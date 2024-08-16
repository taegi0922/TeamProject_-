package com.medicalInfo.project.service;

import java.util.List;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.medicalInfo.project.mapper.MemberMapper;
import com.medicalInfo.project.model.Criteria;
import com.medicalInfo.project.model.KakaoDTO;
import com.medicalInfo.project.model.MemberDTO;
import com.medicalInfo.project.model.MemberInfoDTO;
import com.medicalInfo.project.model.MemberType;
import com.medicalInfo.project.model.WaitForExpertDTO;

import lombok.extern.log4j.Log4j;


@Log4j
@Service
public class MemberService {
	
	@Autowired
	MemberMapper memberMapper;
	
	public boolean isMem(String kakaoEmail) {
		System.out.println("이거 isMem 리턴값");
		int check= memberMapper.isMem(kakaoEmail);
		System.out.println("check 체크"+check);
		if(check==1) {
			return true;
		} 
		return false;
	}
	
	public void registerMember(MemberDTO dto) {
	
		memberMapper.insertMember(dto);
		
	}	
	
	public void registerKakao(KakaoDTO dto) {
	
		memberMapper.insertKakaoEmail(dto);
		
	}
	
	public void registerMemberInfo(String email) {
		int memberNum = memberMapper.getMember(email).getMemberNum();
		
		MemberType membType = MemberType.PATIENT;
		
		MemberInfoDTO dto = new MemberInfoDTO();
		dto.setMemberNum(memberNum);
		dto.setMemberType(membType);
		
		memberMapper.insertMemberInfo(dto);
	}
	
	public boolean idPWCheck(String id, String pw, String email) {
		
		java.util.List<String> pwCheck = memberMapper.idPwCheck(id,email);
		for(String pw2 : pwCheck){
			if(pw.equals(jasyptDecoding(pw2))){
				
				System.out.println("입력한 비밀번호"+pw);
				System.out.println("DB 비밀번호"+jasyptDecoding(pw2));
				return true;
			}
			System.out.println("입력한 비밀번호"+pw);
			System.out.println("DB 비밀번호"+jasyptDecoding(pw2));
		}
		
		return false;
	}
	
	public String jasyptDecoding(String encryptedValue) {
	    String Key = "security";
	    StandardPBEStringEncryptor pbeEnc = new StandardPBEStringEncryptor();
	    pbeEnc.setAlgorithm("PBEWithMD5AndDES");
	    pbeEnc.setPassword(Key);
	    return pbeEnc.decrypt(encryptedValue);
	}

	public MemberDTO getMember(String kakaoEmail) {
		return memberMapper.getMember(kakaoEmail);
	}

	public MemberType getMemberType(int memberNum) {
		System.out.println("여기는 찍히나?");
		MemberType memberType=null; 
		String type= memberMapper.getMemberType(memberNum);
		System.out.println("memberType 이 안찍히는 걸까?:"+type);
		if(type.equals("PATIENT")) {
			memberType=MemberType.PATIENT;
		}else if(type.equals("EXPERT")) {
			memberType=MemberType.EXPERT;
		}else if(type.equals("ADMIN")) {
			memberType=MemberType.ADMIN;
		}
		System.out.println("memberType 출력"+memberType);
		return memberType;
	}

	public void upload(WaitForExpertDTO wfeDTO) {
		memberMapper.uploadFile(wfeDTO);
		
	}

	public List<WaitForExpertDTO> waitforexpertList(Criteria cri) {
		List<WaitForExpertDTO> list=  memberMapper.waitforexpertList(cri);
		System.out.println("리턴 값 체크"+list.toString());
		return list;
	}
	
	public void modPw(String memberNum, String memberPw) {
		memberMapper.modPw(memberNum,memberPw);
	}
	public int memberIdChecked(String memberid) {
		System.out.println("서비스 아이디중복 체크"+memberMapper.memberIdcheck(memberid));
	    return memberMapper.memberIdcheck(memberid);
	}
	
	public MemberInfoDTO getMemberInfo(int memberNum) {
		return memberMapper.getMemberInfo(memberNum);
		
	}
	
	public void updateMember(MemberDTO dto) {
		memberMapper.updateMem(dto);
	}

	// 박미나 추가
	public int withdraw(MemberDTO memberDTO) {
		log.info("memberService withdraw memberDTO" + memberDTO);
		return memberMapper.delete(memberDTO);
	}
	// 김태기 페이징
		public int waitforexpertTotalCnt(Criteria cri) {
			System.out.println("waitforexpertTotalCnt"+cri);
			return memberMapper.waitforexpertTotalCount(cri);
		}

		public MemberDTO getMemberByMem(int member_num) {
			// TODO Auto-generated method stub
			return memberMapper.getMemberByMem(member_num);
		}
}