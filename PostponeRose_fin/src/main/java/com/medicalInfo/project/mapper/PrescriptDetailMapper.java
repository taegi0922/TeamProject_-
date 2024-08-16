package com.medicalInfo.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.medicalInfo.project.model.PrescriptDetailDTO;
import com.medicalInfo.project.model.RatingDTO;
import com.mysql.cj.x.protobuf.MysqlxCrud.Delete;

public interface PrescriptDetailMapper {
	// prescript_no과 일치하는 prescripted_detail 게시글 목록 반환
	@Select("SELECT * FROM prescripted_detail WHERE prescript_no = #{prescript_no}")
	public List<PrescriptDetailDTO> selectPrescript(int prescript_no);

	// 게시글 조회
	public PrescriptDetailDTO select(int prescript_detailID);
	
	public void insertPrescriptDetail(PrescriptDetailDTO pdd);
	//별점
	public void insert(RatingDTO ratingDTO);
	
	@org.apache.ibatis.annotations.Delete("DELETE FROM prescripted_detail WHERE prescript_no = #{prescript_no}")
	public void deleteDetail(int prescript_no);
	
	public int countPrescriptRating(RatingDTO ratingDTO);
}
