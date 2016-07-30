package com.anjilang.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * @author wzq
 *
 *version 1.0 2015-8-25 上午11:51:08
 */
public class DButils {
	
	
private static  Connection conn=null;
	
	public static  Connection getConnection() throws SQLException {
    	String driver = "com.mysql.jdbc.Driver";

		// URL指向要访问的数据库名scutcs

		String url = "jdbc:mysql://localhost:3306/jmshop";

		// MySQL配置时的用户名

		String user = "wzq";

		// Java连接MySQL配置时的密码

		String password = "11111";

		try {

		// 加载驱动程序

		Class.forName(driver);

		// 连续数据库

		 conn = DriverManager.getConnection(url, user, password);

	
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return conn;
		
	}

public static void  release(Connection conn,Statement st,ResultSet rs) {
		
		if(rs!=null){
			try{
				rs.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
			rs = null;

		}
		if(st!=null){
			try{
				st.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		if(conn!=null){
			try{
				conn.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
			
		}

		
		
	}

	}
