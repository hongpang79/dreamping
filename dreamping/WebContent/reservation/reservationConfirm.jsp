<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="reservation.SiteVO" %>
<%@ page import="reservation.DepositVO" %>
<%
	request.setCharacterEncoding("UTF-8");
	NumberFormat nf = NumberFormat.getInstance();
	
	int maxRange = (int)(Integer)request.getAttribute("maxRange");
	String[] days = (String[])request.getAttribute("days");
	String picnicYn = (String)request.getAttribute("picnicYn");
	
	String chooseZone = request.getParameter("chooseZoneName");
	String chooseDate = request.getParameter("chooseDate").toString();
%>
<jsp:include page="/header.jsp" />
<link rel='stylesheet' type='text/css' href='/reservation/css/company.css'>
<br><br><h2></h2>
	<h2><img src="" alt="" /></h2>
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
    									<link rel='stylesheet' type='text/css' href='/reservation/css/sub_layout.css'>
    									<link rel='stylesheet' type='text/css' href='/reservation/css/style.css'>
    									<link rel='stylesheet' type='text/css' href='/reservation/css/template.css'>
    									
    									<div id="contents">
											<div class="con_wrap">
												<!--tab-->
												<div class="con_tab mb30">
													<ul>
														<li><a href="/Reservation.do"><img src="/reservation/images/tab2_on.gif" alt="예약하기" /></a></li>
														<li><a href="/Reservation.do?step=rinfo"><img src="/reservation/images/tab3.gif" alt="예약확인" /></a></li>
														<li><a href="/Reservation.do?step=rcancle"><img src="/reservation/images/tab4.gif" alt="예약취소" /></a></li>
													</ul>
												</div>
												<!--//tab-->
												<div class="reser_box">
													<div class="reser_con">
														<form id="search" name="search">
															<input type="hidden" id="step" name="step" value="" />
															<input type="hidden" name="chooseZone" value="<%= chooseZone %>" />
															<input type="hidden" name="chooseDate" value="<%= chooseDate %>" />
															<input type="hidden" id="sNight" name="sNight" value="" />
															<input type="hidden" id="chooseProductNo" name="chooseProductNo" value="" />
														</form>
														<form name="resForm" method="post" action="/Reservation.do" onSubmit="return chkReservation(this)">
															<input type="hidden" name="step" value="three" />
															<input type="hidden" id="chooseZone" name="chooseZone" value="<%= chooseZone %>" />
															<input type="hidden" name="chooseDate" value="<%= chooseDate %>" />
															<input type="hidden" name="payment" value="bank" />
															<input type="hidden" id="productName" name="productName" value="" />
															<input type="hidden" id="siteNo" name="siteNo" value="" />
															<input type="hidden" id="payAll" name="payAll" value="" />
															<input type="hidden" id="sitePrice" name="sitePrice" value="" />
															<input type="hidden" id="siteUser" name="siteUser" value="" />
															<input type="hidden" id="maxUser" name="maxUser" value="" />
															<input type="hidden" id="addChildPrice" name="addChildPrice" value="" />
															<input type="hidden" id="addUserPrice" name="addUserPrice" value="" />
															<input type="hidden" id="saleYn" name="saleYn" value=""/>
															<input type="hidden" id="sale" name="sale" value="" />
														<div class="con_box mb25">
															<p class="tit">선택내역</p>
															<table class="table1">
																<colgroup>
																	<col width="105" />
																	<col width="*" />
																	<col width="50" />
																</colgroup>
																<tr>
																	<th>ZONE</th>
																	<td colspan="2"><strong><%= chooseZone %></strong></td>
																</tr>
																<tr>
																	<th>이용일자</th>
																	<td colspan="2"><%= chooseDate.substring(0,4)+"년 "+chooseDate.substring(4,6)+"월 "+chooseDate.substring(6,8)+"일 "+days[0]+"요일" %></td>
																</tr>
																<tr>
																	<th>이용기간</th>
																	<td colspan="2">
																		<select id="nights" name="nights">
																			<option value=''>-- SELECT --</option>																			
																			<% String yoil = days[0];
																			   if(yoil.equals("금")||yoil.equals("토")){
																			   }else if(chooseZone.equals("어반하우스")){
																			   }else if(picnicYn.equals("N")){
																			   }else{
																			%>
																				<option value='0'>Picnic</option>
																			<% }
																			   for(int i=1; i<maxRange+1 ; i++){ %>
																				<option value="<%= i %>" /><% out.print(i); out.print("박 "); out.print(i+1); out.print("일 ");%>
																			<% } %>
																		</select>
																	</td>
																</tr>
																<tr>
																	<th>Site No.</th>
																	<td>
																		<select id="productNo" name="productNo">
																			<option value='0'>이용기간을 먼저 선택하세요</option>
																		</select>
																		<br />
																		<b id="wday">
																		<br />
																		<br />
																		<br />
																		</b>
																	</td>
																	<td><a href="javascript:popupSiteMap()"><img src="/reservation/images/map.png"></a></td>
																</tr>
																<tr>
																	<th>이용인원</th>
																	<td colspan="2">유아 
																		<select id="toddler" name="toddler" >
																			<option value="0">-</option>
																		</select>
																		, 아동
																		<select id="child" name="child" onChange="calculatePayAll()">
																			<option value="0">-</option>
																		</select>
																		, 일반
																		<select id="users" name="users" onChange="calculatePayAll()">
																			<option value="0">-</option>
																		</select><b id="mmemo"></b>
																	</td>
																</tr>
															<% if(chooseZone.equals("셀프존")){ %>																
															<!-- 	<tr>
																	<th>옵션</th>
																	<td>전기사용 
																		<select id="optElect" name="optElect" onChange="calculatePayAll()">
																			<option value="N">No</option>
																			<option value="Y">Yes</option>
																		</select>
																		(전기 사용시 5,000원 추가)
																	</td>
																</tr>  -->
 															<% } %>
																<tr>
																	<th>결제액</th>
																	<td colspan="2"><b id="allMondy"></b></td>
																</tr>
														</table>
													</div>
													
													<div class="con_box mb25">
														<p class="tit">예약자정보</p>
														<table class="table1">
															<colgroup>
																<col width="105" />
																<col width="*" />
															</colgroup>
															<tbody>
																<tr>
																	<th><strong class="jinred">*</strong> 예약자명</th>
																	<td><input type="text" id="r_name" name="r_name" title="예약자명" class="input_box" style="width:150px;margin-right:5px;" /> 예약자 실명을 입력하세요. <strong>예약자와 입금자 성함이 동일해야 합니다.</strong></td>
																</tr>
																<tr>
																	<th><strong class="jinred">*</strong> 연락처</th>
																	<td>
																		<input type="text" id="r_phone1" name="r_phone1" maxlength="4" title="연락처" class="input_box" style="width:50px;" /> -
																		<input type="text" id="r_phone2" name="r_phone2" maxlength="4" title="연락처" class="input_box" style="width:50px;" /> -
																		<input type="text" id="r_phone3" name="r_phone3" maxlength="4" title="연락처" class="input_box" style="width:50px;margin-right:5px;"  /> <!-- 예약관련 정보가 문자메시지로 전송됩니다. -->
																	</td>
																</tr>
																<tr>
																	<th>비상연락처</th>
																	<td>
																		<input type="text" id="r_tel1" name="r_tel1" maxlength="4" title="비상연락처" class="input_box" style="width:50px;" /> -
																		<input type="text" id="r_tel2" name="r_tel2" maxlength="4" title="비상연락처" class="input_box" style="width:50px;" /> -
																		<input type="text" id="r_tel3" name="r_tel3" maxlength="4" title="비상연락처" class="input_box" style="width:50px;" /></td>
																</tr>
																<tr>
																	<th>이메일</th>
																	<td><input type="text" id="r_email" name="r_email" title="이메일" class="input_box" style="width:150px;" /></td>
																</tr>
																<tr>
																	<th>예약요청사항</th>
																	<td>
																		<textarea cols="70" rows="12" name="r_content" id="r_content" style="padding:10px;"></textarea>
																	</td>
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
																		※ 예약을 취소하신 경우 취소일로부터 7일 이내에 위에 규정된 취소위약 수수료를 제하고 입금됩니다.<br />
																		※ 결제액은 V.A.T.별도 금액으로 현금영수증 및 세금계산서 증빙 요청시에는<br/>&nbsp;&nbsp;&nbsp; 결제액의 10% V.A.T. 포함 금액을 입금해 주셔야 합니다.<br /><br />
																		예약일의 변경은 예약취소에 해당합니다.<br />
																		전화 또는 메일을 이용한 예약취소 후 다시 예약해 주시기 바랍니다.<br /><br />
																		예약취소시 전체금액에 대한 소정의 위약금이 부과됩니다. 그 기준은 다음과 같습니다.<br />
																		-이용당일, 1일전 20%  환불<br />
																		-2~3일 50% 환불<br />
																		-4~5일 70% 환불<br />
																		-6~7일 90% 환불<br />
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
														<p class="mt10" style="color:#666;"><input type="checkbox" id="reserve_chk" name="reserve_chk" value="Y" title="이용 동의" style="vertical-align:middle;margin:-3px 3px 0 0;"/> <label for="reserve_chk">이용시 유의사항 및 환불/취소 수수료 내역을 확인하였고 이에 동의합니다.</label></p>
													</div>
															
														<ul class="btn mt40">
															<li><input type="image" src="/reservation/images/btn_reservation.gif" alt="예약하기" /></li>
															<li><a href="/Reservation.do?step=one"><img src="/reservation/images/btn_reservation3.gif" alt="이전단계" /></a></li>
														</ul>
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
				</table>

			 </td>
		</tr>
	</table>

<jsp:include page="/footer.jsp" />
<script type="text/javascript" src="/reservation/js/popup.js"></script>
<script type="text/javascript">
//select box 동적변경
//function change_useday(){
$("#nights").change(function(){
	$("#productNo").find('option').each(function(){
		$(this).remove();
	});
	$("#productNo").append("<option value='0'>-- SELECT --</option>");
	var selectVal = $(this).val(); 
	if(selectVal != ''){
		$("#step").val("search");
		$("#sNight").val(selectVal);
		var params = $('#search').serialize();
		$.ajax({
				type: 'POST',
				url: '/Reservation.do',
				data: params,
				dataType: 'json',
				success: function(obj){
					if(obj == null){
						obj = 0;
					}
					//alert(obj.data.length);
					for(var i=0; i<obj.data.length; i++){
						//alert(obj.data[i].rname);out.print(nf.format(price[i-1])+"원");
						$("#productNo").append("<option value='"+obj.data[i].productNo+"'>"+obj.data[i].productName+"</option>");
					}
				}
			});
	}
});	

$("#productNo").change(function(){
	$("#toddler").find('option').each(function(){
		$(this).remove();
	});
	$("#toddler").append("<option value='0'>0명</option>");
	$("#child").find('option').each(function(){
		$(this).remove();
	});
	$("#child").append("<option value='0'>0명</option>");
	$("#users").find('option').each(function(){
		$(this).remove();
	});
	$("#users").append("<option value='0'>0명</option>");
	var selectVal = $(this).val();
	if(selectVal != ''){
		$("#step").val("roomInfo");
		$("#sNight").val($("#nights").val());
		$("#chooseProductNo").val(selectVal);
		var params = $('#search').serialize();
		$.ajax({
			type: 'POST',
			url: '/Reservation.do',
			data: params,
			dataType: 'json',
			success: function(obj){
				if(obj == null){
					obj = 0;
				}
				var maxUserOnePlus = Number(obj.data.maxUser)+1;
				for(var j=1; j<maxUserOnePlus; j++){
					$("#toddler").append("<option value='"+j+"'>"+j+"명</option>");
				}
				for(var k=1; k<maxUserOnePlus; k++){
					$("#child").append("<option value='"+k+"'>"+k+"명</option>");
				}
				for(var i=1; i<maxUserOnePlus; i++){
					$("#users").append("<option value='"+i+"'>"+i+"명</option>");
				}
				$("#productName").val(obj.data.productName);
				$("#siteNo").val(obj.data.siteNo);
				$("#addChildPrice").val(obj.data.addChildPrice);
				$("#addUserPrice").val(obj.data.addUserPrice);
				$("#payAll").val(obj.data.payMoney);
				$("#siteUser").val(obj.data.users);
				$("#maxUser").val(obj.data.maxUser);
				$("#sitePrice").val(obj.data.payMoney);
				$("#saleYn").val(obj.data.saleYn);
				$("#sale").val(obj.data.sale);
				var saleMemo = "";
				if(obj.data.saleYn == "Y"){
					saleMemo = obj.data.saleMemo;
					//saleMemo = saleMemo + " " + obj.data.sale + "%";
				}
				if(obj.data.flatPriceYn == "Y"){
					saleMemo = obj.data.saleMemo;
				}
				
				document.getElementById("mmemo").innerHTML="  (기준인원"+obj.data.users+"명/최대인원"+obj.data.maxUser+"명)<br>(기준인원 초과시 아동 한명당 "+number_format(obj.data.addChildPrice)+"원, 일반 한명당 "+number_format(obj.data.addUserPrice)+"원 추가)";
				document.getElementById("allMondy").innerHTML=number_format(obj.data.payMoney)+"원";
				document.getElementById("wday").innerHTML="-비수기<br />"
						+"(평일 "+number_format(obj.data.lowSeasonWeekday)+"원  / 주말 "+number_format(obj.data.lowSeasonWeekend)+"원  / Picnic "+number_format(obj.data.lowSeasonPicnic)+"원)<br />"
						+"-준성수기<br />"
						+"(평일 "+number_format(obj.data.middleSeasonWeekday)+"원  / 주말 "+number_format(obj.data.middleSeasonWeekend)+"원  / Picnic "+number_format(obj.data.middleSeasonPicnic)+"원)<br />"
						+"-성수기<br />"
						+"(평일 "+number_format(obj.data.highSeasonWeekday)+"원  / 주말 "+number_format(obj.data.highSeasonWeekend)+"원  / Picnic "+number_format(obj.data.highSeasonPicnic)+"원<br />"
						+"<br/><font color='red'>"+saleMemo+"<br/>"+obj.data.productMemo+"</font>";
				//$("#mmemo").val("추가 (한명 추가당 "+number_format(obj.data.addman)+"원 추가)");
				//$("#wday").val("비수기 평일 "+number_format(obj.data.weekday)+"원 추가<br />"
				//		+"비수기 주말 "+number_format(obj.data.weekend)+"원 추가<br />"
				//		+"성수기 평일 "+number_format(obj.data.sweekday)+"원 추가<br />"
				//		+"성수기 주말 "+number_format(obj.data.sweekend)+"원 추가");
				//$("#allMondy").val(number_format(obj.data.payMoney)+"원");
			}
		});		
	}
});

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
   alert(flag);
    return flag;
}

function calculatePayAll(){ 
	var payMoney = Number(document.resForm.sitePrice.value);
	var baseUser = Number(document.resForm.siteUser.value);
	var maxUser = Number(document.resForm.maxUser.value);
	var addChildPrice = Number(document.resForm.addChildPrice.value);
	var addUserPrice = Number(document.resForm.addUserPrice.value);
	var child = Number(document.resForm.child.value);
	var users = Number(document.resForm.users.value);
	var night = Number($("#nights").val());
													
	//var zone = document.resForm.chooseZone.value;
	
	//var saleYn = document.resForm.saleYn.value;
	//if(saleYn == "Y"){
	//	var sale = document.resForm.sale.value;
	//	var isale =  (addChildPrice * sale) / 100;
	//	addChildPrice = addChildPrice - isale;
	//	isale = (addUserPrice * sale) / 100;
	//	addUserPrice = addUserPrice - isale;
	//}
												
	var userSum = child+users;
	if(maxUser < userSum){
		alert("최대인원보다 많은 인원이 선택되었습니다.");
		//$("select#users").focus();
		//return false;
	}
	
	if(userSum < baseUser+1){
		
	}else{
		var adultSum = users-baseUser;
		for(var n=0; n<night; n++){
			if(adultSum == 0){
				for( var j=0; j<child; j++ ){
					payMoney = payMoney + addChildPrice;
				}
			}else if(adultSum > 0){
				for( var i=0; i<adultSum; i++ ){
					payMoney = payMoney + addUserPrice;
				}
				for( var j=0; j<child; j++ ){
					payMoney = payMoney + addChildPrice;
				}
			}else if(adultSum < 0){
				var childSum = baseUser-users;
				childSum = child-childSum;
				//var childSum = Math.abs(baseUser+adultSum-child);
				for( var j=0; j<childSum; j++ ){
					payMoney = payMoney + addChildPrice;
				}
			}
		}
	}
	
	//if(zone == "셀프존"){
	//	 elect = document.resForm.optElect.value;
	//	 if(elect == "Y"){
	//		 payMoney = payMoney + 5000;
	//	 }
	//}
	
	document.resForm.payAll.value = payMoney;
	document.getElementById("allMondy").innerHTML=number_format(payMoney)+"원";
}

function chkReservation(frm){
	var maxUser = Number(document.resForm.maxUser.value);
	var child = Number(document.resForm.child.value);
	var users = Number(document.resForm.users.value);
	
	var userSum = child+users;
	if(maxUser < userSum){
		alert("최대인원보다 많은 인원이 선택되었습니다.");
		$("select#users").focus();
		return false;
	}
	
	if ($("select#nights option:selected").val() == ''){
		alert("이용기간을 선택하세요.");
		$("select#nights").focus();
		return false;
	}
	if ($("select#productNo option:selected").val() < 1){
		alert("Site No.를 선택하세요.");
		$("select#productNo").focus();
		return false;
	}
	
	if ($("select#users option:selected").val() < 1){
		alert("이용인원을 선택하세요.");
		$("select#users").focus();
		return false;
	}
	
	if ($("#r_name").val() == ''){
		alert("예약자명을 입력하십시요.");
		$("#r_name").focus();
		return false;
	}
	
	if ($("#r_phone1").val() == ''){
		alert("연락처를 입력하십시요.");
		$("#r_phone1").focus();
		return false;
	}
	
	if ($("#r_phone2").val() == ''){
		alert("연락처를 입력하십시요.");
		$("#r_phone2").focus();
		return false;
	}
	
	if ($("#r_phone3").val() == ''){
		alert("연락처를 입력하십시요.");
		$("#r_phone3").focus();
		return false;
	}
	
	if (!($("#reserve_chk").prop("checked"))){
		alert("유의사항에 동의해주세요.");
		$("#reserve_chk").focus();
		return false;
	}
	
	//alert("성수기(6월~10월) 예약취소시 위약금 안내\r\n-이용당일, 7일전 환불불가\r\n-8~10일 90% 환불\r\n-10일이전 100% 환불");

	
}

function popupSiteMap(){
	var url = "/reservation/popupSiteMap.jsp";
	popup.openWindowPopup(url, 'SiteMap', {width : '820px', height : '540px'});
}
</script>