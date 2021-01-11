package java_api_class;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

public class G_File {

	public static void main(String[] args) {

//		File.separator
//		윈도우에서는 \ , 유닉스에서는 /
//		파일의 디렉토리 경로를 나타낼때 쓰인다.
//		ex) C:\20201123_eClass\01_JAVA\workspace
		
		System.out.println(File.separator);
//		File.separator를 이용하여 경로작성(호환성이 좋음)
		String path = System.getProperty("user.dir") + File.separator + "G_Separator";
		System.out.println(path);
//		C:\20201123_eClass\01_JAVA\workspace\NEW_GRAMMER\G_Separator

//		File.pathSeparator
//		여러가지 경로를 나열할 때 경로들을 구분하는데 쓰인다. (;)
//		ex)
//		C:\20201123_eClass\01_JAVA\workspace;C:\20201123_eClass\01_JAVA\workspace\ONLINE
//		SILENT AUCTION2;C:\20201123_eClass\01_JAVA\workspace\TEST

		System.out.println(File.pathSeparator);

//		System.getProperty("user.dir")
//		현재 작업중인 디렉토리 출력
//		C:\20201123_eClass\01_JAVA\workspace\NEW_GRAMMER
		System.out.println(System.getProperty("user.dir"));
		System.out.println("=================================");
		
//		현재 디렉토리에 있는 파일/폴더 출력
		String curDir = System.getProperty("user.dir");
		File dir = new File(curDir);
		File[] files = dir.listFiles();
		
		for(int i = 0; i < files.length; i++) {
			System.out.println(files[i]);
		}
		
		System.out.println("=================================");
		
//		현재 디렉토리에 있는 파일/폴더 + 날짜 속성 크기 이름 출력
		for(int i = 0; i < files.length; i++) {
			File f = files[i];
			String name = f.getName();
			String attribute = "";
			String size = "";
			
			// 최근수정시간
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd a HH:mm");
			String LastModified = sdf.format(new Date(f.lastModified()));
			
			// 속성
			if (f.isDirectory() == true) { //폴더인가 파일인가.
				attribute = "d";
			} else {
				attribute = "-";
			}
			
			//읽기 쓰기 실행 가능여부
			attribute += (f.canRead() == true) ? "r" : " ";
			attribute += (f.canWrite() == true) ? "w" : " ";
			attribute += (f.canExecute() == true) ? "x" : " ";
			
			//크기
			size = String.valueOf(f.length());
			
			//출력
			System.out.printf("%s %4s %8s %s\n", LastModified, attribute, size, name);

		}
		
		
		
	}

}
