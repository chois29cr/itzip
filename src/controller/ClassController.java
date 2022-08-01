package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import dto.*;
import utility.Singleton;
import vo.*;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


@WebServlet("/ClassController")
public class ClassController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ClassController() {
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
		
		HttpSession session = request.getSession(true);
		UserinfoVO user = (UserinfoVO)session.getAttribute("user");
		//Class 글쓰기
		if(uris[1].equals("write.do")) {
			
		  
			System.out.println(" ClassController write.do 메소드 들어옴");

			try {
				if (-1 < request.getContentType().indexOf("multipart/form-data")) {
			     
			    //업로드를 위한 로컬 디렉토리명을 얻는다.
				String uploadPath = "C:\\dbrmsgh\\teamc2\\WebContent\\upload";
	
				System.out.println(uploadPath);
			    	
			    	
			    //업로드가 가능한 최대 파일 크기를 지정한다.
			    int size = 10 * 1024 * 1024;
			    	
			    MultipartRequest multi =  null;
			    ClassboardVO c = new ClassboardVO();
			    ClassboardDTO dto = new ClassboardDTO();
			    	
			    multi = new MultipartRequest(request,uploadPath,size,"UTF-8",new DefaultFileRenamePolicy());
			    
			    //업로드된 파일명을 얻는다.
			    Enumeration files = multi.getFileNames();
			    
			    c.setUno(user.getUno());
			    c.setTitle(multi.getParameter("title"));
			    c.setBody(multi.getParameter("ir1"));
			    c.setName(user.getName());	
			    c.setDate(multi.getParameter("date"));
			    c.setHit(multi.getParameter("hit"));
			    
			    dto.write(user, c);
			    
			    //int ino = Integer.parseInt(dto.getCno());
			    
			    Singleton s = Singleton.getInstance();
			    DCattachVO ca = new DCattachVO();
			    DCattachDTO cadto = new DCattachDTO();
			    
			    System.out.println("classboard 컨트롤러 싱글톤 get: "+s.getAttach(s.length()-1));
			    ca.setCno(Integer.parseInt(dto.getCno()));
			    ca.setDcattach(s.getAttach(s.length()-1));
			    
			    cadto.write(user, ca);
			    
			    response.sendRedirect("/teamc2/02class/view.do?cno="+dto.getCno());
			}  
		}catch (IOException ie) {
			ie.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		}
	
		//유저 정보가 없으면 (로그인 안 하고 들어오면) 메인 페이지로 
		if(user == null) {
			response.sendRedirect("../00board/main.jsp");
			return;
		}
	}
			    
			
	//classboard 글보기
	if(uris[1].equals("view.do")) {
		
		String cno = request.getParameter("cno");
		String cre = request.getParameter("cre");
		String k = request.getParameter("k");
		String t = request.getParameter("t");
		String pageno = request.getParameter("page");
		String rpage  = request.getParameter("rpage");
		
		if(k == null) k = "";
		if(t == null) t = "1";
		if(pageno == null) pageno="1";
		if(rpage == null)  rpage="1";
		
		//댓글 리스트 setAttribute();
		request.setAttribute("k", k);
		request.setAttribute("t", t);
		request.setAttribute("pageno", pageno);
		request.setAttribute("rpage", Integer.parseInt(rpage));

		
		//cno를 이용하여 게시글 정보 select 
		ClassboardDTO dto = new ClassboardDTO();
		ClassboardVO c = new ClassboardVO();
		
		//쿠키를 이용하여 조회수 무한 증가를 막는다. 
		Cookie[] cookies = request.getCookies();
		int visitor = 0;
		
				
		for(Cookie cookie : cookies) {
			System.out.println("쿠키이름: "+cookie.getName());
			//visit 쿠키만 있다  
			if(cookie.getName().equals("visit")) {
				
				visitor = 1; 
				System.out.println("visit통과함");
				
				if(cookie.getValue().contains(user+"/"+cno)) {
				
					System.out.println("visit if 통과");
				
				} else {
					//visit 쿠키가 있고 no 값이 없다 >> 쿠키에 _no를 추가한 후 조회수를 증가시킨다.
					cookie.setValue(cookie.getValue() + "_" + user+"/"+cno);
					response.addCookie(cookie);
					dto.hit(cno);
				}

			}
			
		}
		
		//쿠키가 없다면 visit 쿠키를 생성한 후 조회수를 증가시킨다. 
		if(visitor == 0) {
			Cookie cookie1 = new Cookie("visit", user+"/"+cno);
			response.addCookie(cookie1);
			System.out.println("쿠키 user/no: "+cookie1);
			dto.hit(cno);
		}
		
		c = dto.view(cno);	//게시글 본문 view 완료
		
		//글내용 리스트 setAttribute();
		request.setAttribute("view", c);
		
		//댓글영역 시작
		
		ListDTO ldto = new ListDTO();
		//no를 이용하여 댓글 정보 select
		ArrayList<CreplyVO> crList = ldto.crList(cno,Integer.parseInt(rpage),k,t);	
		
		ldto.setPerList(5);
		int total = ldto.getTotal();
		int startno = ldto.getStartPageNo(Integer.parseInt(rpage));
		int endno   = ldto.getLastPageNo(Integer.parseInt(rpage));
		int maxpageno = ldto.getMaxPageNo();
		
		System.out.println("classboard view.do cno"+ cno);
		System.out.println("classboard view.do rpage"+ rpage);
		System.out.println("classboard view.do total"+ total);
		
		request.setAttribute("total", total);
		request.setAttribute("startno", startno);
		request.setAttribute("endno", endno);
		request.setAttribute("maxpageno", maxpageno);
		request.setAttribute("crList", crList); //댓글 리스트 setAttribute();
					
		//uno를 이용하여 게시물 작성자와 프로필사진 불러오기		
		UserinfoDTO udto = new UserinfoDTO();
		
		String file = udto.getProfile("classboard", "cno", Integer.parseInt(cno));		
		System.out.println("클래스 글쓰기 작성자프사:"+file);
		
		request.setAttribute("file", file);
		
		//이전글, 다음글 정보 객체에 저장한 후 setAttribute
		ClassboardVO nvo = new ClassboardVO();
		nvo = dto.getNext(cno);
		ClassboardVO pvo = new ClassboardVO();
		pvo = dto.getPrev(cno);

		request.setAttribute("prev", pvo);
		request.setAttribute("next", nvo);
		
		//찜 정보 setAttribute
		ClasspickDTO pdto = new ClasspickDTO();
		int plTotal = pdto.getTotal(cno);

		request.setAttribute("plTotal", plTotal);
		
		//회원의 찜 여부
		String pickcheck = pdto.pickcheck(user,cno);

		if(pickcheck == null) pickcheck = "";
		request.setAttribute("pickcheck", pickcheck);
		System.out.println("pickcheck 확인: "+pickcheck);
		
		
		RequestDispatcher rd = request.getRequestDispatcher("cView.jsp?cno="+cno+"&k="+k+"&t="+t+"&page="+pageno+"&rpage="+rpage);
		rd.forward(request, response);
	}
		
	//찜 누르기
	if(uris[1].equals("pick.do")) {
		String cno = request.getParameter("cno");
		
		ClasspickDTO pdto = new ClasspickDTO();
		
		pdto.modify(user, cno);
		int plTotal = pdto.getTotal(cno);
		response.getWriter().write(""+plTotal);
		response.getWriter().flush();

		
	}
	
	//찜 해제하기
	if(uris[1].equals("unpick.do")) {	
		String cno = request.getParameter("cno");

		ClasspickDTO pdto = new ClasspickDTO();
		
		pdto.delete(user, cno);
		int plTotal = pdto.getTotal(cno);
		response.getWriter().write(""+plTotal);
		
	}
	
	//처음 좋아요 누르기
	if(uris[1].equals("wpick.do")) {
		String cno = request.getParameter("cno");
		
		ClasspickDTO pdto = new ClasspickDTO();
		
		pdto.write(user, cno);
		int plTotal = pdto.getTotal(cno);
		System.out.println("처음plTotal: "+plTotal);
		response.getWriter().write(""+plTotal);
		
		
	}


	//수정 눌렀을 때 글을 cModify.jsp로 불러오기 위한 .do
	if(uris[1].equals("cView.do")) {
		
		System.out.println("cView.do로 들어옴");
		
		String cno = request.getParameter("cno");
		String k = request.getParameter("k");
		String pageno = request.getParameter("page");
		if(pageno == null) pageno="1";
		if(k == null) k = "";

		System.out.println("[DEBUG]cno : " + cno);

		//no를 이용하여 게시글 정보 select 
		ClassboardDTO cdto = new ClassboardDTO();
		DCattachDTO dcdto = new DCattachDTO();
		ClassboardVO c = new ClassboardVO();
		
		//c.setCno(cno);
		c = cdto.view(cno);
		
		RequestDispatcher rd = request.getRequestDispatcher("cModify.jsp?cno="+cno+"&k="+k+"&page="+pageno);
		request.setAttribute("modi", c);
		
	    rd.forward(request, response);
	}
	
	//글수정
	if(uris[1].equals("modify.do")) {
				
		System.out.println(" ClassboardController modify.do 메소드 들어옴");
		
		//첨부파일 수정 시 이미지 재업로드 후 update
		try {
			
			if (-1 < request.getContentType().indexOf("multipart/form-data")) {
		 
				//업로드를 위한 로컬 디렉토리명을 얻는다.
				String uploadPath = "C:\\dbrmsgh\\teamc2\\WebContent\\upload";
	
				//업로드가 가능한 최대 파일 크기를 지정한다.
				int size = 10 * 1024 * 1024;
		
				MultipartRequest multi =  null;
				ClassboardVO c = new ClassboardVO();
				ClassboardDTO dto = new ClassboardDTO();
				
				multi = new MultipartRequest(request,uploadPath,size,"UTF-8",new DefaultFileRenamePolicy());
		 
				//업로드된 파일명을 얻는다.
				Enumeration files = multi.getFileNames();
				
				String cno = multi.getParameter("cno");
				System.out.println("클래스 글수정 cno: "+cno);
				
				//ClassboardDTO를 이용하여 글 제목을 수정한다. 
				c.setUno(user.getUno());
				c.setCno(Integer.parseInt(cno));
				c.setTitle(multi.getParameter("title"));
				c.setBody(multi.getParameter("ir1"));
				c.setName(user.getName());					
				dto.modify(c);
		 					
				//싱글톤을 getInstance 하여 대표이미지를 수정한다. 
				Singleton s = Singleton.getInstance();
				DCattachVO ca = new DCattachVO();
				DCattachDTO cadto = new DCattachDTO();

				if(s.length() == 0) {
					//System.out.println("myroom 컨트롤러 싱글톤 수정 get: "+s.getAttach(s.length()));
					//ma.setMattach(s.));
					
				}else {
					System.out.println("classboard 컨트롤러 싱글톤 수정 get: "+s.getAttach(s.length()-1));
					ca.setCno(Integer.parseInt(cno));
					ca.setDcattach(s.getAttach(s.length()-1));
					
					cadto.modify(ca);	
				}
								
				response.sendRedirect("/teamc2/02class/view.do?cno="+cno);
			} 
		}catch (IOException ie) {
			ie.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		}
	
	
		//유저 정보가 없으면 (로그인 안 하고 들어오면) 메인 페이지로 
		if(user == null){
			response.sendRedirect("../00board/main.jsp");
			return;
		}
	}	
	
	
	
	//글삭제	
	if(uris[1].equals("delete.do")) {		
		String cno = request.getParameter("cno");
		int ino = Integer.parseInt(cno);
		
		ClassboardDTO cdto = new ClassboardDTO();
		cdto.delete(ino);
		
		response.sendRedirect("classBoard.jsp");
	}
	
	
	
	
	//댓글 등록
	if(uris[1].equals("cWrite.do")) {
		System.out.println("cWrite.do 들어옴");			
		if(user == null) {
			//로그인정보가 없다면 로그인페이지로 이동한다.
			response.sendRedirect("../user/login.jsp");
			return;
		}
		
		String cre = request.getParameter("cre");
		String cno = request.getParameter("cno");			
		int uno = user.getUno();
		
		CreplyDTO dto = new CreplyDTO();
		CreplyVO cr = new CreplyVO(); 
		
		cr.setUno(uno);
		cr.setCno(Integer.parseInt(cno));
		cr.setCre(cre);
		cr.setCrename(user.getName());
		cr.setFile(user.getFile());
		dto.write(user, cr);
				
		JSONObject jObj = new JSONObject();
		jObj.put("uno", cr.getUno());
		jObj.put("cno", cr.getCno());
		jObj.put("cre", cr.getCre());
		jObj.put("crename", cr.getCrename());
		jObj.put("creno", dto.getCreno());
		jObj.put("credate", cr.getCredate());
		jObj.put("file", cr.getFile());
		
		response.getWriter().write(""+jObj);
		response.getWriter().flush();		
		
	}
	
	//댓글 수정
	if(uris[1].equals("cModi.do")) {
		
		System.out.println("클래스댓글수정오류인가");
		
		if(user == null) {
			//로그인정보가 없다면 로그인페이지로 이동한다.
			response.sendRedirect("../user/login.jsp");
			return;
		}
		
		String commentModi = request.getParameter("commentModi");
		String cno = request.getParameter("cno");		
		String creno = request.getParameter("creno");	
		
		System.out.println("댓글수정내용:" +commentModi);
		System.out.println("댓글번호:" +creno);
		
		int uno = user.getUno();
		int ino = Integer.parseInt(cno);
		int imreno = Integer.parseInt(creno);
		
		CreplyDTO dto = new CreplyDTO();
		CreplyVO vo = new CreplyVO(); 
		
		vo.setCreno(imreno);
		vo.setUno(uno);
		vo.setCno(ino);
		vo.setCre(commentModi);
		vo.setCrename(user.getName());
		dto.modify(user, vo);
		
		response.sendRedirect("/teamc2/02class/view.do?cno="+ino);
	}
	
	//댓글 삭제
	if(uris[1].equals("cDelete.do")) {
		
		System.out.println("삭제오류인가");
		
		if(user == null)
		{
			//로그인정보가 없다면 로그인페이지로 이동한다.
			response.sendRedirect("../user/login.jsp");
			return;
		}
		String creno = request.getParameter("creno");
		String cno = request.getParameter("cno");
		int ino = Integer.parseInt(cno);
		int imreno = Integer.parseInt(creno);
		
		CreplyDTO dto = new CreplyDTO();
		CreplyVO vo = new CreplyVO(); 
		
		vo.setCreno(imreno);
		dto.delete(user, vo);
		
		response.sendRedirect("/teamc2/02class/view.do?cno="+ino);
		}
	
	
	//Class 수강신청
	if(uris[1].equals("classing.do")) {
		
		if(user == null) {
			//로그인정보가 없다면 로그인페이지로 이동한다.
			response.sendRedirect("../user/login.jsp");
			return;
		}
		
		int ino = Integer.parseInt(request.getParameter("noHidden"));
		
		StudentDTO dto = new StudentDTO();
		StudentVO st = new StudentVO(); 
		
		st.setUno(user.getUno());
		st.setCno(ino);
		st.setName(request.getParameter("name"));
		st.setPhone(request.getParameter("phone"));
		st.setDate(request.getParameter("date"));
		st.setTitle(request.getParameter("title"));
		st.setImage(request.getParameter("image"));
		st.setEmail(user.getEmail());
		
		dto.classing(st);
		
		response.sendRedirect("/teamc2/02class/view.do?cno="+ino);
		}

	//Class 피드백
	if(uris[1].equals("feed.do")) {
		
		if(user == null) {
			//로그인정보가 없다면 로그인페이지로 이동한다.
			response.sendRedirect("../user/login.jsp");
			return;
		}
		
		int ino = Integer.parseInt(request.getParameter("noHidden"));
		
		ClassboardDTO dto = new ClassboardDTO();
		ClassboardVO st = new ClassboardVO(); 
		
		st.setFeed(request.getParameter("feed"));
		st.setCno(ino);
					
		dto.feed(st);
		
		response.sendRedirect("/teamc2/02class/view.do?cno="+ino);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
