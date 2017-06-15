package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import util.ConnectionUtil;

public class MemberDAO {
	
	// DB연결객체 Close
	private void close(ResultSet rs,PreparedStatement pstmt,Connection conn){
		if(rs != null) try{ rs.close(); }catch(SQLException e){}finally{ rs = null; }
		if(pstmt != null) try{ pstmt.close(); }catch(SQLException e){}finally{ pstmt = null; }
		if(conn != null) try{ conn.close(); }catch(SQLException e){}finally{ conn = null; }
	}
	
	private static MemberDAO instance = new MemberDAO();
	
	public MemberDAO(){}
	
	// 객체 리턴
	public static MemberDAO getInstance(){
		return instance;
	}
	
	public int userCheck(String id, String passwd){
		int check = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT id, grade FROM member WHERE id = ? AND password = ? ";
		
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			rs = pstmt.executeQuery();
//			System.out.println("SQL = " + SQL);
//			System.out.println("id, pw : " +id+", "+passwd);
			if( rs.next() ){
				String grade = rs.getString("grade");
				if(!grade.equals("A")){
					check = 1;
				}
			}else{
				check = 2;
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
//		System.out.println("check =" +check);
		return check;
	}
	
	public MemberVO getMemberForGrade(String grade){
		MemberVO member = new MemberVO();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT id, name, password, grade, cell1, cell2, cell3 FROM member WHERE grade = ? ";
		
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, grade);
			rs = pstmt.executeQuery();
//			System.out.println("SQL = " + SQL);

			if( rs.next() ){
				member.setId(rs.getString("id"));
				member.setName(rs.getString("name"));
				member.setPassword(rs.getString("password"));
				member.setGrade(rs.getString("grade"));
				member.setCell1(rs.getString("cell1"));
				member.setCell2(rs.getString("cell2"));
				member.setCell3(rs.getString("cell3"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		return member;
	}
	
	public Vector<MemberVO> selectMemberList(){
		Vector<MemberVO> vMember = new Vector<MemberVO>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "SELECT id, name, password, grade, cell1, cell2, cell3, email, recv_yn FROM member WHERE grade <> 'A' ";
		
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
//			System.out.println("SQL = " + SQL);

			if( rs.next() ){
				do{
					MemberVO member = new MemberVO();
					member.setId(rs.getString("id"));
					member.setName(rs.getString("name"));
					member.setPassword(rs.getString("password"));
					member.setGrade(rs.getString("grade"));
					member.setCell1(rs.getString("cell1"));
					member.setCell2(rs.getString("cell2"));
					member.setCell3(rs.getString("cell3"));
					member.setEmail(rs.getString("email"));
					member.setRecvYn(rs.getString("recv_yn"));
					vMember.add(member);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}

		return vMember;
	}

}
