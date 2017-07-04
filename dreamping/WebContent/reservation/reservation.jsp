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

<style type="text/css">
.calendar > p{width:100%;font-size:0px;margin:10px; }
.calendar > p span.Ym{font-size:23px;margin:0px 10px;font-weight:bold;}
.calendar > p a{display:inline-block;vertical-align:bottom;line-height:23px;font-weight:bold;}
.calendar > ul > li > div.today{background:#fff8cf !important;}
.calendar > ul > li > div.Sun > time, .calendar > ul > li > div.Sun > time span{color:#cc2220;}
.calendar > ul > li > div.Sat > time, .calendar > ul > li > div.Sat > time span{color:#2453a5;}
@media only screen and (min-width : 761px){
	.calendar > p{text-align:center;}
	.calendar > ul{display:table;width:100%;font-size:0px;margin-bottom:15px;}
	.calendar > ul > li{display:table-row;width:100%;}
	.calendar > ul > li > div{display:table-cell;width:14%;min-height:80px;height:80px;border-right:1px solid #dfd8c6;border-bottom:1px solid #dfd8c6;}
	.calendar > ul > li > div:last-child{border-right:0px;}
	.calendar > ul > li.header > div{height:30px;line-height:30px;min-height:0px;border-top:1px solid #dfd8c6;border-right:1px solid #dfd8c6;border-bottom:1px solid #dfd8c6background:#fbfaf7;color:#777777;font-weight:bold;text-align:center;}
	.calendar > ul > li.header > div:last-child{border-right:0px;}
	.calendar > ul > li.header > div.Sun{color:#cc2220;}
	.calendar > ul > li.header > div.Sat{color:#2453a5;}
	.calendar > ul > li > div.empty{background:#fbfaf7;}
	.calendar > ul > li > div > time{display:block;padding:3px 0 3px 3px;font-weight:bold;min-height:15px;}
	.calendar > ul > li > div > time span{display:none;}
	.calendar > ul > li > div > reserve{display:block;padding:3px 0 3px 3px;font-weight:bold;min-height:45px;}
	.calendar > ul > li > div ul{width:100%;font-size:0px;text-align:right;padding:0 3px;min-height:60px;}
	.calendar > ul > li > div ul li{margin:0px 3px 3px 0px;padding:3px;}
}
@media only screen and (max-width : 760px){
	.calendar > p{text-align:left;}
	.calendar > ul{width:100%;display:block;border-top:2px solid #dfd8c6;margin-bottom:15px;}
	.calendar > ul > li{display:block;}
	.calendar > ul > li > div{width:100%;border-bottom:1px solid #dfd8c6;}
	.calendar > ul > li.header{display:none;}
	.calendar > ul > li > div.empty{display:none;}
	.calendar > ul > li > div > time{display:table-cell;vertical-align:middle;border-right:1px solid #dfd8c6;width:80px;text-align:right;padding:10px 5px 10px 0;background:#fbfaf7;font-weight:bold;}
	.calendar > ul > li > div > time span.Ym{font-size:10px;display:block;margin-bottom:5px;}
	.calendar > ul > li > div > time span.W{margin-left:5px;}
	.calendar > ul > li > div > reserve{margin-left:5px;display:block;}
	.calendar > ul > li > div ul{display:table-cell;padding:5px 10px;vertical-align:middle;}
	.calendar > ul > li > div ul li{margin:2px 2px 2px 0px;padding:3px;}
}

</style>


	<div class="calendar">
		<p>
			<a href="/Reservation.do?y=<%= laterYear %>&m=<%= laterMonth %>">&laquo;</a>
			<span class="Ym"><%= nowYear+"년 "+nowMonth+"월" %></span>
			<a href="/Reservation.do?y=<%= nextYear %>&m=<%= nextMonth %>">&raquo;</a>
		</p>
	 
		<ul>
			<li class="header">
				<div class="Sun">SUN</div>
				<div class="Mon">MON</div>
				<div class="Tue">TUE</div>
				<div class="Wed">WED</div>
				<div class="Thu">THU</div>
				<div class="Fri">FRI</div>
				<div class="Sat">SAT</div>
			</li>
			
			<%	while( true ){	%>
			<li>
			<%	for( int i=0; i<7 ; i++ ){		// 날짜 출력
					if( i<firstWeekday-1 && count == 1 ){ out.print("<div class='empty'></div>"); continue; } 
					if( count > lastDay ){out.print("<div class='empty'></div>");}else{ 
						if(i==0){
					%>
						<div class="Sun">
					<%
						}else if(i==6){
					%>
						<div class="Sat">
			        <%
						}else{
					%>
						<div>
					<%	
						}
					%>
							<time>
								<span class="Ym">[<%= nowYear+". "+nowMonth %>]</span>
								<%= count++ %>
								<span class="W">(<%= day[i] %>)&nbsp;
								<%
									int sChkDate = Integer.parseInt(month+""+(((count-1) < 10) ? "0"+(count-1) : (count-1)));
									String sName = "비수기";
									for(int s=0; s<season.size(); s++){
										if(sChkDate >= iStartSeason[s] && sChkDate <= iEndSeason[s]){
											sName = seasonName[s];
										}
									}
									out.print(sName);
								%>
								</span>
							</time>
							<reserve>
							<%								
							if( count > chkNowDate )
								
								if( zone != null )
									for( int j=0; j<zone.size();j++ ){	// Zone 갯수만큼 루프
										bluRed = 2;
										String thisDate = ""+year+(month < 10 ? "0"+month : month)+((count-1) < 10 ? "0"+(count-1) : (count-1));
										if(reservationDate.size() > 0){
											usedZone = "0";
											bluRed = 2;
											for(int k=0; k<reservationDate.size(); k+=6){	// 예약날짜 만큼 루프
												//System.out.println("i = " + reservationDate.size());
												//System.out.println("1 : "+ reservationDate.get(k)+reservationDate.get(k+1));
												//System.out.println("2 : "+ thisDate+zone.get(j).getGubun());
												if((reservationDate.get(k)+reservationDate.get(k+1)).equals(thisDate+zone.get(j).getZoneName())){
													//System.out.println("for : " +k +" , "+ reservationDate.get(k)+reservationDate.get(k+1));
													//System.out.println("date gubun : " +reservationDate.get(k+1));
													//if(reservationDate.get(k+1).equals(zone.get(j).getGubun())){
														usedZone = zone.get(j).getZoneName()+"("+reservationDate.get(k+3)+"/"+reservationDate.get(k+2)+")";
														if(reservationDate.get(k+3).equals("0")){
															bluRed = 0;
														}else if(!reservationDate.get(k+3).equals(reservationDate.get(k+2))){
															bluRed = 1;
														}
														break;
													//}else{
													//	usedZone = zone.get(j).getZoneName()+"("+zone.get(j).getZoneCnt()+"/"+zone.get(j).getZoneCnt()+")";
													//}
												}
											}
											if(usedZone.equals("0")){
												usedZone = zone.get(j).getZoneName()+"("+zone.get(j).getZoneCnt()+"/"+zone.get(j).getZoneCnt()+")";
											}
											//System.out.println("usedZone : " + usedZone);
										}else{
											usedZone = zone.get(j).getZoneName()+"("+zone.get(j).getZoneCnt()+"/"+zone.get(j).getZoneCnt()+")";
										}
										
										cLinkF=""+(count-1);
										cLinkB=zone.get(j).getZoneName();
										
										if(bluRed == 0){
								%>											
											<div style="height:18px; color:#000000;"><%=usedZone %></div>
									<%	
										}else if(bluRed == 1){
								%>
											<div style="height:18px; color:#000000;"><%=usedZone %></div>
									<%			
										}else{
								%>											
											<div style="height:18px; color:#000000;"><%=usedZone %></div>
									<%
										}
										
										//System.out.println(zone.get(j).getZoneName());
						
									}
								%>
							</reserve>
						</div>
						<% 		
					}
				}
			%>
				</li>
			<%	
			if( count > lastDay ) break;	// while 문 종료
		}
		%>			
		</ul>
	</div>


<jsp:include page="/footer.jsp" />