package com.medicalInfo.project.service;

import java.util.List;

import javax.inject.Inject;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.medicalInfo.project.mapper.QaMapper;
import com.medicalInfo.project.model.CommentDTO;
import com.medicalInfo.project.model.Criteria;
import com.medicalInfo.project.model.PrescriptDTO;
import com.medicalInfo.project.model.PrescriptDetailDTO;
import com.medicalInfo.project.model.QaDTO;
import com.medicalInfo.project.model.RatingDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j

public class QaService {
	private final QaMapper qaMapper;
	
	@Inject
	public QaService(QaMapper qaMapper){
		this.qaMapper = qaMapper;
	}
	
	public List<QaDTO>listAllQa(){
		log.info("QaService listAllQa 들어옴");
		List<QaDTO>list = qaMapper.allList();		
		log.info(list);
		return list;
	}
	public int remove(int qa_id) {
		log.info("remove qa_id: " + qa_id);
			
		return qaMapper.deleteQa(qa_id);
	}
	public void plus(QaDTO dto) {
		log.info("plus: " + dto);
		qaMapper.insertQa(dto);
	}
	
	public void QaInsert(QaDTO dto) {
		log.info("QaInsert: " + dto);
		qaMapper.QaInsert(dto);
	}
	
	public QaDTO get(int qa_id) {
		log.info("get qa_id: " + qa_id);
		qaMapper.incrementViewCnt(qa_id);
		return qaMapper.getList(qa_id);
	}
	
	public int modify(QaDTO dto) {
		log.info("dto : " + dto);
			return qaMapper.updateQaPre(dto);
		}
	
	public int modify2(QaDTO dto) {
		return qaMapper.updateQa(dto);
	}
	
	public List<QaDTO> getList(Criteria cri){
		log.info("Criteria getList : " + cri);
		
		return qaMapper.getListWithSearch(cri);
	}
	
	public int getTotal(Criteria cri) {
		System.out.println("getTotal>>"+cri);
		return qaMapper.getTotalCount(cri);
	}
	public int getMyPrescriptCount(int memberNum) {
		return qaMapper.getMyPrescriptsCount(memberNum);
	}
	
	public List<PrescriptDTO> getMyPrescritList(Criteria cri){
		
		return qaMapper.getMyPrescripts(cri);
	}
	
	public int getListTotal(Criteria cri) {
		System.out.println("getListTotalCount>>>>"+cri);
		return qaMapper.getListTotalCount(cri);
	}
	
	public List<QaDTO> getQaList(Criteria cri) {
		System.out.println("Service In" + cri);
		log.info("-------------- Service in --------------");
		log.info(cri);
		List<QaDTO> result = qaMapper.getListWithSearch(cri);
		log.info("-------------- list out --------------");
		log.info(result);
		return result;
	}
	
	public PrescriptDTO getPrescript(int prescriptNo){
		System.out.println("getPrescript In>>>" + prescriptNo);
		return qaMapper.MyPrescript(prescriptNo);
	}
	
	public List<PrescriptDTO> registerMyPrescript(int memberNo) {
		System.out.println("Service registerMyPrescript>>>>"+memberNo);
		return qaMapper.registerMyPrescript(memberNo);
	}
	
	public List<PrescriptDetailDTO> myPrescriptDetail(int prescriptNo){
		System.out.println("Service>>myPrescriptDetail "+prescriptNo);
		System.out.println("Service>>myPrescriptDetail "+qaMapper.getPrescriptDetial(prescriptNo));
		return qaMapper.getPrescriptDetial(prescriptNo);
	}
	
	public int duplicationRating(RatingDTO ratingdto) {
		System.out.println("Service>>duplicationRating "+ratingdto);
		return qaMapper.countRating(ratingdto);
	}

	public QaDTO getQadtoByQaNo(int ratedqa_no) {
		
		return qaMapper.getQaByQaNo(ratedqa_no) ;
	}
	
	public PrescriptDTO getPrescriptdtoByNo(int prescript_no){
		return qaMapper.getPrescriptByNo(prescript_no);
	}
	
	
	
	//미나님거
	public List<QaDTO> getMyQaList(Criteria cri) {
    	System.out.println("서비스에서 prescriptCri 체크"+ cri);
    	List<QaDTO> qaMemberNumList = qaMapper.selectQaList(cri);
    	System.out.println("서비스에서 qaMemberNumList 체크"+ qaMemberNumList.toString());
    	return qaMemberNumList;
    }
	
	public int getQaTotal(Criteria cri) {
		cri.setType("all");
		return qaMapper.getQaTotal(cri);
	}
	
	public int getQaCommentTotal(Criteria cri) {
		cri.setType("all");
		return qaMapper.getQaCommentTotal(cri);
	}
	
	public List<CommentDTO> getQaCommentList(Criteria cri) {
		System.out.println("PrescriptQaMapper 서비스에서 cri 체크"+ cri);
    	List<CommentDTO> qaCommentList = qaMapper.selectQaCommentList(cri);
    	System.out.println("PrescriptQaMapper 서비스에서 getQaCommentList 체크"+ qaCommentList.toString());
    	return qaCommentList;
	}
	
	
}
