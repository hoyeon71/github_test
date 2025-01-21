package com.ghayoun.ezjobs.common.util;

// Sample program to decode a Base64 text file into a binary file.
// Author: Christian d'Heureuse (www.source-code.biz)

import biz.source_code.base64Coder.Base64Coder;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class Base64FileCoder {

	private static void decodeFile (String inputFileName, String outputFileName) throws IOException {
		BufferedReader in = null;
		BufferedOutputStream out = null;
		
		try {
			in = new BufferedReader(new FileReader(inputFileName));
			out = new BufferedOutputStream(new FileOutputStream(outputFileName));
			decodeStream (in, out);
			out.flush(); }
		finally {
			if (in != null) in.close();
			if (out != null) out.close(); 
		}
   	}	

	private static void decodeStream (BufferedReader in, OutputStream out) throws IOException {
		while (true) {
			String s = in.readLine();
			if (s == null) break;
			byte[] buf = Base64Coder.decodeLines(s);
			out.write (buf); 
		}
	}

	private static void encodeFile (String inputFileName, String outputFileName) throws IOException {
		BufferedInputStream in = null;
		BufferedWriter out = null;
		
		try {
			in = new BufferedInputStream(new FileInputStream(inputFileName));
			out = new BufferedWriter(new FileWriter(outputFileName));
			encodeStream (in, out);
			out.flush(); }
		finally {
			if (in != null) in.close();
			if (out != null) out.close();
		}
	}

	private static void encodeStream (InputStream in, BufferedWriter out) throws IOException {
		int lineLength = 72;
		byte[] buf = new byte[lineLength/4*3];
		while (true) {
			int len = in.read(buf);
			if (len <= 0) break;
			out.write (Base64Coder.encode(buf, 0, len));
			out.newLine(); 
		}
	}
}
