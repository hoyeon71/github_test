package com.ghayoun.ezjobs.comm.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.bmc.ctmem.schema900.ResponseUserRegistrationType;
import com.ghayoun.ezjobs.comm.repository.QuartzDao;
import com.ghayoun.ezjobs.common.axis.ConnectionManager;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.t.domain.Doc01Bean;
import com.ghayoun.ezjobs.t.domain.Doc06Bean;
import com.ghayoun.ezjobs.t.domain.JobMapperBean;
import com.ghayoun.ezjobs.t.repository.WorksUserDao;
import com.ghayoun.ezjobs.t.service.WorksApprovalDocServiceImpl;

public class EzAutoCallServerJobServiceImpl extends QuartzJobBean{

	private static final Log logger = LogFactory.getLog(EzAutoCallServerJobServiceImpl.class);
	private static final Lock QLOCK = new ReentrantLock();
	
	private QuartzDao quartzDao;

	public void setQuartzDao(QuartzDao quartzDao) {
        this.quartzDao = quartzDao;
    }
	
	@SuppressWarnings("unchecked")
	@Override
	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		logger.info("#EzAutoCallServerJobServiceImpl | Start~~~");
		
		Map<String, Object> rMap = new HashMap<>();
		
		if(QLOCK.tryLock()){
			try{
				
				String strResult 			= "";
				String strReturnTime		= "";
				String strReturnHp			= "";
				
				Socket socket 				= null;
				ServerSocket serverSocket 	= new ServerSocket(8000);
				DataOutputStream out 		= null;
				DataInputStream in 			= null;
				BufferedReader br 			= null;
				
				logger.info("#EzAutoCallServerJobServiceImpl | Socket Open ");
				
				while (true) {
					
					try {
					
						logger.info("#EzAutoCallServerJobServiceImpl | 연결 요청을 기다립니다.");
						
						socket = serverSocket.accept();
						
						logger.info("#EzAutoCallServerJobServiceImpl | " + socket.getInetAddress() + " 로부터 연결 요청이 들어왔습니다.");
						
						in		= new DataInputStream(new BufferedInputStream(socket.getInputStream()));
						out 	= new DataOutputStream(new BufferedOutputStream(socket.getOutputStream()));
						br 		= new BufferedReader(new InputStreamReader(in));
						
						int iAckSize 		= 56;
						String StrAckReturn = "";
						byte[] BUFFER 		= new byte[iAckSize];
					
						while (StrAckReturn.length() < iAckSize) {
							in.read(BUFFER);
							StrAckReturn = new String(BUFFER, "UTF-8");
					    }
						
						// ACK 처리.
						if ( !StrAckReturn.equals("") && StrAckReturn.length() == 56 ) {
							strResult	 	= StrAckReturn.substring(18, 20);
							strReturnTime 	= StrAckReturn.substring(4, 18);
							strReturnHp 	= StrAckReturn.substring(32, 43);							
						}
						
						// 발송 테이블 업데이트.
						map.put("flag", 			"AUTOCALL_RESULT");
						map.put("result", 			strResult);
						map.put("result_time", 		strReturnTime);
						map.put("result_hp", 		strReturnHp);						
						
						rMap = quartzDao.dPrcQuartz(map);
						
						socket.close();
						//serverSocket.close();
						in.close();
						out.close();
						
					} catch (Exception e)  {
						socket.close();
						//serverSocket.close();
						in.close();
						out.close();
					} finally {
						socket.close();
						//serverSocket.close();
						in.close();
						out.close();
					}
	 			}
				
			}catch(Exception e){
				logger.info("#EzAutoCallServerJobServiceImpl | Error :::"+e.getMessage());
			}finally{
				QLOCK.unlock();
			}		
		}	
	
		logger.info("#EzAutoCallServerJobServiceImpl | End~~~");
		
	}
}
