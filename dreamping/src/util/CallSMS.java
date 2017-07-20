package util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.Socket;
import java.net.URL;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Random;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * SMS연동 페이지 주소
 * cafe24
 * id : mlksms
 * pw : qpwo1012!
 * @id urban
 * @pass slowcity
 *
 */
public class CallSMS {
	
	private CallSMS(){}
	
	static{}
	
	/**
	 * CAFE24 SMS Hosting 
	 */
	/**
     * nullcheck
     * @param str, Defaultvalue
     * @return
     */

     public static String nullcheck(String str,  String Defaultvalue ) throws Exception
     {
          String ReturnDefault = "" ;
          if (str == null)
          {
              ReturnDefault =  Defaultvalue ;
          }
          else if (str == "" )
         {
              ReturnDefault =  Defaultvalue ;
          }
          else
          {
                      ReturnDefault = str ;
          }
           return ReturnDefault ;
     }
     
     /**
     * BASE64 Encoder
     * @param str
     * @return
     */
    public static String base64Encode(String str)  throws java.io.IOException {
        sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
        byte[] strByte = str.getBytes();
        String result = encoder.encode(strByte);
        return result ;
    }
    
    /**
     * BASE64 Decoder
     * @param str
     * @return
     */
    public static String base64Decode(String str)  throws java.io.IOException {
        sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();
        byte[] strByte = decoder.decodeBuffer(str);
        String result = new String(strByte);
        return result ;
    }
    
	/**
	 * CAFE24 SMS sender
	 * @param reservationNo
	 * @param msgNo
	 * @param phoneNumber
	 * @param msg
	 */
	public static  void callSMS(int reservationNo, int msgNo, String phoneNumber, String msg){
		String smsType = "S";
		String subject = "";
		
		callCafe24SmsSender(reservationNo, msgNo, smsType, phoneNumber, subject, msg);
	}
	
	/**
	 * CAFE24 LMS sender
	 * @param reservationNo
	 * @param msgNo
	 * @param phoneNumber
	 * @param subject
	 * @param msg
	 */
	public static  void callLMS(int reservationNo, int msgNo, String phoneNumber, String subject, String msg){
		String smsType = "L";
		
		callCafe24SmsSender(reservationNo, msgNo, smsType, phoneNumber, subject, msg);
	}
	
	public static  void callCafe24SmsSender(int reservationNo, int msgNo, String type, String phoneNumber, String subject, String msg){
		Connection conn = null;
		PreparedStatement pstmt = null;
       
		try {
			String charsetType = "UTF-8";
			String sms_url = "https://sslsms.cafe24.com/sms_sender.php"; // SMS 전송요청 URL
	        String user_id = base64Encode("mlksms");
	        String secure = base64Encode("");//인증키
	        msg = base64Encode(msg);
	        String rphone = base64Encode(phoneNumber); //예) 받는 번호 011-011-111 , '-' 포함해서 입력.
	        String sphone1 = base64Encode("031");
	        String sphone2 = base64Encode("");
	        String sphone3 = base64Encode("");
	        String rdate = base64Encode(""); //예약 날짜 예)20090909
	        String rtime = base64Encode(""); //예약 시간 예)173000 ,오후 5시 30분,예약시간은 최소 10분 이상으로 설정.
	        String mode = base64Encode("1");
	        //String subject = "";
	        if(nullcheck(type, "").equals("L")) {  //발송타입 "S">단문(SMS) "L">장문(LMS)
	            subject = base64Encode(nullcheck(subject, ""));
	        }
	        String testflag = base64Encode(""); // 예) 테스트시: Y
	        String destination = base64Encode("");  
	        String repeatFlag = base64Encode(""); //repeatFlag : Y
	        String repeatNum = base64Encode(""); //반복횟수 예) 1~10회 가능.
	        String repeatTime = base64Encode(""); //전송간격 예)15분 이상부터 가능.
	        String returnurl = "";
	        String nointeractive = ""; //예) 사용할 경우 : 1, 성공시 대화상자(alert)를 생략.
	        String smsType = base64Encode(type);  //발송타입 "S">단문(SMS) "L">장문(LMS)
	
	        String[] host_info = sms_url.split("/");
	        String host = host_info[2];
	        String path = "/" + host_info[3];
	        int port = 80;
	
	        // 데이터 맵핑 변수 정의
	        String arrKey[]
	            = new String[] {"user_id","secure","msg", "rphone","sphone1","sphone2","sphone3","rdate","rtime"
	                        ,"mode","testflag","destination","repeatFlag","repeatNum", "repeatTime", "smsType", "subject"};
	        String valKey[]= new String[arrKey.length] ;
	        valKey[0] = user_id;
	        valKey[1] = secure;
	        valKey[2] = msg;
	        valKey[3] = rphone;
	        valKey[4] = sphone1;
	        valKey[5] = sphone2;
	        valKey[6] = sphone3;
	        valKey[7] = rdate;
	        valKey[8] = rtime;
	        valKey[9] = mode;
	        valKey[10] = testflag;
	        valKey[11] = destination;
	        valKey[12] = repeatFlag;
	        valKey[13] = repeatNum;
	        valKey[14] = repeatTime;
	        valKey[15] = smsType;
	        valKey[16] = subject;
	
	        String boundary = "";
	        Random rnd = new Random();
	        String rndKey = Integer.toString(rnd.nextInt(32000));
	        MessageDigest md = MessageDigest.getInstance("MD5");
	        byte[] bytData = rndKey.getBytes();
	        md.update(bytData);
	        byte[] digest = md.digest();
	        for(int i =0;i<digest.length;i++)
	        {
	            boundary = boundary + Integer.toHexString(digest[i] & 0xFF);
	        }
	        boundary = "---------------------"+boundary.substring(0,11);
	
	        // 본문 생성
	        String data = "";
	        String index = "";
	        String value = "";
	        for (int i=0;i<arrKey.length; i++)
	        {
	            index =  arrKey[i];
	            value = valKey[i];
	            data +="--"+boundary+"\r\n";
	            data += "Content-Disposition: form-data; name=\""+index+"\"\r\n";
	            data += "\r\n"+value+"\r\n";
	            data +="--"+boundary+"\r\n";
	        }
	
	        //out.println(data);
	
	        InetAddress addr = InetAddress.getByName(host);
	        Socket socket = new Socket(host, port);
	        // 헤더 전송
	        BufferedWriter wr = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), charsetType));
	        wr.write("POST "+path+" HTTP/1.0\r\n");
	        wr.write("Content-Length: "+data.length()+"\r\n");
	        wr.write("Content-type: multipart/form-data, boundary="+boundary+"\r\n");
	        wr.write("\r\n");
	
	        // 데이터 전송
	        wr.write(data);
	        wr.flush();
	
	        // 결과값 얻기
	        BufferedReader rd = new BufferedReader(new InputStreamReader(socket.getInputStream(),charsetType));
	        String line;
	        String alert = "";
	        ArrayList tmpArr = new ArrayList();
	        while ((line = rd.readLine()) != null) {
	            tmpArr.add(line);
	        }
	        wr.close();
	        rd.close();

	        String tmpMsg = (String)tmpArr.get(tmpArr.size()-1);
	        String[] rMsg = tmpMsg.split(",");
	        String Result= rMsg[0]; //발송결과
	        String Count= ""; //잔여건수
	        if(rMsg.length>1) {Count= rMsg[1]; }
	
	        String returnCode = Result;
	                        //발송결과 알림
	        if(Result.equals("success")) {
	            alert = "성공적으로 발송하였습니다.";
	            alert += " 잔여건수는 "+ Count+"건 입니다.";
	            returnCode = "0000";
	        }
	        else if(Result.equals("reserved")) {
	            alert = "성공적으로 예약되었습니다";
	            alert += " 잔여건수는 "+ Count+"건 입니다.";
	            returnCode = "0000";
	        }
	        else if(Result.equals("3205")) {
	            alert = "잘못된 번호형식입니다.";
	        }
	        else {
	            alert = "[Error]"+Result;
	        }
	
	        //out.println(nointeractive);
	
	        if(nointeractive.equals("1") && !(Result.equals("Test Success!")) && !(Result.equals("success")) && !(Result.equals("reserved")) ) {
	            //out.println("<script>alert('" + alert + "')</script>");
	        }
	        else if(!(nointeractive.equals("1"))) {
	            //out.println("<script>alert('" + alert + "')</script>");
	        }
	
	        	
	        //out.println("<script>location.href='"+returnurl+"';</script>");
	        
	        
	        String SQL = "INSERT INTO sms_log (reservation_no, msg_no, phone_number, msg, return_code, return_msg, reg_date) "
					+ "VALUES ("+reservationNo+","+msgNo+",'"+phoneNumber+"','"+msg+"','"+returnCode+"','"+alert+"',NOW())";
			
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			int result = pstmt.executeUpdate();
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			if(pstmt != null) try{ pstmt.close(); }catch(SQLException e){}finally{ pstmt = null; }
			if(conn != null) try{ conn.close(); }catch(SQLException e){}finally{ conn = null; }
		}
	}
	
	
	/**
	 * http://www.sendgo.co.kr/
	 */
	
	/**
	 * SMS GO SMS sender
	 * @param reservationNo
	 * @param msgNo
	 * @param phoneNumber
	 * @param msg
	 */
	public static  void callSMSGO(int reservationNo, int msgNo, String phoneNumber, String msg){
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
	
	
	/**
	 * SMS GO LMS sender
	 * @param reservationNo
	 * @param msgNo
	 * @param phoneNumber
	 * @param subject
	 * @param msg
	 */
	public static  void callLMSGO(int reservationNo, int msgNo, String phoneNumber, String subject, String msg){
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
