package com.ghayoun.ezjobs.common.util;

import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.springframework.web.multipart.MultipartFile;

public class FileUpload{

	public static boolean uploadFormFile(MultipartFile multiFile , String filePath , String newFileName)
		throws FileNotFoundException, IOException , Exception {

		ByteArrayOutputStream baos = null;
		InputStream stream = null;
		OutputStream bos = null;
	    boolean isSuccess = false;
		try{
			baos = new ByteArrayOutputStream();
			stream = multiFile.getInputStream();
			bos = new FileOutputStream(filePath + newFileName);
			int bytesRead = 0;
			byte[] buffer = new byte[8192];
			while ((bytesRead = stream.read(buffer, 0, 8192)) != -1) {
				bos.write(buffer, 0, bytesRead);
			}
			bos.close();
			stream.close();
			isSuccess = true;

		}catch(Exception exception){
           if(bos != null){bos.close();}
           if(stream != null){stream.close();}
     	   isSuccess = false;
        }
   	    return isSuccess;
    }
}