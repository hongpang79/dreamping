package reservation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import util.CommonUtil;
import util.ConnectionUtil;
//import clientmember.LogonDataBean;

public class ReservationDAO {
	
	public ReservationDAO(){}
	
	
	// DB연결객체 Close
	private void close(ResultSet rs,PreparedStatement pstmt,Connection conn){
		if(rs != null) try{ rs.close(); }catch(SQLException e){}finally{ rs = null; }
		if(pstmt != null) try{ pstmt.close(); }catch(SQLException e){}finally{ pstmt = null; }
		if(conn != null) try{ conn.close(); }catch(SQLException e){}finally{ conn = null; }
	}
	
	// 성수기기간,계좌정보
	public Vector<SeasonVO> getSeason(HttpServletRequest request){
		Vector<SeasonVO> seasons = new Vector<SeasonVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from season";
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if( rs.next() ){
				do{
					SeasonVO season = new SeasonVO();
					season.setSeasonName(rs.getString("season_name"));
					season.setStartSeason(rs.getString("start_season"));
					season.setEndSeason(rs.getString("end_season"));
					seasons.add(season);
				}while(rs.next());	
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return seasons;
	}
	
	// 성수기기간,계좌정보
	public void getDepositInformation(HttpServletRequest request){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from deposit";
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if( rs.next() ){
				DepositVO deposit = new DepositVO();
				deposit.setBankName(rs.getString("bank_name"));
				deposit.setAccount(rs.getString("account"));
				deposit.setDepositor(rs.getString("depositor"));
				request.setAttribute("deposit", deposit);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
	}
	
	// zone별 site개수
	public Vector<SiteVO> getZoneInformation(String ym){
		Vector<SiteVO> countSite = new Vector<SiteVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select z.zone_name, count(*) as zone_cnt from zone_information z, site_information s where z.zone_no = s.zone_no and use_start_day <= '"+ym+"-01' and use_end_day >= '"+ym+"-28' group by z.zone_name order by z.order_no";
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if( rs.next() ){
				do{
					SiteVO site = new SiteVO();
					site.setZoneName(rs.getString("zone_name"));
					site.setZoneCnt(rs.getInt("zone_cnt"));
					countSite.add(site);
				}while(rs.next());	
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return countSite;
	}
	
	//일자별 zone별 총 site수, 예약된 site수, 예약가능 site수, 예약완료된 site수
	public Vector<String> reservationDateForZone(Vector<SiteVO> zone, String year, String month){
		//regDate {day, zone, totalCount, reservationCount, WaitCount, CompliteCount}  
		Vector<String> regDate = new Vector<String>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select a.reservation_day, a.zone_name, b.wait_cnt, c.complite_cnt   from reservation_day a left outer join "
	               + "(select reservation_day, zone_name, count(*) as wait_cnt from reservation_day where reservation_month = '"+year+month+"' and pay_status = 'W' group by reservation_day, zone_name) b "
	               + "on a.reservation_day = b.reservation_day and a.zone_name = b.zone_name left outer join "
	               + "(select reservation_day, zone_name, count(*) as complite_cnt from reservation_day where reservation_month = '"+year+month+"' and pay_status = 'C' group by reservation_day, zone_name) c "
	               + "on a.reservation_day = c.reservation_day and a.zone_name = c.zone_name INNER JOIN (SELECT zone_name FROM zone_information WHERE use_start_day <= '"+year+"-"+month+"-01' and use_end_day >= '"+year+"-"+month+"-28') z ON a.zone_name = z.zone_name "
	               + "where reservation_month = '"+year+month+"' group by a.reservation_day, a.zone_name order by a.reservation_day, a.zone_name";
		//System.out.println("reservationDateZone : " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while( rs.next() ){
				regDate.add(rs.getString(1));		//예약일자
				String zoneName = rs.getString(2);	
				regDate.add(rs.getString(2));		//예약zone
				for(int i=0; i<zone.size(); i++){
					if(zoneName.equals(zone.get(i).getZoneName())){
						int totalCnt = zone.get(i).getZoneCnt();
						int waitCnt = rs.getInt(3);
						int compliteCnt = rs.getInt(4);
						regDate.add(Integer.toString(totalCnt));						//총 site수
						regDate.add(Integer.toString(totalCnt-waitCnt-compliteCnt));	//예약가능 site수
						regDate.add(Integer.toString(waitCnt));							//예약중 site수
						regDate.add(Integer.toString(compliteCnt));						//예약완료된 site수
					}
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		
		return regDate;
	}
	
	//step2 start
	public void getDay(HttpServletRequest request){
		String chooseDate = (String)request.getParameter("chooseDate");	//선택한 날짜
		int maxRange = 30;
		String[] da = {"일","월","화","수","목","금","토"};
		String[] days = new String[maxRange];
		String picnicYn = "Y";
		try{
			Calendar chooseCal = Calendar.getInstance();
			chooseCal.set(Integer.parseInt(chooseDate.substring(0,4)),Integer.parseInt(chooseDate.substring(4,6))-1,Integer.parseInt(chooseDate.substring(6,8)));
			for( int i=0; i<maxRange ; i++ ){
				int day = chooseCal.get(Calendar.DAY_OF_WEEK);	// 선택날에 해당하는 요일 [일요일=1 1~7]
				days[i] = da[day-1];	
			} // for 문끝
			if(days[0].equals("금")|| days[0].equals("토")){
				picnicYn = "N";
			}
			boolean holiday = util.CommonUtil.holidayCheckAfterDay(chooseDate); //선택날 다음날이 공휴일이면 피크닉불가
			if( holiday){
				picnicYn = "N";
			}
		}catch(Exception e){
			System.out.println("[ReservationDAO][getDay] chooseDate : " + chooseDate);
			e.printStackTrace();
		}
		request.setAttribute("maxRange", maxRange);
		request.setAttribute("days", days);
		request.setAttribute("picnicYn", picnicYn);
	}
	
	//search
	public ArrayList<Map<String,String>> getSiteList(String zoneName, String resDate, String sNight){
		ArrayList<Map<String,String>> list = new ArrayList<Map<String,String>>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int iNight = Integer.parseInt(sNight);
		if(iNight > 0){
			iNight = iNight-1;
		}
		String SQL = "select product_no, product_name "
				+ "from product s LEFT OUTER JOIN "
				+ "(select site_no from reservation_day where zone_name = ? and reservation_day between ? and DATE_FORMAT(ADDDATE(?,?),'%Y%m%d') and pay_status <> 'R') d "
				+ "on s.site_no = d.site_no where s.zone_no = (select zone_no from zone_information where zone_name = ?) and use_yn = 'Y' "
				+ "and display_start_day <= ? and display_end_day >= ? and high_season_picnic <> ? and d.site_no is null Order by product_no";
//		System.out.println("SQL => " + SQL);
//		System.out.println("param => " + zoneName + ";"+ resDate + ";"+sNight);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, zoneName);
			pstmt.setString(2, resDate);
			pstmt.setString(3, resDate);
			pstmt.setInt(4, iNight);
			pstmt.setString(5, zoneName);
			pstmt.setString(6, resDate);
			pstmt.setString(7, resDate);
			pstmt.setString(8, sNight);
			rs = pstmt.executeQuery();
			while( rs.next() ){
				Map<String,String> sites = new HashMap<String,String>();
				sites.put("productNo", rs.getString(1));
				sites.put("productName", rs.getString(2));
//				System.out.println("RS");
				list.add(sites);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		
		return list;
	}
	
	// 선택된 site정보 검색
	public SiteVO getSiteForNo(String productNo){
		SiteVO site = new SiteVO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from product where product_no=?";
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, productNo);
			rs = pstmt.executeQuery();
			if( rs.next() ){
				site.setProductNo(rs.getInt("product_no"));						// 고유번호 primary key
				site.setProductName(rs.getString("product_name"));				// site이름
				site.setZoneNo(rs.getInt("zone_no"));
				site.setSiteNo(rs.getInt("site_no"));
				site.setUsers(rs.getInt("users"));							// 기본이용인원
				site.setMaxUsers(rs.getInt("max_users"));					// 최대인원수
				site.setAddChildPrice(rs.getInt("add_child_price"));		// 추가아동요금
				site.setAddUserPrice(rs.getInt("add_user_price"));			// 추가인원당 금액
				site.setLowSeasonWeekday(rs.getInt("low_season_weekday"));	// 주중가격
				site.setLowSeasonWeekend(rs.getInt("low_season_weekend"));	// 주말가격
				site.setLowSeasonPicnic(rs.getInt("low_season_picnic"));	// 피크닉가격
				site.setHighSeasonWeekday(rs.getInt("high_season_weekday"));// 성수기주중가격
				site.setHighSeasonWeekend(rs.getInt("high_season_weekend"));// 성수기주말
				site.setHighSeasonPicnic(rs.getInt("high_season_picnic"));	// 성수기피크닉
				site.setMiddleSeasonWeekday(rs.getInt("middle_season_weekday"));// 준성수기주중
				site.setMiddleSeasonWeekend(rs.getInt("middle_season_weekend"));// 준성수기주말
				site.setMiddleSeasonPicnic(rs.getInt("middle_season_picnic"));	// 준성수기피크닉
				site.setSale(rs.getInt("sale"));
				site.setSaleStartDay(rs.getDate("sale_start_day"));
				site.setSaleEndDay(rs.getDate("sale_end_day"));
				site.setSaleMemo(rs.getString("sale_memo"));
				site.setFlatPrice(rs.getInt("flat_price"));
				site.setFlatPriceStartDay(rs.getDate("flat_price_start_day"));
				site.setFlatPriceEndDay(rs.getDate("flat_price_end_day"));
				site.setProductMemo(rs.getString("product_memo"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return site;
	}
	
	// 선택된 site정보 검색
	public SiteVO getSiteForName(String siteName){
		SiteVO site = new SiteVO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from product where product_name=?";
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, siteName);
			rs = pstmt.executeQuery();
			if( rs.next() ){
				site.setProductNo(rs.getInt("product_no"));						// 고유번호 primary key
				site.setProductName(rs.getString("product_name"));				// site이름
				site.setSiteNo(rs.getInt("site_no"));
				site.setUsers(rs.getInt("users"));							// 기본이용인원
				site.setMaxUsers(rs.getInt("max_users"));					// 최대인원수
				site.setAddChildPrice(rs.getInt("add_child_price"));		// 추가아동요금
				site.setAddUserPrice(rs.getInt("add_user_price"));			// 추가인원당 금액
				site.setLowSeasonWeekday(rs.getInt("low_season_weekday"));	// 주중가격
				site.setLowSeasonWeekend(rs.getInt("low_season_weekend"));	// 주말가격
				site.setLowSeasonPicnic(rs.getInt("low_season_picnic"));	// 피크닉가격
				site.setHighSeasonWeekday(rs.getInt("high_season_weekday"));// 성수기주중가격
				site.setHighSeasonWeekend(rs.getInt("high_season_weekend"));// 성수기주말
				site.setHighSeasonPicnic(rs.getInt("high_season_picnic"));	// 성수기피크닉
				site.setMiddleSeasonWeekday(rs.getInt("middle_season_weekday"));// 준성수기주중
				site.setMiddleSeasonWeekend(rs.getInt("middle_season_weekend"));// 준성수기주말
				site.setMiddleSeasonPicnic(rs.getInt("middle_season_picnic"));	// 준성수기피크닉
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return site;
	}
	
	// 선택한 방에 기간별 가격(성수기,주말등에 따른 변동 가격정리)
	public String payMoney(String saleYn, String flatPriceYn, SiteVO site, HttpServletRequest request){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String money = "0";
		String chooseDate = (String)request.getParameter("chooseDate");		// 선택한 날짜
		
		try{
			/*
			int size = season.size();
			String[] seasonName = new String[size];
			int[] iStartSeason = new int[size];
			int[] iEndSeason = new int[size];
			for(int s=0; s<size; s++){
				String[] startSeason = season.get(s).getStartSeason().split("-");
				String[] endSeason = season.get(s).getEndSeason().split("-");
				seasonName[s] = season.get(s).getSeasonName();
				for( int i=0; i<2 ; i++ ){
					startSeason[0] = (Integer.parseInt(startSeason[0]) < 10) ? "0"+Integer.parseInt(startSeason[0]) : startSeason[0] ;
				}
				iStartSeason[s] = Integer.parseInt(chooseDate.substring(0,4)+startSeason[0]+startSeason[1]);
				for( int i=0; i<2 ; i++ ){
					endSeason[0] = (Integer.parseInt(endSeason[0]) < 10) ? "0"+Integer.parseInt(endSeason[0]) : endSeason[0] ;
				}
				iEndSeason[s] = Integer.parseInt(chooseDate.substring(0,4)+endSeason[0]+endSeason[1]);
			}
			*/	
			int maxRange = Integer.parseInt(request.getParameter("sNight"));
//			System.out.print(chooseDate+" ");
//			String[] da = {"일","월","화","수","목","금","토"};
			Calendar chooseCal = Calendar.getInstance();
			chooseCal.set(Integer.parseInt(chooseDate.substring(0,4)),Integer.parseInt(chooseDate.substring(4,6))-1,Integer.parseInt(chooseDate.substring(6,8)));
//			int[] price = new int[maxRange];
//			String[] days = new String[maxRange];
			int payMoney = 0;
			int flatMoney = 0;
			
			conn = ConnectionUtil.getConnection();
			String SQL = "select * from season where cast(concat(date_format(now(),'%Y-'),start_season) as date) <= cast(? as date) and cast(concat(date_format(now(),'%Y-'),end_season) as date) >= cast(? as date)";
			pstmt = conn.prepareStatement(SQL);
			String seasonCode = "L"; 
//			System.out.println("maxRange = " + maxRange);
			if(maxRange == 0){	//피크닉인경우
				String chkDate = chooseCal.get(Calendar.YEAR)+"-"+((chooseCal.get(Calendar.MONTH)+1) < 10 ? "0"+(chooseCal.get(Calendar.MONTH)+1) : chooseCal.get(Calendar.MONTH)+1) +"-"+chooseCal.get(Calendar.DATE);
				int day = chooseCal.get(Calendar.DAY_OF_WEEK);	// 선택날에 해당하는 요일 [일요일=1 1~7]
				boolean holiday = util.CommonUtil.holidayCheckAfterDay(chooseDate); //선택날 다음날이 공휴일이면 피크닉불가
				if( holiday){
					day = 7;
				}
				if( day == 6 || day == 7 ){	//피크닉은 일요일~목요일까지만 가능
					money = "-1";
				}else{
					chooseCal.add(Calendar.DAY_OF_MONTH, 1);
					
					pstmt.setString(1, chkDate);
					pstmt.setString(2, chkDate);
					rs = pstmt.executeQuery();
					
					if( rs.next() ){
						seasonCode = rs.getString("season_code");
					} 
//					System.out.println("seasonCode : " + seasonCode);
					if(seasonCode.equals("L")){
//						price[maxRange] = site.getLowSeasonPicnic();
						payMoney = payMoney + site.getLowSeasonPicnic();
					}else if(seasonCode.equals("H")){
//						price[maxRange] = site.getHighSeasonPicnic();
						payMoney = payMoney + site.getHighSeasonPicnic();
					}else if(seasonCode.equals("M")){
//						price[maxRange] = site.getMiddleSeasonPicnic();
						payMoney = payMoney + site.getMiddleSeasonPicnic();
					}
					money = Integer.toString(payMoney);
				}
			}else{
//				int zoneNo = site.zoneNo;
//				System.out.println("zoneNo : " + zoneNo);
				for( int i=0; i<maxRange ; i++ ){
//					if(flatPriceYn.equals("Y")){ //균일가 기간에는 평일/주말 체크로직 없이 일괄 적용
//						payMoney = payMoney + site.getFlatPrice();
//						
//					}else{
						
						
						//int chkDate = Integer.parseInt(chooseCal.get(Calendar.YEAR)+""+((chooseCal.get(Calendar.MONTH)+1) < 10 ? "0"+(chooseCal.get(Calendar.MONTH)+1) : chooseCal.get(Calendar.MONTH)+1) +""+chooseCal.get(Calendar.DATE));
						String chkDate = chooseCal.get(Calendar.YEAR)+"-"+((chooseCal.get(Calendar.MONTH)+1) < 10 ? "0"+(chooseCal.get(Calendar.MONTH)+1) : chooseCal.get(Calendar.MONTH)+1) +"-"+chooseCal.get(Calendar.DATE);
						String chkHolyDate = chooseCal.get(Calendar.YEAR)+""+((chooseCal.get(Calendar.MONTH)+1) < 10 ? "0"+(chooseCal.get(Calendar.MONTH)+1) : chooseCal.get(Calendar.MONTH)+1) +""+chooseCal.get(Calendar.DATE);
						int day = chooseCal.get(Calendar.DAY_OF_WEEK);	// 선택날에 해당하는 요일 [일요일=1 1~7]
	//					System.out.print(day+" ");
	//					days[i] = da[day-1];
						
						boolean holiday = util.CommonUtil.holidayCheckAfterDay(chkHolyDate); //선택날 다음날이 공휴일이면 주말가격임.
						if( holiday){
							day = 8;  //공휴일=8
//							System.out.println("holiday check : " + day);
						}
						
//						System.out.println("[before]" + chooseCal.get(Calendar.MONTH)+"/"+chooseCal.get(Calendar.DATE));
						chooseCal.add(Calendar.DAY_OF_MONTH, 1); //다음날의 대한 값을 구하기 위해 하루를 더함
//						System.out.println("[after]" + chooseCal.get(Calendar.MONTH)+"/"+chooseCal.get(Calendar.DATE));
						
						pstmt.setString(1, chkDate);
						pstmt.setString(2, chkDate);
						rs = pstmt.executeQuery();
						
						if( rs.next() ){
							seasonCode = rs.getString("season_code");
						}
						
//						if( day == 6 && Integer.parseInt(chooseDate.substring(4,6))==4){ //일시적으로 4월의 금요일도 평일편입
//							if(seasonCode.equals("L")){
////								price[i] = site.getLowSeasonWeekend();
//								payMoney = payMoney + site.getLowSeasonWeekday();
//							}else if(seasonCode.equals("H")){
////								price[i] = site.getHighSeasonWeekend();
//								payMoney = payMoney + site.getHighSeasonWeekday();
//							}else if(seasonCode.equals("M")){
////								price[i] = site.getLowSeasonWeekday();
//								payMoney = payMoney + site.getMiddleSeasonWeekday();
//							}
						
//						if( day == 6 && flatPriceYn.equals("Y")){	// 균일가 이벤트
//							payMoney = payMoney + site.getFlatPrice();
//							flatMoney = flatMoney + site.getFlatPrice();
//						}else if( day == 6 || day == 7 || day == 8){	// 금요일 또는 토요일 (주말), 국경일전날
						
						if( day == 7 || day == 8){	// 토요일 (주말), 국경일전날
							if(seasonCode.equals("L")){
//								price[i] = site.getLowSeasonWeekend();
								payMoney = payMoney + site.getLowSeasonWeekend();
							}else if(seasonCode.equals("H")){
//								price[i] = site.getHighSeasonWeekend();
								payMoney = payMoney + site.getHighSeasonWeekend();
							}else if(seasonCode.equals("M")){
//								price[i] = site.getLowSeasonWeekday();
								payMoney = payMoney + site.getMiddleSeasonWeekend();
							}
						}else if(flatPriceYn.equals("Y")){	// 균일가 이벤트
								payMoney = payMoney + site.getFlatPrice();
								flatMoney = flatMoney + site.getFlatPrice();
//						}else if((zoneNo==2 || zoneNo==3) && flatPriceYn.equals("Y")){	// 특정사이트 균일가 이벤트
//								payMoney = payMoney + site.getFlatPrice();
//								flatMoney = flatMoney + site.getFlatPrice();
						}else{
							if(seasonCode.equals("L")){
//								price[i] = site.getLowSeasonWeekday();
								payMoney = payMoney + site.getLowSeasonWeekday();
							}else if(seasonCode.equals("H")){
//								price[i] = site.getHighSeasonWeekday();
								payMoney = payMoney + site.getHighSeasonWeekday();
							}else if(seasonCode.equals("M")){
//								price[i] = site.getHighSeasonWeekday();
								payMoney = payMoney + site.getMiddleSeasonWeekday();
							}

						}
						
						/*
						if( chkDate >= sSea && chkDate <= eSea ){	// 성수기
							if( day == 6 || day == 7 ){	// 금요일 또는 토요일 (주말)
								price[i] = site.getHighSeasonWeekend();
								payMoney = payMoney + site.getHighSeasonWeekend();
							}else{ // 성수기 평일
								price[i] = site.getHighSeasonWeekday();
								payMoney = payMoney + site.getHighSeasonWeekday();
							}
						}else{	// 비수기
							if( day == 6 || day == 7 ){	// 금요일 또는 토요일 (주말)
								price[i] = site.getLowSeasonWeekend();
								payMoney = payMoney + site.getLowSeasonWeekend();
							}else{ // 비수기 평일
								price[i] = site.getLowSeasonWeekday();
								payMoney = payMoney + site.getLowSeasonWeekday();
							}
						}
						*/
						
					} // for 문끝
//				}
				
				if(saleYn.equals("Y")){
					int isale = site.getSale();
					int saleMoney = payMoney - flatMoney;
					isale = (saleMoney * isale) / 100;
					payMoney = payMoney - isale;
				}
				money = Integer.toString(payMoney);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		
		return money;
	}
	
	// 예약 데이터 입력
	public synchronized void setReservation(HttpServletRequest request){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String chooseZone = (String)request.getAttribute("chooseZone");
		int night = Integer.parseInt((String)request.getAttribute("nights"));
		String chooseDate = request.getAttribute("chooseDate").toString();
		Calendar cal = Calendar.getInstance();
		cal.set(Integer.parseInt(chooseDate.substring(0,4)),Integer.parseInt(chooseDate.substring(4,6))-1,Integer.parseInt(chooseDate.substring(6,8)));
		cal.add(Calendar.DATE,night-1);
		
		int productNo = Integer.parseInt((String)request.getAttribute("productNo"));
		String productName = (String) request.getAttribute("productName");
		int siteNo = Integer.parseInt((String)request.getAttribute("siteNo"));
		String startDate = chooseDate;
		String endDate = cal.get(Calendar.YEAR)+"";
		String mm = ((cal.get(Calendar.MONTH)+1) < 10) ? "0"+(cal.get(Calendar.MONTH)+1) : (cal.get(Calendar.MONTH)+1)+"";
		String dd = (cal.get(Calendar.DATE) < 10) ? "0"+cal.get(Calendar.DATE) : cal.get(Calendar.DATE)+"";
		endDate = endDate + mm + dd;
		
		// request 로 넘어온 아이디 값으로 primary key 값 알아오기
//		int memberNo = getMno((String) request.getSession().getAttribute("memId"));
//		System.out.println("setReservation - member no : " + memberNo);
		int memberNo = 0;
		
		String resDate = chooseDate;
		int toddler = Integer.parseInt((String)request.getAttribute("toddler"));
		int child = Integer.parseInt((String)request.getAttribute("child"));
		int users = Integer.parseInt((String)request.getAttribute("users"));
//		users += 2;
		int price = Integer.parseInt((String)request.getAttribute("payAll"));
		String payment = request.getAttribute("payment").toString();
		String bankName = "",account = "",payYn = "",depositor="";
		if( payment.equals("C") ){
			bankName = request.getAttribute("cardName").toString();
			account = request.getAttribute("cardNumber").toString();
			payYn = "Y";
		}else if(payment.equals("V")){
			DepositVO deposit = (DepositVO)request.getAttribute("deposit");
			bankName = deposit.getBankName();
			account = deposit.getAccount();
			payYn = "N";
			depositor = deposit.getDepositor();
		}
		
		String reserver = (String) request.getAttribute("r_name");
		String phone1 = (String) request.getAttribute("r_phone1");
		String phone2 = (String) request.getAttribute("r_phone2");
		String phone3 = (String) request.getAttribute("r_phone3");
		String tel1 = (String) request.getAttribute("r_tel1");
		String tel2 = (String) request.getAttribute("r_tel2");
		String tel3 = (String) request.getAttribute("r_tel3");
		String email = (String) request.getAttribute("r_email");
		String content = (String) request.getAttribute("r_content");
		
		int reservationNo = 0;
				
//		String SQL = "SELECT count(*) FROM reservation WHERE site_no=? AND DATE_FORMAT(reservation_date,'%Y%m%d') BETWEEN ? AND ?";
		String SQL = "SELECT count(*) FROM reservation_day WHERE site_no=? AND reservation_day BETWEEN ? AND ? AND pay_status <> 'R'";
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, siteNo);
			pstmt.setString(2, startDate);
			pstmt.setString(3, endDate);
			rs = pstmt.executeQuery();
			
			if( rs.next() ){
//				System.out.println("setReservation - count : "+ rs.getInt(1));
				if( rs.getInt(1) == 0 ){
					SQL = "INSERT INTO reservation (product_no,site_no,member_no,reservation_date,nights,toddler,child,users,price,payment,bank_name,account,pay_status,reserver,phone1,phone2,phone3,cell1,cell2,cell3,email,memo,reg_date)" +
							" VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,NOW())";
					pstmt = conn.prepareStatement(SQL);
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
					int result = pstmt.executeUpdate();
					request.setAttribute("insertResult", result);
//					System.out.println("setReservation - insertResult : "+result);
					
					SQL = "SELECT max(reservation_no) FROM reservation WHERE site_no=? and reservation_date=? and DATE_FORMAT(reg_date,'%Y%m%d')=DATE_FORMAT(NOW(),'%Y%m%d')";
					pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, siteNo);
					pstmt.setString(2, resDate);
					rs = pstmt.executeQuery();
					if( rs.next() ){
//						System.out.println("setReservation - reservationNo : "+ rs.getInt(1));
						reservationNo = rs.getInt(1);
					}
								
					SQL = "INSERT INTO reservation_day (reservation_month,reservation_day,zone_name,site_no,reservation_no,pay_status,reg_date)" +
							" VALUES(?,?,?,?,?,?,NOW())";
					
					int loop = night;
					if(loop == 0){
						loop = loop + 1;
					}
					for(int i=0; i<loop; i++){
						pstmt = conn.prepareStatement(SQL);
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
						pstmt.setString(3, chooseZone);
						pstmt.setInt(4, siteNo);
						pstmt.setInt(5, reservationNo);
						pstmt.setString(6, "W");
						pstmt.executeUpdate();
					}
					
					if(result == 1){
						String phoneNumber = phone1+phone2+phone3;
						resDate = resDate.substring(0,4)+"-"+resDate.substring(4,6)+"-"+resDate.substring(6);
						if(phoneNumber.length() > 9){
//							String depositDate = util.CommonUtil.callPlusDate(2);
//							int msgNo = 1;
//							String dvsn = "user";
//							String msg = "";
//							SQL = "SELECT msg FROM sms_manager WHERE msg_no=? and dvsn=? ";
//							pstmt = conn.prepareStatement(SQL);
//							pstmt.setInt(1, msgNo);
//							pstmt.setString(2, dvsn);
//							rs = pstmt.executeQuery();
//							if( rs.next() ){
//								msg = rs.getString(1);
//								msg = msg.replace("[DATE]", resDate);
//								msg = msg.replace("[SITENAME]", productName);
//								msg = msg.replace("[DEPOSITDATE]", depositDate);
//							}
//							//System.out.println(reservationNo+","+msgNo+","+phoneNumber+","+msg);
//							util.CallSMS.callSMS(reservationNo, msgNo, phoneNumber, msg);
//							
//							msgNo = 2;
//							SQL = "SELECT msg FROM sms_manager WHERE msg_no=? and dvsn=? ";
//							pstmt = conn.prepareStatement(SQL);
//							pstmt.setInt(1, msgNo);
//							pstmt.setString(2, dvsn);
//							rs = pstmt.executeQuery();
//							if( rs.next() ){
//								msg = rs.getString(1);
//								msg = msg.replace("[BANK]", bankName);
//								msg = msg.replace("[ACCOUNT]", account);
//								msg = msg.replace("[DEPOSITOR]", depositor);
//								msg = msg.replace("[PRICE]", util.CommonUtil.makeMoneyType(Integer.toString(price)));
//								msg = msg.replace("[DEPOSITDATE]", depositDate);
//							}
//							//System.out.println(reservationNo+","+msgNo+","+phoneNumber+","+msg);
//							util.CallSMS.callSMS(reservationNo, msgNo, phoneNumber, msg);
							
							String depositDate = util.CommonUtil.callPlusDate(1);
							depositDate = util.CommonUtil.isAfterDate(resDate, depositDate);
//							System.out.println(depositDate);
							String subject = "어반슬로우시티 예약접수안내";
							int msgNo = 1;
							String dvsn = "user";
							String msg = "";
							SQL = "SELECT msg FROM sms_manager WHERE msg_no=? and dvsn=? ";
							pstmt = conn.prepareStatement(SQL);
							pstmt.setInt(1, msgNo);
							pstmt.setString(2, dvsn);
							rs = pstmt.executeQuery();
							if( rs.next() ){
								msg = rs.getString(1);
								msg = msg.replace("[DATE]", resDate);
								msg = msg.replace("[SITENAME]", productName);
								msg = msg.replace("[BANK]", bankName);
								msg = msg.replace("[ACCOUNT]", account);
								msg = msg.replace("[DEPOSITOR]", depositor);
								msg = msg.replace("[PRICE]", util.CommonUtil.makeMoneyType(Integer.toString(price)));
								msg = msg.replace("[DEPOSITDATE]", depositDate);
							}
							//System.out.println(reservationNo+","+msgNo+","+phoneNumber+","+msg);
							util.CallSMS.callLMS(reservationNo, msgNo, phoneNumber, subject, msg);
							
							msgNo = 1;
							dvsn = "admin";
							SQL = "SELECT msg FROM sms_manager WHERE msg_no=? and dvsn=? ";
							pstmt = conn.prepareStatement(SQL);
							pstmt.setInt(1, msgNo);
							pstmt.setString(2, dvsn);
							rs = pstmt.executeQuery();
							if( rs.next() ){
								msg = rs.getString(1);
								msg = msg.replace("[DATE]", resDate);
								msg = msg.replace("[SITENAME]", productName);
								msg = msg.replace("[RESERVER]", reserver);
							}
							
							SQL = "SELECT phone_number FROM sms_phone ";
							pstmt = conn.prepareStatement(SQL);
							rs = pstmt.executeQuery();
							if( rs.next() ){
								do{
									phoneNumber = rs.getString(1);
									//System.out.println(reservationNo+","+msgNo+","+phoneNumber+","+msg);
									util.CallSMS.callSMS(reservationNo, msgNo, phoneNumber, msg);
								}while(rs.next());
							}
						}
					}
					
					
				}else{
					System.out.println("setReservation : rs count is not zero!");
				}
			}else{
				System.out.println("setReservation : rs is null!");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
	}
		
	//member의 예약현황	
	public Vector<ReservationVO> getReservationDataForMember(String id){
		Vector<ReservationVO> reservations = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT RM.zone_name, RM.product_name, R.* FROM reservation R " +
		             "LEFT OUTER JOIN member J " +
				     "ON R.member_no=J.member_no " +
		             "LEFT OUTER JOIN (select zone_name, product_no, product_name, site_no, site_name FROM product s, zone_information z WHERE z.zone_no = s.zone_no) RM " +
				     "ON R.product_no=RM.product_no " +
		             "WHERE id = ? " +
				     "ORDER BY reservation_date DESC";
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				reservations = new Vector<ReservationVO>();
				do{
					ReservationVO reservation = new ReservationVO();
					reservation.setReservationNo(rs.getInt("reservation_no"));
					reservation.setReservationDate(rs.getDate("reservation_date"));
					reservation.setZoneName(rs.getString("zone_name"));
					reservation.setSiteName(rs.getString("site_name"));
					reservation.setUsers(rs.getInt("users"));
					reservation.setNights(rs.getInt("nights"));
					reservation.setPrice(rs.getInt("price"));
					reservation.setPayStatus(rs.getString("pay_status"));
					reservation.setMemo(rs.getString("memo"));
					reservations.add(reservation);
				}while(rs.next());
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
		}
		return reservations;
	}	
		
	public Vector<ReservationVO> getReservationDataForGuest(String sname, String sphone1, String sphone2, String sphone3){
		Vector<ReservationVO> reservations = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT RM.zone_name, RM.product_name, R.* FROM reservation R " +
		             "LEFT OUTER JOIN (select zone_name, product_no, product_name, site_no, site_name FROM product s, zone_information z WHERE z.zone_no = s.zone_no) RM " +
				     "ON R.product_no=RM.product_no " +
		             "WHERE reserver = ? " +
				     "AND phone1 = ? " +
				     "AND phone2 = ? " +
				     "AND phone3 = ? " +
				     "ORDER BY reservation_date DESC";
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, sname);
			pstmt.setString(2, sphone1);
			pstmt.setString(3, sphone2);
			pstmt.setString(4, sphone3);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				reservations = new Vector<ReservationVO>();
				do{
					ReservationVO reservation = new ReservationVO();
					reservation.setReservationNo(rs.getInt("reservation_no"));
					reservation.setReservationDate(rs.getDate("reservation_date"));
					reservation.setZoneName(rs.getString("zone_name"));
					reservation.setProductName(rs.getString("product_name"));
					reservation.setToddler(rs.getInt("toddler"));
					reservation.setChild(rs.getInt("child"));
					reservation.setUsers(rs.getInt("users"));
					reservation.setNights(rs.getInt("nights"));
					reservation.setPrice(rs.getInt("price"));
					reservation.setPayStatus(rs.getString("pay_status"));
					reservation.setMemo(rs.getString("memo"));
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
		
	public ReservationVO getReservationDataForReservationNo(String reservationNo){
		ReservationVO reservation = new ReservationVO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT  RM.zone_name, RM.product_name, R.* FROM reservation R " +
		             "LEFT OUTER JOIN (select zone_name, product_no, product_name, site_no, site_name FROM product s, zone_information z WHERE z.zone_no = s.zone_no) RM " +
				     "ON R.product_no=RM.product_no " +
		             "WHERE reservation_no = ? ";
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(reservationNo));
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				reservation.setReservationNo(rs.getInt("reservation_no"));
				reservation.setReservationDate(rs.getDate("reservation_date"));
				reservation.setZoneName(rs.getString("zone_name"));
				reservation.setProductName(rs.getString("product_name"));
				reservation.setToddler(rs.getInt("toddler"));
				reservation.setChild(rs.getInt("child"));
				reservation.setUsers(rs.getInt("users"));
				reservation.setNights(rs.getInt("nights"));
				reservation.setPrice(rs.getInt("price"));
				reservation.setPayStatus(rs.getString("pay_status"));
				reservation.setMemo(rs.getString("memo"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return reservation;
	}
	
	// 예약취소신청
	public void setCancleOk(String reservationNo, String remark, String refundBank, String refundAccount, String refundDepositor, String payStatus, int msgNo){
		String currentDateTime = CommonUtil.callDateTime();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "UPDATE reservation SET pay_status=?, refund_bank=?, refund_depositor=?, refund_account=?, remark=?, refund_reg_date=now() "
				   + "WHERE reservation_no=?";
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, payStatus);
			pstmt.setString(2, refundBank);
			pstmt.setString(3, refundDepositor);
			pstmt.setString(4, refundAccount);
			pstmt.setString(5, remark);
			pstmt.setInt(6, Integer.parseInt(reservationNo));
			pstmt.executeUpdate();
			
			System.out.println(currentDateTime + " [reservation.reservationDAO.setCancleOk] - reservation_no : " + reservationNo);
			
			String SQL1 = "UPDATE reservation_day SET pay_status='R', reg_date=now() "
				+ "WHERE reservation_no=?";
			
			pstmt = conn.prepareStatement(SQL1);
			pstmt.setInt(1, Integer.parseInt(reservationNo));
			int rtn = pstmt.executeUpdate();
			
			System.out.println(currentDateTime + " [reservation.reservationDAO.setCancleOk] - reservation_day update check : pay_status='R' , update count=" + rtn);
			
			if(rtn > 0){
				String resDate = "";
				String productName = "";
				String reserver = "";
				SQL = "SELECT p.product_name, reserver, DATE_FORMAT(r.reservation_date,'%Y-%m-%d') as res_date FROM reservation r, product p WHERE r.product_no=p.product_no AND reservation_no = ?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, Integer.parseInt(reservationNo));
				rs = pstmt.executeQuery();
				if( rs.next() ){
					resDate = rs.getString("res_date");
					productName = rs.getString("product_name");
					reserver = rs.getString("reserver");
				}
				
				String dvsn = "admin";
				String phoneNumber = "";
				String msg = "";
				SQL = "SELECT msg FROM sms_manager WHERE msg_no=? and dvsn=? ";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, msgNo);
				pstmt.setString(2, dvsn);
				rs = pstmt.executeQuery();
				if( rs.next() ){
					msg = rs.getString(1);
					msg = msg.replace("[DATE]", resDate);
					msg = msg.replace("[SITENAME]", productName);
					msg = msg.replace("[RESERVER]", reserver);
				}
				
				SQL = "SELECT phone_number FROM sms_phone ";
				pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				if( rs.next() ){
					do{
						phoneNumber = rs.getString(1);
						//System.out.println(reservationNo+","+msgNo+","+phoneNumber+","+msg);
						util.CallSMS.callSMS(Integer.parseInt(reservationNo), msgNo, phoneNumber, msg);
					 }while(rs.next());
				}
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(null,pstmt,conn);
		}
	}
	
	public ArrayList<Map<String,String>> getSiteListForZoneNo(int zoneNo){
		ArrayList<Map<String,String>> list = new ArrayList<Map<String,String>>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select site_no, site_name from site_information where zone_no=?";
				
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, zoneNo);
			rs = pstmt.executeQuery();
			while( rs.next() ){
				Map<String,String> sites = new HashMap<String,String>();
				sites.put("siteNo", rs.getString(1));
				sites.put("siteName", rs.getString(2));
				list.add(sites);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		
		return list;
	}
	
}