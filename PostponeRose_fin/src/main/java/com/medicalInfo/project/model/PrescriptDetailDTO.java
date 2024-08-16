package com.medicalInfo.project.model;

import lombok.Data;

@Data
public class PrescriptDetailDTO {
	private int prescript_detailID;
	private int prescript_no;
	private String medicine_no;
	private String medicine_name;
	private int per_day;
	private int total_day;
	private ADDORDROP addordrop;
	private String detail_comment;
	
	public PrescriptDetailDTO() {}

	public PrescriptDetailDTO(int prescript_no, String medicine_no, String itemName, int perDays, int totalDays,
			ADDORDROP addordrop, String detail_comment) {
		super();
		this.prescript_no = prescript_no;
		this.medicine_no = medicine_no;
		this.medicine_name = itemName;
		this.per_day = perDays;
		this.total_day = totalDays;
		this.addordrop = addordrop;
		this.detail_comment = detail_comment;
	}	
}
