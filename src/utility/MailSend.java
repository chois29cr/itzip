package utility;

import java.security.SecureRandom;
import java.util.Date;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailSend {
	private StringBuffer temp = null;
	private String certiCode = null;
	private String randomPW = null;
	

	//생성한 랜덤코드 6자리를 겟, 셋한다. 
	public void setCertiCode(String certiCode) {
		this.certiCode = certiCode;
	}
	public String getCertiCode() {
		return certiCode;
	}
	public String getRandomPW() {
		return randomPW;
	}	
	

	public boolean send(String mail) {
		
		System.out.println("MailSend.java의 MailSend 메소드 :수신자 이메일 : "+ mail);
		
		temp = new StringBuffer();
		Random rnd = new Random();
		
		for (int i = 0; i <= 5; i++) {
						
		    int rIndex = rnd.nextInt(2);
		    System.out.println("rIndex:" + rIndex);
		    
		    switch (rIndex) {
		    case 0: // A-Z
			    temp.append((char) ((int) (rnd.nextInt(26)) + 65));
			    break;
			    
		    case 1: // 0-9
			    temp.append((rnd.nextInt(10)));
			    break;	    
		    }
		}
		
		//temp(랜덤코드)를 String으로 형변환 후, certiCode에 셋 해준다.
		setCertiCode(temp.toString());
		
		
		//0과 1을 변환하여 6자리 코드를 생성
		System.out.println("생성된 6자리 코드는? : " + getCertiCode());
		
	
		String host = "smtp.naver.com"; 	//smtp 주소
		String user = "onyu0918@naver.com"; // 네이버일 경우 네이버 계정, gmail경우 gmail 계정
		String password = "on09180918";	// 패스워드
	
		// SMTP 서버 정보를 설정한다.
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 587);
		props.put("mail.smtp.auth", "true");
		//props.put("mail.smtp.starttls.enble", "true");
	
		
		//송신자의 아이디, 비밀번호로 세션을 굽는다.
		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});
	
		
		try {
			//메세지를 보낼 세션 정보를 담는다..
			MimeMessage message = new MimeMessage(session);
			
			//송신자의 아이디로 메세지를 보낼 것이다.
			message.setFrom(new InternetAddress(user));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(mail)); // 수신자 메일주소
	
			 // 메일 제목
			 message.setSubject("잇집 회원가입 인증메일입니다."); 
	
			// 메일 내용 
			//message.setText("<a href ='http://localhost:8080/teamc2/00board/main.jsp'>" + temp.toString() + "</a>");
			 String html = "";
			 
			 html  = "회원가입을 환영합니다.<br><br>";
			 html += "인증번호는 <font color='red'> " + temp.toString() + " </font> 입니다.<br>";
			 html += "회원가입 페이지에서 인증번호를 입력해주세요.<br><br>";
			 
			 message.setContent(html, "text/html; charset=utf-8");
		
			// send the message 
			Transport.send(message);
	
		} 
		catch (MessagingException e) {
			e.printStackTrace(); 
			return false;
		}
		return true;
	}

	//랜덤 비밀번호 만들기..
	public String randomPW(int size){
		char[] charSet = new char[]{
				'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
				'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
				'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd',
				'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
				'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
				'y', 'z', '!', '@', '#', '$', '%', '^', '&' };
		
		StringBuffer sb = new StringBuffer();
		SecureRandom sr = new SecureRandom();
		sr.setSeed(new Date().getTime());
		int idx = 0;
		int len = charSet.length;
		
		for (int i=0 ; i<size ; i++){
			// idx = (int) (len * Math.random());
			idx = sr.nextInt(len); // 강력한 난수를 발생시키기 위해 SecureRandom을 사용한다.
			sb.append(charSet[idx]);
			randomPW = sb.toString();
		}
		return randomPW;
	}
	
	
	//랜덤 비밀번호 전송하기
	public boolean sendPW(String mail) {
		
		System.out.println("MailSend.java의 sendPW ... 수신자 이메일 : "+ mail);
	
		String host = "smtp.naver.com"; 	//smtp 주소
		String user = "onyu0918@naver.com"; //
		String password = "on09180918";	// 패스워드
	
		// SMTP 서버 정보를 설정한다.
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 587);
		props.put("mail.smtp.auth", "true");
		//props.put("mail.smtp.starttls.enble", "true");
	
		
		//송신자의 아이디, 비밀번호로 세션을 굽는다.
		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});
	
		try {
			//메세지를 보낼 세션 정보를 담는다..
			MimeMessage message = new MimeMessage(session);
			
			//송신자의 아이디로 메세지를 보낼 것이다.
			message.setFrom(new InternetAddress(user));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(mail)); // 수신자 메일주소
	
			 // 메일 제목
			 message.setSubject("잇집 임시 비밀번호 발급 메일입니다."); 
	
			// 메일 내용 
			//message.setText("<a href ='http://localhost:8080/teamc2/00board/main.jsp'>" + temp.toString() + "</a>");
			 
			 String html = ""; 
			 html  = "잇집 임시 비밀번호 입니다. <br><br>";
			 html += "비밀번호는 <font color='red'> " + getRandomPW() + " </font> 입니다.<br>";
			 html += "보안을 위해 로그인 하여 비밀번호를 변경해주세요.<br><br>";
			 
			 message.setContent(html, "text/html; charset=utf-8");
		
			// send the message 
			Transport.send(message);	
		} 
		catch (MessagingException e) {
			e.printStackTrace(); 
			return false;
		}
		return true;
	}	
	
}
