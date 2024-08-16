package com.medicalInfo.project.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class myQaMixList {

	private int prescript_no;
	private String title;
	private String context;
	private String writer;
	private Timestamp created_at;
	private double rate;
	
}
