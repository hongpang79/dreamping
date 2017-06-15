package admin;

import java.util.Date;

public class PopupVO {

	String layerId = "";
	String style = "";
	String imgSrc = "";
	String usemapId = "";
	String area = "";
	String alt = "";
	String useYn = "";
	
	Date displayStartDay, displayEndDay;

	public String getLayerId() {
		return layerId;
	}

	public void setLayerId(String layerId) {
		this.layerId = layerId;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public String getImgSrc() {
		return imgSrc;
	}

	public void setImgSrc(String imgSrc) {
		this.imgSrc = imgSrc;
	}

	public String getUsemapId() {
		return usemapId;
	}

	public void setUsemapId(String usemapId) {
		this.usemapId = usemapId;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getAlt() {
		return alt;
	}

	public void setAlt(String alt) {
		this.alt = alt;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
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
