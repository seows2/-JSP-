package myapp.ch10;

import java.io.IOException;
import java.io.StringWriter;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class SendMessageTag extends SimpleTagSupport{
	
	private String from;
	private String to;
	
	public void setFrom(final String from) {
		this.from = from;
	}
	public void setTo(final String to) {
		this.to = to;
	}
	
	@Override
	public void doTag() throws JspException, IOException {
		final StringWriter sw = new StringWriter();
		getJspBody().invoke(sw);
		getJspContext().getOut().print("A message from " + from + " to " + to
										+ ". Message content is " + sw.toString());
	}

}
