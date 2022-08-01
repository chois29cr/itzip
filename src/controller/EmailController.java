package controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utility.MailSend;


@WebServlet("/EmailController")
public class EmailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String certiCode;
       
    public EmailController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//한글 인코딩
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String RequestURI = request.getRequestURI();   // 도메인을 제외한 전체경로를 가져옵니다.
		String contextPath = request.getContextPath(); // context의 경로를 가져옵니다.
		String command = RequestURI.substring(contextPath.length()+1);
		System.out.println(command);
		String[] uris =  command.split("/");
		
		System.out.println("0 index : " + uris[0]);
		System.out.println("1 index : " + uris[1]);
		
		MailSend m = new MailSend();
		
		
		//이메일 전송
		if(uris[1].equals("email.do")) {
			String email = request.getParameter("email");	
			
			System.out.println("EmailController email.do : 받아온 email : " + email);
			boolean result = m.send(email);
			
			//String certiCode = m.getCertiCode();
			System.out.println("email.do : 이메일 가입 시 전송된 코드는? : " + m.getCertiCode());
			certiCode = m.getCertiCode();
			
			if(result == true) {
				System.out.println("이메일 전송이 완료됨");
			}else {
				System.out.println("이메일 전송 실패... MailSend.java 확인하기!");
			}
			
			response.getWriter().write(""+result+"");
			response.getWriter().flush();
			response.getWriter().close();
		}
		
		
		//이메일 인증
		if(uris[1].equals("emailOK.do")) {
			System.out.println("EmailController emailOK.do : 이메일 가입 시 전송된 코드는? : " +  certiCode);
			boolean result = false;
			
			//join.jsp에서 name=certiNum인 곳에 입력한 값을 가져온다.
			String certiNum = request.getParameter("certiNum");
			System.out.println("입력한 코드는? : " + certiNum);
			
			if (certiCode.equals(certiNum)) {
				System.out.println("메일 인증코드가 일치한다.");
				result = true;
			}else {
				System.out.println("메일 인증코드 불일치");
				result = false;
			}

			response.getWriter().write(""+ result +"");
			response.getWriter().flush();
			response.getWriter().close();
		}
		
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
