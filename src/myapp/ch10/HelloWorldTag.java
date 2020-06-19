package myapp.ch10;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class HelloWorldTag extends SimpleTagSupport{
	
	@Override
	public void doTag() throws IOException {
		final JspWriter out = getJspContext().getOut();
		out.println("Hello JSP Custom Tag!");
	}

}
