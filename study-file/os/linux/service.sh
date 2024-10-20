#!/bin/bash

# 应用名称和路径配置
APP_NAME="my-app"
_JAR_KEYWORDS="$APP_NAME.jar"
LOG_DIR="$APP_HOME/logs"
LOG_FILE="$LOG_DIR/$APP_NAME.log"

# 创建日志目录
mkdir -p $LOG_DIR

# JVM 内存配置
JAVA_OPTS="
-Xms4g                    # 初始化堆大小
-Xmx8g                    # 最大堆大小
-Xmn2g                    # 新生代内存大小
-XX:MetaspaceSize=256m     # 元空间大小
-XX:MaxMetaspaceSize=512m  # 元空间最大大小
"

# 垃圾回收器配置（使用 G1 垃圾回收器）
JAVA_OPTS="$JAVA_OPTS
-XX:+UseG1GC                             # 启用 G1 垃圾回收器
-XX:MaxGCPauseMillis=200                 # 最大 GC 暂停时间为 200 毫秒
-XX:+ParallelRefProcEnabled              # 并行引用处理
-XX:InitiatingHeapOccupancyPercent=45    # 堆内存使用到 45% 时触发 GC
-XX:+HeapDumpOnOutOfMemoryError          # OOM 时生成堆转储
-XX:HeapDumpPath=$LOG_DIR/heapdump.hprof # 指定 OOM 堆转储的路径
"

# GC 日志配置
JAVA_OPTS="$JAVA_OPTS
-Xlog:gc*:file=$LOG_DIR/gc.log:time,tags  # 输出 GC 日志，带时间戳
"

# 性能优化参数
JAVA_OPTS="$JAVA_OPTS
-XX:+AlwaysPreTouch                      # 预先分配内存页，避免在运行时分配内存时产生延迟
-XX:+DisableExplicitGC                   # 禁用显式调用 System.gc()
-XX:+UseStringDeduplication              # 启用字符串去重
-XX:+OptimizeStringConcat                # 优化字符串拼接操作
"

# 诊断参数
JAVA_OPTS="$JAVA_OPTS
-XX:+PrintGCDetails                      # 打印 GC 详情
-XX:+PrintGCTimeStamps                   # 打印 GC 时间戳
-XX:+PrintGCDateStamps                   # 打印 GC 日期戳
-XX:+PrintHeapAtGC                       # 每次 GC 后打印堆信息
-XX:+PrintTenuringDistribution           # 打印新生代晋升情况
-XX:+PrintClassHistogram                 # 打印类的内存分布
"

# 系统属性配置
JAVA_OPTS="$JAVA_OPTS
-Dspring.profiles.active=prod            # Spring 启动配置，使用生产环境 profile
-Dfile.encoding=UTF-8                    # 设置文件编码为 UTF-8
"

# 获取进程 PID
get_pid() {
    echo $(pgrep -f "${_JAR_KEYWORDS}")
}

# 检查进程是否在运行
check_if_process_is_running() {
    local pid=$(get_pid)
    if [ -z "$pid" ]; then
        return 1
    fi
    ps -p "$pid" -o comm= | grep -q "java"
    return $?
}

# 状态
status() {
    if check_if_process_is_running; then
        echo -e "\033[32m ${APP_NAME} is running \033[0m"
    else
        echo -e "\033[31m ${APP_NAME} not running \033[0m"
    fi
}

# 停止
stop() {
    local pid=$(get_pid)
    if [ -z "$pid" ]; then
        echo -e "\033[32m ${APP_NAME} already stopped \033[0m"
        exit 0
    fi

    kill -9 "$pid"
    echo -e "\033[32m Waiting for process to stop \033[0m"

    for i in {1..20}; do
        if ! check_if_process_is_running; then
            echo -e "\033[32m ${APP_NAME} stopped \033[0m"
            return 0
        fi
        echo -ne "\033[32m . \033[0m"
        sleep 1
    done

    echo -e "\n\033[31m Cannot kill process \033[0m"
    exit 1
}

# 启动
start() {
    if check_if_process_is_running; then
        echo -e "\033[32m ${APP_NAME} already running \033[0m"
        exit 1
    fi

    # 启动应用
    nohup java -server -jar $JAVA_OPTS $_JAR_KEYWORDS >>$LOG_FILE 2>&1 &
    echo -ne "\033[32m Starting \033[0m"

    for i in {1..20}; do
        if check_if_process_is_running; then
            echo -e "\n\033[32m ${APP_NAME} start success \033[0m"
            return 0
        fi
        echo -ne "\033[32m . \033[0m"
        sleep 1
    done

    echo -e "\n\033[31m ${APP_NAME} failed to start \033[0m"
    exit 1
}

# 重启
restart() {
    stop
    if [ $? -eq 0 ]; then
        start
    else
        exit 1
    fi
}

# 主程序
case "$1" in
status)
    status
    ;;
stop)
    stop
    ;;
start)
    start
    ;;
restart)
    restart
    ;;
*)
    echo "Usage: $0 {start|stop|restart|status}"
    exit 1
    ;;
esac

exit 0
