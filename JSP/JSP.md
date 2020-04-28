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