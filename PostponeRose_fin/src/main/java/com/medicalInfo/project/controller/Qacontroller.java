package com.medicalInfo.project.controller;

import java.util.List;

import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.medicalInfo.project.model.CommentDTO;
import com.medicalInfo.project.model.Criteria;
import com.medicalInfo.project.model.MemberDTO;
import com.medicalInfo.project.model.QaDTO;
import com.medicalInfo.project.model.Ratedtable_type;
import com.medicalInfo.project.model.RatingDTO;
import com.medicalInfo.project.model.TableType;
import com.medicalInfo.project.model.MemberType;
import com.medicalInfo.project.model.PageDTO;
import com.medicalInfo.project.service.CommentService;
import com.medicalInfo.project.service.MemberService;
import com.medicalInfo.project.service.PrescriptService;
import com.medicalInfo.project.service.QaService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Controller
@RequiredArgsConstructor
@RequestMapping("/qa/*")
@Log4j
public class Qacontroller {
	private static final int num = 0;
	
	@Autowired
	private final QaService qaService;
	@Autowired
	private final PrescriptService prescriptService;
	@Autowired
	private final CommentService commentService;

	@Autowired
	private final MemberService memberService;


	//전체 목록,페이징
	@GetMapping("/list")
	public String getlistQa(Model model,HttpSession session,Criteria cri){
		model.addAttribute("qadto", qaService.getList(cri));		
		int total = qaService.getListTotal(cri);
		
		PageDTO pageResult = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageResult);
		Boolean isLogin = (Boolean) session.getAttribute("isLogin");
		if (isLogin == null || isLogin == false) {
			return "redirect:/login";
		}
		return "qa/list";
	}
	
	@ResponseBody
	@PostMapping("/getList")
	public List<QaDTO> getList(Criteria cri, Model model) {
		log.info("Ajax로 전체 게시물 조회 >>> ");
		// 전체 테이블의 데이터 갯수 반환
		int total = qaService.getListTotal(cri);
		System.out.println("<<<<<<<<<total"+cri.toString());
		
		PageDTO pageResult = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageResult);
		
		System.out.println("@PostMapping(\"/getList\")"+pageResult);
		System.out.println(">>>>>>>>>>>>>"+qaService.getQaList(cri));
		return qaService.getQaList(cri);
		
	}
	
	
	// 삭제
	@PostMapping("/remove")
	public String remove(@RequestParam("qa_id") int qa_id, RedirectAttributes rttr,HttpSession session) {
		log.info("remove 들어가니? >>>");
		log.info("remove >>>"+ qa_id);
		 rttr.addFlashAttribute("qadto",qaService.remove(qa_id));
	
		return "redirect:/qa/list";
	}
	
	// 글등록 jsp
	@GetMapping("/register")
	public void registerGet(@RequestParam("memberNum")int memberNum,HttpSession session,Model model,Criteria cri) {
		log.info("registerGet >>>");
		int total = qaService.getMyPrescriptCount(memberNum);
		System.out.println("1>>>>>>>> "+total);
		cri.setMemberNum(memberNum);
		
		model.addAttribute("myPrescript",qaService.getMyPrescritList(cri));
		System.out.println("2>>>>>>>> "+qaService.getMyPrescritList(cri));
		PageDTO pageResult = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageResult);
//		model.addAttribute("myPrescript",qaService.registerMyPrescript(memberNum));
		System.out.println("registerGet >>>"+qaService.registerMyPrescript(memberNum));
	}
	
	//글등록하기
	@PostMapping("/register")
	public String register(@RequestParam("title") String title,@RequestParam("writer") String writer,@RequestParam("context") String context,@RequestParam("memberType")String membertype,
		@RequestParam("memberNum") int member_num,@RequestParam("prescript_no") String prescript_no,Model model,HttpSession session){
		log.info("Post>>>>register<<<<<<들어옴");
		MemberType memberType = null ;
		 int prescript;
		 if(membertype.equals("PATIENT")) {
			 memberType = memberType.PATIENT;
		 }else if(membertype.equals("EXPERT")) {
			 memberType = memberType.EXPERT;
		 }
		 
		
		 
		if(prescript_no == null || prescript_no == "") {
			log.info("혹시 if에 들어가니");
			 prescript = 0;
			 QaDTO DTO = new QaDTO(writer, member_num, title, context, memberType);
			 qaService.QaInsert(DTO);
		}else {
			// 처방전 o 
			 prescript = Integer.parseInt(prescript_no);
			 QaDTO dto = new QaDTO(writer, member_num, title, context, memberType, prescript);
			qaService.plus(dto);
			log.info("qaService.plus(dto)"+dto);
		}
	
		return "redirect:/qa/list";
	}
	
	// 한개의 게시글 
	@GetMapping({ "/get", "/modify" })
	public void detail(@RequestParam("qa_id") int qa_id,@RequestParam("prescript_no")String prescript_no, Model model,
		CommentDTO commentDTO,@RequestParam("memberNum")int memberNum, HttpSession session, HttpServletRequest request,Criteria cri){
		log.info("detail >>>");
		int prescript;
		model.addAttribute("commDTO", commentService.listMyComment(qa_id));
		log.info("commDTO >>>"+commentService.listMyComment(qa_id));
		
		request.setAttribute("q_ID", qaService.get(qa_id));
		if(prescript_no == null || prescript_no == "") {
			prescript = 0;
		}else {
			prescript = Integer.parseInt(prescript_no);
		}
		model.addAttribute("prescriptDTO", qaService.getPrescript(prescript));
		log.info("prescriptDTO >>>"+qaService.getPrescript(prescript));
		
		// 나의처방전가져오기 페이징
		int total = qaService.getMyPrescriptCount(memberNum);
		cri.setMemberNum(memberNum);
		System.out.println("1 modify>>>>>>>> "+total);
		model.addAttribute("myPrescript",qaService.getMyPrescritList(cri));
		System.out.println("2 modify>>>>>>>> "+qaService.getMyPrescritList(cri));
		
		PageDTO pageResult = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageResult);
		System.out.println("3 modify>>>>>>>> "+pageResult);
		
	}
	
	// 게시글 수정하기
	@PostMapping("/modify")
	public String modify(RedirectAttributes rttr,HttpSession session,@RequestParam("context") String context,
			@RequestParam("prescript_no") String prescript_no, @RequestParam("title") String title,@RequestParam("writer") String writer,@RequestParam("qa_id") int qa_id) {
		log.info("modify 들어가니? >>>");
		   int prescriptNo1 = 0;
		   int prescriptNo2 = 0;
		    // prescript_no가 빈 문자열이 아닌 경우에만 변환
		    if (!prescript_no.isEmpty()) {
		        prescriptNo1 = Integer.parseInt(prescript_no);
		        QaDTO dto = new QaDTO(writer, title, context, prescriptNo1, qa_id);
		        rttr.addFlashAttribute("qadto", qaService.modify(dto));
		        System.out.println("제발 수정되줘1111 " + dto.toString());
		    }else {
		    	QaDTO dto2 = new QaDTO(qa_id, writer, title, context);
		    	rttr.addFlashAttribute("qadto", qaService.modify2(dto2));
		    	System.out.println("제발 수정되줘2222 " + dto2.toString());
		    }

		    return "redirect:/qa/list";
		}
	
	// comment 작성
    @PostMapping("/write")
    public String write(@RequestParam("writer")int writer,@RequestParam("table_type")String type,@RequestParam("memberType")String memType,
    		@RequestParam("prescript_no")String prescript,
    		@RequestParam("memberPhone")int member_num,@RequestParam("qa_no")int qa_no,@RequestParam("writerName")String writerName ,
    		@RequestParam("content")String content,@RequestParam("title") String title, RedirectAttributes rttr,HttpSession session) {
        log.info("MypageController write >>>");
        int prescript_no;
        TableType tableType=null;
        CommentDTO dto = new CommentDTO();
        if(type.equals("QA")) {
        tableType = tableType.QA;
        }
        MemberType memberType=null;
        if(memType.equals("EXPERT")) {
        	memberType = memberType.EXPERT;
        }else if(memType.equals("PATIENT")) {
        	memberType = memberType.PATIENT;
        }
        if(prescript == null || prescript == "") {
    		prescript_no = 0;
		}else {
			prescript_no = Integer.parseInt(prescript);	      
		}
        dto = new CommentDTO(writer, content, tableType, qa_no, prescript_no, writerName, memberType);
        commentService.write(dto);
        MemberDTO memberdto =(MemberDTO) session.getAttribute("member_info");
        DefaultMessageService messageService = NurigoApp.INSTANCE.initialize("NCSGZXZLKLWSHU08","GGEZ6IIHKXSUSAMD1BQBRFNL1VZ9UP48",
        		"https://api.coolsms.co.kr"); 
        MemberDTO mem = memberService.getMemberByMem(member_num);
        Message message =  new Message();
        message.setFrom("01043731710");
        message.setTo(mem.getMemberPhone());
        message.setText(writerName+" 님의 댓글: ["+content+"]"); 
        message.setSubject("회원님의 QA:("+title+") 에 댓글이 달렸습니다."); 
        try { 
        	messageService.send(message); 
        } catch (NurigoMessageNotReceivedException exception) { // 발송에 실패한 메시지 목록을 확인할 수 있습니다!
			 System.out.println(exception.getFailedMessageList());
			 System.out.println(exception.getMessage()); 
		} catch (Exception exception) {
			 System.out.println(exception.getMessage()); 
		}
			 
        
        return "redirect:/qa/get?qa_id="+dto.getQa_no()+"&prescript_no="+dto.getPrescript_no()+"&memberNum="+memberdto.getMemberNum();
    }
    
    //댓글삭제
    @GetMapping("/commRemove")
    public String commRemove(@RequestParam("qa_id")int qa_id ,@RequestParam("prescript_no")String prescript, @RequestParam("comment_id")int comment_id,RedirectAttributes rttr,HttpSession session){
    	log.info("commRemove>>>>>>>>");
    	System.out.println("번호찍히나"+comment_id);
    	rttr.addAttribute("commID", commentService.commentid(comment_id));
    	
    	 MemberDTO memberdto =(MemberDTO) session.getAttribute("member_info");
    	
    	 return "redirect:/qa/get?qa_id="+qa_id+"&prescript_no="+prescript+"&memberNum="+memberdto.getMemberNum();
    }
    
    //댓글 수정
    @ResponseBody
    @PostMapping("/commUpdate")
    public boolean  modComment(@RequestParam("comment_id") String comment_id, @RequestParam("content") String content,RedirectAttributes rttr,HttpSession session) {
    	System.out.println("comment_id찍혀?"+comment_id);
    	int comid= Integer.parseInt(comment_id);
    	System.out.println("content 찍혀?"+content);
    	CommentDTO dto = new CommentDTO(comid, content);
    	int cnt = commentService.modify(dto);
    	if(cnt == 1) {
    		System.out.println("여기니?");
    		return true;
    	}else {
    		System.out.println("저기니?");
    		return false;
    	}
    }
    //평점 주기
    @ResponseBody
    @PostMapping("/Rating")
    public boolean rating(@RequestParam("expertNum") int expertNum, @RequestParam("userNum")int memberNum,
    		@RequestParam("userMemType")String userMemType,
    	@RequestParam("ratedtable_type")String ratedTable,@RequestParam("ratedqa_no")int ratedqa_no,@RequestParam("rating")int rating) {
    	RatingDTO ratingdto = new RatingDTO(memberNum, ratedqa_no, expertNum);

    	System.out.println("ratingdto<<<"+ratingdto);
    	int cntRating = qaService.duplicationRating(ratingdto);
    	System.out.println("cntRating>>>>>"+cntRating); 	
    		
    	if(cntRating == 0) {
        	MemberType expertype= commentService.expertmemtype(expertNum);
        	
        	Ratedtable_type ratedtable_type = null;
        	if(ratedTable.equals("QACOMMENT")) {
        		ratedtable_type = ratedtable_type.QACOMMENT;
        	}
        	MemberType membertype = null;
        	if(userMemType.equals("PATIENT")) {
        		membertype = membertype.PATIENT;
        	}else if(userMemType.equals("EXPERT")) {
        		membertype = membertype.EXPERT;
        	}
        	
        	RatingDTO ratingDTO = new RatingDTO(memberNum, ratedtable_type,membertype , ratedqa_no, rating, expertNum, expertype);
        	commentService.rating(ratingDTO);
        	
        	return true;
    	}if(cntRating == 1) {
    		return false;
    	}
    	return false;
    }
}
