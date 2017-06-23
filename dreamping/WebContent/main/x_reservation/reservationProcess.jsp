<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.text.NumberFormat" %>
<%
	NumberFormat nf = NumberFormat.getInstance();

	String str = "";
	String chooseZone = "";
	String chooseDate = "00000000";
	String siteName = "";
	String siteNo = "";
	String productName = "";
	String productNo = "";
	int payAll = 0;
	int nights = 0;
	String toddler = "";
	String child = "";
	String users = "";
	//String id = "";
	String reserver = "";
	String phone1 = "";
	String phone2 = "";
	String phone3 = "";
	String tel1 = "";
	String tel2 = "";
	String tel3 = "";
	String email = "";
	String content = "";
	
	int iNight = 0;
	
	int result = 0;
	if( request.getAttribute("insertResult") == null ){
		str = "예약 실패-서버에 사용자가 많습니다. 잠시후 다시 시도하세요!";
	}else{
		result = (Integer)request.getAttribute("insertResult");
		if( result == 1 ){
			str = "예약이 되었습니다.";
			
			chooseZone = (String) request.getAttribute("chooseZone");
			chooseDate = (String) request.getAttribute("chooseDate");
			productName = (String) request.getAttribute("productName");
			//siteName = (String) request.getAttribute("siteName");
			siteNo = (String) request.getAttribute("siteNo");
			payAll = Integer.parseInt((String) request.getAttribute("payAll"));
			nights = Integer.parseInt((String) request.getAttribute("nights"));
			toddler = (String) request.getAttribute("toddler");
			child = (String) request.getAttribute("child");
			users = (String) request.getAttribute("users");
			//id = (String) request.getAttribute("id");
			
			reserver = (String) request.getAttribute("r_name");
			phone1 = (String) request.getAttribute("r_phone1");
			phone2 = (String) request.getAttribute("r_phone2");
			phone3 = (String) request.getAttribute("r_phone3");
			tel1 = (String) request.getAttribute("r_tel1");
			tel2 = (String) request.getAttribute("r_tel2");
			tel3 = (String) request.getAttribute("r_tel3");
			email = (String) request.getAttribute("r_email");
			content = (String) request.getAttribute("r_content");
			
			iNight = nights+1;
		}else{
			str = "예약 실패-서버에 사용자가 많습니다. 잠시후 다시 시도하세요!";
		}
	
	}
%>
<HTML>
<HEAD>
	<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<TITLE>Urban Slow City </TITLE>
	<link rel='stylesheet' type='text/css' href='/css/company.css'>
	<script language='javascript' src='/js/common.js'></script>
	<script language="javascript">
		function messageCall(){
			alert(<%= str %>);
			if(result != 1){
				history.go(-1);
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
														<li><a href="/Reservation.do"><img src="/images/reservation/tab2_on.gif" alt="예약하기" /></a></li>
														<li><a href="/Reservation.do?step=rinfo"><img src="/images/reservation/tab3.gif" alt="예약확인" /></a></li>
														<li><a href="/Reservation.do?step=rcancle"><img src="/images/reservation/tab4.gif" alt="예약취소" /></a></li>
													</ul>
												</div>
												<!--//tab-->
												<div class="reser_box">
													<div class="reser_con">
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
																		<td><strong><%= chooseZone %></strong></td>
																	</tr>
																	<tr>
																		<th>이용일자</th>
																		<td><%= chooseDate.substring(0,4)+"년 "+chooseDate.substring(4,6)+"월 "+chooseDate.substring(6,8)+"일" %></td>
																	</tr>
																	<tr>
																		<th>이용기간</th>
																		<td><%= nights %>박 <%=iNight %>일</td>
																	</tr>
																	<tr>
																		<th>Site No.</th>
																		<td><%= productName %></td>
																	</tr>
																	<tr>
																		<th>이용인원</th>
																		<td>유아<%=toddler %>, 아동<%=child %>, 일반<%= users %>명</td>
																	</tr>
																	<tr>
																		<th>결제액</th>
																		<td><b id="allMondy"><% out.print(nf.format(payAll)); %>원</b></td>
																	</tr>
																</tbody>
															</table>
														</div>
													
														<div class="con_box mb25">
															<p class="tit">고객정보입력</p>
															<table class="table1">
																<colgroup>
																	<col width="105" />
																	<col width="*" />
																</colgroup>
																<tbody>
																	<tr>
																		<th><strong class="jinred">*</strong> 예약자명</th>
																		<td><%= reserver %></td>
																	</tr>
																	<tr>
																		<th><strong class="jinred">*</strong> 연락처</th>
																		<td><%= phone1 %>-<%= phone2 %>-<%= phone3 %></td>
																	</tr>
																	<tr>
																		<th>비상연락처</th>
																		<td><%= tel1 %>-<%= tel2 %>-<%= tel3 %></td>
																	</tr>
																	<tr>
																		<th>이메일</th>
																		<td><%= email %></td>
																	</tr>
																	<tr>
																		<th>예약요청사항</th>
																		<td><%=content.replace("\r\n","<br/>") %></td>
																	</tr>
																</tbody>
															</table>
														</div>
																										
														<div class="con_box">
															<p class="tit">이용시 유의사항</p>
															<table class="table1" summary="예약자명, 생년월일, 연락처, 이메일 요청사항, 결제방법을 기입하는 표">
																<colgroup>
																	<col width="105" />
																	<col width="*" />
																</colgroup>
																<tbody>
																	<tr>
																		<th><strong>무통장입금<br/>계좌안내</strong></th>
																		<td>
																			<p class="p1"><strong>국민 037601-04-039667 / 예금주  (주)어반슬로우시티</strong><br/>
																			※ 예약을 신청하신 후 24시간 이내에 무통장입금을 하시면 예약이 완료되며, 미입금시 예약이 취소 됩니다.
																			</p>
																		</td>
																	</tr>
																	<tr>
																		<th><strong>환불/취소<br />수수료 안내</strong></th>
																		<td>
																			<p class="p1">※ 예약의 취소는 위약수수료가 있사오니 신중히 결정하시고 예약을 진행해 주시기 바랍니다.<br />
																			※ 사이트의 예약안내에 명시한 환불기준을 꼭 확인하세요.<br />
																			※ 예약을 취소하신 경우 취소일로부터 7일 이내에 위에 규정된 취소위약 수수료를 제하고 입금됩니다.<br /><br />
																			예약일의 변경은 예약취소에 해당합니다.<br />
																			전화 또는 메일을 이용한 예약취소 후 다시 예약해 주시기 바랍니다.<br /><br />
																			예약취소시 전체금액에 대한 소정의 위약금이 부과됩니다. 그 기준은 다음과 같습니다.<br />
																			-이용당일, 1일전 20%  환불<br />
																			-2~3일 50% 환불<br />
																			-4~5일 70% 환불<br />
																			-6~9일 90% 환불<br />
																			-10일이전 100% 환불<br /><br />
																			성수기(6월~10월) 예약취소시 위약금<br />
																			-이용당일, 7일전 환불불가<br />
																			-8~10일 90% 환불<br />
																			-10일이전 100% 환불
																			</p>
																		</td>
																	</tr>
																</tbody>
															</table>
														</div>				
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
<!-- 전환페이지 설정 -->
 <script type="text/javascript" src="http://wcs.naver.net/wcslog.js"> </script> 
 <script type="text/javascript">
var _nasa={};
 _nasa["cnv"] = wcs.cnv("4","1"); // 전환유형, 전환가치 설정해야함. 설치매뉴얼 참고
</script> 




 <script type="text/javascript"> 
 //<![CDATA[ 
 var DaumConversionDctSv="type=W,orderID=,amount="; 
 var DaumConversionAccountID="LrsJ.vyJcYk_jPjMNcEUOQ00"; 
 if(typeof DaumConversionScriptLoaded=="undefined"&&location.protocol!="file:"){ 
 	var DaumConversionScriptLoaded=true; 
 	document.write(unescape("%3Cscript%20type%3D%22text/javas"+"cript%22%20src%3D%22"+(location.protocol=="https:"?"https":"http")+"%3A//t1.daumcdn.net/cssjs/common/cts/vr200/dcts.js%22%3E%3C/script%3E")); 
 } 
 //]]> 
 </script> 





<!-- Google Code for &#50696;&#50557;&#49888;&#52397; Conversion Page -->
<script type="text/javascript">
/* <![CDATA[ */
var google_conversion_id = 949186539;
var google_conversion_language = "en";
var google_conversion_format = "3";
var google_conversion_color = "ffffff";
var google_conversion_label = "PY5CCMP_nl4Q69_NxAM";
var google_remarketing_only = false;
/* ]]> */
</script>
<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt="" src="//www.googleadservices.com/pagead/conversion/949186539/?label=PY5CCMP_nl4Q69_NxAM&amp;guid=ON&amp;script=0"/>
</div>
</noscript>
<!-- adinsight 주문 총금액 받아옴. start -->
<script language='javascript'> 
 var TRS_AMT='<%=payAll%>'; 
 var TRS_ORDER_ID='<%= chooseDate %>_<%=siteNo%>'; 
</script>
<!-- adinsight 주문 총금액 받아옴. end -->
	<!--bottom-->
	<jsp:include page="/main/bottom.jsp" />
	<!--//bottom-->
	
</BODY>
</HTML>
<script language="javascript" type="text/javascript" src="/js/urban.lib.js?date=1364782903"></script>
<script language="javascript" src="/js/urban.board.js"></script>
