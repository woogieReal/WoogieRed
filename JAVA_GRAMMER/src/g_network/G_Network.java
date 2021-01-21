package g_network;
import java.net.*;

public class G_Network {

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
