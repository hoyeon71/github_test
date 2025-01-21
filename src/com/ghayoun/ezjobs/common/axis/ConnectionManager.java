package com.ghayoun.ezjobs.common.axis;

import com.bmc.ctmem.emapi.EMXMLInvoker;
import com.bmc.ctmem.emapi.InvokeException;
import com.bmc.ctmem.schema900.*;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import java.io.ByteArrayInputStream;
import java.util.*;

public class ConnectionManager{
	
	protected final Log logger = LogFactory.getLog(getClass());	
	
	public Map login(Map map) {
		
		try {
			
			JAXBContext context 				= JAXBContext.newInstance(RequestUserRegistrationType.class);
			RequestUserRegistrationType reqType = new RequestUserRegistrationType();
			java.io.StringWriter sw 			= new java.io.StringWriter();
			
			reqType.setUserName(CommonUtil.getMessage("EM.USER.ID"));
			reqType.setPassword(CommonUtil.getMessage("EM.USER.PW"));
			reqType.setTimeout(CommonUtil.getMessage("EM.TIMEOUT"));
			reqType.setHostname(CommonUtil.getMessage("CTM_NM."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			
			// 해당 타입을 토대로 1차적으로 마샬링.
			Marshaller marshaller = CommonUtil.marshalling(context);
			marshaller.marshal(reqType, sw);
			
			// 마샬링 한 데이터에 BMC API를 호출하기 위한 명세 추가.
			String strReqXml = CommonUtil.marshllingAdd(sw);
			
			System.out.println("@@@@@@ : " + strReqXml);
			
			String strResData 	= invokeRequest(strReqXml);
			String strResXml 	= "";
			
			System.out.println("###### : " + strResData);
			
			// 에러 처리.
			if ( strResData.indexOf("ctmem:error") > 0 ) {
				
				map = CommonUtil.apiErrorProcess(strResData);
				
			// 성공 처리.
			} else {
				
				strResXml 			= strResData.substring(strResData.indexOf("ctmem")-1);				
				String strResTitle 	= strResXml.substring(strResXml.indexOf("ctmem")+6, strResXml.indexOf("xmlns")-1);				
				strResXml 			= strResXml.substring(0, strResXml.lastIndexOf("ctmem")+6) + strResTitle + ">";
				
				ByteArrayInputStream bais 				= new ByteArrayInputStream(strResXml.getBytes());	        
		        JAXBContext context2 					= JAXBContext.newInstance(ResponseUserRegistrationType.class);
	            Unmarshaller unMarshaller 				= context2.createUnmarshaller();
	            ResponseUserRegistrationType dataRoot 	= (ResponseUserRegistrationType) unMarshaller.unmarshal(bais);
	            
	            map.put("rCode", "1");
				map.put("rType", "response_register");
				map.put("rObject", dataRoot);
			}
			
		} catch (JAXBException e) {
			e.printStackTrace();
		}
		
		return map;
	}
	
	public boolean chkUserToken(String user_token) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {			
			
			JAXBContext context 				= JAXBContext.newInstance(RequestCheckUserTokenType.class);
			RequestCheckUserTokenType reqType 	= new RequestCheckUserTokenType();
			java.io.StringWriter sw 			= new java.io.StringWriter();
			
			reqType.setUserToken(user_token);
			
			// 해당 타입을 토대로 1차적으로 마샬링. 
			Marshaller marshaller = CommonUtil.marshalling(context);			
			marshaller.marshal(reqType, sw);
			
			// 마샬링 한 데이터에 API를 호출하기 위한 명세 추가.
			String strReqXml = CommonUtil.marshllingAdd(sw);
			
			String strResData 	= invokeRequest(strReqXml);
			String strResXml 	= "";
			
			// 에러 처리.
			if ( strResData.indexOf("ctmem:error") > 0 ) {
				
				map = CommonUtil.apiErrorProcess(strResData);       
	            
			// 성공 처리.
			} else {
				
				strResXml 			= strResData.substring(strResData.indexOf("ctmem")-1);
				String strResTitle 	= strResXml.substring(strResXml.indexOf("ctmem")+6, strResXml.indexOf("xmlns")-1);				
				strResXml 			= strResXml.substring(0, strResXml.lastIndexOf("ctmem")+6) + strResTitle + ">";
				
				ByteArrayInputStream bais 				= new ByteArrayInputStream(strResXml.getBytes());	        
		        JAXBContext context2 					= JAXBContext.newInstance(ResponseCheckUserTokenType.class);
	            Unmarshaller unMarshaller 				= context2.createUnmarshaller();
	            ResponseCheckUserTokenType dataRoot 	= (ResponseCheckUserTokenType) unMarshaller.unmarshal(bais);
	            
	            if ( dataRoot.getStatus().equals("OK") ) {
	            	return true;
	            }
			}

		} catch (JAXBException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public static String invokeRequest(String request) {
		
//		Properties props = System.getProperties();        
//        
//        props.setProperty("org.omg.CORBA.ORBClass", "org.jacorb.orb.ORB");
//        props.setProperty("org.omg.CORBA.ORBSingletonClass", "org.jacorb.orb.ORBSingleton");
    	
        Collection requests = new LinkedList();   
        
        String password 		= "";
        String encoded_passwd 	= "";
        
        if (request.length() > 0) {
            requests.add(request.trim());
        }

        Iterator iter = requests.iterator();
        
        String response = "INVALID REQUEST !!";

        while (iter.hasNext()) {
        	
        	request = (String) iter.next();
        	
//        	EMXMLInvoker invoker = new EMXMLInvoker(new GSRComponent(CommonUtil.isNull(CommonUtil.getMessage("CTM_NM"))));
        	
        	Properties props = new Properties(); 
        	props.setProperty("ServerURL", 	CommonUtil.isNull(CommonUtil.getMessage("CTM_URL."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB"))));
        	props.setProperty("ConfigDir", 	CommonUtil.isNull(CommonUtil.getDefaultFilePath()));
        	props.setProperty("ConfigFile", "communication");
        	
            
        	EMXMLInvoker invoker = new EMXMLInvoker();
        	String[] args = null;
        	invoker.init(args, props);
        	
            try {
            	
				password = GetValFromXml(request,"password");
				
				if (password.length() > 0 && request.indexOf("request_register") > 0) {
					
					encoded_passwd 	= invoker.BuildPasswordString(password);					
					request 		= request.replaceFirst(password,encoded_passwd);				
				}
				
                response = invoker.invoke(request);
            }
            catch (InvokeException ex) {
            	
            	System.out.println("getMajorCode() : " + ex.getMajorCode() );
            	System.out.println("getMinorCode() : " + ex.getMinorCode());
            	System.out.println("getMessage() : " + ex.getMessage() );
            	System.out.println("getReason() : " + ex.getReason() );
                
            }
            catch (Exception ex) {
                
            }            
        }        
        
        System.out.println("최종결과값 : " + response);
        
        return response;
    }
    
    public static String GetValFromXml (String buffer, String token_name)	{
		final String TOKEN_TAG = token_name + ">";
		int nTokenPos = buffer.indexOf(TOKEN_TAG);
		if (nTokenPos > 0) {
			String val = buffer.substring(nTokenPos + TOKEN_TAG.length(),
				buffer.indexOf("<", nTokenPos + TOKEN_TAG.length()));
			return val;
		}		
		return "";
	}
	
	/*
	private boolean keepAlive(String user_token){
		EmApiServiceLocator locator = new EmApiServiceLocator();
		
		try{
			EmApiInterface service = locator.getem_api();
			Request_client_keep_alive_type reqType = new Request_client_keep_alive_type();
		
			reqType.setUser_token(user_token);
			
			try{
				Simple_status_response_type resType = service.client_keep_alive(reqType);
				
				if( "OK".equals(resType.getStatus()) ){
					return true;
				}
			
			}catch (Fault_type e){
				
				Error_type[] error = e.getError_list();
				if (error != null){
					for (int i=0; i< error.length ; i++){
						logger.error("Error major = "+error[i].getMajor());
						logger.error("Error minor = "+error[i].getMinor());
						logger.error("Error severity = "+error[i].getSeverity());
						logger.error("Error Message = "+error[i].getError_message());
					}
				}
			}catch (RemoteException e){
				logger.error("RemoteException",e);
			}
		}catch (ServiceException e){
			logger.error("ServiceException",e);
		}
		return false;
	}
	*/
		
}
