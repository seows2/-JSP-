# JSP

## JSP Action의 기능
- JSP 페이지간의 흐름 제어
- Java applet, Javs Beans 컴포넌트 지원

<br>

## Action의 종류

### 1. include action
  현재의 페이지에 다른 페이지를 포함시키는 기능 제공

  <br>

>사용법
```jsp
<jsp:include page="JSP name"/>
```
<br>


> include directive vs include action
- include directive (지시어)
  - 두 파일 내용을 하나로 합친 후 컴파일
  - 정적인 페이지를 포함시킬 때 사용
- include action (액션)
  - 실행 시점에 해당 파일을 호출해서 그 결과를 현 페이지에 포함
  - 동적인 페이지를 포함시킬 때 사용


<br>

### 2. forward action
현재 페이지에서 제어권을 다른 페이지로 넘길 때 사용   
Servlet에서 RequestDispatcher.forward()와 동일한 기능

<br>

> 사용법
```jsp
<jsp:forward page="JSP name"/>
```

<br>

> forward VS redirect

**forward or request dispatch**
- 요청에 대한 처리를 서버 내부에서 다른 component에게 위임
- 요청에 관련된 req, res객체가 함께 전달되어 처리
- In servlet: RequestDispacher 사용
- In JSP: forward action 사용

**redirect**
- 요청에 대해 새로운 URL을 client에게 전송해서 Client가 새로운 URL로 다시 요청을 보내도록 함
- 새 URL에 대한 요청이기 때문에 새로운 req, res객체가 생성
- In servlet & JSP: res객체의 sendRedirect()이용

<br>

## JSP Beans & MVC parrern

### JSP Beans
- JSP와의 연동을 위해 만들어진 beans   
- 비즈니스 로직과 프리젠테이션 로직을 분리   
- JSP beans는 컨테이너에 위치
  - HTML form을 통한 입력 처리
  - DB등 backend와 연동 후 JSP에 결과 제공

<br>

### Java Beans Class 구성
  일반적인 Java class구성과 유사하지만, Java Beans만의 규칙을 따름
- Class name
  - XxxBean형식 (예) UserBean)
- Parameter가 없는 default constructor 제공
  - (예) public UserBean())
- 멤버 변수
  - 클래스 내의 멤버 변수는 private으로 선언해서 direct access를 방지
- getter/setter method
  - 각 멤버 변수의 접근을 위해 getter/setter 메소드 제공
  - 멤버 변수명에 기반하는 메소드를 생성해야함

<br>

### JSP에서 Beans 사용
Scriptlet 내에 java code를 통해 특정 bean 객체 접근이 가능하지만 JSP action을 이용해 bean 객체 사용 가능

> Bean 사용 선언

```jsp
<jsp:useBean id="bean id" class="bean class" scope="범위"/>
```

- bean id >> Bean의 인스턴스 명
- bean class >> Bean 클래스명으로 패키지 경로 포함
- 범위
  - Bean 객체는 해당 범위 내의 attribute로 관리됨
  - application: 웹 어플 종료시까지 사용
  - session: 현재 세션 종료시까지 사용
  - request: 현재 request가 처리 완료될 때까지 사용
  - page: 현재 페이지 내에서만 사용

<br>

**JSP**

```jsp
<jsp:useBean id="user" class="UserBean" scope="request"/>
```

**Servlet**

```java
UserBean user = (UserBean)request.getAttribute("user");
// 해당 scope내에 UserBean이 이미 생성되어 관리되고 있으면 그 인스턴스 획득
if(user == null){
  user = new UserBean();
  request.setAttribute("user",user);
  // 새로운 인스턴스 생성 후 해당 scope에 맞게 attribute로 저장
}
```

<br>

**Bean 객체의 property 획득**

```jsp
<jsp:getProperty name="bean id" property="property name"/>
```
bean id >> Bean 객체의 인스턴스 명
property name
- 획득하려는 property 명
- 내부에서는 getter()를 통해 획득

```jsp
<html><body>
<% UserBean user = (UserBean)session.getAttribute("user"); %>
User name id <%= user.getName() %>
</body></html>
```
=> jsp안에 자바코드가 들어가는 것은 싫어!! jsp Bean을 사용하자!

```jsp
<html><body>
<jsp:useBean id="user" class="UserBean" scope="session"/>
User name is: <jsp:getProperty name="user" property="name"/>
</body></html>
```

<br>

**Bean 객체의 property 설정**

```jsp
<jsp:setProperty name="bean id" property="property name" value="값"/>
```

bean id >> Bean 객체의 인스턴스 명
property name
- 획득하려는 property 명
- 내부에서는 setter()를 통해 획득
값 >> 설정하려는 value

```jsp
<jsp:useBean id="user" class="UserBean" scope="session"/>
<jsp:setProperty name="user" property="name" value="alice"/>
```
VS. 아래는 session객체로부터 user라는 Attribute를 얻어오려함 하지만 존재하지 않는다면 name Property는 alice다 라고 설정   
위의 경우는 session객체를 가져오고 무조건 name을 alice로 변경
```jsp
<jsp:useBean id="user" class="UserBean" scope="session">
  <jsp:setProperty name="user" property="name" value="alice"/>
</jsp:useBean>
```

<br>

**HTML form과 Bean 연결**

 ```html
 <form action="testBean.jsp">
  name : <input type="text" name="name">
  password : <input type="password" name="passwd">
<input type="submit">
</form>
```

```jsp
 <jsp:useBean id="user" class="UserBean" />
<% user.setName(request.getParameter("name"));
user.setPasswd(request.getParameter("passwd")); %>
```

=> 더 좋은 방법

```jsp
<jsp:useBean id="user" class="UserBean" />
<jsp:setProperty name="user" property="name" param="name" /> <jsp:setProperty name="user" property="passwd" param="passwd" />
```

=>더더 좋은 방법

```jsp
 <jsp:useBean id="user" class="UserBean" />
 <jsp:setProperty name="user" property="name" />
 // 이름이 일치해야함 param 생략
 <jsp:setProperty name="user" property="passwd" />
```
 => 더더더 좋은 방법
 
 ```jsp
 <jsp:useBean id="user" class="UserBean" />
 <jsp:setProperty name="user" property="*" />
 ```
 
 ### MVC패턴
 
 
 