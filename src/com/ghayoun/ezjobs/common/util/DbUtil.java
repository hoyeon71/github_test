package com.ghayoun.ezjobs.common.util;


import java.util.*;

import javax.sql.DataSource;

import java.io.*;
import java.text.*;
import java.sql.*;

import core.log.jdbc.driver.MysqlDriver;

public class DbUtil {

	public static Connection getConnection(String gb
													, String url, String port, String inst
													, String user_id, String user_pw) throws Exception{
		Connection conn 		= null;
		
		try {
			String jUrl = "";
			Properties prop = new Properties();
			
			prop.put("user", user_id);
			prop.put("password", user_pw);
			
			if("D2".equals(gb)){
    			Class.forName("com.ibm.db2.jcc.DB2Driver");
    			jUrl =  "jdbc:db2://"+url+":"+port+"/"+inst;
    		}else if("OR".equals(gb)){
    			Class.forName("oracle.jdbc.driver.OracleDriver");
    			jUrl =  "jdbc:oracle:thin:@"+url+":"+port+"/"+inst;
    		}else if("MS".equals(gb)){
    			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    			jUrl =  "jdbc:sqlserver://"+url+":"+port+";DatabaseName="+inst;
    		}else if("PG".equals(gb)){
    			Class.forName("org.postgresql.Driver");
    			jUrl =  "jdbc:postgresql://"+url+":"+port+"/"+inst;
    		}else if("SY".equals(gb)){
    			Class.forName("net.sourceforge.jtds.jdbc.Driver");
    			jUrl =  "jdbc:jtds:sybase://"+url+":"+port+"/"+inst;
    		}else if("MY".equals(gb)){
    			Class.forName("com.mysql.jdbc.Driver");
    			jUrl =  "jdbc:mysql://"+url+":"+port+"/"+inst;
    		}else{
    			throw new Exception("Unsupported type.");
    		}
			
			conn = DriverManager.getConnection(jUrl, prop);
			
			if(conn == null) new Exception("conn is null");
		}catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return conn;
	}
	
	public static Connection getConnection(DataSource ds) throws Exception{
		Connection conn = null;
    	try {
    		conn = ds.getConnection();
    		
    		//System.out.println("conn:"+conn);
    		if(conn == null) throw new Exception("Connection is null");
    	} catch (Exception e) {
    		throw e;
    	}
    	return conn;
    }
	

}