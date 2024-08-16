package com.medicalInfo.project.model;

import javax.persistence.EnumType;
import javax.persistence.Enumerated;

import lombok.Data;

@Data
public class RatingDTO {

	
	private int rating_id;
	private int memberNum;
	
	@Enumerated(EnumType.STRING)
	private Ratedtable_type ratedtable_type;
	
	@Enumerated(EnumType.STRING)
	private MemberType membertype;
	
	private int ratedtprescript_no;
	private int ratedqa_no;
	private double rate;
	private int expertNum;
	
	@Enumerated(EnumType.STRING)
	private MemberType expertype;
	
	public RatingDTO() {}

	public RatingDTO(int memberNum, Ratedtable_type ratedtable_type, MemberType membertype, int ratedqa_no, double rate,
			int expertNum, MemberType expertype) {
		super();
		this.memberNum = memberNum;
		this.ratedtable_type = ratedtable_type;
		this.membertype = membertype;
		this.ratedqa_no = ratedqa_no;
		this.rate = rate;
		this.expertNum = expertNum;
		this.expertype = expertype;
	}

	public RatingDTO(int memberNum, int ratedqa_no, int expertNum) {
		super();
		this.memberNum = memberNum;
		this.ratedqa_no = ratedqa_no;
		this.expertNum = expertNum;
	};
	
	public RatingDTO(int expertNum ,int memberNum, int ratedtprescript_no, double rate) {
		super();
		this.memberNum = memberNum;
		this.ratedtprescript_no = ratedtprescript_no;
		this.expertNum = expertNum;
		this.rate = rate;
	}

	
	public RatingDTO(int memberNum, MemberType membertype, int ratedtprescript_no,
		double rate, MemberType expertype,int expertNum) {
		super();
		this.memberNum = memberNum;
		this.membertype = membertype;
		this.ratedtprescript_no = ratedtprescript_no;
		this.rate = rate;
		this.expertNum = expertNum;
		this.expertype = expertype;
	}
}
