<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/jsp/common/inc/header.jsp" %>

<%
    Map<String, Object> paramMap = CommonUtil.collectParameters(request);

    String aGb[] = null;
    String aGb_s[] = null;

    String sTmp = "";
    String no_auth = S_NO_AUTH;
%>

<link href="<%=request.getContextPath() %>/css/ftree/ui.sidebar.css" rel="stylesheet" type="text/css"/>
<meta name="viewport" content="initial-scale=1.0">
<div id="leftTree_M" >
    <div class="sidebar">
    <ul class="nav-links" id = "nav-links">
        <%
		aGb = CommonUtil.getMessage("CATEGORY.GB").split(",");
		for(int n=0;n<aGb.length;n++) {
			String f_nm = CommonUtil.getMessage("CATEGORY.GB." + aGb[n]);

			if(!S_USER_GB.equals("99") && aGb[n].equals("06")) continue;

            // 작업 통제 여부
            if ( CommonUtil.isNull(request.getSession().getAttribute("BATCH_CONTROL")).equals("Y") && aGb[n].equals("02") ) continue;

%>
        <li class="showMenu">
            <div class="iocn-link">
                <a>
                    <i class='tree_c_<%=aGb[n] %>'></i>
                    <span class='link_name' id='tree_c_<%=aGb[n] %>'><%=f_nm %></span>
                </a>
                <i class='bx bxs-chevron-down arrow'></i>
            </div>
            <ul class="sub-menu">
                <li><a class="link_name" href="#"><%=f_nm %></a></li>
                <%
                    aGb_s = CommonUtil.getMessage("CATEGORY.GB." + aGb[n] + ".GB").split(",");

                    for (int i = 0; i < aGb_s.length; i++) {
                        String nm = CommonUtil.getMessage("CATEGORY.GB." + aGb[n] + ".GB." + aGb_s[i]);
                        // 권한 제한에 걸릴 경우 메뉴 노출 X
                        if (!no_auth.equals("") && no_auth.contains(aGb_s[i]) && !(S_USER_GB.equals("99"))) {
                            continue;
                        }

                        String[] arr_nm = nm.split(",");

                        if (aGb_s[i].equals("0616") && !(S_USER_GB.equals("99") && S_USER_ID.equals("admin"))) {
                            continue;
                        }

                        // 사용자 구분과 동일한 권한
                        // arr_nm[2] 00 : 모든 권한 조회
                        //if ( arr_nm[2].equals(S_USER_GB) || arr_nm[2].equals("00") || S_USER_GB.equals("02") || S_USER_GB.equals("99") ) {
                        if (arr_nm[2].indexOf(S_USER_GB) > -1 || arr_nm[2].equals("00")) {
                %>
                        <li id='tree_c_<%=aGb[n] %>_<%=aGb_s[i] %>'>
                            <a href='#' onclick="addTab('c','<%=arr_nm[0] %>','<%=aGb[n] %>','<%=aGb_s[i] %>','<%=arr_nm[1]%>');">
                                <span>
                                    <span style="width:100px;"><%=arr_nm[0] %></span>
                                </span>
                            </a>
                        </li>
                <%
                        }
                    }
                %>
                 </ul>   </li>
                <%
			}
%>
    </ul></div>
</div>
<script>
    var arrow = document.querySelectorAll(".arrow");

    for (var i = 0; i < arrow.length; i++) {
        arrow[i].addEventListener("click", (e) => {
            let arrowParent = e.target.parentElement.parentElement;//selecting main parent of arrow
            arrowParent.classList.toggle("showMenu");
        });
    }

    document.addEventListener('DOMContentLoaded', function() {
        const navLinks = document.querySelectorAll('.sub-menu li');

        navLinks.forEach(function(link) {
            link.addEventListener('click', function() {
                // 모든 li에서 'clicked' 클래스를 제거
                navLinks.forEach(function(otherLink) {
                    otherLink.classList.remove('clicked');
                });

                // 현재 클릭된 li에만 'clicked' 클래스를 추가
                this.classList.add('clicked');
            });
        });
    });

    //sidebarBtn.addEventListener("click", ()=>{
    //sidebar.classList.toggle("close");
    //});
</script>
<script type='text/javascript'>

    $('#leftTree_M > ul').height(800).css('overflowX','hidden');

    var resizeLeft = function () {
        setTimeout(function () {
		$('#leftTree_M > ul').height($('#ly_left').height()-1200).css('overflowX','auto');

            if ($('#leftTree_M').data('init') != 'Y') {
                $('#leftTree_M').data('init', 'Y');

                var tree = $('#leftTree_M').fancytree('getTree');
                var focusKey = tree.getPersistData()['focus'];
                if (focusKey != null && focusKey != '') tree.activateKey(focusKey);
            }

        }, 500);
    };

$('#leftTree_M > ul').height(2000).css('overflowX','hidden');
    $("#leftTree_M").fancytree({
        extensions: ["persist"]
        , persist: {
            cookiePrefix: "leftTree_M"
            , store: "cookie"
        }
        , clickFolderMode: 2
        , selectMode: 1
        , init: function (e, d) {
            $(window).unbind('resizestop').bind('resizestop', resizeLeft);
            //resizeLeft.call();

        }
        , hover: function (event, data) {

            $(data.node.span).find(".fancytree-title").css("background-color", "#c4dcff");
        }
        // 클릭 이벤트 핸들러 추가 : 선택한 노드를 굵게 표시 (2024.03.26 강명준)
        , click: function (event, data) {

            // 폴더가 아닐 때만 볼드 처리
            if (!data.node.isFolder()) {

                // 이전에 굵게 표시된 노드의 스타일을 원래대로 되돌림
                $(".fancytree-title").css("font-weight", "normal");
                $(".fancytree-title a").css("color", "#666666");

                // 클릭한 노드의 텍스트를 굵게 처리
                $(data.node.span).find(".fancytree-title").css("font-weight", "bold");
                $(data.node.span).find(".fancytree-title a").css("color", "#000000");
                $(data.node.span).find(".fancytree-title a").css("border-bottom", "1px solid silver");
                $(data.node.span).find(".sub-menu").prepend('<img src="/css/ftree/star.png" id="chk_img" style="margin-left:-10px"/>');
            }
    }
});

</script>
