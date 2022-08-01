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

import dto.*;
import vo.*;


@WebServlet("/MypageController")
public class MypageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public MypageController() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String RequestURI = request.getRequestURI();   // 도메인을 제외한 전체경로를 가져옵니다.
		String contextPath = request.getContextPath(); // context의 경로를 가져옵니다.
		String command = RequestURI.substring(contextPath.length()+1);
		String[] uris =  command.split("/");
		
		HttpSession session = request.getSession(true);
		UserinfoVO user = (UserinfoVO)session.getAttribute("user");
		MypageDTO mdto = new MypageDTO();

		if(user == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter writer = response.getWriter();
			writer.println("<script>alert('올바르지 않는 접근입니다.'); location.href='"+"/teamc2/00board/main.jsp"+"';</script>");
			writer.close();
			
		}	
		
		//mypage에서 내글, 내 댓글, 좋아요, 찜클래스 클릭 시, t와 page는 1로 고정.
		String t = request.getParameter("t");
		if(t == null) t = "1";
		String pageno = request.getParameter("page");
		if(pageno == null) pageno= "1";	
		
		
		//최초 실행 시 페이지 목록을 조회해오기
		if(uris[1].equals("mypageHome.do")) {
			System.out.println("MypageController mypageHome.do 진입");
			int ipageno = Integer.parseInt(pageno);
			System.out.println("mypost.do... ipageno? : " + ipageno);
			
			ArrayList<MypageVO> postlist = mdto.getPost(user.getUno());
			ArrayList<MypageVO> replylist = mdto.getRe(user.getUno());
			
			RequestDispatcher rd = request.getRequestDispatcher("mypage.jsp");
			request.setAttribute("t", t);
			request.setAttribute("ipageno", ipageno);
			request.setAttribute("postlist", postlist);
			request.setAttribute("replylist", replylist);
			rd.forward(request, response);				
		}
		

		//내 게시물 전체... -> 더보기 클릭 시
		if(uris[1].equals("mypost.do")) {
			System.out.println("MypageController mypost.do 진입");
			mdto.setPerList(10);
			int ipageno = Integer.parseInt(pageno);
			System.out.println("mypost.do... ipageno? : " + ipageno);
			System.out.println("유저번호 : " + user.getUno());
			
			//uno, ipageno로 내글 리스트 만들기
			ArrayList<MypageVO> mypostlist = mdto.getPostList(user.getUno(), ipageno);
			
			//현재페이지 ipageno를 이용하여 시작번호, 끝번호를 구함
			int startno = mdto.getStartPageNo(ipageno);
			int endno   = mdto.getLastPageNo(ipageno);
			int maxpageno = mdto.getMaxPageNo();
			
			//total을 가져와서 셋함 
			int total = mdto.getTotal();
			mdto.setTotal(total);

			System.out.println("startno: "+ startno);
			System.out.println("endno: "+ endno);

			RequestDispatcher rd = request.getRequestDispatcher("mypost.jsp");	
			request.setAttribute("mypostlist", mypostlist);	

			request.setAttribute("t", t);
			request.setAttribute("ipageno", ipageno);
			request.setAttribute("startno", startno);
			request.setAttribute("endno", endno);
			request.setAttribute("maxpageno", maxpageno);
			request.setAttribute("total", total);
			
			rd.forward(request, response);
		}

		//내 댓글 전체... -> 더보기 클릭 시
		if(uris[1].equals("myreply.do")) {
			System.out.println("MypageController myreply.do 진입");
			mdto.setPerList(10);
			int ipageno = Integer.parseInt(pageno);
			System.out.println("유저번호 : " + user.getUno());
			ArrayList<MypageVO> myreplylist = mdto.getReplyList(user.getUno(), ipageno);

			//현재페이지 ipageno를 이용하여 시작번호, 끝번호를 구함
			int startno = mdto.getStartPageNo(ipageno);
			int endno   = mdto.getLastPageNo(ipageno);
			int maxpageno = mdto.getMaxPageNo();	
			
			//total을 가져와서 셋함 
			int total = mdto.getTotal();
			mdto.setTotal(total);

			System.out.println("startno: "+ startno);
			System.out.println("endno: "+ endno);

			RequestDispatcher rd = request.getRequestDispatcher("myreply.jsp");
			request.setAttribute("myreplylist", myreplylist);	
			request.setAttribute("t", t);
			request.setAttribute("ipageno", ipageno);
			request.setAttribute("startno", startno);
			request.setAttribute("endno", endno);
			request.setAttribute("maxpageno", maxpageno);
			request.setAttribute("total", total);		
			rd.forward(request, response);
		}
			
		//내 게시글 삭제
		if(uris[1].equals("pdelete.do")) {
			String noList = request.getParameter("no"); // name=no인 체크박스 checked된 애들의 값을 담은 문자열
			System.out.println("noList: " + noList); //게시글의 카테고리 (qna or myroom)이 담김

			String[] noArray = noList.split("@"); //선택한 게시글들을 각각 구분하여 배열로 저장
			
			for(int i=0 ; i<noArray.length ; i++){
				String[] data = noArray[i].split(":");
				String type = data[0]; //카테고리 종류
				String no = data[1]; //게시글 번호
				
				mdto.delete(type, no);				
			}
			response.sendRedirect("mypost.do");			
		}
		
		//내 댓글 삭제
		if(uris[1].equals("rdelete.do")) {
			System.out.println("rdelete.do 진입");
			String noList = request.getParameter("no"); // name=no인 체크박스 checked된 애들의 값을 담은 문자열
			System.out.println("noList: " + noList); //게시글의 카테고리 (qna or myroom or classboard)이 담김
			
			String[] noArray = noList.split("@"); //선택한 게시글들을 각각 구분하여 배열로 저장
			
			for(int i=0 ; i<noArray.length ; i++){
				String[] data = noArray[i].split(":");
				String type = data[0]; //카테고리 종류
				String no = data[1]; //게시글 번호
				
				mdto.delete(type, no);				
			}
			response.sendRedirect("myreply.do");				
		}
		
		//mylike.jsp 클릭시 -> 좋아요 누른 myroom 게시글 목록들 
		if(uris[1].equals("mylike.do")) {		
			System.out.println("MypageController mylike.do 진입");
			mdto.setPerList(9);
			int ipageno = Integer.parseInt(pageno);
			System.out.println("mylike.do... ipageno? : " + ipageno);
			System.out.println("유저번호 : " + user.getUno());
		
			ArrayList<MypageVO> mylikelist = mdto.getLikeList(user.getUno(), ipageno);

			//현재페이지 ipageno를 이용하여 시작번호, 끝번호를 구함
			int startno = mdto.getStartPageNo(ipageno);
			int endno   = mdto.getLastPageNo(ipageno);
			int maxpageno = mdto.getMaxPageNo();	
			
			//total을 가져와서 셋함 
			int total = mdto.getTotal();
			mdto.setTotal(total);

			System.out.println("startno: "+ startno);
			System.out.println("endno: "+ endno);

			RequestDispatcher rd = request.getRequestDispatcher("mylike.jsp");
			request.setAttribute("mylikelist", mylikelist);
			request.setAttribute("t", t);
			request.setAttribute("ipageno", ipageno);
			request.setAttribute("startno", startno);
			request.setAttribute("endno", endno);
			request.setAttribute("maxpageno", maxpageno);
			request.setAttribute("total", total);
			rd.forward(request, response);
		}

		//myclass.jsp 클릭시 -> 좋아요 누른 classboard 게시글 목록들 
		if(uris[1].equals("mypick.do")) {		
			System.out.println("MypageController mypick.do 진입");
			mdto.setPerList(9);

			int ipageno = Integer.parseInt(pageno);
			System.out.println("mypick.do... ipageno? : " + ipageno);
			System.out.println("유저번호 : " + user.getUno());
		
			ArrayList<MypageVO> mypicklist = mdto.getPickList(user.getUno(), ipageno);

			//현재페이지 ipageno를 이용하여 시작번호, 끝번호를 구함
			int startno = mdto.getStartPageNo(ipageno);
			int endno   = mdto.getLastPageNo(ipageno);
			int maxpageno = mdto.getMaxPageNo();	
			
			//total을 가져와서 셋함 
			int total = mdto.getTotal();
			mdto.setTotal(total);

			System.out.println("startno: "+ startno);
			System.out.println("endno: "+ endno);

			RequestDispatcher rd = request.getRequestDispatcher("mypick.jsp");
			request.setAttribute("mypicklist", mypicklist);	
			request.setAttribute("t", t);
			request.setAttribute("ipageno", ipageno);
			request.setAttribute("startno", startno);
			request.setAttribute("endno", endno);
			request.setAttribute("maxpageno", maxpageno);
			request.setAttribute("total", total);		
			rd.forward(request, response);
		}
		
		//myclass.jsp 클릭시 -> 수강신청 누른 classboard 게시글 목록들 
		if(uris[1].equals("myclass.do")) {		
			System.out.println("MypageController myclass.do 진입");
			mdto.setPerList(10);

			int ipageno = Integer.parseInt(pageno);
			System.out.println("myclass.do... ipageno? : " + ipageno);
			System.out.println("유저번호 : " + user.getUno());
		
			ArrayList<StudentVO> sList = mdto.sList(user.getUno(), ipageno);

			//현재페이지 ipageno를 이용하여 시작번호, 끝번호를 구함
			int startno = mdto.getStartPageNo(ipageno);
			int endno   = mdto.getLastPageNo(ipageno);
			int maxpageno = mdto.getMaxPageNo();	
			
			//total을 가져와서 셋함 
			int total = mdto.getTotal();
			mdto.setTotal(total);

			System.out.println("sList startno: "+ startno);
			System.out.println("sList endno: "+ endno);
			System.out.println("sList total: "+ total);

			RequestDispatcher rd = request.getRequestDispatcher("myclass.jsp");
			request.setAttribute("sList", sList);	
			request.setAttribute("t", t);
			request.setAttribute("ipageno", ipageno);
			request.setAttribute("startno", startno);
			request.setAttribute("endno", endno);
			request.setAttribute("maxpageno", maxpageno);
			request.setAttribute("total", total);		
			rd.forward(request, response);
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
