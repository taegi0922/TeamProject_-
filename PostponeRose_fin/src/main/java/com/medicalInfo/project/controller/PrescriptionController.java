package com.medicalInfo.project.controller;

import javax.servlet.http.HttpSession;

import org.hibernate.boot.model.source.internal.hbm.ModelBinder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.medicalInfo.project.model.MemberDTO;
import com.medicalInfo.project.model.PrescriptDTO;
import com.medicalInfo.project.service.PrescriptService;

@Controller
public class PrescriptionController {
	
	@Autowired
	private PrescriptService prescriptionService;
	
	@GetMapping("/prescriptwrite")
	public void prescriptWrite() {	
	}
}
