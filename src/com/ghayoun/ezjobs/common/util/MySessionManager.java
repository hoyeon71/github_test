package com.ghayoun.ezjobs.common.util;

import java.util.Hashtable;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
 
/*
리스너 등록방법
 1. @WebListener 어노테이션 사용
 2. web-app xml설정 추가
	<?xml version="1.0" encoding="UTF-8"?>
	<web-app ...>
	     <listener>
	          <listener-class>com.srctree.session.MySessionManager</listener-class>
	     </listener>
	</web-app>
*/
@WebListener
public class MySessionManager implements HttpSessionListener {
	public static int SESSION_TIME = 20*60;//20분
 
	private static MySessionManager sessionManager;
	public static MySessionManager instance() {
		if (sessionManager == null) {
			synchronized (MySessionManager.class) {
				if (sessionManager == null) {
					sessionManager = new MySessionManager();
				}
			}
		}
		return sessionManager;
	}
  
	private Hashtable<String, HttpSession> useridHash;//유저 아이디 : 세션
 
	public MySessionManager() {
		useridHash = new Hashtable<String, HttpSession>();
	}
 
	public void sessionCreated(HttpSessionEvent se)  {
		addSession(se.getSession());
		System.out.printf("생성된 SESSIONID %s \n",  se.getSession().getId());
	}
 
	public void sessionDestroyed(HttpSessionEvent se)  {
		removeSession(se.getSession());
		System.out.printf("제거된 SESSIONID %s \n",  se.getSession().getId());
	}
 
	//세션 추가
	void addSession(HttpSession session) {
	}
 
	//세션 삭제
	void removeSession(HttpSession session) {
		//useridHash 체크 후 제거
		String idKey = (String)session.getAttribute("idKey");
		if(idKey != null && useridHash.containsKey(idKey)) {
			useridHash.remove(idKey);
			System.out.printf("removeSession() : %s[count: %d] \n", idKey, useridHash.size());
		}
	}
 
	//총 개수 리턴
	int getCount() {
		return useridHash.size();
	}
 
	//중복로그인 처리
	public void loginProcess(String userid, HttpSession session) {
		//해당 유저아이디의 세션이 이미 존재한다면 이전 세션은 종료처리한다.
		try {
			if(useridHash.containsKey(userid)) {
				HttpSession prvSession = useridHash.get(userid);
				String idKey = (String)prvSession.getAttribute("idKey");
				//현재 정상적으로 로그인이 된 상태라면
				if(!session.getId().equals(prvSession.getId())){
					if(idKey != null && idKey.length() > 0) {
						//prvSession.invalidate();
						//이중로그인 체크로직 추가
						prvSession.setAttribute("prvSession", "LOGOUT");
						System.out.printf("loginProcess() : 기존세션 종료처리 \n");
					}
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		session.setMaxInactiveInterval(SESSION_TIME);
		session.setAttribute("idKey", userid);
 
		useridHash.put(userid, session);
		System.out.printf("loginProcess() : %s[getId(): %s][count: %d] \n", userid, session.getId(), useridHash.size());
	}
}