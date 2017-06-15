package admin;

import java.util.Date;

public class StatisticsVO {
	//예약완료건, 예약대기건, 취소/환불신청건, 취소/홥불완료건
	int rsvtCompCnt, rsvtWaitCnt, rsvtRefdReqCnt, rsvtRefdCompCnt;
	
	//예약주문금액, 입금후 취소금액, 결제금액, 환불금액, 순 매출
	int sumAmount, cancelAmount, billingAmount, refundAmount, netAmount;
	
	//일자
	Date reservationDay;

	public int getRsvtCompCnt() {
		return rsvtCompCnt;
	}

	public void setRsvtCompCnt(int rsvtCompCnt) {
		this.rsvtCompCnt = rsvtCompCnt;
	}

	public int getRsvtWaitCnt() {
		return rsvtWaitCnt;
	}

	public void setRsvtWaitCnt(int rsvtWaitCnt) {
		this.rsvtWaitCnt = rsvtWaitCnt;
	}

	public int getRsvtRefdReqCnt() {
		return rsvtRefdReqCnt;
	}

	public void setRsvtRefdReqCnt(int rsvtRefdReqCnt) {
		this.rsvtRefdReqCnt = rsvtRefdReqCnt;
	}

	public int getRsvtRefdCompCnt() {
		return rsvtRefdCompCnt;
	}

	public void setRsvtRefdCompCnt(int rsvtRefdCompCnt) {
		this.rsvtRefdCompCnt = rsvtRefdCompCnt;
	}

	public int getSumAmount() {
		return sumAmount;
	}

	public void setSumAmount(int sumAmount) {
		this.sumAmount = sumAmount;
	}

	public int getCancelAmount() {
		return cancelAmount;
	}

	public void setCancelAmount(int cancelAmount) {
		this.cancelAmount = cancelAmount;
	}

	public int getBillingAmount() {
		return billingAmount;
	}

	public void setBillingAmount(int billingAmount) {
		this.billingAmount = billingAmount;
	}

	public int getRefundAmount() {
		return refundAmount;
	}

	public void setRefundAmount(int refundAmount) {
		this.refundAmount = refundAmount;
	}

	public int getNetAmount() {
		return netAmount;
	}

	public void setNetAmount(int netAmount) {
		this.netAmount = netAmount;
	}

	public Date getReservationDay() {
		return reservationDay;
	}

	public void setReservationDay(Date reservationDay) {
		this.reservationDay = reservationDay;
	}

	

}
