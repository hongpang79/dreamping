<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="reservation.ReservationVO" %>
<%
	NumberFormat nf = NumberFormat.getInstance();
	SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
	Vector<ReservationVO> reservations = (Vector<ReservationVO>)request.getAttribute("reservations");
	
	// 현재 날짜 출력
	Calendar now = Calendar.getInstance();
	String todate = transFormat.format(now.getTime());
	int itodate = Integer.parseInt(todate);
	//out.print(todate);
%>
<jsp:include page="/header.jsp" />
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
	
	<div class="container">
		<div class="row">
<% 
	String cLink = "";
	int reservationNo = 0;
	String chooseDate = "";
	int ichooseDate = 0;
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
	String addition = "";
	
	if( reservations != null ){
		for( int j=0; j<reservations.size();j++ ){
			reservationNo = reservations.get(j).getReservationNo();
			chooseDate = transFormat.format(reservations.get(j).getReservationDate());
			ichooseDate = Integer.parseInt(chooseDate);
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
			addition = reservations.get(j).getAddition()==null?"":reservations.get(j).getAddition();
%>
						<div class="col-md-4">
							<p class="tit">이용일자 : <%= chooseDate.substring(0,4)+"년 "+chooseDate.substring(4,6)+"월 "+chooseDate.substring(6,8)+"일" %></p>
							<table class="table1">
								<tbody>
									<tr>
										<th style="width:105px;">시설명</th>
										<td><b id="allZone"><%= zoneName %></b></td>
									</tr>
									<tr>
										<th style="width:105px;">이용기간</th>
										<td><b id="allNight"><%= nights %>박 <% out.print(nights+1); %>일</b></td>
									</tr>
									<tr>
										<th style="width:105px;">상품명</th>
										<td><b id="allSite"><%= productName %></b></td>
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
										<td><b id="allMoney"><% out.print(nf.format(payAll)); %>원</b></td>
									</tr>
									<tr>
										<th style="width:105px;">예약상태</th>
										<td><b id="allStatus"><%= status %></b></td>
									</tr>
									<tr>
										<th style="width:105px;">예약요청사항</th>
										<td><%=content.replace("\r\n","<br/>") %></td>
									</tr>
									
<%
						if((payStatus.equals("N") || payStatus.equals("Y")) && ichooseDate >= itodate){
%>							
									<tr>
										<td colspan="2" style="text-align:center;">
											<form id="sch_frm<%=j %>" name="sch_frm<%=j %>" method="post" action="/Reservation.do">
												<input type="hidden" name="step" value="rcancle"/>
												<input type="hidden" name="reservationNo" value="<%= reservationNo %>"/>
												<input type="image" src="/reservation/images/btn_reservation6.gif" alt="예약취소"/>
											</form>
										</td>
									</tr>
<%
						}
%>											
										
								</tbody>
							</table>
						
						</div>

<%			
		} // end for
		
	}else{
%>
						<div class="col-md-4">
							예약내역이 없습니다.
						</div>
<%		
	}
%>									
			</div>
	</div>
</section>										

<jsp:include page="/footer.jsp" />
<script type="text/javascript">
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
</script>