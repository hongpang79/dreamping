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
	String addition = "";
	
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
			addition = request.getAttribute("addition")==null?"":(String) request.getAttribute("addition");
			
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

	<div class="container">
		<div class="row">
			<div  class="panel panel-info col-md-6">
				<div class="panel-heading">
					<div class="panel-title">
						<p class="tit">예약내역확인</p>
					</div>
				</div>
				<div class="panel-body">
					<table class="table1">
					  <tbody>
						<tr>
							<th style="width:105px;">시설명</th>
							<td><strong><%= chooseZone %></strong></td>
						</tr>
						<tr>
							<th style="width:105px;">이용일자</th>
							<td><%= chooseDate.substring(0,4)+"년 "+chooseDate.substring(4,6)+"월 "+chooseDate.substring(6,8)+"일" %></td>
						</tr>
						<tr>
							<th style="width:105px;">이용기간</th>
							<td><%= nights %>박 <%=iNight %>일</td>
						</tr>
						<tr>
							<th style="width:105px;">상품명</th>
							<td><%= productName %></td>
						</tr>
						<tr>
							<th style="width:105px;">이용인원</th>
							<td>유아<%=toddler %>, 아동<%=child %>, 일반<%= users %>명</td>
						</tr>
						<tr>
							<th style="width:105px;">옵션상품</th>
							<td><%=addition %></td>
						</tr>
						<tr>
							<th style="width:105px;">결제액</th>
							<td><b id="allMondy"><% out.print(nf.format(payAll)); %>원</b></td>
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
							<td><%= reserver %></td>
						</tr>
						<tr>
							<th style="width:105px;"><strong class="jinred">*</strong> 연락처</th>
							<td><%= phone1 %>-<%= phone2 %>-<%= phone3 %></td>
						</tr>
						<tr>
							<th style="width:105px;">비상연락처</th>
							<td><%= tel1 %>-<%= tel2 %>-<%= tel3 %></td>
						</tr>
						<tr>
							<th style="width:105px;">이메일</th>
							<td><%= email %></td>
						</tr>
						<tr>
							<th style="width:105px;">예약요청사항</th>
							<td><%=content.replace("\r\n","<br/>") %></td>
						</tr>
					  </tbody>
					</table>
				</div>
			</div>

			
			<div class="col-md-12">
				<p class="tit">이용시 유의사항</p>
				<table class="table1" summary="예약자명, 생년월일, 연락처, 이메일 요청사항, 결제방법을 기입하는 표">
					<tbody>
						<tr>
							<th style="width:105px;"><strong>무통장입금<br/>계좌안내</strong></th>
							<td>
								<p class="p1"><strong>국민 401301-04-057170 / 예금주  엠앤엠레저컨설팅</strong><br/>
								※ 예약을 신청하신 후 24시간 이내에 무통장입금을 하시면 예약이 완료되며, 미입금시 예약이 취소 됩니다.
								</p>
							</td>
						</tr>
						<tr>
							<th style="width:105px;"><strong>환불/취소<br />수수료 안내</strong></th>
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
</section>

<jsp:include page="/footer.jsp" />
<script type="text/javascript">
$(function(){
	alert('<%= str %>');
	if(result != 1){
		history.go(-1);
	}
});
</script>