package admin;

import java.sql.Date;

/*
 * CREATE TABLE `member` (
 *  `member_no` int(5) NOT NULL auto_increment,
 *  `id` varchar(50) NOT NULL,
 *  `password` varchar(12) NOT NULL,
 *  `grade` varchar(1) NOT NULL, A:관리자  B:운영자
 *  `name` varchar(12) NOT NULL,
 *  `date_of_birth` char(8) default NULL,
 *  `sex` char(1) default NULL,
 *  `email` varchar(50) default NULL,
 *  `recv_yn` char(1) default NULL,
 *  `phone1` varchar(5) default NULL,
 *  `phone2` varchar(5) default NULL,
 *  `phone3` varchar(5) default NULL,
 *  `cell1` varchar(5) NOT NULL,
 *  `cell2` varchar(5) NOT NULL,
 *  `cell3` varchar(5) NOT NULL,
 *  `zip` char(7) default NULL,
 *  `address1` varchar(100) default NULL,
 *  `address2` varchar(50) default NULL,
 *  `reg_date` date default NULL,
 *  PRIMARY KEY  (`member_no`,`id`)
 *) ENGINE=MyISAM DEFAULT CHARSET=euckr;
 */
public class MemberVO {

	int memberNo;
	String id, password, grade, name, dateOfBirth, sex, email, recvYn, phone1, phone2, phone3, cell1, cell2, cell3, zip, address1, address2;
	Date regDate;
	
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDateOfBirth() {
		return dateOfBirth;
	}
	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRecvYn() {
		return recvYn;
	}
	public void setRecvYn(String recvYn) {
		this.recvYn = recvYn;
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
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

}
