package myapp;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class SelectProduct
 */
@WebServlet("/SelectProduct")
public class SelectProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectProduct() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		String username = request.getParameter("username");
		HttpSession session = request.getSession();
		session.setAttribute("username", username);
		
		PrintWriter out = response.getWriter();
		out.println("<html><body>");
		out.println("<center>");
		out.println("<h2>상품 선택</h2>");
		out.println(username + "님이 로그인한 상태입니다.");
		out.println("<form name=form2 method=post action=AddProduct>");
		out.println("<select name=product>");
		out.println("<option>apple</option>");
		out.println("<option>orange</option>");
		out.println("<option>lemon</option>");
		out.println("</select>");
		out.println("<input type=submit value=추가/>");
		out.println("</form>");
		out.println("<a href=CheckOut>결제</a>");
		out.println("</center>");
		out.println("</html></body>");
	}

}
