<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="reservation.AdditionVO" %>
<%@ page import="reservation.DepositVO" %>
<%@ page import="java.util.Vector" %>
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
    <form name="resForm" method="post" action="/Reservation.do">
		<input type="hidden" name="step" value="three" />
		<input type="hidden" id="chooseZone" name="chooseZone" value="<%= chooseZone %>" />
		<input type="hidden" name="chooseDate" value="<%= chooseDate %>" />
		<input type="hidden" name="payment" value="bank" />
		<input type="hidden" id="productName" name="productName" value="" />
		<input type="hidden" id="siteNo" name="siteNo" value="0" />
		<input type="hidden" id="payAll" name="payAll" value="" />
		<input type="hidden" id="sitePrice" name="sitePrice" value="" />
		<input type="hidden" id="siteUser" name="siteUser" value="" />
		<input type="hidden" id="maxUser" name="maxUser" value="" />
		<input type="hidden" id="addChildPrice" name="addChildPrice" value="" />
		<input type="hidden" id="addUserPrice" name="addUserPrice" value="" />
		<input type="hidden" id="saleYn" name="saleYn" value=""/>
		<input type="hidden" id="sale" name="sale" value="" />
		<input type="hidden" id="nights" name="nights" value="0" />
		<input type="hidden" id="productNo" name="productNo" value="0" />
		<input type="hidden" id="toddler" name="toddler" value="0" />
		<input type="hidden" id="child" name="child" value="0" />
		<input type="hidden" id="users" name="users" value="0" />
    <div class="container">
        <div class="row">
			<div  class="panel panel-info col-md-6">
				<div class="panel-heading">
					<div class="panel-title">
						<p class="tit">선택내역</p>
					</div>
				</div>
				<div class="panel-body">
					<table class="table1">
					  <tbody>
						<tr>
							<th style="width:105px;">시설명</th>
							<td><strong><%= chooseZone %></td>
						</tr>
						<tr>
							<th style="width:105px;">이용일자</th>
							<td><%= chooseDate.substring(0,4)+"년 "+chooseDate.substring(4,6)+"월 "+chooseDate.substring(6,8)+"일 "+days[0]+"요일" %></td>
						</tr>
						<tr>
							<th style="width:105px;">추가옵션</th>
							<td>
								<%  Vector<AdditionVO> additionGroupList = (Vector<AdditionVO>)request.getAttribute("additionGroupList"); 
									for(int x=0; x<additionGroupList.size(); x++){
										int zoneNo = additionGroupList.get(x).getZoneNo();
										String zoneName = additionGroupList.get(x).getZoneName();
										String selectName = "additionList"+x;
										//out.print(zoneName);
								%>
									<select id="zone<%=zoneNo %>" name="zone<%=zoneNo %>">
										<option value="">--- <%=zoneName %> 선택 ---</option>
								<%
										Vector<AdditionVO> additionList = (Vector<AdditionVO>)request.getAttribute(selectName); 
												for(int z=0; z<additionList.size(); z++){
													int additionNo = additionList.get(z).getAdditionNo();
													String additionName = additionList.get(z).getAdditionName()+" [("+additionList.get(z).getUnit() + ") " + additionList.get(z).getAdditionPrice()+"원]";
													int additionPrice = additionList.get(z).getAdditionPrice();
								%>
														<option value="<%=additionNo+":"+additionPrice%>"><%=additionName %></option>
								<%										
												}
								%>		
									</select>
									<img src="/reservation/images/btn_add.gif" class="linked" align="absmiddle" onclick="addAddition('zone<%=zoneNo %>');" alt="추가"></br></br>
								<%
									}
						
								%>
							</td>
						</tr>
						<tr>
							<th style="width:105px;">옵션선택내용</th>
							<td><input type="hidden" id="additionTotal" name="additionTotal" value="0"/>
								<span id="additionSelected"></span>
								<b id="additionMondy"></b>
							</td>
						</tr>
						<tr>
							<th style="width:105px;">결제액</th>
							<td><b id="allMondy"></b></td>
						</tr>
					  </tbody>
					</table>
				</div>
			</div>
			
			
			<div class="panel panel-default col-md-6">
			  <div class="panel-heading"><p class="tit">예약자정보</div>
			  <div class="panel-body">
				   <table class="table1">
					<tbody>
						<tr>
							<th style="width:105px;"><strong class="jinred">*</strong> 예약자명</th>
							<td><input type="text" id="r_name" name="r_name" title="예약자명" class="input_box" style="width:150px;margin-right:5px;" /> 
								<br>예약자 실명을 입력하세요.<br><strong>예약자와 입금자 성함이 동일해야 합니다.</strong>
							</td>
						</tr>
						<tr>
							<th style="width:105px;"><strong class="jinred">*</strong> 연락처</th>
							<td>
								<input type="text" id="r_phone1" name="r_phone1" maxlength="4" title="연락처" class="input_box" style="width:50px;" /> -
								<input type="text" id="r_phone2" name="r_phone2" maxlength="4" title="연락처" class="input_box" style="width:50px;" /> -
								<input type="text" id="r_phone3" name="r_phone3" maxlength="4" title="연락처" class="input_box" style="width:50px;margin-right:5px;"  /> <!-- 예약관련 정보가 문자메시지로 전송됩니다. -->
							</td>
						</tr>
						<tr>
							<th style="width:105px;">비상연락처</th>
							<td>
								<input type="text" id="r_tel1" name="r_tel1" maxlength="4" title="비상연락처" class="input_box" style="width:50px;" /> -
								<input type="text" id="r_tel2" name="r_tel2" maxlength="4" title="비상연락처" class="input_box" style="width:50px;" /> -
								<input type="text" id="r_tel3" name="r_tel3" maxlength="4" title="비상연락처" class="input_box" style="width:50px;" /></td>
						</tr>
						<tr>
							<th style="width:105px;">이메일</th>
							<td><input type="text" id="r_email" name="r_email" title="이메일" class="input_box" style="width:150px;" /></td>
						</tr>
						<tr>
							<th style="width:105px;">예약요청사항</th>
							<td>
								<textarea rows="12" name="r_content" id="r_content" style="width:100%;padding:10px;"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
			  </div>
			</div>
			
			<div class="col-md-12">
				<p class="tit">이용시 유의사항</p>
				<table class="table" summary="예약자명, 생년월일, 연락처, 이메일 요청사항, 결제방법을 기입하는 표">
					<tbody>
						<tr>
							<th style="width:105px;"><strong>무통장입금<br/>계좌안내</strong></th>
							<td>
								<p class="p1"><strong>국민 037601-04-039667 / 예금주  (주)더드림핑</strong><br/>
								※ 예약을 신청하신 후 24시간 이내에 무통장입금을 하시면 예약이 완료되며, 미입금시 예약이 취소 됩니다.
								</p>
							</td>
						</tr>
						<tr>
							<th style="width:105px;"><strong>환불/취소<br />수수료 안내</strong></th>
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
						<tr>
							<th style="width:105px;"><strong>개인정보 활용 동의</strong></th>
							<td>
								<p class="p1">귀하의 소중한 개인정보는 개인정보보호법의 관련 규정에 의하여 예약 및 조회 등 아래의 목적으로 수집 및 이용됩니다.</br>
								1. 개인정보의 수집·이용 목적 - 프로그램/숙박/대관 예약, 조회를 위한 본인 확인 절차</br>
								2. 개인정보 수집 항목 - 예약자명, 핸드폰, 전화번호, 이메일</br>
								3. 개인정보의 보유 및 이용기간 - 이용자의 개인정보는 원칙적으로 개인정보의 처리목적이 달성되면 지체 없이 파기합니다.</br>
								예약을 위하여 수집된 개인정보는 ‘전자상거래 등에서의 소비자보호에 관한 법률’ 제6조에의거 정해진 기간동안 보유됩니다.</br>
								※ 고객님께 예약서비스를 제공하기 위한 최소한의 정보를 수집합니다.</br>
								</p>
							</td>
					</tbody>
				</table>
				<p class="mt10" style="color:#666;"><input type="checkbox" id="reserve_chk" name="reserve_chk" value="Y" title="이용 동의" style="vertical-align:middle;margin:-3px 3px 0 0;"/> <label for="reserve_chk">이용시 유의사항 및 환불/취소 수수료 내역을 확인하였고, 개인정보 활용에  동의 합니다.</label></p>
			</div>
			<div class="col-md-12">		
				<ul class="btn mt40">
					<li><a href="javascript:chkReservation();"><img src="/reservation/images/btn_reservation.gif" alt="예약하기" /></a></li>
					<li><a href="/Reservation.do?step=one"><img src="/reservation/images/btn_reservation3.gif" alt="이전단계" /></a></li>
				</ul>
			</div>
		</div> <!-- row -->
	</div> <!-- container -->
	</form>
<!-- //예약게시판 끝 -->

</section>										
<form id="search" name="search">
	<input type="hidden" id="step" name="step" value="" />
	<input type="hidden" name="chooseZone" value="<%= chooseZone %>" />
	<input type="hidden" name="chooseDate" value="<%= chooseDate %>" />
	<input type="hidden" id="sNight" name="sNight" value="" />
	<input type="hidden" id="chooseProductNo" name="chooseProductNo" value="" />
	<input type="hidden" id="chooseZoneNo" name="chooseZoneNo" value="" />
</form>

<jsp:include page="/footer.jsp" />
<script type="text/javascript" src="/reservation/js/popup.js"></script>
<script type="text/javascript">
//select box 동적변경
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
					+"(평일 "+number_format(obj.data.lowSeasonWeekday)+"원  / 주말 "+number_format(obj.data.lowSeasonWeekend)+"원)<br />"
					+"-준성수기<br />"
					+"(평일 "+number_format(obj.data.middleSeasonWeekday)+"원  / 주말 "+number_format(obj.data.middleSeasonWeekend)+"원)<br />"
					+"-성수기<br />"
					+"(평일 "+number_format(obj.data.highSeasonWeekday)+"원  / 주말 "+number_format(obj.data.highSeasonWeekend)+"원)<br />"
					+"<br/><font color='red'>"+saleMemo+"<br/>"+obj.data.productMemo+"</font>";
				//2017.07.14 picnic 제외	
				//document.getElementById("wday").innerHTML="-비수기<br />"
				//		+"(평일 "+number_format(obj.data.lowSeasonWeekday)+"원  / 주말 "+number_format(obj.data.lowSeasonWeekend)+"원  / Picnic "+number_format(obj.data.lowSeasonPicnic)+"원)<br />"
				//		+"-준성수기<br />"
				//		+"(평일 "+number_format(obj.data.middleSeasonWeekday)+"원  / 주말 "+number_format(obj.data.middleSeasonWeekend)+"원  / Picnic "+number_format(obj.data.middleSeasonPicnic)+"원)<br />"
				//		+"-성수기<br />"
				//		+"(평일 "+number_format(obj.data.highSeasonWeekday)+"원  / 주말 "+number_format(obj.data.highSeasonWeekend)+"원  / Picnic "+number_format(obj.data.highSeasonPicnic)+"원<br />"
				//		+"<br/><font color='red'>"+saleMemo+"<br/>"+obj.data.productMemo+"</font>";
				//end 2017.07.14
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
	var additionTotal =Number($("#additionTotal").val());	
	
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
	payMoney = payMoney+additionTotal;
	//if(zone == "셀프존"){
	//	 elect = document.resForm.optElect.value;
	//	 if(elect == "Y"){
	//		 payMoney = payMoney + 5000;
	//	 }
	//}
	
	document.resForm.payAll.value = payMoney;
	document.getElementById("allMondy").innerHTML=number_format(payMoney)+"원";
}

function chkReservation(){
	
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
	document.resForm.submit();
	
}

function additionCalc(additionRow){
	var additionPrice = Number($("#additionPrice"+additionRow).val());
	var additionCnt = Number($("#additionCnt"+additionRow).val());
	//alert(additionPrice);
	//alert(additionCnt);
	var additionSum = 0;
	for(var k=0; k<additionCnt; k++){
		additionSum = additionSum + additionPrice;
	}
	
	$("#additionSum"+additionRow).val(additionSum);
	//alert(additionSum);
	
	var additionTotal = 0;
	var rowCnt = document.getElementsByName("additionSum[]").length;
	var arrAdditionSum = $("input[name='additionSum[]']").map(function(){return $(this).val();}).get();
	for(var i=0; i<rowCnt; i++){
		//alert(arrAdditionSum[i]);
		additionTotal = additionTotal+Number(arrAdditionSum[i]);
	}
		
	$("#additionTotal").val(additionTotal);
	document.getElementById("additionMondy").innerHTML="옵션요금 합계 "+number_format(additionTotal)+"원";
	calculatePayAll();
}

var additionRow = 1;
function addAddition(zoneNo){
	var addition = $("select#"+zoneNo+" option:selected").val();
	var additionName = $("select#"+zoneNo+" option:selected").text();
	var arrAddition = addition.split(':');
	var additionNo = arrAddition[0];
	var additionPrice = arrAddition[1];
	//alert(additionNo+" : " +additionName+" : "+additionPrice);
	if(additionNo == ""){
		alert("추가옵션을 선택하세요");
		return false;
	}
	var addRow = "<div id='additionSelect"+additionRow+"'>";
	addRow += '<input type="hidden" id="additionNo'+additionRow+'" name="additionNo[]" value="'+additionNo+'">';
	addRow += '<input type="hidden" id="additionName'+additionRow+'" name="additionName[]" value="'+additionName+'">';
	addRow += '<input type="hidden" id="additionPrice'+additionRow+'" name="additionPrice[]" value="'+additionPrice+'">';
	addRow += '<input type="hidden" id="additionSum'+additionRow+'" name="additionSum[]" value="'+additionPrice+'">';
	addRow += additionName;
	addRow += '&nbsp;<input type="number" style="width:50px;" id="additionCnt'+additionRow+'" name="additionCnt[]" min="0" value="1" onChange="javascript:additionCalc(\''+additionRow+'\');">&nbsp;';
	addRow += '<img src="/reservation/images/btn_del.gif" class="linked" align="absmiddle" onclick="deleteAdditionRows(\''+additionRow+'\');" alt="삭제">';
	addRow += '</br></div>';
	
	$("#additionSelected").append(addRow);
	additionCalc(additionRow);
	additionRow++;
}

function deleteAdditionRows(additionRow){
	$("#additionSelect"+additionRow).remove();
	additionCalc(additionRow);
}

function addRows(type, zoneNo){
	
	var addRow = "";

    var rowCnt = document.getElementsByName(type+"_add[]").length;
    
    $("#step").val("addition");
	$("#chooseZoneNo").val(zoneNo);
    var params = $('#search').serialize();
	$.ajax({
			type: 'POST',
			url: '/Reservation.do',
			data: params,
			dataType: 'json',
			success: function(obj){   //{"data":[{"unit":"ê°œ","zoneNo":"5","additionName":"ë¬´ì œí•œ 3ì‹œê°„ 2ì¸","additionMemo":"","quantity":"9999","additionPrice":"100000","additionNo":"6"}]}
				if(obj == null){
					obj = 0;
				}
				
				addRow += '<span id="'+type+'Row'+rowCnt+'">';
			    addRow += '<br><br>';
			    addRow += '<input type="hidden" id="'+type+'UseFlag'+rowCnt+'" name="'+type+'UseFlag[]" value="T">';
			    addRow += '<select name="'+type+'[]">';
			    addRow += '<option value="">----- 선택안함 -----</option>';
				
				//alert(obj.data.length);
				for(var i=0; i<obj.data.length; i++){				
					//String additionName = additionList.get(z).getAdditionName()+" [("+additionList.get(z).getUnit() + ") " + additionList.get(z).getAdditionPrice()+"원]";
					addRow += '<option value="'+obj.data[i].additionNo+'">'+obj.data[i].additionName+' [('+obj.data[i].unit+') '+obj.data[i].additionPrice+'원]</option>';
					addRow += '<div id="'+obj.data[i].additionNo+'" value="'+obj.data[i].additionPrice+'"></div>';
				}
				
				addRow += '</select>&nbsp;';
		    	addRow += '<input type="number" style="width:50px;" id="'+type+'_add[]" name="'+type+'_add[]">&nbsp;';
//			if(rowCnt < obj.data.length){    
		    	addRow += '<img src="/reservation/images/btn_add.gif" class="linked" align="absmiddle" onclick="addRows(\''+type+'\',\''+zoneNo+'\');" alt="추가">&nbsp;';
//			}
		    	addRow += '<img src="/reservation/images/btn_del.gif" class="linked" align="absmiddle" onclick="deleteRows(\''+type+'\', '+rowCnt+');" alt="삭제">';
		    	addRow += '</span>';

		    	document.getElementById(type+"Add").innerHTML += addRow;
		    	//alert(addRow);
			}
	});
		
}

function deleteRows(type, num){

    document.getElementById(type+"Row"+num).style.display = 'none';

    //if(type.indexOf("add") < 0){
    //    document.getElementById("deleted_rows["+num+"]").value = num;
    //}

    document.getElementById(type+"UseFlag"+num).value = 'F';
}

function popupSiteMap(){
	var url = "/reservation/popupSiteMap.jsp";
	popup.openWindowPopup(url, 'SiteMap', {width : '820px', height : '540px'});
}
</script>