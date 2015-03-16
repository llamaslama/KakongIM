#! /bin/sh    
    
#启动方法 
start(){    
 now=`date "+%Y%m%d%H%M%S"`    
 exec java -Xmn128m -Xms512m -Xmx512m -jar /usr/local/kakongim/kakongim.jar 5 >"$now"_bidcheck.log &    
 #java -Xms128m -Xmx2048m -jar cmpp.jar 5 > log.log &    
 #tail -f result.log    
}    
#停止方法    
stop(){    
 ps -ef|grep java|awk '{print $2}'|while read pid    
 do    
    kill -9 $pid    
 done    
}    
    
case "$1" in    
run)    
start    
;;    
stop)    
stop    
;;      
restart)    
stop    
start    
;;    
*)    
printf 'Usage: %s {start|stop|restart}\n' "$prog"    
exit 1    
;;    
esac
