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
<HTML>
<HEAD>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<TITLE>Urban Slow City </TITLE>
	<link rel='stylesheet' type='text/css' href='/css/company.css'>
	<script language='javascript' src='/js/common.js'></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
	<script language="javascript" src="/js/popup.js"></script>
	<script language="javascript">
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
		
		function popupUrbanMap(){
			var url = "/main/reservation/popupUrbanMap.jsp";
			popup.openWindowPopup(url, 'UrbanMap', {width : '820px', height : '540px'});
		}
				
	</script>
</HEAD>
<body leftmargin="0" rightmargin="0" topmargin="0" bottommargin="0">
	<!--menu-->
	<jsp:include page="/main/menu.jsp" />
	<!--//menu-->
	
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="Table_01" >
		<tr>
			<td align="center">
			
				<table width="1200" height="700" border="0" cellspacing="0" cellpadding="0">
					<tr height="30"><td></td></tr>
					<tr>
    					<td align="center" valign="top">
    					
							<table width="1200" border="0" cellspacing="0" cellpadding="0">
								<tr>
    								<td align="center">
    									
    									<!-- 예약게시판 시작 -->
    									<form name="step2Form" method="post" action="/Reservation.do">
											<input type="hidden" name="step" value="two" />
											<input type="hidden" name="chooseDate" />
											<input type="hidden" name="chooseZoneName" />
										</form>
    									<link rel='stylesheet' type='text/css' href='/css/sub_layout.css'>
    									<link rel='stylesheet' type='text/css' href='/css/style.css'>
    									<div id="contents">
											<div class="con_wrap">
												<!--tab-->
												<div class="con_tab mb30">
													<ul>
														<li><a href="/Reservation.do"><img src="/images/reservation/tab2_on.gif" alt="예약하기" /></a></li>
														<li><a href="/Reservation.do?step=rinfo"><img src="/images/reservation/tab3.gif" alt="예약확인" /></a></li>
														<li><a href="/Reservation.do?step=rcancle"><img src="/images/reservation/tab4.gif" alt="예약취소" /></a></li>
													</ul>
													<div>
														<a href="javascript:popupUrbanMap()"><img src="/images/reservation/map.png"></a>
													</div>
												</div>
												<!--//tab-->
												<div class="reser">
									
													<ul class="reser_tok">
														<li><img src="/images/reservation/sm_state1.gif" alt="예약가능" /> 예약가능</li>
														<li><img src="/images/reservation/sm_state3.gif" alt="예약완료" /> 예약완료</li>
													</ul>
									
													<div class="calendar">
														<!--날짜-->
														<ul class="date">
															<li class="fl">TODAY : <%= nowYear+"년 "+nowMonth+"월 "+nowDate+"일" %></li>
															<li class="cen">
																<ul>
																	<li><a href="/Reservation.do?y=<%= laterYear %>&m=<%= laterMonth %>">&laquo;</a></li>
																	<li class="mon"><%= year+"년 "+month+"월" %></li>
																	<li><a href="/Reservation.do?y=<%= nextYear %>&m=<%= nextMonth %>">&raquo;</a></li>
																</ul>
															</li>
															<li class="fr"></li>
														</ul>
														<!--//날짜-->
														<table class="state">
															<caption>예약현황</caption>
															<colgroup>
																<col width="140" />
																<col width="140" />
																<col width="140" />
																<col width="141" />
																<col width="140" />
																<col width="140" />
																<col width="140" />
															</colgroup>
															<tbody>
																<tr>
																	<th class="week">일요일</th>
																	<th class="week">월요일</th>
																	<th class="week">화요일</th>
																	<th class="week">수요일</th>
																	<th class="week">목요일</th>
																	<th class="week">금요일</th>
																	<th class="week">토요일</th>
																</tr>
									
												<%	while( true ){	%>
													<tr>
													<%	for( int i=0; i<7 ; i++ ){		// 날짜 출력
															if( i<firstWeekday-1 && count == 1 ){ out.print("<td><table><tbody><tr><th><p class='num'>&nbsp;</p><p class='num_con'>&nbsp;</p></th></tr><tr><td><ul style='min-height:60px;'></ul></td></tr></tbody></table></td>"); continue; } 
															if( count > lastDay ){out.print("<td><table><tbody><tr><th><p class='num'>&nbsp;</p><p class='num_con'>&nbsp;</p></th></tr><tr><td><ul style='min-height:60px;'></ul></td></tr></tbody></table></td>");}else{ %>
																<td>
																	<table summary="">
																		<tbody>
																			<tr>
																				<th>
																					<p class="num"><%= count++ %></p>
																					<p class="num_con">
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
																					</p>
																				</th>
																			</tr>
																			<tr>
																				<td>
																					<ul style="min-height:60px;">
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
																					<li class="s03"><font color="red"><b id="noLink"><%=usedZone %></b></font></li>
																			<%	
																				}else if(bluRed == 1){
																		%>
																					<li class="s01"><font color="#2F9D27"><b id="link" onClick="javascript:chooseRoom('<%=cLinkF%>','<%=cLinkB%>')"><%=usedZone %></b></font></li>
																			<%			
																				}else{
																		%>											
																					<li class="s01"><font color="blue"><b id="link" onClick="javascript:chooseRoom('<%=cLinkF%>','<%=cLinkB%>')"><%=usedZone %></b></font></li>
																			<%
																				}
																				
																				//System.out.println(zone.get(j).getZoneName());
																
																			}
																		%>
																						
																					</ul>
																				</td>
																			</tr>
																		</tbody>
																	</table>
																</td>
																<% 		
															}
														}
													%>
													</tr>
												<%	
													if( count > lastDay ) break;	// while 문 종료
												}
												%>
												
															</tbody>
														</table>
													</div>
									
												</div>
											</div>
										</div>
										<!-- //예약게시판 끝 -->
										
										</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr height="150"><td></td></tr>
				</table>

			 </td>
		</tr>
	</table>

	<!--bottom-->
	<jsp:include page="/main/bottom.jsp" />
	<!--//bottom-->
	
</BODY>
</HTML>
<script language="javascript" type="text/javascript" src="/js/urban.lib.js?date=1364782903"></script>
<script language="javascript" src="/js/urban.board.js"></script>