package admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import reservation.SiteVO;
import util.ConnectionUtil;

public class ProductDAO {
	
	// DB연결객체 Close
	private void close(ResultSet rs,PreparedStatement pstmt,Connection conn){
		if(rs != null) try{ rs.close(); }catch(SQLException e){}finally{ rs = null; }
		if(pstmt != null) try{ pstmt.close(); }catch(SQLException e){}finally{ pstmt = null; }
		if(conn != null) try{ conn.close(); }catch(SQLException e){}finally{ conn = null; }
	}
	
	private static ProductDAO instance = new ProductDAO();
	
	public ProductDAO(){}
	
	// 객체 리턴
	public static ProductDAO getInstance(){
		return instance;
	}
	
	// SITE 리스트출력
	public Vector<SiteVO> selectProductList(){
		Vector<SiteVO> products = new Vector<SiteVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT z.zone_name, s.* FROM zone_information z, product s where z.zone_no = s.zone_no " +
	             "ORDER BY product_no ASC";
//			System.out.println("[ProductDAO][selectProductList] SQL = " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();

			
			if( rs.next() ){
				do{
					SiteVO product = new SiteVO();
					product.setProductNo(rs.getInt("product_no"));
					product.setProductName(rs.getString("product_name"));
					product.setSiteNo(rs.getInt("site_no"));
					product.setZoneName(rs.getString("zone_name"));
					product.setUsers(rs.getInt("users"));
					product.setMaxUsers(rs.getInt("max_users"));
					product.setAddChildPrice(rs.getInt("add_child_price"));
					product.setAddUserPrice(rs.getInt("add_user_price"));
					product.setLowSeasonWeekday(rs.getInt("low_season_weekday"));
					product.setLowSeasonWeekend(rs.getInt("low_season_weekend"));
					product.setLowSeasonPicnic(rs.getInt("low_season_picnic"));
					product.setMiddleSeasonWeekday(rs.getInt("middle_season_weekday"));
					product.setMiddleSeasonWeekend(rs.getInt("middle_season_weekend"));
					product.setMiddleSeasonPicnic(rs.getInt("middle_season_picnic"));
					product.setHighSeasonWeekday(rs.getInt("high_season_weekday"));
					product.setHighSeasonWeekend(rs.getInt("high_season_weekend"));
					product.setHighSeasonPicnic(rs.getInt("high_season_picnic"));
					product.setDisplayStartDay(rs.getDate("display_start_day"));
					product.setDisplayEndDay(rs.getDate("display_end_day"));
					product.setSale(rs.getInt("sale"));
					product.setSaleStartDay(rs.getDate("sale_start_day"));
					product.setSaleEndDay(rs.getDate("sale_end_day"));
					product.setFlatPrice(rs.getInt("flat_price"));
					product.setFlatPriceStartDay(rs.getDate("flat_price_start_day"));
					product.setFlatPriceEndDay(rs.getDate("flat_price_end_day"));
					product.setUseYn(rs.getString("use_yn"));
					product.setProductMemo(rs.getString("product_memo"));
					product.setSaleMemo(rs.getString("sale_memo"));
					products.add(product);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return products;
	}
	
	public Vector<SiteVO> selectProductListForToday(String startDay, String endDay){
		Vector<SiteVO> products = new Vector<SiteVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT z.zone_name, z.order_no, s.* FROM zone_information z, product s where z.zone_no = s.zone_no "
				   + "and s.use_yn = 'Y' and s.display_start_day <= '"+ startDay +"' and s.display_end_day >= '" + endDay +"' "
				   + "and z.use_start_day <= '"+ startDay +"' and z.use_end_day >= '" + endDay +"' "
				   + "ORDER BY z.order_no,  s.product_name ASC";
//			System.out.println("[ProductDAO][selectProductListForToday] SQL = " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();

			
			if( rs.next() ){
				do{
					SiteVO product = new SiteVO();
					product.setProductNo(rs.getInt("product_no"));
					product.setProductName(rs.getString("product_name"));
					product.setSiteNo(rs.getInt("site_no"));
					product.setZoneName(rs.getString("zone_name"));
					product.setUsers(rs.getInt("users"));
					product.setMaxUsers(rs.getInt("max_users"));
					product.setAddChildPrice(rs.getInt("add_child_price"));
					product.setAddUserPrice(rs.getInt("add_user_price"));
					product.setLowSeasonWeekday(rs.getInt("low_season_weekday"));
					product.setLowSeasonWeekend(rs.getInt("low_season_weekend"));
					product.setLowSeasonPicnic(rs.getInt("low_season_picnic"));
					product.setMiddleSeasonWeekday(rs.getInt("middle_season_weekday"));
					product.setMiddleSeasonWeekend(rs.getInt("middle_season_weekend"));
					product.setMiddleSeasonPicnic(rs.getInt("middle_season_picnic"));
					product.setHighSeasonWeekday(rs.getInt("high_season_weekday"));
					product.setHighSeasonWeekend(rs.getInt("high_season_weekend"));
					product.setHighSeasonPicnic(rs.getInt("high_season_picnic"));
					product.setDisplayStartDay(rs.getDate("display_start_day"));
					product.setDisplayEndDay(rs.getDate("display_end_day"));
					product.setSale(rs.getInt("sale"));
					product.setSaleStartDay(rs.getDate("sale_start_day"));
					product.setSaleEndDay(rs.getDate("sale_end_day"));
					product.setFlatPrice(rs.getInt("flat_price"));
					product.setFlatPriceStartDay(rs.getDate("flat_price_start_day"));
					product.setFlatPriceEndDay(rs.getDate("flat_price_end_day"));
					product.setUseYn(rs.getString("use_yn"));
					product.setProductMemo(rs.getString("product_memo"));
					product.setSaleMemo(rs.getString("sale_memo"));
					products.add(product);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return products;
	}
	
	public SiteVO getProduct(int productNo){
		SiteVO product = new SiteVO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT * FROM product where product_no = ?";
//		System.out.println("[ProductDAO][getSite] productNo = " + productNo);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, productNo);
			rs = pstmt.executeQuery();
			
			if( rs.next() ){
				do{
					product.setProductName(rs.getString("product_name"));
					product.setSiteNo(rs.getInt("site_no"));
					product.setZoneNo(rs.getInt("zone_no"));
					product.setSiteName(rs.getString("site_name"));
					product.setUsers(rs.getInt("users"));
					product.setMaxUsers(rs.getInt("max_users"));
					product.setAddChildPrice(rs.getInt("add_child_price"));
					product.setAddUserPrice(rs.getInt("add_user_price"));
					product.setLowSeasonWeekday(rs.getInt("low_season_weekday"));
					product.setLowSeasonWeekend(rs.getInt("low_season_weekend"));
					product.setLowSeasonPicnic(rs.getInt("low_season_picnic"));
					product.setMiddleSeasonWeekday(rs.getInt("middle_season_weekday"));
					product.setMiddleSeasonWeekend(rs.getInt("middle_season_weekend"));
					product.setMiddleSeasonPicnic(rs.getInt("middle_season_picnic"));
					product.setHighSeasonWeekday(rs.getInt("high_season_weekday"));
					product.setHighSeasonWeekend(rs.getInt("high_season_weekend"));
					product.setHighSeasonPicnic(rs.getInt("high_season_picnic"));
					product.setDisplayStartDay(rs.getDate("display_start_day"));
					product.setDisplayEndDay(rs.getDate("display_end_day"));
					product.setUseYn(rs.getString("use_yn"));
					product.setSale(rs.getInt("sale"));
					product.setSaleStartDay(rs.getDate("sale_start_day"));
					product.setSaleEndDay(rs.getDate("sale_end_day"));
					product.setSaleMemo(rs.getString("sale_memo"));
					product.setFlatPrice(rs.getInt("flat_price"));
					product.setFlatPriceStartDay(rs.getDate("flat_price_start_day"));
					product.setFlatPriceEndDay(rs.getDate("flat_price_end_day"));
					product.setProductMemo(rs.getString("product_memo"));
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return product;
	}
	
	// ZONE 리스트출력
	public Vector<SiteVO> selectZoneList(){
		Vector<SiteVO> zones = new Vector<SiteVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT zone_no, zone_name, order_no, use_start_day, use_end_day  FROM zone_information " +
	             "ORDER BY order_no ASC";
//				System.out.println("[ProductDAO][selectZoneList] SQL = " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();

			
			if( rs.next() ){
				do{
					SiteVO zone = new SiteVO();
					zone.setZoneNo(rs.getInt("zone_no"));
					zone.setZoneName(rs.getString("zone_name"));
					zone.setOrderNo(rs.getInt("order_no"));
					zone.setUseStartDay(rs.getDate("use_start_day"));
					zone.setUseEndDay(rs.getDate("use_end_day"));
					zones.add(zone);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return zones;
	}
	
	// SITE 리스트출력
	public Vector<SiteVO> selectSiteList(){
		Vector<SiteVO> sites = new Vector<SiteVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT zone_no, site_no, site_name  FROM site_information " +
	             "ORDER BY zone_no, site_no ASC";
//					System.out.println("[ProductDAO][selectSiteList] SQL = " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();

			
			if( rs.next() ){
				do{
					SiteVO site = new SiteVO();
					site.setZoneNo(rs.getInt("zone_no"));
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
	
	public Vector<SiteVO> selectSiteList(int zoneNo){
		Vector<SiteVO> sites = new Vector<SiteVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT zone_no, site_no, site_name  FROM site_information WHERE zone_no = ? " +
	             "ORDER BY site_no ASC";
//					System.out.println("[ProductDAO][selectSiteList] SQL = " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, zoneNo);
			rs = pstmt.executeQuery();

			
			if( rs.next() ){
				do{
					SiteVO site = new SiteVO();
					site.setZoneNo(rs.getInt("zone_no"));
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
	
	public int modifyProduct(HttpServletRequest request) throws ServletException,IOException{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		request.setCharacterEncoding("UTF-8");
		String step = request.getParameter("step");
		
		int rtn = 0;
		int productNo = 0;
		String productName = "";
		int zoneNo = 0;
		int siteNo = 0;
		String siteName = "";
		int users = 0;
		int maxUsers = 0;
		int addChildPrice = 0;
		int addUserPrice = 0;
		int lowSeasonWeekday = 0;
		int lowSeasonWeekend = 0;
		int lowSeasonPicnic = 0;
		int middleSeasonWeekday = 0;
		int middleSeasonWeekend = 0;
		int middleSeasonPicnic = 0;
		int highSeasonWeekday = 0;
		int highSeasonWeekend = 0;
		int highSeasonPicnic = 0;
		String displayStartDay = "";
		String displayEndDay = "";
		String useYn = "";
		int sale = 0;
		String saleStartDay = "";
		String saleEndDay = "";
		String saleMemo = "";
		int flatPrice = 0;
		String flatPriceStartDay = "";
		String flatPriceEndDay = "";
		String productMemo = "";
		
		String SQL = "";
		try {
			if(step == null){
				step = "new";
			}else{
				productName = request.getParameter("productName");
				zoneNo = Integer.parseInt((String)request.getParameter("zoneNo"));
				siteNo = Integer.parseInt((String)request.getParameter("siteNo"));
				siteName = request.getParameter("siteName");
				users = Integer.parseInt((String)request.getParameter("users"));
				maxUsers = Integer.parseInt((String)request.getParameter("maxUsers"));
				addChildPrice = Integer.parseInt((String)request.getParameter("addChildPrice"));
				addUserPrice = Integer.parseInt((String)request.getParameter("addUserPrice"));
				lowSeasonWeekday = Integer.parseInt((String)request.getParameter("lowSeasonWeekday"));
				lowSeasonWeekend = Integer.parseInt((String)request.getParameter("lowSeasonWeekend"));
				lowSeasonPicnic = Integer.parseInt((String)request.getParameter("lowSeasonPicnic"));
				middleSeasonWeekday = Integer.parseInt((String)request.getParameter("middleSeasonWeekday"));
				middleSeasonWeekend = Integer.parseInt((String)request.getParameter("middleSeasonWeekend"));
				middleSeasonPicnic = Integer.parseInt((String)request.getParameter("middleSeasonPicnic"));
				highSeasonWeekday = Integer.parseInt((String)request.getParameter("highSeasonWeekday"));
				highSeasonWeekend = Integer.parseInt((String)request.getParameter("highSeasonWeekend"));
				highSeasonPicnic = Integer.parseInt((String)request.getParameter("highSeasonPicnic"));
				displayStartDay = request.getParameter("displayStartDay")==""?null:request.getParameter("displayStartDay");
				displayEndDay = request.getParameter("displayEndDay")==""?null:request.getParameter("displayEndDay");
				useYn = request.getParameter("useYn");
				sale = Integer.parseInt((String)request.getParameter("sale"));
				saleStartDay = request.getParameter("saleStartDay")==""?null:request.getParameter("saleStartDay");
				saleEndDay = request.getParameter("saleEndDay")==""?null:request.getParameter("saleEndDay");
				saleMemo = request.getParameter("saleMemo");
				flatPrice = Integer.parseInt((String)request.getParameter("flatPrice"));
				flatPriceStartDay = request.getParameter("flatPriceStartDay")==""?null:request.getParameter("flatPriceStartDay");
				flatPriceEndDay = request.getParameter("flatPriceEndDay")==""?null:request.getParameter("flatPriceEndDay");
				productMemo = request.getParameter("productMemo");
			}
		
			if(step.equals("insert")){
				SQL = "INSERT INTO product (product_name,zone_no,site_no,site_name,users,max_users,add_child_price,add_user_price,"
			        + "low_season_weekday,low_season_weekend,low_season_picnic,middle_season_weekday,middle_season_weekend,middle_season_picnic,"
			        + "high_season_weekday,high_season_weekend,high_season_picnic,display_start_day,display_end_day,"
			        + "use_yn,sale,sale_start_day,sale_end_day,sale_memo,flat_price,flat_price_start_day,flat_price_end_day,product_memo) "
					+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				conn = ConnectionUtil.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, productName);
				pstmt.setInt(2, zoneNo);
				pstmt.setInt(3, siteNo);
				pstmt.setString(4, siteName);
				pstmt.setInt(5, users);
				pstmt.setInt(6, maxUsers);
				pstmt.setInt(7, addChildPrice);
				pstmt.setInt(8, addUserPrice);
				pstmt.setInt(9, lowSeasonWeekday);
				pstmt.setInt(10, lowSeasonWeekend);
				pstmt.setInt(11, lowSeasonPicnic);
				pstmt.setInt(12, middleSeasonWeekday);
				pstmt.setInt(13, middleSeasonWeekend);
				pstmt.setInt(14, middleSeasonPicnic);
				pstmt.setInt(15, highSeasonWeekday);
				pstmt.setInt(16, highSeasonWeekend);
				pstmt.setInt(17, highSeasonPicnic);
				pstmt.setString(18, displayStartDay);
				pstmt.setString(19, displayEndDay);
				pstmt.setString(20, useYn);
				pstmt.setInt(21, sale);
				pstmt.setString(22, saleStartDay);
				pstmt.setString(23, saleEndDay);
				pstmt.setString(24, saleMemo);
				pstmt.setInt(25, flatPrice);
				pstmt.setString(26, flatPriceStartDay);
				pstmt.setString(27, flatPriceEndDay);
				pstmt.setString(28, productMemo);
				
				rtn = pstmt.executeUpdate();
				
			}else if(step.equals("update")){
				productNo = Integer.parseInt((String) request.getParameter("productNo"));
				SQL = "UPDATE product SET product_name=?, zone_no=?, site_no=?, site_name=?, users=?, max_users=?,  " 
				    + "add_child_price=?, add_user_price=?, low_season_weekday=?, low_season_weekend=?, low_season_picnic=?, "
				    + "middle_season_weekday=?, middle_season_weekend=?, middle_season_picnic=?, high_season_weekday=?, high_season_weekend=?, high_season_picnic=?, "
				    + "display_start_day=?, display_end_day=?, use_yn=?, sale=?, sale_start_day=?, sale_end_day=?, sale_memo=?, flat_price=?,flat_price_start_day=?,flat_price_end_day=?, product_memo=? "
				    + "WHERE product_no = ?";
				
				conn = ConnectionUtil.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, productName);
				pstmt.setInt(2, zoneNo);
				pstmt.setInt(3, siteNo);
				pstmt.setString(4, siteName);
				pstmt.setInt(5, users);
				pstmt.setInt(6, maxUsers);
				pstmt.setInt(7, addChildPrice);
				pstmt.setInt(8, addUserPrice);
				pstmt.setInt(9, lowSeasonWeekday);
				pstmt.setInt(10, lowSeasonWeekend);
				pstmt.setInt(11, lowSeasonPicnic);
				pstmt.setInt(12, middleSeasonWeekday);
				pstmt.setInt(13, middleSeasonWeekend);
				pstmt.setInt(14, middleSeasonPicnic);
				pstmt.setInt(15, highSeasonWeekday);
				pstmt.setInt(16, highSeasonWeekend);
				pstmt.setInt(17, highSeasonPicnic);
				pstmt.setString(18, displayStartDay);
				pstmt.setString(19, displayEndDay);
				pstmt.setString(20, useYn);
				pstmt.setInt(21, sale);
				pstmt.setString(22, saleStartDay);
				pstmt.setString(23, saleEndDay);
				pstmt.setString(24, saleMemo);
				pstmt.setInt(25, flatPrice);
				pstmt.setString(26, flatPriceStartDay);
				pstmt.setString(27, flatPriceEndDay);
				pstmt.setString(28, productMemo);
				pstmt.setInt(29, productNo);
				
				rtn = pstmt.executeUpdate();
				
			}
//			System.out.println(rtn);
//			if(rtn == 0){
//				productNo = 0;
//			}
		} catch(Exception ex) {
	        ex.printStackTrace();
	    } finally {
	    	close(rs,pstmt,conn);
	    }
		
		return rtn;
	}
	
	public int deleteProduct(int siteNo) throws Exception {
	    int x=0;
	    Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
	    try {
			conn = ConnectionUtil.getConnection();
	        pstmt = conn.prepareStatement("delete from product where product_no=?");
	        pstmt.setInt(1, siteNo);
	        x = pstmt.executeUpdate();
	    } catch(Exception ex) {
	        ex.printStackTrace();
	    } finally {
	    	close(rs,pstmt,conn);
	    }
		return x;
	}
	
	// Product 이름출력
	public String selectProductList(String productNos){
		String productNames = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT product_name FROM product WHERE product_no IN (" + productNos +")";
//		System.out.println("[ProductDAO][selectProductList] SQL = " + SQL);
		
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();

			int rCnt = 0;
			if( rs.next() ){
				do{
					productNames = productNames + ", " + rs.getString("product_name");
					rCnt++;
				}while(rs.next());
				
				productNames = "[ 선택한 상품수 : " + rCnt + " ]" + productNames;
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return productNames;
	}
	
	public int modifyProducts(HttpServletRequest request) throws ServletException,IOException{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		request.setCharacterEncoding("UTF-8");
		String step = request.getParameter("step");
		
		int rtn = 0;
		String productNos = "";
		int users = 0;
		int maxUsers = 0;
		int addChildPrice = 0;
		int addUserPrice = 0;
		int lowSeasonWeekday = 0;
		int lowSeasonWeekend = 0;
		int lowSeasonPicnic = 0;
		int middleSeasonWeekday = 0;
		int middleSeasonWeekend = 0;
		int middleSeasonPicnic = 0;
		int highSeasonWeekday = 0;
		int highSeasonWeekend = 0;
		int highSeasonPicnic = 0;
		String displayStartDay = "";
		String displayEndDay = "";
		String useYn = "";
		int sale = 0;
		String saleStartDay = "";
		String saleEndDay = "";
		String saleMemo = "";
		int flatPrice = 0;
		String flatPriceStartDay = "";
		String flatPriceEndDay = "";
		String productMemo = "";
		
		String SQL = "";
		try {
			if(step == null){
				step = "select";
			}else{
				productNos = (String)request.getParameter("productNos");
				users = Integer.parseInt((String)request.getParameter("users"));
				maxUsers = Integer.parseInt((String)request.getParameter("maxUsers"));
				addChildPrice = Integer.parseInt((String)request.getParameter("addChildPrice"));
				addUserPrice = Integer.parseInt((String)request.getParameter("addUserPrice"));
				lowSeasonWeekday = Integer.parseInt((String)request.getParameter("lowSeasonWeekday"));
				lowSeasonWeekend = Integer.parseInt((String)request.getParameter("lowSeasonWeekend"));
				lowSeasonPicnic = Integer.parseInt((String)request.getParameter("lowSeasonPicnic"));
				middleSeasonWeekday = Integer.parseInt((String)request.getParameter("middleSeasonWeekday"));
				middleSeasonWeekend = Integer.parseInt((String)request.getParameter("middleSeasonWeekend"));
				middleSeasonPicnic = Integer.parseInt((String)request.getParameter("middleSeasonPicnic"));
				highSeasonWeekday = Integer.parseInt((String)request.getParameter("highSeasonWeekday"));
				highSeasonWeekend = Integer.parseInt((String)request.getParameter("highSeasonWeekend"));
				highSeasonPicnic = Integer.parseInt((String)request.getParameter("highSeasonPicnic"));
				displayStartDay = request.getParameter("displayStartDay")==""?null:request.getParameter("displayStartDay");
				displayEndDay = request.getParameter("displayEndDay")==""?null:request.getParameter("displayEndDay");
				useYn = request.getParameter("useYn");
				sale = Integer.parseInt((String)request.getParameter("sale"));
				saleStartDay = request.getParameter("saleStartDay")==""?null:request.getParameter("saleStartDay");
				saleEndDay = request.getParameter("saleEndDay")==""?null:request.getParameter("saleEndDay");
				saleMemo = request.getParameter("saleMemo");
				flatPrice = Integer.parseInt((String)request.getParameter("flatPrice"));
				flatPriceStartDay = request.getParameter("flatPriceStartDay")==""?null:request.getParameter("flatPriceStartDay");
				flatPriceEndDay = request.getParameter("flatPriceEndDay")==""?null:request.getParameter("flatPriceEndDay");
				productMemo = request.getParameter("productMemo");
			}
		
			if(step.equals("update")){
				SQL = "UPDATE product SET users=?, max_users=?, add_child_price=?, add_user_price=?, " 
				    + "low_season_weekday=?, low_season_weekend=?, low_season_picnic=?, "
				    + "middle_season_weekday=?, middle_season_weekend=?, middle_season_picnic=?, "
				    + "high_season_weekday=?, high_season_weekend=?, high_season_picnic=?, "
				    + "display_start_day=?, display_end_day=?, use_yn=?, "
				    + "sale=?, sale_start_day=?, sale_end_day=?, sale_memo=?, "
				    + "flat_price=?,flat_price_start_day=?,flat_price_end_day=?, product_memo=? "
				    + "WHERE product_no IN ("+ productNos +")";
				
//				System.out.println("[ProductDAO][modifyProducts] SQL = " + SQL);
				
				conn = ConnectionUtil.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, users);
				pstmt.setInt(2, maxUsers);
				pstmt.setInt(3, addChildPrice);
				pstmt.setInt(4, addUserPrice);
				pstmt.setInt(5, lowSeasonWeekday);
				pstmt.setInt(6, lowSeasonWeekend);
				pstmt.setInt(7, lowSeasonPicnic);
				pstmt.setInt(8, middleSeasonWeekday);
				pstmt.setInt(9, middleSeasonWeekend);
				pstmt.setInt(10, middleSeasonPicnic);
				pstmt.setInt(11, highSeasonWeekday);
				pstmt.setInt(12, highSeasonWeekend);
				pstmt.setInt(13, highSeasonPicnic);
				pstmt.setString(14, displayStartDay);
				pstmt.setString(15, displayEndDay);
				pstmt.setString(16, useYn);
				pstmt.setInt(17, sale);
				pstmt.setString(18, saleStartDay);
				pstmt.setString(19, saleEndDay);
				pstmt.setString(20, saleMemo);
				pstmt.setInt(21, flatPrice);
				pstmt.setString(22, flatPriceStartDay);
				pstmt.setString(23, flatPriceEndDay);
				pstmt.setString(24, productMemo);
				
				rtn = pstmt.executeUpdate();
				
			}
//			System.out.println("[ProductDAO][modifyProducts] rtn = " + rtn);
		} catch(Exception ex) {
	        ex.printStackTrace();
	    } finally {
	    	close(rs,pstmt,conn);
	    }
		
		return rtn;
	}

}
