package com.medicalInfo.project.model;

import lombok.Data;

@Data
public class MemberInfoDTO {
	private int memberNum;
	private MemberType memberType;
	private String institutionName;
	private String institutionAddress;
	private String institutionTel;
	private String license;
	private String pictureName;
	private String picuniName;
	private String picType;
	private String fileName;
	private String uniqueName;
	private String fileType;
	
	public MemberInfoDTO() {}

	public MemberInfoDTO(int memberNum, MemberType memberType, String institutionAddress, String institutionTel,
			String license, String institutionName) {
		super();
		this.memberNum = memberNum;
		this.memberType = memberType;
		this.institutionAddress = institutionAddress;
		this.institutionTel = institutionTel;
		this.license = license;
		this.institutionName = institutionName;
	}

	public MemberInfoDTO(int memberNum, MemberType memberType, String institutionName, String institutionAddress,
			String institutionTel, String license, String picName, String picuniName, String picType, String fileName,
			String fileuniName, String fileType) {
		super();
		this.memberNum = memberNum;
		this.memberType = memberType;
		this.institutionName = institutionName;
		this.institutionAddress = institutionAddress;
		this.institutionTel = institutionTel;
		this.license = license;
		this.pictureName = picName;
		this.picuniName = picuniName;
		this.picType = picType;
		this.fileName = fileName;
		this.uniqueName = fileuniName;
		this.fileType = fileType;
	}
	
	
}
