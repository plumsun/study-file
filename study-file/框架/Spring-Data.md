# Spring-Data

**常用注解**

更新数据时自动添加时间信息

```java
@LastModifiedDate//修改时插入时间
@CreatedDate//添加时插入时间
```

> 上述注解失效原因：未在当前类上引入@EntityListeners(AuditingEntityListener.class)注解，导致spring未监听到实体类发生变化。

更新数据时自动添加用户信息

```java
@Audited//开启审计功能
@LastModifiedBy//修改时插入操作人
@CreatedBy//添加时插入操作人




@Component
public class SpringSecurityAuditorAware implements AuditorAware<String> {
 
    @Override
    public String getCurrentAuditor() {
        /*
        	返回会话中或者指定的用户名
        	自己去处理获取用户名.
        	会通过反射在更新数据时，对属性自动赋值
        */
        return SecurityUtils.getCurrentUsername();
    }
 
}
```

