package com.medicalInfo.project.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MyPrescriptRatingDTO {
	private int prescript_no;
	private String patient_name;
	private String patient_phone;
	private Timestamp prescribed_date;
	private double rate;
}
