package com.medicalInfo.project.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.medicalInfo.project.model.Criteria;
import com.medicalInfo.project.model.MemberDTO;
import com.medicalInfo.project.model.NoticeDTO;
import com.medicalInfo.project.model.PageDTO;
import com.medicalInfo.project.service.NoticeService;
import com.medicalInfo.project.service.QaService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
public class NoticeController {
	
	private final String NoticeFolder = "C:\\test\\Notice";
	
	@Autowired
	private  NoticeService noticeService;
	@Autowired
	private  QaService qaService;

	@GetMapping("/notice") // 게시판 목록 조회
	public void allnotice(Model model,Criteria cri) {
		List<NoticeDTO> notices = noticeService.getNoticeList(cri);
		System.out.println("노티스 리스트: " + notices);
		model.addAttribute("allnotice", notices);
		
		int total = noticeService.noticeTotal(cri);
		log.info("total: "+total);
		
		PageDTO pageResult = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageResult);
		log.info("-------------- 페이징 --------------");
		log.info(pageResult);
	}
	
	@GetMapping("/noticedetail") // 게시글 상세보기
	public String noticedetail(@RequestParam("id_announcement") int id_announcement, Model model) {
		NoticeDTO notice = noticeService.getNoticeById(id_announcement);
		model.addAttribute("notice", notice);
		return "noticedetail";
	}
	
	@GetMapping("/noticewrite") // 게시글 작성
	public String noticewrite(Model model) {
		return "noticewrite";
	}
	
	@PostMapping("/insertnotice") // 게시글 등록
	public String insertnotice(@RequestParam("noticetitle") String noticetitle,
			 @RequestParam("noticecontent") String noticecontent, @RequestParam("writerName")String writerName,
			 @RequestParam("file") MultipartFile file,HttpSession session) {
		
		MemberDTO memberdto = (MemberDTO)session.getAttribute("member_info");
		int memberNum = memberdto.getMemberNum();
		String fileRealName = file.getOriginalFilename(); // 파일명을 얻어낼 수 있는 메서드!
		long size = file.getSize(); // 파일 사이즈
		String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."), fileRealName.length());
		String NoticeFolder = "C:\\test\\Notice";
		
		UUID uuid = UUID.randomUUID();
		System.out.println(uuid.toString());
		String[] uuids = uuid.toString().split("-");

		String uniqueName = uuids[0];
		System.out.println("생성된 고유문자열" + uniqueName);
		System.out.println("확장자명" + fileExtension);
		NoticeDTO notice = new NoticeDTO(noticecontent, memberNum, writerName, noticetitle, fileRealName, uniqueName, fileExtension);
		noticeService.saveNotice(notice);
		System.out.println("notice 잘찍히나");
		
		File saveFile = new File(NoticeFolder + "\\" + uniqueName + fileExtension); // 적용 후
		
		try {
			file.transferTo(saveFile); // 실제 파일 저장메서드(filewriter 작업을 손쉽게 한방에 처리해준다.)
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return "redirect:/notice";
	}
	
	@GetMapping("/deletenotice") // 게시글 삭제
	public String deletenotice(@RequestParam("id_announcement") int id_announcement) {
		System.out.println("id_announcement ㅇㅇㅇ" + id_announcement);
		noticeService.deleteNotice(id_announcement);
		return "redirect:/notice";
	}
	
	@GetMapping("/modnotice") // 게시글 수정
	public void modnotice(@RequestParam("id_announcement") int id_announcement, Model model) {
		NoticeDTO notice = noticeService.getNoticeById(id_announcement);

		model.addAttribute("notice", notice);
		System.out.println("id_announcement 수정수정" + id_announcement);
		noticeService.getNotice(id_announcement);
	}
	
	@PostMapping("/modnotice")
	public String modnotice(@RequestParam("id_announcement") int id_announcement,
	    @RequestParam("title") String noticetitle, @RequestParam("content") String noticecontent) {
		System.out.println("수정 커밋");
		NoticeDTO notice = new NoticeDTO();
		notice.setId_announcement(id_announcement);
		notice.setTitle(noticetitle);
		notice.setContent(noticecontent);
		noticeService.modNotice(notice);
		return "redirect:/noticedetail?id_announcement="+id_announcement;
	}
	
	   @GetMapping("/NoticeDownload")
	    public void downloadFile(@RequestParam("fileName") String fileName,@RequestParam("fileType") String fileType, @RequestParam("originalFileName") String originalFileName, HttpServletResponse response, HttpServletRequest request) throws IOException {
	    	// globals.properties
	    	  File file = new File(NoticeFolder, fileName+fileType);
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

}
