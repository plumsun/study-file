# SpringMVC

```markdown
一个作用于web层的框架
mvc:开发模式
m:model,模型层
v:view视图层
c:controller控制器
```

### 1.配置流程

```markdown
1.创建web工程,引入依赖
2.创建springmvc配置文件,开启注解扫描
3.在web.xml配置前端控制器
    也可以配置post请求过滤器
```





### 2.springmvc初始化流程

```markdown
1.tomcat启动时,前端控制器dispatcherServlet对象创建
2.通过初始化参数信息,找到对应的springmvc配置文件进行解析
3.解析其中的注解扫描,会扫描controller包下所有的controller类,判断是否有@controller注解,有的话会创建bean,并存放到springmvc容器中
```

### 3.springmvc请求响应流程

```markdown
1.浏览器发送请求
2.dispatchServlet会拦截请求,从springmvc中获取请求中携带的路径
3.通过@RequestMapping找到对应的controller下的handler
4.通过handler返回的数据进行视图渲染,做出响应
```





### 4.springmvc三大组件

#### 4.1 handlerMapping:处理器响应器

```markdown
根据请求地址,找到对应的handler
```

#### 4.2 handlerAdapter:处理器适配器

```markdown
前端控制器通过handleradapter调用handler
```

**注意:需要在springmvc配置文件中显示配置处理器适配器和映射器**

**作用:增加其他应用的配置**

```xml
<!--注解驱动-->
<mvc:annotation-driven/>
```

#### 4.3 ViewResolver:视图解析器

```markdown
当开发中使用jsp技术时,将modelAndView进行解析,得到视图的物理地址和数据,做出渲染和响应
```

##### 配置视图解析器

```xml
<bean class="InternalResourceViewResolver">
    <!--前缀-->
    <property name="prefix" value="/"/>
    <!--后缀-->
    <property name="suffix" value=".jsp"/>
</bean>
```







### 5.springmvc执行流程

```markdown
1.前端页面发送请求
2.DispatcherServlet前端控制器接收请求
3.前端控制器调用HandlerMapping(处理器响应器),通过@RequestMapping注解找到对应的controller下的handler(处理请求的方法)
4.响应器返回handlerExecutionChain(处理器执行器链)
	执行器链中包含了handler和拦截器
5.前端控制器调用handlerAdapter(适配器)来执行handler,返回modelAndView
6.前端控制器调用ViewResolver来解析适配器返回的结果,找到对应的资源位置
7.进行视图渲染操作,并给出响应
```



### 6.前端控制器



**起到请求分发的作用,将请求分发到对应handler上**



#### 6.1路径配置

```java
两种配置方式
    1.扩展名匹配
    2.缺省匹配(需要释放静态资源)
```

**释放静态资源**

```xml
<mvc:default-servlet-handler/>
```



#### 6.2控制器配置

**在web.xml文件中配置前端控制器**

```xml
<servlet>
    <servlet-name>DispatcherServlet</servlet-name>
    <servlet-class>DispatcherServlet</servlet-class>
    <!-- 配置springmvc配置文件的位置，用于创建springmvc容器-->
    <init-param>
          <param-name>contextConfigLocation</param-name>
          <param-value>classpath:springmvc.xml</param-value>
     </init-param>
</servlet>
<servlet-mapping>
	<servlet-name>DispatcherServlet</servlet-name>
    <url-pattern>/</url-pattern>
</servlet-mapping>
```



### 7.springmvc路径映射

```css
@RequestMapping("/url")
    value:handler映射的路径
    methods:限定请求的方式
    params:限定请求的参数

    
可以使用在controller上表示父级路径
```



### 8.springmvc参数绑定



> **参数绑定:前端传递参数,后台如何获取**



#### 8.1  默认参数绑定

```css
javaweb中常用的参数,直接声明
    HttpServletRequest request,
	HttpServletResponse response,
	HttpSession session session,
	Model : 数据模型
        model+string=modelAndView
```

**案例**

```java
@RequestMapping("/url")
public String findAll(Model model,HttpServletRequest request,HttpServletResponse response,HttpSession session session){
    
    System.out.println(request);
    System.out.println(response);
    System.out.println(session);
    model.addObject("msg","demo01");
    
    return "jsp文件名";
}
```



#### 8.2  pojo类型

```css
当对应实体类中的属性名和提交参数时的key一致时,直接在方法中声明即可
```

**案例**

```java
@RequestMapping("/url")
public String findAll(Model model,User user){
    
    System.out.println(user);
    model.addObject("msg","demo01");
    
    return "jsp文件名";
}
```

**时间类型参数问题**

```java
   /**
     * @Description 实现时间格式的处理
     */
    @InitBinder
    public void initBinder(WebDataBinder binder){
//        声明时间的格式
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //new CustomDateEditor(simpleDateFormat, true)的true表示是否可以传递空值
        binder.registerCustomEditor(Date.class, new CustomDateEditor(simpleDateFormat, true));
    }
```



#### 8.3  复合类型

```markdown
如果是复合属性绑定参数：那么前端提交参数的key的语法格式：  对象属性.属性名
```



#### 8.4  数组类型

```markdown
直接声明对应参数数组接收
```

**案例**

```java
@RequestMapping("/url")
public String findAll(Model model,String[] id){
    
    System.out.println(Arrays.toString(id));
    model.addObject("msg","demo01");
    
    return "jsp文件名";
}
```



#### 8.5   json类型

```css
声明json数据对应的实体对象,通过@RequestBody将json数据进行解析,封装到对应的实体对象中
```

**案例**

```java
/**
 *
        @RequestBody: 将请求中的json格式直接封装成实体对象。
 */
@RequestMapping("/jsonParam")
public String jsonParam(Model model,@RequestBody Customer customer){

    model.addAttribute("msg","json格式参数绑定:"+customer);
    return "demo";
}
```
##### 注意

```xml
springmvc解析json,需要配置<mvc:annotation-driven>注解驱动,
    并导入jackson依赖
```



#### 8.6     基本数据类型

```css
直接在方法中声明即可
通过@RequestParam获取请求中的参数
    当请求的参数名和变量名一致时,注解省略
```

**案例**

```java
@RequestMapping("/url")
public String findAll(Model model,String id,@RequestParam("请求参数名") String username){
    
    System.out.println(id);
    System.out.println(username);
    model.addObject("msg","demo01");
    
    return "jsp文件名";
}
```





#### 8.7   集合类型

```markdown
1.前端提交多个对象类型的参数，例如提交2个客户信息
2.声明一个包装类，将集合类型作为包装类的属性
3.前端提交参数的格式   集合属性名[index].对象属性名
```

**案例**

**前端页面**

```html
<tr>
            <td><input name="list[0].custName"></td>
            <td><input name="list[0].custSource"></td>
            <td><input name="list[0].custIndustry"></td>
            <td><input name="list[0].custLevel"></td>
            <td><input name="list[0].custAddress"></td>
            <td><input name="list[0].custPhone"></td>
        </tr>
        <tr>
            <td><input name="list[1].custName"></td>
            <td><input name="list[1].custSource"></td>
            <td><input name="list[1].custIndustry"></td>
            <td><input name="list[1].custLevel"></td>
            <td><input name="list[1].custAddress"></td>
            <td><input name="list[1].custPhone"></td>
        </tr>
```

**包装类**

```java
package com.demo.pojo;

import java.util.List;

public class CustomerVo {

    private List<Customer> list;

    public List<Customer> getList() {
        return list;
    }

    public void setList(List<Customer> list) {
        this.list = list;
    }

    @Override
    public String toString() {
        return "CustomerVo{" +
                "list=" + list +
                '}';
    }
}

```

**handler**

```java
 @RequestMapping("/listParam")
    public String listParam(Model model, CustomerVo customerVo){

        model.addAttribute("msg","数组参数绑定:"+ customerVo);
        return "demo";
    }
```



### 9.springmvc返回值

#### 9.1 modelAndView

**modelAndView用于封装视图和数据**

```java


@RequestMapping("/url")
public ModelAndView demo(){
    ModelAndView view = new ModelAndView();
    //设置视图
    view.setViewName("视图名");
    //设置视图需要的数据,向request域中保存数据
    view.addObject("msg","return");
    return view;
}
```



#### 9.2 String(jsp常用)

**handler返回值是String类型,默认是视图名**

```java
//model用于封装数据
public String demo(Model model){
    //向request域中存储视图所需的数据信息
    model.addAttribute("msg","return");
    return "视图名";
}
```

##### String返回值进行重定向和转发

```java
//如果在返回值之前加上redirect: 表示重定向，如果加上forward: 表示转发

@RequestMapping("/demo")
public String demo01(Model model,String type){
    model.addAttribute("msg",type);
    return "demo";//视图名
}

//重定向
@RequestMapping("/redirect")
public String returnRedirect(){
    return "redirect:demo?type=redirect";
}

//转发
@RequestMapping("/forward")
public String returnForward(){
    return "forward:demo?type=forward";
}

```



#### 9.3 json

**需要引入Jackson依赖,并开启注解驱动**



##### 使用@ResponseBody注解

```java
//创建handler，返回值类型直接是java中的实体对象类型。
//handler上添加@ResponseBody


@ResponseBody
@RequestMapping("/demo")
public User demo(){
    User user = new User();
    user.setName("李四");
    user.setSex("男");
    return user;
}
```



##### 使用@RestController注解

```java
package com.demo.controller;

import com.itheima.pojo.User;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/json")
public class Controller_02_json {

    @RequestMapping("/returnJson")
    public User returnJson(){
        User user = new User();
        user.setAge(18);
        user.setUsername("zhangsan");
        user.setSex("male");
        return user;
    }


    @RequestMapping("/returnJson2")
    public List<User> returnJson2(){
        User user = new User();
        user.setAge(18);
        user.setUsername("zhangsan");
        user.setSex("male");

        User user2 = new User();
        user2.setAge(12);
        user2.setUsername("zhangsan2");
        user2.setSex("male2");

        List<User> userList = new ArrayList<>();
        userList.add(user);
        userList.add(user2);

        return userList;
    }
}

```

> **如果一个controller中的所有handler是json返回值，直接使用@RestController来替代原有的@Controller**



#### 9.4 void

**有响应体**

```java
//声明response类型参数,使用原生javaweb技术做出响应
@RequestMapping("/demo")
public void demo(HttpServletResponse response){
    
    
        try {
            response.getWriter().write("success");
        } catch (IOException e) {
            e.printStackTrace();
        }
}
```

**无响应体**

```java
//handler若是没有任何响应体会报错,需要告诉浏览器响应状态信息

@ResponseStatus(HttpStatus.OK)//没有任何响应体
@RequestMapping("/demo")
public void demo(){
    System.out.println("没有响应体");
}
```

### 10.springmvc的Restful风格

```css
restful风格：一种url设计的风格，请求的地址一样，但是请求的含义不一样，通过请求的方式来区分请求的含义。
```

### 11.springmvc文件上传

#### 11.1 文件上传3要素

```markdown
1.使用文件上传组价<input type="file">
2.文件上传的数据格式为 multipart/form-data
3.必须是post请求,get请求会限制提交内容的大小
```

#### 11.2 文件解析器

**需要引入file-upload依赖**

```xml
<bean class="CommonsMulipartMulipartResolver">
    <property name="maxUploadSize" value="文件上传最大值"/>
    <property name="defaultEncoding" value="文件名编码格式"/>
</bean>
```

#### 11.3 相关API

```properties
MultipartFile:
	getOriginalFilename():获取上传文件名
    transferTo():保存文件
```



### 12.springmvc异常处理



```markdown
springmvc中，dispatcherServlet去调用handler，handler调用service和dao，如果controller，service，dao中出现的异常全部不做处理，往上抛，最终都由dispatcherServlet来进行统一处理。
```

#### xml方式的异常统一处理

```markdown
流程:
    1.自定义业务异常 ----->实现exception接口
    2.编写controller,手动抛出业务异常
    3.自定义异常处理类  -------->实现HandlerExceptionResolver接口
    4.创建异常处理器对象 --> <bean>
```

#### 注解

```css
1.创建controller,创建一个用于处理异常的handler,添加注解@ExceptionHandler,表示当前handler用于处理当前controller中得到异常
2.若是其他controller需要这样的handler处理异常,继承controller即可
    
@ControllerAdvice:将当前类中的方法增强到所有controller中
```



### 13.拦截器

```markdown
作用:
	1.过滤请求
	2.对请求访问handler之前进行预处理
```

#### 拦截器配置

```java
//实现HandlerInterceptor表示当前是一个拦截器类

package com.demo.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyInterceptor1 implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("在handler之前执行11111111111111111111");
        return true;//放行
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        System.out.println("handler之后执行，但是在视图渲染之前执行1111111111");
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        System.out.println("视图渲染之后执行333333333333333333");
    }


}

```

```xml
<!-- 配置拦截器-->
<mvc:interceptors>
     <!-- 配置单个拦截器-->
     <mvc:interceptor>
         <!-- 配置拦截路径，*通配所有-->
         <mvc:mapping path="/interceptor/*"/>
         <!-- 拦截器对象-->
         <bean class="com.itheima.interceptor.MyInterceptor1">
         </bean>
     </mvc:interceptor>
</mvc:interceptors>
```



