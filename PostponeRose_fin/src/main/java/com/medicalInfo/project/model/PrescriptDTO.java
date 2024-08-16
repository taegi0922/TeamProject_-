package com.medicalInfo.project.model;

import java.sql.Timestamp;
import java.util.Date;

import lombok.Data;

@Data
public class PrescriptDTO {
	private int prescript_no;
	private String patient_name;
	private String memberId;
	private String patient_phone;
	private int memberNum;
	private MemberType member_type;
	private String institution_address;
	private String expert_name;
	private int memberNum_expert;
	private MemberType membertype_expert;
	private Timestamp prescribed_date;
	
	public PrescriptDTO() {
		
	}

	public PrescriptDTO(String patient_name, String memberId, String patient_phone, int memberNum,
			MemberType member_type, String institution_address, String expert_name, int memberNum_expert,
			MemberType membertype_expert) {
		super();
		this.patient_name = patient_name;
		this.memberId = memberId;
		this.patient_phone = patient_phone;
		this.memberNum = memberNum;
		this.member_type = member_type;
		this.institution_address = institution_address;
		this.expert_name = expert_name;
		this.memberNum_expert = memberNum_expert;
		this.membertype_expert = membertype_expert;
	}

	public PrescriptDTO(String patient_name, String memberId, String patient_phone, String institution_address,
			String expert_name, int memberNum_expert, MemberType membertype_expert) {
		super();
		this.patient_name = patient_name;
		this.memberId = memberId;
		this.patient_phone = patient_phone;
		this.institution_address = institution_address;
		this.expert_name = expert_name;
		this.memberNum_expert = memberNum_expert;
		this.membertype_expert = membertype_expert;
	}


	
	
	
}
