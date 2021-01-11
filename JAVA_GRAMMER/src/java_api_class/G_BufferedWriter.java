package java_api_class;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;

public class G_BufferedWriter {

	@SuppressWarnings("resource")
	public static void main(String[] args) {

		FileReader fr = null;
		BufferedReader br = null;
		FileWriter fw = null;
		BufferedWriter bw = null;

		File file = new File("C:\\Users\\123wo\\OneDrive\\문서\\GitHub\\WoogieRed\\NEW_GRAMMER\\prac02.txt");
		try {

			//현재 파일의 데이터 출력. 있어도 되고 없어도 됨
			try {
				fr = new FileReader(file);
				br = new BufferedReader(fr);
				
				String data = "";
				while((data = br.readLine()) != null) {
					System.out.println(data);
				}
				
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				if (null != br) {
					br.close();
				}
			}
			
			// true를 붙히면 파일이 있을 경우 이어쓰기임. 안 붙히거나 false를 붙히면 덮어쓰기임
			fw = new FileWriter(file, true);
			bw = new BufferedWriter(fw);

			Scanner scan = new Scanner(System.in);
			String addingText = scan.next();
			String renewedText = "\r\n" + addingText;
			bw.write(renewedText);


		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (null != bw) {
					bw.close();
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		System.out.println("Success");

	}

}
