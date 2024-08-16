package com.medicalInfo.project.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class NoticeDTO {
	private int id_announcement;
	private String content;
	private int member_num;
	private String writerName;
	private String title;
	private Timestamp created_at;
	private String fileName;
	private String uniqueName;
	private String fileType;
	
	public NoticeDTO() {};
	
	public NoticeDTO(String content, int member_num, String writerName, String title, String fileName,
			String uniqueName, String fileType) {
		super();
		this.content = content;
		this.member_num = member_num;
		this.writerName = writerName;
		this.title = title;
		this.fileName = fileName;
		this.uniqueName = uniqueName;
		this.fileType = fileType;
	}
	
	
	
	
}