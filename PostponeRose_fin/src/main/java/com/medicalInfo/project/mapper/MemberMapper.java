package com.medicalInfo.project.mapper;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.medicalInfo.project.model.Criteria;
import com.medicalInfo.project.model.KakaoDTO;
import com.medicalInfo.project.model.MemberDTO;
import com.medicalInfo.project.model.MemberInfoDTO;
import com.medicalInfo.project.model.MemberType;
import com.medicalInfo.project.model.WaitForExpertDTO;


public interface MemberMapper {
	
	public void insertMember(MemberDTO dto);
	 
	public void insertKakaoEmail(KakaoDTO dto);
	
	public void insertMemberInfo(MemberInfoDTO dto);
	
	public MemberDTO getMember(String email);
	
	public int isMem(@Param("kakaoEmail") String kakaoEmail);

	public List<String> idPwCheck(@Param("id") String id, @Param("email") String email);

	@Select("SELECT memberType FROM member_info WHERE memberNum = #{memberNum}")
	public String getMemberType(int memberNum);

	public void uploadFile(WaitForExpertDTO wfeDTO);

	public List<WaitForExpertDTO> waitforexpertList(Criteria cri);
	
	public int waitforexpertTotalCount(Criteria cri);

	public void modPw(@Param("memberNum") String memberNum,@Param("memberPw") String memberPw);
	
	public void updateMem(MemberDTO dto);
	
	public int delete(MemberDTO memberDTO);

	public MemberInfoDTO getMemberInfo(int memberNum);

	public MemberDTO getMemberByMem(int member_num);
	
	public int memberIdcheck(String memberid);
}
