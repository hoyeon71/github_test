<%@page import="com.ghayoun.ezjobs.t.domain.ActiveJobBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<c:set var="job_action" value="${fn:split(JOB_ACTION,',')}"/>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.09.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	
	String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
	
	// 세션값 가져오기.
	String strSessionDcCode = S_D_C_CODE;
	String session_user_gb 	= S_USER_GB;
	List systemJobHistory = (List)request.getAttribute("systemJobHistory");
	int f_count = 1;
	int s_count = 1;
	int b_count = 1;
	
	int c_b_d_cnt 		= 0;
	int c_b_w_cnt 		= 0;
	int c_b_t_cnt 		= 0;
	int c_b_m_cnt 		= 0;
	int c_b_q_cnt 		= 0;
	int c_b_h_cnt 		= 0;
	int c_b_y_cnt 		= 0;
	int c_b_o_cnt 		= 0;
	int c_b_b_cnt 		= 0;
	int c_b_s_cnt 		= 0;
	int c_b_tot_cnt 	= 0;
	
	int c_i_d_cnt 		= 0;
	int c_i_w_cnt 		= 0;
	int c_i_t_cnt 		= 0;
	int c_i_m_cnt 		= 0;
	int c_i_q_cnt 		= 0;
	int c_i_h_cnt 		= 0;
	int c_i_y_cnt 		= 0;
	int c_i_o_cnt 		= 0;
	int c_i_b_cnt 		= 0;
	int c_i_s_cnt 		= 0;
	int c_i_tot_cnt 	= 0;
	
	int c_f_d_cnt 		= 0;
	int c_f_w_cnt 		= 0;
	int c_f_t_cnt 		= 0;
	int c_f_m_cnt 		= 0;
	int c_f_q_cnt 		= 0;
	int c_f_h_cnt 		= 0;
	int c_f_y_cnt 		= 0;
	int c_f_o_cnt 		= 0;
	int c_f_b_cnt 		= 0;
	int c_f_s_cnt 		= 0;
	int c_f_tot_cnt 	= 0;
	
	int c_s_d_cnt 		= 0;
	int c_s_w_cnt 		= 0;
	int c_s_t_cnt 		= 0;
	int c_s_m_cnt 		= 0;
	int c_s_q_cnt 		= 0;
	int c_s_h_cnt 		= 0;
	int c_s_y_cnt 		= 0;
	int c_s_o_cnt 		= 0;
	int c_s_b_cnt 		= 0;
	int c_s_s_cnt 		= 0;
	int c_s_tot_cnt 	= 0;
	
	int c_d_d_cnt 		= 0;
	int c_d_w_cnt 		= 0;
	int c_d_t_cnt 		= 0;
	int c_d_m_cnt 		= 0;
	int c_d_q_cnt 		= 0;
	int c_d_h_cnt 		= 0;
	int c_d_y_cnt 		= 0;
	int c_d_o_cnt 		= 0;
	int c_d_b_cnt 		= 0;
	int c_d_s_cnt 		= 0;
	int c_d_tot_cnt 	= 0;
	
	int c_d_cnt 		= 0;
	int c_w_cnt 		= 0;
	int c_t_cnt 		= 0;
	int c_m_cnt 		= 0;
	int c_q_cnt 		= 0;
	int c_h_cnt 		= 0;
	int c_y_cnt 		= 0;
	int c_o_cnt 		= 0;
	int c_b_cnt 		= 0;
	int c_s_cnt 		= 0;
	int c_tot_cnt 		= 0;
	
	int a_b_d_cnt 		= 0;
	int a_b_w_cnt 		= 0;
	int a_b_t_cnt 		= 0;
	int a_b_m_cnt 		= 0;
	int a_b_q_cnt 		= 0;
	int a_b_h_cnt 		= 0;
	int a_b_y_cnt 		= 0;
	int a_b_o_cnt 		= 0;
	int a_b_b_cnt 		= 0;
	int a_b_a_cnt 		= 0;
	int a_b_tot_cnt 	= 0;
	
	int a_i_d_cnt 		= 0;
	int a_i_w_cnt 		= 0;
	int a_i_t_cnt 		= 0;
	int a_i_m_cnt 		= 0;
	int a_i_q_cnt 		= 0;
	int a_i_h_cnt 		= 0;
	int a_i_y_cnt 		= 0;
	int a_i_o_cnt 		= 0;
	int a_i_b_cnt 		= 0;
	int a_i_a_cnt 		= 0;
	int a_i_tot_cnt 	= 0;
	
	int a_f_d_cnt 		= 0;
	int a_f_w_cnt 		= 0;
	int a_f_t_cnt 		= 0;
	int a_f_m_cnt 		= 0;
	int a_f_q_cnt 		= 0;
	int a_f_h_cnt 		= 0;
	int a_f_y_cnt 		= 0;
	int a_f_o_cnt 		= 0;
	int a_f_b_cnt 		= 0;
	int a_f_a_cnt 		= 0;
	int a_f_tot_cnt 	= 0;
	
	int a_a_d_cnt 		= 0;
	int a_a_w_cnt 		= 0;
	int a_a_t_cnt 		= 0;
	int a_a_m_cnt 		= 0;
	int a_a_q_cnt 		= 0;
	int a_a_h_cnt 		= 0;
	int a_a_y_cnt 		= 0;
	int a_a_o_cnt 		= 0;
	int a_a_b_cnt 		= 0;
	int a_a_a_cnt 		= 0;
	int a_a_tot_cnt 	= 0;
	
	int a_d_d_cnt 		= 0;
	int a_d_w_cnt 		= 0;
	int a_d_t_cnt 		= 0;
	int a_d_m_cnt 		= 0;
	int a_d_q_cnt 		= 0;
	int a_d_h_cnt 		= 0;
	int a_d_y_cnt 		= 0;
	int a_d_o_cnt 		= 0;
	int a_d_b_cnt 		= 0;
	int a_d_a_cnt 		= 0;
	int a_d_tot_cnt 	= 0;
	
	int a_d_cnt 		= 0;
	int a_w_cnt 		= 0;
	int a_t_cnt 		= 0;
	int a_m_cnt 		= 0;
	int a_q_cnt 		= 0;
	int a_h_cnt 		= 0;
	int a_y_cnt 		= 0;
	int a_o_cnt 		= 0;
	int a_b_cnt 		= 0;
	int a_a_cnt 		= 0;
	int a_tot_cnt 		= 0;
	
	int r_b_d_cnt 		= 0;
	int r_b_w_cnt 		= 0;
	int r_b_t_cnt 		= 0;
	int r_b_m_cnt 		= 0;
	int r_b_q_cnt 		= 0;
	int r_b_h_cnt 		= 0;
	int r_b_y_cnt 		= 0;
	int r_b_o_cnt 		= 0;
	int r_b_b_cnt 		= 0;
	int r_b_r_cnt 		= 0;
	int r_b_tot_cnt 	= 0;
	
	int r_i_d_cnt 		= 0;
	int r_i_w_cnt 		= 0;
	int r_i_t_cnt 		= 0;
	int r_i_m_cnt 		= 0;
	int r_i_q_cnt 		= 0;
	int r_i_h_cnt 		= 0;
	int r_i_y_cnt 		= 0;
	int r_i_o_cnt 		= 0;
	int r_i_b_cnt 		= 0;
	int r_i_r_cnt 		= 0;
	int r_i_tot_cnt 	= 0;
	
	int r_f_d_cnt 		= 0;
	int r_f_w_cnt 		= 0;
	int r_f_t_cnt 		= 0;
	int r_f_m_cnt 		= 0;
	int r_f_q_cnt 		= 0;
	int r_f_h_cnt 		= 0;
	int r_f_y_cnt 		= 0;
	int r_f_o_cnt 		= 0;
	int r_f_b_cnt 		= 0;
	int r_f_r_cnt 		= 0;
	int r_f_tot_cnt 	= 0;
	
	int r_r_d_cnt 		= 0;
	int r_r_w_cnt 		= 0;
	int r_r_t_cnt 		= 0;
	int r_r_m_cnt 		= 0;
	int r_r_q_cnt 		= 0;
	int r_r_h_cnt 		= 0;
	int r_r_y_cnt 		= 0;
	int r_r_o_cnt 		= 0;
	int r_r_b_cnt 		= 0;
	int r_r_r_cnt 		= 0;
	int r_r_tot_cnt 	= 0;
	
	int r_d_d_cnt 		= 0;
	int r_d_w_cnt 		= 0;
	int r_d_t_cnt 		= 0;
	int r_d_m_cnt 		= 0;
	int r_d_q_cnt 		= 0;
	int r_d_h_cnt 		= 0;
	int r_d_y_cnt 		= 0;
	int r_d_o_cnt 		= 0;
	int r_d_b_cnt 		= 0;
	int r_d_r_cnt 		= 0;
	int r_d_tot_cnt 	= 0;
	
	int r_d_cnt 		= 0;
	int r_w_cnt 		= 0;
	int r_t_cnt 		= 0;
	int r_m_cnt 		= 0;
	int r_q_cnt 		= 0;
	int r_h_cnt 		= 0;
	int r_y_cnt 		= 0;
	int r_o_cnt 		= 0;
	int r_b_cnt 		= 0;
	int r_r_cnt 		= 0;
	int r_tot_cnt 		= 0;
	
	int s_b_d_cnt 		= 0;
	int s_b_w_cnt 		= 0;
	int s_b_t_cnt 		= 0;
	int s_b_m_cnt 		= 0;
	int s_b_q_cnt 		= 0;
	int s_b_h_cnt 		= 0;
	int s_b_y_cnt 		= 0;
	int s_b_o_cnt 		= 0;
	int s_b_b_cnt 		= 0;
	int s_b_s_cnt 		= 0;
	int s_b_tot_cnt 	= 0;
	
	int s_i_d_cnt 		= 0;
	int s_i_w_cnt 		= 0;
	int s_i_t_cnt 		= 0;
	int s_i_m_cnt 		= 0;
	int s_i_q_cnt 		= 0;
	int s_i_h_cnt 		= 0;
	int s_i_y_cnt 		= 0;
	int s_i_o_cnt 		= 0;
	int s_i_b_cnt 		= 0;
	int s_i_s_cnt 		= 0;
	int s_i_tot_cnt 	= 0;
	
	int s_f_d_cnt 		= 0;
	int s_f_w_cnt 		= 0;
	int s_f_t_cnt 		= 0;
	int s_f_m_cnt 		= 0;
	int s_f_q_cnt 		= 0;
	int s_f_h_cnt 		= 0;
	int s_f_y_cnt 		= 0;
	int s_f_o_cnt 		= 0;
	int s_f_b_cnt 		= 0;
	int s_f_s_cnt 		= 0;
	int s_f_tot_cnt 	= 0;
	
	int s_s_d_cnt 		= 0;
	int s_s_w_cnt 		= 0;
	int s_s_t_cnt 		= 0;
	int s_s_m_cnt 		= 0;
	int s_s_q_cnt 		= 0;
	int s_s_h_cnt 		= 0;
	int s_s_y_cnt 		= 0;
	int s_s_o_cnt 		= 0;
	int s_s_b_cnt 		= 0;
	int s_s_s_cnt 		= 0;
	int s_s_tot_cnt 	= 0;
	
	int s_d_d_cnt 		= 0;
	int s_d_w_cnt 		= 0;
	int s_d_t_cnt 		= 0;
	int s_d_m_cnt 		= 0;
	int s_d_q_cnt 		= 0;
	int s_d_h_cnt 		= 0;
	int s_d_y_cnt 		= 0;
	int s_d_o_cnt 		= 0;
	int s_d_b_cnt 		= 0;
	int s_d_s_cnt 		= 0;
	int s_d_tot_cnt 	= 0;
	
	int s_d_cnt 		= 0;
	int s_w_cnt 		= 0;
	int s_t_cnt 		= 0;
	int s_m_cnt 		= 0;
	int s_q_cnt 		= 0;
	int s_h_cnt 		= 0;
	int s_y_cnt 		= 0;
	int s_o_cnt 		= 0;
	int s_b_cnt 		= 0;
	int s_s_cnt 		= 0;
	int s_tot_cnt 		= 0;
	
	int d_b_d_cnt 		= 0;
	int d_b_w_cnt 		= 0;
	int d_b_t_cnt 		= 0;
	int d_b_m_cnt 		= 0;
	int d_b_q_cnt 		= 0;
	int d_b_h_cnt 		= 0;
	int d_b_y_cnt 		= 0;
	int d_b_o_cnt 		= 0;
	int d_b_b_cnt 		= 0;
	int d_b_s_cnt 		= 0;
	int d_b_tot_cnt 	= 0;
	
	int d_i_d_cnt 		= 0;
	int d_i_w_cnt 		= 0;
	int d_i_t_cnt 		= 0;
	int d_i_m_cnt 		= 0;
	int d_i_q_cnt 		= 0;
	int d_i_h_cnt 		= 0;
	int d_i_y_cnt 		= 0;
	int d_i_o_cnt 		= 0;
	int d_i_b_cnt 		= 0;
	int d_i_s_cnt 		= 0;
	int d_i_tot_cnt 	= 0;
	
	int d_f_d_cnt 		= 0;
	int d_f_w_cnt 		= 0;
	int d_f_t_cnt 		= 0;
	int d_f_m_cnt 		= 0;
	int d_f_q_cnt 		= 0;
	int d_f_h_cnt 		= 0;
	int d_f_y_cnt 		= 0;
	int d_f_o_cnt 		= 0;
	int d_f_b_cnt 		= 0;
	int d_f_s_cnt 		= 0;
	int d_f_tot_cnt 	= 0;
	
	int d_s_d_cnt 		= 0;
	int d_s_w_cnt 		= 0;
	int d_s_t_cnt 		= 0;
	int d_s_m_cnt 		= 0;
	int d_s_q_cnt 		= 0;
	int d_s_h_cnt 		= 0;
	int d_s_y_cnt 		= 0;
	int d_s_o_cnt 		= 0;
	int d_s_b_cnt 		= 0;
	int d_s_s_cnt 		= 0;
	int d_s_tot_cnt 	= 0;
	
	int d_d_d_cnt 		= 0;
	int d_d_w_cnt 		= 0;
	int d_d_t_cnt 		= 0;
	int d_d_m_cnt 		= 0;
	int d_d_q_cnt 		= 0;
	int d_d_h_cnt 		= 0;
	int d_d_y_cnt 		= 0;
	int d_d_o_cnt 		= 0;
	int d_d_b_cnt 		= 0;
	int d_d_s_cnt 		= 0;
	int d_d_tot_cnt 	= 0;
	
	int d_d_cnt 		= 0;
	int d_w_cnt 		= 0;
	int d_t_cnt 		= 0;
	int d_m_cnt 		= 0;
	int d_q_cnt 		= 0;
	int d_h_cnt 		= 0;
	int d_y_cnt 		= 0;
	int d_o_cnt 		= 0;
	int d_b_cnt 		= 0;
	int d_s_cnt 		= 0;
	int d_tot_cnt 		= 0;
	

	int m_b_d_cnt 		= 0;
	int m_b_w_cnt 		= 0;
	int m_b_t_cnt 		= 0;
	int m_b_m_cnt 		= 0;
	int m_b_q_cnt 		= 0;
	int m_b_h_cnt 		= 0;
	int m_b_y_cnt 		= 0;
	int m_b_o_cnt 		= 0;
	int m_b_b_cnt 		= 0;
	int m_b_s_cnt 		= 0;
	int m_b_tot_cnt 	= 0;
	
	int m_i_d_cnt 		= 0;
	int m_i_w_cnt 		= 0;
	int m_i_t_cnt 		= 0;
	int m_i_m_cnt 		= 0;
	int m_i_q_cnt 		= 0;
	int m_i_h_cnt 		= 0;
	int m_i_y_cnt 		= 0;
	int m_i_o_cnt 		= 0;
	int m_i_b_cnt 		= 0;
	int m_i_s_cnt 		= 0;
	int m_i_tot_cnt 	= 0;
	
	int m_f_d_cnt 		= 0;
	int m_f_w_cnt 		= 0;
	int m_f_t_cnt 		= 0;
	int m_f_m_cnt 		= 0;
	int m_f_q_cnt 		= 0;
	int m_f_h_cnt 		= 0;
	int m_f_y_cnt 		= 0;
	int m_f_o_cnt 		= 0;
	int m_f_b_cnt 		= 0;
	int m_f_s_cnt 		= 0;
	int m_f_tot_cnt 	= 0;
	
	int m_s_d_cnt 		= 0;
	int m_s_w_cnt 		= 0;
	int m_s_t_cnt 		= 0;
	int m_s_m_cnt 		= 0;
	int m_s_q_cnt 		= 0;
	int m_s_h_cnt 		= 0;
	int m_s_y_cnt 		= 0;
	int m_s_o_cnt 		= 0;
	int m_s_b_cnt 		= 0;
	int m_s_s_cnt 		= 0;
	int m_s_tot_cnt 	= 0;
	
	int m_d_d_cnt 		= 0;
	int m_d_w_cnt 		= 0;
	int m_d_t_cnt 		= 0;
	int m_d_m_cnt 		= 0;
	int m_d_q_cnt 		= 0;
	int m_d_h_cnt 		= 0;
	int m_d_y_cnt 		= 0;
	int m_d_o_cnt 		= 0;
	int m_d_b_cnt 		= 0;
	int m_d_s_cnt 		= 0;
	int m_d_tot_cnt 	= 0;
	    
	int m_d_cnt 		= 0;
	int m_w_cnt 		= 0;
	int m_t_cnt 		= 0;
	int m_m_cnt 		= 0;
	int m_q_cnt 		= 0;
	int m_h_cnt 		= 0;
	int m_y_cnt 		= 0;
	int m_o_cnt 		= 0;
	int m_b_cnt 		= 0;
	int m_s_cnt 		= 0;
	int m_tot_cnt 		= 0;
	
	int u_b_d_cnt 		= 0;
	int u_b_w_cnt 		= 0;
	int u_b_t_cnt 		= 0;
	int u_b_m_cnt 		= 0;
	int u_b_q_cnt 		= 0;
	int u_b_h_cnt 		= 0;
	int u_b_y_cnt 		= 0;
	int u_b_o_cnt 		= 0;
	int u_b_b_cnt 		= 0;
	int u_b_s_cnt 		= 0;
	int u_b_tot_cnt 	= 0;
	
	int u_i_d_cnt 		= 0;
	int u_i_w_cnt 		= 0;
	int u_i_t_cnt 		= 0;
	int u_i_m_cnt 		= 0;
	int u_i_q_cnt 		= 0;
	int u_i_h_cnt 		= 0;
	int u_i_y_cnt 		= 0;
	int u_i_o_cnt 		= 0;
	int u_i_b_cnt 		= 0;
	int u_i_s_cnt 		= 0;
	int u_i_tot_cnt 	= 0;
	
	int u_f_d_cnt 		= 0;
	int u_f_w_cnt 		= 0;
	int u_f_t_cnt 		= 0;
	int u_f_m_cnt 		= 0;
	int u_f_q_cnt 		= 0;
	int u_f_h_cnt 		= 0;
	int u_f_y_cnt 		= 0;
	int u_f_o_cnt 		= 0;
	int u_f_b_cnt 		= 0;
	int u_f_s_cnt 		= 0;
	int u_f_tot_cnt 	= 0;
	
	int u_s_d_cnt 		= 0;
	int u_s_w_cnt 		= 0;
	int u_s_t_cnt 		= 0;
	int u_s_m_cnt 		= 0;
	int u_s_q_cnt 		= 0;
	int u_s_h_cnt 		= 0;
	int u_s_y_cnt 		= 0;
	int u_s_o_cnt 		= 0;
	int u_s_b_cnt 		= 0;
	int u_s_s_cnt 		= 0;
	int u_s_tot_cnt 	= 0;
	
	int u_d_d_cnt 		= 0;
	int u_d_w_cnt 		= 0;
	int u_d_t_cnt 		= 0;
	int u_d_m_cnt 		= 0;
	int u_d_q_cnt 		= 0;
	int u_d_h_cnt 		= 0;
	int u_d_y_cnt 		= 0;
	int u_d_o_cnt 		= 0;
	int u_d_b_cnt 		= 0;
	int u_d_s_cnt 		= 0;
	int u_d_tot_cnt 	= 0;
	    
	int u_d_cnt 		= 0;
	int u_w_cnt 		= 0;
	int u_t_cnt 		= 0;
	int u_m_cnt 		= 0;
	int u_q_cnt 		= 0;
	int u_h_cnt 		= 0;
	int u_y_cnt 		= 0;
	int u_o_cnt 		= 0;
	int u_b_cnt 		= 0;
	int u_s_cnt 		= 0;
	int u_tot_cnt 		= 0;
	
	int p_b_d_cnt 		= 0;
	int p_b_w_cnt 		= 0;
	int p_b_t_cnt 		= 0;
	int p_b_m_cnt 		= 0;
	int p_b_q_cnt 		= 0;
	int p_b_h_cnt 		= 0;
	int p_b_y_cnt 		= 0;
	int p_b_o_cnt 		= 0;
	int p_b_b_cnt 		= 0;
	int p_b_s_cnt 		= 0;
	int p_b_tot_cnt 	= 0;
	
	int p_i_d_cnt 		= 0;
	int p_i_w_cnt 		= 0;
	int p_i_t_cnt 		= 0;
	int p_i_m_cnt 		= 0;
	int p_i_q_cnt 		= 0;
	int p_i_h_cnt 		= 0;
	int p_i_y_cnt 		= 0;
	int p_i_o_cnt 		= 0;
	int p_i_b_cnt 		= 0;
	int p_i_s_cnt 		= 0;
	int p_i_tot_cnt 	= 0;
	
	int p_f_d_cnt 		= 0;
	int p_f_w_cnt 		= 0;
	int p_f_t_cnt 		= 0;
	int p_f_m_cnt 		= 0;
	int p_f_q_cnt 		= 0;
	int p_f_h_cnt 		= 0;
	int p_f_y_cnt 		= 0;
	int p_f_o_cnt 		= 0;
	int p_f_b_cnt 		= 0;
	int p_f_s_cnt 		= 0;
	int p_f_tot_cnt 	= 0;
	
	int p_s_d_cnt 		= 0;
	int p_s_w_cnt 		= 0;
	int p_s_t_cnt 		= 0;
	int p_s_m_cnt 		= 0;
	int p_s_q_cnt 		= 0;
	int p_s_h_cnt 		= 0;
	int p_s_y_cnt 		= 0;
	int p_s_o_cnt 		= 0;
	int p_s_b_cnt 		= 0;
	int p_s_s_cnt 		= 0;
	int p_s_tot_cnt 	= 0;
	
	int p_d_d_cnt 		= 0;
	int p_d_w_cnt 		= 0;
	int p_d_t_cnt 		= 0;
	int p_d_m_cnt 		= 0;
	int p_d_q_cnt 		= 0;
	int p_d_h_cnt 		= 0;
	int p_d_y_cnt 		= 0;
	int p_d_o_cnt 		= 0;
	int p_d_b_cnt 		= 0;
	int p_d_s_cnt 		= 0;
	int p_d_tot_cnt 	= 0;
	    
	int p_d_cnt 		= 0;
	int p_w_cnt 		= 0;
	int p_t_cnt 		= 0;
	int p_m_cnt 		= 0;
	int p_q_cnt 		= 0;
	int p_h_cnt 		= 0;
	int p_y_cnt 		= 0;
	int p_o_cnt 		= 0;
	int p_b_cnt 		= 0;
	int p_s_cnt 		= 0;
	int p_tot_cnt 		= 0;
	
	int etc_b_d_cnt 		= 0;
	int etc_b_w_cnt 		= 0;
	int etc_b_t_cnt 		= 0;
	int etc_b_m_cnt 		= 0;
	int etc_b_q_cnt 		= 0;
	int etc_b_h_cnt 		= 0;
	int etc_b_y_cnt 		= 0;
	int etc_b_o_cnt 		= 0;
	int etc_b_b_cnt 		= 0;
	int etc_b_s_cnt 		= 0;
	int etc_b_tot_cnt 	= 0;
	
	int etc_i_d_cnt 		= 0;
	int etc_i_w_cnt 		= 0;
	int etc_i_t_cnt 		= 0;
	int etc_i_m_cnt 		= 0;
	int etc_i_q_cnt 		= 0;
	int etc_i_h_cnt 		= 0;
	int etc_i_y_cnt 		= 0;
	int etc_i_o_cnt 		= 0;
	int etc_i_b_cnt 		= 0;
	int etc_i_s_cnt 		= 0;
	int etc_i_tot_cnt 	= 0;
	
	int etc_f_d_cnt 		= 0;
	int etc_f_w_cnt 		= 0;
	int etc_f_t_cnt 		= 0;
	int etc_f_m_cnt 		= 0;
	int etc_f_q_cnt 		= 0;
	int etc_f_h_cnt 		= 0;
	int etc_f_y_cnt 		= 0;
	int etc_f_o_cnt 		= 0;
	int etc_f_b_cnt 		= 0;
	int etc_f_s_cnt 		= 0;
	int etc_f_tot_cnt 	= 0;
	
	int etc_s_d_cnt 		= 0;
	int etc_s_w_cnt 		= 0;
	int etc_s_t_cnt 		= 0;
	int etc_s_m_cnt 		= 0;
	int etc_s_q_cnt 		= 0;
	int etc_s_h_cnt 		= 0;
	int etc_s_y_cnt 		= 0;
	int etc_s_o_cnt 		= 0;
	int etc_s_b_cnt 		= 0;
	int etc_s_s_cnt 		= 0;
	int etc_s_tot_cnt 	= 0;
	
	int etc_d_d_cnt 		= 0;
	int etc_d_w_cnt 		= 0;
	int etc_d_t_cnt 		= 0;
	int etc_d_m_cnt 		= 0;
	int etc_d_q_cnt 		= 0;
	int etc_d_h_cnt 		= 0;
	int etc_d_y_cnt 		= 0;
	int etc_d_o_cnt 		= 0;
	int etc_d_b_cnt 		= 0;
	int etc_d_s_cnt 		= 0;
	int etc_d_tot_cnt 	= 0;
	    
	int etc_d_cnt 		= 0;
	int etc_w_cnt 		= 0;
	int etc_t_cnt 		= 0;
	int etc_m_cnt 		= 0;
	int etc_q_cnt 		= 0;
	int etc_h_cnt 		= 0;
	int etc_y_cnt 		= 0;
	int etc_o_cnt 		= 0;
	int etc_b_cnt 		= 0;
	int etc_s_cnt 		= 0;
	int etc_tot_cnt 		= 0;
	
	for(int i=0; i<systemJobHistory.size(); i++){
		ActiveJobBean activeJobBean = (ActiveJobBean) systemJobHistory.get(i);
	
		if(activeJobBean.getSystem_gubun() != null && activeJobBean.getSystem_gubun().equals("C")){
			c_d_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));                                 
			c_w_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));                                 
			c_t_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));                                 
			c_m_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));                                 
			c_q_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));                                 
			c_h_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));                                 
			c_y_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));                                 
			c_o_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));                                 
			c_b_cnt 	   = c_d_cnt + c_w_cnt + c_t_cnt + c_m_cnt + c_q_cnt + c_h_cnt + c_y_cnt + c_o_cnt; 
			c_s_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));                                 
			c_tot_cnt      = c_b_cnt + c_b_s_cnt;                                                                         
			                                                                                                                
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("B")){
				c_b_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				c_b_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				c_b_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				c_b_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				c_b_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				c_b_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				c_b_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				c_b_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				c_b_b_cnt 		= c_b_d_cnt + c_b_w_cnt + c_b_t_cnt + c_b_m_cnt + c_b_q_cnt + c_b_h_cnt + c_b_y_cnt + c_b_o_cnt;
				c_b_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				c_b_tot_cnt 	= c_b_b_cnt + c_b_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("I")){
				c_i_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				c_i_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				c_i_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				c_i_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				c_i_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				c_i_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				c_i_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				c_i_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				c_i_b_cnt 		= c_i_d_cnt + c_i_w_cnt + c_i_t_cnt + c_i_m_cnt + c_i_q_cnt + c_i_h_cnt + c_i_y_cnt + c_i_o_cnt;
				c_i_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				c_i_tot_cnt 	= c_i_b_cnt + c_i_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("F")){
				c_f_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				c_f_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				c_f_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				c_f_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				c_f_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				c_f_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				c_f_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				c_f_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				c_f_b_cnt 		= c_f_d_cnt + c_f_w_cnt + c_f_t_cnt + c_f_m_cnt + c_f_q_cnt + c_f_h_cnt + c_f_y_cnt + c_f_o_cnt;
				c_f_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				c_f_tot_cnt 	= c_f_b_cnt + c_f_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("S")){
				c_s_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				c_s_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				c_s_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				c_s_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				c_s_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				c_s_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				c_s_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				c_s_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				c_s_b_cnt 		= c_s_d_cnt + c_s_w_cnt + c_s_t_cnt + c_s_m_cnt + c_s_q_cnt + c_s_h_cnt + c_s_y_cnt + c_s_o_cnt;
				c_s_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				c_s_tot_cnt 	= c_s_b_cnt + c_s_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("D")){
				c_d_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				c_d_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				c_d_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				c_d_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				c_d_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				c_d_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				c_d_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				c_d_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				c_d_b_cnt 		= c_d_d_cnt + c_d_w_cnt + c_d_t_cnt + c_d_m_cnt + c_d_q_cnt + c_d_h_cnt + c_d_y_cnt + c_d_o_cnt;
				c_d_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				c_d_tot_cnt 	= c_d_b_cnt + c_d_s_cnt;
			}
		}else if(activeJobBean.getSystem_gubun() != null && activeJobBean.getSystem_gubun().equals("A")){
			a_d_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));                                 
			a_w_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));                                 
			a_t_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));                                 
			a_m_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));                                 
			a_q_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));                                 
			a_h_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));                                 
			a_y_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));                                 
			a_o_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));                                 
			a_b_cnt 	   = a_d_cnt + a_w_cnt + a_t_cnt + a_m_cnt + a_q_cnt + a_h_cnt + a_y_cnt + a_o_cnt; 
			a_a_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));                                 
			a_tot_cnt      = a_b_cnt + a_b_a_cnt;                                                                         
			                                                                                                                
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("B")){
				a_b_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				a_b_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				a_b_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				a_b_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				a_b_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				a_b_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				a_b_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				a_b_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				a_b_b_cnt 		= a_b_d_cnt + a_b_w_cnt + a_b_t_cnt + a_b_m_cnt + a_b_q_cnt + a_b_h_cnt + a_b_y_cnt + a_b_o_cnt;
				a_b_a_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				a_b_tot_cnt 	= a_b_b_cnt + a_b_a_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("I")){
				a_i_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				a_i_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				a_i_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				a_i_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				a_i_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				a_i_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				a_i_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				a_i_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				a_i_b_cnt 		= a_i_d_cnt + a_i_w_cnt + a_i_t_cnt + a_i_m_cnt + a_i_q_cnt + a_i_h_cnt + a_i_y_cnt + a_i_o_cnt;
				a_i_a_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				a_i_tot_cnt 	= a_i_b_cnt + a_i_a_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("F")){
				a_f_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				a_f_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				a_f_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				a_f_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				a_f_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				a_f_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				a_f_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				a_f_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				a_f_b_cnt 		= a_f_d_cnt + a_f_w_cnt + a_f_t_cnt + a_f_m_cnt + a_f_q_cnt + a_f_h_cnt + a_f_y_cnt + a_f_o_cnt;
				a_f_a_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				a_f_tot_cnt 	= a_f_b_cnt + a_f_a_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("S")){
				a_a_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				a_a_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				a_a_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				a_a_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				a_a_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				a_a_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				a_a_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				a_a_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				a_a_b_cnt 		= a_a_d_cnt + a_a_w_cnt + a_a_t_cnt + a_a_m_cnt + a_a_q_cnt + a_a_h_cnt + a_a_y_cnt + a_a_o_cnt;
				a_a_a_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				a_a_tot_cnt 	= a_a_b_cnt + a_a_a_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("D")){
				a_d_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				a_d_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				a_d_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				a_d_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				a_d_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				a_d_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				a_d_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				a_d_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				a_d_b_cnt 		= a_d_d_cnt + a_d_w_cnt + a_d_t_cnt + a_d_m_cnt + a_d_q_cnt + a_d_h_cnt + a_d_y_cnt + a_d_o_cnt;
				a_d_a_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				a_d_tot_cnt 	= a_d_b_cnt + a_d_a_cnt;
			}
		}else if(activeJobBean.getSystem_gubun() != null && activeJobBean.getSystem_gubun().equals("R")){
			r_d_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));                                 
			r_w_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));                                 
			r_t_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));                                 
			r_m_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));                                 
			r_q_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));                                 
			r_h_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));                                 
			r_y_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));                                 
			r_o_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));                                 
			r_b_cnt 	   = r_d_cnt + r_w_cnt + r_t_cnt + r_m_cnt + r_q_cnt + r_h_cnt + r_y_cnt + r_o_cnt; 
			r_r_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));                                 
			r_tot_cnt      = r_b_cnt + r_b_r_cnt;                                                                         
			                                                                                                                
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("B")){
				r_b_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				r_b_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				r_b_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				r_b_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				r_b_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				r_b_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				r_b_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				r_b_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				r_b_b_cnt 		= r_b_d_cnt + r_b_w_cnt + r_b_t_cnt + r_b_m_cnt + r_b_q_cnt + r_b_h_cnt + r_b_y_cnt + r_b_o_cnt;
				r_b_r_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				r_b_tot_cnt 	= r_b_b_cnt + r_b_r_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("I")){
				r_i_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				r_i_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				r_i_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				r_i_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				r_i_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				r_i_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				r_i_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				r_i_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				r_i_b_cnt 		= r_i_d_cnt + r_i_w_cnt + r_i_t_cnt + r_i_m_cnt + r_i_q_cnt + r_i_h_cnt + r_i_y_cnt + r_i_o_cnt;
				r_i_r_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				r_i_tot_cnt 	= r_i_b_cnt + r_i_r_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("F")){
				r_f_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				r_f_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				r_f_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				r_f_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				r_f_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				r_f_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				r_f_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				r_f_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				r_f_b_cnt 		= r_f_d_cnt + r_f_w_cnt + r_f_t_cnt + r_f_m_cnt + r_f_q_cnt + r_f_h_cnt + r_f_y_cnt + r_f_o_cnt;
				r_f_r_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				r_f_tot_cnt 	= r_f_b_cnt + r_f_r_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("S")){
				r_r_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				r_r_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				r_r_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				r_r_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				r_r_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				r_r_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				r_r_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				r_r_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				r_r_b_cnt 		= r_r_d_cnt + r_r_w_cnt + r_r_t_cnt + r_r_m_cnt + r_r_q_cnt + r_r_h_cnt + r_r_y_cnt + r_r_o_cnt;
				r_r_r_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				r_r_tot_cnt 	= r_r_b_cnt + r_r_r_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("D")){
				r_d_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				r_d_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				r_d_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				r_d_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				r_d_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				r_d_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				r_d_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				r_d_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				r_d_b_cnt 		= r_d_d_cnt + r_d_w_cnt + r_d_t_cnt + r_d_m_cnt + r_d_q_cnt + r_d_h_cnt + r_d_y_cnt + r_d_o_cnt;
				r_d_r_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				r_d_tot_cnt 	= r_d_b_cnt + r_d_r_cnt;
			}
		}else if(activeJobBean.getSystem_gubun() != null && activeJobBean.getSystem_gubun().equals("S")){
			s_d_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));                                 
			s_w_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));                                 
			s_t_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));                                 
			s_m_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));                                 
			s_q_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));                                 
			s_h_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));                                 
			s_y_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));                                 
			s_o_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));                                 
			s_b_cnt 	   = s_d_cnt + s_w_cnt + s_t_cnt + s_m_cnt + s_q_cnt + s_h_cnt + s_y_cnt + s_o_cnt; 
			s_s_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));                                 
			s_tot_cnt      = s_b_cnt + s_b_s_cnt;                                                                         
			                                                                                                                
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("B")){
				s_b_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				s_b_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				s_b_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				s_b_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				s_b_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				s_b_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				s_b_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				s_b_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				s_b_b_cnt 		= s_b_d_cnt + s_b_w_cnt + s_b_t_cnt + s_b_m_cnt + s_b_q_cnt + s_b_h_cnt + s_b_y_cnt + s_b_o_cnt;
				s_b_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				s_b_tot_cnt 	= s_b_b_cnt + s_b_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("I")){
				s_i_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				s_i_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				s_i_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				s_i_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				s_i_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				s_i_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				s_i_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				s_i_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				s_i_b_cnt 		= s_i_d_cnt + s_i_w_cnt + s_i_t_cnt + s_i_m_cnt + s_i_q_cnt + s_i_h_cnt + s_i_y_cnt + s_i_o_cnt;
				s_i_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				s_i_tot_cnt 	= s_i_b_cnt + s_i_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("F")){
				s_f_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				s_f_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				s_f_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				s_f_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				s_f_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				s_f_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				s_f_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				s_f_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				s_f_b_cnt 		= s_f_d_cnt + s_f_w_cnt + s_f_t_cnt + s_f_m_cnt + s_f_q_cnt + s_f_h_cnt + s_f_y_cnt + s_f_o_cnt;
				s_f_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				s_f_tot_cnt 	= s_f_b_cnt + s_f_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("S")){
				s_s_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				s_s_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				s_s_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				s_s_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				s_s_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				s_s_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				s_s_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				s_s_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				s_s_b_cnt 		= s_s_d_cnt + s_s_w_cnt + s_s_t_cnt + s_s_m_cnt + s_s_q_cnt + s_s_h_cnt + s_s_y_cnt + s_s_o_cnt;
				s_s_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				s_s_tot_cnt 	= s_s_b_cnt + s_s_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("D")){
				s_d_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				s_d_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				s_d_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				s_d_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				s_d_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				s_d_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				s_d_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				s_d_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				s_d_b_cnt 		= s_d_d_cnt + s_d_w_cnt + s_d_t_cnt + s_d_m_cnt + s_d_q_cnt + s_d_h_cnt + s_d_y_cnt + s_d_o_cnt;
				s_d_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				s_d_tot_cnt 	= s_d_b_cnt + s_d_s_cnt;
			}
		}else if(activeJobBean.getSystem_gubun() != null && activeJobBean.getSystem_gubun().equals("D")){
			d_d_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));                                 
			d_w_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));                                 
			d_t_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));                                 
			d_m_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));                                 
			d_q_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));                                 
			d_h_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));                                 
			d_y_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));                                 
			d_o_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));                                 
			d_b_cnt 	   = d_d_cnt + d_w_cnt + d_t_cnt + d_m_cnt + d_q_cnt + d_h_cnt + d_y_cnt + d_o_cnt; 
			d_s_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));                                 
			d_tot_cnt      = d_b_cnt + d_s_cnt;                                                                         
			                                                                                                                
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("B")){
				d_b_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				d_b_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				d_b_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				d_b_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				d_b_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				d_b_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				d_b_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				d_b_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				d_b_b_cnt 		= d_b_d_cnt + d_b_w_cnt + d_b_t_cnt + d_b_m_cnt + d_b_q_cnt + d_b_h_cnt + d_b_y_cnt + d_b_o_cnt;
				d_b_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				d_b_tot_cnt 	= d_b_b_cnt + d_b_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("I")){
				d_i_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				d_i_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				d_i_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				d_i_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				d_i_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				d_i_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				d_i_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				d_i_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				d_i_b_cnt 		= d_i_d_cnt + d_i_w_cnt + d_i_t_cnt + d_i_m_cnt + d_i_q_cnt + d_i_h_cnt + d_i_y_cnt + d_i_o_cnt;
				d_i_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				d_i_tot_cnt 	= d_i_b_cnt + d_i_d_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("F")){
				d_f_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				d_f_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				d_f_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				d_f_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				d_f_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				d_f_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				d_f_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				d_f_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				d_f_b_cnt 		= d_f_d_cnt + d_f_w_cnt + d_f_t_cnt + d_f_m_cnt + d_f_q_cnt + d_f_h_cnt + d_f_y_cnt + d_f_o_cnt;
				d_f_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				d_f_tot_cnt 	= d_f_b_cnt + d_f_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("S")){
				d_s_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				d_s_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				d_s_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				d_s_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				d_s_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				d_s_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				d_s_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				d_s_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				d_s_b_cnt 		= d_s_d_cnt + d_s_w_cnt + d_s_t_cnt + d_s_m_cnt + d_s_q_cnt + d_s_h_cnt + d_s_y_cnt + d_s_o_cnt;
				d_s_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				d_s_tot_cnt 	= d_s_b_cnt + d_s_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("D")){
				d_d_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				d_d_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				d_d_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				d_d_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				d_d_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				d_d_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				d_d_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				d_d_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				d_d_b_cnt 		= d_d_d_cnt + d_d_w_cnt + d_d_t_cnt + d_d_m_cnt + d_d_q_cnt + d_d_h_cnt + d_d_y_cnt + d_d_o_cnt;
				d_d_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				d_d_tot_cnt 	= d_d_b_cnt + d_d_s_cnt;
			}
		}else if(activeJobBean.getSystem_gubun() != null && activeJobBean.getSystem_gubun().equals("M")){
			m_d_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));                                 
			m_w_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));                                 
			m_t_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));                                 
			m_m_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));                                 
			m_q_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));                                 
			m_h_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));                                 
			m_y_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));                                 
			m_o_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));                                 
			m_b_cnt 	   = m_d_cnt + m_w_cnt + m_t_cnt + m_m_cnt + m_q_cnt + m_h_cnt + m_y_cnt + m_o_cnt; 
			m_s_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));                                 
			m_tot_cnt      = m_b_cnt + m_s_cnt;                                                                         
			                                                                                                                
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("B")){
				m_b_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				m_b_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				m_b_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				m_b_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				m_b_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				m_b_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				m_b_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				m_b_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				m_b_b_cnt 		= m_b_d_cnt + m_b_w_cnt + m_b_t_cnt + m_b_m_cnt + m_b_q_cnt + m_b_h_cnt + m_b_y_cnt + m_b_o_cnt;
				m_b_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				m_b_tot_cnt 	= m_b_b_cnt + m_b_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("I")){
				m_i_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				m_i_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				m_i_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				m_i_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				m_i_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				m_i_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				m_i_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				m_i_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				m_i_b_cnt 		= m_i_d_cnt + m_i_w_cnt + m_i_t_cnt + m_i_m_cnt + m_i_q_cnt + m_i_h_cnt + m_i_y_cnt + m_i_o_cnt;
				m_i_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				m_i_tot_cnt 	= m_i_b_cnt + m_i_d_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("F")){
				m_f_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				m_f_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				m_f_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				m_f_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				m_f_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				m_f_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				m_f_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				m_f_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				m_f_b_cnt 		= m_f_d_cnt + m_f_w_cnt + m_f_t_cnt + m_f_m_cnt + m_f_q_cnt + m_f_h_cnt + m_f_y_cnt + m_f_o_cnt;
				m_f_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				m_f_tot_cnt 	= m_f_b_cnt + m_f_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("S")){
				m_s_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				m_s_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				m_s_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				m_s_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				m_s_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				m_s_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				m_s_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				m_s_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				m_s_b_cnt 		= m_s_d_cnt + m_s_w_cnt + m_s_t_cnt + m_s_m_cnt + m_s_q_cnt + m_s_h_cnt + m_s_y_cnt + m_s_o_cnt;
				m_s_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				m_s_tot_cnt 	= m_s_b_cnt + m_s_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("D")){
				m_d_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				m_d_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				m_d_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				m_d_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				m_d_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				m_d_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				m_d_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				m_d_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				m_d_b_cnt 		= m_d_d_cnt + m_d_w_cnt + m_d_t_cnt + m_d_m_cnt + m_d_q_cnt + m_d_h_cnt + m_d_y_cnt + m_d_o_cnt;
				m_d_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				m_d_tot_cnt 	= m_d_b_cnt + m_d_s_cnt;
			}
		}else if(activeJobBean.getSystem_gubun() != null && activeJobBean.getSystem_gubun().equals("U")){
			u_d_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));                                 
			u_w_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));                                 
			u_t_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));                                 
			u_m_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));                                 
			u_q_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));                                 
			u_h_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));                                 
			u_y_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));                                 
			u_o_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));                                 
			u_b_cnt 	   = u_d_cnt + u_w_cnt + u_t_cnt + u_m_cnt + u_q_cnt + u_h_cnt + u_y_cnt + u_o_cnt; 
			u_s_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));                                 
			u_tot_cnt      = u_b_cnt + u_s_cnt;                                                                         
			                                                                                                                
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("B")){
				u_b_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				u_b_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				u_b_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				u_b_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				u_b_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				u_b_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				u_b_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				u_b_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				u_b_b_cnt 		= u_b_d_cnt + u_b_w_cnt + u_b_t_cnt + u_b_m_cnt + u_b_q_cnt + u_b_h_cnt + u_b_y_cnt + u_b_o_cnt;
				u_b_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				u_b_tot_cnt 	= u_b_b_cnt + u_b_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("I")){
				u_i_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				u_i_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				u_i_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				u_i_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				u_i_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				u_i_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				u_i_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				u_i_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				u_i_b_cnt 		= u_i_d_cnt + u_i_w_cnt + u_i_t_cnt + u_i_m_cnt + u_i_q_cnt + u_i_h_cnt + u_i_y_cnt + u_i_o_cnt;
				u_i_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				u_i_tot_cnt 	= u_i_b_cnt + u_i_d_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("F")){
				u_f_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				u_f_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				u_f_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				u_f_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				u_f_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				u_f_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				u_f_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				u_f_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				u_f_b_cnt 		= u_f_d_cnt + u_f_w_cnt + u_f_t_cnt + u_f_m_cnt + u_f_q_cnt + u_f_h_cnt + u_f_y_cnt + u_f_o_cnt;
				u_f_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				u_f_tot_cnt 	= u_f_b_cnt + u_f_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("S")){
				u_s_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				u_s_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				u_s_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				u_s_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				u_s_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				u_s_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				u_s_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				u_s_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				u_s_b_cnt 		= u_s_d_cnt + u_s_w_cnt + u_s_t_cnt + u_s_m_cnt + u_s_q_cnt + u_s_h_cnt + u_s_y_cnt + u_s_o_cnt;
				u_s_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				u_s_tot_cnt 	= u_s_b_cnt + u_s_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("D")){
				u_d_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				u_d_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				u_d_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				u_d_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				u_d_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				u_d_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				u_d_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				u_d_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				u_d_b_cnt 		= u_d_d_cnt + u_d_w_cnt + u_d_t_cnt + u_d_m_cnt + u_d_q_cnt + u_d_h_cnt + u_d_y_cnt + u_d_o_cnt;
				u_d_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				u_d_tot_cnt 	= u_d_b_cnt + u_d_s_cnt;
			}
		}else if(activeJobBean.getSystem_gubun() != null && activeJobBean.getSystem_gubun().equals("P")){
			p_d_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));                                 
			p_w_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));                                 
			p_t_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));                                 
			p_m_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));                                 
			p_q_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));                                 
			p_h_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));                                 
			p_y_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));                                 
			p_o_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));                                 
			p_b_cnt 	   = p_d_cnt + p_w_cnt + p_t_cnt + p_m_cnt + p_q_cnt + p_h_cnt + p_y_cnt + p_o_cnt; 
			p_s_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));                                 
			p_tot_cnt      = p_b_cnt + p_s_cnt;                                                                         
			                                                                                                                
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("B")){
				p_b_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				p_b_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				p_b_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				p_b_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				p_b_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				p_b_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				p_b_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				p_b_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				p_b_b_cnt 		= p_b_d_cnt + p_b_w_cnt + p_b_t_cnt + p_b_m_cnt + p_b_q_cnt + p_b_h_cnt + p_b_y_cnt + p_b_o_cnt;
				p_b_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				p_b_tot_cnt 	= p_b_b_cnt + p_b_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("I")){
				p_i_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				p_i_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				p_i_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				p_i_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				p_i_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				p_i_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				p_i_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				p_i_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				p_i_b_cnt 		= p_i_d_cnt + p_i_w_cnt + p_i_t_cnt + p_i_m_cnt + p_i_q_cnt + p_i_h_cnt + p_i_y_cnt + p_i_o_cnt;
				p_i_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				p_i_tot_cnt 	= p_i_b_cnt + p_i_d_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("F")){
				p_f_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				p_f_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				p_f_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				p_f_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				p_f_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				p_f_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				p_f_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				p_f_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				p_f_b_cnt 		= p_f_d_cnt + p_f_w_cnt + p_f_t_cnt + p_f_m_cnt + p_f_q_cnt + p_f_h_cnt + p_f_y_cnt + p_f_o_cnt;
				p_f_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				p_f_tot_cnt 	= p_f_b_cnt + p_f_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("S")){
				p_s_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				p_s_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				p_s_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				p_s_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				p_s_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				p_s_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				p_s_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				p_s_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				p_s_b_cnt 		= p_s_d_cnt + p_s_w_cnt + p_s_t_cnt + p_s_m_cnt + p_s_q_cnt + p_s_h_cnt + p_s_y_cnt + p_s_o_cnt;
				p_s_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				p_s_tot_cnt 	= p_s_b_cnt + p_s_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("D")){
				p_d_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				p_d_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				p_d_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				p_d_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				p_d_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				p_d_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				p_d_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				p_d_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				p_d_b_cnt 		= p_d_d_cnt + p_d_w_cnt + p_d_t_cnt + p_d_m_cnt + p_d_q_cnt + p_d_h_cnt + p_d_y_cnt + p_d_o_cnt;
				p_d_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				p_d_tot_cnt 	= p_d_b_cnt + p_d_s_cnt;
			}
		}else{
			etc_d_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));                                 
			etc_w_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));                                 
			etc_t_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));                                 
			etc_m_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));                                 
			etc_q_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));                                 
			etc_h_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));                                 
			etc_y_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));                                 
			etc_o_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));                                 
			etc_b_cnt 	   = etc_d_cnt + etc_w_cnt + etc_t_cnt + etc_m_cnt + etc_q_cnt + etc_h_cnt + etc_y_cnt + etc_o_cnt; 
			etc_s_cnt 	   += Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));                                 
			etc_tot_cnt      = etc_b_cnt + etc_s_cnt;                                                                         
			                                                                                                                
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("B")){
				etc_b_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				etc_b_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				etc_b_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				etc_b_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				etc_b_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				etc_b_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				etc_b_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				etc_b_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				etc_b_b_cnt 		= etc_b_d_cnt + etc_b_w_cnt + etc_b_t_cnt + etc_b_m_cnt + etc_b_q_cnt + etc_b_h_cnt + etc_b_y_cnt + etc_b_o_cnt;
				etc_b_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				etc_b_tot_cnt 	= etc_b_b_cnt + etc_b_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("I")){
				etc_i_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				etc_i_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				etc_i_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				etc_i_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				etc_i_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				etc_i_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				etc_i_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				etc_i_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				etc_i_b_cnt 		= etc_i_d_cnt + etc_i_w_cnt + etc_i_t_cnt + etc_i_m_cnt + etc_i_q_cnt + etc_i_h_cnt + etc_i_y_cnt + etc_i_o_cnt;
				etc_i_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				etc_i_tot_cnt 	= etc_i_b_cnt + etc_i_d_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("F")){
				etc_f_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				etc_f_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				etc_f_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				etc_f_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				etc_f_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				etc_f_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				etc_f_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				etc_f_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				etc_f_b_cnt 		= etc_f_d_cnt + etc_f_w_cnt + etc_f_t_cnt + etc_f_m_cnt + etc_f_q_cnt + etc_f_h_cnt + etc_f_y_cnt + etc_f_o_cnt;
				etc_f_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				etc_f_tot_cnt 	= etc_f_b_cnt + etc_f_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("S")){
				etc_s_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				etc_s_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				etc_s_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				etc_s_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				etc_s_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				etc_s_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				etc_s_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				etc_s_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				etc_s_b_cnt 		= etc_s_d_cnt + etc_s_w_cnt + etc_s_t_cnt + etc_s_m_cnt + etc_s_q_cnt + etc_s_h_cnt + etc_s_y_cnt + etc_s_o_cnt;
				etc_s_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				etc_s_tot_cnt 	= etc_s_b_cnt + etc_s_s_cnt;
			}
			
			if(activeJobBean.getType_gubun() != null && activeJobBean.getType_gubun().equals("D")){
				etc_d_d_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getD_cnt()));
				etc_d_w_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getW_cnt()));
				etc_d_t_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getT_cnt()));
				etc_d_m_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getM_cnt()));
				etc_d_q_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getQ_cnt()));
				etc_d_h_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getH_cnt()));
				etc_d_y_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getY_cnt()));
				etc_d_o_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getO_cnt()));
				etc_d_b_cnt 		= etc_d_d_cnt + etc_d_w_cnt + etc_d_t_cnt + etc_d_m_cnt + etc_d_q_cnt + etc_d_h_cnt + etc_d_y_cnt + etc_d_o_cnt;
				etc_d_s_cnt 		= Integer.parseInt(CommonUtil.isNull(activeJobBean.getS_cnt()));
				etc_d_tot_cnt 	= etc_d_b_cnt + etc_d_s_cnt;
			}
		}
	}
	out.println("<script type='text/javascript'>");
	out.println("try{viewProgBar(true);}catch(e){}");
	out.println("$('#if1').on('mousewheel', function(){");
	out.println("alert();");
	out.println("$('#if1').prop('height','64%');");
	out.println("});");
	out.println("</script>");
%>
<div style="width:100%; height:100%; overflow-x:hidden; overflow-y:scroll;">
<form id="f_s" name="f_s" method="post" onsubmit="return false;">	

</form>

<table style='width:100%;height:60%;'>
	<tr>
		<td valign="top">
			<table style="width:100%; text-align:center;">
				<tr>
					<td width="250" rowspan="2" colspan="2" class='cellTitle_kang2'>
						구분
					</td>
					<td width="200" colspan="9" class='cellTitle_kang2'>
						정기
					</td>
					<td width="200" colspan="1" class='cellTitle_kang2'>
						비정기
					</td>
					<td width="250" rowspan="2" colspan="2" class='cellTitle_kang2'>
						합계
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							일별[D]
					</td>
					<td width="200" class='cellTitle_kang2'>
							주별[W]
					</td>
					<td width="200" class='cellTitle_kang2'>
							10일단위[T]
					</td>
					<td width="200" class='cellTitle_kang2'>
							월별[M]
					</td>
					<td width="200" class='cellTitle_kang2'>
							분기[Q]
					</td>
					<td width="200" class='cellTitle_kang2'>
							반기[H]
					</td>
					<td width="200" class='cellTitle_kang2'>
							년[Y]
					</td>
					<td width="200" class='cellTitle_kang2'>
							오픈Open[O]
					</td>
					<td width="200" class='cellTitle_kang2'>
							소계
					</td>
					<td width="200" class='cellTitle_kang2'>
							비정기(Ondemand)[S]
					</td>
				
				</tr>
				<tr>
					<td width="250" rowspan="6" class='cellTitle_kang2'>
							계정계[C]
					</td>
				</tr>
				
				<tr>
					<td width="250" class='cellTitle_kang2'>
						 	Batch Job [B]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_b_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_b_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_b_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_b_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_b_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_b_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_b_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_b_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_b_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_b_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_b_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Interface Job [I]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_i_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_i_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_i_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_i_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_i_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_i_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_i_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_i_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_i_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_i_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_i_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							FileWatcher Job [F]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_f_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_f_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_f_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_f_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_f_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_f_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_f_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_f_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_f_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_f_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_f_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Sorting Job [S]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_s_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_s_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_s_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_s_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_s_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_s_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_s_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_s_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_s_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_s_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_s_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Dummy Job [D]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_d_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_d_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_d_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_d_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_d_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_d_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_d_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_d_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_d_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_d_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_d_tot_cnt %>
					</td>
				</tr>
				<tr style="border-top:2px solid black;border-bottom:2px solid black;border-left:2px solid black;border-right:2px solid black;">
					<td width="200" colspan="2" class='cellTitle_kang2'>
						소계
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=c_tot_cnt %>
					</td>
				</tr>
				 <tr>
					<td width="250" rowspan="6" class='cellTitle_kang2'>
							정보계[A]<br/>(ADW)
					</td>
				</tr>
				
				<tr>
					<td width="250" class='cellTitle_kang2'>
						 	Batch Job [B]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_b_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_b_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_b_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_b_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_b_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_b_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_b_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_b_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_b_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_b_a_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_b_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Interface Job [I]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_i_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_i_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_i_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_i_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_i_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_i_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_i_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_i_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_i_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_i_a_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_i_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							FileWatcher Job [F]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_f_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_f_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_f_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_f_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_f_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_f_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_f_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_f_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_f_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_f_a_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_f_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Sorting Job [S]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_a_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_a_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_a_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_a_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_a_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_a_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_a_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_a_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_a_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_a_a_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_a_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Dummy Job [D]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_d_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_d_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_d_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_d_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_d_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_d_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_d_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_d_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_d_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_d_a_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_d_tot_cnt %>
					</td>
				</tr>
				<tr style="border-top:2px solid black;border-bottom:2px solid black;border-left:2px solid black;border-right:2px solid black;">
					<td width="200" colspan="2" class='cellTitle_kang2'>
						소계
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_a_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=a_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="250" rowspan="6" class='cellTitle_kang2'>
							정보계[R]<br/>(RDW)
					</td>
				</tr>
				
				<tr>
					<td width="250" class='cellTitle_kang2'>
						 	Batch Job [B]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_b_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_b_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_b_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_b_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_b_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_b_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_b_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_b_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_b_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_b_r_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_b_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Interface Job [I]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_i_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_i_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_i_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_i_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_i_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_i_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_i_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_i_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_i_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_i_r_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_i_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							FileWatcher Job [F]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_f_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_f_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_f_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_f_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_f_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_f_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_f_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_f_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_f_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_f_r_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_f_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Sorting Job [S]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_r_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_r_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_r_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_r_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_r_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_r_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_r_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_r_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_r_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_r_r_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_r_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Dummy Job [D]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_d_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_d_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_d_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_d_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_d_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_d_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_d_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_d_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_d_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_d_r_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_d_tot_cnt %>
					</td>
				</tr>
				<tr style="border-top:2px solid black;border-bottom:2px solid black;border-left:2px solid black;border-right:2px solid black;">
					<td width="200" colspan="2" class='cellTitle_kang2'>
						소계
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_r_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=r_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="250" rowspan="6" class='cellTitle_kang2'>
							정보계[S]<br/>(세일즈마케팅)
					</td>
				</tr>
				
				<tr>
					<td width="250" class='cellTitle_kang2'>
						 	Batch Job [B]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_b_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_b_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_b_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_b_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_b_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_b_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_b_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_b_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_b_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_b_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_b_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Interface Job [I]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_i_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_i_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_i_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_i_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_i_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_i_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_i_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_i_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_i_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_i_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_i_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							FileWatcher Job [F]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_f_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_f_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_f_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_f_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_f_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_f_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_f_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_f_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_f_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_f_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_f_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Sorting Job [S]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_s_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_s_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_s_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_s_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_s_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_s_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_s_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_s_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_s_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_s_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_s_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Dummy Job [D]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_d_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_d_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_d_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_d_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_d_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_d_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_d_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_d_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_d_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_d_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_d_tot_cnt %>
					</td>
				</tr>
				<tr style="border-top:2px solid black;border-bottom:2px solid black;border-left:2px solid black;border-right:2px solid black;">
					<td width="200" colspan="2" class='cellTitle_kang2'>
						소계
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=s_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="250" rowspan="6" class='cellTitle_kang2'>
							전일자배치[D]
					</td>
				</tr>
				
				<tr>
					<td width="250" class='cellTitle_kang2'>
						 	Batch Job [B]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_b_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_b_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_b_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_b_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_b_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_b_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_b_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_b_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_b_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_b_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_b_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Interface Job [I]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_i_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_i_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_i_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_i_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_i_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_i_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_i_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_i_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_i_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_i_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_i_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							FileWatcher Job [F]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_f_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_f_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_f_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_f_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_f_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_f_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_f_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_f_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_f_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_f_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_f_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Sorting Job [S]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_s_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_s_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_s_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_s_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_s_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_s_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_s_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_s_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_s_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_s_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_s_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Dummy Job [D]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_d_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_d_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_d_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_d_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_d_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_d_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_d_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_d_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_d_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_d_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_d_tot_cnt %>
					</td>
				</tr>
				<tr style="border-top:2px solid black;border-bottom:2px solid black;border-left:2px solid black;border-right:2px solid black;">
					<td width="200" colspan="2" class='cellTitle_kang2'>
						소계
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=d_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="250" rowspan="6" class='cellTitle_kang2'>
							월말배치[M]
					</td>
				</tr>
				
				<tr>
					<td width="250" class='cellTitle_kang2'>
						 	Batch Job [B]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_b_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_b_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_b_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_b_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_b_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_b_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_b_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_b_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_b_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_b_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_b_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Interface Job [I]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_i_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_i_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_i_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_i_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_i_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_i_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_i_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_i_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_i_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_i_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_i_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							FileWatcher Job [F]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_f_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_f_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_f_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_f_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_f_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_f_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_f_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_f_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_f_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_f_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_f_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Sorting Job [S]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_s_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_s_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_s_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_s_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_s_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_s_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_s_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_s_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_s_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_s_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_s_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Dummy Job [D]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_d_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_d_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_d_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_d_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_d_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_d_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_d_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_d_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_d_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_d_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_d_tot_cnt %>
					</td>
				</tr>
				<tr style="border-top:2px solid black;border-bottom:2px solid black;border-left:2px solid black;border-right:2px solid black;">
					<td width="200" colspan="2" class='cellTitle_kang2'>
						소계
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=m_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="250" rowspan="6" class='cellTitle_kang2'>
							전문가시스템[U]
					</td>
				</tr>
				
				<tr>
					<td width="250" class='cellTitle_kang2'>
						 	Batch Job [B]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_b_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_b_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_b_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_b_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_b_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_b_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_b_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_b_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_b_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_b_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_b_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Interface Job [I]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_i_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_i_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_i_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_i_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_i_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_i_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_i_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_i_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_i_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_i_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_i_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							FileWatcher Job [F]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_f_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_f_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_f_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_f_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_f_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_f_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_f_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_f_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_f_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_f_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_f_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Sorting Job [S]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_s_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_s_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_s_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_s_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_s_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_s_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_s_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_s_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_s_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_s_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_s_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Dummy Job [D]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_d_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_d_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_d_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_d_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_d_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_d_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_d_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_d_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_d_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_d_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_d_tot_cnt %>
					</td>
				</tr>
				<tr style="border-top:2px solid black;border-bottom:2px solid black;border-left:2px solid black;border-right:2px solid black;">
					<td width="200" colspan="2" class='cellTitle_kang2'>
						소계
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=u_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="250" rowspan="6" class='cellTitle_kang2'>
							카드[P]
					</td>
				</tr>
				
				<tr>
					<td width="250" class='cellTitle_kang2'>
						 	Batch Job [B]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_b_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_b_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_b_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_b_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_b_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_b_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_b_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_b_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_b_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_b_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_b_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Interface Job [I]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_i_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_i_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_i_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_i_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_i_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_i_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_i_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_i_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_i_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_i_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_i_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							FileWatcher Job [F]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_f_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_f_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_f_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_f_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_f_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_f_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_f_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_f_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_f_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_f_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_f_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Sorting Job [S]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_s_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_s_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_s_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_s_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_s_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_s_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_s_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_s_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_s_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_s_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_s_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Dummy Job [D]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_d_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_d_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_d_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_d_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_d_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_d_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_d_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_d_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_d_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_d_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_d_tot_cnt %>
					</td>
				</tr>
				<tr style="border-top:2px solid black;border-bottom:2px solid black;border-left:2px solid black;border-right:2px solid black;">
					<td width="200" colspan="2" class='cellTitle_kang2'>
						소계
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=p_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="250" rowspan="6" class='cellTitle_kang2'>
							기타
					</td>
				</tr>
				
				<tr>
					<td width="250" class='cellTitle_kang2'>
						 	Batch Job [B]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_b_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_b_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_b_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_b_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_b_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_b_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_b_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_b_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_b_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_b_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_b_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Interface Job [I]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_i_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_i_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_i_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_i_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_i_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_i_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_i_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_i_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_i_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_i_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_i_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							FileWatcher Job [F]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_f_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_f_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_f_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_f_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_f_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_f_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_f_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_f_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_f_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_f_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_f_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Sorting Job [S]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_s_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_s_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_s_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_s_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_s_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_s_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_s_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_s_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_s_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_s_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_s_tot_cnt %>
					</td>
				</tr>
				<tr>
					<td width="200" class='cellTitle_kang2'>
							Dummy Job [D]
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_d_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_d_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_d_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_d_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_d_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_d_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_d_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_d_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_d_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_d_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_d_tot_cnt %>
					</td>
				</tr>
				<tr style="border-top:2px solid black;border-bottom:2px solid black;border-left:2px solid black;border-right:2px solid black;">
					<td width="200" colspan="2" class='cellTitle_kang2'>
						소계
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_d_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_w_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_t_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_m_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_q_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_h_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_y_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_o_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_b_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_s_cnt %>
					</td>
					<td width="200" class='cellContent_kang'>
							<%=etc_tot_cnt %>
					</td>
				</tr>
			</table>   
		</td>
	</tr>
</table>
</div>
<%@include file="/jsp/common/inc/progBar.jsp"  %>
