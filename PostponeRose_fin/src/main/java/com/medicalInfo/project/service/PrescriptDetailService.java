package com.medicalInfo.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.medicalInfo.project.mapper.PrescriptDetailMapper;
import com.medicalInfo.project.model.PrescriptDetailDTO;
import com.medicalInfo.project.model.RatingDTO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class PrescriptDetailService {
	
	private final PrescriptDetailMapper prescriptDetailMapper;
	
	public PrescriptDetailService(PrescriptDetailMapper prescriptDetailMapper) {
		this.prescriptDetailMapper = prescriptDetailMapper;
	}

	public List<PrescriptDetailDTO> selectPrescript(int prescript_no) {
		log.info("PrescriptDetailService selectPrescript() 호출");
		return prescriptDetailMapper.selectPrescript(prescript_no);
	}
	
	public PrescriptDetailDTO get(int prescript_detailID) {
		log.info("PrescriptDetailService get prescript_detailID : " + prescript_detailID);
		return prescriptDetailMapper.select(prescript_detailID);
	}
	
	public void addRate(RatingDTO ratingDTO) {
		log.info("PrescriptRatingService addRate ratingDTO : " + ratingDTO);
		prescriptDetailMapper.insert(ratingDTO);
	}
	

	public void insertPrescriptDetail(PrescriptDetailDTO pdd) {
		prescriptDetailMapper.insertPrescriptDetail(pdd);
	}

	public void deleteDetail(int prescript_no) {
		prescriptDetailMapper.deleteDetail(prescript_no);
	}
	
	public int MyPrescriptRating(RatingDTO ratingdto) {
		return prescriptDetailMapper.countPrescriptRating(ratingdto);
	}
}
