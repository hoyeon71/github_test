package com.ghayoun.ezjobs.common.util;

import java.util.*;
import java.io.*;

/**
 * Created by IntelliJ IDEA. 
 * User: 조홍주
 * Date: 2009. 11. 01
 */
public class PropertiesConfig{
	
	private String filePath 	= null;
	private Properties props 	= null;
	
	public PropertiesConfig(String filePath, String propId){
		this.filePath = filePath+"/"+propId+".properties";
		init();
	}
	
	public void init(){
		InputStream is = null;
		
		try{
			this.props = new Properties();
			is = getClass().getResourceAsStream(this.filePath);
			this.props.load(is);
		}catch(IOException ioe){
			ioe.printStackTrace();
		}finally{
			if(null != is){ try{is.close();is=null;}catch(IOException e){} }
		}
	}
	
	public String getProperty(String key){
		return this.props.getProperty(key);
	}
}