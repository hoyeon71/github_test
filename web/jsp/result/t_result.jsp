﻿<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/jsp/common/inc/header.jsp"%>

<%
  response.setHeader("Cache-Control","no-store"); //HTTP 1.1
  response.setHeader("Pragma","no-cache"); //HTTP 1.0
  response.setDateHeader ("Expires", 0);
%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	String c 				= CommonUtil.isNull(paramMap.get("c"));
	String rc 				= CommonUtil.isNull(paramMap.get("rc"));
    String tabId 			= CommonUtil.isNull(paramMap.get("tabId"));

	String currentPage 		= CommonUtil.isNull(paramMap.get("currentPage"));
	String jobgroup_id 		= CommonUtil.isNull(paramMap.get("jobgroup_id"));
	String s_state_cd 		= CommonUtil.isNull(paramMap.get("s_state_cd"));
	String odate 			= CommonUtil.isNull(paramMap.get("odate"));
	String strFlag 			= CommonUtil.isNull(paramMap.get("flag"));
	String strFlag2 		= CommonUtil.isNull(paramMap.get("flag2"));
	String strGb 			= CommonUtil.isNull(paramMap.get("gb"));
	String strDataCenter 	= CommonUtil.isNull(paramMap.get("data_center"));
	String strJob 			= CommonUtil.isNull(paramMap.get("job"));
    String strJob_name		= CommonUtil.isNull(paramMap.get("job_name"));
	String strMcode 		= CommonUtil.isNull(paramMap.get("mcode_cd"));
	String strDocGb 		= CommonUtil.isNull(paramMap.get("doc_gb"));
	String task_type 		= CommonUtil.isNull(paramMap.get("task_type"));
    String grp_doc_gb 		= CommonUtil.isNull(paramMap.get("grp_doc_gb"));

	// 목록 화면 검색 파라미터.
	String search_data_center 	= CommonUtil.isNull(paramMap.get("search_data_center"));
	String search_state_cd 		= CommonUtil.isNull(paramMap.get("search_state_cd"));
    String search_apply_cd 	    = CommonUtil.isNull(paramMap.get("search_apply_cd"));
	String search_gb 			= CommonUtil.isNull(paramMap.get("search_gb"));
	String search_text 			= CommonUtil.isNull(paramMap.get("search_text"));
	String search_date_gubun 	= CommonUtil.isNull(paramMap.get("search_date_gubun"));
	String search_s_search_date = CommonUtil.isNull(paramMap.get("search_s_search_date"));
	String search_e_search_date = CommonUtil.isNull(paramMap.get("search_e_search_date"));
	String search_s_search_date2 = CommonUtil.isNull(paramMap.get("search_s_search_date2"));
	String search_e_search_date2 = CommonUtil.isNull(paramMap.get("search_e_search_date2"));
	String search_task_nm 		= CommonUtil.isNull(paramMap.get("search_task_nm"));
	String search_moneybatchjob	= CommonUtil.isNull(paramMap.get("search_moneybatchjob"));
	String search_critical		= CommonUtil.isNull(paramMap.get("search_critical"));
    String search_approval_state	= CommonUtil.isNull(paramMap.get("search_approval_state"));
    String search_check_approval_yn	= CommonUtil.isNull(paramMap.get("search_check_approval_yn"));
    String doc_group_id 	     = CommonUtil.isNull(paramMap.get("doc_group_id"));
    String doc_cnt			     = CommonUtil.isNull(paramMap.get("doc_cnt"));

    System.out.println("c : " + c);
    
 	//js version 추가하여 캐시 새로고침
  	String jsVersion = CommonUtil.getMessage("js_version");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<script type="text/javascript" src="<%=sContextPath %>/js/common.js" ></script>
<script type="text/javascript" src="<%=sContextPath %>/js/jquery-1.9.0.min.js"></script>
<script type="text/javascript" src="<%=sContextPath %>/js/works_common.js?v=<%=jsVersion %>" ></script>

<script type="text/javascript" >
<!--

//-->
</script>
</head>

<body>

<%   
   Map rMap       = (Map)request.getAttribute("rMap");
   String r_code    = CommonUtil.isNull(rMap.get("r_code"));
   String r_doc_cd   = CommonUtil.isNull(rMap.get("doc_cd"));
  
   String r_msg    = "";
   
   if("-2".equals(r_code)){
      r_msg = CommonUtil.isNull(rMap.get("r_msg"));
      r_msg = r_msg.replaceAll("\"","").replaceAll("'","");
   }else{
      // 일괄결재일 경우.
      if ( c.equals("ez016") || c.equals("groupApproval")|| c.equals("ez036")|| c.equals("ez021_jg") || c.equals("ez006_order_p") || c.equals("ez038_p") || c.equals("ez039_p") ) {
         r_msg = CommonUtil.isNull(rMap.get("r_msg"));

      // UTIL 호출일 경우 & 상태변경 관리자즉시결재
      } else if ( c.equals("ez033_p") ) {
         
         r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
         
         if ( r_msg.equals("") ) {
            r_msg = CommonUtil.isNull(rMap.get("r_msg"));
         }
         
      } else {
         r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
         
         if ( r_msg.equals("") ) {
            r_msg = CommonUtil.isNull(rMap.get("r_msg"));
         }

      }
   }
   
   // BPI를 API로 바꾸면서 새로 만든 에러 메세지. (2013/02/21 강명준)
   // 특수문자 중에 홑따옴표가 있는 문구가 있어서 특수문자 처리 해줌.
   String strErrorMsg = CommonUtil.isNull(rMap.get("rMsg"));
   if ( !strErrorMsg.equals("") ) {
      r_msg = strErrorMsg;
      r_msg = r_msg.replaceAll("\'", "\\\\'");
   } else {
		// 특수문자 중에 홑따옴표가 있는 문구가 있어서 특수문자 처리 해줌. (2022/11/01 강명준)
	  	r_msg = r_msg.replaceAll("\'", "\\\\'");
   }
   
   r_msg = r_msg.replaceAll("\r\n", "");
   r_msg = r_msg.replaceAll("\n", "\\\\n");
   
   // DOC_CD PK 오류일 경우 에러 메시지를 가공해 준다.
   if ( r_msg.indexOf("PK_EZ_DOC_MASTER") > -1 ) {
      r_msg = "처리 실패 [다른 사용자와 동시에 처리 요청]\\n다시 시도해 주세요.";
   } 
   
   // FORCE가 아니어서 작업 오더가 안되는 에러 메시지를 가공해 준다.
   if ( r_msg.indexOf("(scheduling criteria are not met)") > -1 ) {
      r_msg = r_msg.replaceAll("scheduling criteria are not met", "");
      r_msg = r_msg.replaceAll("\\(", "").replaceAll("\\)", "");
      r_msg += "\\n재작업 실패 - 스케줄과 FORCE 옵션을 확인해 주세요.";
   }
   //tabId를 통해 리프레쉬할 메뉴 체크
   String menu_gb_c = "";
   String menu_nm = "";
   if(tabId.equals("0390")){
      menu_gb_c = "ez005";
      menu_nm = "결재문서함";
   }else if( (tabId.equals("0399") || tabId.equals("99999")) && !(strFlag.equals("ins") || strFlag.equals("udt"))){
      menu_gb_c = "ez004";
      menu_nm = "요청문서함";
   }else if( (strFlag.equals("ins") || strFlag.equals("udt")) || (tabId.equals("99999") && !strFlag.equals("draft_admin")) || c.equals("ez032_p")){
      menu_nm = CommonUtil.getMessage("DOC.GB."+strDocGb) + "_상세";
      if(strDocGb.equals("05") && !doc_cnt.equals("0")){
         menu_nm = CommonUtil.getMessage("DOC.GB."+strDocGb+"G") + "_상세";
      }
   }else{
      tabId = "0399";
      menu_gb_c = "ez004";
      menu_nm = "요청문서함";
   }

   if( c.equals("ez008_p") || c.equals("ez014_p") || c.equals("ez022_p") || c.equals("ez041_p") ){
      out.println("<script type='text/javascript'>");
            
      if("1".equals(r_code)){
         out.println("alert('"+r_msg+"');");
                        
         if(strGb.equals("dept")){
            out.println("parent.deptList();");
         }else if(strGb.equals("duty")){
            out.println("parent.dutyList();");
         }else if(strGb.equals("M")){
            out.println("parent.mCodeList();");
         }else if(strGb.equals("S")){
            out.println("parent.sCodeList('"+strMcode+"');");
         }else{
            out.println("parent.finalAppLineList();");
         }
         
      }else{
         out.println("alert('"+r_msg+"');");   
      }
      out.println("</script>");
   } else if( c.equals("ez002_p") || c.equals("ez002_all_p") || c.equals("ez002_role_p") || c.equals("ez002_account_lock_init") || c.equals("ez002_pw_init")){
      out.println("<script type='text/javascript'>");
      
      if(r_code.equals("1")){
         out.println("alert('"+r_msg+"');");
         if(strFlag.equals("udt_auth")){
            out.println("parent.dlClose('dl_tmp_auth');");
            out.println("parent.userList();");
            out.println("try{viewProgBar(false);}catch(e){console.error(e);}");
		}else if(strFlag.equals("folder_auth") || strFlag.equals("user_folder_auth")){
			out.println("parent.dlClose('cmAppGrpCode');");
            out.println("parent.userList();");
            out.println("try{viewProgBar(false);}catch(e){console.error(e);}");
         }else if(strFlag.equals("ins_copy")||strFlag.equals("del_copy")){
            out.println("try{parent.viewProgBar(false);}catch(e){console.log(e.message);}");
            out.println("if( typeof parent.folderAppGrpList == 'function' ) parent.folderAppGrpList(2);");
         }else if(strFlag.equals("all_folder_auth") || strFlag.equals("user_folder_auth_delete")){
        	String isMoreThanTwo = CommonUtil.isNull(rMap.get("p_isMoreThanTwo"));
        	out.println("parent.getCodeList();");
        	if(isMoreThanTwo.equals("N")) {
         		out.println("parent.getUserCodeList('"+CommonUtil.isNull(rMap.get("user_cd"))+"');");
        	}
         }else{
            out.println("parent.dlClose('dl_tmp1');");
            out.println("parent.userList();");
         }
      }else{
         out.println("alert('"+r_msg+"');");
      }
      out.println("</script>");
   } else if( c.equals("ez002_info_p") ){
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");      
      if( "1".equals(r_code) ) {
         out.println("parent.goPage();");
      } else {
         out.println("parent.location.href='"+sContextPath+"/tWorks.ez?c=ez002_edit';");
      }
      out.println("</script>");
   } else if( c.equals("ez002_pw_change") ){
	  String screenState = CommonUtil.isNull(rMap.get("screen_status"));
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
      if( "1".equals(r_code) ) {
         //out.println("location.href='"+sContextPath+"/tWorks.ez?c=ez001&login_gubun=ezjobs&user_id="+CommonUtil.isNull(paramMap.get("user_id"))+"&user_pw="+CommonUtil.isNull(paramMap.get("new_user_pw"))+"';");
         //out.println("location.href='"+sContextPath+"/common.ez?c=ez002';");
         if(screenState.equals("popup")) {
        	 out.println("window.close()");
         }else {
         	out.println("top.location.href='"+sContextPath+"/index.jsp';");
         }
      }else{
         out.println("history.back();");   
      }
      out.println("</script>");
   } else if( c.equals("ez002_pw_init") ){   // 일괄 패스워드 초기화
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
      out.println("</script>");
      
   }else if( c.equals("ez003_p") ){
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
      if( "1".equals(r_code) ) out.println("top.topFrame.goSimpleSearch('"+sContextPath+"/tWorks.ez?c=ez003'); ");
      out.println("</script>");
      
   }else if( c.equals("ez004_p") ){
      
      String strDoc_cd = CommonUtil.isNull(rMap.get("doc_cd"), CommonUtil.isNull(paramMap.get("doc_cd")));

      out.println("<form id='frm1' name='frm1' method='post' onsubmit='return false;' >");
      out.println("<input type='hidden' id='flag' name='flag' value='"+CommonUtil.isNull(rMap.get("flag"))+"' />");
      out.println("<input type='hidden' id='doc_cd' name='doc_cd' value='"+CommonUtil.isNull(rMap.get("doc_cd"))+"' />");
      out.println("</form>");
      
      out.println("<script type='text/javascript'>");
      if(strFlag.equals("v_temp_ins")){ 
   	  	if(!"1".equals(r_code) ){  
      		out.println("alert('"+r_msg+"');");
   	  	}
      }else{
   		out.println("alert('"+r_msg+"');");	  
      }
      
      // 목록 화면 검색 파라미터.
      out.println("var search_data_center       = '"+search_data_center+"';");
      out.println("var search_state_cd          = '"+search_state_cd+"';");
      out.println("var search_apply_cd          = '"+search_apply_cd+"';");
      out.println("var search_gb                = '"+search_gb+"';");
      out.println("var search_text              = '"+search_text+"';");
      out.println("var search_date_gubun        = '"+search_date_gubun+"';");
      out.println("var search_s_search_date     = '"+search_s_search_date+"';");
      out.println("var search_e_search_date     = '"+search_e_search_date+"';");
      out.println("var search_s_search_date2   	= '"+search_s_search_date2+"';");
      out.println("var search_e_search_date2   	= '"+search_e_search_date2+"';");
      out.println("var search_task_nm           = '"+search_task_nm+"';");
      out.println("var search_moneybatchjob     = '"+search_moneybatchjob+"';");
      out.println("var search_critical          = '"+search_critical+"';");
      out.println("var search_approval_state    = '"+search_approval_state+"';");
      out.println("var search_check_approval_yn = '"+search_check_approval_yn+"';");
      out.println("var tabId                	= '"+tabId+"';");
      out.println("var doc_group_id           	= '"+doc_group_id+"';");

      out.println("var search_param = '&search_data_center='+search_data_center+'&search_state_cd='+search_state_cd+'&search_apply_cd='+search_apply_cd+'&search_gb='+search_gb+'&search_text='+encodeURI(search_text)+'&search_date_gubun='+search_date_gubun+'&search_s_search_date='+search_s_search_date+'&search_e_search_date='+search_e_search_date+'&search_s_search_date2='+search_s_search_date2+'&search_e_search_date2='+search_e_search_date2+'&search_task_nm='+search_task_nm+'&search_moneybatchjob='+search_moneybatchjob+'&search_critical='+search_critical+'&search_approval_state='+search_approval_state+'&search_check_approval_yn='+search_check_approval_yn+'&tabId='+tabId");

      if ( strDocGb.equals("06")) {
    	 if(strFlag.equals("v_temp_ins")){ 
 	  	 	if(!"1".equals(r_code) ){  
	   	  		out.println("try{parent.viewProgBar(false);}catch(e){}");
	   	  	}
	     }else{
	     	out.println("try{parent.viewProgBar(false);}catch(e){}");
	     }
         if( "1".equals(r_code) ){
         
            if ( strFlag.equals("temp_ins") || strFlag.equals("detail_ins") ) {
               out.println("   parent.changeBtn('"+CommonUtil.isNull(rMap.get("doc_cd"))+"');");
            }else if(strFlag.equals("v_temp_ins")){ 
               out.println("   parent.v_changeBtn('"+CommonUtil.isNull(rMap.get("doc_cd"))+"');");
            }else {
               out.println("parent.parent.parent.doApprovalCntChk2();"); // 메인 상단의 결재건수와 동기화
			   out.println("top.closeTabsAndAddTab('tabs-0205|tabs-"+tabId+"|tabs-"+strDoc_cd+"', 'c','"+menu_nm+"','01','"+tabId+"','tWorks.ez?c="+menu_gb_c+"&menu_gb="+tabId+"&doc_gb=99&'+search_param);");
            }
         }
      }

      if ( strDocGb.equals("01") || strDocGb.equals("02") || strDocGb.equals("03") || strDocGb.equals("04") || strDocGb.equals("05")|| strDocGb.equals("07")|| strDocGb.equals("08") || strDocGb.equals("09") | strDocGb.equals("10")) {
         out.println("try{parent.viewProgBar(false);}catch(e){}");
         if ("1".equals(r_code)) {
        	out.println("parent.parent.doApprovalCntChk2();"); // 메인 상단의 결재건수와 동기화
            if (strFlag.equals("udt") || strFlag.equals("ins")) {
               if(tabId.equals("0201")){
                  out.println("top.closeTabsAndAddTab('tabs-" + tabId + "', 'c','" + menu_nm + "','01','" + strDoc_cd + "','tWorks.ez?c=ez004_m&doc_gb=" + strDocGb + "&doc_cd=" + CommonUtil.isNull(rMap.get("doc_cd")) + "&job_name=" + CommonUtil.isNull(rMap.get("job_name")) + "&state_cd=00&data_center=" + strDataCenter + "');");
               }else {
                  out.println("top.closeTabsAndAddTab('tabs-99999|tabs-"+tabId + "|tabs-" + strDoc_cd + "', 'c','" + menu_nm + "','01','" + strDoc_cd + "','tWorks.ez?c=ez004_m&doc_gb=" + strDocGb + "&doc_cd=" + CommonUtil.isNull(rMap.get("doc_cd")) + "&job_name=" + CommonUtil.isNull(rMap.get("job_name")) + "&state_cd=00&data_center=" + strDataCenter + "');");
               }
            }else {
               if (menu_gb_c.equals("") && strFlag.equals("del")) {
                  out.println("top.closeTab('tabs-" + strDoc_cd + "');");
               } else {
                  out.println("top.closeTabsAndAddTab('tabs-" + tabId + "|tabs-" + strDoc_cd + "', 'c','" + menu_nm + "','01','" + tabId + "','tWorks.ez?c=" + menu_gb_c + "&menu_gb=" + tabId + "&doc_gb=99&'+search_param);");
               }
            }
         }
      }

      out.println("if ( ('main_ins'=='"+strFlag+"' || 'detail_ins'=='"+strFlag+"') && '02'== '"+strDocGb+"' ) {");
      if(strFlag.equals("v_temp_ins")){ 
  	 	if(!"1".equals(r_code) ){  
   	  		out.println("try{parent.viewProgBar(false);}catch(e){}");
   	  	}
   	  }else{
     	out.println("try{parent.viewProgBar(false);}catch(e){}");
      }
      if( "1".equals(r_code) ){
         out.println("   parent.changeBtn('"+CommonUtil.isNull(rMap.get("doc_cd"))+"');");
      }
         
      out.println("}");
      
      if( "1".equals(r_code) ){

         out.println("if ( 'del'=='"+CommonUtil.isNull(paramMap.get("flag"))+"' && '' != '"+s_state_cd+"' ) {");
         out.println("closeTab();");
         out.println("} else {");
         out.println("   closeTab();");
         out.println("}");
            
      }
      if(strFlag.equals("v_temp_ins")){ 
  	 	if(!"1".equals(r_code) ){  
   	  		out.println("try{parent.viewProgBar(false);}catch(e){}");
   	  	}
   	  }else{
     	out.println("try{parent.viewProgBar(false);}catch(e){}");
      }
      out.println("</script>");
      
   }else if( c.equals("ez006_p") || c.equals("ez006_state_update") || c.equals("ez006_order_p") ){
      
      String strDoc_cd = CommonUtil.isNull(paramMap.get("doc_cd"));
      
      out.println("<script type='text/javascript'>");
      
      // 목록 화면 검색 파라미터.
      out.println("var search_data_center      = '"+search_data_center+"';");
      out.println("var search_state_cd      = '"+search_state_cd+"';");
      out.println("var search_gb            = '"+search_gb+"';");
      out.println("var search_text         = '"+search_text+"';");
      out.println("var search_date_gubun      = '"+search_date_gubun+"';");
      out.println("var search_s_search_date   = '"+search_s_search_date+"';");
      out.println("var search_e_search_date   = '"+search_e_search_date+"';");
      out.println("var search_s_search_date2   = '"+search_s_search_date2+"';");
      out.println("var search_e_search_date2   = '"+search_e_search_date2+"';");
      out.println("var search_task_nm         = '"+search_task_nm+"';");
      out.println("var search_moneybatchjob   = '"+search_moneybatchjob+"';");
      out.println("var search_critical        = '"+search_critical+"';");
      out.println("var search_check_approval_yn = '"+search_check_approval_yn+"';");
      out.println("var tabId                  = '"+tabId+"';");

      out.println("var search_param = '&search_data_center='+search_data_center+'&search_state_cd='+search_state_cd+'&search_gb='+search_gb+'&search_text='+encodeURI(search_text)+'&search_date_gubun='+search_date_gubun+'&search_s_search_date='+search_s_search_date+'&search_e_search_date='+search_e_search_date+'&search_s_search_date2='+search_s_search_date2+'&search_e_search_date2='+search_e_search_date2+'&search_task_nm='+search_task_nm+'&search_moneybatchjob='+search_moneybatchjob+'&search_critical='+search_critical+'&search_check_approval_yn='+search_check_approval_yn+'&tabId='+tabId");
      
      out.println("try{parent.viewProgBar(false);}catch(e){}");
      
      out.println("alert('"+r_msg+"');");
      
      out.println("parent.parent.doApprovalCntChk2();"); // 메인 상단의 결재건수와 동기화
      
      if ( strDocGb.equals("01") || strDocGb.equals("03") || strDocGb.equals("04") || strDocGb.equals("02") || strDocGb.equals("05") || strDocGb.equals("07") || strDocGb.equals("08") || strDocGb.equals("09") || strDocGb.equals("10")) {
         
         //if( "1".equals(r_code) ){
            out.println("top.closeTabsAndAddTab('tabs-"+tabId+"|tabs-"+strDoc_cd+"', 'c','"+menu_nm+"','01','"+tabId+"','tWorks.ez?c="+menu_gb_c+"&menu_gb="+tabId+"&doc_gb=99&'+search_param);");

         //}
      }

      if ( strDocGb.equals("06") ) {
         if( "1".equals(r_code) ){
            out.println("top.closeTabsAndAddTab('tabs-"+tabId+"|tabs-"+strDoc_cd+"', 'c','"+menu_nm+"','01','"+tabId+"','tWorks.ez?c="+menu_gb_c+"&menu_gb="+tabId+"&doc_gb=99&'+search_param);");

         }
      }
      out.println("</script>");
      
   }else if( c.equals("ez009_p") ) {

      out.println("<script type='text/javascript'>");
      out.println("try{top.contents_area.list.viewProgBar(false);}catch(e){}");
      out.println("alert('"+r_msg+"');");
      if( "1".equals(r_code) ){
         out.println("try{top.contents_area.list.viewProgBar(true);}catch(e){}");   
         // 그룹작업의 상태변경은 팝업으로 띄운다.
         if ( jobgroup_id.equals("") ) {
            out.println("top.contents_area.list.goPage('"+currentPage+"'); ");
         } else {
            out.println("top.goSearch();");
         }         
      }
      out.println("</script>");
      
   }else if( c.equals("ez010_p") ){
      
      out.println("<script type='text/javascript'>");
      out.println("try{top.mainFrame.viewProgBar(false);}catch(e){}");
      out.println("alert('"+r_msg+"');");
      if( "1".equals(r_code) ){
         out.println("top.stateFrame.document.getElementById('lyState').innerHTML += '<div> - Order : ["+CommonUtil.isNull(paramMap.get("order_date"))+"] "+CommonUtil.isNull(paramMap.get("job_name"))+"</div>'; ");
         out.println("top.document.getElementById('subFrameSet').rows = '"+CommonUtil.getMessage("ROWS.TOP.0")+",*,"+CommonUtil.getMessage("ROWS.STATE.2")+","+CommonUtil.getMessage("ROWS.BOTTOM.0")+",0';");
      }
      out.println("</script>");
   }else if( c.equals("ez011_up") || c.equals("ez011_del") ){
      
      out.println("<script type='text/javascript'>");
      out.println("try{top.contents_area.viewProgBar(false);;}catch(e){}");
      out.println("alert('"+r_msg+"');");
      if( "1".equals(r_code) ){
         out.println("top.contents_area.viewProgBar(true);");
         out.println("top.contents_area.goPage(1); ");
      }
      out.println("</script>");
      
   }else if( c.equals("ez012_popup_p") ){
      
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
      if( "1".equals(r_code) ){
         if (rMap.get("flag").equals("job_insert")) { //작업 이관
        	if(rMap.get("action_gubun").equals("popup")){
            	out.println("parent.defJobExceptMapper();"); 
            	out.println("if(confirm('작업검색 창을 닫으시겠습니까?'))");
            	out.println("parent.dlClose('defJobExceptMapper');");
        	}
            out.println("parent.defJobsList2();");
         } else {
            out.println("parent.defJobsList2();");
         }
      }
      out.println("</script>");
      
   }else if( c.equals("ez013_p") ){
      
      out.println("<script type='text/javascript'>");
      out.println("try{top.contents_area.viewProgBar(false);}catch(e){}");
      
      if( "1".equals(r_code) ){
    	  String flag    = CommonUtil.isNull(rMap.get("flag"));
    	  String host_cd = CommonUtil.isNull(rMap.get("host_cd"));
    	  
    	  if(flag.equals("owner_takeOver")){
    		  out.println("alert('"+r_msg+"');");
    	      out.println("parent.hostList();");
    	      out.println("parent.sCodeList('"+host_cd+"');");
    	      out.println("parent.dlClose('cmAppGrpCode');");
    	  }else{
    		  out.println("alert('"+r_msg+"');");
   	          out.println("parent.hostList();");
   	          out.println("parent.sCodeList(null);");
   	          out.println("parent.dlClose('cmAppGrpCode');");
    	  }
      }else{
         out.println("alert('"+r_msg+"');");
      }
      out.println("</script>");
   }else if( c.equals("ez013_p") ){
	      
	      out.println("<script type='text/javascript'>");
	      out.println("try{top.contents_area.viewProgBar(false);}catch(e){}");
	      
	      if( "1".equals(r_code) ){
	    	  String flag    = CommonUtil.isNull(rMap.get("flag"));
	    	  String host_cd = CommonUtil.isNull(rMap.get("host_cd"));
	    	  
	    	  if(flag.equals("owner_takeOver")){
	    		  out.println("alert('"+r_msg+"');");
	    	      out.println("parent.hostList();");
	    	      out.println("parent.sCodeList('"+host_cd+"');");
	    	      out.println("parent.dlClose('cmAppGrpCode');");
	    	  }else{
	    		  out.println("alert('"+r_msg+"');");
	   	          out.println("parent.hostList();");
	   	          out.println("parent.sCodeList(null);");
	   	          out.println("parent.dlClose('cmAppGrpCode');");
	    	  }
	      }else{
	         out.println("alert('"+r_msg+"');");
	      }
	      out.println("</script>");
   }else if( c.equals("ez045_p") ){
        
        out.println("<script type='text/javascript'>");
        out.println("try{top.contents_area.viewProgBar(false);}catch(e){}");
        
        if( "1".equals(r_code) ){
          if(strFlag.equals("database_takeOver")){
        	  r_msg += "\\n\\n이후 작업을 위해 패스워드 설정이 필요합니다.";
          }
          out.println("alert('"+r_msg+"');");
          out.println("parent.databaseList();");
          out.println("parent.dlClose('popDbProfileInfo');");
        }else{
        	out.println("alert('"+r_msg+"');");
        }
        out.println("</script>");
   }else if( c.equals("ez045_access") ){
       
       out.println("<script type='text/javascript'>");
	   out.println("try{parent.viewProgBar(false);}catch(e){console.log(e)}");
	   out.println("alert('"+r_msg+"');");
       out.println("</script>");
  }else if( c.equals("ezLink004_p") ){
      out.println("<script type='text/javascript'>");
      out.println("try{top.viewProgBar(false);}catch(e){}");
      out.println("alert('"+r_msg+"');");
      if( "1".equals(r_code) ){
         out.println("try{top.viewProgBar(false);}catch(e){}");
         out.println("top.close();");
      }
      out.println("</script>");
      
   }else if( c.equals("ez016") ||  c.equals("groupApproval") || (c.equals("ez036") && grp_doc_gb.equals("01")) ){ // 일괄결재
	  String strDoc_cd = CommonUtil.isNull(rMap.get("doc_cd"), CommonUtil.isNull(paramMap.get("doc_cd")));
      out.println("<form id='frm1' name='frm1' method='post' onsubmit='return false;' >");
      out.println("<input type='hidden' id='r_msg' name='r_msg' value='"+r_msg+"' />");
      out.println("</form>");

      out.println("<script type='text/javascript'>");
      
      out.println("try{parent.viewProgBar(false);}catch(e){}");
      
      out.println("var r_msg = document.frm1.r_msg.value; ");

      // 목록 화면 검색 파라미터.
      out.println("var search_data_center       = '"+search_data_center+"';");
      out.println("var search_state_cd          = '"+search_state_cd+"';");
      out.println("var search_apply_cd          = '"+search_apply_cd+"';");
      out.println("var search_gb                = '"+search_gb+"';");
      out.println("var search_text              = '"+search_text+"';");
      out.println("var search_date_gubun        = '"+search_date_gubun+"';");
      out.println("var search_s_search_date     = '"+search_s_search_date+"';");
      out.println("var search_e_search_date     = '"+search_e_search_date+"';");
      out.println("var search_s_search_date2    = '"+search_s_search_date2+"';");
      out.println("var search_e_search_date2    = '"+search_e_search_date2+"';");
      out.println("var search_task_nm           = '"+search_task_nm+"';");
      out.println("var search_critical          = '"+search_critical+"';");
      out.println("var search_approval_state    = '"+search_approval_state+"';");
      out.println("var search_check_approval_yn = '"+search_check_approval_yn+"';");
      out.println("var tabId                    = '"+tabId+"';");

      //out.println("var search_param = '&search_data_center='+search_data_center+'&search_state_cd='+search_state_cd+'&_apply_cd+'&search_gb='+search_gb+'&search_text='+encodeURI(search_text)+'&search_date_gubun='+search_date_gubun+'&search_s_search_date='+search_s_search_date+'&search_e_search_date='+search_e_search_date+'&search_s_search_date2='+search_s_search_date2+'&search_e_search_date2='+search_e_search_date2+'&search_task_nm='+search_task_nm+'&search_critical='+search_critical+'&search_approval_state='+search_approval_state+'&search_check_approval_yn='+search_check_approval_yn+'&tabId='+tabId");

      out.println("alert('"+r_msg+"');");
      
      out.println("parent.dlClose('dl_tmp3');");
      out.println("parent.dlClose('titleInput');");
      
      out.println("parent.$('#btn_search').trigger('click')");
      //out.println("parent.dlClose('dl_tmp3');");

      out.println("parent.parent.doApprovalCntChk2();"); // 메인 상단의 결재건수와 동기화
      out.println("</script>");      
   }else if( c.equals("ez020_w") ) { // 수시작업(수행/상태변경) LIST 등록 
      
      out.println("<form id='frm1' name='frm1' method='post' onsubmit='return false;' >");
      out.println("<input type='hidden' id='r_msg' name='r_msg' value='"+r_msg+"' />");
      out.println("</form>");
      
      out.println("<script type='text/javascript'>");
      out.println("try{top.contents_area.viewProgBar(false);}catch(e){}");
      
      out.println("var r_msg = document.frm1.r_msg.value; ");
      
      out.println("alert(r_msg);");
      
      out.println("try{top.contents_area.viewProgBar(true);}catch(e){}");
      out.println("top.window.close(); ");
      out.println("top.opener.location.href='"+sContextPath+"/tWorks.ez?c=ez019&jobgroup_id="+CommonUtil.isNull(paramMap.get("jobgroup_id"))+"';");

      out.println("</script>");
      
   }else if( c.equals("ez020_group_i") ) { // 수시작업(수행/상태변경) 등록
      
      out.println("<form id='frm1' name='frm1' method='post' onsubmit='return false;' >");
      out.println("<input type='hidden' id='r_msg' name='r_msg' value='"+r_msg+"' />");
      out.println("</form>");
      
      out.println("<script type='text/javascript'>");
      out.println("try{top.contents_area.viewProgBar(false);}catch(e){}");
      
      out.println("var r_msg = document.frm1.r_msg.value; ");
      
      out.println("alert(r_msg);");
      
      if( "1".equals(r_code) ){
         out.println("try{top.contents_area.viewProgBar(true);}catch(e){}");
	      if(strFlag.equals("group_update") || strFlag.equals("group_insert")) {
				out.println("parent.jobGroupList();");
	      }
		 if(strFlag.equals("detail_insert")) {
			out.println("parent.detailGrpList(2);");
			out.println("parent.defJobsList();");
			out.println("parent.parent.jobGroupList();");
		 }
      }
      
      out.println("</script>");

   }else if( c.equals("ez020_group_d") ) { // 수시작업(수행/상태변경) 삭제 
      
      out.println("<form id='frm1' name='frm1' method='post' onsubmit='return false;' >");
      out.println("<input type='hidden' id='r_msg' name='r_msg' value='"+r_msg+"' />");
      out.println("</form>");
      
      out.println("<script type='text/javascript'>");
      out.println("try{top.contents_area.viewProgBar(false);}catch(e){}");
      
      out.println("var r_msg = document.frm1.r_msg.value; ");
      
      out.println("alert(r_msg);");
      
      out.println("try{top.contents_area.viewProgBar(true);}catch(e){}");
      if( "1".equals(r_code) ){
			out.println("try{top.contents_area.viewProgBar(true);}catch(e){}");
			if(strFlag.equals("group_delete")){
				out.println("parent.jobGroupList();");
			}else if(strFlag.equals("detail_delete")) {
				out.println("parent.detailGrpList(2);");
				out.println("parent.defJobsList();");
				out.println("parent.parent.jobGroupList();");
			}
		}

      out.println("</script>");
   
   }else if( c.equals("ez021_w") || (c.equals("ez036") && grp_doc_gb.equals("05"))  ) { // ORDER 결재 요청
      
      out.println("<script type='text/javascript'>");
      
      out.println("alert('"+r_msg+"');");
      out.println("try{parent.viewProgBar(false);}catch(e){}");

      if ( "1".equals(r_code) ) {
   		 out.println("parent.dlClose('smartTreeView');");
         out.println("parent.dlClose('dl_tmp3');");
         out.println("parent.dlClose('titleInput');");
         out.println("parent.dlClose('popAdminTitleInput');");
         out.println("parent.defJobsList();");
         //out.println("top.closeTabsAndAddTab('tabs-"+tabId+"', 'c','"+menu_nm+"','01','"+tabId+"','tWorks.ez?c="+menu_gb_c+"&menu_gb="+tabId+"&doc_gb=99');");
      }
      
      out.println("</script>");
   }else if( c.equals("ez021_jg") ){ // ORDER 그룹결재 요청 
		out.println("<script type='text/javascript'>");

		out.println("alert('"+r_msg+"');");

		out.println("try{parent.viewProgBar(false);}catch(e){}");

		if ( "1".equals(r_code) ) {
	    	out.println("parent.dlClose('dl_tmp3');");
	    	out.println("parent.dlClose('titleInput');");
           out.println("parent.dlClose('popAdminTitleInput');");
	    	//out.println("clearGridSelected('gridObj');");

	    	//out.println("top.closeTabsAndAddTab('tabs-"+tabId+"', 'c','"+menu_nm+"','01','"+tabId+"','tWorks.ez?c="+menu_gb_c+"&menu_gb="+tabId+"&doc_gb=99');");
		}

		out.println("</script>");
      
   }else if( c.equals("ez022_w") || (c.equals("ez036") && grp_doc_gb.equals("07"))) { // 상태 변경 결재 요청
      
      out.println("<script type='text/javascript'>");
      
      out.println("alert('"+r_msg+"');");
      
      out.println("try{parent.viewProgBar(false);}catch(e){}");
      
      if ( "1".equals(r_code) ) {
         out.println("parent.dlClose('dl_tmp3');");
         out.println("parent.dlClose('titleInput');");
         out.println("parent.activeJobList();");
         //out.println("clearGridSelected('gridObj');");

         //out.println("top.closeTabsAndAddTab('tabs-"+tabId+"', 'c','"+menu_nm+"','01','"+tabId+"','tWorks.ez?c="+menu_gb_c+"&menu_gb="+tabId+"&doc_gb=99');");
      }
      
      out.println("</script>");
   
   }else if( c.equals("ez032_p") ){ // 결재자 변경 팝업창
      String doc_cd = CommonUtil.isNull(rMap.get("doc_cd"), CommonUtil.isNull(paramMap.get("doc_cd")));
         out.println("<script type='text/javascript'>");
         out.println("try{top.contents_area.viewProgBar(false);}catch(e){}");
         out.println("alert('"+r_msg+"');");
         out.println(" top.closeTab('tabs-"+doc_cd+"');");
         out.println("var job_name    = '"+strJob_name+"';");
         out.println("top.closeTabsAndAddTab('tabs-" + tabId + "|tabs-" + doc_cd + "', 'c','" + menu_nm + "','01','" + doc_cd + "','tWorks.ez?c=ez006&doc_gb=" + CommonUtil.isNull(rMap.get("doc_gb")) + "&doc_cd=" + CommonUtil.isNull(rMap.get("doc_cd")) + "&job_name=encodeURI(job_name)&doc_group_id=" + doc_group_id + "&doc_cnt=" + doc_cnt + "&data_center=" + CommonUtil.isNull(rMap.get("data_center"))+CommonUtil.isNull(rMap.get("search_param"))+ "');");
         out.println("</script>");
         
   }else if( c.equals("ez033_p") ){   // 실시간 작업 정보 팝업창 > 저장
      
      out.println("<form id='frm1' name='frm1' method='post' onsubmit='return false;' >");
      out.println("<input type='hidden' id='r_msg' name='r_msg' value='"+r_msg+"' />");
      out.println("</form>");
      
      out.println("<script type='text/javascript'>");      
      out.println("var r_msg = document.frm1.r_msg.value; ");
      out.println("alert(r_msg);");
      out.println("parent.window.close();");
      out.println("parent.opener.activeJobList()");
      out.println("</script>");
   
   }else if( c.equals("ez038_p") ){   // APP관리
      
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
      //out.println("top.leftFrame.goMenu('0714');}");
      out.println("try{top.contents_area.viewProgBar(false);}catch(e){}");
      out.println("</script>");
      
   }else if( c.equals("ez036_p") ){   // APP관리      
      out.println("<script type='text/javascript'>");
//       out.println("alert(1);");
      out.println("alert('"+r_msg+"');");
      
      out.println("try{top.contents_area.viewProgBar(false);}catch(e){}");
      out.println("</script>");
      
   }else if( c.equals("ez039_p") ){   // 리소스관리
      
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
      out.println("try{top.contents_area.viewProgBar(true);}catch(e){}");
      out.println("top.topFrame.goSimpleSearch('"+sContextPath+"/tWorks.ez?c=ez039'); ");
      out.println("</script>");
      
   } else if(c.equals("ezBoardPrc") ){
      
      String flag    = CommonUtil.isNull(rMap.get("flag"));
      
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
      
      out.println("parent.noticeList()");      
      
      out.println("</script>");

   }else if(c.equals("ezComCode_p")){
      
      String flag = CommonUtil.isNull(rMap.get("flag"));
      String code_gubun = CommonUtil.isNull(rMap.get("code_gubun"));
      String mcode_cd = CommonUtil.isNull(rMap.get("mcode_cd"));
      String host_cd = CommonUtil.isNull(rMap.get("host_cd"));
      
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
      //out.println("alert('"+code_gubun+"');");
      if(code_gubun.equals("M")){
         
         if(r_code.equals("1")){
            out.println("parent.mCodeList();");
         }
      }else if(code_gubun.equals("S")){
         
         if(r_code.equals("1")){
            out.println("parent.sCodeList('"+mcode_cd+"');");
         }
      }else if(code_gubun.equals("H")){
         if(r_code.equals("1")){
            out.println("parent.sCodeList('"+host_cd+"');");
         }
      }
      
      out.println("</script>");
   }else if(c.equals("ezAppGrp_p")){
      String flag 		= CommonUtil.isNull(rMap.get("flag"));
      String scode_cd 	= CommonUtil.isNull(rMap.get("scode_cd"));
      String grp_depth 	= CommonUtil.isNull(rMap.get("grp_depth"));
      String grp_cd 	= CommonUtil.isNull(rMap.get("grp_cd"));
      String defJobCnt 	= CommonUtil.isNull(rMap.get("defJobCnt"));
      
      if(r_msg.equals("")) r_msg = "처리완료";
      
      out.println("<script type='text/javascript'>");
   	  out.println("alert('"+r_msg+"');");

      if(grp_depth.equals("1")){
         if(r_code.equals("1")){
            out.println("parent.getCodeList('"+scode_cd+"','"+grp_depth+"');");
            out.println("parent.formClear();");
         }
         if(flag.equals("del")){               
            out.println("parent.getAppCodeList('"+scode_cd+"','2','0','');");
         }
      }else if(grp_depth.equals("2") || grp_depth.equals("4")){
//          if(r_code.equals("1")){
            out.println("parent.getAppCodeList('"+scode_cd+"','"+grp_depth+"','"+grp_cd+"','');");
//          }
      }else if(grp_depth.equals("3") || grp_depth.equals("5")){
//     	  if(r_code.equals("1")){
            out.println("parent.getSubCodeList('"+scode_cd+"','"+grp_depth+"','"+grp_cd+"','');");
//          }
      }else{
         if(r_code.equals("1")){
            out.println("parent.getCodeList('"+scode_cd+"','1');");
            out.println("parent.formClear();");
         }
      }
      
      out.println("</script>");
   }else if (c.equals("ezAppGrp_excel_p")) {
      String scode_cd       = CommonUtil.isNull(rMap.get("scode_cd"));
      String grp_depth       = CommonUtil.isNull(rMap.get("grp_depth"));
      String grp_cd          = CommonUtil.isNull(rMap.get("grp_cd"));
      
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
      
//       if(grp_depth.equals("1")){
         if(r_code.equals("1")){
            out.println("parent.parent.getCodeList('"+scode_cd+"', 1);");
            out.println("parent.parent.formClear();");
            out.println("parent.parent.dlClose('dl_tmp2');");
         }
//       }else if(grp_depth.equals("2") || grp_depth.equals("3")) {
//          if(r_code.equals("1")){
//             out.println("parent.parent.dlClose('dl_tmp2');");
//          }
//       }
      out.println("</script>");
      
   }else if(c.equals("ezUserApprovalGroup_p")){
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
      
      if(r_code.equals("1")){
         out.println("parent.userApprovalGroupList();");
      }
      
      out.println("</script>");
   }else if(c.equals("ezUserApprovalLine_p")){
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
      
      String line_grp_cd = CommonUtil.isNull(rMap.get("line_grp_cd"));
      
      if(r_code.equals("1")){
         out.println("parent.userApprovalLineList('"+line_grp_cd+"');");
      }
      
      out.println("</script>");
   
   }else if(c.equals("ezAdminApprovalGroup_p")){
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");

      if(r_code.equals("1")){ 
			out.println("parent.adminApprovalGroupList();");
      }
      
      out.println("</script>");
   }else if(c.equals("ezAdminApprovalLine_p")){
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
      
      String admin_line_grp_cd = CommonUtil.isNull(rMap.get("admin_line_grp_cd"));
      
      if(r_code.equals("1")){
         out.println("parent.adminApprovalLineList('"+admin_line_grp_cd+"');");
      }
      
      out.println("</script>");
      
   }else if(c.equals("ezGroupApprovalGroup_p")){
      out.println("<script type='text/javascript'>");
       
      out.println("alert('"+CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")))+"');");
      
      if(r_code.equals("1")){
         out.println("parent.groupApprovalGroupList();");
      }
      
      out.println("</script>");
      
   }else if(c.equals("ezGroupApprovalLine_p")){
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
      
      String group_line_grp_cd = CommonUtil.isNull(rMap.get("group_line_grp_cd"));
      
      if(r_code.equals("1")){
         out.println("parent.groupApprovalLineList('"+group_line_grp_cd+"');");
      }
      
      out.println("</script>");
      
   }else if(c.equals("ezCtmAgent_p")){
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
         
      if(r_code.equals("1")){
         out.println("parent.agentList();");
      }
      
      out.println("</script>");
   }else if(c.equals("ExcelLoad")){
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
         
   
      out.println("</script>");
      
   }else if(c.equals("ez_ReRunDoc")){
      
      out.println("<script type='text/javascript'>");
      out.println("alert('"+CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")))+"');");
      
      if(r_code.equals("1")){
         out.println("parent.doc06DetailList('"+CommonUtil.isNull(rMap.get("doc_cd"))+"');");
      }
      
      out.println("</script>");
      
   }else if( c.equals("ez003_p") ){
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
      if( "1".equals(r_code) ) out.println("top.topFrame.goSimpleSearch('"+sContextPath+"/tWorks.ez?c=ez003'); ");
      out.println("</script>");
      
   } else if( c.equals("ez013_grp_p") ){
      
      out.println("<script type='text/javascript'>");
      
      out.println("var grpname = '"+CommonUtil.isNull(paramMap.get("grpname"))+"';");
      
      out.println("alert('"+r_msg+"');");   
            
      if("1".equals(r_code)){
         out.println("parent.hostGrpList();");
         out.println("parent.grpNodeList(grpname);");
      }
      
      out.println("</script>");
      
   } else if( c.equals("ez019_p") ){
		
		out.println("<script type='text/javascript'>");
		
		out.println("alert('"+CommonUtil.isNull(rMap.get("r_msg"))+"');");	
				
		out.println("parent.jobCondList();");
		
		if("1".equals(r_code)){
		}
		
		out.println("</script>");
		
	} else if( c.equals("myWork_p") ){
      
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
      out.println("parent.myWorkList();");
      out.println("</script>");
      
	} else if( c.equals("ez006_forecastOrder") ){
      if(r_msg.equals("")) {
         r_msg = "처리완료";
      }
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
      out.println("try{parent.viewProgBar(false);}catch(e){console.log(e.message);}");
      out.println("</script>");

	} else if( c.equals("cmAppGrpCodeInsert") ){             // 시스템관리 - 테이블/어플리케이션/그룹이관
      out.println("<script type='text/javascript'>"); 
      out.println("alert('"+r_msg+"');");
      if( "1".equals(r_code) ){
         out.println("parent.getCodeList('"+CommonUtil.isNull(paramMap.get("p_scode_cd"))+"', '"+CommonUtil.isNull(paramMap.get("p_grp_depth"))+"');");
         out.println("parent.dlClose('cmAppGrpCode');");
      }
      out.println("</script>");
	} else if( c.equals("ezQuartzList_p") ){ //EzJOBs배치조회
      if(r_msg.equals("")) {
         r_msg = "처리완료";
      }
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
      out.println("parent.quartzList();");
      out.println("</script>");

	}else if( c.equals("ez006_w") ){
		if(r_msg.equals("")) {
			r_msg = "처리완료";
		
		}
		out.println("<script type='text/javascript'>");
		out.println("alert('"+r_msg+"');");
		out.println("try{parent.viewProgBar(false);}catch(e){console.log(e.message);}");
		out.println("parent.dlClose('titleInput');");
		out.println("parent.dlClose('dl_tmp3');");
		out.println("</script>");

	}else if(c.equals("ez002_user_ins_excel")){
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
      if(r_code.equals("1")){
          out.println("parent.parent.userList();");
    	  out.println("parent.parent.dlClose('dl_tmp2');");
      }
      out.println("</script>");
      
	}else if(c.equals("userChangeExcel_p")){
	  if(r_msg.equals("")) {
         r_msg = "처리완료";
      }
      out.println("<script type='text/javascript'>");
      out.println("alert('"+r_msg+"');");
      out.println("try{parent.viewProgBar(false);}catch(e){}");
      if(r_code.equals("1")){
	      out.println("parent.parent.defJobsList2();");
	      out.println("parent.parent.dlClose('dl_tmp2');");
      }
      out.println("</script>");
      
	} else if(c.equals("ezAlarmInfoList_p")){
	      
	      out.println("<script type='text/javascript'>");
	      out.println("alert('"+r_msg+"');");
	      out.println("parent.adminApprovalGroupList();");
	      out.println("</script>");
	} else if( c.equals("ez006_attempt") ){ //재반영
	   
	   // 재반영 결과 리턴을 위한 변수 추가
	   String main_doc_cd   = CommonUtil.isNull(rMap.get("main_doc_cd"));
	   String fail_comment  = CommonUtil.isNull(rMap.get("fail_comment"));
	   String fail_cnt  	= CommonUtil.isNull(rMap.get("fail_cnt"));
	   String rMap_flag  	= CommonUtil.isNull(rMap.get("flag"));
	   String strDoc_cd		= CommonUtil.isNull(rMap.get("doc_cds"));
	   String strDoc_gb		= CommonUtil.isNull(rMap.get("doc_gb"));
	   String doc_gbs   	= CommonUtil.isNull(rMap.get("doc_gbs"));
	   String strTabNm		= "";
	   
	    out.println("try{parent.viewProgBar(false);}catch(e){}");
	   
		if(rMap_flag.equals("API_CALL_FAIL") || !(fail_cnt.equals("0"))){
			r_msg = "재반영 실패한 작업이 있습니다.";
		}
		
		out.println("<script type='text/javascript'>");
		out.println("alert('"+r_msg+"');");
		System.out.println("rMaprMaprMaprMap : " + rMap);
		if(!main_doc_cd.equals("")){
			if(doc_gbs.equals("06")){
				  out.println("parent.doc06DetailList('"+main_doc_cd+"');");
			  }else{
				  out.println("parent.mainDocInfoList('"+main_doc_cd+"');");
			  }
		}else{
			if(strDoc_gb.equals("01")){
				strTabNm = "작업등록";
			}else if(strDoc_gb.equals("02")){
				strTabNm = "긴급";
			}else if(strDoc_gb.equals("03")){
				strTabNm = "작업삭제";
			}else if(strDoc_gb.equals("04")){
				strTabNm = "작업수정";
			}
			
			out.println("top.closeTabsAndAddTab('tabs-" + strDoc_cd + "', 'c','"+ strTabNm +"_상세','"+strDoc_gb+"','" + strDoc_cd + "','tWorks.ez?c=ez006&doc_gb=" + strDoc_gb + "&doc_cd=" + strDoc_cd + "&job_name=encodeURI(job_name)&doc_group_id=" + doc_group_id + "&doc_cnt=" + doc_cnt + "&data_center=" + CommonUtil.isNull(rMap.get("data_center"))+CommonUtil.isNull(rMap.get("search_param"))+ "');");
		}
		out.println("</script>");

	}else if((c.equals("ez036") && grp_doc_gb.equals("10")) ){

      out.println("<script type='text/javascript'>");
      out.println("try{parent.viewProgBar(false);}catch(e){}");

      if( "1".equals(r_code) ){
         out.println("alert('"+r_msg+"');");
         out.println("parent.dlClose('dl_tmp3');");
         out.println("parent.dlClose('popAdminTitleInput');");
         out.println("parent.parent.doErrorCntChk();"); // 메인 상단의 오류건수와 동기화
         out.println("parent.alertErrorList();");
      }else{
         out.println("alert('"+r_msg+"');");
      }

      out.println("</script>");
   }else if(c.equals("excel_verify") ){
	      
	      String strDoc_cd = CommonUtil.isNull(rMap.get("doc_cd"), CommonUtil.isNull(paramMap.get("doc_cd")));
	      String r_ori_con = CommonUtil.isNull(rMap.get("r_ori_con"));
	      String r_new_con = CommonUtil.isNull(rMap.get("r_new_con"));
	      Document parsedXmlDoc 	= (Document)rMap.get("parsedXmlDoc");
	      String xmlDoc 	= CommonUtil.isNull(rMap.get("xmlDoc"));
	      out.println("<form id='frm1' name='frm1' method='post' onsubmit='return false;' >");
	      out.println("<input type='hidden' id='flag' name='flag' value='"+CommonUtil.isNull(rMap.get("flag"))+"' />");
	      out.println("<input type='hidden' id='doc_cd' name='doc_cd' value='"+CommonUtil.isNull(rMap.get("doc_cd"))+"' />");
	      out.println("</form>");
	      
	      out.println("<script type='text/javascript'>");
	      
	      
	      // 목록 화면 검색 파라미터.
	      out.println("var search_data_center       = '"+search_data_center+"';");
	      out.println("var search_state_cd          = '"+search_state_cd+"';");
	      out.println("var search_apply_cd          = '"+search_apply_cd+"';");
	      out.println("var search_gb                = '"+search_gb+"';");
	      out.println("var search_text              = '"+search_text+"';");
	      out.println("var search_date_gubun        = '"+search_date_gubun+"';");
	      out.println("var search_s_search_date     = '"+search_s_search_date+"';");
	      out.println("var search_e_search_date     = '"+search_e_search_date+"';");
	      out.println("var search_s_search_date2   	= '"+search_s_search_date2+"';");
	      out.println("var search_e_search_date2   	= '"+search_e_search_date2+"';");
	      out.println("var search_task_nm           = '"+search_task_nm+"';");
	      out.println("var search_moneybatchjob     = '"+search_moneybatchjob+"';");
	      out.println("var search_critical          = '"+search_critical+"';");
	      out.println("var search_approval_state    = '"+search_approval_state+"';");
	      out.println("var search_check_approval_yn = '"+search_check_approval_yn+"';");
	      out.println("var tabId                	= '"+tabId+"';");
	      out.println("var doc_group_id           	= '"+doc_group_id+"';");

	      out.println("var search_param = '&search_data_center='+search_data_center+'&search_state_cd='+search_state_cd+'&search_apply_cd='+search_apply_cd+'&search_gb='+search_gb+'&search_text='+encodeURI(search_text)+'&search_date_gubun='+search_date_gubun+'&search_s_search_date='+search_s_search_date+'&search_e_search_date='+search_e_search_date+'&search_s_search_date2='+search_s_search_date2+'&search_e_search_date2='+search_e_search_date2+'&search_task_nm='+search_task_nm+'&search_moneybatchjob='+search_moneybatchjob+'&search_critical='+search_critical+'&search_approval_state='+search_approval_state+'&search_check_approval_yn='+search_check_approval_yn+'&tabId='+tabId");

	         
	      out.println("try{parent.viewProgBar(false);}catch(e){}");
	      String xmlDocStr = StringEscapeUtils.escapeEcmaScript(CommonUtil.convertDocumentToString(parsedXmlDoc).replaceAll("(\\r\\n|\\n|\\r)", ""));
	      System.out.println("r_code : " + r_code);
	      if( "1".equals(r_code) ){
   		  	out.println("parent.contentsCompare('"+xmlDocStr+"');");
	      }else{
	      	out.println("alert('"+r_msg+"');");
	      	out.println("$(parent.parent.document).find('#if2').hide();");
				      	
	      }
	      out.println("</script>");
	      
	}else if(c.equals("ez001_tempPassword")){
		
		out.println("<script type='text/javascript'>");
	    if ("1".equals(r_code)) {
	        out.println("alert('임시 비밀번호가 발급되었습니다.');"); 
	    }else {
	        out.println("alert('" + r_msg + "');");
	    }
	    out.println("window.location.href='" + sContextPath + "/index.jsp';");  
	    out.println("</script>");
	}
   
%>
</body>
</html>