from pymongo import MongoClient
from optparse import OptionParser
import os
import sys
import re

universe = []
dataMap = {}
root = ''
docNum = None

#put in mongo
def doMongo(tree):
    client = MongoClient(sys.argv[5], sys.argv[6])
    db = client[sys.argv[7]]
    collection = db[sys.argv[4]]
    collection.remove({})
    collection.insert(tree)

#creates universe of dictionaries from du input
def formatItems(du):
    for item in du:
        fLineArr = item.split('\t')
        size = int(fLineArr[0])*1000
        path = fLineArr[1].strip('\n');
        parent = path.rsplit('/',1)[0]
        # the root is contingent upon initial depth
        # if /liang for example, length should be 2
        # if /home/gfrantzen, length should be 3
        if ( len( path.split('/') ) == int(sys.argv[1])+1 ):
            if path!='':
                global root
                root=path
            universe.append( {'name':path, 'size':size, 'parent':None} )
        else:
            universe.append( {'name':path, 'size':size, 'parent':parent } )


def trimP(dn):
    print("pre trim length is: ")
    print(len(universe))
    print(dn)
    firstTake = len(universe)
    remCount = 0
    bytes = 64000
    while(len(universe)>dn):
        for i in universe:
            print(len(universe))
            foundIt = False
            if i['parent'] is not None:
                for j in universe:
                    if i['name']==j['parent']:
                        foundIt=True
                        break
                if not foundIt:
                    if i['size']<bytes:
                        universe.remove(i)
                        print(i)
                        remCount+=1
        print(remCount)
        bytes = bytes + 128000


#convert flat dict into tree
def nest(dn):
    empty = {}
    if dn:
        trimP(dn)
    for atom in universe:
        dataMap[ atom['name'] ] = atom
        if atom['name']=="empty":
            empty = atom
            universe.remove(atom)
    tree = []
    for atom in universe:
        parent = None
        if atom['parent']!=None and atom['parent']!='':
            parent = dataMap[ atom['parent'] ]
        if(parent):
            atom.pop('parent',None)
            if( 'children' in parent):
                parent['children'].append(atom)
            else:
                parent['children'] = []
                parent['children'].append({'name':parent['name'], 'size':parent['size']})
                parent.pop('size',None)
                parent['children'].append(atom)
        else:
            atom.pop('parent',None)
            atom['children'].append(empty)
            tree.append(atom)
    r = []
    for k,v in dataMap.iteritems():
        if "size" not in str(v):
            r.append(k)
    for rem in r:
        dataMap.pop(rem,None)
    return tree


def doDf(df,root):
    numintegers = [x for x in df if x.isdigit()]
    empty = numintegers[-1]
    universe.append({'name':'empty', 'size':int(empty)*1000, 'parent':root})


def main():
    du = open(sys.argv[2]).readlines()
    df = open(sys.argv[3]).read().split()
    formatItems(du)
    doDf(df,root)
    print(len(universe))
    if(docNum):
        tree = nest(docNum)
    else:
        tree = nest(None)
    doMongo(tree)

if __name__ == '__main__':
    parser = OptionParser()
    parser = OptionParser(usage="usage: %prog [required:initial_depth (e.g. /home == 1)] [required:your_du.txt] [required:your_df.txt]  [required:output_collection]  [optional:options/flags]",
                          version="%prog 1.01")
    parser.add_option("--lim", type="int", dest="docNum", help="Specify a maximum number of documents. Program will attempt to remove least significant values. If this option is null, all du.txt lines will be processed.")
    (options, args) = parser.parse_args()
    docNum = options.docNum
    if(len(sys.argv)<5):
        print("use -h or --help to see usage!")
    else: 
        main()
