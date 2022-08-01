package controller;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import dto.ListDTO;
import dto.QnaDTO;
import dto.QreplyDTO;
import dto.UserinfoDTO;
import vo.MyroomVO;
import vo.QnaVO;
import vo.QreplyVO;
import vo.UserinfoVO;


@WebServlet("/QnaController")
public class QnaController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public QnaController() {
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
		
		//qna 글쓰기
		if(uris[1].equals("write.do")) {
		
			if(user == null){
				response.sendRedirect("../user/login.jsp");
				return;
			}			
			
			String qno = request.getParameter("qno");
			int uno = user.getUno();
			String title = request.getParameter("title");
			String body  = request.getParameter("body");
			String name = user.getName();

			String k = request.getParameter("k");
			String pageno = request.getParameter("page");
			if(pageno == null) pageno="1";
			if(k == null) k = "";
			
			
			QnaDTO dto = new QnaDTO();
			
			QnaVO q = new QnaVO();
			q.setQno(qno);
			q.setUno(uno);
			q.setTitle(title);
			q.setBody(body);
			q.setName(name);
			
			dto.write(user, q);			
			
			System.out.println("QnaController write.do 실행됨1");
			
			response.sendRedirect("/teamc2/03qna/view.do?qno=" + dto.getQno());
			
		    System.out.println("QnaController write.do 실행됨2");
			
		}
		
		
		
		//qna 글보기
		if(uris[1].equals("view.do")) {
			
			String qno = request.getParameter("qno");
			String qre = request.getParameter("qre");
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

			
			System.out.println("[DEBUG]qno : " + qno);
			
			//qno를 이용하여 게시글 정보 select 
			QnaDTO qdto = new QnaDTO();
			QnaVO q = new QnaVO();
			
			//쿠키를 이용하여 조회수 무한 증가를 막는다. 
			Cookie[] cookies = request.getCookies();
			int visitor = 0;
			
			for(Cookie cookie : cookies) {
				System.out.println("쿠키이름: "+cookie.getName());
				//visit 쿠키만 있다  
				if(cookie.getName().equals("visit")) {
					visitor = 1;
					System.out.println("visit통과함");
					
					if(cookie.getValue().contains(user+"/"+qno)) {
						System.out.println("visit if 통과");
					} else {
						//visit 쿠키가 있고 no 값이 없다 >> 쿠키에 _no를 추가한 후 조회수를 증가시킨다.
						cookie.setValue(cookie.getValue() + "_" + user+"/"+qno);
						response.addCookie(cookie);
						qdto.hit(qno);
					}
				}
			}
			
			//쿠키가 없다면 visit 쿠키를 생성한 후 조회수를 증가시킨다. 
			if(visitor == 0) {
				Cookie cookie1 = new Cookie("visit", user+"/"+qno);
				response.addCookie(cookie1);
				System.out.println("qna쿠키 user/no: "+cookie1);
				qdto.hit(qno);
			}
			q = qdto.view(qno);
			System.out.println("QnaController view.do... ncheck?? :" + q.getNcheck());
			
			//uno를 이용하여 게시물 작성자와 프로필사진 불러오기		
			UserinfoDTO udto = new UserinfoDTO();
			String file = udto.getProfile("qna", "qno", Integer.parseInt(qno));		
			System.out.println("qna 글쓰기 작성자:"+file);
			
			request.setAttribute("view", q); //게시글 본문
			
			//이전글, 다음글 정보 객체에 저장한 후 setAttribute
			QnaVO nvo = new QnaVO();
			nvo = qdto.getNext(qno);
			QnaVO pvo = new QnaVO();
			pvo = qdto.getPrev(qno);
			
			request.setAttribute("prev", pvo);
			request.setAttribute("next", nvo);
			request.setAttribute("file", file);
			
			//댓글 영역
			
			
			ListDTO ldto = new ListDTO();
			//qno를 이용하여 댓글 정보 select
			ArrayList<QreplyVO> rList = ldto.qrList(qno,Integer.parseInt(rpage),k,t);

			ldto.setPerList(5);
			int total = ldto.getTotal();
			int startno = ldto.getStartPageNo(Integer.parseInt(rpage));
			int endno   = ldto.getLastPageNo(Integer.parseInt(rpage));
			int maxpageno = ldto.getMaxPageNo();
			
			System.out.println("qna view.do qno"+ qno);
			System.out.println("qna view.do rpage"+ rpage);
			System.out.println("qna view.do total"+ total );
			
			request.setAttribute("total", total);
			request.setAttribute("startno", startno);
			request.setAttribute("endno", endno);
			request.setAttribute("maxpageno", maxpageno);
			request.setAttribute("qrList", rList);
				
			RequestDispatcher rd = request.getRequestDispatcher("qView.jsp?qno="+qno+"&k="+k+"&t="+t+"&page="+pageno+"&rpage="+rpage);
		    rd.forward(request, response);
		}
		
		
		
		//qna 수정눌렀을 때 글보기
		if(uris[1].equals("qView.do")) {
			
			int uno = user.getUno();
			
			String qno = request.getParameter("qno");
			String k = request.getParameter("k");
			String pageno = request.getParameter("page");
			if(pageno == null) pageno="1";
			if(k == null) k = "";
			
			System.out.println("[DEBUG]qno : " + qno);
			
			//qno를 이용하여 게시글 정보 select 
			QnaDTO dto = new QnaDTO();
			QnaVO vo = new QnaVO();
			vo.setQno(qno);
			vo = dto.modi(qno);
			
			
			RequestDispatcher rd = request.getRequestDispatcher("qModify.jsp?qno="+qno+"&k="+k+"&page="+pageno);
			request.setAttribute("modi", vo);
			
		    rd.forward(request, response);
		}
				
		//qna 글수정
		if(uris[1].equals("modify.do")) {
			
			if(user == null){
				response.sendRedirect("../user/login.jsp");
				return;
			}			
			
			String title = request.getParameter("title");
			String body  = request.getParameter("body");
			int uno = user.getUno();
			String name = user.getName();

			String qno = request.getParameter("qno");
			
			String k = request.getParameter("k");
			String pageno = request.getParameter("page");
			if(pageno == null) pageno="1";
			if(k == null) k = "";			
			
			QnaDTO dto = new QnaDTO();			
			QnaVO vo = new QnaVO();
			
			vo.setTitle(title);
			vo.setBody(body);
			vo.setUno(uno);
			vo.setName(name);
			vo.setQno(Integer.parseInt(qno));
			dto.modify(user, vo);			
			
			response.sendRedirect("/teamc2/03qna/view.do?qno="+qno);		
		}
		
		
		//qna 글삭제	
		if(uris[1].equals("delete.do")) {		
			String qno = request.getParameter("qno");
			
			QnaDTO dto = new QnaDTO();
			QnaVO vo = new QnaVO();
			dto.delete(qno);
			
			response.sendRedirect("qna.jsp");
		}
		
		//qna 댓글 등록
		if(uris[1].equals("qWrite.do")) {
			System.out.println("qWrite.do로 들어옴");			
			if(user == null)
			{
				//로그인정보가 없다면 로그인페이지로 이동한다.
				response.sendRedirect("../user/login.jsp");
				return;
			}
			
			String qre = request.getParameter("qre");
			String qno = request.getParameter("qno");			
			
			//System.out.println("qWrite qre"+qre);
			//System.out.println("qWrite qno"+qno);
			
			int uno = user.getUno();
			
			QreplyDTO dto = new QreplyDTO();
			QreplyVO qr = new QreplyVO(); 
			
			qr.setUno(uno);
			qr.setQno(Integer.parseInt(qno));
			qr.setQre(qre);
			qr.setQrename(user.getName());			
			qr.setFile(user.getFile());
			
			dto.write(user, qr);
			
			int rTotal = dto.getRcount(Integer.parseInt(qno));
			
			JSONObject jObj = new JSONObject();
			jObj.put("uno", qr.getUno());
			jObj.put("qno", qr.getQno());
			jObj.put("qre", qr.getQre());
			jObj.put("qrename", qr.getQrename());
			jObj.put("qreno", dto.getQreno());
			jObj.put("qredate", qr.getQredate());
			jObj.put("file", qr.getFile());
			jObj.put("rTotal", rTotal);
			
			response.getWriter().write(""+jObj);
			response.getWriter().flush();
		}
		
		//qna 댓글 수정
		if(uris[1].equals("qModi.do")) {
			
			if(user == null) {
				//로그인정보가 없다면 로그인페이지로 이동한다.
				response.sendRedirect("../user/login.jsp");
				return;
			}
			
			String commentModi = request.getParameter("commentModi");
			String qno = request.getParameter("qno");		
			String qreno = request.getParameter("qreno");	
			
			System.out.println("댓글번호:" + qreno);
			System.out.println("댓글수정내용:" + commentModi);
			
			int uno = user.getUno();
			
			QreplyDTO dto = new QreplyDTO();
			QreplyVO qr = new QreplyVO(); 
			
			qr.setUno(uno);
			qr.setQno(Integer.parseInt(qno));
			qr.setQreno(Integer.parseInt(qreno));
			qr.setQre(commentModi);
			qr.setQrename(user.getName());
			dto.modify(user, qr);
			
			response.sendRedirect("/teamc2/03qna/view.do?qno="+qno);
		}
		
		//qna 댓글 삭제
		if(uris[1].equals("qDelete.do")) {
			System.out.println("삭제오류인가");
						
			//로그인정보가 없다면 로그인페이지로 이동한다.
			if(user == null) {
				response.sendRedirect("../user/login.jsp");
				return;
			}
			
			String qreno = request.getParameter("qreno");
			String qno = request.getParameter("qno");
			String rpage = request.getParameter("rpage");
			System.out.println("qDelete.do rpage:"+rpage);
			
			
			QreplyDTO dto = new QreplyDTO();
			QreplyVO qr = new QreplyVO(); 
			
			qr.setQreno(Integer.parseInt(qreno));
			dto.delete(user, qr);
			
			response.sendRedirect("/teamc2/03qna/view.do?qno="+qno+"&rpage="+rpage+"&mode=qna");
		}			
	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
