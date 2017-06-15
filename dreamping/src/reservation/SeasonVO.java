package reservation;

/**
 * 
  CREATE TABLE `season` (
  `season_name` varchar(25) NOT NULL,  
  `start_season` varchar(5) NOT NULL,
  `end_season` varchar(5) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=euckr;
 *
 */
public class SeasonVO {
	String seasonName,startSeason,endSeason,startHighSeason,endHighSeason,startLowSeason,endLowSeason;

	public String getSeasonName() {
		return seasonName;
	}
	
	public void setSeasonName(String seasonName) {
		this.seasonName = seasonName;
	}
	
	public String getStartSeason() {
		return startSeason;
	}
	
	public void setStartSeason(String startSeason) {
		this.startSeason = startSeason;
	}
	
	public String getEndSeason() {
		return endSeason;
	}
	
	public void setEndSeason(String endSeason) {
		this.endSeason = endSeason;
	}
	
	public String getStartHighSeason() {
		return startHighSeason;
	}

	public void setStartHighSeason(String startHighSeason) {
		this.startHighSeason = startHighSeason;
	}

	public String getEndHighSeason() {
		return endHighSeason;
	}

	public void setEndHighSeason(String endHighSeason) {
		this.endHighSeason = endHighSeason;
	}

	public String getStartLowSeason() {
		return startLowSeason;
	}

	public void setStartLowSeason(String startLowSeason) {
		this.startLowSeason = startLowSeason;
	}

	public String getEndLowSeason() {
		return endLowSeason;
	}

	public void setEndLowSeason(String endLowSeason) {
		this.endLowSeason = endLowSeason;
	}
}
