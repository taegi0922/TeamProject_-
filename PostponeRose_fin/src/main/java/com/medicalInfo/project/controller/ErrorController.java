package com.medicalInfo.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ErrorController {

	@GetMapping("/error/404")
	public void error() {
		
	}
	
	@GetMapping("/error/500")
	public void error2() {
		
	}
}
