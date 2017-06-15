package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import util.ConnectionUtil;

public class MainDAO {

	// DB연결객체 Close
	private void close(ResultSet rs,PreparedStatement pstmt,Connection conn){
		if(rs != null) try{ rs.close(); }catch(SQLException e){}finally{ rs = null; }
		if(pstmt != null) try{ pstmt.close(); }catch(SQLException e){}finally{ pstmt = null; }
		if(conn != null) try{ conn.close(); }catch(SQLException e){}finally{ conn = null; }
	}
	
	private static MainDAO instance = new MainDAO();
	
	public MainDAO(){}
	
	// 객체 리턴
	public static MainDAO getInstance(){
		return instance;
	}
	
	public Vector<MainBoardVO> selectMainBannerList(){
		Vector<MainBoardVO> banners = new Vector<MainBoardVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT z.*, s.subject as board_subject FROM siteboard z, comboard s where z.board_no = s.num " +
	             "ORDER BY z.num ASC";
//			System.out.println("[MainDAO][selectMainBannerList] SQL = " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();

			
			if( rs.next() ){
				do{
					MainBoardVO banner = new MainBoardVO();
					banner.setNum(rs.getInt("num"));
					banner.setCategory(rs.getString("category"));
					banner.setSubject(rs.getString("subject"));
					banner.setImgUrl(rs.getString("img_url"));
					banner.setBoardNo(rs.getInt("board_no"));
					banner.setBoardSubject(rs.getString("board_subject"));
					banner.setDisplayStartDay(rs.getTimestamp("display_start_day"));
					banner.setDisplayEndDay(rs.getTimestamp("display_end_day"));
					banner.setUseYn(rs.getString("use_yn"));
					banners.add(banner);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return banners;
	}
	
	public Vector<MainBoardVO> selectMainBannerShow(){
		Vector<MainBoardVO> banners = new Vector<MainBoardVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT z.*, s.subject as board_subject FROM siteboard z, comboard s where z.board_no = s.num " +
	             "and z.use_yn='Y' ORDER BY z.num ASC";
//			System.out.println("[MainDAO][selectMainBannerShow] SQL = " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();

			
			if( rs.next() ){
				do{
					MainBoardVO banner = new MainBoardVO();
					banner.setNum(rs.getInt("num"));
					banner.setCategory(rs.getString("category"));
					banner.setSubject(rs.getString("subject"));
					banner.setImgUrl(rs.getString("img_url"));
					banner.setBoardNo(rs.getInt("board_no"));
					banner.setBoardSubject(rs.getString("board_subject"));
					banner.setDisplayStartDay(rs.getTimestamp("display_start_day"));
					banner.setDisplayEndDay(rs.getTimestamp("display_end_day"));
					banner.setUseYn(rs.getString("use_yn"));
					banners.add(banner);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return banners;
	}
	
	public MainBoardVO getBanner(int num){
		MainBoardVO banner = new MainBoardVO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT z.*, s.subject as board_subject FROM siteboard z, comboard s where category='banner' and z.board_no = s.num " +
	             "and z.num = " + num;
//			System.out.println("[MainDAO][getBanner] SQL = " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();

			
			if( rs.next() ){
				banner.setNum(rs.getInt("num"));
				banner.setCategory(rs.getString("category"));
				banner.setSubject(rs.getString("subject"));
				banner.setImgUrl(rs.getString("img_url"));
				banner.setBoardNo(rs.getInt("board_no"));
				banner.setBoardSubject(rs.getString("board_subject"));
				banner.setDisplayStartDay(rs.getTimestamp("display_start_day"));
				banner.setDisplayEndDay(rs.getTimestamp("display_end_day"));
				banner.setUseYn(rs.getString("use_yn"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return banner;
	}
	
	public void insertArticle(MainBoardVO article) throws Exception {
    	Connection conn = null;
        PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	
		int number=0;
        String sql="";

        try {
        	conn = ConnectionUtil.getConnection();

            pstmt = conn.prepareStatement("select max(num) from siteboard");
			rs = pstmt.executeQuery();
			
			if(rs.next()){
		      number=rs.getInt(1)+1;
			}else{
		      number=1; 
			}
			System.out.println("[MainDAO][insertArticle] number = " + number);
			
            sql = "insert into siteboard(category,zone_no,subject,img_url,board_no,use_yn)";
		    sql+=" values(?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, article.getCategory());
            pstmt.setString(2, article.getZoneNo());
            pstmt.setString(3, article.getSubject());
            pstmt.setString(4, article.getImgUrl());
            pstmt.setInt(5, article.getBoardNo());
//			pstmt.setDate(6, (Date) article.getDisplayStartDay());
//			pstmt.setDate(7, (Date) article.getDisplayEndDay());
            pstmt.setString(6, article.getUseYn());
            int rtn = pstmt.executeUpdate();
            
            System.out.println("[MainDAO][insertArticle] rtn = " + rtn);
        } catch(Exception ex) {        	
            ex.printStackTrace();
        } finally {
			ConnectionUtil.close(conn, pstmt, rs);
        }
    }
	
	public String processBanner(HttpServletRequest request){
		String msg = "";
		int rtn = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "";
		String step = request.getParameter("step");
		System.out.println("[MainDAO][processBanner] step = " + step);
		
		try{
			conn = ConnectionUtil.getConnection();
			int bannerNo = Integer.parseInt((String) request.getParameter("bannerNo"));
			System.out.println("[MainDAO][processBanner] bannerNo = " + bannerNo);
			if(step.equals("modify")){
				String useYn = request.getParameter("useYn");
				System.out.println("[MainDAO][processBanner] useYn = " + useYn);
				SQL = "UPDATE siteboard SET use_yn=? WHERE num = ? ";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, useYn);
				pstmt.setInt(2, bannerNo);
								
				msg = "변경되었습니다.";
			
			}else if(step.equals("delete")){
				SQL = "DELETE FROM siteboard WHERE num=?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, bannerNo);
				
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
	
	public MainBoardVO getContent(String category){
		
		String SQL = "SELECT * FROM siteboard where category='" + category +"'";
		
		MainBoardVO board = selectContent(SQL);
		
		return board;
	}
	
	public MainBoardVO getContent(String category, String zoneNo){
		
		String SQL = "SELECT * FROM siteboard where category='" + category +"' and zone_no='"+zoneNo+"'";
		
		MainBoardVO board = selectContent(SQL);
		
		return board;
	}
	
	public MainBoardVO getContent(int num){
		
		String SQL = "SELECT * FROM siteboard where num = " + num;
		
		MainBoardVO board = selectContent(SQL);
				
		return board;
	}
	
	public MainBoardVO selectContent(String SQL){
		MainBoardVO board = new MainBoardVO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
				
//			System.out.println("[MainDAO][getContents] SQL = " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if( rs.next() ){
				board.setNum(rs.getInt("num"));
				board.setCategory(rs.getString("category"));
				board.setZoneNo(rs.getString("zone_no"));
				board.setSubject(rs.getString("subject"));
				board.setImgUrl(rs.getString("img_url"));
				board.setBoardNo(rs.getInt("board_no"));
				board.setSubject(rs.getString("subject"));
				board.setDisplayStartDay(rs.getTimestamp("display_start_day"));
				board.setDisplayEndDay(rs.getTimestamp("display_end_day"));
				board.setUseYn(rs.getString("use_yn"));
				board.setContents(rs.getString("contents"));
				
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return board;
	}
	
	public int insertContent(MainBoardVO article) throws Exception {
    	Connection conn = null;
        PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	
    	int rtn = 0;
    	
		int number=0;
        String sql="";

        try {
        	conn = ConnectionUtil.getConnection();

            pstmt = conn.prepareStatement("select max(num) from siteboard");
			rs = pstmt.executeQuery();
			
			if(rs.next()){
		      number=rs.getInt(1)+1;
			}else{
		      number=1; 
			}
//			System.out.println("[MainDAO][insertContent] number = " + number);
			
            sql = "insert into siteboard(category,zone_no,subject,img_url,board_no,display_start_day,display_end_day,use_yn,contents)";
		    sql+=" values(?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, article.getCategory());
            pstmt.setString(2, article.getZoneNo());
            pstmt.setString(3, article.getSubject());
            pstmt.setString(4, article.getImgUrl());
            pstmt.setInt(5, article.getBoardNo());
			pstmt.setTimestamp(6, article.getDisplayStartDay());
			pstmt.setTimestamp(7, article.getDisplayEndDay());
            pstmt.setString(8, article.getUseYn());
            pstmt.setString(9, article.getContents());
            rtn = pstmt.executeUpdate();
            
//            System.out.println("[MainDAO][insertContent] rtn = " + rtn);
        } catch(Exception ex) {        	
            ex.printStackTrace();
        } finally {
			ConnectionUtil.close(conn, pstmt, rs);
        }
        return rtn;
    }
	
	public int updateContent(MainBoardVO article) throws Exception {
    	Connection conn = null;
        PreparedStatement pstmt = null;
    	
    	int rtn = 0;
		String sql="";

        try {
        	conn = ConnectionUtil.getConnection();

            sql = "UPDATE siteboard " +
            		" SET category=?,zone_no=?,subject=?,img_url=?,board_no=?,display_start_day=?,display_end_day=?,use_yn=?,contents=? " +
            	  " WHERE num = ? ";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, article.getCategory());
            pstmt.setString(2, article.getZoneNo());
            pstmt.setString(3, article.getSubject());
            pstmt.setString(4, article.getImgUrl());
            pstmt.setInt(5, article.getBoardNo());
            pstmt.setTimestamp(6, article.getDisplayStartDay());
			pstmt.setTimestamp(7, article.getDisplayEndDay());
            pstmt.setString(8, article.getUseYn());
            pstmt.setString(9, article.getContents());
            pstmt.setInt(10, article.getNum());
            rtn = pstmt.executeUpdate();
            
//            System.out.println("[MainDAO][updateContent] rtn = " + rtn);
        } catch(Exception ex) {        	
            ex.printStackTrace();
        } finally {
			ConnectionUtil.close(conn, pstmt);
        }
        return rtn;
    }
	
	public Vector<MainBoardVO> selectContentList(String category){
		Vector<MainBoardVO> contents = new Vector<MainBoardVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT * FROM siteboard where category = '" +category+"' ORDER BY zone_no, board_no ASC";
//			System.out.println("[MainDAO][selectContentList] SQL = " + SQL);
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if( rs.next() ){
				do{
					MainBoardVO content = new MainBoardVO();
					content.setNum(rs.getInt("num"));
					content.setCategory(rs.getString("category"));
					content.setZoneNo(rs.getString("zone_no"));
					content.setSubject(rs.getString("subject"));
					content.setImgUrl(rs.getString("img_url"));
					content.setBoardNo(rs.getInt("board_no"));
					content.setDisplayStartDay(rs.getTimestamp("display_start_day"));
					content.setDisplayEndDay(rs.getTimestamp("display_end_day"));
					content.setUseYn(rs.getString("use_yn"));
					contents.add(content);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return contents;
	}

}
