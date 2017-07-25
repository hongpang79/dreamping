package reservation;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

public class Reservation extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 requestPro(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 requestPro(request,response);
	}

	private void requestPro(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		request.setCharacterEncoding("UTF-8");
		String step = request.getParameter("step");
		String path = null;
		Boolean df = true;
		
		if(step == null){
			step = "check";
		}
//		System.out.println("step : " + step);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		
		if(step.equals("check")){
			path = "/reservation/reservation.jsp";
		}else if(step.equals("one")){
			path = "/reservation/reservation_pc.jsp";
			
			if(request.getParameter("agent").equals("mobile")){
				path = "/reservation/reservation_mobile.jsp";
			}
			
			Calendar rightNow = Calendar.getInstance();
			TimeZone tz = TimeZone.getTimeZone("GMT+09:00");
			rightNow.setTimeZone(tz);
			String currentDay = sdf.format(rightNow.getTime()); 
//			System.out.println("currentDay : "+ currentDay);
			
			String nowYear = currentDay.substring(0,4);
			String nowMonth = currentDay.substring(4,6);
			
			String year = (request.getParameter("y") == null ? nowYear : request.getParameter("y"));
			String month = (request.getParameter("m") == null ? nowMonth : request.getParameter("m"));
			
			month = Integer.parseInt(month) < 10 ? "0"+month : month;
			
			if( Integer.parseInt(year) < 1981 || year.length() > 4 ){
				year = nowYear;
			}

			if( Integer.parseInt(month) < 1 || Integer.parseInt(month) > 12 || month.length() > 2 ){
				month = nowMonth;
			}
			
			request.setAttribute("year",year);
			request.setAttribute("month",month);
			
			String ym = year + "-" + month;
			
			ReservationDAO action = new ReservationDAO();
			Vector<SeasonVO> seasons = action.getSeason(request); // 성수기 기간
			Vector<SiteVO> zone = action.getZoneInformation(ym);
			if( zone == null ) {
				path = "/reservation/information.jsp";
			}
			request.setAttribute("seasons",seasons);
			request.setAttribute("zone",zone);
			
			Vector<String> reservationDate = action.reservationDateForZone(zone, year, month);
			request.setAttribute("reservationDate", reservationDate);
			
		}else if(step.equals("two")){
			ReservationDAO action = new ReservationDAO();
			String additionYn = request.getParameter("chooseAddition");
			if(additionYn.equals("Y")){
				path = "/reservation/reservationAddition.jsp";
			}else{
				path = "/reservation/reservationSite.jsp";
			}
			action.getDay(request);
			String chooseDate = (String)request.getParameter("chooseDate");	//선택한 날짜
			Vector<AdditionVO> additionGroupList = action.getAdditionGroupList(chooseDate);
			request.setAttribute("additionGroupList",additionGroupList);
			
			for(int x=0; x<additionGroupList.size(); x++){
				Vector<AdditionVO> additionList = action.getAdditionVector(chooseDate, additionGroupList.get(x).getZoneNo());
				request.setAttribute("additionList"+x,additionList);
			}
			
		
			//회원제일 경우 로그인한 user 정보
//			String id = (String) request.getSession().getAttribute("memId");
//			action.getUserInfo(id,request);
//			request.setAttribute("userInfo", userMap);
			
		}else if(step.equals("addition")){
			df = false;
			ReservationDAO action = new ReservationDAO();
			int chooseZoneNo = Integer.parseInt(request.getParameter("chooseZoneNo"));
			String chooseDate = request.getParameter("chooseDate");

			ArrayList<Map<String,String>> list = action.getAdditionList(chooseDate, chooseZoneNo);
			
			JSONObject obj = new JSONObject();
			obj.put("data", list);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(obj);
			
		}else if(step.equals("search")){
			df = false;
			ReservationDAO action = new ReservationDAO();
			String chooseZone = request.getParameter("chooseZone");
			String chooseDate = request.getParameter("chooseDate");
			String sNight = request.getParameter("sNight");

			ArrayList<Map<String,String>> list = action.getSiteList(chooseZone, chooseDate, sNight);
//			System.out.println("list => " + list.size());
//			String js = JSONArray.toJSONString(list);
			JSONObject obj = new JSONObject();
			obj.put("data", list);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(obj);
		
		}else if(step.equals("roomInfo")){
			df = false;
			//-------------------------------------------------------
			// return JSON : maxMen, addMenPrice, getWeekday, getWeekend, getSweekday, getSweekend, payMoney
			//-------------------------------------------------------		
			ReservationDAO action = new ReservationDAO();
			String productNo = request.getParameter("chooseProductNo");
			String chooseDate = request.getParameter("chooseDate");

			//action.getDepositInformation(request); // 계좌정보
//			Vector<SeasonVO> season = action.getSeason(request); // 성수기 기간
			SiteVO site = action.getSiteForNo(productNo); // site
			int curd = Integer.parseInt(chooseDate);
			String saleYn = "N";
			if(site.getSaleStartDay() != null){
				String ssd = sdf.format(site.getSaleStartDay());
				String sed = sdf.format(site.getSaleEndDay());
				int issd = Integer.parseInt(ssd);
				int ised = Integer.parseInt(sed);
				if(issd <= curd && ised >= curd){
					saleYn = "Y";
				}
			}
			String flatPriceYn = "N";
			if(site.getFlatPriceStartDay() != null){
				String fsd = sdf.format(site.getFlatPriceStartDay());
				String fed = sdf.format(site.getFlatPriceEndDay());
				int ifsd = Integer.parseInt(fsd);
				int ifed = Integer.parseInt(fed);
				if(ifsd <= curd && ifed >= curd){
					flatPriceYn = "Y";
				}
			}
			
			String payMoney = action.payMoney(saleYn, flatPriceYn, site, request);
			
			Map<String,String> resultMap = new HashMap<String,String>();
			resultMap.put("productNo", Integer.toString(site.getProductNo()));
			resultMap.put("productName",site.getProductName());
			resultMap.put("siteNo", Integer.toString(site.getSiteNo())); 
			resultMap.put("users", Integer.toString(site.getUsers()));
			resultMap.put("maxUser", Integer.toString(site.getMaxUsers()));
			resultMap.put("addChildPrice", Integer.toString(site.getAddChildPrice()));
			resultMap.put("addUserPrice", Integer.toString(site.getAddUserPrice()));
			resultMap.put("lowSeasonWeekday", Integer.toString(site.getLowSeasonWeekday()));
			resultMap.put("lowSeasonWeekend", Integer.toString(site.getLowSeasonWeekend()));
			resultMap.put("lowSeasonPicnic", Integer.toString(site.getLowSeasonPicnic()));
			resultMap.put("middleSeasonWeekday", Integer.toString(site.getMiddleSeasonWeekday()));
			resultMap.put("middleSeasonWeekend", Integer.toString(site.getMiddleSeasonWeekend()));
			resultMap.put("middleSeasonPicnic", Integer.toString(site.getMiddleSeasonPicnic()));
			resultMap.put("highSeasonWeekday", Integer.toString(site.getHighSeasonWeekday()));
			resultMap.put("highSeasonWeekend", Integer.toString(site.getHighSeasonWeekend()));
			resultMap.put("highSeasonPicnic", Integer.toString(site.getHighSeasonPicnic()));
			resultMap.put("peakSeasonWeekday", Integer.toString(site.getPeakSeasonWeekday()));
			resultMap.put("peakSeasonWeekend", Integer.toString(site.getPeakSeasonWeekend()));
			resultMap.put("peakSeasonPicnic", Integer.toString(site.getPeakSeasonPicnic()));
			resultMap.put("sale", Integer.toString(site.getSale()));
			resultMap.put("saleYn", saleYn);
			resultMap.put("flatPriceYn", flatPriceYn);
			resultMap.put("saleMemo", site.getSaleMemo());
			resultMap.put("productMemo", site.getProductMemo());
			resultMap.put("payMoney", payMoney);
			JSONObject obj = new JSONObject();
			obj.put("data", resultMap);
//			System.out.println("data = " + resultMap.toString());
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(obj);
		
		}else if(step.equals("three")){
			path = "/reservation/reservationProcess.jsp";
			request.setAttribute("chooseZone", request.getParameter("chooseZone"));
			request.setAttribute("chooseDate", request.getParameter("chooseDate"));
			request.setAttribute("productNo", request.getParameter("productNo"));
			request.setAttribute("productName", request.getParameter("productName"));
			request.setAttribute("siteNo", request.getParameter("siteNo"));
			request.setAttribute("payAll", request.getParameter("payAll"));
			request.setAttribute("nights", request.getParameter("nights"));
			request.setAttribute("toddler", request.getParameter("toddler"));
			request.setAttribute("child", request.getParameter("child"));
			request.setAttribute("users", request.getParameter("users"));
//			request.setAttribute("id", request.getParameter("id"));
			
			if( request.getParameter("payment").equals("card") ){
				request.setAttribute("payment", "C");
				request.setAttribute("cardName", request.getParameter("cardName"));
				request.setAttribute("cardNumber", request.getParameter("cardNumber"));
			}else if( request.getParameter("payment").equals("bank") ){
				request.setAttribute("payment", "V");
			}
			
			request.setAttribute("r_name", request.getParameter("r_name"));
			request.setAttribute("r_phone1", request.getParameter("r_phone1"));
			request.setAttribute("r_phone2", request.getParameter("r_phone2"));
			request.setAttribute("r_phone3", request.getParameter("r_phone3"));
			request.setAttribute("r_tel1", request.getParameter("r_tel1"));
			request.setAttribute("r_tel2", request.getParameter("r_tel2"));
			request.setAttribute("r_tel3", request.getParameter("r_tel3"));
			request.setAttribute("r_email", request.getParameter("r_email"));
			
			String content = request.getParameter("r_content");
//			request.setAttribute("opt_elect", request.getParameter("optElect"));
			
//			String optElect = (String) request.getAttribute("opt_elect");
//			if(optElect != null){
//				if(optElect.equals("Y")){
//					content = "옵션 : 전기사용 "+"<br/>"+ "----"+"<br/>" + content;
//				}
//			}
			request.setAttribute("r_content", content);
			
			String[] additionNo = request.getParameterValues("additionNo[]");
			String[] additionName = request.getParameterValues("additionName[]");
			String[] additionCnt = request.getParameterValues("additionCnt[]");
			String additionTotal = request.getParameter("additionTotal");
			String addition = "";
			if(additionNo != null && additionNo.length > 0){
				for(int x=0; x<additionNo.length; x++){
					addition += additionName[x] + " [수량 : " + additionCnt[x] + " 개] <br>";
				}
			}
			request.setAttribute("addition", addition);
			request.setAttribute("", request.getParameter("r_email"));
			
			ReservationDAO action = new ReservationDAO();
			action.getDepositInformation(request); // 계좌정보
			action.setReservation(request);
			
		}else if(step.equals("rinfo")){
			path = "/reservation/reservationBookProcess.jsp";
//			String id = (String) request.getSession().getAttribute("memId");
			ReservationDAO action = new ReservationDAO();
			Vector<ReservationVO> reservations = null;
//			System.out.println("id : " + id);
//			if(id != null){
//				reservations = action.getReservationDataForMember(id);
//				path = "/main/reservation/reservationBookProcess.jsp";
//			}else{
				String sname = request.getParameter("sch_name");
				if(sname == null){
					path = "/reservation/reservationBook.jsp";
				}else{
					String sphone1 = request.getParameter("sch_phone1");
					String sphone2 = request.getParameter("sch_phone2");
					String sphone3 = request.getParameter("sch_phone3");
					reservations = action.getReservationDataForGuest(sname, sphone1, sphone2, sphone3);
				}
//			}
//			System.out.println("size : " + reservations.size());
			request.setAttribute("reservations", reservations);
			
		}else if(step.equals("rcancle")){
			path = "/reservation/reservationCancel.jsp";
			String reservationNo = request.getParameter("reservationNo");
			if(reservationNo == null){
				path = "/reservation/reservationBook.jsp";
			}else{
				ReservationDAO action = new ReservationDAO();
				ReservationVO reservation = action.getReservationDataForReservationNo(reservationNo);
				request.setAttribute("reservation", reservation);
			}
			
		}else if(step.equals("rcancleOK")){	
			df = false;
			int msgNo = 0;
			String reservationNo = request.getParameter("reservationNo");
			String payStatus = request.getParameter("payStatus");
			if(payStatus.equals("Y")){
				payStatus="C"; //예약취소, 환불요청
				msgNo = 5;
			}else if(payStatus.equals("N")){
				payStatus="R"; //예약취소, 환불없음
				msgNo = 4;
			}
			String remark = request.getParameter("r_cancel_content");
			String refundBank = request.getParameter("r_bank");
			String refundAccount = request.getParameter("r_bank_num");
			String refundDepositor = request.getParameter("r_bank_name");
			ReservationDAO action = new ReservationDAO();
			action.setCancleOk(reservationNo, remark, refundBank, refundAccount, refundDepositor, payStatus, msgNo);
			response.setContentType("text/html; charset=UTF-8");
	    	PrintWriter pr=response.getWriter();
			pr.println("<html>");
			pr.println("<head><script language='JavaScript'>");
			pr.println("alert('예약이 취소 되었습니다.');");
			pr.println("location.href='/Reservation.do';");
			pr.println("</script>");
			pr.println("</head></html>");
			
		}else if(step.equals("siteSearch")){
			df = false;
			ReservationDAO action = new ReservationDAO();
			int zoneNo = Integer.parseInt(request.getParameter("searchZoneNo"));
			ArrayList<Map<String,String>> list = action.getSiteListForZoneNo(zoneNo);
			JSONObject obj = new JSONObject();
			obj.put("data", list);
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(obj);
//			System.out.println("data = " + list.toString());
		}else{
			path = "/reservation/information.jsp";
		}
		
		if(df){
			RequestDispatcher dispatcher = request.getRequestDispatcher(path);
			dispatcher.forward(request,	response);
		}
	}


} 