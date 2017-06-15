package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import reservation.DepositVO;
import reservation.RefundVO;
import reservation.SeasonVO;
import reservation.SiteVO;
import util.CommonUtil;
import util.ConnectionUtil;

public class CommonDAO {
	
	// DB연결객체 Close
	private void close(ResultSet rs,PreparedStatement pstmt,Connection conn){
		if(rs != null) try{ rs.close(); }catch(SQLException e){}finally{ rs = null; }
		if(pstmt != null) try{ pstmt.close(); }catch(SQLException e){}finally{ pstmt = null; }
		if(conn != null) try{ conn.close(); }catch(SQLException e){}finally{ conn = null; }
	}
	
	private static CommonDAO instance = new CommonDAO();
	
	public CommonDAO(){}
	
	// 객체 리턴
	public static CommonDAO getInstance(){
		return instance;
	}
	
	// 시즌 리스트출력
	public Vector<SeasonVO> selectSeasonList(String seasonCode){
		Vector<SeasonVO> seasons = new Vector<SeasonVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT * FROM season WHERE season_code = ? ORDER BY start_season ";
//			System.out.println("[CommonDAO][selectDepositList] SQL = " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, seasonCode);
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
	
	public String processSeason(HttpServletRequest request){
		String msg = "";
		int rtn = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "";
		String cmd = request.getParameter("cmd");
		String seasonCode = "";
		String seasonName = "";
		String startSeason = "";
		String endSeason = "";
		String flag = "";
		int length = 0;
		String[] middleFlag = request.getParameterValues("busyMiddleaddCalUseFlag[]");
		String[] hightFlag = request.getParameterValues("busyaddCalUseFlag[]");
		String[] startMiddleSeason = request.getParameterValues("busyMiddleFrom_add[]");
		String[] endMiddleSeason = request.getParameterValues("busyMiddleTo_add[]");
		String[] startHighSeason = request.getParameterValues("busyFrom_add[]");
		String[] endHighSeason = request.getParameterValues("busyTo_add[]");
//		System.out.println("[CommonDAO][selectRefundList] SQL = " + SQL);
		
		try{
			conn = ConnectionUtil.getConnection();
			SQL = "DELETE FROM season ";
			pstmt = conn.prepareStatement(SQL);
			pstmt.executeUpdate();
			
			SQL = "INSERT INTO season VALUES (?,?,?,?) ";
			if(startMiddleSeason.length>0){
				length = startMiddleSeason.length;
				seasonCode = "M";
				seasonName = "준성수기";
				for(int i=0; i<length; i++){
					flag = middleFlag[i];
					if(flag.equals("T")){
						startSeason = startMiddleSeason[i].substring(5);
						endSeason = endMiddleSeason[i].substring(5);
						
						pstmt = conn.prepareStatement(SQL);
						pstmt.setString(1, seasonCode);
						pstmt.setString(2, seasonName);
						pstmt.setString(3, startSeason);
						pstmt.setString(4, endSeason);
						pstmt.executeUpdate();
						rtn++;
					}
				}
			}
			
			if(startHighSeason.length>0){
				length = startHighSeason.length;
				seasonCode = "H";
				seasonName = "성수기";
				for(int i=0; i<length; i++){
					flag = hightFlag[i];
					if(flag.equals("T")){
						startSeason = startHighSeason[i].substring(5);
						endSeason = endHighSeason[i].substring(5);
						
						pstmt = conn.prepareStatement(SQL);
						pstmt.setString(1, seasonCode);
						pstmt.setString(2, seasonName);
						pstmt.setString(3, startSeason);
						pstmt.setString(4, endSeason);
						pstmt.executeUpdate();
						rtn++;
					}
					
				}
			}
			
			if(rtn == 0){
				msg = "처리중 오류가 발생했습니다. 관리자에게 문의해 주세요!";
			}else{
				msg = "저장되었습니다.";
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return msg;
	}

	// Refund 리스트출력
	public Vector<RefundVO> selectRefundList(){
		Vector<RefundVO> refunds = new Vector<RefundVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT * FROM refund " +
	             "ORDER BY refund_day_before ASC";
//				System.out.println("[CommonDAO][selectRefundList] SQL = " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();

			
			if( rs.next() ){
				do{
					RefundVO refund = new RefundVO();
					refund.setRefundDayBefore(rs.getInt("refund_day_before"));
					refund.setRefundType(rs.getString("refund_type"));
					refund.setRefundAmount(rs.getInt("refund_amount"));
					refunds.add(refund);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return refunds;
	}
	
	public String processRefund(HttpServletRequest request){
		String msg = "";
		int rtn = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "";
		String cmd = request.getParameter("cmd");
		int refundDayBefore = Integer.parseInt((String) request.getParameter("refundDayBefore"));
		String refundType = request.getParameter("refundType")==null?"":request.getParameter("refundType");
		int refundAmount = request.getParameter("refundAmount")==""?0:Integer.parseInt((String) request.getParameter("refundAmount"));
//		System.out.println("[CommonDAO][selectRefundList] SQL = " + SQL);
		
		try{
			conn = ConnectionUtil.getConnection();
			
			if(cmd.equals("add")){
				SQL = "INSERT INTO refund VALUES (?,?,?) ";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, refundDayBefore);
				pstmt.setString(2, refundType);
				pstmt.setInt(3, refundAmount);
				
				msg = "저장되었습니다.";
			}else if(cmd.equals("edit")){
				SQL = "UPDATE refund SET refund_type=?, refund_amount=? WHERE refund_day_before=?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, refundType);
				pstmt.setInt(2, refundAmount);
				pstmt.setInt(3, refundDayBefore);
				
				msg = "수정되었습니다.";
			}else if(cmd.equals("del")){
				SQL = "DELETE FROM refund WHERE refund_day_before=?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, refundDayBefore);
				
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
	
	// Refund 리스트출력
	public Vector<DepositVO> selectDepositList(){
		Vector<DepositVO> deposits = new Vector<DepositVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT * FROM deposit ";
//		System.out.println("[CommonDAO][selectDepositList] SQL = " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();

			
			if( rs.next() ){
				do{
					DepositVO deposit = new DepositVO();
					deposit.setBankName(rs.getString("bank_name"));
					deposit.setAccount(rs.getString("account"));
					deposit.setDepositor(rs.getString("depositor"));
					deposits.add(deposit);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return deposits;
	}
	
	public String processDeposit(HttpServletRequest request){
		String msg = "";
		int rtn = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "";
		String cmd = request.getParameter("cmd");
//		System.out.println("[CommonDAO][processDeposit] cmd = " + cmd);
		
		try{
			conn = ConnectionUtil.getConnection();
			String account = "";
			if(cmd.equals("insert")){
				String bankName = request.getParameter("bank_name");
				if(bankName.equals("etc")){
					bankName = request.getParameter("etc_bank_name");
				}
				account = request.getParameter("bank_acc_no");
				String depositor = request.getParameter("bank_depositor");
				
				SQL = "INSERT INTO deposit VALUES (?,?,?) ";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, bankName);
				pstmt.setString(2, account);
				pstmt.setString(3, depositor);
				
				msg = "저장되었습니다.";
			
			}else if(cmd.equals("delete")){
				account = request.getParameter("account");
				SQL = "DELETE FROM deposit WHERE account=?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, account);
				
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
	
	// Holyday 리스트출력
	public Vector<HolydayVO> selectHolydayList(){
		Vector<HolydayVO> holydays = new Vector<HolydayVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT dvsn_cd, concat(substr(mmdd,1,2),'-',substr(mmdd,3,2)) as mmdd, use_yn, description FROM holyday ";
//			System.out.println("[CommonDAO][selectHolydayList] SQL = " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();

			
			if( rs.next() ){
				do{
					HolydayVO holyday = new HolydayVO();
					holyday.setDvsnCd(rs.getString("dvsn_cd"));
					holyday.setMmdd(rs.getString("mmdd"));
					holyday.setUseYn(rs.getString("use_yn"));
					holyday.setDescription(rs.getString("description"));
					holydays.add(holyday);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return holydays;
	}
	
	public String processHolyday(HttpServletRequest request){
		String msg = "";
		int rtn = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "";
		String cmd = request.getParameter("cmd");
//			System.out.println("[CommonDAO][processHolyday] cmd = " + cmd);
		
		try{
			conn = ConnectionUtil.getConnection();
			String dvsnCd = request.getParameter("dvsnCd");
			String mmdd = request.getParameter("mmdd");
//			System.out.println("[CommonDAO][processHolyday] mmdd length = " + mmdd.length());
//			if(mmdd.length() > 4){
//				mmdd.replace("-", "");
//				System.out.println("[CommonDAO][processHolyday] mmdd length = " + mmdd.length());
//			}
//			System.out.println("[CommonDAO][processHolyday] param = " + dvsnCd + ", " + mmdd);
			if(cmd.equals("insert")){
				String useYn ="Y";
				String description = request.getParameter("description");

				SQL = "INSERT INTO holyday VALUES (?,?,?,?) ";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, dvsnCd);
				pstmt.setString(2, mmdd);
				pstmt.setString(3, useYn);
				pstmt.setString(4, description);
				
				msg = "저장되었습니다.";
			
			}else if(cmd.equals("delete")){
				SQL = "DELETE FROM holyday WHERE dvsn_cd=? AND mmdd=?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, dvsnCd);
				pstmt.setString(2, mmdd);
				
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
	
	// Popup 리스트출력
	public Vector<PopupVO> selectPopupList(String dvsn){
		Vector<PopupVO> popups = new Vector<PopupVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT * FROM popup ";
		String WHERE = "";
		
		if(dvsn.equals("admin")){
			
		}else if(dvsn.equals("main")){
			String today = CommonUtil.callDate();
			WHERE = "WHERE use_yn = 'Y' AND display_start_day <= DATE_FORMAT('"+today+"','%Y-%m-%d') AND display_end_day >= DATE_FORMAT('"+today+"','%Y-%m-%d') ";
		}
		
		SQL = SQL + WHERE;
//				System.out.println("[CommonDAO][selectPopupList] SQL = " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();

			
			if( rs.next() ){
				do{
					PopupVO popup = new PopupVO();
					popup.setLayerId(rs.getString("layer_id"));
					popup.setStyle(rs.getString("style"));
					popup.setUseYn(rs.getString("use_yn"));
					popup.setAlt(rs.getString("alt"));
					popup.setArea(rs.getString("area"));
					popup.setImgSrc(rs.getString("img_src"));
					popup.setUsemapId(rs.getString("usemap_id"));
					popup.setDisplayStartDay(rs.getDate("display_start_day"));
					popup.setDisplayEndDay(rs.getDate("display_end_day"));
					popups.add(popup);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return popups;
	}
	
	public PopupVO getPopup(String layerId){
		PopupVO popup = new PopupVO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT * FROM popup WHERE layer_id='"+layerId+"'";
//				System.out.println("[CommonDAO][getPopup] SQL = " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();

			if( rs.next() ){				
				popup.setLayerId(rs.getString("layer_id"));
				popup.setStyle(rs.getString("style"));
				popup.setUseYn(rs.getString("use_yn"));
				popup.setAlt(rs.getString("alt"));
				popup.setArea(rs.getString("area"));
				popup.setImgSrc(rs.getString("img_src"));
				popup.setUsemapId(rs.getString("usemap_id"));
				popup.setDisplayStartDay(rs.getDate("display_start_day"));
				popup.setDisplayEndDay(rs.getDate("display_end_day"));					
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return popup;
	}
	
	public String processPopup(HttpServletRequest request){
		String msg = "";
		int rtn = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "";
		String cmd = request.getParameter("cmd");
//			System.out.println("[CommonDAO][processPopup] cmd = " + cmd);
	
		try{
			conn = ConnectionUtil.getConnection();
			String layerId = request.getParameter("layerId");
			
			if(cmd.equals("insert")){
				String style = request.getParameter("style");
				String imgSrc = request.getParameter("imgSrc");
				String usemapId = request.getParameter("usemapId");
				String area = request.getParameter("area");
				String alt = request.getParameter("alt");
				String useYn = request.getParameter("useYn");
				String displayStartDay = request.getParameter("displayStartDay");
				String displayEndDay = request.getParameter("displayEndDay");

				SQL = "INSERT INTO popup VALUES (?,?,?,?,?,?,?,?,?) ";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, layerId);
				pstmt.setString(2, style);
				pstmt.setString(3, imgSrc);
				pstmt.setString(4, usemapId);
				pstmt.setString(5, area);
				pstmt.setString(6, alt);
				pstmt.setString(7, useYn);
				pstmt.setString(8, displayStartDay);
				pstmt.setString(9, displayEndDay);
								
				msg = "저장되었습니다.";
			}else if(cmd.equals("update")){
				String style = request.getParameter("style");
				String imgSrc = request.getParameter("imgSrc");
				String usemapId = request.getParameter("usemapId");
				String area = request.getParameter("area");
				String alt = request.getParameter("alt");
				String useYn = request.getParameter("useYn");
				String displayStartDay = request.getParameter("displayStartDay");
				String displayEndDay = request.getParameter("displayEndDay");
				
				SQL = "UPDATE popup SET style=?, img_src=?, usemap_id=?, area=?, alt=?, use_yn=?, display_start_day=?, display_end_day=? WHERE layer_id=? ";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, style);
				pstmt.setString(2, imgSrc);
				pstmt.setString(3, usemapId);
				pstmt.setString(4, area);
				pstmt.setString(5, alt);
				pstmt.setString(6, useYn);
				pstmt.setString(7, displayStartDay);
				pstmt.setString(8, displayEndDay);
				pstmt.setString(9, layerId);
				
				msg = "수정되었습니다.";
			}else if(cmd.equals("delete")){
				SQL = "DELETE FROM popup WHERE layer_id=?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, layerId);
				
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
	
	// site 리스트출력
	public Vector<SiteVO> selectSiteList(){
		Vector<SiteVO> sites = new Vector<SiteVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT z.zone_name, s.* FROM site_information s, zone_information z WHERE s.zone_no = z.zone_no ORDER BY s.zone_no, s.site_no ";
//			System.out.println("[CommonDAO][selectSiteList] SQL = " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();

			
			if( rs.next() ){
				do{
					SiteVO site = new SiteVO();
					site.setZoneNo(rs.getInt("zone_no"));
					site.setZoneName(rs.getString("zone_name"));
					site.setSiteNo(rs.getInt("site_no"));
					site.setSiteName(rs.getString("site_name"));
					sites.add(site);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return sites;
	}
	
	public String processSite(HttpServletRequest request){
		String msg = "";
		int rtn = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "";
		String cmd = request.getParameter("cmd");
//		System.out.println("[CommonDAO][processSite] cmd = " + cmd);
		
		try{
			conn = ConnectionUtil.getConnection();
			if(cmd.equals("insert")){
				int zoneNo = Integer.parseInt((String) request.getParameter("zoneNo"));
				String siteName = request.getParameter("siteName");
				
				SQL = "INSERT INTO site_information(zone_no, site_name) VALUES (?,?) ";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, zoneNo);
				pstmt.setString(2, siteName);
								
				msg = "저장되었습니다.";
			
			}else if(cmd.equals("delete")){
				int siteNo = Integer.parseInt((String) request.getParameter("siteNo"));
				SQL = "DELETE FROM site_information WHERE site_no=?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, siteNo);
				
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
	
	public String processZone(HttpServletRequest request){
		String msg = "";
		int rtn = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "";
		String cmd = request.getParameter("cmd");
//		System.out.println("[CommonDAO][processZone] cmd = " + cmd);
		
		try{
			conn = ConnectionUtil.getConnection();
			if(cmd.equals("insert")){
				String zoneName = request.getParameter("zoneName");
				int orderNo = Integer.parseInt((String) request.getParameter("orderNoOrg"));
				String useStartDay = request.getParameter("useStartDay");
				String useEndDay = request.getParameter("useEndDay");
				
				SQL = "UPDATE zone_information SET order_no = order_no+1 WHERE order_no >= ?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, orderNo);
				rtn = pstmt.executeUpdate();
				
				SQL = "INSERT INTO zone_information(zone_name, order_no, use_start_day, use_end_day) VALUES (?,?,?,?) ";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, zoneName);
				pstmt.setInt(2, orderNo);
				pstmt.setString(3, useStartDay);
				pstmt.setString(4, useEndDay);
				
				msg = "저장되었습니다.";
				
			}else if(cmd.equals("edit")){
				int zoneNo = Integer.parseInt((String) request.getParameter("zoneNoOrg"));
				String zoneName = request.getParameter("zoneName");
				int orderNo = Integer.parseInt((String) request.getParameter("orderNoOrg"));
				String useStartDay = request.getParameter("useStartDay");
				String useEndDay = request.getParameter("useEndDay");
				String orgZoneName = request.getParameter("orgZoneName");
				
				SQL = "UPDATE zone_information SET order_no = order_no+1 WHERE order_no >= ?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, orderNo);
				rtn = pstmt.executeUpdate();
				
				SQL = "UPDATE zone_information SET zone_name=?, order_no=?, use_start_day=?, use_end_day=? WHERE zone_no=?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, zoneName);
				pstmt.setInt(2, orderNo);
				pstmt.setString(3, useStartDay);
				pstmt.setString(4, useEndDay);
				pstmt.setInt(5, zoneNo);
				
				if(!orgZoneName.equals(zoneName)){
					SQL = "UPDATE reservation_day SET zone_name=? WHERE zone_name=?";
					pstmt = conn.prepareStatement(SQL);
					pstmt.setString(1, zoneName);
					pstmt.setString(2, orgZoneName);
				}
				
				msg = "수정되었습니다.";
			
			}else if(cmd.equals("delete")){
				int zoneNo = Integer.parseInt((String) request.getParameter("zoneNo"));
				int orderNo = Integer.parseInt((String) request.getParameter("orderNo"));
				
				SQL = "UPDATE zone_information SET order_no = order_no-1 WHERE order_no >= ?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, orderNo);
				rtn = pstmt.executeUpdate();
				
				SQL = "DELETE FROM zone_information WHERE zone_no=?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, zoneNo);
				
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

}
