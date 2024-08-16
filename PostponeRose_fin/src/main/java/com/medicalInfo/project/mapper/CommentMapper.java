package com.medicalInfo.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.medicalInfo.project.model.CommentDTO;
import com.medicalInfo.project.model.MemberInfoDTO;
import com.medicalInfo.project.model.MemberType;
import com.medicalInfo.project.model.RatingDTO;
@Mapper
public interface CommentMapper {
	
		// prescript_no과 일치하는 Comment 게시글 목록 반환
		@Select("SELECT * FROM comment WHERE prescript_no = #{prescript_no}")
		public List<CommentDTO> selectComment(int prescript_no);
		
		// prescript_no 
		public CommentDTO select(int prescript_no);
		
		// prescript_no 
		public CommentDTO selectcomment(int comment_id);

		public void insert(CommentDTO commentDTO);

		public Integer insertCommentPrescriptNo(CommentDTO commentDTO);

		public int update(CommentDTO commentDTO);

		public int delete(CommentDTO commentDTO);
		
		
		
	// 태기님
	
	public List<CommentDTO> getComments(int qa_id);
	
	public void QAComInsert(CommentDTO commentDTO);
	
	public int QAComUpdate(CommentDTO commentDTO);
	
	public int QaComDelete(int comId);
	
	//rating expetype구하는 메서드
	public MemberType expertType(int writer);
	
	public void RatingInsert(RatingDTO ratingDTO);
	
	public void RatingPrescriptInsert(RatingDTO ratingDTO);
}
