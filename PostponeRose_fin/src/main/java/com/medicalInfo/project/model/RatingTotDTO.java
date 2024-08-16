package com.medicalInfo.project.model;

import lombok.Data;

@Data
public class RatingTotDTO {
	private int expertNum;
	private double averageRate;
	private int memberNum;
	private String memberName;
	private String institutionAddress;
	private String institutionTel;
	private String institutionName;
	private String pictureName;
	private String picuniName;
	private String picType;
}
