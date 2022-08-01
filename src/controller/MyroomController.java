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


import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dto.*;
import vo.*;
import utility.*;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


@WebServlet("/MyroomController")
public class MyroomController extends HttpServlet {
private static final long serialVersionUID = 1L;
       

public MyroomController() {
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

	//myroom 글쓰기
	if(uris[1].equals("write.do")) {
	

		
		System.out.println(" MyroomController write.do 메소드 : " + request.getContentType());
	
		try {
			
			if (-1 < request.getContentType().indexOf("multipart/form-data")) {
		 
				//유저 정보가 없으면 (로그인 안 하고 들어오면) 메인 페이지로 
				if(user == null){
					response.sendRedirect("../00board/main.jsp");
					return;
				}
				
				//업로드를 위한 로컬 디렉토리명을 얻는다.
				//String uploadPath = request.getRealPath("/upload");
				String uploadPath = "C:\\dbrmsgh\\teamc2\\WebContent\\upload";
		
				//System.out.println(uploadPath);
				
				//업로드가 가능한 최대 파일 크기를 지정한다.
				int size = 10 * 1024 * 1024;
		
				MultipartRequest multi =  null;
				MyroomVO m = new MyroomVO();
				MyroomDTO dto = new MyroomDTO();
				
				multi = new MultipartRequest(request,uploadPath,size,"UTF-8",new DefaultFileRenamePolicy());
		 
				//업로드된 파일명을 얻는다.
				Enumeration files = multi.getFileNames();
				//String ir1 = multi.getParameter("ir1");
				//System.out.println("스마트에디터 글내용 받아오기: "+ir1);
				
				m.setUno(user.getUno());
				m.setTitle(multi.getParameter("title"));			
				m.setBody(multi.getParameter("ir1"));			
				m.setName(user.getName());					
				//m.setDate(multi.getParameter("date"));
				//m.setHit(multi.getParameter("hit"));
				
				dto.write(user, m);
				
				Singleton s = Singleton.getInstance();
				MattachVO ma = new MattachVO();
				MattachDTO madto = new MattachDTO();
				
				System.out.println("myroom 컨트롤러 싱글톤 get: "+s.getAttach(s.length()-1));
				ma.setNo(Integer.parseInt(dto.getNo()));
				ma.setMattach(s.getAttach(s.length()-1));
								
				madto.write(user, ma);					
			
				response.sendRedirect("/teamc2/01myroom/view.do?no="+dto.getNo());
			}  
		}catch (IOException ie) {
			ie.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		}
	
		
		
	}


	//myroom 글보기
	if(uris[1].equals("view.do")) {
		
		String no = request.getParameter("no");
		String mre = request.getParameter("mre");
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

		
		//no를 이용하여 게시글 정보 select 
		MyroomDTO dto = new MyroomDTO();
		MyroomVO m = new MyroomVO();
		
		//쿠키를 이용하여 조회수 무한 증가를 막는다. 
		Cookie[] cookies = request.getCookies();
		int visitor = 0;
		for(Cookie cookie : cookies) {
			System.out.println("쿠키이름: "+cookie.getName());
			//visit 쿠키만 있다  
			if(cookie.getName().equals("visit")) {
				visitor = 1; 
				System.out.println("visit통과함");
				
				if(cookie.getValue().contains(user+"/"+no)) {
					System.out.println("visit if 통과");
				} else {
					//visit 쿠키가 있고 no 값이 없다 >> 쿠키에 _no를 추가한 후 조회수를 증가시킨다.
					cookie.setValue(cookie.getValue() + "_" + user+"/"+no);
					response.addCookie(cookie);
					dto.hit(no);
				}
			}
		}		
		//쿠키가 없다면 visit 쿠키를 생성한 후 조회수를 증가시킨다. 
		if(visitor == 0) {
			Cookie cookie1 = new Cookie("visit", user+"/"+no);
			response.addCookie(cookie1);
			System.out.println("쿠키 user/no: "+cookie1);
			dto.hit(no);
		}
		
		m = dto.view(no);	//게시글 본문 view 완료
		
		//글내용 리스트 setAttribute();
		request.setAttribute("view", m);
		
		//댓글영역 시작
		
		ListDTO ldto = new ListDTO();
		//no를 이용하여 댓글 정보 select
		ArrayList<MreplyVO> mrList = ldto.mrList(no,Integer.parseInt(rpage),k,t);	
		
		ldto.setPerList(5);
		int total = ldto.getTotal();
		int startno = ldto.getStartPageNo(Integer.parseInt(rpage));
		int endno   = ldto.getLastPageNo(Integer.parseInt(rpage));
		int maxpageno = ldto.getMaxPageNo();
		
		System.out.println("myroom view.do no"+ no);
		System.out.println("myroom view.do rpage"+ rpage);
		System.out.println("myroom view.do total"+ total);
		
		request.setAttribute("total", total);
		request.setAttribute("startno", startno);
		request.setAttribute("endno", endno);
		request.setAttribute("maxpageno", maxpageno);
		request.setAttribute("mrList", mrList); //댓글 리스트 setAttribute();
					
		//uno를 이용하여 게시물 작성자와 프로필사진 불러오기		
		UserinfoDTO udto = new UserinfoDTO();
		
		String file = udto.getProfile("myroom", "no", Integer.parseInt(no));		
		System.out.println("마이룸 글쓰기 작성자프사:"+file);
		
		request.setAttribute("file", file);
		
		//이전글, 다음글 정보 객체에 저장한 후 setAttribute
		MyroomVO nvo = new MyroomVO();
		nvo = dto.getNext(Integer.parseInt(no));
		MyroomVO pvo = new MyroomVO();
		pvo = dto.getPrev(Integer.parseInt(no));

		request.setAttribute("prev", pvo);
		request.setAttribute("next", nvo);
		
		//좋아요 정보 setAttribute
		MrelikeDTO mdto = new MrelikeDTO();
		int mlTotal = mdto.getTotal(Integer.parseInt(no));

		request.setAttribute("mlTotal", mlTotal);
		
		//회원의 좋아요 여부
		String likecheck = mdto.likecheck(user,no);

		if(likecheck == null) likecheck = "";
		request.setAttribute("likecheck", likecheck);
		System.out.println("likecheck 확인: "+likecheck);
		
		
		RequestDispatcher rd = request.getRequestDispatcher("mView.jsp?no="+no+"&k="+k+"&page="+pageno+"&rpage="+rpage);
		rd.forward(request, response);
	}
	
	//좋아요 누르기
	if(uris[1].equals("like.do")) {

		String no = request.getParameter("no");
		String lno = request.getParameter("lno");
		
		MrelikeDTO mdto = new MrelikeDTO();
		
		mdto.modify(user, no);
		int mlTotal = mdto.getTotal(Integer.parseInt(no));
		response.getWriter().write(""+mlTotal);
		response.getWriter().flush();
	}
	
	//좋아요 해제하기
	if(uris[1].equals("unlike.do")) {	

		String no = request.getParameter("no");
		String lno = request.getParameter("lno");
		
		MrelikeDTO mdto = new MrelikeDTO();
		
		mdto.delete(user, no);
		int mlTotal = mdto.getTotal(Integer.parseInt(no));
		response.getWriter().write(""+mlTotal);
		
	}
	
	//처음 좋아요 누르기
	if(uris[1].equals("wlike.do")) {

		String no = request.getParameter("no");
		String lno = request.getParameter("lno");
				
		MrelikeDTO mdto = new MrelikeDTO();
		
		mdto.write(user, no);
		int mlTotal = mdto.getTotal(Integer.parseInt(no));
		System.out.println("처음mlTotal: "+mlTotal);
		response.getWriter().write(""+mlTotal);
		
	}
	
	
	
	//myroom 수정 눌렀을 때 글을 qModify.jsp로 불러오기 위한 .do
	if(uris[1].equals("mView.do")) {
		
		System.out.println("mView.do로 들어옴");

		int uno = user.getUno();
		
		String no = request.getParameter("no");
		String k = request.getParameter("k");
		String pageno = request.getParameter("page");
		if(pageno == null) pageno="1";
		if(k == null) k = "";
		
		System.out.println("[DEBUG]no : " + no);

		//no를 이용하여 게시글 정보 select 
		MyroomDTO mdto = new MyroomDTO();
		MyroomVO m = new MyroomVO();

		m = mdto.view(no);
		
		
		RequestDispatcher rd = request.getRequestDispatcher("mModify.jsp?no="+no+"&k="+k+"&page="+pageno);
		request.setAttribute("modi", m);
		
	    rd.forward(request, response);
	}
	
	//myroom 글수정
	if(uris[1].equals("modify.do")) {
		
		System.out.println(" MyroomController modify.do 메소드 : " + request.getContentType());
		
		//첨부파일 수정 시 이미지 재업로드 후 update
		try {
			
			if (-1 < request.getContentType().indexOf("multipart/form-data")) {
		 
				//업로드를 위한 로컬 디렉토리명을 얻는다.
				//String uploadPath = request.getRealPath("/upload");
				String uploadPath = "C:\\dbrmsgh\\teamc2\\WebContent\\upload";
		
				//System.out.println(uploadPath);
		
		
				//업로드가 가능한 최대 파일 크기를 지정한다.
				int size = 10 * 1024 * 1024;
		
				MultipartRequest multi =  null;
				MyroomVO m = new MyroomVO();
				MyroomDTO dto = new MyroomDTO();
				
				multi = new MultipartRequest(request,uploadPath,size,"UTF-8",new DefaultFileRenamePolicy());
		 
				//업로드된 파일명을 얻는다.
				Enumeration files = multi.getFileNames();
				
				String no = multi.getParameter("no");
				System.out.println("se글수정 no: "+no);
				
				//myroomDTO를 이용하여 글 제목을 수정한다. 
				m.setUno(user.getUno());
				m.setNo(Integer.parseInt(no));
				m.setTitle(multi.getParameter("title"));
				m.setBody(multi.getParameter("ir1"));
				m.setName(user.getName());					
				dto.modify(user, m);
		 
				//싱글톤을 getInstance 하여 대표이미지를 수정한다. 
				Singleton s = Singleton.getInstance();
				MattachVO ma = new MattachVO();
				MattachDTO madto = new MattachDTO();

				if(s.length() == 0) {
					//System.out.println("myroom 컨트롤러 싱글톤 수정 get: "+s.getAttach(s.length()));
					//ma.setMattach(s.));
					
				}else {
					System.out.println("myroom 컨트롤러 싱글톤 수정 get: "+s.getAttach(s.length()-1));
					ma.setNo(Integer.parseInt(no));
					ma.setMattach(s.getAttach(s.length()-1));
					
					madto.modify(user, ma);	
				}
				
				response.sendRedirect("/teamc2/01myroom/view.do?no="+no);
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
	
	
	
	//myroom 글삭제	
	if(uris[1].equals("delete.do")) {		
		String no = request.getParameter("no");
		
		MyroomDTO mdto = new MyroomDTO();
		mdto.delete(no);
		
		response.sendRedirect("myroom.jsp");
	}
	
	
	//myroom 댓글 등록
	if(uris[1].equals("mWrite.do")) {
		System.out.println("mWrite.do 들어옴");
		if(user == null) {
			//로그인정보가 없다면 로그인페이지로 이동한다.
			response.sendRedirect("../user/login.jsp");
			return;
		}
		
		String mre = request.getParameter("mre");
		String no = request.getParameter("no");			
		int uno = user.getUno();
		
		System.out.println("mre: "+mre);
		System.out.println("nohidden: "+no);
		MreplyDTO dto = new MreplyDTO();
		MreplyVO mr = new MreplyVO(); 
		
		mr.setUno(uno);
		mr.setNo(Integer.parseInt(no));
		mr.setMre(mre);
		mr.setMrename(user.getName());
		mr.setFile(user.getFile());
		dto.write(user, mr);
		System.out.println("mredate:"+mr.getMredate());
		System.out.println("mreno:"+dto.getMreno());
		
		
		JSONObject jObj = new JSONObject();
		jObj.put("uno", mr.getUno());
		jObj.put("no", mr.getNo());
		jObj.put("mre", mr.getMre());
		jObj.put("mrename", mr.getMrename());
		jObj.put("mreno", dto.getMreno());
		jObj.put("mredate", mr.getMredate());
		jObj.put("file", mr.getFile());
		
		response.getWriter().write(""+jObj);
		response.getWriter().flush();
		//response.sendRedirect("/teamc2/01myroom/view.do?no="+no);
		
	}
	
	
	//myroom 댓글 수정
	if(uris[1].equals("mModi.do")) {
		
		if(user == null) {
			//로그인정보가 없다면 로그인페이지로 이동한다.
			response.sendRedirect("../user/login.jsp");
			return;
		}
		
		String commentModi = request.getParameter("commentModi");
		String no = request.getParameter("no");		
		String mreno = request.getParameter("mreno");	
		
		System.out.println("댓글수정내용:" +commentModi);
		System.out.println("댓글번호:" +mreno);
		
		int uno = user.getUno();
		int imreno = Integer.parseInt(mreno);
		
		MreplyDTO dto = new MreplyDTO();
		MreplyVO vo = new MreplyVO(); 
		
		vo.setMreno(imreno);
		vo.setUno(uno);
		vo.setNo(Integer.parseInt(no));
		vo.setMre(commentModi);
		vo.setMrename(user.getName());
		dto.modify(user, vo);
		
		response.sendRedirect("/teamc2/01myroom/view.do?no="+no);
	}
	
	//myroom 댓글 삭제
	if(uris[1].equals("mDelete.do")) {
		
		System.out.println("삭제오류인가");
		
		if(user == null)
		{
			//로그인정보가 없다면 로그인페이지로 이동한다.
			response.sendRedirect("../user/login.jsp");
			return;
		}
		String mreno = request.getParameter("mreno");
		String no = request.getParameter("no");
		String rpage = request.getParameter("rpage");
		
		MreplyDTO dto = new MreplyDTO();
		MreplyVO vo = new MreplyVO(); 
		
		vo.setMreno(Integer.parseInt(mreno));
		dto.delete(user, vo);
		
		response.sendRedirect("/teamc2/01myroom/view.do?no="+no+"&rpage="+rpage+"&mode=qna");
	}
	
	//무한스크롤 append를 위한 목록 조회
	if(uris[1].equals("mAdd.do")) {
		String k = request.getParameter("k");
		String t = request.getParameter("t");
		String pageno = request.getParameter("page");
		String rpage = request.getParameter("rpage");
		
		if(k == null) k = "";
		if(t == null) t = "";
		if(pageno == null) pageno="1";
		if(rpage == null) rpage="1";
		
		//댓글 리스트 setAttribute();
		request.setAttribute("k", k);
		request.setAttribute("t", t);
		request.setAttribute("pageno", pageno);
		request.setAttribute("rpage", Integer.parseInt(rpage));

		int ipageno = Integer.parseInt(pageno);
		
		ListDTO ldto = new ListDTO();
		ArrayList<MyroomVO> addList = ldto.mList(ipageno, k, t, user);		

		request.setAttribute("addList", addList);
		
		RequestDispatcher rd = request.getRequestDispatcher("mAdd.jsp");
		rd.forward(request, response);		
	}
	
	/*
	if(uris[1].equals("testJson.do")) {
		HttpSession session = request.getSession(true);
		String k = request.getParameter("k");
		String pageno = request.getParameter("page");
		String t = request.getParameter("t");
		if(pageno == null) pageno="1";
		if(k == null) k = "";
		if(t == null) t = "";
		
		int ipageno = Integer.parseInt(pageno);
		//int istartno = Integer.parseInt(startno);
		
		ListDTO ldto = new ListDTO();
		ArrayList<MyroomVO> addList = ldto.mList(ipageno, k, t);
		
		//json 데이터를 사용하기
		JSONArray jArray = new JSONArray(); //[{"키":"value","":""},{},{}]
		for(MyroomVO vo :addList) {
			JSONObject jObj = new JSONObject();
			jObj.put("no", vo.getNo());
			jObj.put("uno", vo.getUno());
			jObj.put("title", vo.getTitle());
			jObj.put("name", vo.getName());
			jObj.put("date", vo.getDate());
			jObj.put("hit", vo.getHit());
			jArray.add(jObj);
		}
		response.getWriter().write(jArray.toJSONString());
		response.getWriter().flush();

	}
	*/
}



protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
}

}
