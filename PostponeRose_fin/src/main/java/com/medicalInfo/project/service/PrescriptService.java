package com.medicalInfo.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.medicalInfo.project.mapper.PrescriptDetailMapper;
import com.medicalInfo.project.mapper.PrescriptMapper;
import com.medicalInfo.project.model.Criteria;
import com.medicalInfo.project.model.PrescriptDTO;
import com.medicalInfo.project.model.PrescriptDetailDTO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class PrescriptService {
	
	private final PrescriptMapper prescriptMapper;
	private final PrescriptDetailMapper prescriptDetailMapper;
	
	public PrescriptService(PrescriptMapper prescriptMapper, PrescriptDetailMapper prescriptDetailMapper) {
		this.prescriptMapper = prescriptMapper;
		this.prescriptDetailMapper = prescriptDetailMapper;
	}
	
	public List<PrescriptDTO> listAll(Criteria prescriptCriteria) {
		log.info("PrescriptSevice listAll() 호출: "+prescriptCriteria);
		List<PrescriptDTO> list = prescriptMapper.selectAll(prescriptCriteria);
		System.out.println("PrescriptSevice 서비스에서list체크"+list.toString());
		return list;
	}
	
	public int listCount(int memberNum) {
		return prescriptMapper.listCount(memberNum);
	}
	
	public List<PrescriptDetailDTO> selectPrescript(int prescript_no) {
		log.info("PrescriptSevice selectPrescript() 호출");
		return prescriptDetailMapper.selectPrescript(prescript_no);
	}

	public PrescriptDTO get(Integer prescript_no) {
		log.info("PrescriptSevice get prescript_no : " + prescript_no);
		return prescriptMapper.select(prescript_no);
	}

	public Object memberNumGet(int memberNum) {
		log.info("PrescriptSevice memberNumGet memberNum : " + memberNum);
		return prescriptMapper.selectMemberNum(memberNum);
	}

	public int getTotal(Criteria cri) {
		cri.setType("all");
		return prescriptMapper.getTotal(cri);
	}

	public List<PrescriptDTO> expertListAll(Criteria cri) {
		log.info("PrescriptSevice expertListAll() 호출: "+cri);
		List<PrescriptDTO> expertList = prescriptMapper.selectExpertAll(cri);
		System.out.println("PrescriptSevice 서비스에서 expertList체크"+expertList.toString());
		return expertList;
	}

	public int getExpertTotal(Criteria cri) {
		cri.setType("all");
		return prescriptMapper.getExpertTotal(cri);
	}

	public List<PrescriptDTO> showMyPrescription(int memberNum) {
		List<PrescriptDTO> list = prescriptMapper.showMyPrescription(memberNum);
		System.out.println("list 체크"+list.toString());
		return list;
	}

	public int insertPrescipt(PrescriptDTO prescriptDTO) {
		prescriptMapper.insertPrescript(prescriptDTO);
		return prescriptMapper.getPresriptID();
	}

	public int insertMemPrescipt(PrescriptDTO prescriptDTO) {
		prescriptMapper.insertMemPrescript(prescriptDTO);
		return prescriptMapper.getPresriptID();
	}

	public void modPrescriptNo(int prescript_no) {
		prescriptMapper.showMyPrescription(prescript_no);
		
	}

	public PrescriptDTO getPrescript(int prescript_no) {
		return prescriptMapper.getPrescript(prescript_no);
	}

	public void deletePrescript(int prescript_no) {
		prescriptMapper.deletePrescript(prescript_no);
	}

	public int getListTotal(Criteria cri) {
		return prescriptMapper.getPrescriptTotal(cri);
	}

	public List<PrescriptDTO> getList(Criteria cri) {
		return prescriptMapper.getPreList(cri);
	}



}
