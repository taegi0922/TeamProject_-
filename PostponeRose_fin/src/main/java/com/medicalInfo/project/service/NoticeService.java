package com.medicalInfo.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.medicalInfo.project.mapper.NoticeMapper;
import com.medicalInfo.project.model.Criteria;
import com.medicalInfo.project.model.NoticeDTO;

@Service
public class NoticeService {
	@Autowired
	private NoticeMapper noticemapper;
	
	public List<NoticeDTO> allnotice() {
		return noticemapper.allnotice();
	}

	public NoticeDTO getNoticeById(int id_announcement) {
		return noticemapper.getNoticeById(id_announcement);
	}

	public void saveNotice(NoticeDTO notice) {
		noticemapper.saveNotice(notice);
	}

	public void deleteNotice(int id_announcement) {
		noticemapper.deleteNotice(id_announcement);
	}

	public void modNotice(NoticeDTO dto) {
		noticemapper.modNotice(dto);		
	}

	public void getNotice(int id_announcement) {
		noticemapper.getNoticeById(id_announcement);		
	}
	
	public int noticeTotal(Criteria cri) {
		System.out.println("게시판총합"+cri);
		return  noticemapper.getTotalCount(cri);
	}

	public List<NoticeDTO> getNoticeList(Criteria cri){
		System.out.println("노티스서비스 페이징"+cri);
		return noticemapper.getListWithPasing(cri);
	}
}
