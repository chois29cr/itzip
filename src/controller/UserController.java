package controller;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dto.MyroomDTO;
import dto.UserinfoDTO;
import utility.MailSend;
import vo.MyroomVO;
import vo.UserinfoVO;


@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public UserController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		//한글 인코딩
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String RequestURI = request.getRequestURI();   // 도메인을 제외한 전체경로를 가져옵니다.
		String contextPath = request.getContextPath(); // context의 경로를 가져옵니다.
		String command = RequestURI.substring(contextPath.length()+1);
		String[] uris =  command.split("/");
		
		System.out.println("0 index : " + uris[0]);
		System.out.println("1 index : " + uris[1]);	
		
		//로그인 시, user의 정보를 담을 VO
		//로그아웃 시에는 로그인 해서 셋되서 가지고 있는 정보를 날리기 위해 상단에 선언
		UserinfoVO user = null;
		
		//로그인 하기
		if(uris[1].equals("login.do")) {		
			System.out.println("UserController login.do 분기 전");

			String email = request.getParameter("email");
			String pw = request.getParameter("pw");
			System.out.println(email);
			System.out.println(pw);
			boolean result = false;
			
			UserinfoDTO dto = new UserinfoDTO();			 	
			     
		     //입력한 아이디랑 비밀번호가 없거나 불일치
			if (dto.login(email, pw) == null) {
				System.out.println("UserController의 login.do :: 로그인 정보 불일치");
				result = false;
			}else {
	 
		    	user = dto.getUser();
		    	HttpSession session = request.getSession(true);
		    	session.setAttribute("user", user);
		    	System.out.println("UserController login.do else... email? :" + user.getEmail());

				result = true;
			}
			response.getWriter().write(""+result+"");
			response.getWriter().flush();
			response.getWriter().close();
		}

		
		//로그아웃 하기
		if(uris[1].equals("logout.do")) {		
			System.out.println("UserController의 logout.do 실행");
	    	
			HttpSession session = request.getSession(true);
	    	session.setAttribute("user", user);
			session.removeAttribute("user");
			response.sendRedirect("../00board/main.jsp");
		}

		
		//이메일 찾기 (입력한 핸드폰번호로 가입한 email 있는지 검사)
		if(uris[1].equals("findEmail.do")) {
			System.out.println("UserController의 findEmail.do 실행");
			String phone = request.getParameter("phone1");
			System.out.println("입력한 핸드폰 번호.. " + phone);
			
			UserinfoDTO dto = new UserinfoDTO();			
			String email= dto.findEmail(phone);
			request.setAttribute("email", email);		
			
			 RequestDispatcher dispatcher = request.getRequestDispatcher("../user/findok.jsp");
	    	 dispatcher.forward(request, response);
		}
		
		
		//임시비밀번호 발급 (입력한 이메일, 핸드폰 번호로 검사)
		if(uris[1].equals("findPW.do")) {
			System.out.println("UserController의 findPW.do 실행");
			String email = request.getParameter("email");
			String phone = request.getParameter("phone2");
			System.out.println("입력한 email.. " + email);
			System.out.println("입력한 phone.. " + phone);
			
			boolean result = false;
			UserinfoDTO dto = new UserinfoDTO();			
			boolean usercheck = dto.findPW(email, phone);
		
			if (usercheck == true) { //입력한 핸드폰 번호로 가입한 내역이 있음

				MailSend m = new MailSend();
				String randomPW = m.randomPW(10);
				System.out.println("만들어진 랜덤 비밀번호? : " + randomPW);
				
				dto.setRandomPW(email, phone, randomPW); //DB에 임시 비밀번호를 새로 셋한다.
				m.sendPW(email); //랜덤비밀번호를, 회원의 이메일로 전송!
				
				result = true;	
			}else {
				result = false; //가입한 내역 없음...
			} 
			
			response.getWriter().write(""+result+"");
			response.getWriter().flush();
			response.getWriter().close();
		}		
		
		
		//회원가입 시 이메일 중복검사 (join.jsp에서)
		if(uris[1].equals("emailCK.do")) {
			String email = request.getParameter("email");				
			System.out.println("UserController의 emailCK.do ... email? : " +  email);
			boolean result = false;
			
			UserinfoDTO dto = new UserinfoDTO();
			boolean emailcheck = dto.idok(email); //중복된 email이 없으면 true 반환..
			
			if (emailcheck == true) { //중복이 없으면
				result = true;
			}else {
				result = false; //중복이 있으면
			} 
			
			response.getWriter().write(""+result+"");
			response.getWriter().flush();
			response.getWriter().close();
		}
		
		
		//회원가입 시 닉네임 중복검사 (join.jsp)
		//회원정보 수정 시 profileModi.jsp에서 중복검사..
		if(uris[1].equals("nameCK.do")) {
			String name = request.getParameter("name");				
			System.out.println("UserController의 nameCK.do ... name? : " +  name);
			boolean result = false;
			
			HttpSession session = request.getSession(true);
	    	user = (UserinfoVO)session.getAttribute("user"); 
	    	
	    	//이미 회원가입 된 유저가 회원정보 수정할 때, 기존의 name을 그대로 쓸 경우
			if (user != null && name.equals(user.getName())) {
				result = true;
				response.getWriter().write(""+result+"");
				response.getWriter().flush();
				response.getWriter().close();			
				return;
			}
			
			//새로 회원가입할 경우..
			UserinfoDTO dto = new UserinfoDTO();
			boolean namecheck = dto.nameok(name); //중복된 name이 없으면 true 반환..
			
			if (namecheck == true) { //중복이 없으면
				result = true;
			}else {
				result = false; //중복이 있으면
			} 
			
			response.getWriter().write(""+result+"");
			response.getWriter().flush();
			response.getWriter().close();			
		}
		
		
		
		//회원가입 시 핸드폰 중복검사
		if(uris[1].equals("phoneCK.do")) {
			String phone = request.getParameter("phone");
			System.out.println("UserController의 phoneCK.do ... phone? : " +  phone);
			boolean result = false;

			HttpSession session = request.getSession(true);
	    	user = (UserinfoVO)session.getAttribute("user"); 

	    	//이미 회원가입 된 유저가 회원정보 수정할 때, 기존의 phone을 그대로 쓸 경우
			if (user != null && phone.equals(user.getPhone())) {
				result = true;
				response.getWriter().write(""+result+"");
				response.getWriter().flush();
				response.getWriter().close();			
				return;
			}
	    	
			//새로 회원가입할 경우..
			UserinfoDTO dto = new UserinfoDTO();
			boolean phonecheck = dto.phoneok(phone); //중복된 email이 없으면 true 반환..
			
			//중복이 있으면, phonecheck = false 
			if (phonecheck == true) { //중복이 없으면
				result = true;
			}else {
				result = false; //중복이 있으면
			} 
			
			response.getWriter().write(""+result+"");
			response.getWriter().flush();
			response.getWriter().close();	
		}
		
		//회원탈퇴
		if(uris[1].equals("deluser.do")) {
			System.out.println("UserController의 delUser 실행");
			HttpSession session = request.getSession(true);
			boolean result = false;
			
	    	user = (UserinfoVO)session.getAttribute("user");
	    	
			String email = request.getParameter("email");
			String pw = request.getParameter("pw");
			
			System.out.println(email);
			System.out.println(pw);
			System.out.println(user);
			
			if(user.getEmail() != email || user.getPw() != pw) {
				result = false;
			}
			
			if(user.getEmail() == email && user.getPw() == pw) {			
				UserinfoDTO dto = new UserinfoDTO();
				dto.deluser(user.getUno());
				result = true;
			}
			
			response.getWriter().write(""+result+"");
			response.getWriter().flush();
			response.getWriter().close();		
		}
	    	
			
		
		//회원가입 하기
		if(uris[1].equals("join.do")) {
			System.out.println("UserController의 join.do 실행");	
			
			HttpSession session = request.getSession(true);
			
			//join.jsp -> join2.jsp 에서 받아옴
			String file = request.getParameter("file");
			String email = request.getParameter("email");
			String name = request.getParameter("name");
			String phone = request.getParameter("phone");
			String pw  = request.getParameter("pw");
			
			System.out.println("프로필 사진...? " + file);
			System.out.println("닉네임...? " + name);
			
			//join2.jsp에서 받아옴
			String texture = request.getParameter("texture");
			System.out.println("텍스쳐...? " + texture);

			
			UserinfoVO u = new UserinfoVO();
			UserinfoDTO dto = new UserinfoDTO();
			
			u.setFile(file);
			u.setEmail(email);
			u.setName(name);
			u.setPhone(phone);
			u.setPw(pw);			
			u.setTexture(texture);
			
			dto.join(u);
			response.sendRedirect("/teamc2/user/login.jsp");
		}
		
		
		//회원정보 수정
		if(uris[1].equals("modify.do")) {
			
			//로그인한 회원 정보.. 가져오기 -> uno 쓰기 위함
			HttpSession session = request.getSession(true);
			user = (UserinfoVO)session.getAttribute("user");			
			
			System.out.println("UserController의 modify.do 실행");
			
			
			if (-1 < request.getContentType().indexOf("multipart/form-data")) {
			 
				//업로드를 위한 로컬 디렉토리명을 얻는다.
				//String uploadPath = "C:\\dbrmsgh\\teamc2\\WebContent\\upload\\profile";
				String uploadPath = "C:\\dbrmsgh\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\teamc2\\upload\\profile";

				int size = 10 * 1024 * 1024; //업로드가 가능한 최대 파일 크기를 지정
				
				MultipartRequest multi =  null;
				multi = new MultipartRequest(request,uploadPath,size,"UTF-8",new DefaultFileRenamePolicy());
		 
				String selectProType = multi.getParameter("selectProType");
				System.out.println("누른 버튼 타입은?.. : " + selectProType);
		
				//기본정보 수정
				String pw = multi.getParameter("pw");
				String name = multi.getParameter("name");
				String phone = multi.getParameter("phone");
				String texture = multi.getParameter("texture");
				
				System.out.println("modify.do....  pw? : " + pw);
				System.out.println("modify.do....  name? : " + name);
				System.out.println("modify.do....  phone? : " + phone);
				System.out.println("modify.do....  texture? : " + texture);
					
				user.setPw(pw);
				user.setName(name);
				user.setPhone(phone);
				user.setTexture(texture);

				//프사 정보 수정
				String oldFile =multi.getParameter("oldFile");		//가입시 랜덤으로 설정되는 기본 프사 정보
				String basicFile = multi.getParameter("basicFile"); //기본프사 버튼을 눌러서 바꾼 새로운 기본 프사 정보
				String file =multi.getFilesystemName("file");		//사진등록 버튼을 눌러서 업로드한 로컬의 사진 정보
				
				System.out.println("modify.do....  oldFile? : " + oldFile);
				System.out.println("modify.do....  basicFile? : " + basicFile);					
				System.out.println("modify.do....  file? : " + file);
				
				
				//프사등록 버튼(M) : 로컬에 있는 사진을 올릴 때
				if(selectProType.equals("M")) {
					System.out.println("M일때..?");						
					
					user.setFile("/teamc2/upload/profile/"+ file);
					UserinfoDTO dto = new UserinfoDTO();
					dto.update(user);				
				}
				
					
				//기본프사 버튼을 누르지 않고 가입시 주어진 기본프사 그대로일 경우, 나머지 정보만 바꾼다.
				if(selectProType.equals("")) {	
					System.out.println("기본프사 버튼을 누르지 않았다.");
						
					user.setFile(oldFile);
					UserinfoDTO dto = new UserinfoDTO();
					dto.update(user);
				}
				
				//기본프사 버튼(D) : 눌렀을 때 주어진 기본 프사와 달라질 경우 프사도 함께 바꾼다.
				if(selectProType.equals("D")) {
					System.out.println("D일때..?");
					System.out.println("기본프사 버튼을 눌렀다..");
					
					user.setFile(basicFile);
					UserinfoDTO dto = new UserinfoDTO();
					dto.update(user);
				}
			}		
			//회원정보 수정 후, 마이페이지로 이동 
			response.sendRedirect("/teamc2/mypage/mypageHome.do");		
		}	
	}
			

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
