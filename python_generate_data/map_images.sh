#!/bin/bash

images=( "/carpten" "/su2c" "/IVY" "/liang" "/ngd-data" "/trent" "/keats" "/MMRF" "/kjensen" "/AshionDrop")
collections=( "carpten" "su2c" "IVY" "liang" "ngddata" "trent" "keats" "MMRF" "kjensen" "AshionDrop"  )
count=0

for i in "${images[@]}"
do
   :
   du -S $i --exclude=$i/.snapshot 2>/dev/null > "${collections[count]}".txt
   df $i > df_"${collections[count]}".txt
   ls -laRp $i > ls_lRp_"${collections[count]}".txt
   if [ "$i" = "/MMRF" ] || [ "$i" = "/ngd-data" ] || [ "$i" = "/kjensen" ] ; then
       python dlim_.py "${collections[count]}".txt df_"${collections[count]}".txt "${collections[count]}" $1 $2 $3 --lim 86000
   else
       python dlim_.py "${collections[count]}".txt df_"${collections[count]}".txt "${collections[count]}" $1 $2 $3
   fi
   node ../findDups.js "${collections[count]}"_lRp
   (( count++ ))
done


