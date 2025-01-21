package com.ghayoun.ezjobs.common.util;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletResponse;

/*
 *  ver 1.0
 */
public class JsUtil {
	private static void jsExecute(String script, HttpServletResponse response)
			throws IOException {
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.println(" <script>");
		out.println(" <!-- ");
		out.println(script);
		out.println(" //-->");
		out.println(" </script>");
	}

	private static void htmlExecute(String encoding, String html,
			HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=" + encoding);
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		out.println(" <html><head></head><body>");
		out.println(html);
		out.println(" </body></html>");
	}

	public static void returnXML(String returnTags, HttpServletResponse response)
			throws Exception {
		StringBuffer result = new StringBuffer();
		result.append("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
		result.append("<ajax-response>");
		result.append("<response>");
		result.append(returnTags);
		result.append("</response>");
		result.append("</ajax-response>");
		response.setContentType("text/xml;charset=utf-8");
		// response.setCharacterEncoding("utf-8");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write(result.toString());

	}

	public static void showHtmlMessage(String encoding, String message,
			HttpServletResponse response) throws IOException {
		StringBuffer sbf = new StringBuffer();
		sbf.append("<style>");
		sbf.append("body {");
		sbf.append("font-family: verdana, gulim;");
		sbf.append("font-size: 11px;");
		sbf.append("color:#666666;");
		sbf.append("padding:0px 20px 20px 20px;");
		sbf.append("</style>");
		sbf.append(message);
		htmlExecute(encoding, sbf.toString(), response);
	}

	public static void executeJS(String script, HttpServletResponse response)
			throws Exception {
		jsExecute(script, response);
	}

	public static void showMessage(String message, HttpServletResponse response)
			throws IOException {
		String script = " alert(\"" + message + "\");";
		jsExecute(script, response);

	}

	public static void alertBack(String msg, HttpServletResponse response)
			throws Exception {
		String script = "";
		if (!msg.equals("")) {
			script += " alert(\"" + msg + "\"); ";
		}
		script += " history.back(); ";
		jsExecute(script, response);
	}

	public static void historyBack(HttpServletResponse response)
			throws Exception {
		String script = "";
		script += "history.back();";
		jsExecute(script, response);
	}

	public static void goAlertURL(String msg, String url,
			HttpServletResponse response) throws Exception {
		String script = "";
		if (!msg.equals("")) {
			script += " alert(\"" + msg + "\"); ";
		}
		script += " location.href = \"" + url + "\"; ";
		jsExecute(script, response);
	}

	public static void goParentAlertURL(String msg, String url,
			HttpServletResponse response) throws Exception {
		String script = "";
		if (!msg.equals("")) {
			script += " alert(\"" + msg + "\"); ";
		}
		script += " parent.location.href = \"" + url + "\"; ";
		jsExecute(script, response);
	}

	public static void goURL(String url, HttpServletResponse response)
			throws Exception {
		String script = "";
		script += " location.href = \"" + url + "\"; ";
		jsExecute(script, response);
	}

	public static void alert(String msg, HttpServletResponse response)
			throws Exception {
		String script = " alert(\"" + msg + "\"); ";
		jsExecute(script, response);
	}

	public static void alertClose(String msg, HttpServletResponse response)
			throws Exception {
		String script = "";
		if (!msg.equals("")) {
			script += " alert(\"" + msg + "\"); ";
		}
		script += " self.close();";
		jsExecute(script, response);
	}

	public static void alertOpenerReload(String msg,
			HttpServletResponse response) throws Exception {
		String script = "";
		if (!msg.equals("")) {
			script += " alert(\"" + msg + "\"); ";
		}
		script += " opener.location.reload();";
		script += " self.close();";
		jsExecute(script, response);
	}

	public static void alertOpenerUrl(String msg, String url,
			HttpServletResponse response) throws Exception {
		String script = "";
		if (!msg.equals("")) {
			script += " alert(\"" + msg + "\"); ";
		}
		script += " opener.location.href = \"" + url + "\"; ";
		script += " self.close();";
		jsExecute(script, response);
	}

	public static void goParentURL(String msg, String url,
			HttpServletResponse response) throws Exception {
		String script = "";
		if (!msg.equals("")) {
			script += " alert(\"" + msg + "\"); ";
		}
		script += " parent.location.href = \"" + url + "\"; ";
		jsExecute(script, response);

	}

	public static void goLoginURL(String msg, String url,
			HttpServletResponse response) throws Exception {
		StringBuffer sbf = new StringBuffer();
		sbf.append("var child = parent.document.getElementById('content');");
		sbf.append("if(child != null){alert('" + msg
				+ "');	parent.location.href = '" + url + "';}");
		sbf.append("else{location.href='" + url + "';}");
		jsExecute(sbf.toString(), response);

	}

	public static void alertConfirm(String msg, String goUrl, String stopUrl,
			HttpServletResponse response) throws Exception {
		String script = "";
		if (!msg.equals("")) {
			script += "if(confirm(\"" + msg + "\")){location.replace(\""
					+ goUrl + "\");}else{location.replace(\"" + stopUrl
					+ "\");}";
		}
		jsExecute(script, response);
	}
	
	/**
	 * 문자열 자르기
	 */
	public static String cutStr(String str, int f_size, String joinStr) throws Exception {
		if(str.equals("") || str.getBytes("utf-8").length <= f_size){
		     return str;
		}

		String a = str;
		int i = 0;
		String temp = "";
		String rtn_val = "";
		temp = a.substring(0,1);
		while(i < f_size){
	
		    byte[] ar = temp.getBytes("utf-8");

		    i += ar.length;
		
		    rtn_val += temp;
		    a = a.substring(1);
		    if(a.length() == 1){
		       temp = a;
		    }else if(a.length() > 1){
		       temp = a.substring(0,1);
		    }
		}
		
		return rtn_val+joinStr;
	}
	
	public static void getJsonString(String jsonData, HttpServletResponse response) throws IOException{
		if(jsonData == null) jsonData = "";
		
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		
		PrintWriter pw = response.getWriter();
		pw.println(jsonData);
		
	}
}
