package com.medicalInfo.project.controller;

import javax.naming.Context;
import javax.naming.NameParser;
import javax.naming.NamingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.medicalInfo.project.model.KaKaoOauthResponse;
import com.medicalInfo.project.model.KakaoDTO;
import com.medicalInfo.project.model.KakaoTokenResponse;
import com.medicalInfo.project.model.KakaoUserResponse;
import com.medicalInfo.project.model.MemberDTO;
import com.medicalInfo.project.model.MemberInfoDTO;
import com.medicalInfo.project.model.MemberType;
import com.medicalInfo.project.model.WaitForExpertDTO;
import com.medicalInfo.project.service.KaKaoService;
import com.medicalInfo.project.service.MemberService;
import com.medicalInfo.project.service.WaitForExpertService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class KakaoController {  

	private boolean isLogin = false; // 로그인 상태를 나타내는 변수

	@Autowired 
	WaitForExpertService waitForExpertService;
	
	@Autowired
	KaKaoService kakaoService;
	
	@Autowired
	MemberService memberService;

	@GetMapping("/login")
	public void login() {
		log.info("로그인!!");
	}
	
	@GetMapping("/register")
	public void register() {
		log.info("회원가입!");
	}

	@GetMapping("/oauth")
	public String oauthResult(KaKaoOauthResponse response, Model model, HttpSession session,
			RedirectAttributes redirectAttributes) throws NamingException {
		log.info("이거null임?" + response.getCode());
		KakaoTokenResponse token = kakaoService.getToken(response);		
		if (token != null && token.getAccess_token() != null) {
			KakaoUserResponse userInfo = kakaoService.getUserInfo(token.getAccess_token());
			String kakaoEmail = userInfo.getKakao_account().getEmail();
			session.setAttribute("kakaoEmail", kakaoEmail);
			Boolean check = memberService.isMem(kakaoEmail);
			if (check) {
				session.setAttribute("userInfo", userInfo);
				session.setAttribute("isLogin", isLogin);			
			} else {
				model.addAttribute("kakaoEmail", kakaoEmail);
				return "redirect:/register";
			}
		} else {
			log.info("로그인 실패");
			session.setAttribute("isLogin", isLogin);
			redirectAttributes.addFlashAttribute("error", "로그인 실패");
		}
		return "redirect:/loginidpw";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		isLogin = false;
		session.invalidate();
		return "redirect:/login";
	}
}
