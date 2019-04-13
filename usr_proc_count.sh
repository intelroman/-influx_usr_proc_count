#!/bin/bash 

influx_ip=""
influx_user=""
influx_pass=""
influx_db=""


data=`ps  axo user:30 | sed -e "1d" | sort | uniq -c | awk '{print $2"=" $1}' | tr '\n' ','| sed -e 's/\+//g'`
host=`hostname`
t=($(date +%s%N))
feed="proc_count,host=$host $data $t"
eval curl -u $influx_user:$influx_pass -i -XPOST 'http://$influx_ip:8086/write?db=$influx_db' --data-binary \' $feed \'

