package reservation;


/**
 * 
  CREATE TABLE `deposit` (
  `bank_name` varchar(20) NOT NULL,
  `account` varchar(30) NOT NULL,
  `depositor` varchar(20) NOT NULL
 ) ENGINE=MyISAM DEFAULT CHARSET=euckr;
 *
 */
public class DepositVO {
	String bankName,account,depositor;
	
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
	
	public String getDepositor() {
		return depositor;
	}
	
	public void setDepositor(String depositor) {
		this.depositor = depositor;
	}
	
}
