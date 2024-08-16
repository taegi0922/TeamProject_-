package com.medicalInfo.project.service;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.medicalInfo.project.model.KaKaoOauthResponse;
import com.medicalInfo.project.model.KakaoTokenResponse;
import com.medicalInfo.project.model.KakaoUserResponse;
import com.medicalInfo.project.util.RestApiUtil;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class KaKaoService {
	private static final String APPKEY = "bc19ac7c0d184c8fbf994a386db912f2";

    private final RestTemplate restTemplate;

    public KaKaoService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }
	
	//토큰 발급 기능
	public KakaoTokenResponse getToken(KaKaoOauthResponse response) {
		String url = "https://kauth.kakao.com/oauth/token";
		

		
		HashMap<String, String> headerData = new HashMap<String, String>();
		headerData.put("Content-type", "Content-type: application/x-www-form-urlencoded;charset=utf-8");
		
		HashMap<String, String> data = new HashMap<String, String>();
		data.put("grant_type", "authorization_code");
		data.put("client_id", APPKEY);
		data.put("redirect_uri", "http://localhost:8090/oauth");
		data.put("code", response.getCode());
		
		KakaoTokenResponse result = null;
		try {
			result = RestApiUtil.ConnHttpGetType(url,data,headerData, KakaoTokenResponse.class);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		log.info(result);
		return result;
		
	}
	
	public void logOut(HttpSession session) throws IOException {
		String url = "https://kauth.kakao.com/oauth/logout";
		
		HashMap<String, String> data = new HashMap<String, String>();
		data.put("client_id", APPKEY);
		data.put("client_id","http://localhost:8090/logout");
		
		
		RestApiUtil.logout(url,data);
		
	}
	
	 public KakaoUserResponse getUserInfo(String accessToken) throws RestClientException {
	        String url ="https://kapi.kakao.com/v2/user/me?";
	        System.out.println("나 access Token 이야"+accessToken);
	        // 설정된 HttpHeaders에 Authorization 헤더 추가
	        HashMap<String, String> headerData = new HashMap<String, String>();
	        headerData.put("Authorization", "Bearer " + accessToken);
	        headerData.put("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

	        HashMap<String,String > data = new HashMap<String, String>();
	        
	        KakaoUserResponse result = null;
			try {
				result = RestApiUtil.ConnHttpGetType(url,data,headerData, KakaoUserResponse.class);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			log.info("메서드 결과물인데 되냐?"+result);
			return result;
	
	   }

}
