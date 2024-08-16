package com.medicalInfo.project.util;

import com.google.gson.Gson;

public class JsonUtil {
	
	public static <T> T parseJson(String jsonString, Class<T> clazz) {
		Gson gson = new Gson();
		T result = gson.fromJson(jsonString, clazz);
		
		
		return result;
	}

}
