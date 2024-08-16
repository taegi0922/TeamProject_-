package com.medicalInfo.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.medicalInfo.project.mapper.WaitForExpertMapper;
import com.medicalInfo.project.model.WaitForExpertDTO;

@Service
public class WaitForExpertService {

	@Autowired
	WaitForExpertMapper waitForExpertMapper;
	
	public WaitForExpertDTO getExpertInfo(int memberNum) {
		return waitForExpertMapper.getExpertInfo(memberNum);
	}

	public void delWaitForExpert(int waitforexpertId) {
		waitForExpertMapper.delWaitForExpert(waitforexpertId);
	}

	public void modMemberInfo(int memberNum) {
		WaitForExpertDTO wfe = waitForExpertMapper.getExpertInfo(memberNum);
		waitForExpertMapper.modMemberInfo(wfe);
		
	}

	public WaitForExpertDTO getWFEById(int waitforexpertId) {
		// TODO Auto-generated method stub
		return waitForExpertMapper.getWFEById(waitforexpertId);
	}

	

}
