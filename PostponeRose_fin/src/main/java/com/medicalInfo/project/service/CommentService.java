package com.medicalInfo.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.medicalInfo.project.mapper.CommentMapper;
import com.medicalInfo.project.model.CommentDTO;
import com.medicalInfo.project.model.MemberType;
import com.medicalInfo.project.model.RatingDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class CommentService {
	
	private final CommentMapper commentMapper;
	
	public void preWrite(CommentDTO commentDTO) {
		log.info("CommentService write commentDTO : " + commentDTO);
		commentMapper.insert(commentDTO);
	}
	
	public Integer preWriteKey(CommentDTO commentDTO) {
		log.info("CommentService writeKey commentDTO : " + commentDTO);
		commentMapper.insertCommentPrescriptNo(commentDTO);
		return commentDTO.getPrescript_no();
	}
	
	public List<CommentDTO> preSelectComment(int prescript_no) {
		log.info("CommentService selectComment() 호출");
		return commentMapper.selectComment(prescript_no);
	}
	
	public CommentDTO preGet(Integer prescript_no) {
		log.info("CommentService get prescript_no" + prescript_no);
		return commentMapper.select(prescript_no);
	}
	
	public CommentDTO preGetComment(int comment_id) {
		log.info("CommentService getComment comment_id" + comment_id);
		return commentMapper.selectcomment(comment_id);
	}

	public int preModify(CommentDTO commentDTO) {
		log.info("CommentService modify commentDTO" + commentDTO);
		return commentMapper.update(commentDTO);
	}
	
	public Integer preModifyKey(CommentDTO commentDTO) {
		log.info("CommentService modifyKey commentDTO : " + commentDTO);
		commentMapper.insertCommentPrescriptNo(commentDTO);
		return commentDTO.getPrescript_no();
	}

	public int preRemove(CommentDTO commentDTO) {
		log.info("CommentService remove commentDTO" + commentDTO);
		return commentMapper.delete(commentDTO);
	}
	
	// 태기님
	 public List<CommentDTO> listMyComment(int qa_id){
		 log.info("listMyPrescriptDetail"+qa_id);
		 return commentMapper.getComments(qa_id);
	 }
	 
	 // 수정
	 public int modify(CommentDTO commentDTO){
		 log.info("CommentService modify commentDTO" + commentDTO);
		 return commentMapper.QAComUpdate(commentDTO);
	 }
	 //댓글 등록
	  public void write(CommentDTO commentDTO) {
	        log.info("CommentService write commentDTO : " + commentDTO);
	        commentMapper.QAComInsert(commentDTO);
	    }
	 
	    
	    //댓글 삭제 
	    public int remove(int comId) {
			log.info("remove comId: " + comId);
				
		return commentMapper.QaComDelete(comId);
		}
	    
	    public int commentid(int comId ){
	    	return commentMapper.QaComDelete(comId);
	    }
	    
	    public MemberType expertmemtype(int writer){
	    	System.out.println("expertmemtype>>>>"+writer);
	    	return commentMapper.expertType(writer);
	    }
	    
	    public void rating(RatingDTO ratingDTO) {
	    	System.out.println("rating>>>>"+ratingDTO);
	    	commentMapper.RatingInsert(ratingDTO);
	    }
	    
	    public void prescriptRating(RatingDTO ratingDTO) {
	    	System.out.println("prescriptRating>>>>"+ratingDTO);
	    	commentMapper.RatingPrescriptInsert(ratingDTO);
	    }
}
