import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.Socket;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.ghayoun.ezjobs.common.util.CommonUtil;

public class if_test {

	public static void main(String[] args) {
		
		try {
			ifCheckCall("1");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	
	
	
	public static void ifCheckCall(String if_name) throws Exception {
		
		BufferedReader br = null;
		
		try {
			
			//URL obj = new URL("http://weimst.woorifg.com/inf/callContMIntfChk.do");
			URL obj = new URL("http://weimsp.woorifg.com/inf/callContMIntfChk.do");
			HttpURLConnection conn = (HttpURLConnection) obj.openConnection();
			
			conn.setRequestMethod("POST");			
			conn.setDoOutput(true);
			
			OutputStream out = conn.getOutputStream();
			
			out.write(("INTFID=" + URLEncoder.encode("UTMMR0040054", "UTF-8")).getBytes());
			
			br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			
			String line = "";
			
			while ((line = br.readLine()) != null) {
				System.out.println(URLDecoder.decode(line, "UTF-8"));
			}

		}catch(ConnectException e){
		    e.printStackTrace();
		    throw e;
		}catch(IOException e){
		    e.printStackTrace();
		    throw e;
		}catch(Exception e){
		    e.printStackTrace();
		    throw e;
		} finally {
			if ( br != null ) {
				br.close();
			}
		}
	}
}
