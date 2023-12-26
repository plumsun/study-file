#!/bin/bash
APP_NAME=msda-cgdecl-server
JAVA_HOME=/u01/jdk1.8.0_161

if [ ! $JAVA_HOME ];then
  JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
else
  JAVA_VERSION=${JAVA_HOME#*jdk}
fi

## Memory Options## 官方推荐3：5  但是ep 4：4比较合适。   关于堆内存分布的比例看具体的业务: 官方的推荐 3 ： 5. 但是需要依据业务进行调整。
MEM_OPTS="-Xms2048m -Xmx2048m -XX:NewRatio=1"

# shellcheck disable=SC2072
if [[ "$JAVA_VERSION" < "1.8" ]]; then
  MEM_OPTS="$MEM_OPTS -XX:PermSize=256m -XX:MaxPermSize=512m"
else
  MEM_OPTS="$MEM_OPTS -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=256m"
fi
# 启动时预申请内存
MEM_OPTS="$MEM_OPTS -XX:+AlwaysPreTouch"
# 线程栈分配大小。
MEM_OPTS="$MEM_OPTS -Xss256k"
# 回收比例。Grafana90报警。预先设置为80回收。并使用CMS. 看业务情况可动态调整。包括上面的堆内存的分配。
GC_OPTS="-XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=80 -XX:+UseCMSInitiatingOccupancyOnly"

#打印GC日志，包括时间戳，晋升老生代失败原因，应用实际停顿时间(含GC及其他原因)
# GCLOG_OPTS="-Xloggc:${GC_LOG_FILE} -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintPromotionFailure -XX:+PrintGCApplicationStoppedTime"

OPTIMIZE_OPTS="-XX:AutoBoxCacheMax=20000"

SHOOTING_OPTS="-XX:-OmitStackTraceInFastThrow -XX:ErrorFile=${LOGDIR}/hs_err_%p.log"

export JAVA_OPTS="$MEM_OPTS $GC_OPTS $OPTIMIZE_OPTS $SHOOTING_OPTS"

_JAR_KEYWORDS=${APP_NAME}".jar"
PID=$(ps aux | grep ${_JAR_KEYWORDS} | grep -v grep | awk '{print $2}' )

check_if_process_is_running(){
 if [ "$PID" = "" ]; then
   return 1
 fi
 ps -p $PID | grep "java"
 return $?
}


case "$1" in
  status)
    if check_if_process_is_running
    then
      echo -e "\033[32m $APP_NAME is running \033[0m"
    else
      echo -e "\033[32m $APP_NAME not running \033[0m"
    fi
    ;;
  stop)
    if ! check_if_process_is_running
    then
      echo  -e "\033[32m $APP_NAME  already stopped \033[0m"
      exit 0
    fi
    kill -9 $PID
    echo -e "\033[32m Waiting for process to stop \033[0m"
    NOT_KILLED=1
    for i in {1..20}; do
      if check_if_process_is_running
      then
        echo -ne "\033[32m . \033[0m"
        sleep 1
      else
        NOT_KILLED=0
      fi
    done
    echo
    if [ $NOT_KILLED = 1 ]
    then
      echo -e "\033[32m Cannot kill process \033[0m"
      exit 1
    fi
    echo  -e "\033[32m $APP_NAME already stopped \033[0m"
    ;;
  start)
    if [ "$PID" != "" ] && check_if_process_is_running
    then
      echo -e "\033[32m $APP_NAME already running \033[0m"
      exit 1
    fi
   nohup $JAVA_HOME/bin/java -jar -server $JAVA_OPTS $_JAR_KEYWORDS > output 2>&1 &
   echo -ne "\033[32m Starting \033[0m"
    for i in {1..20}; do
        echo -ne "\033[32m.\033[0m"
        sleep 1
    done
    if check_if_process_is_running
     then
       echo  -e "\033[32m $APP_NAME fail \033[0m"
    else
       echo  -e "\033[32m $APP_NAME started \033[0m"
    fi
    ;;
  restart)
    $0 stop
    if [ $? = 1 ]
    then
      exit 1
    fi
    $0 start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|status}"
    exit 1
esac

exit 0
