package myapp.ch08;

import java.util.ArrayList;

public interface EventDAO {
	public void addEvent(EventBean event);
	public EventBean getEvent(String id);
	public ArrayList<EventBean> getAllEvent();
}
