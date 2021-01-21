package java_api_class;
import java.net.*;

public class G_Network {

//	네트워킹
//	네트워킹이랑 2대이상의 컴퓨터를 케이블로 연결하여 네트워크를 구성
//	-java.net 패키지에서 API제공
//	클라이언트/서버(client/server)
//	-서버 : 서비스를 제공(web server, mail server, file server, FTP server)
//	-클라이언트 : 서비스 이용
//	IP주소(IP address)
//	-ip주소는 컴퓨터를 구별하는데 사용되는 고유한 값.
//	(인터넷에 연결된 모든 컴퓨터는 고유한 IP를 갖는다.)
//	-ipv4주소는 4byte(32bit)의 정수
//	-자기 ip확인 cmd - ipconfig /all
//	IPv4 주소 . . . . . . . . . : 220.79.121.229(기본 설정)
//	2진수로 변환 8bit씩 4개 즉 32bit
//	11011100
//	01001111
//	01111001
//	11100101
	
	public static void main(String[] args) {

		//InetAddress : IP를 다루는 클래스
		InetAddress ip = null;
		
		//getHostName()
		//호스트의 이름을 get
		
		//getHostAddress()
		//호스트의 ip주소를 get
		
		//ip.toString()
		//호스트의 이름과 주소를 get
		
		try {
			ip = InetAddress.getByName("www.naver.com");
			System.out.println("host 이름: "+ip.getHostName());
			System.out.println("host 주소: "+ip.getHostAddress());
			System.out.println("host 이름/주소: "+ip.toString());
			
			
			
		} catch (UnknownHostException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		
		//getLocalHost()
		//로컬호스트를 IntetAddress 객체로
		
		try {
			ip = InetAddress.getLocalHost();
			System.out.println("localhost 이름: "+ip.getHostName());
			System.out.println("localhost 주소: "+ip.getHostAddress());
			
		} catch (UnknownHostException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		
		//배열로도 선언 가능
		
		InetAddress[] ipArr = null;
		
		try {
			ipArr = InetAddress.getAllByName("naver.com");
			for(InetAddress inetAddr : ipArr) {
				System.out.println(inetAddr);
			}
		} catch (UnknownHostException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		
		
	}

}
