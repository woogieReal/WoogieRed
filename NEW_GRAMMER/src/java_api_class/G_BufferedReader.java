package java_api_class;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
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
			if(fr != null) {
				try {
					fr.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(br != null) {
				try {
					br.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
		}
		
		System.out.println("Success");
		
		System.out.println("================================");
		
		FileWriter fw = null;
		BufferedWriter bw = null;
		
		try {
			fw = new FileWriter("prac02.txt");
			bw = new BufferedWriter(fw);
			String tmp = "근데 아예 수정되냐";
			bw.write(tmp);
		}catch(IOException e) {
			e.printStackTrace();
		}finally {
			try {
				bw.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		System.out.println("Success");
		
	}

}
