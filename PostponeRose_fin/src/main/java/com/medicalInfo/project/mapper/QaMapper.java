package com.medicalInfo.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.web.bind.annotation.RequestParam;

import com.medicalInfo.project.model.CommentDTO;
import com.medicalInfo.project.model.Criteria;
import com.medicalInfo.project.model.PrescriptDTO;
import com.medicalInfo.project.model.PrescriptDetailDTO;
import com.medicalInfo.project.model.QaDTO;
import com.medicalInfo.project.model.RatingDTO;

@Mapper
public interface QaMapper {
	// 게시판 전체조회
		public List<QaDTO> allList();
		
		//게시글이 내꺼인지 판단 
		public boolean isMine(int MemberNo);
		
		public int updateQa(QaDTO dto);
		
		public int deleteQa(int qa_id);
		
		//처방전 o
		public void insertQa(QaDTO dto);
		
		//처방전x
		public void  QaInsert(QaDTO dto);
		
		//한개의 게시글 
		public QaDTO getList(int qa_id);
		
		//페이징만 했을떄
		public List<QaDTO> getListWithPasing(Criteria cri);
		
		public List<PrescriptDTO> getMyPrescripts(Criteria cri);
		
		public int getMyPrescriptsCount(int memberNum);
		//총게시물이 몇개인지
		public int getTotalCount(Criteria cri);
		
		public int getListTotalCount(Criteria cri);
		
		//페이징과 검색기능까지 
		public List<QaDTO> getListWithSearch(Criteria cri);
		
		//자기 처방전가져오기
		public PrescriptDTO MyPrescript(int prescriptNo);
		
		//글작성할떄 나의처방전가져오기
		public List<PrescriptDTO>  registerMyPrescript(int MemberNO);
		
		public List<PrescriptDetailDTO> getPrescriptDetial(int prescriptNo);
		
		public int countRating(RatingDTO ratingdto);
		
		public int bestRating();

		public QaDTO getQaByQaNo(int ratedqa_no);
		
		public PrescriptDTO getPrescriptByNo(int prescript_no);
		
		//미나님거 
		List<QaDTO> selectQaList(Criteria cri);
		
		int getQaTotal(Criteria cri);
		
		List<CommentDTO> selectQaCommentList(Criteria cri);
		
		int getQaCommentTotal(Criteria cri);

		public int updateQaPre(QaDTO dto);
		
		public int incrementViewCnt(int qa_id);
}