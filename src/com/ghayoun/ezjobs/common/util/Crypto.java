package com.ghayoun.ezjobs.common.util;

import java.security.*;
import java.io.*;

import javax.crypto.Cipher;
import javax.crypto.CipherOutputStream;

public class Crypto {
	
	public final String DEFAULT_KEY = "default.key";	
	public Key key = null;
	
	public Crypto() throws Exception{
		initKey();
	}
	
	public Crypto(String file_path) throws Exception{
		initKey(new File(file_path,DEFAULT_KEY));
	}
	
	public Crypto(String file_path,String file_name) throws Exception{
		initKey(new File(file_path,file_name));
	}
	
	public void initKey() throws Exception{
		InputStream is = this.getClass().getResourceAsStream(DEFAULT_KEY);
		if(is==null){
			String file_path = new File(Crypto.class.getProtectionDomain().getCodeSource().getLocation().getPath()).getParentFile().getAbsolutePath();
			File file = new File(file_path,DEFAULT_KEY);
			if (!file.exists()) {
				makekey(file);
			}
			is = new FileInputStream(file);
		}
		
		ObjectInputStream in = new ObjectInputStream(is);
		key = (Key)in.readObject();
		in.close();
	}
	
	public void initKey(File file) throws Exception{
		if (!file.exists()) {
			makekey(file);
		}
		
		ObjectInputStream in = new ObjectInputStream(new FileInputStream(file));
		key = (Key)in.readObject();
		in.close();
		
	}
	
	public void makekey(File file) throws IOException, NoSuchAlgorithmException{
		javax.crypto.KeyGenerator generator = javax.crypto.KeyGenerator.getInstance("DES");
		generator.init(128,SecureRandom.getInstance("SHA1PRNG"));
		Key key = generator.generateKey();
		ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream(file));
		out.writeObject(key);
		out.close();
	}
	
	public String encrypt(String ID) throws Exception{
		if ( ID == null ) return null;
		if ( ID.length() == 0 ) return "";
		javax.crypto.Cipher cipher = javax.crypto.Cipher.getInstance("DES/ECB/PKCS5Padding");
		cipher.init(javax.crypto.Cipher.ENCRYPT_MODE,key);
		String amalgam = ID;
	  
		byte[] inputBytes1 = amalgam.getBytes("UTF8");
		byte[] outputBytes1 = cipher.doFinal(inputBytes1);
		
		//sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();        
		//String outputStr1 = encoder.encode(outputBytes1);
		String outputStr1 = Base64Coder.encodeLines(outputBytes1);
		return outputStr1.replaceAll("\r\n", "\n").replaceAll("\n", "");
	}
	
	public String decrypt(String codedID) throws Exception{
		if ( codedID == null ) return null;
		if ( codedID.length() == 0 ) return "";
		javax.crypto.Cipher cipher = javax.crypto.Cipher.getInstance("DES/ECB/PKCS5Padding");
		cipher.init(javax.crypto.Cipher.DECRYPT_MODE, key);
		
		//sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();
		//byte[] inputBytes1  = decoder.decodeBuffer(codedID);
		byte[] inputBytes1  = Base64Coder.decodeLines(codedID);
		byte[] outputBytes2 = cipher.doFinal(inputBytes1);
	  
		String strResult = new String(outputBytes2,"UTF8");
		return strResult;
	}

	//file
	public void encrypt(File inputFile, File outputFile) throws Exception {
		doCrypto(Cipher.ENCRYPT_MODE, inputFile, outputFile);
	}
	public void decrypt(File inputFile, File outputFile) throws Exception {
		doCrypto(Cipher.DECRYPT_MODE, inputFile, outputFile);
	}

	private void doCrypto(int cipherMode, File inputFile, File outputFile) throws Exception {
		InputStream is = null;
		OutputStream os = null;
		try {
			Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
			cipher.init(cipherMode, key);

			is = new FileInputStream(inputFile);
			os = new FileOutputStream(outputFile,false);
			
			CipherOutputStream cos = new CipherOutputStream(os, cipher );
			byte [] buffer = new byte [8192];  
			int r;  
			while ((r = is.read(buffer)) >= 0) {  
				cos.write(buffer, 0, r);  
			}
			
			cos.close();
		}catch(Exception e) {
			throw e;
		}finally{
			if(os!=null) os.close();
			if(is!=null) is.close();
		}
	}
}