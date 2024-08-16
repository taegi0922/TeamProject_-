package com.medicalInfo.project.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Member;
import java.net.URLEncoder;
import java.net.http.HttpHeaders;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.medicalInfo.project.model.Criteria;
import com.medicalInfo.project.model.MemberDTO;
import com.medicalInfo.project.model.PageDTO;
import com.medicalInfo.project.model.WaitForExpertDTO;
import com.medicalInfo.project.service.MemberService;
import com.medicalInfo.project.service.WaitForExpertService;

import lombok.extern.log4j.Log4j;
@Log4j
@Controller
public class FileDownloadController {
    
	private final String uploadFolder = "C:\\test\\upload";
	private final String uploadPicture = "C:\\test\\picture";
    
	@Autowired
	JavaMailSenderImpl mailSender;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	WaitForExpertService waitforexpertSerivce;
	
    @GetMapping("/waitforexpert")
    public void waitforexpert(Model model,Criteria cri) {
        	System.out.println("waitforexpert 여기 안들어오나?");
        	model.addAttribute("waitforexpertlist", memberService.waitforexpertList(cri));
        	
        	int total = memberService.waitforexpertTotalCnt(cri);
    		log.info(total);
    		
    		PageDTO pageResult = new PageDTO(cri,total);
    		model.addAttribute("pageMaker", pageResult);
    		log.info(pageResult);
    	
    }
    
    @GetMapping("/download")
    public void downloadFile(@RequestParam("fileName") String fileName,@RequestParam("fileType") String fileType, @RequestParam("originalFileName") String originalFileName, HttpServletResponse response, HttpServletRequest request) throws IOException {
    	// globals.properties
    	  File file = new File(uploadFolder, fileName+fileType);
    	  BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));

    	  //User-Agent : 어떤 운영체제로  어떤 브라우저를 서버( 홈페이지 )에 접근하는지 확인함
    	  String header = request.getHeader("User-Agent");
    	  String fileName_;

    	  if ((header.contains("MSIE")) || (header.contains("Trident")) || (header.contains("Edge"))) {
    	    //인터넷 익스플로러 10이하 버전, 11버전, 엣지에서 인코딩 
    	    fileName_ = URLEncoder.encode(originalFileName, "UTF-8");
    	  } else {
    	    //나머지 브라우저에서 인코딩
    	    fileName_ = new String(originalFileName.getBytes("UTF-8"), "iso-8859-1");
    	  }
    	  //형식을 모르는 파일첨부용 contentType
    	  response.setContentType("application/octet-stream");
    	  //다운로드와 다운로드될 파일이름
    	  response.setHeader("Content-Disposition", "attachment; filename=\""+ fileName+fileType + "\"");
    	  //파일복사
    	  FileCopyUtils.copy(in, response.getOutputStream());
    	  in.close();
    	  response.getOutputStream().flush();
    	  response.getOutputStream().close();
    }
    
    @GetMapping("/download2")
    public void downloadFile2(@RequestParam("fileName") String fileName,@RequestParam("fileType") String fileType,
    		@RequestParam("originalFileName") String originalFileName, HttpServletResponse response, HttpServletRequest request) throws IOException {
    	  File file = new File(uploadPicture, fileName+fileType);
    	  BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
    	  String header = request.getHeader("User-Agent");
    	  String fileName_;

    	  if ((header.contains("MSIE")) || (header.contains("Trident")) || (header.contains("Edge"))) {
    	    fileName_ = URLEncoder.encode(originalFileName, "UTF-8");
    	  } else {
    	    fileName_ = new String(originalFileName.getBytes("UTF-8"), "iso-8859-1");
    	  }
    	  response.setContentType("application/octet-stream");
    	  response.setHeader("Content-Disposition", "attachment; filename=\""+ fileName+fileType + "\"");
    	  FileCopyUtils.copy(in, response.getOutputStream());
    	  in.close();
    	  response.getOutputStream().flush();
    	  response.getOutputStream().close();
    }
    
    @PostMapping("/upload_ok")
	public String upload(@RequestParam("file") MultipartFile file,
			@RequestParam("picture") MultipartFile picture,
			@RequestParam("memberName") String memberName,
			@RequestParam("medicalLicense") String medicalLicense,
			@RequestParam("medicalInstitution") String medicalInstitution,
			@RequestParam("institutionTel") String institutionTel,
			@RequestParam("email") String email,
			@RequestParam("InstitutionAddress") String InstitutionAddress,HttpSession session) {
		String fileRealName = file.getOriginalFilename(); // 파일명을 얻어낼 수 있는 메서드!
		String pictureRealName = picture.getOriginalFilename();
		long size = file.getSize(); // 파일 사이즈
		String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."), fileRealName.length());
		String picExtension = pictureRealName.substring(pictureRealName.lastIndexOf("."), pictureRealName.length());		
		String uploadFolder = "C:\\test\\upload";
		String picFolder = "C:\\test\\picture";	
		UUID uuid = UUID.randomUUID();
		String[] uuids = uuid.toString().split("-");
		String uniqueName = uuids[0];
		
		MemberDTO mem = (MemberDTO) session.getAttribute("member_info");
		WaitForExpertDTO wfeDTO = new WaitForExpertDTO(mem.getMemberNum(), memberName, InstitutionAddress,
				institutionTel, medicalLicense, fileRealName,uniqueName,fileExtension,medicalInstitution,pictureRealName,uniqueName,picExtension,email);
		memberService.upload(wfeDTO);

		File saveFile = new File(uploadFolder + "\\" + uniqueName + fileExtension); // 적용 후
		File savePic = new File(picFolder + "\\" + uniqueName + picExtension); 
		try {
			file.transferTo(saveFile); 
			picture.transferTo(savePic);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "redirect:/login";
	}

    
    @PostMapping ("/delwaitforexpert")
    private String delWaitForExpert(@RequestParam("waitforexpertId")int waitforexpertId, @RequestParam("rejectReason") String rejectReason, @RequestParam("email")String email) {
    System.out.println("어려워"+waitforexpertId);
    WaitForExpertDTO wfe = waitforexpertSerivce.getWFEById(waitforexpertId);
    MemberDTO memdto =memberService.getMemberByMem(wfe.getMemberNum());
    System.out.println("여기 들어오나"+rejectReason);
    //waitforexpertSerivce.delWaitForExpert(waitforexpertId);      
    String setfrom = "pyun9704@gmail.com";
	String tomail = email; // 받는사람
	String title = "[약쳐봥]  전문가 회원신청이 거절 되었습니다";
	String content = System.getProperty("line.separator")+"[약쳐봥]" + memdto.getMemberName()+"회원님의" + System.getProperty("line.separator")
			+ "전문가 회원신청 거절 사유는: [" + rejectReason +  "] 입니다." + System.getProperty("line.separator"); //


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
	waitforexpertSerivce.delWaitForExpert(waitforexpertId);     
    return "redirect:/waitforexpert" ;
    
}
    
    @GetMapping("/modwaitforexpert")
    private String modMemberInfo(@RequestParam("memberNum")int memberNum ,@RequestParam("waitforexpertId")int waitforexpertId,@RequestParam("email")String email) {
    System.out.println("어려워22"+memberNum);
    MemberDTO memdto =memberService.getMemberByMem(memberNum);
    waitforexpertSerivce.modMemberInfo(memberNum);
    waitforexpertSerivce.delWaitForExpert(waitforexpertId);      
    
    String setfrom = "pyun9704@gmail.com";
   	String tomail = email; // 받는사람
   	String title = "[약쳐봥]  전문가 회원신청이 승인 되었습니다";
   	String content = System.getProperty("line.separator")+"[약쳐봥]" + memdto.getMemberName()+"전문가님의" + System.getProperty("line.separator")
   			+ "전문가 회원신청이 승인 되었습니다. 앞으로 [약쳐봥]에서 좋은 활동 기대하겠습니다. " + System.getProperty("line.separator"); //


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
    return "redirect:/waitforexpert" ;
    
}
    
	public String jasyptEncoding(String value) {
		String Key = "security";
		StandardPBEStringEncryptor pbeEnc = new StandardPBEStringEncryptor();
		pbeEnc.setAlgorithm("PBEWithMD5AndDES");
		pbeEnc.setPassword(Key);
		return pbeEnc.encrypt(value);
		

	}
}
