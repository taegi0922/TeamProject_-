package com.medicalInfo.project.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class WaitForExpertDTO {
	private int waitforexpertId;
	private int memberNum;
	private String memberName;
	private String institutionAddress;
	private String institutionTel;
	private String license;
	private String FileName;
	private String uniqueName;
	private String fileType;
	private Timestamp created_at;
	private String institutionName;
	private String pictureName;
	private String picuniName;
	private String picType;
	private String email;
	public WaitForExpertDTO() {
		super();
	}
	
	
	public WaitForExpertDTO(int memberNum, String memberName, String institutionAddress,
			String institutionTel, String license, String fileName) {
		super();
		this.memberNum = memberNum;
		this.memberName = memberName;
		this.institutionAddress = institutionAddress;
		this.institutionTel = institutionTel;
		this.license = license;
		FileName = fileName;
	}


	public WaitForExpertDTO(int memberNum, String memberName, String institutionAddress, String institutionTel,
			String license, String fileName, String uniqueName, String fileType, String institutionName) {
		super();
		this.memberNum = memberNum;
		this.memberName = memberName;
		this.institutionAddress = institutionAddress;
		this.institutionTel = institutionTel;
		this.license = license;
		FileName = fileName;
		this.uniqueName = uniqueName;
		this.fileType = fileType;
		this.institutionName = institutionName;
	}


	public WaitForExpertDTO(int memberNum, String memberName, String institutionAddress, String institutionTel,
			String license, String fileName, String uniqueName, String fileType, String institutionName,
			String pictureName, String picuniName, String picType, String email) {
		super();
		this.memberNum = memberNum;
		this.memberName = memberName;
		this.institutionAddress = institutionAddress;
		this.institutionTel = institutionTel;
		this.license = license;
		FileName = fileName;
		this.uniqueName = uniqueName;
		this.fileType = fileType;
		this.institutionName = institutionName;
		this.pictureName = pictureName;
		this.picuniName = picuniName;
		this.picType = picType;
		this.email = email;
	}
	
	
}
