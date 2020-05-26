package myapp.ch08;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EventControl
 */
@WebServlet("/EventControl")
public class EventControl extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    EventDAO dao = new DBEventDAO();
	    
	    String address = null;
	    request.setCharacterEncoding("utf-8");
	    
	    String action = request.getParameter("action");
	    if(action == null || action.equals("list")) {
	    	ArrayList<EventBean> list = dao.getAllEvent();
	    	request.setAttribute("eventlist", list);
	    	address = "/ch08/eventview_list.jsp";
	    } else if( action.equals("view")) {
	    	EventBean event = new EventBean();
	    	request.setAttribute("event", event);
	    	address = "/ch08/eventview_view.jsp";
	    } else if(action.equals("add")) {
	    	EventBean event = new EventBean();
	    	event.setId(Integer.parseInt(request.getParameter("id")));
	    	event.setTitle(request.getParameter("title"));
	    	event.setOwner(request.getParameter("owner"));
	    	event.setContent(request.getParameter("content"));
	    	dao.addEvent(event);
	    	request.setAttribute("event", event);
	    	address = "/ch08/eventview_add.jsp";
	    }
	    RequestDispatcher dispatcher = request.getRequestDispatcher(address);
	    dispatcher.forward(request, response);
}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
