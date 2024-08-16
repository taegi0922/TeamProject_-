package com.medicalInfo.project.controller;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.medicalInfo.project.model.KakaoDTO;
import com.medicalInfo.project.model.MemberDTO;
import com.medicalInfo.project.model.MemberInfoDTO;
import com.medicalInfo.project.model.MemberType;
import com.medicalInfo.project.model.WaitForExpertDTO;
import com.medicalInfo.project.service.KaKaoService;
import com.medicalInfo.project.service.MemberService;
import com.mysql.cj.Session;

@Controller
public class RegisterController {

	private boolean isLogin = false;
	
	@Autowired
	MemberService memberService;


	@Autowired
	KaKaoService kakaoService;
	
	// 아이디 중복확인 
	@PostMapping("/user/register")
	public String register(@RequestParam("memberId") String memberId, @RequestParam("memberPw") String memberPw,
			@RequestParam("memberName") String memberName, @RequestParam("memberAddress") String memberAddress,
			@RequestParam("memberPhone") String memberPhone, @RequestParam("memberEmail") String memberEmail) {
		
		MemberDTO dto = new MemberDTO(memberId, jasyptEncoding(memberPw),
				memberName, memberAddress, memberPhone,memberEmail);
		
		System.out.println("dto체크" + dto.toString());
		KakaoDTO kakao = new KakaoDTO();
		kakao.setEmail(memberEmail);
		kakao.setName(memberName);
		memberService.registerMember(dto);
		memberService.registerKakao(kakao);
		memberService.registerMemberInfo(memberEmail);
		return "redirect:/login";
	}

	@GetMapping("/loginidpw")
	public void idpw() {
	}
	
	@PostMapping("/loginidpw")
	@ResponseBody
	public Boolean idpwcheck(@RequestParam("id") String id, @RequestParam("pw") String pw, HttpSession session) {
	    String kakaoEmail = (String) session.getAttribute("kakaoEmail");
	    Boolean check = memberService.idPWCheck(id, pw, kakaoEmail);	    
	    if (check) {
	        isLogin = true;
	        session.setAttribute("isLogin", isLogin);
	        System.out.println("로그인된거야? yes");
	        MemberDTO memberDto = memberService.getMember(kakaoEmail);
	        session.setAttribute("member_info", memberDto);
	        MemberType membertype = memberService.getMemberType(memberDto.getMemberNum());

	        session.setAttribute("membertype", membertype);
	        if (membertype == MemberType.EXPERT) {
	            System.out.println("멤버dto찍히나?" + memberDto);
	            MemberInfoDTO memInfo = memberService.getMemberInfo(memberDto.getMemberNum());
	            System.out.println("memInfo잘 찍히나?" + memInfo.toString());
	            session.setAttribute("memInfo", memInfo);
	        }
	        return check;
	    }
	    System.out.println("로그인 실패: 아이디 또는 비밀번호가 잘못되었습니다.");
	    return check;
	}
	
	@GetMapping("/applyExpert")
	public void form() {
	}

	
	@PostMapping("/user/memberIdCheck")
    @ResponseBody
    public boolean idCheck(@RequestParam("memberId")String memberid ) {
        System.out.println("보내졌니?");
        int cnt = memberService.memberIdChecked(memberid);
        System.out.println("cnt"+cnt);
        if(cnt == 0) {
            System.out.println("if문에 들어오니?");
            return true;
        }else if(cnt == 1){
            return false;
        }

        return false;
    }
	
	public String jasyptEncoding(String value) {
		String Key = "security";
		StandardPBEStringEncryptor pbeEnc = new StandardPBEStringEncryptor();
		pbeEnc.setAlgorithm("PBEWithMD5AndDES");
		pbeEnc.setPassword(Key);
		return pbeEnc.encrypt(value);
	}
}
