package java_api_class;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public class G_BufferedReader {

	public static void main(String[] args) {

		FileReader fr = null;
		BufferedReader br = null;
		
		File file = new File("prac01.txt");
		
		try {
			String readData = "";
			fr = new FileReader(file);
			br = new BufferedReader(fr);
			while((readData = br.readLine()) != null) {
				System.out.println(readData);
			}
			
			
		}catch(IOException e) {
			e.printStackTrace();
		}finally {
			if(br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
		}
		
		System.out.println("Success");
		
		
		
	}

}
