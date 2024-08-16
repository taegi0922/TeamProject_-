package com.medicalInfo.project.controller;

import java.util.HashMap;
import java.util.Map;

import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.medicalInfo.project.model.MemberDTO;
import com.medicalInfo.project.model.PatientDTO;
import com.medicalInfo.project.service.PatientService;

@Controller
public class PatientController {

	@Autowired
	private PatientService patientService;

	@PostMapping("/lookupPatient")
	@ResponseBody
	public Map<String, Object> lookupPatient(@RequestParam("memberId") String memberId, Model model) {
		Map<String, Object> response = new HashMap<>();
		MemberDTO patientmem = patientService.getPatientByEmail(memberId);
		if (patientmem != null) {
			System.out.println("patient찍히냐?" + patientmem);
			response.put("success", true);
			response.put("memberName", patientmem.getMemberName());
			response.put("phoneNum", patientmem.getMemberPhone());
			model.addAttribute("pateint", patientmem);
		} else {
			PatientDTO patient = patientService.getPatient(memberId);
			if (patient!=null) {
				response.put("success", true);
				response.put("memberName", patient.getPatientName());
				response.put("phoneNum", patient.getPatientTel());
				model.addAttribute("pateint", patient);
			}else {
				response.put("success", false);
			}
		}
		
		return response;
	}
	
	@PostMapping("/registerpatient")
	@ResponseBody
	public boolean registerPatient(PatientDTO patient) {
		System.out.println("여기는 들어오나?");
		System.out.println("patient 찍어보기"+patient);
		if (patient.getPatientName()==null||patient.getPatientTel()==null||patient.getPatientEmail()==null) {
			return false;
		}
			patientService.registerPatient(patient);
			return true;
	}
	
}
