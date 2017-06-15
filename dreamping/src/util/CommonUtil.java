package util;

import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

import com.ibm.icu.util.ChineseCalendar;

public class CommonUtil {

	private CommonUtil(){}
	
	static{}
	
	//양력 휴일
//	private static String[] solarArr = new String[]{"0101", "0301", "0505", "0606", "0815", "1003", "1009", "1010", "1225"};
	//음력 휴일
//	private static String[] lunarArr = new String[]{"0101", "0102", "0408", "0814", "0815", "0816"};
	//대체 휴일 (양력)
//	private static String[] subSoArr = new String[]{"0814", "0929", "1226"};
	
	
	//양력 휴일 DB
	@SuppressWarnings("null")
	public static String[] getSolarArr(){
		String[] solarArr = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT mmdd FROM holyday WHERE use_yn='Y' AND dvsn_cd='SOLAR'";
		
		try {
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			rs.last();
			int row = rs.getRow();
			solarArr = new String[row];
			rs.beforeFirst();
			
			int i=0;
			while( rs.next() ){
				solarArr[i] = rs.getString("mmdd");
				i++;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try{ rs.close(); }catch(SQLException e){}finally{ rs = null; }
			if(pstmt != null) try{ pstmt.close(); }catch(SQLException e){}finally{ pstmt = null; }
			if(conn != null) try{ conn.close(); }catch(SQLException e){}finally{ conn = null; }
		}
		
		
		return solarArr;
	}
	
	//음력 휴일 DB
	@SuppressWarnings("null")
	public static String[] getLunarArr(){
		String[] lunarArr = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT mmdd FROM holyday WHERE use_yn='Y' AND dvsn_cd='LUNAR'";
		
		try {
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			rs.last();
			int row = rs.getRow();
			lunarArr = new String[row];
			rs.beforeFirst();
			
			int i=0;
			while( rs.next() ){
				lunarArr[i] = rs.getString("mmdd");
				i++;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try{ rs.close(); }catch(SQLException e){}finally{ rs = null; }
			if(pstmt != null) try{ pstmt.close(); }catch(SQLException e){}finally{ pstmt = null; }
			if(conn != null) try{ conn.close(); }catch(SQLException e){}finally{ conn = null; }
		}
		
		
		return lunarArr;
	}
	
	//대체 휴일 DB
//	public static String[] getSubSoArr(){
//		String[] solarArr = new String[]{};
//		
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		
//		String SQL = "SELECT mmdd FROM holyday WHERE use_yn='Y' AND dvsn_cd='SOLAR' AND description = 'SUB'";
//		
//		try {
//			conn = ConnectionUtil.getConnection();
//			pstmt = conn.prepareStatement(SQL);
//			rs = pstmt.executeQuery();
//			
//			int i=0;
//			while( rs.next() ){
//				solarArr[i] = rs.getString("mmdd");
//				i++;
//			}
//			
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} finally {
//			if(rs != null) try{ rs.close(); }catch(SQLException e){}finally{ rs = null; }
//			if(pstmt != null) try{ pstmt.close(); }catch(SQLException e){}finally{ pstmt = null; }
//			if(conn != null) try{ conn.close(); }catch(SQLException e){}finally{ conn = null; }
//		}
//		
//		
//		return solarArr;
//	}
	
	
	public static String callDate(){
		long time = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd");
		String str = dayTime.format(new Date(time));
		
		return str;
	}
	
	public static String callPlusDate(int plusDay){
		Calendar cal = new GregorianCalendar(Locale.KOREA);
		cal.setTime(new Date());
		cal.add(Calendar.DAY_OF_YEAR, plusDay);
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd");
		String str = dayTime.format(cal.getTime());
		
		return str;
	}
	
	public static String callDateTime(){
		long time = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String str = dayTime.format(new Date(time));
		
		return str;
	}
	
	public static String isAfterDate(String oneDate, String twoDate){
		long time = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd");
		String str = dayTime.format(new Date(time));
		
		Calendar cal1 = Calendar.getInstance();
		Calendar cal2 = Calendar.getInstance();
		Calendar cal3 = Calendar.getInstance();
//		System.out.println("one: "+oneDate.substring(0,4) + "," + oneDate.substring(5,7) + "," + oneDate.substring(8));
//		System.out.println("two: "+twoDate.substring(0,4) + "," + twoDate.substring(5,7) + "," + twoDate.substring(8));
//		System.out.println("thr: "+str.substring(0,4) + "," + str.substring(5,7) + "," + str.substring(8));
		
		cal1.set(Integer.parseInt(oneDate.substring(0,4)),Integer.parseInt(oneDate.substring(5,7))-1,Integer.parseInt(oneDate.substring(8)));
		cal2.set(Integer.parseInt(twoDate.substring(0,4)),Integer.parseInt(twoDate.substring(5,7))-1,Integer.parseInt(twoDate.substring(8)));
		cal3.set(Integer.parseInt(str.substring(0,4)),Integer.parseInt(str.substring(5,7))-1,Integer.parseInt(str.substring(8)));
		
		if(cal1.before(cal2)){
			twoDate = oneDate;
		}
		if(cal1.equals(cal3)){
			twoDate = oneDate;
		}
		return twoDate;
	}
	
	public static String makeMoneyType(String moneyString){ 
        String format = "#,##0"; 
        DecimalFormat df = new DecimalFormat(format); 
        DecimalFormatSymbols dfs = new DecimalFormatSymbols(); 

        dfs.setGroupingSeparator(',');// 구분자를 ,로 
        df.setGroupingSize(3);//3자리 단위마다 구분자처리 한다. 
        df.setDecimalFormatSymbols(dfs); 

        return (df.format(Double.parseDouble(moneyString))).toString(); 
    }
	
	/**
	 * 휴일, 국경일 체크
	 */
	public static boolean holidayCheck(String day){
		boolean result = false;
		
		result = isHolidayLunar(day);
//		System.out.println("[CommonUtil][holidayCheck] isHolidayLunar : " + result);
		if(!result){
			result = isHolidaySolar(day);
//			System.out.println("[CommonUtil][holidayCheck] isHolidaySolar : " + result);
		}
		if(!result){
			result = isSunday(day);
//			System.out.println("[CommonUtil][holidayCheck] isSunday : " + result);
		}
//		if(!result){
//			result = isSubstitutionHolidaySolar(day);
////			System.out.println("[CommonUtil][holidayCheck] isSubstitutionHolidaySolar : " + result);
//		}
//		System.out.println("[CommonUtil][holidayCheck] result : " + result);
		return result;
	}
	
	/**
	 * 다은날이 휴일, 국경일 체크
	 */
	public static boolean holidayCheckAfterDay(String day){
		boolean result = false;
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMdd");
		
		Calendar cal = new GregorianCalendar(Locale.KOREA);
		cal.set(Calendar.YEAR, Integer.parseInt(day.substring(0,4)));
		cal.set(Calendar.MONTH, Integer.parseInt(day.substring(4, 6)) - 1);
		cal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(day.substring(6)));
		cal.add(Calendar.DAY_OF_YEAR, 1);

		day = dayTime.format(cal.getTime());
//		System.out.println("[CommonUtil][holidayCheckAfterDay] day : " + day);
		result = holidayCheck(day);
		
		return result;		
	}
	
	/**
	 * 해당일자가 음력 법정공휴일에 해당하는 지 확인
	 * @param day
	 * @return
	 */
	private static boolean isHolidayLunar(String day){
		boolean result = false;
		
		Calendar cal = new GregorianCalendar(Locale.KOREA);
		cal.set(Calendar.YEAR, Integer.parseInt(day.substring(0,4)));
		cal.set(Calendar.MONTH, Integer.parseInt(day.substring(4, 6)) - 1);
		cal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(day.substring(6)));
		
		ChineseCalendar chinaCal = new ChineseCalendar();
		chinaCal.setTimeInMillis(cal.getTimeInMillis());
		
		/** 음력으로 변환된 월과 일자 **/
		int mm = chinaCal.get(ChineseCalendar.MONTH) + 1;
		int dd = chinaCal.get(ChineseCalendar.DAY_OF_MONTH);
		
		StringBuilder sb = new StringBuilder();
		if (mm < 10){
			sb.append("0");
		}
		sb.append(mm);
		
		if (dd < 10){
			sb.append("0");
		}
		sb.append(dd);
		
		/** 음력 12월의 마지막날 (설날 첫번째 휴일)인지 확인 **/
		if (mm == 12) {
			int lastDate = chinaCal.getActualMaximum(ChineseCalendar.DAY_OF_MONTH);
			if (dd == lastDate) {
				return true;
			}
		}
		
		String[] lunarArr = getLunarArr();
		
		for (String d : lunarArr) {
			if (sb.toString().equals(d)) {
				return true;
			}
		}
		
		return result;
	}
	
	/**
	 * 해당일자가 양력 법정공휴일에 해당하는 지 확인
	 * @param day
	 * @return
	 */
	private static boolean isHolidaySolar(String day) {
		boolean result = false;
		
		day = day.substring(4);
		
		String[] solarArr = getSolarArr();
		
		for (String d : solarArr) {
			if (day.equals(d)) {
				return true;
			}
		}
		
		return result;
	}
	
	/**
	 * 해당일자가 일요일인지 확인
	 * @param day
	 * @return
	 */
	private static boolean isSunday(String day) {
		boolean result = false;
		
		Calendar cal = new GregorianCalendar(Locale.KOREA);
		cal.set(Calendar.YEAR, Integer.parseInt(day.substring(0,4)));
		cal.set(Calendar.MONTH, Integer.parseInt(day.substring(4, 6)) - 1);
		cal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(day.substring(6)));
		
		if (cal.get ( Calendar.DAY_OF_WEEK ) == 1) {
			result = true;
		}
		
		return result;
	}
	
	/**
	 * 해당일자가 대체휴일인지 확인
	 * @param day
	 * @return
	 */
//	private static boolean isSubstitutionHolidaySolar(String day){
//		boolean result = false;
//		
//		day = day.substring(4);
////		System.out.println("[CommonUtil][isSubstitutionHolidaySolar] day : " + day);
//		for (String d : subSoArr) {
//			if (day.equals(d)) {
//				return true;
//			}
//		}
//		
//		return result;
//	}

}
