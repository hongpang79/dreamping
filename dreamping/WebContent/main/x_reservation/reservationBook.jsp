<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
											function CheckSpaces(str,m) {
											    var flag=true;
											    var strValue = str.value;

											    if (strValue!=" ") {
											       for (var i=0; i < strValue.length; i++) {
											          if (strValue.charAt(i) != " ") {
											             flag=false;
											             break;
											          }
											       }
											    }
												if(flag == true) {
											       alert( m + "을(를) 입력하십시요.");
											       str.focus();
											    }

											    return flag;
											}
																					
											function sendit(frm){
												if (CheckSpaces(sch_name, '예약자명')) { return false; }
												if (CheckSpaces(sch_phone1, '연락처')) { return false; }
												if (CheckSpaces(sch_phone2, '연락처')) { return false; }
												if (CheckSpaces(sch_phone3, '연락처')) { return false; }											
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
					
														<form id="sch_frm" name="sch_frm" method="post" action="/Reservation.do" onsubmit="return sendit();">
															<input type="hidden" name="step" value="rinfo"/>
															<div class="con_box mb25">
																<p class="tit">예약확인</p>
																<p class="mb15">
																	1. 성명과 휴대폰 번호를 입력하시면 예약 확인이 가능합니다.</br />
																	2. 예약 취소는 예약자와 전화번호를 입력하셔야 가능합니다.
																</p>
																<table class="table1" summary="예약번호와 예약자명, 전화번호를 기입해 예약상황을 확인하는 표">
																	<colgroup>
																		<col width="105" />
																		<col width="*" />
																	</colgroup>
																	<tbody>
																		<tr>
																			<th>예약자명</th>
																			<td><input type="text" id="sch_name" name="sch_name" title="예약자명" class="input_box" style="width:150px;margin-right:5px;" /> 예약시 신청하셨던 예약자명 입력하세요.</td>
																		</tr>
																		<tr>
																			<th>전화번호</th>
																			<td>
																				<input type="text" id="sch_phone1" name="sch_phone1" maxlength="4" title="전화번호" class="input_box" style="width:50px;" /> - 
																				<input type="text" id="sch_phone2" name="sch_phone2" maxlength="4" title="전화번호" class="input_box" style="width:50px;" /> - 
																				<input type="text" id="sch_phone3" name="sch_phone3" maxlength="4" title="전화번호" class="input_box" style="width:50px;margin-right:5px;" /> 예약시 기록한 핸드폰번호를 적어주세요.</td>
																		</tr>
																	</tbody>
																</table>
														</div>
														<p class="mt40 tac"><input type="image" src="/images/reservation/btn_reservation7.gif" alt="예약확인" /></p>
									
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
