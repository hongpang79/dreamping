package admin;

import java.sql.Date;
/**
 * CREATE TABLE `siteboard` (
 *  `num` int(11) NOT NULL auto_increment,
 *  `category` varchar(10) default NULL,
 *  `zone_no` varchar(10) default NULL,
 *  `subject` varchar(50) default NULL,
 *  `img_url` varchar(255) default NULL,
 *  `boardNo` int(11),
 *  `display_start_day` date default NULL,
 *  `display_end_day` date default NULL,
 *  `use_yn` varchar(1) default 'Y',
 *  PRIMARY KEY  (`num`)
 *) ENGINE=MyISAM DEFAULT CHARSET=euckr;
 *
 */
import java.sql.Timestamp;

public class MainBoardVO{
	private int num, boardNo;
	private String category;
	private String zoneNo;
    private String subject;
    private String useYn;
    private String imgUrl;
    private String boardSubject;
    private String contents;
    
    Timestamp displayStartDay, displayEndDay;

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getZoneNo() {
		return zoneNo;
	}

	public void setZoneNo(String zoneNo) {
		this.zoneNo = zoneNo;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public String getBoardSubject() {
		return boardSubject;
	}

	public void setBoardSubject(String boardSubject) {
		this.boardSubject = boardSubject;
	}

	public Timestamp getDisplayStartDay() {
		return displayStartDay;
	}

	public void setDisplayStartDay(Timestamp displayStartDay) {
		this.displayStartDay = displayStartDay;
	}

	public Timestamp getDisplayEndDay() {
		return displayEndDay;
	}

	public void setDisplayEndDay(Timestamp displayEndDay) {
		this.displayEndDay = displayEndDay;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	} 
}

