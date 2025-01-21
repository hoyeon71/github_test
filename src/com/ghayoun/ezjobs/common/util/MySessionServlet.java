package com.ghayoun.ezjobs.common.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ghayoun.ezjobs.common.util.MySessionManager;
import com.google.gson.Gson;
 
/**
 * Servlet implementation class MySessionServlet
 */
@WebServlet("/MySessionServlet")
public class MySessionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    /**
     * @see HttpServlet#HttpServlet()
     */
	public MySessionServlet() {
		super();
	}
 
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		if("isLogin".equals(action)) {
			HttpSession session = request.getSession();
			String idKey = (String)session.getAttribute("idKey");
 
			HashMap<String, Object> map = new HashMap<String, Object>();
			if(idKey != null && idKey.length() > 0) {
				map.put("result", "success");
				map.put("message", "로그인 중입니다.");
			} else {
				map.put("result", "fail");
				map.put("message", "일정시간 동작이 없거나, 다른 곳에서 로그인을 하여 로그아웃 되었습니다.\n다시 로그인 해주세요.");
			}
 
			String rtnJsonString = new Gson().toJson(map);
 
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			out.print(rtnJsonString);
			out.flush();
 
			System.out.printf("isLogin : %s \n", map.toString());
		}
		else if("sessionRefresh".equals(action)) {
			HttpSession session = request.getSession();
			session.setMaxInactiveInterval(MySessionManager.SESSION_TIME);
 
			System.out.printf("sessionRefresh\n");
		}
	}
 
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}