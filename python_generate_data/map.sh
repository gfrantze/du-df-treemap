#!/bin/bash

images=("/carpten" "/su2c" "/IVY" "/liang" "/ngd-data" "/trent" "/keats" "/MMRF" "/kjensen" "/AshionDrop")
collections=("carpten" "su2c" "IVY" "liang" "ngddata" "trent" "keats" "MMRF" "kjensen" "AshionDrop"  )
count=0

for i in "${images[@]}"
do
   :
   node findDups.js "${collections[count]}"
   (( count++ ))
done


