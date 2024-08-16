package com.medicalInfo.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.medicalInfo.project.mapper.BestExpertMapper;
import com.medicalInfo.project.model.Criteria;
import com.medicalInfo.project.model.MemberDTO;
import com.medicalInfo.project.model.MemberInfoDTO;
import com.medicalInfo.project.model.MyPrescriptRatingDTO;
import com.medicalInfo.project.model.MyQaRatingDTO;
import com.medicalInfo.project.model.QaDTO;
import com.medicalInfo.project.model.RatingDTO;
import com.medicalInfo.project.model.RatingTotDTO;

import lombok.AllArgsConstructor;
import lombok.extern.java.Log;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BestExpertService {
	
	private final BestExpertMapper bestExpertMapper;
	
	public RatingDTO ExpertTop() {
		System.out.println("전문가1rating"+bestExpertMapper.bestExpert());
		return bestExpertMapper.bestExpert();
	}
	
	public MemberInfoDTO bestFirst(int expertNum) {
		System.out.println("전문가memberinfo"+bestExpertMapper.firstExpert(expertNum));
		return bestExpertMapper.firstExpert(expertNum);
	}
	
	public MemberDTO RatingName(int expertNum) {
		System.out.println("너의이름은뭐니"+bestExpertMapper.ExpertName(expertNum));
		return bestExpertMapper.ExpertName(expertNum);
	}
	
	public RatingDTO ExpertSecondTop() {
		System.out.println("전문가222rating"+bestExpertMapper.bestSecondExpert());
		return bestExpertMapper.bestSecondExpert();
	}
	
	public RatingDTO ExpertThridTop() {
		System.out.println("전문가333rating"+bestExpertMapper.bestThirdExpert());
		return bestExpertMapper.bestThirdExpert();
	}
	
	public RatingDTO myAvgRating(int expertNum){
		System.out.println("나의평균평점"+expertNum);
		return bestExpertMapper.myRating(expertNum);
	}
	
	public List<MyQaRatingDTO> myQaRating(Criteria cri){
		return bestExpertMapper.qaRatingList(cri);
	}
	
	public List<MyPrescriptRatingDTO> myPrescriptRating(Criteria cri){
		return bestExpertMapper.prescriptRatingList(cri);
	}

	public List<RatingTotDTO> getList(Criteria cri) {
		// TODO Auto-generated method stub
		return bestExpertMapper.getListWithSearch(cri);
	}

	public int getListTotal(Criteria cri) {
		System.out.println("getListTotalCount>>>>"+cri);
		return bestExpertMapper.getListTotalCount(cri);
	}

	public List<RatingTotDTO> getRateList(Criteria cri) {
		
		System.out.println("Service In" + cri);
		log.info("-------------- Service in --------------");
		log.info(cri);
		List<RatingTotDTO> result = bestExpertMapper.getListWithSearch(cri);
		log.info("-------------- list out --------------");
		log.info(result);
		return result;
		
	}

	public int getMPR(Criteria cri) {
		// TODO Auto-generated method stub
		return bestExpertMapper.getMPRT(cri);
	}

	public int getMQR(Criteria cri) {
		// TODO Auto-generated method stub
		return bestExpertMapper.getMQRT(cri);
	}
}
