package com.medicalInfo.project.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MemberDTO {
	private int memberNum;
	private String memberId;
	private String memberPw;
	private String memberName;
	private Timestamp memberBday;
	private String memberAddress;
	private String memberPhone;
	private String memberEmail;
	
	public MemberDTO() {}
	
	public MemberDTO(String memberId, String memberPw, String memberName, String memberAddress, String memberPhone, String memberEmail) {
		super();
		this.memberId = memberId;
		this.memberPw = memberPw;
		this.memberName = memberName;
		this.memberAddress = memberAddress;
		this.memberPhone = memberPhone;
		this.memberEmail = memberEmail;

	}
	
	// 박미나 추가
		public MemberDTO(String memberId, String memberAddress, String memberPhone, int memberNum) {
			super();
			this.memberId = memberId;
			this.memberAddress = memberAddress;
			this.memberPhone = memberPhone;
			this.memberNum = memberNum;
		}


	
	
}
