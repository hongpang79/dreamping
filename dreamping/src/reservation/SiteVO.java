package reservation;

import java.util.Date;

/**
 * 
 CREATE TABLE `zone_infomation` (
  `zone_no` int(3) NOT NULL auto_increment,
  `zone_name` varchar(20) default NULL,
  `order_no` int(2) NOT NULL,
  `use_start_day` date default NULL,
  `use_end_day` date default NULL,
) ENGINE=MyISAM DEFAULT CHARSET=euckr;

CREATE TABLE `site_information` (
  `zone_no` int(3) NOT NULL,
  `site_no` int(3) NOT NULL auto_increment,
  `site_name` varchar(20) default NULL,
  PRIMARY KEY  (`site_no`)
) ENGINE=MyISAM DEFAULT CHARSET=euckr;

CREATE TABLE `product` (
  `product_no` int(3) NOT NULL auto_increment,
  `product_name` varchar(64) default NULL,
  `zone_no` int(3) NOT NULL,
  `site_no` int(3) NOT NULL,
  `site_name` varchar(20) default NULL,
  `users` int(2) default NULL,
  `max_users` int(2) default NULL,
  `add_child_price` int(6) default '0',
  `add_user_price` int(6) default '0',
  `low_season_weekday` int(6) default NULL, /비수기 평일/
  `low_season_weekend` int(6) default NULL, /비수기 주말/
  `low_season_picnic` int(6) default NULL, /비수기 피크닉/
  `middle_season_weekday` int(6) default NULL,/준성수기 평일/
  `middle_season_weekend` int(6) default NULL,/준성수기 주말/
  `middle_season_picnic` int(6) default NULL,/준성수기 피크닉/
  `high_season_weekday` int(6) default NULL,/성수기 평일/
  `high_season_weekend` int(6) default NULL,/성수기 주말/
  `high_season_picnic` int(6) default NULL,/성수기 피크닉/
  `display_start_day` date default NULL,
  `display_end_day` date default NULL,
  `use_yn` varchar(1) default 'Y', 	/사용여부/
  `sale` int(2) default NULL,
  `sale_start_day` date default NULL,
  `sale_end_day` date default NULL,
  `sale_memo` varchar(255) default NULL,
  `flat_price` int(6) default NULL,
  `flat_price_start_day` date default NULL,
  `flat_price_end_day` date default NULL,
  `product_memo` varchar(255) default NULL,
  PRIMARY KEY  (`product_no`),
  UNIQUE KEY `product_product_name_uk` (`product_name`)
) ENGINE=MyISAM DEFAULT CHARSET=euckr;
 *
 */
public class SiteVO {
	
	String zoneName,siteName,productName,useYn,saleMemo,productMemo;
	int zoneNo,orderNo,zoneCnt,siteNo,productNo,users,maxUsers,addChildPrice,addUserPrice,sale,flatPrice;
	int lowSeasonWeekday,lowSeasonWeekend,lowSeasonPicnic;
	int highSeasonWeekday,highSeasonWeekend,highSeasonPicnic;
	int middleSeasonWeekday,middleSeasonWeekend,middleSeasonPicnic;
	Date displayStartDay,displayEndDay,saleStartDay,saleEndDay,flatPriceStartDay,flatPriceEndDay,useStartDay,useEndDay;
	
	public int getLowSeasonPicnic() {
		return lowSeasonPicnic;
	}
	public void setLowSeasonPicnic(int lowSeasonPicnic) {
		this.lowSeasonPicnic = lowSeasonPicnic;
	}
	public int getHighSeasonPicnic() {
		return highSeasonPicnic;
	}
	public void setHighSeasonPicnic(int highSeasonPicnic) {
		this.highSeasonPicnic = highSeasonPicnic;
	}
	public int getMiddleSeasonWeekday() {
		return middleSeasonWeekday;
	}
	public void setMiddleSeasonWeekday(int middleSeasonWeekday) {
		this.middleSeasonWeekday = middleSeasonWeekday;
	}
	public int getMiddleSeasonWeekend() {
		return middleSeasonWeekend;
	}
	public void setMiddleSeasonWeekend(int middleSeasonWeekend) {
		this.middleSeasonWeekend = middleSeasonWeekend;
	}
	public int getMiddleSeasonPicnic() {
		return middleSeasonPicnic;
	}
	public void setMiddleSeasonPicnic(int middleSeasonPicnic) {
		this.middleSeasonPicnic = middleSeasonPicnic;
	}
		
	public String getZoneName() {
		return zoneName;
	}
	public void setZoneName(String zoneName) {
		this.zoneName = zoneName;
	}
	
	public String getSiteName() {
		return siteName;
	}
	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}
	
	public int getZoneNo() {
		return zoneNo;
	}
	public void setZoneNo(int zoneNo) {
		this.zoneNo = zoneNo;
	}
	
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	
	public int getZoneCnt() {
		return zoneCnt;
	}
	public void setZoneCnt(int zoneCnt) {
		this.zoneCnt = zoneCnt;
	}
	
	public int getSiteNo() {
		return siteNo;
	}
	public void setSiteNo(int siteNo) {
		this.siteNo = siteNo;
	}
	
	public int getUsers() {
		return users;
	}
	public void setUsers(int users) {
		this.users = users;
	}
	
	public int getMaxUsers() {
		return maxUsers;
	}
	public void setMaxUsers(int maxUsers) {
		this.maxUsers = maxUsers;
	}
	
	public int getAddChildPrice() {
		return addChildPrice;
	}
	public void setAddChildPrice(int addChildPrice) {
		this.addChildPrice = addChildPrice;
	}
	public int getAddUserPrice() {
		return addUserPrice;
	}
	public void setAddUserPrice(int addUserPrice) {
		this.addUserPrice = addUserPrice;
	}
	
	public int getLowSeasonWeekday() {
		return lowSeasonWeekday;
	}
	public void setLowSeasonWeekday(int lowSeasonWeekday) {
		this.lowSeasonWeekday = lowSeasonWeekday;
	}
	
	public int getLowSeasonWeekend() {
		return lowSeasonWeekend;
	}
	public void setLowSeasonWeekend(int lowSeasonWeekend) {
		this.lowSeasonWeekend = lowSeasonWeekend;
	}
	
	public int getHighSeasonWeekday() {
		return highSeasonWeekday;
	}
	public void setHighSeasonWeekday(int highSeasonWeekday) {
		this.highSeasonWeekday = highSeasonWeekday;
	}
	
	public int getHighSeasonWeekend() {
		return highSeasonWeekend;
	}
	public void setHighSeasonWeekend(int highSeasonWeekend) {
		this.highSeasonWeekend = highSeasonWeekend;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public Date getDisplayStartDay() {
		return displayStartDay;
	}
	public void setDisplayStartDay(Date displayStartDay) {
		this.displayStartDay = displayStartDay;
	}
	public Date getDisplayEndDay() {
		return displayEndDay;
	}
	public void setDisplayEndDay(Date displayEndDay) {
		this.displayEndDay = displayEndDay;
	}
	public String getProductMemo() {
		return productMemo;
	}
	public void setProductMemo(String productMemo) {
		this.productMemo = productMemo;
	}
	public int getSale() {
		return sale;
	}
	public void setSale(int sale) {
		this.sale = sale;
	}
	public Date getSaleStartDay() {
		return saleStartDay;
	}
	public void setSaleStartDay(Date saleStartDay) {
		this.saleStartDay = saleStartDay;
	}
	public Date getSaleEndDay() {
		return saleEndDay;
	}
	public void setSaleEndDay(Date saleEndDay) {
		this.saleEndDay = saleEndDay;
	}
	public String getSaleMemo() {
		return saleMemo;
	}
	public void setSaleMemo(String saleMemo) {
		this.saleMemo = saleMemo;
	}
	public int getFlatPrice() {
		return flatPrice;
	}
	public void setFlatPrice(int flatPrice) {
		this.flatPrice = flatPrice;
	}
	public Date getFlatPriceStartDay() {
		return flatPriceStartDay;
	}
	public void setFlatPriceStartDay(Date flatPriceStartDay) {
		this.flatPriceStartDay = flatPriceStartDay;
	}
	public Date getFlatPriceEndDay() {
		return flatPriceEndDay;
	}
	public void setFlatPriceEndDay(Date flatPriceEndDay) {
		this.flatPriceEndDay = flatPriceEndDay;
	}
	public Date getUseStartDay() {
		return useStartDay;
	}
	public void setUseStartDay(Date useStartDay) {
		this.useStartDay = useStartDay;
	}
	public Date getUseEndDay() {
		return useEndDay;
	}
	public void setUseEndDay(Date useEndDay) {
		this.useEndDay = useEndDay;
	}
}
