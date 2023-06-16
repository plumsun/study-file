# Linux

## 1.命令



#### 启动命令

```shell
#JAR包启动命令
#找到系统中对应的服务占用，并清除
ps -ef|grep video-stream-srv-0.0.1.jar |grep -v grep|awk '{print $2}'|xargs -i kill -6 {}
#启动jar包
nohup java -jar -Dserver.name=video-stream-srv -Dspring.profiles.active=wxtest video-stream-srv-0.0.1.jar >nohup.out 2>&1 &
#& 代表在后台运行。特定：当前ssh窗口不被锁定，但是当窗口关闭时，程序中止运行。
#nohup 意思是不挂断运行命令,当账户退出或终端关闭时,程序仍然运行
#>console.log 将启动日志输入到对应文件中

#实时查看启动日志
tail -f nohup.out
```

> 2>&1
>
> 表示将标准错误 2 重定向到标准输出 &1 ，标准输出 &1 再被重定向输入到nohup.out文件中。
>
> 0 – stdin (standard input，标准输入),java中表示System.in
> 1 – stdout (standard output，标准输出)，java中表示System.out
> 2 – stderr (standard error，标准错误输出),java中表示System.err







#### 文件命令

```shell
#添加
touch 文件名
#查询
find path expression search-term
#path 路径
#expression 选项。例如：-name 根据文件名
#search-term 检索目标

#删除
rm -rf 文件名
#解压
tar -xrf name.tar

#发送文件到指定ip下
scp live remote@ip:目录

#请求指定链接
#get请求
curl -X GET -H 'GVP-APPID: YWD7H1615809701123' "http://localhost:9909/gvp/mixStream/v1/resumeMixTask?sceneId=1111100"
#post请求
curl -X POST 'http://localhost:8003/video-stream-srv/mai/kickoutUser' -H "Content-type: application/json" -H 'appId: miguLive' -d '{json}'
```

#### 文件夹命令

```shell
#用户添加文件夹权限
chown -R migu:migu /opt
#添加启动权限
chmod 755 springBoot.sh
```

> 第一个数字表示文件所有者的权限
> 第二个数字表示文件所有者同属一个用户组的其他用户在该文件上的权限
> 第三个数字表示其他用户组在该文件夹上的权限。
>
> 权限分为三种：读（r=4），写（w=2），执行（x=1）。结合起来还有：
>
> 可读+可执行（rx=5=4+1）对应数字5，
> 可读+可写（rw=6=4+2）等，对应数字6。
> 可读+可写+可执行（rwx=7=4+2+1）对应数字7.
> 所以，chmod 755设置用户的权限为：
>
> 1.文件所有者的权限   				可读可写可执行 
> 2.与文件所有者同属一个用户组的其他用户  可读可执行 
> 3.其他用户组  					  可读可执行      

#### 日志命令

```shell
#根据关键字查询日志文件的前后10行
grep -C 10 'Exception' xxx.log  xxx为日志文件名称
#实时查询日志文件
tail -n 20 filename
#根据关键字查询指定日志文件
cat name.log|grep 关键字
```



#### 进程命令

```shell
#查询指定进程
ps -ef|grep "进程名"
#清理进程
kill -9 pid
#用于查看指定的端口号的进程情况
netstat -tunlp |grep 端口号
#用于查看某一端口的占用情况
lsof -i:端口号
#显示当前所有java进程pid的命令
jps
#显示当前服务器中java的安装路径
echo $JAVA_HOME 
```



#### 防火墙命令

```shell
# 关闭防火墙
systemctl stop firewalld.service 

# 查看防火墙的状态
systemctl status firewalld.service 

#执行开机禁用防火墙自启命令(永久关闭防火墙)
systemctl disable firewalld.service

#执行开机启动防火墙自启命令(永久启动防火墙)
systemctl enable firewalld.service
```

或

```shell
#查询防火墙状态
firewall-cmd --state

#重新载入配置，比如添加规则之后，需要执行此命令
firewall-cmd --reload                        

#centos7查看防火墙开放的端口信息
firewall-cmd --list-ports

#关闭端口
firewall-cmd --zone=public --remove-port=9200/tcp --permanent

#开启端口
firewall-cmd --zone=public --add-port=9876/tcp --permanent
#说明:
#–zone #作用域
#–add-port=80/tcp #添加端口，格式为：端口/通讯协议
#–permanent 永久生效，没有此参数重启后失效

#查询指定端口是否开启成功
firewall-cmd --query-port=123/tcp
```

### 挂载

```shell
#查询当前服务器的挂载点
df -h
```
