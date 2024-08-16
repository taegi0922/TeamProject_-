package com.medicalInfo.project.controller;

import java.io.IOException;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.medicalInfo.project.model.MemberDTO;
import com.medicalInfo.project.service.MemberService;

@Controller
public class findIdPwController {
	
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	@GetMapping("/findid")
	public void findId() {

	}
	
	@GetMapping("/findpw")
	public void findPw() {

	}
	
	@GetMapping("/pwAuth")
	public void pwmod() {

	}
	// 아이디 비번 찾기 할때 이메일이 전송되었습니다 문구 띄우기
	@PostMapping("/id_auth.me")
	public String id_auth(@RequestParam("email") String email, HttpSession session) throws IOException {
		String kakaoEmail = (String)session.getAttribute("kakaoEmail");
		MemberDTO dto = memberService.getMember(kakaoEmail);

		String setfrom = "pyun9704@gmail.com";
		String tomail = email; // 받는사람
		String title = "[약쳐봥]  아이디 찾기 입니다";
		String content = System.getProperty("line.separator") + "안녕하세요 회원님" + System.getProperty("line.separator")
				+ "[약쳐봥] 당신의 아이디는 " + dto.getMemberId() + " 입니다." + System.getProperty("line.separator"); //

		System.out.println("이거찍혀?" + email);

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "utf-8");

			messageHelper.setFrom(setfrom);
			messageHelper.setTo(tomail);
			messageHelper.setSubject(title);
			messageHelper.setText(content);

			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return "redirect:/loginidpw";

	}

	@PostMapping("/pw_auth.me")
    @ResponseBody
	public String pw_auth(HttpSession session, @RequestParam("email") String email, @RequestParam("id") String id,
			Model model) throws IOException {
		String kakaoEmail = (String)session.getAttribute("kakaoEmail");
		MemberDTO dto = memberService.getMember(kakaoEmail);
		if (dto != null) {
			Random r = new Random();
			int num = r.nextInt(999999); // 랜덤난수설정
			if (dto.getMemberId().equals(id)) {
				String setfrom = "pyun9704@gmail.com";
				String tomail = email; // 받는사람
				String title = "[약쳐봥] 비밀번호변경 인증 이메일 입니다";
				String content = System.getProperty("line.separator") + "안녕하세요 회원님"
						+ System.getProperty("line.separator") + "[약쳐봥] 비밀번호찾기(변경) 인증번호는 " + num + " 입니다."
						+ System.getProperty("line.separator"); //
				try {
					MimeMessage message = mailSender.createMimeMessage();
					MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "utf-8");
					messageHelper.setFrom(setfrom);
					messageHelper.setTo(tomail);
					messageHelper.setSubject(title);
					messageHelper.setText(content);

					mailSender.send(message);
				} catch (Exception e) {
					System.out.println(e.getMessage());
				}

				session.setAttribute("num",num);
				return "redirect:/pwAuth";
			} else {

				return "redirect:/findpw";
			}
		} else {
			return "redirect:/findpw";
		}
	}

	@GetMapping("/idAuth")
	public void pwAuth() {
	}
	
	@GetMapping("/pw_new")
	public void pwNew() {
	}
	
	@PostMapping("/pw_set.me")
	@ResponseBody
	public String pw_set(@RequestParam("email_injeung") String emailInjeung, HttpSession session) {
	    int email_injeung = Integer.parseInt(emailInjeung);
	    int num = (int) session.getAttribute("num");

	    System.out.println("입력한 인증번호: " + email_injeung);
	    System.out.println("만든 인증번호: " + num);

	    if (email_injeung == num) {
	        return "success";
	    } else {
	        return "fail";
	    }
	}
	//이메일 인증번호 확인
	@RequestMapping(value = "/pw_new.me", method = RequestMethod.POST)
	public String pw_new(HttpSession session, @RequestParam("memberPw") String memberPw) throws IOException{
		String kakaoEmail = (String)session.getAttribute("kakaoEmail");
		System.out.println("memberPw 잘찍히나?"+memberPw);
		
		memberService.modPw(kakaoEmail,jasyptEncoding(memberPw));
		
		session.invalidate();
		return "redirect:/login";
	}
	
	public String jasyptEncoding(String value) {
		String Key = "security";
		StandardPBEStringEncryptor pbeEnc = new StandardPBEStringEncryptor();
		pbeEnc.setAlgorithm("PBEWithMD5AndDES");
		pbeEnc.setPassword(Key);
		return pbeEnc.encrypt(value);

	}
}