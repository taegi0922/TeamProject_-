package com.medicalInfo.project.mapper;

import org.apache.ibatis.annotations.Update;

import com.medicalInfo.project.model.WaitForExpertDTO;

public interface WaitForExpertMapper {

    public WaitForExpertDTO getExpertInfo(int memberNum);

	public void delWaitForExpert(int waitforexpertId);
	
	public void modMemberInfo(WaitForExpertDTO wfe);

	public WaitForExpertDTO getWFEById(int waitforexpertId);

}