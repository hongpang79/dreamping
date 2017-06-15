package reservation;

import java.util.Date;

/**
 * 
 * CREATE TABLE `reservation` (
*   `reservation_no` int(11) NOT NULL auto_increment,
*   `product_no` int(3) NOT NULL
*   `product_name` varchar(64) default NULL,
*   `site_no` int(3) default NULL,
*   `member_no` int(11) default NULL,
*   `reservation_date` date default NULL,		/예약일자/
*   `nights` int(2) default NULL,				/~박/
*   `toddler` int(2) default NULL,			/유아/
*  	`child` int(2) default NULL,				/어린이/
*   `users` int(2) default NULL,				/이용인원/
*   `price` int(7) default NULL,				/이용금액/
*   `payment` char(1) default 'V',			/무통장입금/
*   `bank_name` varchar(20) default NULL,		/입금은행명/
*   `account` varchar(20) default NULL,		/입금계좌번호/
*   `pay_status` char(1) default 'N',				/입금여부/
*   `reserver` varchar(12) NOT NULL,			/예약자/
*   `email` varchar(50) default NULL,
*   `phone1` varchar(5) default NULL,
*   `phone2` varchar(5) default NULL,
*   `phone3` varchar(5) default NULL,
*   `cell1` varchar(5) default NULL,
*   `cell2` varchar(5) default NULL,
*   `cell3` varchar(5) default NULL,
*   `memo` varchar(2048) default NULL,			/요청사항/
*   `refund_bank` varchar(25) default NULL,		/환불받을 은행명/
*   `refund_depositor` varchar(25) default NULL,	/환불받을 예금주/
*   `refund_account` varchar(48) default NULL,	/환불받을 계좌번호/
*   `refund_price` int(7) default NULL,		    /환불금액/
*   `remark` varchar(1024) default NULL,			/취소사유/
*   `refund_reg_date` date default NULL,			/환불요청 일자/
*   `refund_date` date default NULL,				/환불일자/
*   `admin_memo` varchar(2048) default NULL,		//
*   `reg_date` date default NULL,
*   PRIMARY KEY  (`reservation_no`),
*   KEY `reservation_rno_fk` (`site_no`)
* ) ENGINE=MyISAM DEFAULT CHARSET=euckr;
* 
* CREATE TABLE `reservation_day` (
*   `reservation_month` varchar(6) default NULL, /YYYYMM/
*   `reservation_day` varchar(8) default NULL,   /YYYYMMDD/
*   `zone_name` varchar(20) default NULL,
*   `site_no` int(3) default NULL,
*   `reservation_no` int(11) default NULL,
*   `pay_status` varchar(1) default NULL,
*   `reg_date` date default NULL
* ) ENGINE=MyISAM DEFAULT CHARSET=euckr;
 *
 */
public class ReservationVO {
	
	//예약번호, Site 번호, 회원번호, 숙박일, 인원, 금액, 환불금액, 환불기준일, 환불기준금액, 환불기준일
	int reservationNo,productNo,siteNo,memberNo,nights,toddler,child,users,price,calcPrice,refundPrice,refundDayBefore,refundAmount,refundDay; 
	//지불방법, 은행명, 계좌번호, 지불여부(N:입금대기/Y:입금완료/C:예약취소/R:환불완료), 예약자, 이메일, 연락처1,2,3, 비상연락처1,2,3, 요청사항
	String payment="",bankName="",account="",payStatus="",reserver="",email="",phone1="",phone2="", phone3="", cell1="", cell2="", cell3="", memo=""; 
	//환불은행명, 환불예금주, 환불계좌번호, 취소사유
	String refundBank="", refundDepositor="", refundAccount="", remark="", refundMemo="", adminMemo="", productName=""; 
	public String getRefundMemo() {
		return refundMemo;
	}

	public void setRefundMemo(String refundMemo) {
		this.refundMemo = refundMemo;
	}

	//예약년월, 예약일자, zone명, 지불상태코드 (W : 대기 / C : 완료) 
	String reservationMonth="", reservationDay="", zoneName="", status="", siteName="";
	//환불금액타입
	String refundType="";
	//숙박시작일, 등록일자
	Date reservationDate,regDate,refundRegDate,refundDate;

	public int getReservationNo() {
		return reservationNo;
	}

	public void setReservationNo(int reservationNo) {
		this.reservationNo = reservationNo;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public int getSiteNo() {
		return siteNo;
	}

	public void setSiteNo(int siteNo) {
		this.siteNo = siteNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getNights() {
		return nights;
	}

	public void setNights(int nights) {
		this.nights = nights;
	}

	public int getToddler() {
		return toddler;
	}

	public void setToddler(int toddler) {
		this.toddler = toddler;
	}

	public int getChild() {
		return child;
	}

	public void setChild(int child) {
		this.child = child;
	}

	public int getUsers() {
		return users;
	}

	public void setUsers(int users) {
		this.users = users;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}
	
	public int getCalcPrice() {
		return calcPrice;
	}

	public void setCalcPrice(int calcPrice) {
		this.calcPrice = calcPrice;
	}

	public int getRefundPrice() {
		return refundPrice;
	}

	public void setRefundPrice(int refundPrice) {
		this.refundPrice = refundPrice;
	}

	public int getRefundDayBefore() {
		return refundDayBefore;
	}

	public void setRefundDayBefore(int refundDayBefore) {
		this.refundDayBefore = refundDayBefore;
	}

	public int getRefundDay() {
		return refundDay;
	}

	public void setRefundDay(int refundDay) {
		this.refundDay = refundDay;
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

	public String getPayment() {
		return payment;
	}

	public void setPayment(String payment) {
		this.payment = payment;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}

	public String getReserver() {
		return reserver;
	}

	public void setReserver(String reserver) {
		this.reserver = reserver;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone1() {
		return phone1;
	}

	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}

	public String getPhone2() {
		return phone2;
	}

	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}

	public String getPhone3() {
		return phone3;
	}

	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}

	public String getCell1() {
		return cell1;
	}

	public void setCell1(String cell1) {
		this.cell1 = cell1;
	}

	public String getCell2() {
		return cell2;
	}

	public void setCell2(String cell2) {
		this.cell2 = cell2;
	}

	public String getCell3() {
		return cell3;
	}

	public void setCell3(String cell3) {
		this.cell3 = cell3;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getAdminMemo() {
		return adminMemo;
	}

	public void setAdminMemo(String adminMemo) {
		this.adminMemo = adminMemo;
	}

	public String getRefundBank() {
		return refundBank;
	}

	public void setRefundBank(String refundBank) {
		this.refundBank = refundBank;
	}

	public String getRefundDepositor() {
		return refundDepositor;
	}

	public void setRefundDepositor(String refundDepositor) {
		this.refundDepositor = refundDepositor;
	}

	public String getRefundAccount() {
		return refundAccount;
	}

	public void setRefundAccount(String refundAccount) {
		this.refundAccount = refundAccount;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getReservationMonth() {
		return reservationMonth;
	}

	public void setReservationMonth(String reservationMonth) {
		this.reservationMonth = reservationMonth;
	}

	public String getReservationDay() {
		return reservationDay;
	}

	public void setReservationDay(String reservationDay) {
		this.reservationDay = reservationDay;
	}

	public String getZoneName() {
		return zoneName;
	}

	public void setZoneName(String zoneName) {
		this.zoneName = zoneName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getSiteName() {
		return siteName;
	}

	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}

	public Date getReservationDate() {
		return reservationDate;
	}

	public void setReservationDate(Date reservationDate) {
		this.reservationDate = reservationDate;
	}

	public Date getRefundRegDate() {
		return refundRegDate;
	}

	public void setRefundRegDate(Date refundRegDate) {
		this.refundRegDate = refundRegDate;
	}

	public Date getRefundDate() {
		return refundDate;
	}

	public void setRefundDate(Date refundDate) {
		this.refundDate = refundDate;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}
	
	
	
	
}
