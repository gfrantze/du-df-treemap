#!/bin/bash

du -S /carpten --exclude=/carpten/.snapshot 2>/dev/null > carpten.txt
du -S /su2c --exclude=/su2c/.snapshot 2>/dev/null > su2c.txt
du -S /IVY --exclude=/IVY/.snapshot 2>/dev/null > IVY.txt
du -S /liang --exclude=/liang/.snapshot 2>/dev/null > liang.txt
du -S /ngd-data --exclude=/ngd-data/.snapshot 2>/dev/null > ngddata.txt
du -S /trent --exclude=/trent/.snapshot 2>/dev/null > trent.txt
du -S /keats --exclude/keats/.snapshot 2>/dev/null > keats.txt
du -S /MMRF --exclude/MMRF/.snapshot 2>/dev/null > MMRF.txt

df /keats > df_keats.txt
df /MMRF > df_MMRF.txt
df /trent > df_trent.txt
df /carpten > df_carpten.txt
df /su2c > df_su2c.txt
df /IVY > df_IVY.txt
df /ngd-data > df_ngddata.txt
df /liang > df_liang.txt

ls -laRp /trent > ls_lRp_trent.txt
ls -laRp /MMRF > ls_lRp_MMRF.txt
ls -laRp /keats > ls_lRp_keats.txt
ls -laRp /liang  > ls_lRp_liang.txt
ls -laRp /IVY  > ls_lRp_IVY.txt
ls -laRp /su2c  > ls_lRp_su2c.txt
ls -laRp /ngd-data  > ls_lRp_ngddata.txt
ls -laRp /carpten > ls_lRp_carpten.txt

python dlim_.py keats.txt df_keats.txt keats $1 $2 $3
python dlim_.py trent.txt df_trent.txt trent $1 $2 $3
python dlim_.py MMRF.txt df_MMRF.txt MMRF $1 $2 $3 --lim 89000
python dlim_.py carpten.txt df_carpten.txt carpten $1 $2 $3 
python dlim_.py liang.txt df_liang.txt liang $1 $2 $3 
python dlim_.py su2c.txt df_su2c.txt su2c $1 $2 $3 
python dlim_.py ngddata.txt df_ngddata.txt ngddata $1 $2 $3 --lim 89000
python dlim_.py IVY.txt df_IVY.txt IVY $1 $2 $3 

python parse_lRp.py ls_lRp_trent.txt trent_lRp $1 $2 $3
python parse_lRp.py ls_lRp_keats.txt keats_lRp $1 $2 $3
python parse_lRp.py ls_lRp_MMRF.txt MMRF_lRp $1 $2 $3
python parse_lRp.py ls_lRp_liang.txt liang_lRp $1 $2 $3 
python parse_lRp.py ls_lRp_IVY.txt IVY_lRp $1 $2 $3 
python parse_lRp.py ls_lRp_su2c.txt su2c_lRp $1 $2 $3 
python parse_lRp.py ls_lRp_ngddata.txt ngddata_lRp $1 $2 $3 
python parse_lRp.py ls_lRp_carpten.txt carpten_lRp $1 $2 $3 
