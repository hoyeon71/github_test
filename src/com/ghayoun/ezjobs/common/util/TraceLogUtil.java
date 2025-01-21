package com.ghayoun.ezjobs.common.util;

import java.io.*;
import java.util.Date;
import java.text.SimpleDateFormat;


public class TraceLogUtil {

    private static FileWriter objfile 	= null;

    /**************************
    * Logging Method          *  
    ***************************/
    public static void TraceLog(String strLogContent, String strLogPath, String strLogName)
    {
        int i                 = 0;
        String stPath         = "";
        String stFileName     = "";

        stPath     = strLogPath;
        stFileName = strLogName;
        
        SimpleDateFormat formatter1 = new SimpleDateFormat ("yyyyMMdd");
        SimpleDateFormat formatter2 = new SimpleDateFormat ("HH:mm:ss");
        
        String stDate = formatter1.format(new Date());
        String stTime = formatter2.format(new Date());
        
        StringBuffer bufLogPath  = new StringBuffer();       
        bufLogPath.append(stPath);
        bufLogPath.append(stFileName);
        bufLogPath.append("_");
        bufLogPath.append(stDate);
        bufLogPath.append(".log") ;
        
        StringBuffer bufLogMsg = new StringBuffer(); 
        bufLogMsg.append("[");
        bufLogMsg.append(stTime);
        bufLogMsg.append("] ::: ");
        bufLogMsg.append(strLogContent);
        
        try{
        	objfile = new FileWriter(bufLogPath.toString(), true);
            objfile.write(bufLogMsg.toString());
            objfile.write("\r\n");
        }catch(IOException e){
            
        }
        finally
        {
            try{
             objfile.close();
            }catch(Exception e1){}
        }
    }
}



