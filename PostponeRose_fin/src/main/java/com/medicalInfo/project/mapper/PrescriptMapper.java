package com.medicalInfo.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.medicalInfo.project.model.Criteria;
import com.medicalInfo.project.model.PrescriptDTO;

@Mapper
public interface PrescriptMapper {
	// memberNum과 일치하는 prescript 게시글 목록 반환
	
	public List<PrescriptDTO> selectAll(Criteria prescriptCriteria);
	

	// prescript_no 
	public PrescriptDTO select(int prescript_no);

	public PrescriptDTO selectMemberNum(int memberNum);


	public int getTotalCount(Criteria cri, @Param("memberNum")int memberNum);


	public int listCount(int memberNum);


	public int getTotal(Criteria cri);


	public List<PrescriptDTO> selectExpertAll(Criteria cri);


	public int getExpertTotal(Criteria cri);

	public List<PrescriptDTO> showMyPrescription(int memberNum);

	public void insertPrescript(PrescriptDTO prescriptDTO);

	public int getPresriptID();

	public void insertMemPrescript(PrescriptDTO prescriptDTO);


	public PrescriptDTO getPrescript(int prescript_no);

	@Delete("DELETE FROM prescript WHERE prescript_no=#{prescript_no}")
	public void deletePrescript(int prescript_no);


	public int getPrescriptTotal(Criteria cri);


	public List<PrescriptDTO> getPreList(Criteria cri);

	
}
