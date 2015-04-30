from pymongo import MongoClient
import sys

f_ = open(sys.argv[1]).readlines()
client = MongoClient(sys.argv[3], int(sys.argv[4])  )
db = client[sys.argv[5]]

collection = db[sys.argv[2]]
collection.remove({})
print(collection)

path = ""

for item in f_:
    template = {"path":"","filename":"","size":0}
    if item[0]=='/':
        path=item.split()[0]
    elif item.split() and item.split()[0]!="total" and item.split()[0]!=" ":
        template['filename']=item.split()[8]
        template['size']=int(item.split()[4])
        template['path']=path
        collection.insert(template)
        print(template)
    

