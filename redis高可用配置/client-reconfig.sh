#!/bin/sh 

monitor_name="$1"   ##monitor master-group-name
master_old_ip="$4"
master_old_port="$5"
master_new_ip="$6"
master_new_port="$7"
twemproxy_name=$(echo $monitor_name |awk -F'_' '{print $1"_"$2}')   


twemproxy_bin="/usr/local/sbin/nutcracker"
twemproxy_conf="/etc/twemproxy/${twemproxy_name}.yml"
twemproxy_pid="/var/run/${twemproxy_name}.pid"
twemproxy_log="/var/log/redis-server/${twemproxy_name}.log"
twemproxy_cmd="${twemproxy_bin} -c ${twemproxy_conf} -p ${twemproxy_pid} -o ${twemproxy_log} -v 11 -d"


sed -i "s/${master_old_ip}:${master_old_port}/${master_new_ip}:${master_new_port}/" ${twemproxy_conf}


ps -ef |grep "${twemproxy_cmd}" |grep -v grep |awk '{print $2}'|xargs kill
${twemproxy_cmd}

sleep 1
ps -ef |grep "${twemproxy_cmd}" |grep -v grep
