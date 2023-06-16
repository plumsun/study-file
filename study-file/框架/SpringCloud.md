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







### 7.openfeign使用

feign的配置信息除了一些组件配置外（协议切换，熔断开启，数据压缩...），其余的配置都是分为全局和单量的。主要通过指定的config为准，当指定default时为全局。若是指定clientname，则当前配置只针对对应的client配置有效。

配置信息：

```yml
#openfeign配置
feign:
  circuitbreaker:
    enabled: true
  # feign启用hystrix，才能熔断、降级
  hystrix:
    enabled: true
  # 切换okhttp
  okhttp:
    enabled: true
  # 数据压缩
  compression:
    request:
      enabled: true
      min-request-size: 2048
      mime-types: text/xml,application/xml,application/json
    response:
      enabled: true
  client:
    config:
      default:
        # 建议生产不要打开
        loggerLevel: BASIC
        ConnectTimeOut: 5000
        ReadTimeOut: 10000
      #调用system微服务，默认时间设置为30s
#      systemClient:
#        ConnectTimeOut: 30000
#        ReadTimeOut: 30000
```

> `feign.client.config.default`: 全局配置
>
> `feign.client.config.clinetname`: 单个client配置



引入OKhttp

openfeign默认http协议用httpclient，如果要采用okhttp时，需要引入对应依赖，并修改配置文件。

```yml
feign:
  # 切换okhttp
  okhttp:
    enabled: true
```



拦截器（RequestInterceptor）

```java
public interface RequestInterceptor {

  /**
   * Called for every request. Add data using methods on the supplied {@link RequestTemplate}.
   */
  void apply(RequestTemplate template);
}
```

使用拦截器在feign调用接口时自动添加权限认证头信息。

```java
//两种方式实现feign拦截器
//1.实现Interceptor，这种会自动注入到springbean容器中。
@Configuration
public class IRequestInterceptor implements RequestInterceptor {
 
    @Override
    public void apply(RequestTemplate template) {
        /**
        RequestTemplate包含了feign经过动态代理后的请求信息。（URL，method，header,serverName）
        */
        //添加请求头
        template.header(hearder);
    }
}

//2.手动注入springbean容器
@Slf4j
public class FeignConfig {

    @Bean
    public RequestInterceptor requestInterceptor() {
        return template -> {
            AppContext context = AppContext.getContext();
            if (ObjectUtil.hasEmpty(context.getToken(), context.getValue())) {
                log.error("feign请求头信息获取失败,当前请求位置:{}", template.url());
                return;
            }
            //添加请求头
            template.header(context.getToken(), context.getValue());
        };
    }
}
```



自定义日志

feign的日志等级为：

- `NONE`（默认）：不记录任何日志;
- `BASIC`：仅记录请求方法、URL、响应状态代码以及执行时间;
- `HEADERS`：在BASIC级别的基础上，记录请求和响应的header;
- `FULL`：记录请求元数据，响应元数据（请求信息，请求体信息，请求体长度，请求头，响应时间，响应体等）。

feign的日志开启有两种：

1.通过配置信息

```yml
feign:
  client:
    config:
      default:
        loggerLevel: BASIC
```

2.通过配置类

```java
@Slf4j
public class FeignConfig {

    @Bean
    Logger.Level logger(){
        return Logger.Level.FULL; 
    }
}
```

feign的所有日志均为`debug`级别，可能有些日志采集框架会忽略这种日志，导致feign调用信息在链路追踪时不显示。

需要自定义feign日志打印格式，使用`slf4j`框架的日志格式。

```java
@Slf4j
public class FeignConfig {
    
    //注入spring
    @Bean
    FeignLoggerFactory infoFeignLoggerFactory() {
        return new InfoFeignLoggerFactory();
    }
}
/**
    自定义日志工厂，注入spring时采用工厂注入
*/
class InfoFeignLoggerFactory implements FeignLoggerFactory {

    @Override
    public feign.Logger create(Class<?> type) {
        //实际创建日志对象是自定义的日志对象
        return new InfoFeignLogger();
    }
}
/**
	自定义日志对象，需要继承feign的日志对象
*/
@Slf4j
class InfoFeignLogger extends feign.Logger {

    /**
    	重新日志打印方法
    */
    
    //feign请求日志
    @Override
    protected void logRequest(String configKey, Level logLevel, Request request) {
        log.info("---RPC调用开始......");
        log.info("{}---> Feign Request Msg: {},{} HTTP/1.1", configKey, request.httpMethod().name(), request.url());
        if (request.requestBody().asBytes() != null) {
            String bodyText = request.requestBody().asString();
            log.info("{}---> Feign Request Body: {}", configKey, bodyText);
        }

    }

	//feign响应日志
    @Override
    protected Response logAndRebufferResponse(String configKey, Level logLevel, Response response, long elapsedTime) throws IOException {
        String reason =
                response.reason() != null && logLevel.compareTo(Level.NONE) > 0 ? " " + response.reason()
                        : "";
        int status = response.status();
        log.info("{}<--- Feign Response Msg: {}({}), Time: ({}ms)", configKey, status, reason, elapsedTime);
        if (response.body() != null && !(status == 204 || status == 205)) {
            // HTTP 204 No Content "...response MUST NOT include a message-body"
            // HTTP 205 Reset Content "...response MUST NOT include an entity"
            byte[] bodyData = Util.toByteArray(response.body().asInputStream());
            if (bodyData.length > 0) {
                log.info("{}<--- Feign Response Body: {}", configKey, decodeOrDefault(bodyData, UTF_8, "Binary data"));
            }
            return response.toBuilder().body(bodyData).build();
        }
        return response;
    }
    //feign 原生日志打印方法，不要重写，原生的格式个人感觉不怎么样。
    @Override
    protected void log(String configKey, String format, Object... args) {
        // TODO 使用slf4j打印feign
    }
}
```



> feign的配置创建完毕后，如果没有采用`@Configuration`这种格式，那一定要在`@FeignClient(configuration = FeignConfig.class)`指定配置类，否则不会生效。
