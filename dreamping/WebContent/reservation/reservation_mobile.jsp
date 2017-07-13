<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="reservation.SeasonVO" %>
<%@ page import="reservation.SiteVO" %>
<%@ page import="reservation.ReservationVO" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	Vector<SiteVO> zone = (Vector<SiteVO>)request.getAttribute("zone");
	Vector<String> reservationDate = (Vector<String>)request.getAttribute("reservationDate");
	
	Vector<SeasonVO> season = (Vector<SeasonVO>)request.getAttribute("seasons");
	int size = season.size();
	String[] seasonName = new String[size];
	int[] iStartSeason = new int[size];
	int[] iEndSeason = new int[size];
	for(int s=0; s<size; s++){
		seasonName[s] = season.get(s).getSeasonName();
		String[] startSeason = season.get(s).getStartSeason().split("-");
		String[] endSeason = season.get(s).getEndSeason().split("-");
		for( int i=0; i<2 ; i++ ){
			startSeason[0] = (Integer.parseInt(startSeason[0]) < 10) ? "0"+Integer.parseInt(startSeason[0]) : startSeason[0] ;	
		}
		iStartSeason[s] = Integer.parseInt(startSeason[0]+startSeason[1]);
		for( int i=0; i<2 ; i++ ){
			endSeason[0] = (Integer.parseInt(endSeason[0]) < 10) ? "0"+Integer.parseInt(endSeason[0]) : endSeason[0] ;
		}		
		iEndSeason[s] = Integer.parseInt(endSeason[0]+endSeason[1]);
	}
	
	// 현재 날짜 출력
	Calendar now = Calendar.getInstance();
	int nowYear = now.get(Calendar.YEAR);			// 현재 년
	int nowMonth = now.get(Calendar.MONTH)+1;		// 현재 월
	int nowDate = now.get(Calendar.DATE);			// 현재 일
	
	String[] day = {"일","월","화","수","목","금","토"};
	int year = Integer.parseInt(request.getAttribute("year").toString());
	int month = Integer.parseInt(request.getAttribute("month").toString());
//	out.print(year+"/"+month);

	// 선택한 월에 이전달
	now.set(year,month-1,1);
	now.add(Calendar.MONTH,-1);
	int laterYear = now.get(Calendar.YEAR);
	int laterMonth = now.get(Calendar.MONTH)+1;
	
	// 선택한 월에 다음달
	now.set(year,month-1,1);
	now.add(Calendar.MONTH,1);
	int nextYear = now.get(Calendar.YEAR);
	int nextMonth = now.get(Calendar.MONTH)+1;
	
	// 달력을 보여주기 위한 선처리 작업
	Calendar cal = Calendar.getInstance();
	cal.set(year, month-1, 1);
	int firstWeekday = cal.get(Calendar.DAY_OF_WEEK);	// 선택월의 1일에 해당하는 요일
	int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);	// 현재 월의 마지막 날짜
//	out.print("이번달 : "+toYear+" "+(toMonth+1)+" "+firstWeekday+" "+lastDay);	// 확인  년/월/첫날요일값 1~7
	int chkNowDate = month == nowMonth ? nowDate : 0 ;
	if( (year*100)+month == (nowYear*100)+nowMonth ) chkNowDate = nowDate;
	else if( (year*100)+month < (nowYear*100)+nowMonth ) chkNowDate = 32;
	else chkNowDate = 0;
	int count = 1;
	String usedZone = null;
	String cLinkF = "";
	String cLinkB = "";
	int bluRed = 0;
%>
<jsp:include page="/header.jsp" />
<link rel="stylesheet" href="/css/bootstrap.theme.css">
<link rel="stylesheet" href="/reservation/css/template.css?ver=3">
<br><br><br><br>
<section class="mbr-section mbr-section__container article" id="header3-n" style="background-color: rgb(255, 255, 255); padding-top: 20px; padding-bottom: 20px;">
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <h3 class="mbr-section-title display-2">예약하기</h3>
                <small class="mbr-section-subtitle">
                	<a href="/Reservation.do"><img src="/reservation/images/tab2_on.gif" alt="예약하기" /></a>
                	<a href="/Reservation.do?step=rinfo"><img src="/reservation/images/tab3.gif" alt="예약확인" /></a>
                	<a href="/Reservation.do?step=rcancle"><img src="/reservation/images/tab4.gif" alt="예약취소" /></a>
                </small>
            </div>
        </div>
    </div>
</section>

<section class="mbr-section" id="msg-box5-o" style="background-color: rgb(255, 255, 255); padding-top: 0px; padding-bottom: 0px;">
<!-- 예약게시판 시작 -->
	<form name="step2Form" method="post" action="/Reservation.do">
		<input type="hidden" name="step" value="two" />
		<input type="hidden" name="chooseDate" />
		<input type="hidden" name="chooseZoneName" />
	</form>
	
<style type="text/css">
.calendar > p{width:100%;font-size:23px;margin:10px;text-align:center; }
.calendar > p span.Ym{font-size:23px;margin:0px 10px;font-weight:bold;}
.calendar > p a{display:inline-block;vertical-align:bottom;line-height:23px;font-weight:bold;}
.today{background:#fff8cf !important;}
.Sun{color:#cc2220;}
.Sat{color:#2453a5;}
</style>
	
	<div class="container">
		<div class="row">
			
			<div class="col-md-12">
				
				<div class="calendar">
					<p>
						<a href="/Reservation.do?y=<%= laterYear %>&m=<%= laterMonth %>">&laquo;</a>
						<span class="Ym"><%= year+"년 "+month+"월" %></span>
						<a href="/Reservation.do?y=<%= nextYear %>&m=<%= nextMonth %>">&raquo;
					</p>
				</div>
				
				<table class="table1">
					<tbody>
						<tr>
							<th class="Sat" style="width:105px;">1(토)<br>비수기</th>
							<td></td>
						</tr>
						<tr>
							<th class="Sun" style="width:105px;">2(일)<br>비수기</th>
							<td></td>
						</tr>
						<tr>
							<th style="width:105px;">3(월)<br>비수기</th>
							<td></td>
						</tr>
				</table>
		
			</div>
			
		</div><!-- //row -->
	</div><!-- //container -->
<!-- //예약게시판 끝 -->
										
</section>

<jsp:include page="/footer.jsp" />
<script type="text/javascript">
	// 날짜와 방을 선택
	function chooseRoom(chooseDate,zoneName){
		//document.getElementById("aa").innerHTML=cDate;
		//alert("신청"+cDate+","+rno);
		var month = <%= month %>;
		month = (month < 10) ? "0"+month : month; 
		var date = (chooseDate < 10) ? "0"+chooseDate : chooseDate; 
		document.step2Form.chooseDate.value = <%= year %>+""+month+date; 
		document.step2Form.chooseZoneName.value = zoneName;
		document.step2Form.submit();
	}	
</script>