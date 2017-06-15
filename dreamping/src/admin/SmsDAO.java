package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import util.ConnectionUtil;

public class SmsDAO {

	// DB연결객체 Close
	private void close(ResultSet rs,PreparedStatement pstmt,Connection conn){
		if(rs != null) try{ rs.close(); }catch(SQLException e){}finally{ rs = null; }
		if(pstmt != null) try{ pstmt.close(); }catch(SQLException e){}finally{ pstmt = null; }
		if(conn != null) try{ conn.close(); }catch(SQLException e){}finally{ conn = null; }
	}
	
	private static SmsDAO instance = new SmsDAO();
	
	public SmsDAO(){}
	
	// 객체 리턴
	public static SmsDAO getInstance(){
		return instance;
	}
	
	public String[] getSMSList(String dvsn){
		String[] smsList = new String[6];
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "select * from sms_manager where dvsn=? order by msg_no";
		
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, dvsn);
			rs = pstmt.executeQuery();
			
			int i = 0;
			if( rs.next() ){
				do{
					smsList[i] = rs.getString("msg");
					i++;
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}

		return smsList;
	}
	
	public String updateSMSMassage(HttpServletRequest request){
		String rtnMsg = "";
		int rtn = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "UPDATE sms_manager SET msg = ? WHERE msg_no = ? AND dvsn = ?";
		
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			
			int msgNo = 0;
			String msg = "";
			String dvsn = "user";
			String[] message_customer = request.getParameterValues("message_customer[]");
			for(int i=0; i<message_customer.length; i++){
				msgNo = i+1;
				msg = message_customer[i]; 
				pstmt.setString(1, msg);
				pstmt.setInt(2, msgNo);
				pstmt.setString(3, dvsn);

				rtn = pstmt.executeUpdate();
			}
			dvsn = "admin";
			String[] message_admin = request.getParameterValues("message_admin[]");
			for(int i=0; i<message_admin.length; i++){
				msgNo = i+1;
				msg = message_admin[i]; 
				pstmt.setString(1, msg);
				pstmt.setInt(2, msgNo);
				pstmt.setString(3, dvsn);

				rtn = pstmt.executeUpdate();
			}
			
			if(rtn == 0){
				rtnMsg = "처리중 오류가 발생했습니다. 관리자에게 문의해 주세요!";
			}else{
				rtnMsg = "수정되었습니다.";
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return rtnMsg;
	}
	
	public List<Map<String,String>> getSMSUser(){
		List smsUser = new ArrayList<Map<String,String>>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "select * from sms_phone order by name";
		
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if( rs.next() ){
				do{
					Map<String, String> user = new HashMap<String, String>();
					user.put("name", rs.getString("name"));
					user.put("phoneNumber", rs.getString("phone_number"));
					user.put("dvsn", rs.getString("dvsn"));
					user.put("desc", rs.getString("description"));
					smsUser.add(user);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}

		return smsUser;
	}
	
	public String processSmsUser(HttpServletRequest request){
		String msg = "";
		int rtn = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "";
		String cmd = request.getParameter("cmd");
//		System.out.println("[SmsDAO][processSmsUser] cmd = " + cmd);
		
		try{
			conn = ConnectionUtil.getConnection();
			if(cmd.equals("insert")){
				String name = request.getParameter("name");
				String phoneNumber = request.getParameter("phoneNumber");
				String dvsn = request.getParameter("dvsn");
				String desc = request.getParameter("desc");
				
				SQL = "INSERT INTO sms_phone(phone_number, name, dvsn, description) VALUES (?,?,?,?) ";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, phoneNumber);
				pstmt.setString(2, name);
				pstmt.setString(3, dvsn);
				pstmt.setString(4, desc);
				
				msg = "저장되었습니다.";
			
			}else if(cmd.equals("delete")){
				String phoneNumber = request.getParameter("phoneNumber");
				
				SQL = "DELETE FROM sms_phone WHERE phone_number=?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, phoneNumber);
				
				msg = "삭제되었습니다.";
			}
			rtn = pstmt.executeUpdate();
			if(rtn == 0){
				msg = "처리중 오류가 발생했습니다. 관리자에게 문의해 주세요!";
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return msg;
	}
	
	public List<Map<String,Object>> selectSmsLog(String startDate, String endDate){
		List smsLogs = new ArrayList<Map<String,Object>>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "select * from sms_log where reg_date between DATE_FORMAT(?,'%Y-%m-%d') and DATE_FORMAT(?,'%Y-%m-%d')"
				+ " order by reg_date";

		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, startDate);
			pstmt.setString(2, endDate);
			rs = pstmt.executeQuery();
			
			if( rs.next() ){
				do{
					Map<String, Object> smsLog = new HashMap<String, Object>();
					smsLog.put("smsDay", rs.getDate("reg_date"));
					smsLog.put("msg", rs.getString("msg"));
					smsLog.put("phoneNumber", rs.getString("phone_number"));
					smsLog.put("rtnMessage", rs.getString("return_msg"));
					smsLogs.add(smsLog);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}

		return smsLogs;
	}

}
