package com.medicalInfo.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.medicalInfo.project.mapper.PatientMapper;
import com.medicalInfo.project.model.MemberDTO;
import com.medicalInfo.project.model.PatientDTO;


@Service
public class PatientService {
	 
	@Autowired
	PatientMapper patientmapper;
	
	 public MemberDTO getPatientByEmail(String email) {
		 return patientmapper.findByEmail(email);
	 }

	public void registerPatient(PatientDTO patient) {
		patientmapper.registerPatient(patient);
	}

	public PatientDTO getPatient(String memberId) {
		return patientmapper.findEmail(memberId);
	}
}
