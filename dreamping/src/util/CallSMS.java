package util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * SMS연동 페이지 주소
 * http://www.sendgo.co.kr/
 * @id urban
 * @pass slowcity
 *
 */
public class CallSMS {
	
	private CallSMS(){}
	
	static{}
	
	public static  void callSMS(int reservationNo, int msgNo, String phoneNumber, String msg){
//		System.out.println("callSMS");
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			String orgMsg = msg;
			msg = URLEncoder.encode(msg,"UTF-8");
			String uri = "http://www.sendgo.co.kr/Remote/RemoteSms.html?remote_id=urban&remote_pass=slowcity"
					+"&remote_returnurl=www.urbanslowcity.com/admin/returnSMS.jsp"
					+"&remote_num=1"
					+"&remote_reserve=0"
					+"&remote_phone="+phoneNumber
					+"&remote_callback=18999349"
					+"&remote_msg="+msg
					+"&remote_etc1="+reservationNo
					+"&remote_etc2="+msgNo;
			
			URL url = new URL(uri);
			HttpURLConnection http = (HttpURLConnection) url.openConnection();
			http.setRequestMethod("POST");
			http.setDoOutput(true);
			
			StringBuffer param = new StringBuffer();
			param.append("");
			
			//System.out.println(param.toString());
			//POST전송
			PrintWriter pout = new PrintWriter(http.getOutputStream());
			pout.print(param.toString());
			pout.close();
			
			BufferedReader respRd = new BufferedReader(new InputStreamReader(http.getInputStream()));
			String returnStr = "";
			String tempStr = "";
			while(true){
				tempStr = respRd.readLine();
				if(tempStr == null){
					break;
				}
				returnStr += tempStr;
			}
			respRd.close();
			//System.out.println(returnStr);
			//<html><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8' /></head><body><form name='ReturnForm' method='post' action='http://www.urbanslowcity.com/admin/returnSMS.jsp'><input type='hidden' name='code' value='0000'><input type='hidden' name='msg' value='전송 성공'><input type='hidden' name='etc1' value='1345'><input type='hidden' name='etc2' value=''><input type='hidden' name='etc3' value=''><input type='hidden' name='etc4' value=''><input type='hidden' name='etc5' value=''><input type='hidden' name='etc6' value=''><input type='hidden' name='gcode' value='14346016550.18332600_0'><input type='hidden' name='nums' value='1'><input type='hidden' name='cols' value='3'></form><script language='Javascript'>document.ReturnForm.submit();</script></body></html>
			Document doc = Jsoup.parse(returnStr);
			Elements rows = doc.select("input");
		    
			String name = "";
			String value = "";
			String returnCode = "";
			String returnMsg = "";
			for(Element e : rows){
		    	name = e.attr("name");
		    	value = e.attr("value");
		    	if(name.equals("code")){
		    		returnCode = value;
		    	}else if(name.equals("msg")){
		    		returnMsg = value;
		    	}else if(name.equals("etc1")){
		    		reservationNo = Integer.parseInt(value);
		    	}else if(name.equals("etc2")){
		    		msgNo = Integer.parseInt(value);
		    	}
			}
			
			String SQL = "INSERT INTO sms_log (reservation_no, msg_no, phone_number, msg, return_code, return_msg, reg_date) "
					+ "VALUES ("+reservationNo+","+msgNo+",'"+phoneNumber+"','"+orgMsg+"','"+returnCode+"','"+returnMsg+"',NOW())";
			
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			int result = pstmt.executeUpdate();
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}finally{
			if(pstmt != null) try{ pstmt.close(); }catch(SQLException e){}finally{ pstmt = null; }
			if(conn != null) try{ conn.close(); }catch(SQLException e){}finally{ conn = null; }
		}
	}
	
	public static  void callLMS(int reservationNo, int msgNo, String phoneNumber, String subject, String msg){
//		System.out.println("callLMS");
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			String orgMsg = msg;
			subject = URLEncoder.encode(subject,"UTF-8");
			msg = URLEncoder.encode(msg,"UTF-8");
			String uri = "http://www.sendgo.co.kr/Remote/RemoteMms.html?remote_id=urban&remote_pass=slowcity"
					+"&remote_returnurl=www.urbanslowcity.com/admin/returnSMS.jsp"
					+"&remote_num=1"
					+"&remote_reserve=0"
					+"&remote_phone="+phoneNumber
					+"&remote_subject="+subject
					+"&remote_callback=18999349"
					+"&remote_msg="+msg
					+"&remote_etc1="+reservationNo
					+"&remote_etc2="+msgNo;
			
			URL url = new URL(uri);
			HttpURLConnection http = (HttpURLConnection) url.openConnection();
			http.setRequestMethod("POST");
			http.setDoOutput(true);
			
			StringBuffer param = new StringBuffer();
			param.append("");
			
			//System.out.println(param.toString());
			//POST전송
			PrintWriter pout = new PrintWriter(http.getOutputStream());
			pout.print(param.toString());
			pout.close();
			
			BufferedReader respRd = new BufferedReader(new InputStreamReader(http.getInputStream()));
			String returnStr = "";
			String tempStr = "";
			while(true){
				tempStr = respRd.readLine();
				if(tempStr == null){
					break;
				}
				returnStr += tempStr;
			}
			respRd.close();
			//System.out.println(returnStr);
			//<html><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8' /></head><body><form name='ReturnForm' method='post' action='http://www.urbanslowcity.com/admin/returnSMS.jsp'><input type='hidden' name='code' value='0000'><input type='hidden' name='msg' value='전송 성공'><input type='hidden' name='etc1' value='1345'><input type='hidden' name='etc2' value=''><input type='hidden' name='etc3' value=''><input type='hidden' name='etc4' value=''><input type='hidden' name='etc5' value=''><input type='hidden' name='etc6' value=''><input type='hidden' name='gcode' value='14346016550.18332600_0'><input type='hidden' name='nums' value='1'><input type='hidden' name='cols' value='3'></form><script language='Javascript'>document.ReturnForm.submit();</script></body></html>
			Document doc = Jsoup.parse(returnStr);
			Elements rows = doc.select("input");
		    
			String name = "";
			String value = "";
			String returnCode = "";
			String returnMsg = "";
			for(Element e : rows){
		    	name = e.attr("name");
		    	value = e.attr("value");
		    	if(name.equals("code")){
		    		returnCode = value;
		    	}else if(name.equals("msg")){
		    		returnMsg = value;
		    	}else if(name.equals("etc1")){
		    		reservationNo = Integer.parseInt(value);
		    	}else if(name.equals("etc2")){
		    		msgNo = Integer.parseInt(value);
		    	}
			}
			
			String SQL = "INSERT INTO sms_log (reservation_no, msg_no, phone_number, msg, return_code, return_msg, reg_date) "
					+ "VALUES ("+reservationNo+","+msgNo+",'"+phoneNumber+"','"+orgMsg+"','"+returnCode+"','"+returnMsg+"',NOW())";
			
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			int result = pstmt.executeUpdate();
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}finally{
			if(pstmt != null) try{ pstmt.close(); }catch(SQLException e){}finally{ pstmt = null; }
			if(conn != null) try{ conn.close(); }catch(SQLException e){}finally{ conn = null; }
		}
	}
}
