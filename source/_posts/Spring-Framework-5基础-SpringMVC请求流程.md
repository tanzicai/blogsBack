---
layout: pages
title: Spring Framework 5基础-SpringMVC请求流程
date: 2023-01-31 19:21:20
tags:
---

> 前文我们介绍了Spring框架和Spring框架中最为重要的两个技术点（**IOC**和**AOP**），那我们如何更好的构建上层的应用呢（比如web 应用），这便是**SpringMVC**；Spring MVC是**Spring**在**Spring** **Container** **Core**和**AOP**等技术基础上，遵循上述Web MVC的**规范**推出的web开发框架，目的是为了简化Java栈的**web**开发。 本文主要介绍SpringMVC主要的流程和基础案例的编写和运行。

## 导言

> 前文我们介绍了Spring框架和Spring框架中最为重要的两个技术点（IOC和AOP），同时我们也通过几个Demo应用了**Core** **Container**中包，那么问题是，我们如何更好的构建上层的应用呢？比如web 应用？

![Spring框架](https://pdai.tech/images/spring/springframework/spring-springframework-mvc-1.png)

针对上层的Web应用，**SpringMVC**诞生了，它也是Spring技术栈中最为重要的一个框架。

>  **如下几个问题帮你深入浅出的构建对SpringMVC的认知**。

- Java技术栈的**Web**应用是如何发展的？
- 什么是**MVC**，什么是**SpringMVC**？
- **SpringMVC**主要的请求流程是什么样的？
- **SpringMVC**中还有哪些组件？
- 如何编写一个简单的**SpringMVC**程序呢？

## 什么是MVC

> MVC英文是Model View Controller，是模型(model)－视图(view)－控制器(controller)的缩写，一种软件设计规范。本质上也是一种解耦。

用一种业务逻辑、数据、界面显示分离的方法，将业务逻辑聚集到一个部件里面，在改进和个性化定制界面及用户交互的同时，不需要重新编写业务逻辑。MVC被独特的发展起来用于映射传统的输入、处理和输出功能在一个逻辑的图形化用户界面的结构中。

![MVC](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/img/202301311930898.png)

+ **Model**（模型）是应用程序中用于**处理应用程序数据逻辑**的部分。通常模型对象负责在数据库中存取数据。

+ **View**（视图）是应用程序中处理**数据显示**的部分。通常视图是依据模型数据创建的。

+ **Controller**（控制器）是应用程序中**处理用户交互**的部分。通常控制器负责从视图读取数据，控制用户输入，并向模型发送数据。

## 什么是Spring MVC

> 简单而言，Spring MVC是Spring在Spring Container Core和AOP等技术基础上，遵循上述Web MVC的规范推出的web开发框架，目的是为了简化Java栈的web开发。

>  Spring Web MVC 是一种基于Java 的实现了Web MVC 设计模式的请求驱动类型的轻量级Web框架，即使用了MVC 架构模式的思想，将 web 层进行职责解耦，基于请求驱动指的就是使用**请求-响应**模型，框架的目的就是帮助我们简化开发，Spring Web MVC 也是要简化我们日常Web 开发的。@kaitao

**相关特性如下**：

- 让我们能非常简单的设计出干净的Web 层和薄薄的Web 层；
- 进行更简洁的Web 层的开发；
- 天生与Spring 框架集成（如IoC 容器、AOP 等）；
- 提供强大的约定大于配置的契约式编程支持；
- 能简单的进行Web 层的单元测试；
- 支持灵活的URL 到页面控制器的映射；
- 非常容易与其他视图技术集成，如 Velocity、FreeMarker 等等，因为模型数据不放在特定的 API 里，而是放在一个 Model 里（Map 数据结构实现，因此很容易被其他框架使用）；
- 非常灵活的数据验证、格式化和数据绑定机制，能使用任何对象进行数据绑定，不必实现特定框架的API；
- 提供一套强大的JSP 标签库，简化JSP 开发；
- 支持灵活的本地化、主题等解析；
- 更加简单的异常处理；
- 对静态资源的支持；
- 支持Restful 风格。

## Spring MVC的请求流程

> Spring Web MVC 框架也是一个基于请求驱动的Web 框架，并且也使用了前端控制器模式来进行设计，再根据请求映射 规则分发给相应的页面控制器（动作/处理器）进行处理。

### 核心架构的具体流程步骤

首先让我们整体看一下Spring Web MVC 处理：

![请求的流程](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/img/202301311936615.png)

**核心架构的具体流程步骤**如下：

1. **首先用户发送请求——>DispatcherServlet**，前端控制器收到请求后自己不进行处理，而是委托给其他的解析器进行 处理，作为统一访问点，进行全局的流程控制；
2. **DispatcherServlet——>HandlerMapping**， HandlerMapping 将会把请求映射为 HandlerExecutionChain 对象（包含一 个Handler 处理器（页面控制器）对象、多个HandlerInterceptor 拦截器）对象，通过这种策略模式，很容易添加新 的映射策略；
3. **DispatcherServlet——>HandlerAdapter**，HandlerAdapter 将会把处理器包装为适配器，从而支持多种类型的处理器， 即适配器设计模式的应用，从而很容易支持很多类型的处理器；
4. **HandlerAdapter——>处理器功能处理方法的调用**，HandlerAdapter 将会根据适配的结果调用真正的处理器的功能处 理方法，完成功能处理；并返回一个ModelAndView 对象（包含模型数据、逻辑视图名）；
5. **ModelAndView 的逻辑视图名——> ViewResolver**，ViewResolver 将把逻辑视图名解析为具体的View，通过这种策 略模式，很容易更换其他视图技术；
6. **View——>渲染**，View 会根据传进来的Model 模型数据进行渲染，此处的Model 实际是一个Map 数据结构，因此 很容易支持其他视图技术；
7. **返回控制权给DispatcherServlet**，由DispatcherServlet 返回响应给用户，到此一个流程结束。

### 对上述流程的补充

上述流程只是核心流程，这里我们再补充一些其它组件：

#### **Filter(ServletFilter)**

进入**Servlet**前可以有**preFilter**, Servlet**处理**之后还可有**postFilter**

![Filter](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/img/202301311939447.png)

#### **LocaleResolver**

在视图解析/渲染时，还需要考虑国际化(Local)，显然这里需要有**LocaleResolver**.

![LocaleResolver](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/img/202301311941906.png)

#### **ThemeResolver**

如何控制视图样式呢？SpringMVC中还设计了**ThemeSource**接口和**ThemeResolver**，包含一些静态资源的集合(样式及图片等），用来控制应用的视觉风格。

![ThemeResolver](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/img/202301311942708.png)

#### **MultipartResolver(对于文件的上传请求)**

对于常规请求上述流程是合理的，但是如果是文件的上传请求，那么就不太一样了；所以这里便出现了**MultipartResolver**。

![MultipartResolver](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/img/202301311942926.png)

## Spring MVC案例

这里主要向你展示一个基本的SpringMVC例子，后文中将通过以Debug的方式分析源码。

![结构](https://raw.githubusercontent.com/tanzicai/OSS_IMG/main/img/202301312314624.png)

+ Entity-User

```java
package org.books.tanzicai.Entity;

/**
 * @author  tanzicai
 */
public class User {
    /**
     * user's name
     */
    private String name;
    /**
     * user's age
     */
    private int age;

    /**
     * init
     * @param name name
     * @param age age
     */
    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }
}

```

+ Dao-UserDaoImpl

```java
package org.books.tanzicai.Dao;

import org.books.tanzicai.Entity.User;

import java.util.Collections;
import java.util.List;

/**
 * @author tanzicai
 */
public class UserDaoImpl {
    /**
     * mocked to find user list.
     *
     * @return user list
     */
    public List<User> findUserList() {
        return Collections.singletonList(new User("tanzicai", 22));
    }

}

```

+ Controller - **User Controller.**

```java
package org.books.tanzicai.Controller;

import org.books.tanzicai.Service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

/**
 * User Controller.
 *
 * @author tanzicai
 */
@Controller
public class UserController {

    @Autowired
    private UserServiceImpl userService;
    /**
     * find user list.
     *
     * @param request  request
     * @param response response
     * @return model and view
     */
    @RequestMapping("/user")
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("dateTime", new Date());
        modelAndView.addObject("userList", userService.findUserList());
        modelAndView.setViewName("userList"); // views目录下userList.jsp
        return modelAndView;
    }

}
```

+ **Service-UserServiceImpl**

```java
package org.books.tanzicai.Service;


import org.books.tanzicai.Dao.UserDaoImpl;
import org.books.tanzicai.Entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author tanzicai
 */
@Service
public class UserServiceImpl {
    /**
     * user dao impl.
     */
    @Autowired
    private UserDaoImpl userDao;

    /**
     * find user list.
     *
     * @return user list
     */
    public List<User> findUserList() {
        return userDao.findUserList();
    }

}
```

+ springmvc.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xmlns:jpa="http://www.springframework.org/schema/data/jpa"
       xmlns:tx="http://www.springframework.org/schema/tx"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd
       http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc.xsd
       http://www.springframework.org/schema/data/jpa http://www.springframework.org/schema/data/jpa/spring-jpa.xsd
       http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx.xsd">

    <!-- 扫描注解 -->
    <context:component-scan base-package="org.books.tanzicai"/>

    <!-- 静态资源处理 -->
    <mvc:default-servlet-handler/>

    <!-- 开启注解 -->
    <mvc:annotation-driven/>

    <!-- 视图解析器 -->
    <bean id="jspViewResolver" class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="viewClass" value="org.springframework.web.servlet.view.JstlView"/>
        <property name="prefix" value="/WEB-INF/views/"/>
        <property name="suffix" value=".jsp"/>
    </bean>

</beans>

```

+ index.jsp

```jsp
<%--
  Created by IntelliJ IDEA.
  User: pdai
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Hello</title>
</head>
<body>
Hello pdai.
</body>
</html>

```

+ web.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
         version="3.1">

    <display-name>SpringFramework - SpringMVC Demo @</display-name>

    <servlet>
        <servlet-name>springmvc-demo</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <!-- 通过初始化参数指定SpringMVC配置文件的位置和名称 -->
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>classpath:springmvc.xml</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
    </servlet>

    <servlet-mapping>
        <servlet-name>springmvc-demo</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>

    <filter>
        <filter-name>encodingFilter</filter-name>
        <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
        <init-param>
            <param-name>encoding</param-name>
            <param-value>UTF-8</param-value>
        </init-param>
        <init-param>
            <param-name>forceEncoding</param-name>
            <param-value>true</param-value>
        </init-param>
    </filter>

    <filter-mapping>
        <filter-name>encodingFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>
</web-app>

```

+ **userList.jsp**

```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>User List</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">

</head>
<body>
<div class="container">
    <c:if test="${!empty userList}">
        <table class="table table-bordered table-striped">
            <tr>
                <th>Name</th>
                <th>Age</th>
            </tr>
            <c:forEach items="${userList}" var="user">
                <tr>
                    <td>${user.name}</td>
                    <td>${user.age}</td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
</div>
</body>
</html>

```

