import java.io.BufferedWriter; 
import java.io.File; 
import java.io.FileNotFoundException; 
import java.io.FileOutputStream; 
import java.io.IOException; 
import java.io.OutputStreamWriter; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date; 
import java.util.List;

import edu.emory.mathcs.backport.java.util.Collections;

public class FileSearcher { 

    public static void main(String[] args) throws FileNotFoundException, IOException { 
    	
    	System.out.println("FileSearcher Start..."); 

        // 파일 최종 수정일 날짜 형식 
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
        
        // 읽어올 경로 
        File dir = new File("C:/project/EZJOBS/workspace/EZJOBS_WOORI/src");
        
        if(dir.exists() == false ) {
            System.out.println("경로가 존재 하지 않습니다."); 
            return ;
        }
        // 출력할 파일 경로 
        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream("D:/src.txt"))); 

        // 탐색할 파일을 저장할 리스트
        ArrayList files = new ArrayList();

        // 파일을 탐색한다.
        visitAllFiles(files, dir);
        
        List<String> list = new ArrayList<String>();

        // 탐색한 파일을 하나씩 출력할 파일에 쓴다.
        for(int i = 0; i < files.size(); i++) {
        	
        	File f = (File) files.get(i);
        	
            String line = sdf.format(new Date(f.lastModified())) + "|" + f.getAbsolutePath() +"\n";
            
            // class 파일은 제외한다.
            if ( !f.getAbsolutePath().substring(f.getAbsolutePath().lastIndexOf(".") + 1, f.getAbsolutePath().length()).equals("class")) {
            	list.add(line);
            }
        }
        
        Collections.sort(list);
        
        for ( int i = 0; i < list.size(); i++ ) {
        	String line = list.get(i);
        	bw.write(line);
        }
        
        bw.flush();
        bw.close();
    }


    /** 
     * 총 파일 수를 arraylist에 추가 합니다. 
     * 만약 검색된 부분이 디렉토리라면 하위 폴더를 탐색합니다. 
     */ 
    public static void visitAllFiles(ArrayList files, File dir) { 

        if(dir.isDirectory()) { 
            File[] children = dir.listFiles(); 
            for(File f : children) { 
                // 재귀 호출 사용 
                // 하위 폴더 탐색 부분 
                visitAllFiles(files,f); 
            } 
        } else { 
            files.add(dir); 
        } 
    } 
} 