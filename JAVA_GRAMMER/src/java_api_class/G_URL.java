package java_api_class;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.net.URL;

public class G_URL {

//	URL(Uniform Resource Location)
//	프로토콜://호스트명:포트번호/경로명/파일명?쿼리스트리#참조
//	포트번호 https 는 443 / http 는 80
//	네이버(https://www.naver.com:443)
//	쌍용(http://www.sist.co.kr:80/index.do)
//	프로토콜
//	-자원에 접근하기 위해 서버와 통신하는데 사용되는 통신규약 ex)http,https,ftp
//	호스트명 -자원을 제공하기 위한 서버이름(www.naver.com)
//	포트번호 -통신에 사용되는 서버포트(443, 80등등)
//	경로명 -접근하려는 자원에 저장된 서버상 위치
//	파일명 -접근하려는 자원의 이름
//	쿼리스트리 -URL에서 ?이후의 부분(name=홍길동)
//	참조(anchor)
	
	public static void main(String[] args) {

		BufferedReader br = null;
		
		try {
			
			URL url = new URL("http://cgv.co.kr:80/movies/");
			System.out.println(url.getAuthority());
			System.out.println(url.getPort());
			System.out.println(url.getDefaultPort());
			System.out.println(url.getProtocol());
			System.out.println(url.getHost());
			System.out.println(url.toURI());
		
			
			//url의 소스코드 읽어오기
			br = new BufferedReader(new InputStreamReader(url.openStream()));
			String line = "";
			while((line = br.readLine()) != null) {
				System.out.println(line);
			}
					
		} catch (MalformedURLException | URISyntaxException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		} catch (IOException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		} finally {
			if(null != br) {
				try {
					br.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		
	}

}
