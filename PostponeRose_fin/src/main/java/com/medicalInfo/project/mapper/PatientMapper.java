package com.medicalInfo.project.mapper;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.medicalInfo.project.model.MemberDTO;
import com.medicalInfo.project.model.PatientDTO;


public interface PatientMapper {
	
	@Select ("SELECT * FROM member WHERE memberEmail LIKE #{memberId}")
	public MemberDTO findByEmail(String memberId);
	
	@Select("SELECT * FROM patient WHERE patientEmail LIKE #{memberId}")
	public PatientDTO findEmail(String memberId); 
	
	public void registerPatient(PatientDTO patient);
	
	
}
