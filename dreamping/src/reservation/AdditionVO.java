package reservation;

import java.util.Date;

/**
 * CREATE TABLE `addition` (
  `addition_no` int(3) NOT NULL auto_increment,
  `addition_name` varchar(64) default NULL,
  `zone_no` int(3) NOT NULL,
  `unit` varchar(32) default NULL,
  `addition_price` int(6) default '0',
  `quantity` int(6) default '9999', 
  `addition_memo` varchar(512) default NULL,
  `display_start_day` date default NULL,
  `display_end_day` date default NULL,
  `use_yn` varchar(1) default 'Y', 	
  `del_yn` varchar(1) default 'N',
  PRIMARY KEY  (`addition_no`)
) ENGINE=MyISAM;
 * @author kr007951
 *
 */

public class AdditionVO {
	
	int additionNo, zoneNo, additionPrice, quantity;
	String additionName, unit, additionMemo, useYn, delYn, zoneName;
	Date displayStartDay, displayEndDay;
	
	public String getZoneName() {
		return zoneName;
	}
	public void setZoneName(String zoneName) {
		this.zoneName = zoneName;
	}
	public int getAdditionNo() {
		return additionNo;
	}
	public void setAdditionNo(int additionNo) {
		this.additionNo = additionNo;
	}
	public int getZoneNo() {
		return zoneNo;
	}
	public void setZoneNo(int zoneNo) {
		this.zoneNo = zoneNo;
	}
	public int getAdditionPrice() {
		return additionPrice;
	}
	public void setAdditionPrice(int additionPrice) {
		this.additionPrice = additionPrice;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getAdditionName() {
		return additionName;
	}
	public void setAdditionName(String additionName) {
		this.additionName = additionName;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getAdditionMemo() {
		return additionMemo;
	}
	public void setAdditionMemo(String additionMemo) {
		this.additionMemo = additionMemo;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
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

}
