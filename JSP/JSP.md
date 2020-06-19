# JSP

## JSP Action의 기능

- JSP 페이지간의 흐름 제어
- Java applet, Javs Beans 컴포넌트 지원

<br>

## Action의 종류

### 1. include action

현재의 페이지에 다른 페이지를 포함시키는 기능 제공

  <br>

> 사용법

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
  name : <input type="text" name="name" /> password :
  <input type="password" name="passwd" />
  <input type="submit" />
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

 <br>
 
## MVC 패턴

**Model**

- 백엔드 단에서 비즈니스 로직 담당
- 데이터와 그에 대한 행동을 모델링
- 실제 처리해야 하는 작업을 수행
  - DB와 연동해서 쿼리 실행
  - 비즈니스 프로세스 실행
- 프레젠테이션 레이어와 무관하게 데이터를 캡슐화

**View**

- 모델을 통해 얻어진 결과를 출력
- 사용자 타입과 환경에 맞게 다양한 정보를 출력
- 정보 자체가 어디로부터 왓는지, 어떻게 생성되었는지는 상관하지 않음

**Controller**

- 사용자와 백엔드의 비즈니스 로직을 연결해 주는 역할
- 여러 프레젠테이션 중 어느 것을 제공할지 결정해 주는 역할
- 사용자 요청을 받은 후, 요청을 어떻게 처리하고 어떤 결과를 얻어서 표현해야 하는지를 결정

## JDBC

자바 프로그램에서 다양한 종류의 데이터베이스를 표준화된 방법으로 사용할 수 있도록 만든 API 규격

| 연결과정         | JDBC언어                                                                                 |
| ---------------- | ---------------------------------------------------------------------------------------- |
| JDBC driver 로드 | `Class.forName()`                                                                        |
| Database 연결    | `java.sql.Connection`                                                                    |
| SQL문 생성       | `java.sql.Statement` <br> `java.sql.PreparedStatement` <br> `java.sql.CallableStatement` |
| SQL문 전송       | `excuteQuery()` <br> `exeuteUpdate()`                                                    |
| 결과 받기        | `java.sql.ResultSet`                                                                     |
| 연결 해제        | `Connection.close()`                                                                     |

### 표현 언어 (Expression Language)

- 표현 언어란?
  - 처음 JSTL이 소개되었을 때 나온 것
  - MVC 패턴에 따라 뷰 역할을 수행하는 JSP를 더욱 효과적으로 만들려는 목적
  - 간단한 방법으로 데이터를 표현하기 위해 고안된 언어은 SPEL에 기본을 둠

**JSP 표현식 사용**

```jsp
<h2>
  <jsp:useBean id="test" class="TestBean" />
  <%= test.getName() %> 혹은 <jsp:getProperty name="test" property="name" />
</h2>
```

**EL 사용**

```jsp
<h2>
  ${test.name}
</h2>
```

- 현재 페이지에서 출력하고자 하는 데이터(or 객체)가 미리 확보 되어 있어야 함
- page, request, application, session 내장 객체중 하나에 사용하고자 하는 객체가 있어야만 표현 언어를 이용해 데이터 출력이 가능
- 표현 언어의 기본적인 문법
  - 표현 언어는 '\$'로 시작한다.
  - 모든 내용은 "{표현식}"과 같이 구성된다.
  - 표현식에는 기본적으로 변수 이름, 혹은 "객체*이름.멤버변수*이름"구조로 이루어진다.
  - 표현식에는 부가적으로 숫자ㅡ 문자열 ,boolean, null과 같은 상수 값도 올 수 있다.
  - 표현식에는 기본적인 연산을 할 수 있다.
- 표현 언어에서 사용할 수 있는 내장 객체
  - 표현 언어에서는 객체가 생성되어 이미 전달 되었다는 것을 가정
  - 표현언어에서 사용 시점에 객체를 선언할 필요가 없음
  - 표현 언어에서는 다음과 같이 객체에 접근 할 수 있음

```jsp
${member.id} 혹은 ${member["id"]} -> member 객체의 getId() 메소드 호출과 동일
${row[0]} ->row라는 이름의 컬렉션 갹채의 첫 번째 값
```

- 또한 몇몇 내장객체를 통해 컨테이너가 제공하는 다른 객체에 접근할 수 있는 방법을 제공

| 내장객체         | 기능                                                                                   |
| ---------------- | -------------------------------------------------------------------------------------- |
| pageScope        | page범위에 포함된 속성 값에 접근 할 수 있는 객체다.                                    |
| requestScope     | request 범위에 포함된 속성 값에 접근할 수 있는 객체다.                                 |
| sessionScope     | session 범위에 포함된 속성 값에 접근할 수 있는 객체다.                                 |
| applicationScope | application범위에 포함된 속성 값에 접근할 수 있는 객체다.                              |
| param            | request.getParameter("xxx")로 얻을 수 있는 값들이다. <br> \${param.xxx}처럼 사용한다.  |
| paramValues      | request.getParameterValues("xxx")와 동일한 기능 수행 <br> \${paramValues.xxx}처럼 사용 |
| header           | request.getHeader("xxx")와 동일한 기능을 수행 <br> \${header.xxx}처럼 사용한다.        |
| headerValues     | request.getHeaderValues("xxx")와 동일한 기능을 수행 <br> \${headerValues.xxx}처럼 사용 |
| initParam        | 컨텍스트의 초기화 매개변수 값이다.                                                     |
| cookie           | 쿠키 정보에 접근할 수 있는 객체다.                                                     |
| pageContext      | pageContext 객체다.                                                                    |

### 커스텀 태그

- 커스텀 태그(Custom Tag)란?

  - 원래 JSP 페이지에서 반복적인 프로그램 로직을 캡슐화하기 위해 고안됨
  - 기본적으로 제공되는 태그 이외 사용자가 확장한 태그라는 의미에서 붙여진 이름
  - HTML 문서는 브라우저에 의해 해석되므로 커스텀 태그를 구현할 수 없지만, JSP는 서버에서 해석되므로 커스텀 태그를 구현할 수 있음
  - 웹 화면과 프로그램이 복잡해질수록 커스텀 태그를 사용하면 소스를 간결하게 유지할 수 있고 구현된 기능의 재활용이 용이해짐
  - 커스텀태그 라이브러리 장점
    - 비즈니스 로직으로부터 화면 표현을 분리할 수 있다 : 프로그램 개발자는 비즈니스 로직을 개발하고 표현을 위한 커스텀 태그를 제공하며, 화면 개발자는 화면 디자인에 집중할 수 있다.
    - 비즈니스 로직의 캡슐화할 수 있다 : 재사용할 수 있고 유지보수에 유리하다.
    - 보다 완벽한 MVC 패턴을 구현할 수 있다. : JSP를 순수하게 뷰 형태로 사용할 수 있으므로 더욱 완벽한 MVC 패턴을 구현할 수 있다.

- 커스텀 태그를 구현하는 방법
  - 태그파일 기반의 개발 방법
  - 태그 핸들러 클래스 기반 개발 방법
- 태그 파일 기반 개발
  - 비교적 쉽게 JSP 기술들을 활용해 커스텀 태그를 만들 수 있음
  - 구조상 소스가 노출되고 라이브러리화 하기 어려움
  - 복잡한 태그나 라이브러리 개발의 경우에는 태그 핸들러 클래스 기반 개발이 좋음

* 태그의 기본 구조
  - 커스텀 태그도 일반적인 태그와 동일한 구조
  - 태그의 구성 요소는 태그, 속성, 태그 바디
  ```jsp
  <h2>커스텀 태그</h2>
  <form name="form1" method="post">
    <input type="text" name="item1">
  </form>
  ```
  - 태그
    - 기본적으로 모든 태그는 쌍으로 이루어 지며 속성을 포함하고 있다.
  - 속성
    - 속성은 태그안에서 부가적인 정보를 제공하는 것으로, form태그 내에 있는 name과 method, input 태그에 있는 type과 name등이 속성에 해당한다. HTML 자체에서는 제약이 크지 않으니, 가급적 속성 값들은 ""로 묶어주는 것이 좋다.
  - 태그 바디
    - 시작 태그와 종료 태그 사이에 있는 내용을 말한다.

- taglib 지시어
  - 커스텀 태그를 사용하기 위해서는 태그 사용을 원하는 jsp에 taglib 지시어를 기술
  - taglib 지시어는 태그에 대한 정보 수집을 위한 uri 혹은 태그파일 디렉토리와 태그에 붙이기 위한 prefix 정보를 등록한다.

```jsp
<%@ taglib uri="/WEB-INF/tld/MsgTag.tld" prefix="mytag" %>
```

uri : tld 파일 위치를 지정, 태그파일로 구현된 커스텀 태그를 사용하려면 uri대산 tagdir사용
prefix : 커스텀 태그를 구분하기 위한 이름'

- 본문에서 태그를 사용할땐 다음과같이 사용

  ```jsp
  <prefix:태그_이름> 태그 바디</prefix:태그_이름>
  ```

### 태그파일 기반 커스텀 태그

- 태그파일 개요
  - 태그 파일을 이용하면 비교적 간단하고 JSP 페이지 개발과 유사한 구조로 태그 파일을 만들 수 있다.
  - tag 지시어를 사용해 태그 파일을 선언하고 JSP 문법과 표현언어, JSTL 등을 자유롭게 사용할 수 있다.
  - 기본적으로 태그 파일은 JSP와 유사하나 다음과 같은 차이가 있다.
    - 태그 파일 : .tag 파일로 대부분의 JSP 파일과 구성이 동일하다. 표현 언어와 JSTL등을 이용 가능하다.
    - JSP 파일 : 커스텀 태그를 사용하려면 JSP 파일에 taglib 지시어를 설정한 후 커스텀 태그를 사용한다.
- 태그 파일의 구조
  - 태그 파일은 실제 태그의 기능을 구현한 파일.
  - 기본적인 JSP 지시어와 추가된 tag 지시어 attribute 와 variavle 이라는 태그를 사용 할 수 있다.

> 태그 파일에서 사용하는 지시어

| 지시어    | 설명                                                                                                                                                        |
| --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| taglib    | JSP에서의 taglib지시어와 동일하다. 현재 태그 파일에서 다른 커스텀 태그나 JSTL등을 사용하려면 해당 태그 라이브러리를 사용하기 위한 taglib 지시어를 작성한다. |
| include   | JSP에서의 include 지시어와 동일하다. 그러나 포함되는 파일의 구조가 태그 파일의 구조를 따라야만 한다.                                                        |
| tag       | 새로운 지시어로, page 지시어와 유사하다. 현재 파일이 태그 파일이라는 것을 알리고 옵션을 설정한다.                                                           |
| attribute | 작성하는 태그에 포함될 속성 등을 정의한다.                                                                                                                  |
| variable  | 태그 내용에 필요한 표현 언어 변수를 선언한다.                                                                                                               |


