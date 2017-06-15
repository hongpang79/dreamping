package reservation;

/**
 * CREATE TABLE `refund` (
 * `refund_day_before` int(2) NOT NULL,
 * `refund_type` varchar(1) NOT NULL,
 * `refund_amount` int(7) default NULL
 *) ENGINE=MyISAM DEFAULT CHARSET=euckr;
 *
 */
public class RefundVO {

	int refundDayBefore, refundAmount;
	String refundType;
	
	public int getRefundDayBefore() {
		return refundDayBefore;
	}
	public void setRefundDayBefore(int refundDayBefore) {
		this.refundDayBefore = refundDayBefore;
	}
	public int getRefundAmount() {
		return refundAmount;
	}
	public void setRefundAmount(int refundAmount) {
		this.refundAmount = refundAmount;
	}
	public String getRefundType() {
		return refundType;
	}
	public void setRefundType(String refundType) {
		this.refundType = refundType;
	}

}
