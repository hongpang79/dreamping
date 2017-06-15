package admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import reservation.DepositVO;
import reservation.ReservationVO;
import util.CommonUtil;
import util.ConnectionUtil;

public class ReservationDAO {
	
	// DB연결객체 Close
	private void close(ResultSet rs,PreparedStatement pstmt,Connection conn){
		if(rs != null) try{ rs.close(); }catch(SQLException e){}finally{ rs = null; }
		if(pstmt != null) try{ pstmt.close(); }catch(SQLException e){}finally{ pstmt = null; }
		if(conn != null) try{ conn.close(); }catch(SQLException e){}finally{ conn = null; }
	}
	
	private static ReservationDAO instance = new ReservationDAO();
	
	public ReservationDAO(){}
	
	// 객체 리턴
	public static ReservationDAO getInstance(){
		return instance;
	}
	
	// 리스트출력 예약정보 검색(YYYY-MM-DD ~ YYYY-MM-DD)
	public Vector<ReservationVO> selectOrderList(String startDate, String endDate, String periodGubun, String searchSite, String searchUserName, String mode, String sort){
		Vector<ReservationVO> reservations = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String WHERE = " WHERE ";
		if(periodGubun.equals("order")){
			WHERE = WHERE + "reg_date ";
		}else if(periodGubun.equals("period")){
			WHERE = WHERE + "reservation_date ";
		}
		
		String ANDSITE = "";
		if(searchSite != null){
			if(searchSite.length() > 0){
				ANDSITE = " AND site_name LIKE '%" + searchSite + "%' ";
			}
		}
		
		String ANDUSER = "";
		if(searchUserName != null){
			if(searchUserName.length() > 0){
				ANDUSER = " AND reserver LIKE '%" + searchUserName + "%' ";
			}
		}
		
		String ANDMODE = "";
		if(mode != null){
			if(mode.length() > 0){
				ANDMODE = " AND pay_status IN ("+mode+") ";
			}
		}
		
		String ORDER = "reg_date";
		if(sort != null){
			if(sort.length() > 0){
				ORDER = sort;
			}
		}
		
		String SQL = "SELECT RM.zone_name, RM.product_name, RM.site_name, R.* FROM reservation R " +
	             "LEFT OUTER JOIN (select zone_name, product_no, product_name, site_no, site_name FROM product s, zone_information z WHERE z.zone_no = s.zone_no) RM " +
			     "ON R.product_no=RM.product_no " +
			     WHERE + " BETWEEN DATE_FORMAT(?,'%Y-%m-%d %H:%i:%s') AND DATE_FORMAT(?,'%Y-%m-%d %H:%i:%s') " +
			     ANDSITE + ANDUSER + ANDMODE +
			     "ORDER BY "+ORDER;
//		System.out.println("[ReservationDAO][selectOrderList] SQL = " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, startDate+" 00:00:00");
			pstmt.setString(2, endDate+" 23:59:59");
			rs = pstmt.executeQuery();

			
			if( rs.next() ){
				reservations = new Vector<ReservationVO>();
				do{
					ReservationVO reservation = new ReservationVO();
					reservation.setReservationNo(rs.getInt("reservation_no"));
					reservation.setReservationDate(rs.getDate("reservation_date"));
					reservation.setZoneName(rs.getString("zone_name"));
					reservation.setProductName(rs.getString("product_name"));
					reservation.setReserver(rs.getString("reserver"));
					reservation.setToddler(rs.getInt("toddler"));
					reservation.setChild(rs.getInt("child"));
					reservation.setUsers(rs.getInt("users"));
					reservation.setNights(rs.getInt("nights"));
					reservation.setPrice(rs.getInt("price"));
					reservation.setRegDate(rs.getDate("reg_date"));
					reservation.setPhone1(rs.getString("phone1"));
					reservation.setPhone2(rs.getString("phone2"));
					reservation.setPhone3(rs.getString("phone3"));
					reservation.setCell1(rs.getString("cell1"));
					reservation.setCell2(rs.getString("cell2"));
					reservation.setCell3(rs.getString("cell3"));
					reservation.setEmail(rs.getString("email"));
					reservation.setMemo(rs.getString("memo"));
					reservation.setPayStatus(rs.getString("pay_status"));
					reservation.setAdminMemo(rs.getString("admin_memo"));
					reservations.add(reservation);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return reservations;
	}
	
	public Vector<ReservationVO> selectStayOrderList(String startDate, String endDate, String searchSite, String searchUserName, String mode, String sort){
		Vector<ReservationVO> reservations = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
			
		String ANDSITE = "";
		if(searchSite != null){
			if(searchSite.length() > 0){
				ANDSITE = " AND site_name LIKE '%" + searchSite + "%' ";
			}
		}
		
		String ANDUSER = "";
		if(searchUserName != null){
			if(searchUserName.length() > 0){
				ANDUSER = " AND reserver LIKE '%" + searchUserName + "%' ";
			}
		}
		
		String ANDMODE = "";
		if(mode != null){
			if(mode.length() > 0){
				ANDMODE = " AND pay_status IN ("+mode+") ";
			}
		}
		
		String ORDER = "reg_date";
		if(sort != null){
			if(sort.length() > 0){
				ORDER = sort;
			}
		}
		
		String SQL = "SELECT RM.zone_name, RM.product_name, RM.site_name, R.* FROM reservation R " +
	             "LEFT OUTER JOIN (select zone_name, product_no, product_name, site_no, site_name FROM product s, zone_information z WHERE z.zone_no = s.zone_no) RM " +
			     "ON R.product_no=RM.product_no " +
			     "WHERE reservation_no IN (SELECT reservation_no FROM reservation_day WHERE reservation_day BETWEEN ? AND ? AND pay_status IN ('W','C') ) " +
			     "AND reservation_date NOT BETWEEN DATE_FORMAT(?,'%Y-%m-%d %H:%i:%s') AND DATE_FORMAT(?,'%Y-%m-%d %H:%i:%s') " +
			     ANDSITE + ANDUSER + ANDMODE +
			     
			     "ORDER BY "+ORDER;
//		System.out.println("[ReservationDAO][selectStayOrderList] SQL = " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, startDate.replaceAll("-", ""));
			pstmt.setString(2, endDate.replaceAll("-", ""));
			pstmt.setString(3, startDate+" 00:00:00");
			pstmt.setString(4, endDate+" 23:59:59");
			rs = pstmt.executeQuery();

			
			if( rs.next() ){
				reservations = new Vector<ReservationVO>();
				do{
					ReservationVO reservation = new ReservationVO();
					reservation.setReservationNo(rs.getInt("reservation_no"));
					reservation.setReservationDate(rs.getDate("reservation_date"));
					reservation.setZoneName(rs.getString("zone_name"));
					reservation.setProductName(rs.getString("product_name"));
					reservation.setReserver(rs.getString("reserver"));
					reservation.setToddler(rs.getInt("toddler"));
					reservation.setChild(rs.getInt("child"));
					reservation.setUsers(rs.getInt("users"));
					reservation.setNights(rs.getInt("nights"));
					reservation.setPrice(rs.getInt("price"));
					reservation.setRegDate(rs.getDate("reg_date"));
					reservation.setPhone1(rs.getString("phone1"));
					reservation.setPhone2(rs.getString("phone2"));
					reservation.setPhone3(rs.getString("phone3"));
					reservation.setCell1(rs.getString("cell1"));
					reservation.setCell2(rs.getString("cell2"));
					reservation.setCell3(rs.getString("cell3"));
					reservation.setEmail(rs.getString("email"));
					reservation.setMemo(rs.getString("memo"));
					reservation.setPayStatus(rs.getString("pay_status"));
					reservation.setAdminMemo(rs.getString("admin_memo"));
					reservations.add(reservation);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return reservations;
	}
	
	
	public String updateReservation(String status, String reservationNo){
		String currentDateTime = CommonUtil.callDateTime();
		String msg = "예약숭인 처리 되었습니다.";
		String dayStatus = "C";
		int msgNo = 3;
		String dvsn = "user";
		if(status.equals("C")||status.equals("R")){
			dayStatus = "R";
			msg = "예약취소 처리 되었습니다.";
			msgNo = 4;
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "UPDATE reservation SET pay_status = ? WHERE reservation_no = ?";
		if(status.equals("C")){
			SQL = "UPDATE reservation SET pay_status = ?, refund_reg_date=now() WHERE reservation_no = ?";
		}
		String SQL1 = "UPDATE reservation_day SET pay_status = ? WHERE reservation_no = ?";
		
		String ResSQL = "SELECT p.product_name, date_format(r.reservation_date,'%Y-%m-%d') as reservation_date, r.phone1, r.phone2, r.phone3 FROM reservation r, product p WHERE r.product_no=p.product_no and r.reservation_no=?";
		
		String MsgSQL = "SELECT msg FROM sms_manager WHERE msg_no=? and dvsn=? ";
		
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, status);
			pstmt.setString(2, reservationNo);
			
			int result = pstmt.executeUpdate();
			
			System.out.println(currentDateTime + " [admin.reservationDAO.updateReservation] SQL - reservation_no : " + reservationNo + " update count="+result);
			
			int rtn = 0;
			if(result == 1){
				pstmt = conn.prepareStatement(SQL1);
				pstmt.setString(1, dayStatus);
				pstmt.setString(2, reservationNo);
				rtn = pstmt.executeUpdate();
				
				String phoneNumber = "";
				String resDate = "";
				String productName = "";
				String smsMsg = "";
				pstmt = conn.prepareStatement(ResSQL);
				pstmt.setString(1, reservationNo);
				rs = pstmt.executeQuery();
				if(rs.next()){
					productName = rs.getString("product_name");
					resDate = rs.getDate("reservation_date").toString();
					phoneNumber = rs.getString("phone1")+rs.getString("phone2")+rs.getString("phone3");
				}
				
				if(phoneNumber.length() > 9){
					pstmt = conn.prepareStatement(MsgSQL);
					pstmt.setInt(1, msgNo);
					pstmt.setString(2, dvsn);
					rs = pstmt.executeQuery();
					if( rs.next() ){
						smsMsg = rs.getString(1);
						smsMsg = smsMsg.replace("[DATE]", resDate);
						smsMsg = smsMsg.replace("[SITENAME]", productName);
					}
					util.CallSMS.callSMS(Integer.parseInt(reservationNo), msgNo, phoneNumber, smsMsg);
				}
				
			}
			
			System.out.println(currentDateTime + " [admin.reservationDAO.updateReservation] SQL1 - reservation_day update check : pay_status="+dayStatus+" , update count=" + rtn);
			
			if(result == 0){
				msg = "처리중 오류가 발생했습니다.";
			}
		}catch(Exception e){
			msg = "처리중 오류가 발생했습니다. \n 관리자에게 문의하세요!";
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return msg;
	}
	
	public String updateReservationAdminComment(String reservationNo, String price, String adminMemo){
//		System.out.println(adminMemo + "," + reservationNo);
		String msg = "저장 되었습니다.";
//		int iPrice = Integer.parseInt(price);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "UPDATE reservation SET admin_memo = ?, price=? WHERE reservation_no = ?";
		
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, adminMemo);
			pstmt.setString(2, price);
			pstmt.setString(3, reservationNo);
			
			int result = pstmt.executeUpdate();
			
			if(result == 0){
				msg = "처리중 오류가 발생했습니다.";
			}
		}catch(Exception e){
			msg = "처리중 오류가 발생했습니다. \n 관리자에게 문의하세요!";
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return msg;
	}
	
	public String updateReservationRefundComment(String reservationNo, String refundPrice, String refundMemo){
//		System.out.println(adminMemo + "," + reservationNo);
		String msg = "저장 되었습니다.";
//		int iPrice = Integer.parseInt(price);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "UPDATE reservation SET refund_memo = ?, refund_price=? WHERE reservation_no = ?";
		
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, refundMemo);
			pstmt.setString(2, refundPrice);
			pstmt.setString(3, reservationNo);
			
			int result = pstmt.executeUpdate();
			
			if(result == 0){
				msg = "처리중 오류가 발생했습니다.";
			}
		}catch(Exception e){
			msg = "처리중 오류가 발생했습니다. \n 관리자에게 문의하세요!";
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return msg;
	}
	
	// 리스트출력 환불정보 검색(YYYY-MM-DD ~ YYYY-MM-DD)
	public Vector<ReservationVO> selectRefundList(String startDate, String endDate, String periodGubun, String searchSite, String searchUserName, String mode){
//		System.out.println("[ReservationDAO][selectRefundList] [startDate] : " + startDate);
//		System.out.println("[ReservationDAO][selectRefundList] [endDate] : " + endDate);
//		System.out.println("[ReservationDAO][selectRefundList] [periodGubun] : " + periodGubun);
//		System.out.println("[ReservationDAO][selectRefundList] [searchSite] : " + searchSite);
//		System.out.println("[ReservationDAO][selectRefundList] [searchUserName] : " + searchUserName);
//		System.out.println("[ReservationDAO][selectRefundList] [mode] : " + mode);
		
		Vector<ReservationVO> reservations = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String WHERE = " WHERE ";
		String ANDGUBUN = "B.";
		if(periodGubun.equals("order")){
			WHERE = WHERE + "reg_date ";
			ANDGUBUN = ANDGUBUN + "reg_date ";
		}else if(periodGubun.equals("period")){
			WHERE = WHERE + "reservation_date ";
			ANDGUBUN = ANDGUBUN + "reservation_date ";
		}else if(periodGubun.equals("cancle")){
			WHERE = WHERE + "refund_reg_date ";
			ANDGUBUN = ANDGUBUN + "refund_reg_date ";
		}else if(periodGubun.equals("refund")){
			WHERE = WHERE + "refund_date ";
			ANDGUBUN = ANDGUBUN + "refund_date ";
		}
		
		String ANDSITE = "";
		if(searchSite != null){
			if(searchSite.length() > 0){
				ANDSITE = " AND site_name LIKE '%" + searchSite + "%' ";
			}
		}
		
		String ANDUSER = "";
		if(searchUserName != null){
			if(searchUserName.length() > 0){
				ANDUSER = " AND reserver LIKE '%" + searchUserName + "%' ";
			}
		}
		
		String ANDMODE = "";
		if(mode != null){
			if(mode.length() > 0){
				ANDMODE = " AND pay_status IN ("+mode+") ";
			}
		}
		
		String SQL = "";
		
		if(periodGubun.equals("order")){
			SQL = "SELECT RM.zone_name, RM.product_name, F.refund_day_before, F.refund_type, F.refund_amount, TO_DAYS(R.reservation_date)-TO_DAYS(R.refund_reg_date) AS refund_day, " +
					 "CASE refund_type " +
					 " WHEN 'P' THEN CEIL(R.price*F.refund_amount*0.01) " +
					 " WHEN 'W' THEN R.price-F.refund_amount " +
					 " END AS calc_price, R.* FROM reservation R " +
		             "LEFT OUTER JOIN (select zone_name, product_no, product_name, site_no, site_name FROM product s, zone_information z WHERE z.zone_no = s.zone_no) RM " +
				     "ON R.product_no=RM.product_no, " +
		             "(SELECT B.reservation_no, MAX(A.refund_day_before) AS refund_day_before, A.refund_type, A.refund_amount FROM refund A, reservation B " + 
				     "WHERE A.refund_day_before <= (TO_DAYS(B.reservation_date)-TO_DAYS(B.refund_reg_date)) " +
				     "AND "+ ANDGUBUN + " BETWEEN DATE_FORMAT(?,'%Y-%m-%d %H:%i:%s') AND DATE_FORMAT(?,'%Y-%m-%d %H:%i:%s') GROUP BY B.reservation_no) F " + 
				     WHERE + " BETWEEN DATE_FORMAT(?,'%Y-%m-%d %H:%i:%s') AND DATE_FORMAT(?,'%Y-%m-%d %H:%i:%s') AND F.reservation_no = R.reservation_no " +
				     ANDSITE + ANDUSER + ANDMODE +
				     "ORDER BY reservation_date DESC";
		}else{
			SQL = "SELECT RM.zone_name, RM.product_name, F.refund_day_before, F.refund_type, F.refund_amount, TO_DAYS(R.reservation_date)-TO_DAYS(R.refund_reg_date) AS refund_day, " +
					 "CASE refund_type " +
					 " WHEN 'P' THEN CEIL(R.price*F.refund_amount*0.01) " +
					 " WHEN 'W' THEN R.price-F.refund_amount " +
					 " END AS calc_price, R.* FROM reservation R " +
		             "LEFT OUTER JOIN (select zone_name, product_no, product_name, site_no, site_name FROM product s, zone_information z WHERE z.zone_no = s.zone_no) RM " +
				     "ON R.product_no=RM.product_no, " +
		             "(SELECT B.reservation_no, MAX(A.refund_day_before) AS refund_day_before, A.refund_type, A.refund_amount FROM refund A, reservation B " + 
				     "WHERE A.refund_day_before <= (TO_DAYS(B.reservation_date)-TO_DAYS(B.refund_reg_date)) " +
				     "AND "+ ANDGUBUN + " BETWEEN DATE_FORMAT(?,'%Y-%m-%d') AND DATE_FORMAT(?,'%Y-%m-%d') GROUP BY B.reservation_no) F " + 
				     WHERE + " BETWEEN DATE_FORMAT(?,'%Y-%m-%d') AND DATE_FORMAT(?,'%Y-%m-%d') AND F.reservation_no = R.reservation_no " +
				     ANDSITE + ANDUSER + ANDMODE +
				     "ORDER BY reservation_date DESC";
		}
//			System.out.println("[ReservationDAO][selectRefundList] SQL = " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			if(periodGubun.equals("order")){
				pstmt.setString(1, startDate+" 00:00:00");
				pstmt.setString(2, endDate+" 23:59:59");
				pstmt.setString(3, startDate+" 00:00:00");
				pstmt.setString(4, endDate+" 23:59:59");
			}else{
				pstmt.setString(1, startDate);
				pstmt.setString(2, endDate);
				pstmt.setString(3, startDate);
				pstmt.setString(4, endDate);
			}
			
			rs = pstmt.executeQuery();

			
			if( rs.next() ){
				reservations = new Vector<ReservationVO>();
				do{
					ReservationVO reservation = new ReservationVO();
					reservation.setReservationNo(rs.getInt("reservation_no"));
					reservation.setReservationDate(rs.getDate("reservation_date"));
					reservation.setZoneName(rs.getString("zone_name"));
					reservation.setProductName(rs.getString("product_name"));
					reservation.setReserver(rs.getString("reserver"));
					reservation.setUsers(rs.getInt("users"));
					reservation.setNights(rs.getInt("nights"));
					reservation.setPrice(rs.getInt("price"));
					reservation.setRegDate(rs.getDate("reg_date"));
					reservation.setPhone1(rs.getString("phone1"));
					reservation.setPhone2(rs.getString("phone2"));
					reservation.setPhone3(rs.getString("phone3"));
					reservation.setCell1(rs.getString("cell1"));
					reservation.setCell2(rs.getString("cell2"));
					reservation.setCell3(rs.getString("cell3"));
					reservation.setEmail(rs.getString("email"));
					reservation.setMemo(rs.getString("memo"));
					reservation.setPayStatus(rs.getString("pay_status"));
					reservation.setRefundBank(rs.getString("refund_bank"));
					reservation.setRefundDepositor(rs.getString("refund_depositor"));
					reservation.setRefundAccount(rs.getString("refund_account"));
					reservation.setRefundRegDate(rs.getDate("refund_reg_date"));
					reservation.setRefundDate(rs.getDate("refund_date"));
					reservation.setRefundPrice(rs.getInt("refund_price"));
					reservation.setRefundDay(rs.getInt("refund_day"));
					reservation.setRefundDayBefore(rs.getInt("refund_day_before"));
					reservation.setRefundType(rs.getString("refund_type"));
					reservation.setRefundMemo(rs.getString("refund_memo"));
					reservation.setCalcPrice(rs.getInt("calc_price"));
					reservation.setRefundAmount(rs.getInt("refund_amount"));
					reservations.add(reservation);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return reservations;
	}
		
	public String updateReservationRefund(String status, String reservationNo, String refundPrice, String refundMemo){
		String currentDateTime = CommonUtil.callDateTime();
		
		String msg = "환불 처리 되었습니다.";
		String dayStatus = "R";
		String SET = ",refund_price='"+refundPrice+"',refund_memo='"+refundMemo+"', refund_date=now() ";
		int msgNo = 5;
		String dvsn = "user";
		if(status.equals("Y")){
			dayStatus = "C";
			msg = "환불취소 처리 되었습니다.";
			SET = "";
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "UPDATE reservation SET pay_status = ? "+SET+" WHERE reservation_no = ?";
		
		String SQL1 = "UPDATE reservation_day SET pay_status = ? WHERE reservation_no = ?";
		
		String ResSQL = "SELECT p.product_name, date_format(r.reservation_date,'%Y-%m-%d') as reservation_date, r.phone1, r.phone2, r.phone3 FROM reservation r, product p WHERE r.product_no=p.product_no and r.reservation_no=?";
		
		String MsgSQL = "SELECT msg FROM sms_manager WHERE msg_no=? and dvsn=? ";
		
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, status);
			pstmt.setString(2, reservationNo);
			
			int result = pstmt.executeUpdate();
			System.out.println(currentDateTime + " [admin.reservationDAO.updateReservationRefund] SQL - reservation_no : " + reservationNo + " update count="+result);
			
			int rtn=0;
			if(result == 1){
				pstmt = conn.prepareStatement(SQL1);
				pstmt.setString(1, dayStatus);
				pstmt.setString(2, reservationNo);
				rtn = pstmt.executeUpdate();
				
				if(status.equals("Y")){
					
				}else{
					String phoneNumber = "";
					String resDate = "";
					String productName = "";
					String smsMsg = "";
					pstmt = conn.prepareStatement(ResSQL);
					pstmt.setString(1, reservationNo);
					rs = pstmt.executeQuery();
					if(rs.next()){
						productName = rs.getString("product_name");
						resDate = rs.getDate("reservation_date").toString();
						phoneNumber = rs.getString("phone1")+rs.getString("phone2")+rs.getString("phone3");
					}
					
					if(phoneNumber.length() > 9){
						pstmt = conn.prepareStatement(MsgSQL);
						pstmt.setInt(1, msgNo);
						pstmt.setString(2, dvsn);
						rs = pstmt.executeQuery();
						if( rs.next() ){
							smsMsg = rs.getString(1);
							smsMsg = smsMsg.replace("[DATE]", resDate);
							smsMsg = smsMsg.replace("[SITENAME]", productName);
						}
						util.CallSMS.callSMS(Integer.parseInt(reservationNo), msgNo, phoneNumber, smsMsg);
					}
				}
				
			}
			System.out.println(currentDateTime + " [admin.reservationDAO.updateReservationRefund] SQL1 - reservation_day update check : pay_status="+dayStatus+" , update count=" + rtn);
			if(result == 0){
				msg = "처리중 오류가 발생했습니다.";
			}
		}catch(Exception e){
			msg = "처리중 오류가 발생했습니다. \n 관리자에게 문의하세요!";
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return msg;
	}
	
	public String updateReservationCancleAll(){
		String currentDateTime = CommonUtil.callDateTime();
		
		int updateCnt = 0;
		int reservationNo = 0;
		String smsOrgMsg = "";
		int msgNo = 4;
		String msg = "";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String ResSQL = "SELECT r.reservation_no, p.product_name, date_format(r.reservation_date,'%Y-%m-%d') as reservation_date, r.phone1, r.phone2, r.phone3, date_format(r.reg_date,'%Y-%m-%d %T') as reg_date FROM reservation r, product p WHERE r.product_no=p.product_no AND pay_status = 'N' AND reg_date < date_Sub(now(), interval 1 day)";
		
		String SQL = "UPDATE reservation SET pay_status = 'R' WHERE reservation_no = ?";
		
		String SQL1 = "UPDATE reservation_day SET pay_status = 'R' WHERE reservation_no = ?";
		
		String MsgSQL = "SELECT msg FROM sms_manager WHERE msg_no=? and dvsn='user' ";
		
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(MsgSQL);
			pstmt.setInt(1, msgNo);
			
			rs = pstmt.executeQuery();
			
			if( rs.next() ){
				smsOrgMsg = rs.getString(1);
				
				System.out.println(currentDateTime + " [admin.reservationDAO.updateReservationCancleAll] smsOrgMsg = " +smsOrgMsg);
			}
			
			rs = null;
			pstmt = conn.prepareStatement(ResSQL);
			
			rs = pstmt.executeQuery();
			
			if(rs != null){
				String phoneNumber = "";
				String resDate = "";
				String regDate = "";
				String productName = "";
				String smsMsg = "";
				int rtn=0;
				
				while(rs.next()){
					updateCnt++;
					reservationNo = rs.getInt("reservation_no");
					productName = rs.getString("product_name");
					resDate = rs.getDate("reservation_date").toString();
					regDate = rs.getDate("reg_date").toString();
					phoneNumber = rs.getString("phone1")+rs.getString("phone2")+rs.getString("phone3");
					
					System.out.println(currentDateTime + " [admin.reservationDAO.updateReservationCancleAll] Start {reservationNo} = " +reservationNo+ ", {reg_date} = " + regDate);
					rtn=0;
					
					pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, reservationNo);
					rtn = pstmt.executeUpdate();
					
					System.out.println(currentDateTime + " [admin.reservationDAO.updateReservationCancleAll] {update Count} = " +rtn);
					
					if(rtn > 0){
						pstmt = conn.prepareStatement(SQL1);
						pstmt.setInt(1, reservationNo);
						rtn = pstmt.executeUpdate();
						
						if(phoneNumber.length() > 9){
							smsMsg = smsOrgMsg;
							smsMsg = smsMsg.replace("[DATE]", resDate);
							smsMsg = smsMsg.replace("[SITENAME]", productName);
							
							util.CallSMS.callSMS(reservationNo, msgNo, phoneNumber, smsMsg);
						}
					}
					System.out.println(currentDateTime + " [admin.reservationDAO.updateReservationCancleAll] End {update Count} = " +rtn);
					
				}
			}
			System.out.println(currentDateTime + " [admin.reservationDAO.updateReservationCancleAll] total count  = " +updateCnt);
			if(updateCnt == 0){
				msg = "대상 건수가 없습니다.";
			}else{
				msg = updateCnt + "건의 예약이 취소되었습니다.";
			}
		}catch(Exception e){
			msg = "처리중 오류가 발생했습니다. \n 관리자에게 문의하세요!";
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return msg;
	}
	
	public int insertGroupReservation(HttpServletRequest request) throws ServletException,IOException{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		request.setCharacterEncoding("UTF-8");
		int rtn = 0;
		
		String zoneName = "";
				
		int night = Integer.parseInt((String)request.getParameter("nights"));
		String chooseDate = request.getParameter("chooseDate").toString();
		chooseDate = chooseDate.replaceAll("-", "");
		Calendar cal = Calendar.getInstance();
		cal.set(Integer.parseInt(chooseDate.substring(0,4)),Integer.parseInt(chooseDate.substring(4,6))-1,Integer.parseInt(chooseDate.substring(6,8)));
		cal.add(Calendar.DATE,night-1);
		
		String productNos = (String)request.getParameter("productNos");
		String[] sProductNos = productNos.split(","); 
		
		int productNo = 0;
		String productName = "";
		String oProductName = "";
		int siteNo = 0;
		String startDate = chooseDate;
		String endDate = cal.get(Calendar.YEAR)+"";
		String mm = ((cal.get(Calendar.MONTH)+1) < 10) ? "0"+(cal.get(Calendar.MONTH)+1) : (cal.get(Calendar.MONTH)+1)+"";
		String dd = (cal.get(Calendar.DATE) < 10) ? "0"+cal.get(Calendar.DATE) : cal.get(Calendar.DATE)+"";
		endDate = endDate + mm + dd;
		
		int memberNo = 0;
		
		String resDate = chooseDate;
		int toddler = 0;
		int child = 0;
		int users = Integer.parseInt((String)request.getParameter("users"));
		int price = Integer.parseInt((String)request.getParameter("price"));
		String payment = "V";
		String bankName = "",account = "",payYn = "N",depositor="";
		
		String reserver = (String) request.getParameter("reserver");
		String phone1 = (String) request.getParameter("phone1");
		String phone2 = (String) request.getParameter("phone2");
		String phone3 = (String) request.getParameter("phone3");
		String tel1 = (String) request.getParameter("cell1");
		String tel2 = (String) request.getParameter("cell2");
		String tel3 = (String) request.getParameter("cell3");
		String email = (String) request.getParameter("email");
		String content = (String) request.getParameter("content");
		
		int reservationNo = 0;

		String SQL = "select * from deposit";
		
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if( rs.next() ){
				bankName = rs.getString("bank_name");
				account = rs.getString("account");
				depositor = rs.getString("depositor");
			}
			
			String SQL1 = "SELECT p.product_name, p.zone_no, p.site_no, p.site_name, z.zone_name FROM product p, zone_information z WHERE p.zone_no = z.zone_no and product_no = ?";
			String SQL2 = "SELECT count(*) FROM reservation_day WHERE site_no=? AND reservation_day BETWEEN ? AND ? AND pay_status <> 'R'";
			String SQL3 = "INSERT INTO reservation (product_no,site_no,member_no,reservation_date,nights,toddler,child,users,price,payment,bank_name,account,pay_status,reserver,phone1,phone2,phone3,cell1,cell2,cell3,email,memo,reg_date)" +
					" VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,NOW())";
			String SQL4 = "SELECT max(reservation_no) FROM reservation WHERE site_no=? and reservation_date=? and DATE_FORMAT(reg_date,'%Y%m%d')=DATE_FORMAT(NOW(),'%Y%m%d')";
			String SQL5 = "INSERT INTO reservation_day (reservation_month,reservation_day,zone_name,site_no,reservation_no,pay_status,reg_date)" +
					" VALUES(?,?,?,?,?,?,NOW())";
			int pSize = sProductNos.length;
//			System.out.println("pSize : " + pSize);
			for(int x=1; x<pSize; x++){
				productNo = Integer.parseInt(sProductNos[x]);
				pstmt = conn.prepareStatement(SQL1);
				pstmt.setInt(1, productNo);
				rs = pstmt.executeQuery();
				
				if( rs.next() ){
					productName = rs.getString("product_name");
					siteNo = rs.getInt("site_no");
					zoneName = rs.getString("zone_name");
					if(x==1){
						oProductName = productName;
					}
				}else{
					productName = "";
					siteNo = 0;
				}
				
				pstmt = conn.prepareStatement(SQL2);
				pstmt.setInt(1, siteNo);
				pstmt.setString(2, startDate);
				pstmt.setString(3, endDate);
				rs = pstmt.executeQuery();

//				System.out.println("setReservation - count : "+ rs.getInt(1));
				
				if( rs.next() ){
					if( rs.getInt(1) == 0 ){
						pstmt = conn.prepareStatement(SQL3);
						pstmt.setInt(1, productNo);
						pstmt.setInt(2, siteNo);
						pstmt.setInt(3, memberNo);
						pstmt.setString(4, resDate);
						pstmt.setInt(5, night);
						pstmt.setInt(6, toddler);
						pstmt.setInt(7, child);
						pstmt.setInt(8, users);
						pstmt.setInt(9, price);
						pstmt.setString(10, payment);
						pstmt.setString(11, bankName);
						pstmt.setString(12, account);
						pstmt.setString(13, payYn);
						pstmt.setString(14, reserver);
						pstmt.setString(15, phone1);
						pstmt.setString(16, phone2);
						pstmt.setString(17, phone3);
						pstmt.setString(18, tel1);
						pstmt.setString(19, tel2);
						pstmt.setString(20, tel3);
						pstmt.setString(21, email);
						pstmt.setString(22, content);
						rtn = pstmt.executeUpdate();
						request.setAttribute("insertResult", rtn);
//						System.out.println("setReservation - insertResult : "+rtn);
						
						if(rtn > 0){
							users = 0;
							price = 0;
							content = "그룹예약건<br>("+oProductName+" 과 동일건 입니다.)";
						}
						pstmt = conn.prepareStatement(SQL4);
						pstmt.setInt(1, siteNo);
						pstmt.setString(2, resDate);
						rs = pstmt.executeQuery();
						if( rs.next() ){
//							System.out.println("setReservation - reservationNo : "+ rs.getInt(1));
							reservationNo = rs.getInt(1);
						}
						
						int loop = night;
						if(loop == 0){
							loop = loop + 1;
						}
						for(int i=0; i<loop; i++){
							pstmt = conn.prepareStatement(SQL5);
							if(i==0){
								pstmt.setString(1, chooseDate.substring(0,6));
								pstmt.setString(2, chooseDate);
							}else{
								cal.set(Integer.parseInt(chooseDate.substring(0,4)),Integer.parseInt(chooseDate.substring(4,6))-1,Integer.parseInt(chooseDate.substring(6,8)));
								cal.add(Calendar.DATE,i);
								endDate = cal.get(Calendar.YEAR)+"";
								mm = ((cal.get(Calendar.MONTH)+1) < 10) ? "0"+(cal.get(Calendar.MONTH)+1) : (cal.get(Calendar.MONTH)+1)+"";
								dd = (cal.get(Calendar.DATE) < 10) ? "0"+cal.get(Calendar.DATE) : cal.get(Calendar.DATE)+"";
								endDate = endDate + mm + dd;
								pstmt.setString(1, endDate.substring(0,6));
								pstmt.setString(2, endDate);
							}
							pstmt.setString(3, zoneName);
							pstmt.setInt(4, siteNo);
							pstmt.setInt(5, reservationNo);
							pstmt.setString(6, "W");
							pstmt.executeUpdate();
						}
					}else{
						System.out.println("setReservation : rs count is not zero!");
				}
			}else{
				System.out.println("setReservation : rs is null!");
			}
		} //end for
				
//			System.out.println("[reservationDAO][insertGroupReservation] rtn = " + rtn);
		} catch(Exception ex) {
	        ex.printStackTrace();
	    } finally {
	    	close(rs,pstmt,conn);
	    }
		
		return rtn;
	}

}
