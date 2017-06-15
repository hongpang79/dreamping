package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import util.ConnectionUtil;
/**
 * SMS연동 페이지 주소
 * http://www.sendgo.co.kr/
 * @author hongpang79
 *
 */
public class StatisticsDAO {
	
	// DB연결객체 Close
	private void close(ResultSet rs,PreparedStatement pstmt,Connection conn){
		if(rs != null) try{ rs.close(); }catch(SQLException e){}finally{ rs = null; }
		if(pstmt != null) try{ pstmt.close(); }catch(SQLException e){}finally{ pstmt = null; }
		if(conn != null) try{ conn.close(); }catch(SQLException e){}finally{ conn = null; }
	}
	
	private static StatisticsDAO instance = new StatisticsDAO();
	
	public StatisticsDAO(){}
	
	// 객체 리턴
	public static StatisticsDAO getInstance(){
		return instance;
	}
	
	public StatisticsVO selectMainStatisticsCnt(String today){
		StatisticsVO statistics = new StatisticsVO();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "select pay_status, count(*) AS cnt from reservation WHERE reg_date >= DATE_FORMAT(?,'%Y-%m-%d') GROUP BY pay_status";
		
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, today);
			
			rs = pstmt.executeQuery();
			
			statistics.setRsvtCompCnt(0);	//예약완료
			statistics.setRsvtWaitCnt(0);	//예약대기
			statistics.setRsvtRefdReqCnt(0);	//환불신청
			statistics.setRsvtRefdCompCnt(0);//환불완료
			if( rs.next() ){
				do{
					if("Y".equals(rs.getString("pay_status"))){ 		//예약완료
						statistics.setRsvtCompCnt(rs.getInt("cnt"));
					}else if("N".equals(rs.getString("pay_status"))){	//예약대기
						statistics.setRsvtWaitCnt(rs.getInt("cnt"));
					}else if("C".equals(rs.getString("pay_status"))){	//환불신청
						statistics.setRsvtRefdReqCnt(rs.getInt("cnt"));	
					}else if("F".equals(rs.getString("pay_status"))){	//환불완료
						statistics.setRsvtRefdCompCnt(rs.getInt("cnt"));
					}
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		
		return statistics;
	}
	
	public Vector<StatisticsVO> selectStatisticsForPeriod(String startDay, String endDay){
		Vector<StatisticsVO> statistics = new Vector<StatisticsVO>();
				
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "select z.reservation_date as reservation_day, COALESCE(z.price,0) as sum_amount, COALESCE(c.price,0) as cancel_amount, COALESCE(y.price,0) as billing_amount, COALESCE(f.price,0) as refund_amount, COALESCE(y.price,0) - COALESCE(f.price,0) as net_amount "
				   + "from (select reservation_date, sum(price) price from reservation where reservation_date between DATE_FORMAT(?,'%Y-%m-%d') and DATE_FORMAT(?,'%Y-%m-%d') group by reservation_date) z "
				   + "LEFT OUTER JOIN (select reservation_date, sum(price) price from reservation where reservation_date between DATE_FORMAT(?,'%Y-%m-%d') and DATE_FORMAT(?,'%Y-%m-%d') and pay_status in ('F','C')  group by reservation_date) c on z.reservation_date = c.reservation_date "
				   + "LEFT OUTER JOIN (select reservation_date, sum(price) price from reservation where reservation_date between DATE_FORMAT(?,'%Y-%m-%d') and DATE_FORMAT(?,'%Y-%m-%d') and pay_status in ('Y','C','F')  group by reservation_date) y on z.reservation_date = y.reservation_date "
				   + "LEFT OUTER JOIN (select reservation_date, sum(refund_price) price from reservation where reservation_date between DATE_FORMAT(?,'%Y-%m-%d') and DATE_FORMAT(?,'%Y-%m-%d') and pay_status = 'F'  group by reservation_date) f on z.reservation_date = f.reservation_date "
				   + "order by reservation_day ";
		
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, startDay);
			pstmt.setString(2, endDay);
			pstmt.setString(3, startDay);
			pstmt.setString(4, endDay);
			pstmt.setString(5, startDay);
			pstmt.setString(6, endDay);
			pstmt.setString(7, startDay);
			pstmt.setString(8, endDay);

			rs = pstmt.executeQuery();
			
			if( rs.next() ){
				do{
					StatisticsVO statistic = new StatisticsVO();
					statistic.setReservationDay(rs.getDate("reservation_day"));
					statistic.setSumAmount(rs.getInt("sum_amount"));
					statistic.setCancelAmount(rs.getInt("cancel_amount"));
					statistic.setBillingAmount(rs.getInt("billing_amount"));
					statistic.setRefundAmount(rs.getInt("refund_amount"));
					statistic.setNetAmount(rs.getInt("net_amount"));
					statistics.add(statistic);
				}while(rs.next());
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		
		return statistics;
	}
	
	public StatisticsVO selectStatisticsForPeriodSum(String startDay, String endDay){
		StatisticsVO statistic = new StatisticsVO();
				
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String SQL = "select COALESCE(z.price,0) as sum_amount, COALESCE(c.price,0) as cancel_amount, COALESCE(y.price,0) as billing_amount, COALESCE(f.price,0) as refund_amount, COALESCE(y.price,0) - COALESCE(f.price,0) as net_amount "
				   + "from (select 'total' as reservation_date, sum(price) price from reservation where reservation_date between DATE_FORMAT(?,'%Y-%m-%d') and DATE_FORMAT(?,'%Y-%m-%d')) z "
				   + "LEFT OUTER JOIN (select 'total' as reservation_date, sum(price) price from reservation where reservation_date between DATE_FORMAT(?,'%Y-%m-%d') and DATE_FORMAT(?,'%Y-%m-%d') and pay_status in ('F','C')) c on z.reservation_date = c.reservation_date "
				   + "LEFT OUTER JOIN (select 'total' as reservation_date, sum(price) price from reservation where reservation_date between DATE_FORMAT(?,'%Y-%m-%d') and DATE_FORMAT(?,'%Y-%m-%d') and pay_status in ('Y','C','F')) y on z.reservation_date = y.reservation_date "
				   + "LEFT OUTER JOIN (select 'total' as reservation_date, sum(refund_price) price from reservation where reservation_date between DATE_FORMAT(?,'%Y-%m-%d') and DATE_FORMAT(?,'%Y-%m-%d') and pay_status = 'F') f on z.reservation_date = f.reservation_date ";
		
		try{
			conn = ConnectionUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, startDay);
			pstmt.setString(2, endDay);
			pstmt.setString(3, startDay);
			pstmt.setString(4, endDay);
			pstmt.setString(5, startDay);
			pstmt.setString(6, endDay);
			pstmt.setString(7, startDay);
			pstmt.setString(8, endDay);

			rs = pstmt.executeQuery();
			
			if( rs.next() ){
				statistic.setSumAmount(rs.getInt("sum_amount"));
				statistic.setCancelAmount(rs.getInt("cancel_amount"));
				statistic.setBillingAmount(rs.getInt("billing_amount"));
				statistic.setRefundAmount(rs.getInt("refund_amount"));
				statistic.setNetAmount(rs.getInt("net_amount"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rs,pstmt,conn);
		}
		
		return statistic;
	}

}
