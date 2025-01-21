function fn_check_days(month_days, days_cal) {

	if ( month_days.value != "" && month_days.value != "ALL" ) {
	
		idxSu 		= 0;
		idxGi 		= 0;
		idxPlus 	= 0;
		idxMinus 	= 0;
		idxP_D 		= 0;
		idxM_D 		= 0;
		idxP_L 		= 0;
		idxM_L 		= 0;
		
		arrSu 		= new Array();
		arrGi 		= new Array();
		arrPlus 	= new Array();
		arrMinus 	= new Array();
		arrP_D 		= new Array();
		arrM_D 		= new Array();
		arrP_L 		= new Array();
		arrM_L 		= new Array();
	
		chkSu 		= "F";
		chkPM_Su 	= "F";
		chkCalTF 	= "F";
	
		special_character = "";
	
		month_days_check = "TRUE";
	
		var arr_month_days = month_days.value.split(",");
	
		for ( var i = 0; i < arr_month_days.length; i++ ) {
			if(fnMDayChk(arr_month_days[i])) {
				month_days_check = "FALSE";
			}
		}
	
		if ( month_days_check == "FALSE" ) {
			alert("실행날짜는 1~31 사이의 값과 '+, -, >, <, D, L' 옵션을 ','로 구분하여 입력하셔야 합니다.\n'ALL' 옵션은 단독으로 사용 가능합니다.");
			month_days.focus();
			return false;
		}
	
		var month_days_duplicate_check = "TRUE";
		
		for ( var i = 0; i < arrGi.length; i++ ) {
			for ( var j = 0; j < arrSu.length; j++ ) {
				if(arrGi[i] == arrSu[j]) {
					month_days_duplicate_check = "FALSE";
				}
			}
		}
	
		if ( month_days_duplicate_check == "FALSE" ) {
			alert("'+, -' 옵션사용시에는 일반날짜와 중복값을 입력할 수 없습니다.");
			month_days.focus();
			return false;
		}
	
		var month_days_duplicate2_check = "TRUE";
		
		for ( var i = 0; i < arrPlus.length; i++ ) {
			for ( var j = 0; j < arrMinus.length; j++ ) {
				if ( arrPlus[i] == arrMinus[j] ) {
					month_days_duplicate2_check = "FALSE";
				}
			}
		}
	
		for ( var i = 0; i < arrP_D.length; i++ ) {
			for ( var j = 0; j < arrM_D.length; j++ ) {
				if ( arrP_D[i] == arrM_D[j] ) {
					month_days_duplicate2_check = "FALSE";
				}
			}
		}
	
		for ( var i = 0; i < arrP_L.length; i++ ) {
			for ( var j = 0; j < arrM_L.length; j++ ) {
				if ( arrP_L[i] == arrM_L[j] ) {
					month_days_duplicate2_check = "FALSE";
				}
			}
		}
	
		if ( month_days_duplicate2_check == "FALSE" ) {
			alert("옵션 '+, -'에 서로 중복값을 입력할 수 없습니다.");
			month_days.focus();
			return false;
		}
	
		if ( special_character == "true" && days_cal.value == "" ) {
			alert("'+, -, >, <, D, L' 옵션을 사용시에는 월 캘린더를 필수로 선택하셔야 합니다.");
			days_cal.focus();
			return false;
		}
	}

}

function fn_check_weeks(week_days, weeks_cal) {
	
	var week_days_text = document.getElementById("week_days_text");
	
	if ( week_days.value != "" ) { 
	
		idxSu 		= 0;
		idxGi 		= 0;
		idxPlus 	= 0;
		idxMinus 	= 0;
		idxP_D 		= 0;
		idxM_D 		= 0;
		idxP_L 		= 0;
		idxM_L 		= 0;
		
		arrSu 		= new Array();
		arrGi 		= new Array();
		arrPlus 	= new Array();
		arrMinus 	= new Array();
		arrP_D 		= new Array();
		arrM_D 		= new Array();
		arrP_L 		= new Array();
		arrM_L 		= new Array();
	
		chkSu 		= "F";
		chkPM_Su 	= "F";
		chkCalTF 	= "F";
	
		special_character = "";
	
		week_days_check = "TRUE";
		
		// 실행요일 맨 앞에 콤마가 있을 경우 콤마를 제외하고 체크를 해야 한다.		
		if ( week_days.value.substring(0, 1) == "," ) {
			week_days.value = week_days.value.substring(1, week_days.length);
		}
	
		var arr_week_days = week_days.value.split(",");
	
		for ( var i = 0; i < arr_week_days.length; i++ ) {
			if(fnWDayChk(arr_week_days[i])) {
				week_days_check = "FALSE";
			}
		}
		
		if ( (week_days.value.indexOf("ALL") > -1) && (week_days.value.length > 3) ) {
			alert("실행요일에 ALL 을 사용할 경우 그 외 옵션은 사용 불가합니다.");
			week_days_text.focus();
			return false;
		}
	
		if ( week_days_check == "FALSE" ) {
			alert("실행요일은 0~6 사이의 값 또는 '+, -, >, <, D, L, D숫자W숫자' \n형식의 명령어를 ','로 구분하여 입력하셔야 합니다.\n'ALL' 옵션은 단독으로 사용 가능합니다.");
			week_days_text.focus();
			return false;
		}
	
		var week_days_duplicate_check = "TRUE";
		
		for ( var i = 0; i < arrGi.length; i++ ) {
			for ( var j = 0; j < arrSu.length; j++ ) {
				if(arrGi[i] == arrSu[j]) {
					week_days_duplicate_check = "FALSE";
				}
			}
		}
	
		if ( week_days_duplicate_check == "FALSE" ) {
			alert("'+, -' 옵션사용시에는 일반날짜와 중복값을 입력할 수 없습니다.");
			week_days_text.focus();
			return false;
		}
	
		var week_days_duplicate2_check = "TRUE";
		
		for ( var i = 0; i < arrPlus.length; i++ ) {
			for ( var j = 0; j < arrMinus.length; j++ ) {
				if ( arrPlus[i] == arrMinus[j] ) {
					week_days_duplicate2_check = "FALSE";
				}
			}
		}
	
		for ( var i = 0; i < arrP_D.length; i++ ) {
			for ( var j = 0; j < arrM_D.length; j++ ) {
				if ( arrP_D[i] == arrM_D[j] ) {
					week_days_duplicate2_check = "FALSE";
				}
			}
		}
	
		for ( var i = 0; i < arrP_L.length; i++ ) {
			for ( var j = 0; j < arrM_L.length; j++ ) {
				if ( arrP_L[i] == arrM_L[j] ) {
					week_days_duplicate2_check = "FALSE";
				}
			}
		}
	
		if ( week_days_duplicate2_check == "FALSE" ) {
			alert("옵션 '+, -'에 서로 중복값을 입력할 수 없습니다.");
			week_days_text.focus();
			return false;
		}
	
		if ( special_character == "true" && weeks_cal.value == "" ) {
			alert("'+, -, >, <, D, L' 옵션을 사용시에는 월 캘린더를 필수로 선택하셔야 합니다.");
			weeks_cal.focus();
			return false;
		}
	}

}

var idxSu 		= 0;
var idxGi 		= 0;
var idxPlus 	= 0;
var idxMinus 	= 0;
var idxP_D 		= 0;
var idxM_D 		= 0;
var idxP_L 		= 0;
var idxM_L 		= 0;

var arrSu 		= new Array();
var arrGi 		= new Array();
var arrPlus 	= new Array();
var arrMinus 	= new Array();
var arrP_D 		= new Array();
var arrM_D 		= new Array();
var arrP_L 		= new Array();
var arrM_L 		= new Array();

var chkSu 		= "F";
var chkPM_Su 	= "F";
var chkCalTF 	= "F";

var special_character = "";

function fnMDayChk(Mday) {
	
	if(IsInteger(Mday)) {
		if(0 < parseInt(Mday) && 32 > parseInt(Mday)) {
			arrSu[idxSu] = Mday;
			idxSu++;
			return false;
		}else {
			return true;
		}
	}else {
		var pre = Mday.substring(0, 1);
		var nxt = Mday.substring(1, Mday.length);

		if("+" == pre || "-" == pre || ">" == pre || "<" == pre || "D" == pre || "L" == pre) {
			special_character = "true";
			if(IsInteger(nxt)) {
				if(0 < parseInt(nxt) && 32 > parseInt(nxt)) {
					if("+" == pre || "-" == pre) {
						arrGi[idxGi] = nxt;
						idxGi++;
						
						if("+" == pre) {
							arrPlus[idxPlus] = nxt;
							idxPlus++;
						}else if("-" == pre) {
							arrMinus[idxMinus] = nxt;
							idxMinus++;
						}
					}else if("D" == pre) {
						arrP_D[idxP_D] = nxt;
						idxP_D++;
					}else if("L" == pre) {
						arrP_L[idxP_L] = nxt;
						idxP_L++;
					}

					chkSu = "T";
					chkCalTF = "T";
					return false;
				}else {
					return true;
				}
			}else {
				pre = Mday.substring(0, 2);
                nxt = Mday.substring(2, Mday.length);

				if("-D" == pre || "-L" == pre) {
					if(IsInteger(nxt)) {
						if(0 < parseInt(nxt) && 32 > parseInt(nxt)) {
							if("-D" == pre) {
								arrM_D[idxM_D] = nxt;
								idxM_D++;
							}else if("-L" == pre) {
								arrM_L[idxM_L] = nxt;
								idxM_L++;
							}

							chkSu = "T";
							chkCalTF = "T";
							return false;
						}else {
							return true;
						}
					}else {
						return true;
					}
				}else {
					return true;
				}
			}
		}else {
			return true;
		}
	}
}

function fnWDayChk(Wday) {

	if(Wday.length == 4) {
		if("D" == Wday.substring(0,1) && "W" == Wday.substring(2,3)) {
			if(IsInteger(Wday.substring(1,2)) && IsInteger(Wday.substring(3,4))) {
				if( (-1 < parseInt(Wday.substring(1,2)) && 7 > parseInt(Wday.substring(1,2))) && (0 < parseInt(Wday.substring(3,4)) && 7 > parseInt(Wday.substring(3,4))) ) {
					return false;
				}else {
					return true;
				}
			}else {
				return true;
			}
		}else {
			return true;
		}
	}else if(IsInteger(Wday)) {
		if(-1 < parseInt(Wday) && 7 > parseInt(Wday)) {
			arrSu[idxSu] = Wday;
			idxSu++;
			return false;
		}else {
			return true;
		}
	} else if (Wday == "ALL") {
		
	}else {
		var pre = Wday.substring(0, 1);
		var nxt = Wday.substring(1, Wday.length);

		if("+" == pre || "-" == pre || ">" == pre || "<" == pre || "D" == pre || "L" == pre) {
			special_character = "true";
			if(IsInteger(nxt)) {
				if(-1 < parseInt(nxt) && 7 > parseInt(nxt)) {
					if("+" == pre || "-" == pre) {
						arrGi[idxGi] = nxt;
						idxGi++;
						
						if("+" == pre) {
							arrPlus[idxPlus] = nxt;
							idxPlus++;
						}else if("-" == pre) {
							arrMinus[idxMinus] = nxt;
							idxMinus++;
						}
					}else if("D" == pre) {
						arrP_D[idxP_D] = nxt;
						idxP_D++;
					}else if("L" == pre) {
						arrP_L[idxP_L] = nxt;
						idxP_L++;
					}

					chkSu = "T";
					chkCalTF = "T";
					return false;
				}else {
					return true;
				}
			}else {
				pre = Wday.substring(0, 2);
                nxt = Wday.substring(2, Wday.length);

				if("-D" == pre || "-L" == pre) {
					if(IsInteger(nxt)) {
						if(-1 < parseInt(nxt) && 7 > parseInt(nxt)) {
							if("-D" == pre) {
								arrM_D[idxM_D] = nxt;
								idxM_D++;
							}else if("-L" == pre) {
								arrM_L[idxM_L] = nxt;
								idxM_L++;
							}

							chkSu = "T";
							chkCalTF = "T";
							return false;
						}else {
							return true;
						}
					}else {
						return true;
					}
				}else {
					return true;
				}
			}
		}else {
			return true;
		}
	}
}

/*-------------------------------------------------
0~9의 숫자 값인지 체크
-------------------------------------------------*/
function IsInteger(st){
    if ( !IsEmpty(st) ){
          for (j=0; j<st.length; j++) {
             if (((st.substring(j, j+1) < "0") || (st.substring(j, j+1) > "9")))
            return false;
          }
    } else {
          return false ;
    }
    return true ;
}

/*-------------------------------------------------
스페이스 체크
-------------------------------------------------*/
function IsEmpty(toCheck){
     var chkstr = toCheck + "";
     var is_Space = true ;
     if ( ( chkstr == "") || ( chkstr == null ) )
       return false ;

     for ( j = 0 ; is_Space &&  ( j < chkstr.length ) ; j++){

             if( chkstr.substring( j , j+1 ) != " " )
               is_Space = false ;
     }

     return ( is_Space );
}