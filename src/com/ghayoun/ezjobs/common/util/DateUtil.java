package com.ghayoun.ezjobs.common.util;

import java.text.*;
import java.util.*;

import oracle.net.aso.b;

public class DateUtil {
	static DecimalFormat df4 = new DecimalFormat("0000");
	static DecimalFormat df2 = new DecimalFormat("00");
	
	static SimpleDateFormat korDF = new SimpleDateFormat("yyyy년 MM월 dd일");
	static SimpleDateFormat dashDF = new SimpleDateFormat("yyyy-MM-dd");
	static SimpleDateFormat noneDF = new SimpleDateFormat("yyyyMMdd");
	
	static SimpleDateFormat korTF = new SimpleDateFormat("HH시 mm분 ss초");
	static SimpleDateFormat colonTF = new SimpleDateFormat("HH:mm:ss");
	static SimpleDateFormat noneTF = new SimpleDateFormat("HHmmss");
	
	// date format type
	public final static int NONE = 0;
	public final static int DASH = 1;
	public final static int COLON = 1;
	public final static int KOR = 2;
	
	// add type
	public final static int YEAR = 0;
	public final static int MONTH = 1;
	public final static int DATE = 2;
	
	/**
	 * 서버의 현재날짜를 yyyymmdd 형식으로 return해준다.
	 */
	public static String getDay() {
		return noneDF.format(Calendar.getInstance().getTime());
	}
	
	/**
	 * 서버의 현재날짜를 정해진 타입에 따라 return 해준다.
	 * @param type<br>
	 * @param <pre>
	 * @param	DateUtil.NONE : yyyymmdd<br>
	 * @param	DateUtil.DASH : yyyy년 mm월 dd일<br>
	 * @param	DateUtil.KOR  : yyyy-mm-dd<br>
	 * @param </pre>
	 */
	public static String getDay(int type) {
		Date now = Calendar.getInstance().getTime();
		switch (type) {
			case 0:
			return noneDF.format(now);
			case 1:
			return dashDF.format(now);
			case 2:
			return korDF.format(now);
			default:
			return "";
		}
	}
	
	/**
	 * 현재 Day를 구한다.
	 * @param  day, type
	 * @return String
	 * @throws 
	 */    
	public static String getDay(String day, int type) {
		Date now = makeDate(day);
		switch (type) {
			case 0:
			return noneDF.format(now);
			case 1:
			return dashDF.format(now);
			case 2:
			return korDF.format(now);
			default:
			return "";
		}
	}
	
	/**
	 * 
	 * @param  day
	 * @return Date
	 * @throws Exception
	 */    
	public static Date makeDate(String day) {
		String strYear = "";
		String strMonth = "";
		String strDate = "";
		try {
			strYear = day.substring(0,4);
			strMonth = day.substring(4,6);
			strDate = day.substring(6);
		} catch (Exception e) {
			return null;
		}
		int iYear = 0;
		int iMonth = 0;
		int iDate = 0;
		
		try {
			iYear = Integer.parseInt(strYear);
			iMonth = Integer.parseInt(strMonth)-1;
			iDate = Integer.parseInt(strDate);
		} catch (Exception e) {
			return null;
		}
		Calendar cz_Tmp = Calendar.getInstance();
		cz_Tmp.set(iYear, iMonth, iDate);
		return cz_Tmp.getTime();
	}
	
	/**
	 * 서버의 현재시간을 HHmmss 형식으로 return해준다.
	 */
	public static String getTime() {
		return noneTF.format(Calendar.getInstance().getTime());
	}
	
	/**
	 * 서버의 현재시간을 정해진 타입에 따라 return 해준다.
	 * @param type<br>
	 * @param <pre>
	 * @param	DateUtil.NONE : HHmmss<br>
	 * @param	DateUtil.COLON : HH:mm:ss<br>
	 * @param	DateUtil.KOR  : HH시 mm분 ss초<br>
	 * @param </pre>
	 */
	public static String getTime(int type) {
		Date now = Calendar.getInstance().getTime();
		switch (type) {
			case 0:
			return noneTF.format(now);
			case 1:
			return colonTF.format(now);
			case 2:
			return korTF.format(now);
			default:
			return "";
		}
	}
	
	/**
	 * 서버의 현재날짜를 seperator로 구분하여 return해준다.
	 */
	public static String getDay(String seperator) {
		SimpleDateFormat userDF = new SimpleDateFormat("yyyy"+seperator+"MM"+seperator+"dd");
		return userDF.format(Calendar.getInstance().getTime());
	}
	
	/**
	 * 서버의 현재날짜 중 년도를 리턴해준다.
	 */
	public static String getYear() {
		return df4.format(Calendar.getInstance().get(Calendar.YEAR));
	}
	
	/**
	 * 서버의 현재날짜 중 월을 리턴해준다.
	 */
	public static String getMonth() {
		return df2.format(Calendar.getInstance().get(Calendar.MONTH)+1);
	}
	
	/**
	 * 서버의 현재날짜 중 날짜를 리턴해준다.
	 */
	public static String getDate() {
		return df2.format(Calendar.getInstance().get(Calendar.DATE));
	}
	
	/**
	 * 서버의 현재날짜 중 시간을 리턴해준다.
	 */
	public static String getHour() {
		return df2.format(Calendar.getInstance().get(Calendar.HOUR_OF_DAY));
	}
	
	/**
	 * 서버의 현재날짜 중 분을 리턴해준다.
	 */
	public static String getMinute() {
		return df2.format(Calendar.getInstance().get(Calendar.MINUTE));
	}
	
	/**
	 * 서버의 현재날짜 중 초를 리턴해준다.
	 */
	public static String getSecond() {
		return df2.format(Calendar.getInstance().get(Calendar.SECOND));
	}
	
	/**
	 * yyyymmdd타입의 날짜에 년, 월 혹은 일을 더해서 리턴해준다.<br>
	 * @param day : target day<br>
	 * @param i : YEAR, MONTH, DATE<br>
	 * @param addNum : 더할 숫자.
	 */
	public static String add(String day, int i, int addNum) {
		String strYear = "";
		String strMonth = "";
		String strDate = "";
		if (day.length() == 8) {
			strYear = day.substring(0,4);
			strMonth = day.substring(4,6);
			strDate = day.substring(6);	
		} else if (day.length() == 10) {
			strYear = day.substring(0,4);
			strMonth = day.substring(5,7);
			strDate = day.substring(8);	
		} else {
				return "날짜 길이가 맞지 않습니다.";
		}
		
		int iYear = 0;
		int iMonth = 0;
		int iDate = 0;
		
		try {
			iYear = Integer.parseInt(strYear);
			iMonth = Integer.parseInt(strMonth)-1;
			iDate = Integer.parseInt(strDate);
		} catch (Exception e) {
			return "숫자타입이 아닙니다.";
		}
		
		Calendar cdar = Calendar.getInstance();
		cdar.clear();
		cdar.set(iYear,iMonth,iDate);
		
		switch (i) {
			case YEAR:
			cdar.add(Calendar.YEAR, addNum);
			break;
			case MONTH:
			cdar.add(Calendar.MONTH, addNum);
			break;
			case DATE:
			cdar.add(Calendar.DATE, addNum);
			break;
		}
		
		if (day.length() == 8) {
			return noneDF.format(cdar.getTime());			
		} else {
			return dashDF.format(cdar.getTime());
		}

	}
	
	/**
	 * yyyymmdd타입의 날짜에 년을 더해서 리턴해준다.
	 */
	public static String addYear(String day, int addNum) {
		return add(day, DateUtil.YEAR, addNum);
	}
	public static String addYear(String day, int addNum, int type) {
		return getDay(add(day, DateUtil.YEAR, addNum),type);
	}
	
	/**
	 * yyyymmdd타입의 날짜에 월을 더해서 리턴해준다.
	 */
	public static String addMonth(String day, int addNum) {
		return add(day, DateUtil.MONTH, addNum);
	}
	public static String addMonth(String day, int addNum, int type) {
		return getDay(add(day, DateUtil.MONTH, addNum),type);
	}
	
	/**
	 * yyyymmdd타입의 날짜에 일을 더해서 리턴해준다.
	 */
	public static String addDate(String day, int addNum) {
		return add(day, DateUtil.DATE, addNum);
	}
	public static String addDate(String day, int addNum, int type) {
		String newDay = add(day, DateUtil.DATE, addNum);
		return getDay(newDay,type);
	}
	/**
	 * 서버의 현재날짜를 seperator로 구분하여 return해준다.
	 */
	public static String getTime(String seperator) {
		SimpleDateFormat userDF = new SimpleDateFormat("HH"+seperator+"mm"+seperator+"ss");
		return userDF.format(Calendar.getInstance().getTime());
	}	
	
	public static String getTime(String day, int type) {
		Date now = makeTime(day);
		switch (type) {
			case 0:
			return noneTF.format(now);
			case 1:
			return colonTF.format(now);
			case 2:
			return korTF.format(now);
			default:
			return "";
		}
	}	
	
	public static Date makeTime(String time) {
		String strHour = "";
		String strMinute = "";
		String strSecond = "";
		try {
			strHour = time.substring(0,2);
			strMinute = time.substring(2,4);
			strSecond = time.substring(4);
		} catch (Exception e) {
			return null;
		}
		int iHour = 0;
		int iMinute = 0;
		int iSecond = 0;
		
		try {
			iHour = Integer.parseInt(strHour);
			iMinute = Integer.parseInt(strMinute);
			iSecond = Integer.parseInt(strSecond);
		} catch (Exception e) {
			return null;
		}
		Calendar cz_Tmp = Calendar.getInstance();
		cz_Tmp.set(Calendar.HOUR, iHour-12);
		cz_Tmp.set(Calendar.MINUTE, iMinute);
		cz_Tmp.set(Calendar.SECOND, iSecond);
		return cz_Tmp.getTime();
	}
	
	/**
	 *	현재년도에서 앞뒤로 년도를 추가해서 배열로 린턴한다.
	 * @param prenum	과거년도의 갯수
	 * @param postnum	미래년도의 갯수
	 * @return
	 */
	public static String[] getSelectYear(int prenum, int postnum){
		String[] years = new String[prenum + postnum + 1];
        int nowYear = Integer.parseInt(getYear());
		int pos = 0;
		for(int i=0; i< prenum; i++){
			years[pos] = String.valueOf(nowYear - (prenum - pos));
            pos++;
		}
		years[pos] = String.valueOf(nowYear);
        pos++;

		for(int i=0; i<postnum; i++){
            years[pos] = String.valueOf(nowYear + (i+1));
			pos++;
		}
        return years;
	}
	
	/**
	 * @ 설명  : 주어진 일자의 요일 구하기 
	 * @param  day
	 * @return Date
	 * @throws Exception
	 */    
	public static String getWeekDay(String day) {
		String strReturn = "";
		Date dDate =  makeDate(day);
		
		Calendar cal = Calendar.getInstance();
		cal.setTime( dDate);
		int iWeekDay = cal.get(Calendar.DAY_OF_WEEK);
		
		switch( iWeekDay ){
			case 1: strReturn ="일"; break;
			case 2: strReturn ="월"; break;
			case 3: strReturn ="화"; break;
			case 4: strReturn ="수"; break;
			case 5: strReturn ="목"; break;
			case 6: strReturn ="금"; break;
			case 7: strReturn ="토"; break;
		}
		
		return strReturn;		
		
	}
	
	public static String[] getWeekDays(String day) {
		Date dDate =  makeDate(day);
		
		Calendar cal = Calendar.getInstance();
		cal.setTime( dDate);
		
		String aWeek[] = new String[7];
		for(int i=0;i<aWeek.length;i++){
			cal.set(Calendar.DAY_OF_WEEK,i+1);
			aWeek[i]=noneDF.format(cal.getTime());
		}
		
		return aWeek;		
		
	}
	
	/**
	 * @ 설명  : 주어진 YYYYMMDD의 해당 월 마지막 날짜 구하기 
	 */    
	public static String getLastDay(String YMD) {
		
		String strYear	= YMD.substring(0,4);
		String strMonth	= YMD.substring(4,6);
		String strDay	= YMD.substring(4,6);
		
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		
		GregorianCalendar cal = new GregorianCalendar(Integer.parseInt(strYear),
													  Integer.parseInt(strMonth),
													  Integer.parseInt(strDay));
		
		cal.add(Calendar.MONTH,0);
		
		int iYear 	= cal.get(GregorianCalendar.YEAR);
		int iMonth	= cal.get(GregorianCalendar.MONTH);
		
		String strEndDay = fmt.format(cal.getTime());
		
		GregorianCalendar cal2 = new GregorianCalendar(iYear, iMonth, 1);
		
		cal2.add(Calendar.DATE, -1);
		
		strEndDay = fmt.format(cal2.getTime());
		
		return strEndDay;
	}
	
	/**
	 * @throws ParseException 
	 * @ 설명  : 주어진 YYYYMMDD 두 날짜 차이 계산
	 */    
	public static long diffOfDate(String begin, String end) throws ParseException {
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		
		Date beginDate 	= formatter.parse(begin);
		Date endDate 	= formatter.parse(end);
		
		long diff 		= endDate.getTime() - beginDate.getTime();
		long diffDays 	= diff / (24 * 60 * 60 * 1000);
		
		return diffDays;
	}
	
	/*
	 * @ 설명  : 주어진 YYYYMMDD 두 날짜 사이 날짜들 구하기
	 */    
	public static String gapOfDate(String begin, String end) throws ParseException {
		
		DateFormat df = new SimpleDateFormat("yyyyMMdd");
		
		String strGapDate = "";
		
		Date d1 = df.parse( begin );
		Date d2 = df.parse( end );
		
		Calendar c1 = Calendar.getInstance();
		Calendar c2 = Calendar.getInstance();
		
		//Calendar 타입으로 변경 add()메소드로 1일씩 추가해 주기위해 변경
		c1.setTime( d1 );
		c2.setTime( d2 );

		//시작날짜와 끝 날짜를 비교해, 시작날짜가 작거나 같은 경우 출력
		while( c1.compareTo( c2 ) != 1 ){
			
			strGapDate += df.format(c1.getTime()) + "|";

			// 시작날짜 + 1 일
			c1.add(Calendar.DATE, 1);
		}
		
		if ( !strGapDate.equals("") ) {
			strGapDate = strGapDate.substring(0, strGapDate.length()-1);
		}
		
		return strGapDate;
	}	
	
	public static String getCurDateMinus(String yyyymmdd, int arg) throws ParseException{
		
		String rtn_dt = "";
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		cal.setTime(sf.parse(yyyymmdd));
		
		cal.add(Calendar.DATE, arg);
		
		rtn_dt = sf.format(cal.getTime());
		
		return rtn_dt;
	}
	
	// HHMM Validation
	public static boolean checkHHMM(String hhmm) throws ParseException{
		
		boolean bCheck = false;
		
		if ( hhmm.length() == 4) {
			
			if ( CommonUtil.NumberChk(hhmm) ) {
				
				if ( Integer.parseInt(hhmm.substring(0, 2)) >= 00 && Integer.parseInt(hhmm.substring(0, 2)) <= 23 ) {
					if ( Integer.parseInt(hhmm.substring(2, 4)) >= 00 && Integer.parseInt(hhmm.substring(2, 4)) <= 59 ) {						
						bCheck = true;
					}
				}
			}			
		}		
		
		return bCheck;		
	}
	
	// YYYYMMDD Validation
	public static boolean checkYYYYMMDD(String yyyymmdd) throws ParseException{
		
		boolean bCheck = false;
		
		if ( yyyymmdd.length() == 8) {
			
			if ( CommonUtil.NumberChk(yyyymmdd) ) {
				
				SimpleDateFormat dataFormatParser = new SimpleDateFormat("yyyyMMdd");
				
				try {
					
					dataFormatParser.parse(yyyymmdd);
					
					bCheck = true;
					
				} catch (Exception e) {
					
				}				
			}			
		}		
		
		return bCheck;		
	}
}