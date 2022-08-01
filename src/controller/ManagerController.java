package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dto.ClassboardDTO;
import dto.ManagerDTO;
import dto.QnaDTO;
import dto.QreplyDTO;
import dto.UserinfoDTO;
import vo.ClassboardVO;
import vo.ManagerVO;
import vo.MattachVO;
import vo.QnaVO;
import vo.QreplyVO;
import vo.StudentVO;
import vo.UserinfoVO;


@WebServlet("/ManagerController")
public class ManagerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ManagerController() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String RequestURI = request.getRequestURI();   // 도메인을 제외한 전체경로를 가져옵니다.
		String contextPath = request.getContextPath(); // context의 경로를 가져옵니다.
		String command = RequestURI.substring(contextPath.length()+1);
		String[] uris =  command.split("/");
		ManagerDTO mdto = new ManagerDTO();
		
		HttpSession session = request.getSession(true);
		UserinfoVO user = (UserinfoVO)session.getAttribute("user");
		
		if(user == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter writer = response.getWriter();
			writer.println("<script>alert('올바르지 않는 접근입니다.'); location.href='"+"/teamc2/00board/main.jsp"+"';</script>");
			writer.close();	
		}
		
		if(user.getIsadmin().equals("N")) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter writer = response.getWriter();
			writer.println("<script>alert('올바르지 않는 접근입니다.'); location.href='"+"/teamc2/00board/main.jsp"+"';</script>");
			writer.close();				
		}
		
		
		//qna 글을 공지사항으로 등록하기
		if(uris[1].equals("notice.do")) {
			System.out.println("ManagerController notice.do 메소드 진입");

			int qno = Integer.parseInt(request.getParameter("qno")); //글 번호를 가져옴
			String ncheck = request.getParameter("ncheck");
			System.out.println(qno);
			System.out.println(ncheck);

			String result = mdto.notice(qno, ncheck); //qnaVO의 ncheck Y/N 값에 따라 공지사항 해제/등록 한다.
			
			System.out.println("notice.do....  result는? : " + result);
			
			response.getWriter().write(""+result+"");
			response.getWriter().flush();
			response.getWriter().close();
		}
		
		
		
		//최초 실행 시 페이지 목록을 조회해오기
		if(uris[1].equals("oArticle.do")) {
			System.out.println("ManagerController oArticle.do 메소드 : " + request.getContentType());
			
			
			String pageno = request.getParameter("page");
			int ipageno = Integer.parseInt(pageno);
			System.out.println("ManagerController 페이지"+ipageno);
			if(pageno == null) pageno="1";
			
			
			ArrayList<ManagerVO> List = mdto.getList(ipageno);
			//ArrayList<ManagerVO> rList = dto.getRlist();
			int total = mdto.getTotal();
				
			mdto.getStartPageNo(ipageno);
			mdto.setTotal(total);
			//mdto.getTotal(); //전체 게시물 갯수를 얻는다.
			
			System.out.println("페이징 total: "+total);
			
			int maxpageno = mdto.getMaxPageNo();
			mdto.getLastPageNo(ipageno);
			
			int startno = mdto.getStartPageNo(ipageno);
			int endno   = mdto.getLastPageNo(ipageno);
			
			System.out.println("startno: "+startno);
			System.out.println("endno: "+endno);
			
			
			RequestDispatcher rd = request.getRequestDispatcher("oArticle.jsp?page="+pageno);
			request.setAttribute("List", List);
			request.setAttribute("startno", startno);
			request.setAttribute("endno", endno);
			request.setAttribute("maxpageno", maxpageno);
			request.setAttribute("total", total);
			request.setAttribute("pageno", pageno);
	
		    rd.forward(request, response);
		}
		
		//전체 댓글 목록을 조회한다.
		if(uris[1].equals("oReply.do")) {
			System.out.println("ManagerController oReply.do 메소드 : " + request.getContentType());	
			
			String pageno = request.getParameter("page");
			int ipageno = Integer.parseInt(pageno);
			System.out.println("ManagerController 페이지"+ipageno);
			if(pageno == null) pageno="1";		
			
			ArrayList<ManagerVO> rList = mdto.getRlist(ipageno);
			//ArrayList<ManagerVO> rList = dto.getRlist();
			int total = mdto.getTotal();
			
			mdto.getStartPageNo(ipageno);
			mdto.setTotal(total);
			//mdto.getTotal(); //전체 댓글 갯수를 얻는다.
			
			System.out.println("페이징 total: "+total);
			
			int maxpageno = mdto.getMaxPageNo();
			mdto.getLastPageNo(ipageno);
			
			int startno = mdto.getStartPageNo(ipageno);
			int endno   = mdto.getLastPageNo(ipageno);
			
			System.out.println("startno: "+startno);
			System.out.println("endno: "+endno);
			
			
			RequestDispatcher rd = request.getRequestDispatcher("oReply.jsp?page="+pageno);
			request.setAttribute("rList", rList);		
			request.setAttribute("startno", startno);		
			request.setAttribute("endno", endno);	
			request.setAttribute("maxpageno", maxpageno);	
			request.setAttribute("total", total);	
			request.setAttribute("pageno", pageno);
			
		    rd.forward(request, response);
		}
		
		//클래스 글목록을 조회한다.
		if(uris[1].equals("oDaily.do")) {
			System.out.println("ManagerController oDaily.do 메소드 : " + request.getContentType());
						
			String pageno = request.getParameter("page");
			String title = request.getParameter("title");
			int ipageno = Integer.parseInt(pageno);
			System.out.println("ManagerController 페이지"+ipageno);
			if(pageno == null) pageno="1";
			
			ArrayList<ClassboardVO> cList = mdto.getClist(ipageno);
			//ArrayList<ManagerVO> rList = dto.getRlist();
			int total = mdto.getTotal();

			mdto.getStartPageNo(ipageno);
			//mdto.setTotal(total);
			//mdto.getTotal(); //전체 게시물 갯수를 얻는다.
			
			System.out.println("c페이징 total: "+total);
			
			int maxpageno = mdto.getMaxPageNo();
			mdto.getLastPageNo(ipageno);
			
			int startno = mdto.getStartPageNo(ipageno);
			int endno   = mdto.getLastPageNo(ipageno);
			
			System.out.println("startno: "+startno);
			System.out.println("endno: "+endno);
			
			
			RequestDispatcher rd = request.getRequestDispatcher("oDaily.jsp?page="+pageno);
			request.setAttribute("cList", cList);		
			request.setAttribute("startno", startno);		
			request.setAttribute("endno", endno);	
			request.setAttribute("maxpageno", maxpageno);	
			request.setAttribute("total", total);	
			request.setAttribute("pageno", pageno);
			request.setAttribute("title", title);
			
		    rd.forward(request, response);
		}
		
		//클래스 글목록을 조회한다.
		if(uris[1].equals("oUser.do")) {			
			System.out.println("ManagerController oUser.do 메소드 : " + request.getContentType());			
			
			String pageno = request.getParameter("page");
			
			int ipageno = Integer.parseInt(pageno);
			System.out.println("ManagerController 페이지"+ipageno);
			if(pageno == null) pageno="1";
			
			ArrayList<UserinfoVO> uList = mdto.getUlist(ipageno);			
			int total = mdto.getTotal();
			
			mdto.getStartPageNo(ipageno);
			
			System.out.println("u페이징 total: "+total);
			
			int maxpageno = mdto.getMaxPageNo();
			mdto.getLastPageNo(ipageno);
			
			int startno = mdto.getStartPageNo(ipageno);
			int endno   = mdto.getLastPageNo(ipageno);
			
			System.out.println("startno: "+startno);
			System.out.println("endno: "+endno);
			
			
			RequestDispatcher rd = request.getRequestDispatcher("oUser.jsp?page="+pageno);
			request.setAttribute("uList", uList);		
			request.setAttribute("startno", startno);		
			request.setAttribute("endno", endno);	
			request.setAttribute("maxpageno", maxpageno);	
			request.setAttribute("total", total);	
			request.setAttribute("pageno", pageno);
			
			
		    rd.forward(request, response);
		}		
		
		//클래스 수강생 목록을 조회한다.
		if(uris[1].equals("oStudent.do")) {			
			System.out.println("ManagerController oStudent.do 메소드 들어옴");
			
			String pageno = request.getParameter("page");
			String cno = request.getParameter("cno");
			String title = request.getParameter("title");
			
			System.out.println("ManagerController 페이지"+Integer.parseInt(pageno));
			if(pageno == null) pageno="1";
			
			ArrayList<StudentVO> sList = mdto.getSlist(cno,Integer.parseInt(pageno));			
			int total = mdto.getTotal();
			
			mdto.getStartPageNo(Integer.parseInt(pageno));
			
			System.out.println("s페이징 total: "+total);
			
			int maxpageno = mdto.getMaxPageNo();
			mdto.getLastPageNo(Integer.parseInt(pageno));
			
			int startno = mdto.getStartPageNo(Integer.parseInt(pageno));
			int endno   = mdto.getLastPageNo(Integer.parseInt(pageno));
			
			System.out.println("startno: "+startno);
			System.out.println("endno: "+endno);
			
			ClassboardVO vo = null;
			ClassboardDTO cdto = new ClassboardDTO();
			
			vo = cdto.view(cno);
			
			RequestDispatcher rd = request.getRequestDispatcher("oStudent.jsp?page="+pageno);
			request.setAttribute("sList", sList);		
			request.setAttribute("startno", startno);		
			request.setAttribute("endno", endno);	
			request.setAttribute("maxpageno", maxpageno);	
			request.setAttribute("total", total);	
			request.setAttribute("pageno", pageno);
			request.setAttribute("title", vo.getTitle());
			
		    rd.forward(request, response);
		}	
		
		
		//선택된 게시물을 일괄 삭제한다
		if(uris[1].equals("oDelete.do")) {			
			String pageno = request.getParameter("page");
			String NoList = request.getParameter("no");
			System.out.println("nolist: "+NoList);
			
			String [] NoArray = NoList.split("@");
			String type = "";
			for(int i=0;i<NoArray.length;i++){
				String [] Data = NoArray[i].split(":");
				type = Data[0];
				String no   = Data[1];
				
				mdto.delete(no, type);
			}
			
			System.out.println("type: "+type);
			if(type.equals("qna") || type.equals("myroom")) {
				response.sendRedirect("/teamc2/manager/oArticle.do?page="+pageno);
			}
			if(type.equals("mreply") || type.equals("qreply") || type.equals("creply")) {
				response.sendRedirect("/teamc2/manager/oReply.do?page="+pageno);
			}
			if(type.equals("classboard")) {
				response.sendRedirect("/teamc2/manager/oDaily.do?page="+pageno);
			}
			if(type.equals("userinfo")) {
				response.sendRedirect("/teamc2/manager/oUser.do?page="+pageno);
			}
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
