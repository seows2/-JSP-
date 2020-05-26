package myapp.ch08;

import java.sql.*;
import java.util.ArrayList;

public class DBEventDAO implements EventDAO{
	private String jdbc_driver = "org.mariadb.jdbc.Driver";
	private String jdbc_url = "jdbc:mariadb://localhost:3306/mydb?characterEncoding=utf8&serverTimezone=UTC";
	private Connection con;
	private Statement stmt;
	
	private void connect() {
		try {
			Class.forName(jdbc_driver);
			con = DriverManager.getConnection(jdbc_url, "root", "kgu123");
			stmt = con.createStatement();
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	
	private void disconnect() {
		try {
			stmt.close();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
	}


	@Override
	public EventBean getEvent(String id) {
		String sql = "select id, title, owner, content from event where id = "+ id;
		EventBean event = new EventBean();
		try {
			connect();
			ResultSet rs = stmt.executeQuery(sql);
			rs.next();
			
			event.setId(rs.getInt("id"));
			event.setTitle(rs.getString("title"));
			event.setOwner(rs.getString("owner"));
			event.setContent(rs.getString("content"));
		
			rs.close();
			disconnect();
		} catch (Exception e) {
			System.out.println(e);
		}
		return event;
	}

	@Override
	public ArrayList<EventBean> getAllEvent() {
		String sql = "select id, title, owner from event";
		ArrayList<EventBean> list = new ArrayList<EventBean>();
		
		try {
			connect();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				EventBean event = new EventBean();
				event.setId(rs.getInt("id"));
				event.setTitle(rs.getString("title"));
				event.setTitle(rs.getString("owner"));
				list.add(event);
			}
			rs.close();
			disconnect();
		} catch (Exception e) {
			System.out.println(e);
		}
		
		return list;
	}

	@Override
	public void addEvent(EventBean event) {
		String sql = "insert into event values(`"
				+ event.getId() + "', '"
				+ event.getTitle() + "', '"
				+ event.getOwner() + "', '"
				+ event.getContent() + "')";
		
		try {
			connect();
			stmt.executeUpdate(sql);
			disconnect();
		} catch (Exception e) {
			System.out.println(e);
		}
		
	}
}
