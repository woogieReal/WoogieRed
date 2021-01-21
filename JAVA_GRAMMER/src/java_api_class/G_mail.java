package java_api_class;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class G_mail {

//	mail
//	naver smtp
//	1. 네이버 설정
//	2. smtp email 라이브러리
//	POP 서버명 : pop.naver.com
//	SMTP 서버명 : smtp.naver.com
//	POP 포트 : 995, 보안연결(SSL) 필요
//	SMTP 포트 : 465, 보안 연결(SSL) 필요
//	아이디 : 123wodnr
//	비밀번호 : 네이버 로그인 비밀번호
	
	public static void main(String[] args) {

//		3. mail 전송
//		 3.1. 발신자의 메일 계정과 비번
//		 3.2. SMTP정보 설정: Properties
//		 3.3. SMTP정보와 사용자 정보를 기반으로 Session객체 생성
//		 3.4. Message 수신자,제목,내용
//		 3.5. Transport클래스 통해 전송. 	
		//SMTP 서버명
		String host = "smtp.naver.com";
		int    port = 465;
		String user = "123wodnr@naver.com";
		String password = "aegis01!!@@";
		//Properties STMP정보 설정
		Properties props=new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", true);
		//ssl
		props.put("mail.smtp.ssl.enable", true);
		props.put("mail.smtp.ssl.trust", host);
		//SMTP,사용자 정보를 기반으로 Seesion객체 생성
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user,password);
			}
		});
		//Message수신자,제목,내용
		MimeMessage  message=new MimeMessage(session);
		try {
			//보내는 사람
			message.setFrom(new InternetAddress(user));
			//받는사람
			message.addRecipient(Message.RecipientType.TO, new InternetAddress("plagis@daum.net"));
			//제목
			message.setSubject("eclass mail 테스트");
			//내용
			message.setText("비오는 목요일 오후");
			//전송
			Transport.send(message);
		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		System.out.println("==============================");
		System.out.println("=전송=");
		System.out.println("==============================");
		
	}

}
