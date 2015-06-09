#!/bin/bash

images=( "/carpten" "/su2c" "/IVY" "/liang" "/ngd-data" "/trent" "/keats" "/MMRF" "/kjensen" "/AshionDrop")
collections=( "carpten" "su2c" "IVY" "liang" "ngddata" "trent" "keats" "MMRF" "kjensen" "AshionDrop"  )
count=0

for i in "${images[@]}"
do
   :
   echo "du -S $i --exclude=$i/.snapshot 2>/dev/null > "${collections[count]}".txt"
   echo "df $i > df_"${collections[count]}".txt"
   echo "ls -laRp $i > ls_lRp_"${collections[count]}".txt"
   if [ "$i" = "/MMRF" ] || [ "$i" = "/ngd-data" ] || [ "$i" = "/kjensen" ] ; then
       echo "python dlim_.py "${collections[count]}".txt df_"${collections[count]}".txt "${collections[count]}" $1 $2 $3 --lim 89000"
   else
       echo "python dlim_.py "${collections[count]}".txt df_"${collections[count]}".txt "${collections[count]}" $1 $2 $3"
   fi
   echo "node ../findDups.js "${collections[count]}""
   (( count++ ))
done


