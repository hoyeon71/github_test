package com.ghayoun.ezjobs.comm.service;

import java.io.File;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.QuartzDao;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.SendMail;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;
import com.ghayoun.ezjobs.m.domain.BatchResultTotalBean;
import com.ghayoun.ezjobs.m.repository.EmBatchResultTotalDao;
import com.ghayoun.ezjobs.t.domain.UserBean;

public class EzDailyReportJobServiceImpl extends QuartzJobBean{
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private QuartzDao quartzDao;
	private EmBatchResultTotalDao emBatchResultTotalDao;
	
	public void setQuartzDao(QuartzDao quartzDao) {
        this.quartzDao = quartzDao;
    }
	public void setEmBatchResultTotalDao(EmBatchResultTotalDao emBatchResultTotalDao) {
        this.emBatchResultTotalDao = emBatchResultTotalDao;
    }
	
	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		
		// 로그 경로 가져오기.
		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
		String strClassName		= this.getClass().getName().split("\\.")[this.getClass().getName().split("\\.").length-1];
		String strLogPath		= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + strClassName + "/";

		// 해당 폴더 없으면 생성.
		if ( !new File(strLogPath).exists() ) {
			new File(strLogPath).mkdirs();
		}
		
		JobDataMap jobDataMap = jobExecutionContext.getJobDetail().getJobDataMap();
		
		String strCode = jobDataMap.getString("code");		
		
		Map<String, Object> map 		= new HashMap<String, Object>();
		Map<String, Object> rMap 		= new HashMap<String, Object>();
		map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		try {
			
			// AJOB 정보 추출.
			map.put("data_center_code", strCode);
			CommonBean dataCenterInfo = quartzDao.getDataCenterInfo(map);
	
			String strDataCenter 		= "";
			String strActiveNetName 	= "";
			String strCtmOdate 			= "";
			
			if ( dataCenterInfo != null ) {
				strDataCenter = CommonUtil.isNull(dataCenterInfo.getData_center());
				strActiveNetName = CommonUtil.isNull(dataCenterInfo.getActive_net_name());
				strCtmOdate = CommonUtil.isNull(dataCenterInfo.getCtm_odate());
			}
			
			map.put("data_center", 			strDataCenter);
			map.put("active_net_name", 	strActiveNetName);
			map.put("odate", 				strCtmOdate);
			
			// 전체 일 총괄표 추출.
			List dailyReportList = quartzDao.dGetDailyReportList(map);
			
			// HTML 만들기.
			String strAdminContent = createHtml(dailyReportList);
			
			// 제목
			String strTitle = "[통합배치] 배치 작업 통계";
			
			
			// 관리자 추출 및 발송
			List dailyReportSendAdminList = quartzDao.dGetDailyReportSendAdminList(map);
			
			if ( dailyReportSendAdminList != null ) {
				for ( int i = 0; i < dailyReportSendAdminList.size(); i++ ) {
					UserBean bean = (UserBean)dailyReportSendAdminList.get(i);
					
					String strUserEmail	= CommonUtil.E2K(bean.getUser_email());

					// 메일 발송
					mailSend(strUserEmail, strTitle, strAdminContent);
				}
			}			

			// 담당자 추출 및 발송
			List dailyReportSendUserList = quartzDao.dGetDailyReportSendUserList(map);
			
			if ( dailyReportSendUserList != null ) {
				for ( int i = 0; i < dailyReportSendUserList.size(); i++ ) {
					UserBean bean = (UserBean)dailyReportSendUserList.get(i);
					
					String strUserEmail	= CommonUtil.E2K(bean.getUser_email());
					String strUserCd		= CommonUtil.E2K(bean.getUser_cd());
					
					map.put("user_cd_1", strUserCd);
					
					// 담당자 별 일 총괄표 추출.
					List userDailyReportList = quartzDao.dGetDailyReportList(map);
					
					// HTML 만들기.
					String strUserContent = createHtml(userDailyReportList);

					// 메일 발송
					mailSend(strUserEmail, strTitle, strUserContent);
				}
			}
		} catch(Exception e) {
			TraceLogUtil.TraceLog(e.toString(), strLogPath, strClassName);
			logger.error("[" + strClassName+" Exception] : " + e);
		}
	}
	
	// HTML 만들기
	private static String createHtml(List dailyReportList) throws SQLException {

		StringBuffer sb = new StringBuffer();
		
		sb.append("<style type='text/css'>");
		
		sb.append(".board_area {display:block;height:100%;width:100%;background:#fff;}");
		
		sb.append(".lst_area {margin:10px;padding:0;height:100%;}");
		
		sb.append(".lst_contents {margin:0;padding:0;height:100%;width:100%;}");
		
		sb.append(".board_lst {table-layout:fixed !important;border-collapse:separate;*border-collapse:collapse;width:100%;border-left:1px solid #f2f2f2;}");			
		
		sb.append(".board_lst.gray {table-layout:auto;border-collapse:separate;*border-collapse:collapse;width:100%;border-left:1px solid #f2f2f2;}");
		sb.append(".board_lst.gray th {padding:5px 0;font-size:12px;font-weight:normal;color:#fff;text-align:center;background:#797979;border-right:1px solid #f2f2f2;border-bottom:1px solid #f2f2f2;}");
		sb.append(".board_lst.gray td {padding:5px 0;font-size:12px;text-align:center;border-right:1px solid #f2f2f2;border-bottom:1px solid #f2f2f2;}");
		sb.append(".board_lst.gray td span {margin:0 30px 0 0;color:#858585;font-weight:bold;}");
		sb.append(".board_lst.gray td.con {padding:30px;height:200px;font-size:13px;line-height:20px;text-align:justify;vertical-align:top;}");
		sb.append(".board_lst.gray td.tLeft {text-align:left;padding:0 5px;}");
		
		sb.append("</style>");
		
		sb.append("<div class='board_area'>");
		sb.append("<div class='lst_area'>");
		sb.append("<div class='lst_contents'>");
		sb.append("<table class='board_lst gray'>");
		sb.append("<colgroup>");
		sb.append("<col width='40px' />");
		sb.append("<col width='40px' />");
		sb.append("<col width='40px' />");
		sb.append("<col width='40px' />");
		sb.append("<col width='40px' />");
		sb.append("<col width='40px' />");
		sb.append("<col width='40px' />");
		sb.append("<col width='40px' />");
		sb.append("<col width='40px' />");
		sb.append("<col width='40px' />");
		sb.append("</colgroup>");
		sb.append("<thead>");
		sb.append("<tr>");
		sb.append("<th>GRP</th>");
		sb.append("<th>건수</th>");
		sb.append("<th>성공</th>");
		sb.append("<th>실패</th>");
		sb.append("<th>수행중</th>");
		sb.append("<th>대기</th>");
		sb.append("<th>기타</th>");
		sb.append("<th>Unknown</th>");
		sb.append("<th>HOLD</th>");
		sb.append("<th>삭제</th>");
		sb.append("</tr>");
		sb.append("</thead>");
		
		sb.append("<tbody>");
		
		if ( dailyReportList != null && dailyReportList.size() > 0 ) {
			for ( int i = 0; i < dailyReportList.size(); i++ ) {
				BatchResultTotalBean bean = (BatchResultTotalBean)dailyReportList.get(i);
				
				String strGroup_name				= CommonUtil.E2K(bean.getGroup_name());
				String strTotal 						= CommonUtil.isNull(bean.getTotal());
				String strEnded_ok 					= CommonUtil.isNull(bean.getEnded_ok());
				String strEnded_not_ok 			= CommonUtil.isNull(bean.getEnded_not_ok());
				String strExecuting 					= CommonUtil.isNull(bean.getExecuting());
				String strWait_condition 			= CommonUtil.isNull(bean.getWait_condition());
				String strWait_time 					= CommonUtil.isNull(bean.getWait_time());
				String strWait_confirm 				= CommonUtil.isNull(bean.getWait_confirm());
				String strWait_resource 			= CommonUtil.isNull(bean.getWait_resource());
				String strWait_host 					= CommonUtil.isNull(bean.getWait_host());
				String strEtc 							= CommonUtil.isNull(bean.getEtc());
				String strUnknown 					= CommonUtil.isNull(bean.getUnknown());
				String strHold 						= CommonUtil.isNull(bean.getHold());
				String strDeletes 						= CommonUtil.isNull(bean.getDeletes());
				
				String strWait							= CommonUtil.isNull(Integer.parseInt(strWait_condition) + Integer.parseInt(strWait_time) + Integer.parseInt(strWait_confirm) + Integer.parseInt(strWait_resource) + Integer.parseInt(strWait_host));

				sb.append(createContents(strGroup_name, strTotal, strEnded_ok, strEnded_not_ok, strExecuting, strWait, strEtc, strUnknown, strHold, strDeletes));
			}
		} else {			
			sb.append("<tr><td colspan='10'>수행된 작업 내역이 없습니다.</td></tr>");
		}
		
		sb.append("</tbody>");
		sb.append("</table>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		
		return sb.toString();
	}
	
	// 내용 만들기
	private static String createContents(String strGroup_name, String strTotal, String strEnded_ok, 
													String strEnded_not_ok, String strExecuting, String strWait, String strEtc, String strUnknown, 
													String strHold, String strDeletes) throws SQLException {

		StringBuffer sb = new StringBuffer();
		
		String HtmlContent = "";
		
		try {
			
			sb.append("<tr >");
			sb.append("<td>"+strGroup_name+"</td>");
			sb.append("<td>"+strTotal+"</td>");
			sb.append("<td>"+strEnded_ok+"</td>");
			sb.append("<td>"+strEnded_not_ok+"</td>");
			sb.append("<td>"+strExecuting+"</td>");
			sb.append("<td>"+strWait+"</td>");
			sb.append("<td>"+strEtc+"</td>");
			sb.append("<td>"+strUnknown+"</td>");
			sb.append("<td>"+strHold+"</td>");
			sb.append("<td>"+strDeletes+"</td>");
			sb.append("<tr >");
			
			HtmlContent = sb.toString();

		} catch (Exception e) {
			
			System.out.println(e.toString());
		}
		return HtmlContent;		
	}
	
	// 메일 전송.
	private static void mailSend(String strUserEmail, String strTitle, String strContent) throws SQLException {

		try {
			
			SendMail.senderMail("TLI_security@tyli.myangel.co.kr", "ilwoo.lim@tyli.myangel.co.kr", strTitle, strContent, "관리자");
			
			System.out.println(strUserEmail + "주소로 메일 발송 : " + strContent);
			
		} catch (Exception e) {
			
			System.out.println(e.toString());
		}
	}
}
