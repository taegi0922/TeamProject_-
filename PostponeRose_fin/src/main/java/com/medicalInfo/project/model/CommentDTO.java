package com.medicalInfo.project.model;

import java.sql.Timestamp;

import javax.persistence.EnumType;
import javax.persistence.Enumerated;

import lombok.Data;

@Data
public class CommentDTO {

	
	private int comment_id;
	private int writer;
	private String content;
	private int rating_id;
	
	@Enumerated(EnumType.STRING)
	private TableType table_type;
	
	private int qa_no;
	private int prescript_no;
	private Timestamp created_at;
	private String writerName;
	
	@Enumerated(EnumType.STRING)
	private MemberType memberType;
	
	public CommentDTO() {}
	
	public CommentDTO(int writer, String content, TableType tableType, int qa_no,String writerName, MemberType memberType) {
		super();
		this.writer = writer;
		this.content = content;
		this.table_type = tableType;
		this.qa_no = qa_no;
		this.writerName = writerName;
		this.memberType = memberType;
	}

	public CommentDTO(int comment_id, String content) {
		super();
		this.comment_id = comment_id;
		this.content = content;
	}

	public CommentDTO(int writer, String content, TableType table_type, int qa_no, int prescript_no, String writerName,
			MemberType memberType) {
		super();
		this.writer = writer;
		this.content = content;
		this.table_type = table_type;
		this.qa_no = qa_no;
		this.prescript_no = prescript_no;
		this.writerName = writerName;
		this.memberType = memberType;
	}
}
