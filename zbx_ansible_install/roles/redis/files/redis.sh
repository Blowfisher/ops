#!/bin/bash
#
#此脚本仅支持单redis端口监控

REDISCLI="sudo /usr/local/redis-3.0.6/bin/redis-cli -a redis_jk2017"
HOST={{ ansible_default_ipv4.address }}
Flag=`date +%s -d '2018-07-06 12:00:00'`
Now=`date +%s`
Last_hit=
Last_miss=

let remainder=($Now - $Flag)%1


#auto_discover(){
#  port=`netstat -tnlp|grep redis|awk '{print $4}'|awk -F: '{print $2}'|grep -v ^$|awk '{if($1 <10000)print $1}'`
#  count=`for i in "$port";do echo $i;done|wc -l`
#  index=0
#
#  echo '{"data":['
#  for i in $port;do
#    echo -n {'"{#RPORT}"':"$i"}
#    index=`expr $index + 1`
#    if [ "$index" -lt "$count" ];then
#      echo ','
#      fi
#  done
#  echo ']}'
#}
#
#if [ $# -eq 0 ];then
#  auto_discover
#  exit
#fi

port=`sudo netstat -tnlp|grep redis|awk '{print $4}'|awk -F: '{print $2}'|grep -v ^$|awk '{if($1 <10000)print $1}'`

function redis_info(){
    $REDISCLI -h $HOST -p $port info | grep -w $2 | awk -F: '{print $2}'
}

function redis_cluster(){
    $REDISCLI -h $HOST -p $port cluster info | grep -w $2 | awk -F: '{print $2}'
}


echo $1 |grep -o cluster 2&>/dev/null
result=$?

if [ $1 == "hits" ];then
    hits=`$REDISCLI -h $HOST -p $port info | grep -w keyspace_hits | awk -F: '{printf "%d",$2}'` 
    miss=`$REDISCLI -h $HOST -p $port info | grep -w keyspace_misses | awk -F: '{printf "%d",$2}'`
    let Hit_temp="${hits}"-"$Last_hit"
    let temp="${hits}"-"$Last_hit"+"${miss}"-"$Last_miss"
   # let Hiter="$Hit_temp"/"$temp"\*100
    Hiter=`awk 'BEGIN{printf "%.3f",('$Hit_temp'/'$temp'*100)}'`
    echo $Hiter

elif [ "$1"=="cluster_enabled" ];then
   redis_info $port $1
elif [ $result -ne 0 ];then
   redis_info $port $1
else
   redis_cluster $port $1
fi

