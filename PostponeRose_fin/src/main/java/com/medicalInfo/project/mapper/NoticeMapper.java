package com.medicalInfo.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.medicalInfo.project.model.Criteria;
import com.medicalInfo.project.model.NoticeDTO;

@Mapper
public interface NoticeMapper {
	
	@Select("SELECT * FROM announcement")
	public List<NoticeDTO> allnotice();
	
	@Select("SELECT * FROM announcement WHERE id_announcement = #{id_announcement}")
	public NoticeDTO getNoticeById(int id_announcement);

	public void saveNotice(NoticeDTO notice);
	
	@Delete("DELETE FROM announcement WHERE id_announcement=#{id_announcement}")
	public void deleteNotice(int id_announcement);
	
	public void modNotice(NoticeDTO notice);
	
	public int getTotalCount(Criteria cri);
	
	public List<NoticeDTO> getListWithPasing(Criteria cri);
	

	
}
