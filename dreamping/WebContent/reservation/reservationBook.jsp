<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="/header.jsp" />
<link rel="stylesheet" href="/css/bootstrap.theme.css">
<link rel="stylesheet" href="/reservation/css/template.css?ver=3">
<br><br><br><br>
<section class="mbr-section mbr-section__container article" id="header3-n" style="background-color: rgb(255, 255, 255); padding-top: 20px; padding-bottom: 20px;">
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <h3 class="mbr-section-title display-2">예약확인</h3>
                <small class="mbr-section-subtitle">
                	<a href="/Reservation.do"><img src="/reservation/images/tab2.gif" alt="예약하기" /></a>
					<a href="/Reservation.do?step=rinfo"><img src="/reservation/images/tab3_on.gif" alt="예약확인" /></a>
					<a href="/Reservation.do?step=rcancle"><img src="/reservation/images/tab4.gif" alt="예약취소" /></a>
                </small>
            </div>
        </div>
    </div>
</section>

<section class="mbr-section" id="msg-box5-o" style="background-color: rgb(255, 255, 255); padding-top: 0px; padding-bottom: 0px;">
	
	<form id="sch_frm" name="sch_frm" method="post" action="/Reservation.do" onsubmit="return sendit();">
		<input type="hidden" name="step" value="rinfo"/>
	
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<p class="tit">예약확인</p>
				<p class="mb15">
					1. 성명과 휴대폰 번호를 입력하시면 예약 확인이 가능합니다.</br />
					2. 예약 취소는 예약자와 전화번호를 입력하셔야 가능합니다.
				</p>
				<table class="table1" summary="예약번호와 예약자명, 전화번호를 기입해 예약상황을 확인하는 표">
					<tbody>
						<tr>
							<th style="width:105px;">예약자명</th>
							<td><input type="text" id="sch_name" name="sch_name" title="예약자명" class="input_box" style="width:150px;margin-right:5px;" /> <br>예약시 신청하셨던 예약자명 입력하세요.</td>
						</tr>
						<tr>
							<th style="width:105px;">전화번호</th>
							<td>
								<input type="text" id="sch_phone1" name="sch_phone1" maxlength="4" title="전화번호" class="input_box" style="width:50px;" /> - 
								<input type="text" id="sch_phone2" name="sch_phone2" maxlength="4" title="전화번호" class="input_box" style="width:50px;" /> - 
								<input type="text" id="sch_phone3" name="sch_phone3" maxlength="4" title="전화번호" class="input_box" style="width:50px;margin-right:5px;" /><br> 예약시 기록한 핸드폰번호를 적어주세요.</td>
						</tr>
					</tbody>
				</table>
				<p class="mt40 tac"><input type="image" src="/reservation/images/btn_reservation7.gif" alt="예약확인" /></p>
			
			</div>
		</div> <!-- //row -->
	</div> <!-- //container -->		
					
    </form>
</section>									
	
<jsp:include page="/footer.jsp" />
<script type="text/javascript">										
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