<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="reservation.ReservationVO" %>
<%
	NumberFormat nf = NumberFormat.getInstance();
	SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
	ReservationVO reservation= (ReservationVO) request.getAttribute("reservation");
	
	int reservationNo = reservation.getReservationNo();
	String chooseDate = transFormat.format(reservation.getReservationDate());
	String zoneName = reservation.getZoneName();
	String productName = reservation.getProductName();
	String siteName = reservation.getSiteName();
	int toddler = reservation.getToddler();
	int child = reservation.getChild();
	int users = reservation.getUsers();
	int nights = reservation.getNights();
	int payAll = reservation.getPrice();
	String content = reservation.getMemo();
	String payStatus = reservation.getPayStatus();
	String status = "";
	if(payStatus.equals("N")){
		status="입금대기";
	}else if(payStatus.equals("Y")){
		status="입금완료";
	}else if(payStatus.equals("C")){
		status="예약취소";
	}else if(payStatus.equals("R")){
		status="환불완료";
	}
%>
<HTML>
<HEAD>
	<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<TITLE>Urban Slow City </TITLE>
	<link rel='stylesheet' type='text/css' href='/css/company.css'>
	<script language='javascript' src='/js/common.js'></script>
	<script language='javascript'>
	function sendit(){
		
		var pay = document.sch_frm.payStatus.value;
		if(pay == 'Y'){
			alert("환불신청은 고객센터로 전화주세요\r\n1899-9349");
			return false;
		}
		
		var str = document.sch_frm.r_cancel_content.value;
		if(str.length < 1){
			alert("취소사유를 입력해 주세요!");
			document.sch_frm.r_cancel_content.focus();
			return false;
		}
	}
	</script>
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

    									<div id="contents">
											<div class="con_wrap">
												<!--tab-->
												<div class="con_tab mb30">
													<ul>
														<li><a href="/Reservation.do"><img src="/images/reservation/tab2.gif" alt="예약하기" /></a></li>
														<li><a href="/Reservation.do?step=rinfo"><img src="/images/reservation/tab3.gif" alt="예약확인" /></a></li>
														<li><a href="/Reservation.do?step=rcancle"><img src="/images/reservation/tab4_on.gif" alt="예약취소" /></a></li>
													</ul>
												</div>
												<!--//tab-->
												<div class="reser_box">
													<div class="reser_con">

														<div class="con_box mb25">
															<p class="tit">환불기준 - 예약취소시 환불기준을 필히 확인하세요!</p>
															<table class="table1" summary="환불/수수료 안내를 나타내는 표">
																<colgroup>
																	<col width="105" />
																	<col width="*" />
																</colgroup>
																<tbody>
																	<tr>
																		<th><strong>환불/취소<br />수수료 안내</strong></th>
																		<td>
																			<p class="p1">※ 예약의 취소는 위약수수료가 있사오니 신중히 결정하시고진행해 주시기 바랍니다.<br />
																				※ 사이트의 예약안내에 명시한 환불기준을 꼭 확인하세요.<br />
																				※ 예약을 취소하신 경우 취소일로부터 7일 이내에 위에 규정된 취소위약 수수료를 제하고 입금됩니다.<br /><br />
																				예약일의 변경은 예약취소에 해당합니다.<br />
																				전화 또는 메일을 이용한 예약취소 후 다시 예약해 주시기 바랍니다.<br /><br />
																				예약취소 시 소정의 위약금이 부과됩니다. 그 기준은 다음과 같습니다.<br />
																				- 12일이전 80% 환불<br />
																				- 6~11일 70% 환불<br />
																				- 3~5일 60% 환불<br />
																				- 1~2일 50% 환불<br />
																				- 이용당일 환불불가<br /><br />
																				성수기(6월~10월) 예약취소시 위약금<br />
																				- 10일이전 100% 환불<br />
																				- 8~10일 90% 환불<br />
																				- 이용당일, 7일전 환불불가<br /><br />
																						
																				* 올바른 예약문화 정착을 위해 불가피한 조치이오니 양해부탁드립니다.</p>
																		</td>
																	</tr>
																</tbody>
															</table>
														</div>
									
									
														<form id="sch_frm" name="sch_frm" method="post" action="/Reservation.do" onsubmit="return sendit();">
															<input type="hidden" name="step" value="rcancleOK"/>
															<input type="hidden" name="reservationNo" value="<%= reservationNo %>"/>
															<input type="hidden" name="payStatus" value="<%= payStatus %>"/>
															<div class="con_box">
																<p class="tit">예약확인</p>
																<table class="table1" summary="예약번호와 전화번호, 숙박날짜, 취소사유, 환불 계좌를 기입하는 표">
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
																			<td><b id="allPay"><% out.print(nf.format(payAll)); %>원</b></td>
																		</tr>
																		<tr>
																		<th>예약상태</th>
																			<td><b id="allStatus"><%= status %></b></td>
																		</tr>
																		<tr>
																			<th>취소사유</th>
																			<td>
																				<textarea cols="80" rows="8" name="r_cancel_content" id="r_cancel_content" style="padding:10px;"></textarea>
																			</td>
																		</tr>
																		<tr>
																			<th>환불계좌</th>
																			<td>
																				<p style="color:red; padding-bottom:9px;">※ 입금을 하신 분은 환불계좌를 반드시 입력해 주세요.</p>
										
																				은 행 명 <input type="text" id="r_bank" name="r_bank" class="input_box" style="width:160px;margin:0 0 3px 5px;" /><br />
																				계좌번호<input type="text" id="r_bank_num" name="r_bank_num" class="input_box" style="width:160px;margin:0 0 3px 5px;" /><br />
																				예금주명<input type="text" id="r_bank_name" name="r_bank_name" class="input_box" style="width:160px;margin:0 0 0 5px;" /> 
																				
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
															
															<p class="mt40 tac"><input type="image" src="/images/reservation/btn_reservation6.gif" alt="예약취소" /></p>
														
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
