package com.medicalInfo.project.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;

import javax.net.ssl.HttpsURLConnection;

public class RestApiUtil {

	//MedicieResponse result = RestApiUtil.ConnhttpGetType(url,data,headerData, MedicieResponse.class);
	
	public static <T>T ConnHttpGetType (String connUrl,HashMap<String, String> data, HashMap<String, String> headerData,
			Class<T> classType) throws IOException{
			StringBuilder urlBuilder = new StringBuilder(connUrl);
		
			int cnt = 0;
		
			for(String key : data.keySet()) {
			
				if(cnt==0) {
				urlBuilder.append("?"+URLEncoder.encode(key,"UTF-8")+"="+URLEncoder.encode(data.get(key), "UTF-8"));
				}else {
				urlBuilder.append("&"+URLEncoder.encode(key,"UTF-8")+"="+URLEncoder.encode(data.get(key), "UTF-8"));
				}
				cnt++;
				
			}
			// API에서 원하는 헤더 연결
			if((urlBuilder.toString()).startsWith("https")) {
				System.out.println("너 json이야?");
				return JsonUtil.parseJson(httpsConn(urlBuilder.toString(),headerData), classType);
			}else {
				
				return JsonUtil.parseJson(httpConn(urlBuilder.toString(),headerData), classType);
 			}
					
			
	}
	
	public static void logout (String connUrl,HashMap<String, String> data) throws IOException{
		
			System.out.println("여기는 들어와?");
			StringBuilder urlBuilder = new StringBuilder(connUrl);
		
			int cnt = 0;
		
			for(String key : data.keySet()) {
			
				if(cnt==0) {
				urlBuilder.append("?"+URLEncoder.encode(key,"UTF-8")+"="+URLEncoder.encode(data.get(key), "UTF-8"));
				}else {
				urlBuilder.append("&"+URLEncoder.encode(key,"UTF-8")+"="+URLEncoder.encode(data.get(key), "UTF-8"));
				}
				cnt++;
			}	
			
	}

	private static String httpConn(String connUrl, HashMap<String, String> headerData) throws IOException {
		URL url = new URL(connUrl);
		// 서비스를 요청할 API에 필요한 요청 파라미터 전달
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		for(String key : headerData.keySet()) {
			conn.setRequestProperty(key, headerData.get(key));
		}
		BufferedReader rd; // 텍스트 기반의 데이터를 읽을때 사용되는 객체
	       if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	    	   //응답 성공
	    	   //InputStramReader : 읽기 가능한 문자열 생성
	           rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	       } else {
	    	   //응답 실패
	           rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	       }
	    StringBuilder sb = new StringBuilder();
	    String line;
	    while ((line = rd.readLine()) != null) {
	         sb.append(line);
	    }
	    rd.close();
	    conn.disconnect();
	
		return sb.toString();
	}

	private static String httpsConn(String connUrl, HashMap<String, String> headerData) throws IOException {
		URL url = new URL(connUrl);
		// 서비스를 요청할 API에 필요한 요청 파라미터 전달
		HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		for(String key : headerData.keySet()) {
			conn.setRequestProperty(key, headerData.get(key));
		}
		BufferedReader rd; // 텍스트 기반의 데이터를 읽을때 사용되는 객체
	       if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	    	   //응답 성공
	    	   //InputStramReader : 읽기 가능한 문자열 생성
	           rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	       } else {
	    	   //응답 실패
	           rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	       }
	    StringBuilder sb = new StringBuilder();
	    String line;
	    while ((line = rd.readLine()) != null) {
	         sb.append(line);
	    }
	    rd.close();
	    conn.disconnect();

		return sb.toString();
	}
}
