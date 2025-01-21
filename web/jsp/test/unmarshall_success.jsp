<%@page import="com.bmc.ctmem.schema900.ErrorListType"%>
<%@page import="javax.xml.bind.Unmarshaller"%>
<%@page import="javax.xml.bind.JAXBContext"%>
<%@page import="com.bmc.ctmem.schema900.FaultOrderForceWithJobsType"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="com.ghayoun.ezjobs.common.util.SendSms"%>
<%@page import="com.ghayoun.ezjobs.common.util.SshUtil"%>
<%@page import="com.ghayoun.ezjobs.common.util.CommonUtil"%>
<%@page import="com.ghayoun.ezjobs.common.util.DateUtil"%>
<%@page import="com.ghayoun.ezjobs.common.util.SeedUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//String cmd 			= "<?xml version='1.0' encoding='UTF-8'?><SOAP-ENV:Envelope xmlns:SOAP-ENV='http://schemas.xmlsoap.org/soap/envelope/'><SOAP-ENV:Body><SOAP-ENV:Fault><faultcode>SOAP-ENV:Server</faultcode><faultstring>Error response from EM Server.</faultstring><detail><ctmem:fault_poll_order_force xmlns:ctmem='http://www.bmc.com/ctmem/schema900'><ctmem:jobs><ctmem:job><ctmem:error_list ctmem:highest_severity='Error' ><ctmem:error ctmem:major='100' ctmem:minor='6' ctmem:severity='Error' ><ctmem:error_message>Entry not found5702 Jobname &apos;CBSTES-EZ_0207_104331&apos; not ordered (scheduling criteria are not met)</ctmem:error_message></ctmem:error></ctmem:error_list></ctmem:job></ctmem:jobs><ctmem:error_list ctmem:highest_severity='Error' ><ctmem:error ctmem:major='405' ctmem:minor='4' ctmem:severity='Error' ><ctmem:error_message>No jobs were ordered.</ctmem:error_message></ctmem:error></ctmem:error_list></ctmem:fault_poll_order_force></detail></SOAP-ENV:Fault></SOAP-ENV:Body></SOAP-ENV:Envelope>";
	
	String cmd 			= "<ctmem:error_list  xmlns:ctmem='http://www.bmc.com/ctmem/schema900' ctmem:highest_severity='Error'><ctmem:error ctmem:major='200' ctmem:minor='2' ctmem:severity='Error'><ctmem:error_message>Error while parsing XML: %s</ctmem:error_message></ctmem:error><ctmem:error ctmem:major='200' ctmem:minor='2' ctmem:severity='Error'><ctmem:error_message>Error while parsing XML: Not enough elements to match content model : '(on_statements,do_statements)' Line: 81 Column: 41</ctmem:error_message></ctmem:error></ctmem:error_list>";
	
	ByteArrayInputStream bais 		= new ByteArrayInputStream(cmd.getBytes());
	
	System.out.println("22222");
	
    JAXBContext context2 			= JAXBContext.newInstance(ErrorListType.class);
    
    System.out.println("33333");
    
    Unmarshaller unMarshaller 		= context2.createUnmarshaller();
    
    System.out.println("44444");
    
    ErrorListType dataRoot 		= (ErrorListType) unMarshaller.unmarshal(bais);
    
    System.out.println("55555");
%>