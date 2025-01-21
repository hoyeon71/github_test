package com.ghayoun.ezjobs.common.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class FileCompare {
	
	public static StringBuffer fileCompare(String gb, String ori_file, String comp_file){
		
		StringBuffer sb = null;
		
		try{
			
			if(gb.equals("windows")){
				sb = runCommand("cmd /c fc /N \""+ori_file+"\" \""+comp_file+"\"");
			}else{
				sb = runCommand("diff "+ori_file+" "+comp_file);
			}
			
		}catch(Exception e){
			e.getMessage();
		}
		
		return sb;
	}
	
	public static StringBuffer runCommand(String command) throws IOException {
        
		BufferedReader br = null;
		InputStreamReader isr = null;
		StringBuffer sb = new StringBuffer();
		
        try{
        	
            Process proc = Runtime.getRuntime().exec(command);
           
            isr = new InputStreamReader(proc.getInputStream(), "euc-kr");
            br = new BufferedReader(isr);
                    
            String msg = "";            
            while ((msg = br.readLine()) != null) {                
                sb.append(msg+System.getProperty("line.separator"));
                sb.append("<br>");
            }
            
            if(isr != null) isr.close();
        	if(br != null) br.close();
        	
            isr = new InputStreamReader(proc.getErrorStream(), "euc-kr");
            br = new BufferedReader(isr);
            while ((msg = br.readLine()) != null) {
            	sb.append(msg+System.getProperty("line.separator"));
            	sb.append("<br>");
            }
           
        }catch (Exception e){
            e.getMessage();
        }finally{
        	if(isr != null) isr.close();
        	if(br != null) br.close();
        }
        
        return sb;
    }

}
