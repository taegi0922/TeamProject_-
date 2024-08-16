package com.medicalInfo.project.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MyQaRatingDTO {
	private int qa_id;
	private String title;
	private String writer;
	private Timestamp created_at;
	private double rate;
}
