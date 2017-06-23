<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="reservation.ReservationVO" %>
<%
	NumberFormat nf = NumberFormat.getInstance();
	SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
	Vector<ReservationVO> reservations = (Vector<ReservationVO>)request.getAttribute("reservations");
%>
<HTML>
<HEAD>
	<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<TITLE>Urban Slow City </TITLE>
	<link rel='stylesheet' type='text/css' href='/css/company.css'>
	<script language='javascript' src='/js/common.js'></script>
	
</HEAD>
<body leftmargin="0" rightmargin="0" topmargin="0" bottommargin="0" onLoad="javascript:messageCall();">
	<!--menu-->
	<jsp:include page="/main/menu.jsp" />
	<!--//menu-->
	
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="Table_01" >
		<tr>
			<td align="center">
			
				<table width="1200" height="700" border="0" cellspacing="0" cellpadding="0">
					<tr height="80"><td></td></tr>
					<tr>
    					<td align="center" valign="top">
    					
							<table width="1200" border="0" cellspacing="0" cellpadding="0">
								<tr>
    								<td align="center">
    									
    									<!-- 예약게시판 시작 -->
    									<link rel='stylesheet' type='text/css' href='/css/sub_layout.css'>
    									<link rel='stylesheet' type='text/css' href='/css/style.css'>
    									<link rel='stylesheet' type='text/css' href='/css/template.css'>
										<script language="javascript">
											var date = new Date();
											var today = date.getFullYear()+""+(date.getMonth()+1)+""+date.getDate();
										
											function number_format(numStr) {
												var numstr = String(numStr);
												var re0 = /(\d+)(\d{3})($|\..*)/;
												if (re0.test(numstr)) 
													return numstr.replace( 
													  re0, 
													  function(str,p1,p2,p3) { return number_format(p1) + "," + p2 + p3; } 
													); 
												else 
													return numstr; 
											}
											
											function chooseReservation(reservationNo,chooseDate,zoneName,siteName,toddler,child,users,nights,payAll,payStatus,status,content){ 
												var payMoney = Number(payAll);
												var night = Number(nights);
												night = night+1;
												document.sch_frm.reservationNo.value = reservationNo;
												document.sch_frm.payStatus.value = payStatus;
												document.sch_frm.chooseDate.value = chooseDate;
												document.getElementById("allZone").innerHTML=zoneName;
												document.getElementById("allDate").innerHTML=chooseDate.substring(0,4)+"년 "+ chooseDate.substring(4,6)+"월 "+ chooseDate.substring(6,8)+"일";
												document.getElementById("allNight").innerHTML=nights+"박 "+night+"일";
												document.getElementById("allSite").innerHTML=siteName;
												document.getElementById("allUser").innerHTML="유아"+toddler+", 아동"+child+", 일반"+users+"명";
												document.getElementById("allMoney").innerHTML=number_format(payMoney)+"원";
												document.getElementById("allStatus").innerHTML=status;
												document.getElementById("allContent").innerHTML=content;
											}
											
											function sendit(){
												var payStatus = payStatus.value; 
												if(payStatus == "C" || payStatus == "R"){
													alert("취소된 예약건 입니다.");
												    return;
												}
												
												var chooseDate = chooseDate.value;
												if(chooseDate < today){
													alert("지난일자의 예약은 취소할 수 없습니다.");
												    return;
												}
											}
										</script>
    									<div id="contents">
											<div class="con_wrap">
												<!--tab-->
												<div class="con_tab mb30">
													<ul>
														<li><a href="/Reservation.do"><img src="/images/reservation/tab2.gif" alt="예약하기" /></a></li>
														<li><a href="/Reservation.do?step=rinfo"><img src="/images/reservation/tab3_on.gif" alt="예약확인" /></a></li>
														<li><a href="/Reservation.do?step=rcancle"><img src="/images/reservation/tab4.gif" alt="예약취소" /></a></li>
													</ul>
												</div>
												<!--//tab-->
												<div class="reser_box">
													<div class="reser_con">
					
														<div class="con_box mb25">
															<p class="tit">예약목록</p>
															<table class="table1">
																<colgroup>
																	<col width="120" />
																	<col width="100" />
																	<col width="100" />
																	<col width="150" />
																	<col width="80" />
																	<col width="110" />
																	<col width="*" />
																</colgroup>
																<tbody>
																	<tr>
																		<th>이용일자</th>
																		<th>ZONE</th>
																		<th>Site No.</th>
																		<th>이용인원</th>
																		<th>이용기간</th>
																		<th>결제액</th>
																		<th>예약상태</th>
																	</tr>
<% 
	String cLink = "";
	int reservationNo = 0;
	String chooseDate = "";
	String zoneName = "";
	String siteName = "";
	String productName = "";
	int toddler = 0;
	int child = 0;
	int users = 0;
	int nights = 0;
	int payAll = 0;
	String content = "";
	String payStatus = "";
	String status = "";
	
	if( reservations != null ){
		for( int j=0; j<reservations.size();j++ ){
			reservationNo = reservations.get(j).getReservationNo();
			chooseDate = transFormat.format(reservations.get(j).getReservationDate());
			zoneName = reservations.get(j).getZoneName();
			siteName = reservations.get(j).getSiteName();
			productName = reservations.get(j).getProductName();
			toddler = reservations.get(j).getToddler();
			child = reservations.get(j).getChild();
			users = reservations.get(j).getUsers();
			nights = reservations.get(j).getNights();
			payAll = reservations.get(j).getPrice();
			content = reservations.get(j).getMemo();
			payStatus = reservations.get(j).getPayStatus();
			if(payStatus.equals("N")){
				status="예약대기";
			}else if(payStatus.equals("Y")){
				status="예약완료";
			}else if(payStatus.equals("C")){
				status="취소/환불요청";
			}else if(payStatus.equals("R")){
				status="예약취소";
			}
%>
																<tr onclick="javascript:chooseReservation('<%=reservationNo%>','<%=chooseDate%>','<%=zoneName%>','<%=productName%>','<%=toddler %>','<%=child %>','<%=users%>','<%=nights%>','<%=payAll%>','<%=payStatus %>','<%=status%>','<%=content.replace("\r\n","<br/>")%>')">
																	<td><%= chooseDate.substring(0,4)+"년 "+chooseDate.substring(4,6)+"월 "+chooseDate.substring(6,8)+"일" %></td>
																	<td><%= zoneName %></td>
																	<td><%= productName %></td>
																	<td>유아<%=toddler %>, 아동<%=child %>, 일반<%= users %>명</td>
																	<td><%= nights %>박 <% out.print(nights+1); %>일</td>
																	<td><% out.print(nf.format(payAll)); %>원</td>
																	<td><%= status %></td>
																</tr>
<%			
		}
		reservationNo = reservations.get(0).getReservationNo();
		chooseDate = transFormat.format(reservations.get(0).getReservationDate());
		zoneName = reservations.get(0).getZoneName();
		siteName = reservations.get(0).getSiteName();
		productName = reservations.get(0).getProductName();
		toddler = reservations.get(0).getToddler();
		child = reservations.get(0).getChild();
		users = reservations.get(0).getUsers();
		nights = reservations.get(0).getNights();
		payAll = reservations.get(0).getPrice();
		content = reservations.get(0).getMemo();
		payStatus = reservations.get(0).getPayStatus();
		if(payStatus.equals("N")){
			status="예약대기";
		}else if(payStatus.equals("Y")){
			status="예약완료";
		}else if(payStatus.equals("C")){
			status="취소/환불요청";
		}else if(payStatus.equals("R")){
			status="예약취소";
		}
	}else{
%>
																<tr>
																	<td colspan="6"><center>예약내역이 없습니다.</center></td>
																</tr>
<%		
	}
%>									
									
															</tbody>
														</table>
													</div>
<%
	if( reservations != null ){
%>
													<form id="sch_frm" name="sch_frm" method="post" action="/Reservation.do" onsubmit="return sendit();">
														<input type="hidden" name="step" value="rcancle"/>
														<input type="hidden" name="reservationNo" value="<%= reservationNo %>"/>
														<input type="hidden" id="chooseDate" name="chooseDate" value="<%= chooseDate %>"/>
														<input type="hidden" id="payStatus" name="payStatus" value="<%= payStatus %>"/>
														<div class="con_box mb25">
														<p class="tit">예약내역확인</p>
														<table class="table1">
															<colgroup>
																<col width="105" />
																<col width="*" />
															</colgroup>
															<tbody>
																<tr>
																	<th>ZONE</th>
																	<td><b id="allZone"><%= zoneName %></b></td>
																</tr>
																<tr>
																	<th>이용일자</th>
																	<td><b id="allDate"><%= chooseDate.substring(0,4)+"년 "+chooseDate.substring(4,6)+"월 "+chooseDate.substring(6,8)+"일" %></b></td>
																</tr>
																<tr>
																	<th>이용기간</th>
																	<td><b id="allNight"><%= nights %>박 <% out.print(nights+1); %>일</b></td>
																</tr>
																<tr>
																	<th>Site No.</th>
																	<td><b id="allSite"><%= productName %></b></td>
																</tr>
																<tr>
																	<th>이용인원</th>
																	<td><b id="allUser">유아<%=toddler %>, 아동<%=child %>, 일반<%= users %>명</b></td>
																</tr>
																<tr>
																	<th>결제액</th>
																	<td><b id="allMoney"><% out.print(nf.format(payAll)); %>원</b></td>
																</tr>
																<tr>
																	<th>예약상태</th>
																	<td><b id="allStatus"><%= status %></b></td>
																</tr>
																<tr>
																	<th>예약요청사항</th>
																	<td><b id="allContent"><%=content.replace("\r\n","<br/>") %></b></td>
																</tr>
															</tbody>
														</table>
													</div>
													<p class="mt40 tac"><input type="image" src="/images/reservation/btn_reservation6.gif" alt="예약취소" /></p>
<%	
	}
%>
												</form>
								
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
