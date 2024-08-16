package com.medicalInfo.project.util;

import java.io.IOException;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import com.google.gson.Gson;

public class XmlUtil {
	public static <T> T parseXml(String xmlString, Class<T> clazz) throws IOException {
	
		XmlMapper xmlMapper = new XmlMapper();
		
		JsonNode node = xmlMapper.readTree(xmlString.getBytes());
		
		ObjectMapper jsonMapper = new ObjectMapper();
		String json = jsonMapper.writeValueAsString(node);
		System.out.println("xmlutil jsonNode:"+node);
		T result = JsonUtil.parseJson(json, clazz);
		
		return result;
	}
}
