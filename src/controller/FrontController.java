package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;      

    public FrontController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String RequestURI = request.getRequestURI();   // 도메인을 제외한 전체경로를 가져옵니다.
		String contextPath = request.getContextPath(); // context의 경로를 가져옵니다.
		String command = RequestURI.substring(contextPath.length()+1);
		String[] uris =  command.split("/");
		
	
		System.out.println("Front Controller 들어옴");


		if(uris[0].equals("01myroom")) {
			System.out.println("FrontController에서 01myroom으로 분기됨 !!! :  "+ command);

			MyroomController m =new MyroomController();
			m.doGet(request, response);
		}
		
	
		if(uris[0].equals("02class")) {
			System.out.println("FrontController에서 02class로 분기됨 !!! : "+ command);
			ClassController c =new ClassController();
			c.doGet(request, response);
		}

		
		if(uris[0].equals("03qna")) {
			System.out.println("FrontController에서 03qna로 분기됨 !!! : "+ command);
			QnaController q =new QnaController();
			q.doGet(request, response);
		}
		
		
		if(uris[0].equals("04brand")) {
			System.out.println("FrontController에서 04brand로 분기됨 !!! : " + command);
			QnaController b =new QnaController();
			b.doGet(request, response);
		}
		
		
		if(uris[0].equals("user")) {
			System.out.println("FrontController에서 user로 분기됨 !!! : "+command);
			UserController u =new UserController();
			u.doGet(request, response);
		}
		
		if(uris[0].equals("email")) {
			System.out.println("FrontController에서 email로 분기됨 !!! : "+command);
			EmailController e =new EmailController();
			e.doGet(request, response);
		}
		
		if(uris[0].equals("mypage")) {
			System.out.println("FrontController에서 mypage로 분기됨 !!! : "+command);
			MypageController e =new MypageController();
			e.doGet(request, response);
		}
		
		
		if(uris[0].equals("manager")) {
			System.out.println("FrontController에서 manager로 분기됨 !!! : "+command);
			ManagerController e =new ManagerController();
			e.doGet(request, response);
		}
	}		
		

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
