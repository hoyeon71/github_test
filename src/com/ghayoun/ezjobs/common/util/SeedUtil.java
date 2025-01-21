package com.ghayoun.ezjobs.common.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

public class SeedUtil {
	
	public static Object getAttribute(String name) throws Exception {		
		return (Object) RequestContextHolder.getRequestAttributes().getAttribute(name, RequestAttributes.SCOPE_SESSION);
	}

	public static String encodeStr(String sourceText) throws Exception {
        
		String text = sourceText;
		
		// 원문.
		//System.out.println("원문 : " + text);
		
		//String encryptText = Base64.encode(seed.encrypt(text, key.getBytes(), "UTF-8"));
		String encryptText = Base64Coder.encodeString(text);
		
		// 암호문.
		//System.out.println("암호문 : " + encryptText);
		
		return encryptText;
	}

	public static String decodeStr(String sourceText) throws Exception {
		
		String encryptbytes = Base64Coder.decodeString(sourceText);
		
		//String decryptText = seed.decryptAsString(encryptbytes, keyString.getBytes(), "UTF-8");
		
		// 평문
		//System.out.println("평문 : " + encryptbytes);
		return encryptbytes;
	
	}
	


}