<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="reservation.SeasonVO" %>
<%@ page import="admin.CommonDAO" %>
<%
request.setCharacterEncoding("UTF-8");

Calendar cal = Calendar.getInstance();
String year = cal.get(Calendar.YEAR)+"";
String seasonCode = "";
String startSeason = "";
String endSeason = "";

Vector<SeasonVO> vSeason = null;
SeasonVO season = null;

String cmd = request.getParameter("cmd")==null?"list":request.getParameter("cmd");
String msg = "";

if(!cmd.equals("list")){
	msg = CommonDAO.getInstance().processSeason(request);	
}
%>
<html>
<head>
<title>예약환경설정</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<link rel="icon" href="/favicon.ico" type="image/x-icon" />
<link rel="shortcut icon" href="/images/favicon.png" type="image/x-icon" />
<link rel="apple-touch-icon" href="/images/apple-touch-icon.png" />
<link rel='stylesheet' type='text/css' href='/admin/css/admin.css'>
<script language=javascript src='/admin/js/common.js'></script>
<script language=javascript src='/admin/js/admin.js'></script>
</head>

<body bgcolor='#FFFFFF' topmargin='0' leftmargin='0'>

        <!-- 상단 TOP Menu S -->
        <jsp:include page="/admin/common/menu_top.jsp" />
        <!-- 상단 TOP Menu E -->

	<table border=0 cellpadding=0 cellspacing=0 width=800>
			<tr valign=top>
				<td width=175 bgcolor=F7F7F7>
					<!--왼쪽 타이틀------------------------------------------------->
					<jsp:include page="/admin/common/menu_left.jsp" />
					<!--//왼쪽 타이틀------------------------------------------------->
					
				</td>
				<td width=18><img src=/admin/img/e.gif width=18></td>
				<td width="100%">
				<td align="left" width="50%">
	

<script type="text/javascript" src="/admin/js/reservation_product.js"></script>
<script type="text/javascript" src="/admin/js/calendar.js"></script>
<script type="text/javascript">
	var cal = null;
	
	function submitSave(){
		// 날짜 체크
		var trs = document.getElementsByTagName( 'div' );

		for( var i = 0 , trname = null , ipts = null , from = null , to = null , typestr = null ; i < trs.length ; i++ )
		{

			trname = trs[ i ].getAttribute( 'name' );
			if( !trname ) continue;

            if(trname.lastIndexOf("weekend") >= 0)
                continue;

			ipts = trs[ i ].getElementsByTagName( 'input' );
			if( ipts.length < 2 ) continue;

            var useFlag='T';
            for(var jj=0; jj < ipts.length; jj++){
                iptsName = ipts[jj].getAttribute( 'name' );

                from = ipts[ ++jj ];
                to = ipts[ ++jj ];

                switch( trname )
                {
	                case 'busyMiddleFrom' :
	                	 if( !from.value ) return alert( '준성수기 기간 시작일을 입력해 주세요' );
	                     if( !to.value ) return alert( '준성수기 기간 종료일을 입력해 주세요' );
	                     break;
	                     
                    case 'busyFrom' :
                        if( !from.value ) return alert( '성수기 기간 시작일을 입력해 주세요' );
                        if( !to.value ) return alert( '성수기 기간 종료일을 입력해 주세요' );
                        break;

                    default :
                        continue;
                        break;
                }

                var fromDates = from.value.split( '-' );
                if( fromDates.length > 2 ) {
                    fromDates[ 0 ] = parseInt( fromDates[ 0 ] );
                    fromDates[ 1 ] = ( fromDates[ 1 ].substr( 0 , 1 ) == '0' ? parseInt( fromDates[ 1 ].substr( 1 , 1 ) ) : parseInt( fromDates[ 1 ] ) );
                    fromDates[ 2 ] = ( fromDates[ 2 ].substr( 0 , 1 ) == '0' ? parseInt( fromDates[ 2 ].substr( 1 , 1 ) ) : parseInt( fromDates[ 2 ] ) );
                }

                var toDates = to.value.split( '-' );
                if( toDates.length > 2 ) {
                    toDates[ 0 ] = parseInt( toDates[ 0 ] );
                    toDates[ 1 ] = ( toDates[ 1 ].substr( 0 , 1 ) == '0' ? parseInt( toDates[ 1 ].substr( 1 , 1 ) ) : parseInt( toDates[ 1 ] ) );
                    toDates[ 2 ] = ( toDates[ 2 ].substr( 0 , 1 ) == '0' ? parseInt( toDates[ 2 ].substr( 1 , 1 ) ) : parseInt( toDates[ 2 ] ) );
                }

                if( ( fromDates.length > 2 ) && ( fromDates.length > 2 ) ) {
                    var fdObj = new Date( fromDates[0] , fromDates[1] -1 , fromDates[2] );
                    var tdObj = new Date( toDates[0] , toDates[1] -1 , toDates[2] );

                    if( tdObj.getTime() < fdObj.getTime() ) return alert( '시작일은 종료일보다 과거여야 합니다.' );
                }

            }



		}
		
		var f = document.commonInfoForm;
		f.submit();
	}

	function submitCommonInfo()
	{
	
		// 결제 수단 체크
		var mt = document.getElementsByName( 'chargedType[]' );
		for( var i = 0 , checked = false ; i < mt.length ; i++ ) checked = checked || mt[ i ].checked;
		if( !checked )
		{
			mt[ 0 ].checked = true;
			mt[ 0 ].focus();
			return alert( '결제 수단을 하나 이상 선택해 주세요' );
		}

		// 날짜 체크
		var trs = document.getElementsByTagName( 'div' );

		for( var i = 0 , trname = null , ipts = null , from = null , to = null , typestr = null ; i < trs.length ; i++ )
		{

			trname = trs[ i ].getAttribute( 'name' );
			if( !trname ) continue;

            if(trname.lastIndexOf("weekend") >= 0)
                continue;

			ipts = trs[ i ].getElementsByTagName( 'input' );
			if( ipts.length < 2 ) continue;

            var useFlag='T';
            for(var jj=0; jj < ipts.length; jj++){
                iptsName = ipts[jj].getAttribute( 'name' );

                if(iptsName.lastIndexOf("deleted_rows") >= 0 || iptsName.lastIndexOf("CalUseFlag") >= 0) {
                    useFlag = ipts[jj].value;
                    continue;
                }

                if(iptsName.lastIndexOf("seasonExSpecial") >= 0) {
                    continue;
                }

                //삭제된 기간 처리
                if(useFlag == 'F'){
                    jj++;
                    useFlag = 'T';
                    continue;
                }

                from = ipts[ jj ];
                to = ipts[ ++jj ];

                switch( trname )
                {
                    case 'seasonFromCal' :
                        typestr = '예약가능 기간';
                        if( document.getElementById( 'useSeasonT' ).checked && !from.value ) return alert( '예약가능 기간 시작일을 입력해 주세요' );
                        if( document.getElementById( 'useSeasonT' ).checked && !to.value ) return alert( '예약가능 기간 종료일을 입력해 주세요' );
                        break;

                    case 'seasonExFrom' :
//                        if( !from.value && !to.value ) continue;
                        if( document.getElementById( 'useExSeasonT' ).checked && !from.value ) return alert( '예약제외 기간 시작일을 입력해 주세요' );
                        if( document.getElementById( 'useExSeasonT' ).checked && !to.value ) return alert( '예약제외 기간 종료일을 입력해 주세요' );
                        break;

                    case 'busyFrom' :
                        if( document.getElementById( 'useBusyT' ).checked && !from.value ) return alert( '성수기 기간 시작일을 입력해 주세요' );
                        if( document.getElementById( 'useBusyT' ).checked && !to.value ) return alert( '성수기 기간 종료일을 입력해 주세요' );
                        break;

                    default :
                        continue;
                        break;
                }

                var fromDates = from.value.split( '-' );
                if( fromDates.length > 2 ) {
                    fromDates[ 0 ] = parseInt( fromDates[ 0 ] );
                    fromDates[ 1 ] = ( fromDates[ 1 ].substr( 0 , 1 ) == '0' ? parseInt( fromDates[ 1 ].substr( 1 , 1 ) ) : parseInt( fromDates[ 1 ] ) );
                    fromDates[ 2 ] = ( fromDates[ 2 ].substr( 0 , 1 ) == '0' ? parseInt( fromDates[ 2 ].substr( 1 , 1 ) ) : parseInt( fromDates[ 2 ] ) );
                }

                var toDates = to.value.split( '-' );
                if( toDates.length > 2 ) {
                    toDates[ 0 ] = parseInt( toDates[ 0 ] );
                    toDates[ 1 ] = ( toDates[ 1 ].substr( 0 , 1 ) == '0' ? parseInt( toDates[ 1 ].substr( 1 , 1 ) ) : parseInt( toDates[ 1 ] ) );
                    toDates[ 2 ] = ( toDates[ 2 ].substr( 0 , 1 ) == '0' ? parseInt( toDates[ 2 ].substr( 1 , 1 ) ) : parseInt( toDates[ 2 ] ) );
                }

                if( ( fromDates.length > 2 ) && ( fromDates.length > 2 ) ) {
                    var fdObj = new Date( fromDates[0] , fromDates[1] -1 , fromDates[2] );
                    var tdObj = new Date( toDates[0] , toDates[1] -1 , toDates[2] );

                    if( tdObj.getTime() < fdObj.getTime() ) return alert( '시작일은 종료일보다 과거여야 합니다.' );
                }

            }



		}

		// 주말 설정 체크
		if( document.getElementById( 'useWeekendT' ).checked )
		{
			var days = null;
			var ipts = document.getElementsByTagName( 'input' );
			for( var i = 0 ; i < ipts.length ; i++ ) if( ipts[ i ].getAttribute( 'name' ) == 'busyWeek' ) days = ipts[ i ];

			if( !/[\d]{1}~[\d]{1}/.test( days.value ) ) return alert( '주말을 입력해 주세요' );
		}

        if(document.getElementById('reservationCancleAuthFlagC').checked == false && document.getElementById('reservationCancleAuthFlagU').checked == false && document.getElementById('reservationCancleAuthFlagA').checked == false) {
            return alert('결제완료건 예약취소 권한을 선택해주세요.');
        }


		if( !confirm( '변경된 정보를 저장하시겠습니까?' ) ) return;

		var f = document.commonInfoForm;
		f.submit();
	}

	function startCalendar()
	{
		if( !cal ) cal = new Calendar('http://builderdemo04.cafe24.com/chtml/holidays.php' , true );
	}
	/*
	*	공휴일 팝업
	*/
	function holidayPopupLayer(){
		window.open('/chtml/reservation/reservation_holiday_list.php','holiday_list','toolbar=no,scrollbars=no,width=300,height=200');
	}

	/*
	*	주말 설정환경 테이블 UI 변경.- 상세/간단 -> 다름 함수로 대체, 사용안함
	*/
	function displayWeekendEnvDiv_(e,weekEndSimpleEnv){
		if(weekEndSimpleEnv == 'T'){ // 주말 간단 설정
			alert('간단 설정으로 저장하기를 하실경우 상세 설정의 요금제는 반영되지 않습니다.');

			var srcE = e.target ? e.target : e.srcElement;
			var tb = srcE.offsetParent.offsetParent;

			for( var i = 0 , rName = '' ; i < tb.rows.length ; i++ )
			{
				rName = tb.rows[ i ].getAttribute( 'name' );
				if( !rName ) continue;
				if( rName != 'WeekendSimpleEnv' ) continue;
				for( var j = 0 ; j < tb.rows[ i ].childNodes.length ; j++ )
				{
					tb.rows[ i ].childNodes.item( j ).style.display = '';
                    alert(tb.rows[ i ].childNodes.item( j ).getAttribute('name'));
				}
				tb.rows[ i ].style.display = '';
                document.getElementById("id_week").style.display = '';
			}

			for( var i = 0 , rName = '' ; i < tb.rows.length ; i++ )
			{
				rName = tb.rows[ i ].getAttribute( 'name' );
				if( !rName ) continue;
				if( rName != 'WeekendDetailEnv' ) continue;
				for( var j = 0 ; j < tb.rows[ i ].childNodes.length ; j++ )
				{
					tb.rows[ i ].childNodes.item( j ).style.display = 'none';
				}
				tb.rows[ i ].style.display = 'none';
			}
/*
			document.getElementsByName('WeekendSimpleEnv')[0].style.display='';
			var trArray = document.getElementsByName('WeekendDetailEnv');
			for(var i=0;i<trArray.length;i++){
				trArray[i].style.display='none';
			}
*/
            document.getElementById("weekendF").style.display = "none";
            document.getElementById("weekendT").style.display = "block";

		}else if (weekEndSimpleEnv == 'F'){ // 주말 상세 설정
			alert('상세 설정으로 저장하기를 하실경우 간단 설정의 요금제는 반영되지 않습니다.');
			var srcE = e.target ? e.target : e.srcElement;
			var tb = srcE.offsetParent.offsetParent;

			for( var i = 0 , rName = '' ; i < tb.rows.length ; i++ )
			{
				rName = tb.rows[ i ].getAttribute( 'name' );
				if( !rName ) continue;
				if( rName != 'WeekendDetailEnv' ) continue;
				for( var j = 0 ; j < tb.rows[ i ].childNodes.length ; j++ )
				{
					tb.rows[ i ].childNodes.item( j ).style.display = '';
				}
				tb.rows[ i ].style.display = '';
			}

			for( var i = 0 , rName = '' ; i < tb.rows.length ; i++ )
			{
				rName = tb.rows[ i ].getAttribute( 'name' );
				if( !rName ) continue;
				if( rName != 'WeekendSimpleEnv' ) continue;
				for( var j = 0 ; j < tb.rows[ i ].childNodes.length ; j++ )
				{
					tb.rows[ i ].childNodes.item( j ).style.display = 'none';
				}
				tb.rows[ i ].style.display = 'none';
			}
/*
			document.getElementsByName('WeekendSimpleEnv')[0].style.display='none';
			var trArray = document.getElementsByName('WeekendDetailEnv');
			for(var i=0;i<trArray.length;i++){
				trArray[i].style.display='';
			}
*/

            document.getElementById("weekendF").style.display = "none";
            document.getElementById("weekendT").style.display = "block";

		} else{ // 주말 설정 사용안함, 2011-06-23

			var srcE = e.target ? e.target : e.srcElement;
			var tb = srcE.offsetParent.offsetParent;

			for( var i = 0 , rName = '' ; i < tb.rows.length ; i++ )
			{
				rName = tb.rows[ i ].getAttribute( 'name' );
				if( !rName ) continue;
                if(rName == 'WeekendSimpleEnv' || rName == 'WeekendDetailEnv'){
                    for( var j = 0 ; j < tb.rows[ i ].childNodes.length ; j++ )
                    {
                        tb.rows[ i ].childNodes.item( j ).style.display = 'none';
                    }
                    tb.rows[ i ].style.display = 'none';
                }
			}

            document.getElementById("weekendF").style.display = "block";
            document.getElementById("weekendT").style.display = "none";
        }
	}

    function displayWeekendEnvDiv(e,weekEndSimpleEnv){

		if(weekEndSimpleEnv == 'T'){ // 주말 간단 설정
			alert('간단 설정으로 저장하기를 하실경우 상세 설정의 요금제는 반영되지 않습니다.');

            document.getElementById("id_week").style.display = '';
            document.getElementById("id_weekd").style.display = 'none';

            document.getElementById("weekendF").style.display = "none";
            document.getElementById("weekendT").style.display = "block";

		}else if (weekEndSimpleEnv == 'F'){ // 주말 상세 설정
			alert('상세 설정으로 저장하기를 하실경우 간단 설정의 요금제는 반영되지 않습니다.');

            document.getElementById("id_week").style.display = 'none';
            document.getElementById("id_weekd").style.display = '';

            document.getElementById("weekendF").style.display = "none";
            document.getElementById("weekendT").style.display = "block";

		} else{ // 주말 설정 사용안함, 2011-06-23

            document.getElementById("id_week").style.display = 'none';
            document.getElementById("id_weekd").style.display = 'none';

            document.getElementById("weekendF").style.display = "block";
            document.getElementById("weekendT").style.display = "none";
        }
	}


if( window.attachEvent )
{
	window.attachEvent( 'onload' , startCalendar );
}
else
{
	window.addEventListener( 'load' , startCalendar , false );
}

    function addRows(type){
        var addRow = "";

        var rowCnt = document.getElementsByName(type+"From_add[]").length;

        addRow += '<span id="'+type+'addCalRow'+rowCnt+'">';
        addRow += '<br>';
        addRow += '<input type="hidden" id="'+type+'addCalUseFlag'+rowCnt+'" name="'+type+'addCalUseFlag[]" value="T">';
        addRow += '<input type="text" id="'+type+'From_add'+rowCnt+'" size="12" name="'+type+'From_add[]" value="" onfocus="blur()">&nbsp;';
        addRow += '<img src="/admin/img/reservation/btn_calendar.gif" class="linked" align="middle" onclick="cal.toggle( event , this.previousSibling.previousSibling);" alt="달력">&nbsp; 부터 &nbsp;&nbsp;';
        addRow += '<input type="text" id="'+type+'To_add'+rowCnt+'" size="12" name="'+type+'To_add[]" value="" onfocus="blur()" >&nbsp;';
        addRow += '<img src="/admin/img/reservation/btn_calendar.gif" class="linked" align="middle" onclick="cal.toggle( event , this.previousSibling.previousSibling);" alt="달력">&nbsp; 까지  &nbsp;&nbsp;&nbsp;';

        addRow += '<img src="/admin/img/btn_add.gif" class="linked" align="absmiddle" onclick="addRows(\''+type+'\');" alt="추가">&nbsp;';
        addRow += '<img src="/admin/img/btn_del.gif" class="linked" align="absmiddle" onclick="deleteRows(\''+type+'add\', '+rowCnt+');" alt="삭제">';
        addRow += '</span>';

        document.getElementById(type+"AddDate").innerHTML += addRow;
    }

    function deleteRows(type, num){

        document.getElementById(type+"CalRow"+num).style.display = 'none';

        if(type.indexOf("add") < 0){
            document.getElementById("deleted_rows["+num+"]").value = num;
        }

        document.getElementById(type+"CalUseFlag"+num).value = 'F';
    }

    function showDisplayDate(type, flag){

        if(flag == 'T'){
            document.getElementById(type).style.display = 'block';
        }else {
            document.getElementById(type).style.display = 'none';
        }
    }

    function checkNonMember(obj) {
        if(obj.value == '1') {
            document.getElementById('memberConfirmLayer').style.display = 'none';
        }
        else if(obj.value == '2') {
            document.getElementById('memberConfirmLayer').style.display = 'block';
        }
    }


</script>

<style type="text/css">@import url(/admin/css/calendar.css);</style>
<style type="text/css">@import url(/admin/css/text_button.css);</style>

<!--본문 타이틀------------------------------------------------------------>
<ul class="content_title">
	<li>예약환경설정</li>
	<li class="location">캠핑장관리>기본정보>예약환경설정</li>
</ul>

<!--본문---------------------------------------------------------------------->
<form name="commonInfoForm" method="post">
<input type="hidden" name="cmd" >

<ul class="bullet_title"><li style="font-weight:normal;">준성수기 기간설정</ul>
<table class="product_table">
	<col class="title" width="200"></col>
	<tr>
		<th rowspan="2">준성수기 설정</th>
		<td>
        	<div id="busyMiddleFrom"  style="display:block;" >
<%
	seasonCode = "M";
	vSeason = CommonDAO.getInstance().selectSeasonList(seasonCode);
	if (vSeason == null){
%>        	
                <span style="padding-top:10px;">
                <input type="hidden" id="busyMiddleaddCalUseFlag0" name="busyMiddleaddCalUseFlag[0]" value="T">
                <input type="text" size="12" id="busyMiddleFrom_add[]" name="busyMiddleFrom_add[]" onfocus="blur()">
                <img src="/admin/img/reservation/btn_calendar.gif" class="linked" align="middle" onclick="cal.toggle( event , this.previousSibling.previousSibling );" alt="달력">
                 &nbsp; 부터 &nbsp;&nbsp;
                <input type="text" size="12" id="busyMiddleTo_add[]" name="busyMiddleTo_add[]" onfocus="blur()">
                <img src="/admin/img/reservation/btn_calendar.gif" class="linked" align="middle" onclick="cal.toggle( event , this.previousSibling.previousSibling );" alt="달력">
                 &nbsp; 까지 &nbsp;&nbsp;
                <img src="/admin/img/btn_add.gif"  class="linked" align="absmiddle" onclick="addRows('busyMiddle');" alt="추가">
                </span>
<%
	}else{
		for(int i=0; i<vSeason.size(); i++){
			season = vSeason.get(i);
			startSeason = year+"-"+season.getStartSeason();
			endSeason = year+"-"+season.getEndSeason();
%>
			     <span id="busyMiddleaddCalRow<%=i%>"><br>
				 <input type="hidden" id="busyMiddleaddCalUseFlag<%=i%>" name="busyMiddleaddCalUseFlag[]" value="T">
        		 <input type="text" id="busyMiddleFrom_add<%=i%>" size="12" name="busyMiddleFrom_add[]" value="<%=startSeason %>" onfocus="blur()">&nbsp;
        		 <img src="/admin/img/reservation/btn_calendar.gif" class="linked" align="middle" onclick="cal.toggle( event , this.previousSibling.previousSibling);" alt="달력">&nbsp; 부터 &nbsp;&nbsp;
        		 <input type="text" id="busyMiddleTo_add<%=i%>" size="12" name="busyMiddleTo_add[]" value="<%=endSeason %>" onfocus="blur()" >&nbsp;
        		 <img src="/admin/img/reservation/btn_calendar.gif" class="linked" align="middle" onclick="cal.toggle( event , this.previousSibling.previousSibling);" alt="달력">&nbsp; 까지  &nbsp;&nbsp;&nbsp;
        		 <img src="/admin/img/btn_add.gif" class="linked" align="absmiddle" onclick="addRows('busyMiddle');" alt="추가">&nbsp;
<%
			if(i>0){
%>        		 
        		 <img src="/admin/img/btn_del.gif" class="linked" align="absmiddle" onclick="deleteRows('busyMiddleadd', '<%=i%>');" alt="삭제">
<%
			}
%>        		 
        		 </span>
			   
<%			
		}
	}
%>                
            	<span id="busyMiddleAddDate"></span>
            </div>
		</td>
	</tr>
</table>
<div style="margin:-5px 0 15px 0;">
					* 기간설정은 년도에 상관없이 1월 1일 부터 12월31일 기준으로 입력하시기 바랍니다.<br>
    </div>

<ul class="bullet_title"><li style="font-weight:normal;">성수기 기간설정</ul>
<table class="product_table">
	<col class="title" width="200"></col>
	<tr>
		<th rowspan="2">성수기 설정</th>
		<td>

        	<div id="busyFrom" name="busyFrom"  style="display:block;" >
<%
	seasonCode = "H";
	vSeason = CommonDAO.getInstance().selectSeasonList(seasonCode);
	if (vSeason == null){
%>        	
                <span style="padding-top:10px;">
                <input type="hidden" id="busyaddCalUseFlag0" name="busyaddCalUseFlag[0]" value="T">
                <input type="text" size="12" id="busyFrom_add[]" name="busyFrom_add[]" onfocus="blur()">
                <img src="/admin/img/reservation/btn_calendar.gif" class="linked" align="middle" onclick="cal.toggle( event , this.previousSibling.previousSibling );" alt="달력">
                &nbsp; 부터 &nbsp;&nbsp;
                <input type="text" size="12" id="busyTo_add[]" name="busyTo_add[]" onfocus="blur()">
                <img src="/admin/img/reservation/btn_calendar.gif" class="linked" align="middle" onclick="cal.toggle( event , this.previousSibling.previousSibling );" alt="달력">
                &nbsp; 까지 &nbsp;&nbsp;
                <img src="/admin/img/btn_add.gif"  class="linked" align="absmiddle" onclick="addRows('busy');" alt="추가">
                </span>
<%
	}else{
		season = null;
		for(int i=0; i<vSeason.size(); i++){
			season = vSeason.get(i);
			startSeason = year+"-"+season.getStartSeason();
			endSeason = year+"-"+season.getEndSeason();
%>
			     <span id="busyaddCalRow<%=i%>"><br>
				 <input type="hidden" id="busyaddCalUseFlag<%=i%>" name="busyaddCalUseFlag[]" value="T">
        		 <input type="text" id="busyFrom_add<%=i%>" size="12" name="busyFrom_add[]" value="<%=startSeason %>" onfocus="blur()">&nbsp;
        		 <img src="/admin/img/reservation/btn_calendar.gif" class="linked" align="middle" onclick="cal.toggle( event , this.previousSibling.previousSibling);" alt="달력">&nbsp; 부터 &nbsp;&nbsp;
        		 <input type="text" id="busyTo_add<%=i%>" size="12" name="busyTo_add[]" value="<%=endSeason %>" onfocus="blur()" >&nbsp;
        		 <img src="/admin/img/reservation/btn_calendar.gif" class="linked" align="middle" onclick="cal.toggle( event , this.previousSibling.previousSibling);" alt="달력">&nbsp; 까지  &nbsp;&nbsp;&nbsp;
        		 <img src="/admin/img/btn_add.gif" class="linked" align="absmiddle" onclick="addRows('busy');" alt="추가">&nbsp;
<%
			if(i>0){
%>        		 
        		 <img src="/admin/img/btn_del.gif" class="linked" align="absmiddle" onclick="deleteRows('busyadd', '<%=i%>');" alt="삭제">
<%
			}
%>        		 
        		 </span>
			   
<%			
		}
	}
%>                  
            	<span id="busyAddDate"></span>
            </div>
		</td>
	</tr>
</table>
    <div style="margin:-5px 0 15px 0;">
					* 기간설정은 년도에 상관없이 1월 1일 부터 12월31일 기준으로 입력하시기 바랍니다.<br>
    </div>

<table border="0" align="center">
<tr>
<td align="center">
	<img src="/admin/img/reservation/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="저장하기" class="bt_a32 tmb22" onclick="submitSave()">
	<img src="/admin/img/reservation/tbtn_bg_022.gif" align="absmiddle" class="imp"><input type="button" value="취소하기" class="bt_a32 tmb22" onclick="location.reload();">
</td>
</tr>
</table>

</table>



</form>

<br>

<br>

<script language="JavaScript">
var id_week = true;

window.onload = function() {
    if(id_week==true) {
        Common.getObj('id_week').style.display = '';
    } else {
        Common.getObj('id_week').style.display = 'none';
    }
}

</script>

<!--본문 끝---------------------------------------------------------------------------------------->


							</td>
					</tr>
				</table>
	
	<!--footer-->
	<jsp:include page="/admin/footer.jsp" />
	<!--//footer-->
	

</body>
</html>