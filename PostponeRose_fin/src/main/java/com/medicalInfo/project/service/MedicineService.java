package com.medicalInfo.project.service;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.medicalInfo.project.model.MedicineResponse;
import com.medicalInfo.project.util.RestApiUtil;

@Service
public class MedicineService {

	// 실제 기상청_단기예보 API 요청 서비스를 요청할때 필요한 정보 작성
	public static MedicineResponse apiTest() {
		String url = "http://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList";
		System.out.println("여기로왔나?");
		// 요청 변수를 저장하기 위한 map 선언
		HashMap<String, String> data = new HashMap<String, String>();
		data.put("ServiceKey",
				"52hUuwZkGcmIn8daxaXmr0bjQytOKkbKltQsPA5J5d5IcoVpvU4Kk7jwPzlIBcf9hftYnTUD9NclotFT5eo+yQ==");
		data.put("pageNo", "1");
		data.put("numOfRows", "100");
		data.put("entpName", "");
		data.put("itemName", "");
		data.put("itemSeq", "");
		data.put("efcyQesitm", "");
		data.put("useMethodQesitm", "");
		data.put("atpnWarnQesitm", "");
		data.put("atpnQesitm", "");
		data.put("intrcQesitm", "");
		data.put("seQesitm", "");
		data.put("depositMethodQesitm", "");
		data.put("openDe", "");
		data.put("updateDe", "");
		data.put("type", "json");

		HashMap<String, String> headerData = new HashMap<String, String>();
		headerData.put("Content-type", "application/json");
		System.out.println("서비스 체크");
		// 실제 API 요청 후 응답을 반환 받는 ConnHttpGetType 메서드 호출
		// url : 요청할 주소
		// data: 요청시 필요한 파라미터
		// headrData : 요청시 http 헤더에 필요한 파라미터
		// MedicieResponse.class : 응답을 매핑할 클래스 타입.(반환 타입)
		MedicineResponse result = null;
		try {
			result = RestApiUtil.ConnHttpGetType(url, data, headerData, MedicineResponse.class);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("result 체크" + result.toString());

		return result;

	}

	 	private static final int THREAD_POOL_SIZE = 10;
	    public List<MedicineResponse> medicineSearch(String search) {
	        String url = "http://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList";
	        String key = "52hUuwZkGcmIn8daxaXmr0bjQytOKkbKltQsPA5J5d5IcoVpvU4Kk7jwPzlIBcf9hftYnTUD9NclotFT5eo+yQ==";
	        ExecutorService executor = Executors.newFixedThreadPool(THREAD_POOL_SIZE);
	        List<CompletableFuture<MedicineResponse>> futures = new ArrayList<>();
	        for (int cnt = 1; cnt < 50; cnt++) {
	            int pageNo = cnt;
	            CompletableFuture<MedicineResponse> future = CompletableFuture.supplyAsync(() -> {
	                HashMap<String, String> data = new HashMap<>();
	                data.put("ServiceKey", key);
	                data.put("pageNo", String.valueOf(pageNo));
	                data.put("numOfRows", "100");
	                data.put("itemName", search);
	                data.put("type", "json");

	                HashMap<String, String> headerData = new HashMap<>();
	                headerData.put("Content-type", "application/json");

	                MedicineResponse result = null;
	                try {
	                    result = RestApiUtil.ConnHttpGetType(url, data, headerData, MedicineResponse.class);
	                } catch (IOException e) {
	                    e.printStackTrace();
	                }
	                return result;
	            }, executor);
	            futures.add(future);
	        }

	        List<MedicineResponse> results = new ArrayList<>();
	        for (CompletableFuture<MedicineResponse> future : futures) {
	            try {
	                MedicineResponse response = future.get();
	                results.add(response);
	            } catch (InterruptedException | ExecutionException e) {
	                e.printStackTrace();
	            }
	        }

	        executor.shutdown();
	        return results;
	    }
	    
	    public List<MedicineResponse> medicineSearchItemSeq(String itemSeq) {
	        String url = "http://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList";
	        String key = "52hUuwZkGcmIn8daxaXmr0bjQytOKkbKltQsPA5J5d5IcoVpvU4Kk7jwPzlIBcf9hftYnTUD9NclotFT5eo+yQ==";
	        ExecutorService executor = Executors.newFixedThreadPool(THREAD_POOL_SIZE);
	        List<CompletableFuture<MedicineResponse>> futures = new ArrayList<>();

	        for (int cnt = 1; cnt < 50; cnt++) {
	            int pageNo = cnt;
	            CompletableFuture<MedicineResponse> future = CompletableFuture.supplyAsync(() -> {
	                HashMap<String, String> data = new HashMap<>();
	                data.put("ServiceKey", key);
	                data.put("pageNo", String.valueOf(pageNo));
	                data.put("numOfRows", "100");
	                data.put("itemSeq", itemSeq);
	                data.put("type", "json");

	                HashMap<String, String> headerData = new HashMap<>();
	                headerData.put("Content-type", "application/json");

	                MedicineResponse result = null;
	                try {
	                    result = RestApiUtil.ConnHttpGetType(url, data, headerData, MedicineResponse.class);
	                } catch (IOException e) {
	                    e.printStackTrace();
	                }
	                return result;
	            }, executor);
	            futures.add(future);
	        }

	        List<MedicineResponse> results = new ArrayList<>();
	        for (CompletableFuture<MedicineResponse> future : futures) {
	            try {
	                MedicineResponse response = future.get();
	                results.add(response);
	            } catch (InterruptedException | ExecutionException e) {
	                e.printStackTrace();
	            }
	        }

	        executor.shutdown();
	        return results;
	    }
}
