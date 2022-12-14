# SpringCloud

### 1.什么是Restful?

```
Restful是一种架构设计风格，提供了设计原则和约束条件，提供给了设计原则和约束条件，而满足这些约束条件和原则的应用程序或设计就是restful架构或服务
后端将资源发布为URI，前端通过URI访问资源，并通过http动词表示对不同资源进行的操作
特点：
1.面向资源：
2.统一接口：
	通过http请求方法完成对数据的crud工作
3.url：
	每个资源至少有一个对应的url
4.无状态：
	所有的资源都可以通过URI定位，而且这个定位与其他资源无关
```

### 2.ROA,SOA,REST,RPC

```java
SOA:
	1.面向服务架构
	2.是一种设计模式，主要应用于不同组件之间通过某种协议交互操作
	3.soa不依赖与任何技术，soap，rpc，rest是对soa的不同实现
SOAP:
	1.简单对象访问协议，是一种轻量的，简单的，基于xml的协议
	2.可在任何传输协议（诸如TCP,HTTP,SMTP，甚至是MSMQ）上使用
	3.其中，SOAP广泛使用的是基于HTTP和xml协议的实现（SOAP=RPC+HTTP+XML）,家常提的WebService使用的通信协议
Rest:
	1.表征状态转移，采用Web服务使用标准的http方法（GET/PUT/POST/DELETE）将所有web系统的服务抽象资源
	2.目前较为流行的一种组件通信方式，在微服务中有较多使用
	3.REST不是一种协议，它是一种架构，一种webService能够如果满足rest的几个条件，通常就称这个系统是restful的
RPC:
	1.远程方法调用，就是像调用本地方法一样调用远程方法
	2.dubbo就是一种rpc框架，它的通信协议rpc协议
	3.4中典型rpc远程调用框架:RMI,Hessian,thrift,dubbo
	4.springcloud也是一种rpc框架，区别是它使用的是http协议（区分应用层协议和传输协议）的传输
```

### 3.微服务和SOA的区别

```java
1.微服务是soa架构演进的结果
2.两者都是对外提供接口的一种架构设计方式，微服务是soa发展出来的产物，是一种比较现代化的细粒度的soa实现方式
- 微服务相比于SOA更加精细，微服务更多的以独立的进程的方式存在，互相之间并无影响
- 微服务提供的接口方式更加通用化，例如HTTP RESTful方式，各种终端都可以调用，无关语言、平台限制
- 微服务更倾向于分布式去中心化的部署方式，在互联网业务场景下更适合
```

### 4.rpc和rest的区别

```markdown
1.rest基于http作为应用协议
2.rpc是基于tcp和http协议的，是把http作为一种传输协议，本身还会封装一层rpc框架的应用层协议，不同语言之间调用需要rpc协议，典型代表就是dubbo
```

### 5.Rest和SOAP协议的区别

```java
1.rest是基于http协议
2.soap基于任何传输协议：诸如tcp，http，SMTP，甚至是msmq等
3.soap是一种rpc框架，http是承载协议，本身是一种应用协议，实现了调用远程就像调用本地接口一样
4.rest是一种架构风格，客户端需要通过url去调用服务端，http本身即是承载协议，也是应用协议
5.soap适合企业应用，rest更适合高并发场景，soap的 业务状态大多是在维护在服务端的，而rest是无状态的操作，维护的是资源状态，将会话状态交由客户端维护
```

### 6.spring项目配置信息优先级

```markdown
1.spring项目中配置信息格式：
a.properties文件
	eg:spring.appilcation.name=test
b.yml文件
	eg:spring:
		application:
			name: test
yml格式的文件要比prop格式的文件优先级高，当两个文件中配置了相同配置名的数据时，会优先读取yml格式的配置。
2.特殊命名规则的配置文件
bootstrap>application>其他（优先级从大到小）
3.当项目中引入了配置中心时，会优先加载配置文件中的数据，再去加载配置中心的数据，最后才会读取@value注解配置的默认数据；
总得来说就是：配置文件>config(apollo,nacos)>@Value.
```

