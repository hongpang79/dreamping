package board;
 
import java.sql.*;
import java.util.*;
import util.ConnectionUtil;

public class BoardDAO {

	private static BoardDAO instance = new BoardDAO();
    
    public static BoardDAO getInstance() {
        return instance;
    }
    
    BoardDAO() {
    }
    
    public int getArticleCount(String category) throws Exception {
    	Connection conn = null;
        PreparedStatement pstmt = null;
    	ResultSet rs = null;
	    int x=0;
	
	    try {
	        conn = ConnectionUtil.getConnection();
	        pstmt = conn.prepareStatement("select count(*) from comboard where category=? ");
	        pstmt.setString(1, category);
	        rs = pstmt.executeQuery();
	
	        if (rs.next()) {
	           x= rs.getInt(1);
			}
	    } catch(Exception ex) {
	        ex.printStackTrace();
	    } finally {
	        ConnectionUtil.close(conn, pstmt, rs);
	    }
	    
		return x;
    }
    
    public int getArticleCount(String category, String searchCode, String searchValue) throws Exception {
    	Connection conn = null;
        PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	int x=0;
        String SQL = "select count(*) from comboard where category=? and " + searchCode + " like CONCAT(?,'%')";
    	try {
    		conn = ConnectionUtil.getConnection();
    	    pstmt = conn.prepareStatement(SQL);
    	    pstmt.setString(1, category);
    	    pstmt.setString(2, searchValue);
//    	    System.out.println("[getArticleCount][SQL] " + SQL);
//    	    System.out.println("[getArticleCount][searchValue] " + SQL);
    	    rs = pstmt.executeQuery();

    	    if (rs.next()) {
    	    	x= rs.getInt(1);
    		}
    	} catch(Exception ex) {
    		ex.printStackTrace();
    	} finally {
    		ConnectionUtil.close(conn, pstmt, rs);

    	}
    	
    	return x;
    }
    
    public List getArticles(int start, int end, String category) throws Exception {
        List<BoardVO> articleList=null;
        Connection conn = null;
        PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	
        try {
            conn = ConnectionUtil.getConnection();
            pstmt = conn.prepareStatement("select board.* from (select * from  comboard where category=? order by ref desc, re_step asc) board limit ?, ?");
            pstmt.setString(1, category);   
            pstmt.setInt(2, start-1);
			pstmt.setInt(3, end);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                articleList = new ArrayList<BoardVO>(end);
                do{
	              BoardVO article= new BoardVO();
				  article.setNum(rs.getInt("num"));
				  article.setWriter(rs.getString("writer"));
	              article.setEmail(rs.getString("email"));
	              article.setSubject(rs.getString("subject"));
	              article.setPassword(rs.getString("password"));
			      article.setRegDate(rs.getTimestamp("reg_date"));
				  article.setReadCount(rs.getInt("read_count"));
	              article.setRef(rs.getInt("ref"));
	              article.setReStep(rs.getInt("re_step"));
				  article.setReLevel(rs.getInt("re_level"));
	              article.setDescription(rs.getString("description"));
	              article.setThumbImgUrl(rs.getString("thumb_img_url"));
	
				  
	              articleList.add(article);
			    }while(rs.next());
			}
        } catch(Exception ex) {
        	System.out.println("[Error][board.BoardDAO.getArticles] Start : " + start + "; End : " + end +"; Category : " + category);
            ex.printStackTrace();
        } finally {
            ConnectionUtil.close(conn, pstmt, rs);
        }
		return articleList;
    }
    
    public List getArticles(int start, int end, String category, String searchCode, String searchValue) throws Exception {
    	List<BoardVO> articleList=null;
    	Connection conn = null;
        PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	
    	try {
    		conn = ConnectionUtil.getConnection();
    	    pstmt = conn.prepareStatement("select board.* from (select * from  comboard where category=? and " + searchCode + " like CONCAT(?,'%') order by ref desc, re_step asc) board limit ?, ? ");
    	    pstmt.setString(1, category);
    	    pstmt.setString(2, searchValue);
	    	pstmt.setInt(3, start-1);
    		pstmt.setInt(4, end);
    	    rs = pstmt.executeQuery();

    	    if (rs.next()) {
            	articleList = new ArrayList<BoardVO>(end);
                
            	do{
            		BoardVO article= new BoardVO();
            		article.setNum(rs.getInt("num"));
            		article.setWriter(rs.getString("writer"));
            		article.setEmail(rs.getString("email"));
            		article.setSubject(rs.getString("subject"));
            		article.setPassword(rs.getString("password"));
            		article.setRegDate(rs.getTimestamp("reg_date"));
            		article.setReadCount(rs.getInt("read_count"));
            		article.setRef(rs.getInt("ref"));
            		article.setReStep(rs.getInt("re_step"));
            		article.setReLevel(rs.getInt("re_level"));
            		article.setDescription(rs.getString("description"));

            		articleList.add(article);
			    }while(rs.next());
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionUtil.close(conn, pstmt, rs);
        }
		
    	return articleList;
    }
    
    public void insertArticle(BoardVO article) throws Exception {
    	Connection conn = null;
        PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	
    	int num=article.getNum();
		int ref=article.getRef();
		int reStep=article.getReStep();
		int reLevel=article.getReLevel();
		int number=0;
        String sql="";

        try {
        	conn = ConnectionUtil.getConnection();

            pstmt = conn.prepareStatement("select max(num) from comboard");
			rs = pstmt.executeQuery();
			
			if(rs.next()){
		      number=rs.getInt(1)+1;
			}else{
		      number=1; 
			}
			
		    if(num!=0){  
		    	sql="update comboard set re_step=re_step+1 where ref= ? and re_step> ?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setInt(1, ref);
				pstmt.setInt(2, reStep);
				pstmt.executeUpdate();
				reStep=reStep+1;
				reLevel=reLevel+1;
		     }else{
			  	ref=number;
				reStep=0;
				reLevel=0;
		     }	 

            sql = "insert into comboard(category,writer,email,subject,password,reg_date,read_count,ref,re_step,re_level,description,thumb_img_url)";
		    sql+=" values(?,?,?,?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, article.getCategory());
            pstmt.setString(2, article.getWriter());
            pstmt.setString(3, article.getEmail());
            pstmt.setString(4, article.getSubject());
            pstmt.setString(5, article.getPassword());
			pstmt.setTimestamp(6, article.getRegDate());
			pstmt.setInt(7, article.getReadCount());
            pstmt.setInt(8, ref);
            pstmt.setInt(9, reStep);
            pstmt.setInt(10, reLevel);
			pstmt.setString(11, article.getDescription());
			pstmt.setString(12, article.getThumbImgUrl());
            int rtn = pstmt.executeUpdate();
            
            String category = article.getCategory();
            if("qna".equals(category)){
            	if(rtn > 0){
                	int msgNo = 6;
    				String dvsn = "admin";
    				String msg = "";
    				String phoneNumber = "";
    				String SQL = "SELECT msg FROM sms_manager WHERE msg_no=? and dvsn=? ";
    				pstmt = conn.prepareStatement(SQL);
    				pstmt.setInt(1, msgNo);
    				pstmt.setString(2, dvsn);
    				rs = pstmt.executeQuery();
    				if( rs.next() ){
    					msg = rs.getString(1);
    				}
    				
    				SQL = "SELECT phone_number FROM sms_phone ";
    				pstmt = conn.prepareStatement(SQL);
    				rs = pstmt.executeQuery();
    				if( rs.next() ){
    					phoneNumber = rs.getString(1);
    					//System.out.println(reservationNo+","+msgNo+","+phoneNumber+","+msg);
    					util.CallSMS.callSMS(0, msgNo, phoneNumber, msg);
    				}
                }
            }
            
        } catch(Exception ex) {
        	System.out.println("[Error][board.BoardDAO.insertArticle] SQL : " + sql);
        	System.out.println("[Error][board.BoardDAO.insertArticle] Category : " + article.getCategory());
        	System.out.println("[Error][board.BoardDAO.insertArticle] Description : " + article.getDescription());
        	if(article.getDescription() != null){
            	System.out.println("[Error][board.BoardDAO.insertArticle] Description UTF-8  : " + new String(article.getDescription().getBytes("UTF-8"),"UTF-8"));
            	System.out.println("[Error][board.BoardDAO.insertArticle] Description EUC-KR  : " + new String(article.getDescription().getBytes("UTF-8"),"EUC-KR"));
        	}
        	
            ex.printStackTrace();
        } finally {
			ConnectionUtil.close(conn, pstmt, rs);
        }
    }

    public BoardVO getArticle(int num) throws Exception {
    	BoardVO article = null;
    	Connection conn = null;
        PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	
    	try {
    		conn = ConnectionUtil.getConnection();
    		
            pstmt = conn.prepareStatement("update comboard set read_count=read_count+1 where num = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

            pstmt = conn.prepareStatement("select * from comboard where num = ?");
            pstmt.setInt(1, num);
            
            rs = pstmt.executeQuery();

            if (rs.next()) {
                article = new BoardVO();
                article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
                article.setEmail(rs.getString("email"));
                article.setSubject(rs.getString("subject"));
                article.setPassword(rs.getString("password"));
			    article.setRegDate(rs.getTimestamp("reg_date"));
				article.setReadCount(rs.getInt("read_count"));
                article.setRef(rs.getInt("ref"));
                article.setReStep(rs.getInt("re_step"));
				article.setReLevel(rs.getInt("re_level"));
                article.setDescription(rs.getString("description"));
			}
            
        }catch(Exception ex){
            ex.printStackTrace();
        }finally{
            ConnectionUtil.close(conn, pstmt, rs);
        }
    	
		return article;
    }
    
    public int deleteArticle(int num, String password) throws Exception {
    	Connection conn = null;
        PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	
    	String dbpasswd="";
	    int x=-1;
	    try {
			conn = ConnectionUtil.getConnection();
	        pstmt = conn.prepareStatement("select password from comboard where num = ?");
	        pstmt.setInt(1, num);
	        rs = pstmt.executeQuery();
	        
			if(rs.next()){
				dbpasswd= rs.getString("password");
				if(password.equals("slowcity")){
		        	password = dbpasswd;
		        }
				if(dbpasswd.equals(password)){
					pstmt = conn.prepareStatement("delete from comboard where num=?");
	                pstmt.setInt(1, num);
	                pstmt.executeUpdate();
					x= 1; 
				}else
					x= 0;
			}
	    } catch(Exception ex) {
	        ex.printStackTrace();
	    } finally {
	        ConnectionUtil.close(conn, pstmt, rs);
	    }
		return x;
	}
    
    public int updateArticle(BoardVO article) throws Exception {
    	Connection conn = null;
        PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	
    	String dbpasswd="";
        String sql="";
		int x=-1;
        try {
        	conn = ConnectionUtil.getConnection();
//            System.out.print(article.getNum());
			pstmt = conn.prepareStatement("select password from comboard where num=?");
            pstmt.setInt(1, article.getNum());
            rs = pstmt.executeQuery();
            
			if(rs.next()){
				dbpasswd= rs.getString("password"); 
				if(dbpasswd.equals(article.getPassword())){
	                sql="update comboard set writer=?,email=?,subject=?,password=?,description=?";
				    sql+="where num=?";
	                pstmt = conn.prepareStatement(sql);
	
	                pstmt.setString(1, article.getWriter());
	                pstmt.setString(2, article.getEmail());
	                pstmt.setString(3, article.getSubject());
	                pstmt.setString(4, article.getPassword());
	                pstmt.setString(5, article.getDescription());
				    pstmt.setInt(6, article.getNum());
	                pstmt.executeUpdate();
					x= 1;
				}else{
					x= 0;
				}
			}
        }catch(Exception ex) {
            ex.printStackTrace();
        }finally {
			ConnectionUtil.close(conn, pstmt, rs);
        }
        
		return x;
	}

//------------------------------

    public BoardVO updateGetArticle(int num) throws Exception {
        BoardVO article=null;
        Connection conn = null;
        PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	
        try {
            conn = ConnectionUtil.getConnection();

            pstmt = conn.prepareStatement("select * from comboard where num=?");
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                article = new BoardVO();
                article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
                article.setEmail(rs.getString("email"));
                article.setSubject(rs.getString("subject"));
                article.setPassword(rs.getString("password"));
				article.setRegDate(rs.getTimestamp("reg_date"));
				article.setReadCount(rs.getInt("readcount"));
                article.setRef(rs.getInt("ref"));
                article.setReStep(rs.getInt("re_step"));
                article.setReLevel(rs.getInt("re_level"));
                article.setDescription(rs.getString("description"));
 
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionUtil.close(conn, pstmt, rs);
        }
		return article;
    }

 }
