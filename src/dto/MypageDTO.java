package dto;

import java.util.ArrayList;

import dbms.DBManager;
import vo.*;

public class MypageDTO extends DBManager {

	private int perList;
	private int total;

	public int getPerList() { return perList; }
	public void setPerList(int perList) { this.perList = perList; }
	public int getTotal() {	return total; }
	public void setTotal(int total) { this.total = total; }


	public int getStartPageNo(int curpageno) {		
		int startPageno;
		startPageno = ((curpageno - 1)/perList) * perList + 1;
		return startPageno;
		
	}

	//현재페이지 위치를 파악하여 끝 페이지 번호를 구한다.
	public int getLastPageNo(int curpageno) {
		int lastPageno;
		lastPageno = getStartPageNo(curpageno) + (perList - 1);
		if(lastPageno > getMaxPageNo()){
			lastPageno = getMaxPageNo();
			//lastPageno++;
		}
		return lastPageno;
	} 

	//전체게시물 수를 파악하여 제일 마지막 페이지번호를 구한다. 
	public int getMaxPageNo() {
		int maxPageNo = total / perList;
		
		if(total % perList > 0) {
			maxPageNo++;
		}
		System.out.println("MypageDTO getMaxPageNO 메소드 ... 끝페이지? : "+maxPageNo);
		return maxPageNo;
		
	}
	
	
	
	//mypage.jsp 최초 접속 시 -> 내 게시물 목록 리스트 (최신 10개) 
	public ArrayList<MypageVO> getPost(int uno) {
		
		ArrayList<MypageVO> list = new ArrayList<MypageVO>();
		
		this.DBOpen();
		
		String sql = "";
		sql += "select b.no, b.title, b.date, b.uno, b.type from (";
		sql += "select no, title, date, uno, 'myroom' as type from myroom ";
		sql += "union ";
		sql += "select qno as no, title, date, uno, 'qna' as type from qna) b ";
		sql += "where b.uno = " + uno ;
		sql += " order by b.date desc ";
		sql += "limit 0 , 10 ";
		
		System.out.println("MypageDTO getlist 메소드... : " + sql);
		
		this.openQuery(sql);

		while(this.next() == true) {		
			MypageVO m = new MypageVO();
			
			m.setNo(this.getInt("no"));			
			m.setTitle(this.getValue("title"));
			m.setDate(this.getValue("date"));
			m.setUno(this.getInt("uno"));
			m.setType(this.getValue("type"));
			
			list.add(m);
		}
		this.closeQuery();
		this.DBClose();
		return list;
	}	

	//mypage.jsp 최초 접속 시  -> 내 댓글 목록 리스트 (최신 10개) 
	public ArrayList<MypageVO> getRe(int uno) {
		
		ArrayList<MypageVO> list = new ArrayList<MypageVO>();
		
		this.DBOpen();
		
		String sql = "";
		sql += "select b.no, b.title, b.date, b.uno, b.type from (";
		sql += "select no, mre as title, mredate as date, uno, 'mreply' as type from mreply ";
		sql += "union ";
		sql += "select qno as no, qre, qredate, uno, 'qreply' as type from qreply ";
		sql += "union ";
		sql += "select cno as no, cre, credate, uno, 'creply' as type from creply) b ";		
		sql += "where b.uno = " + uno ;
		sql += " order by b.date desc ";
		sql += "limit 0 , 10 ";
		
		System.out.println("MypageDTO getRe 메소드... : " + sql);
		
		this.openQuery(sql);

		while(this.next() == true) {		
			MypageVO m = new MypageVO();
			
			m.setNo(this.getInt("no"));	
			m.setTitle(this.getValue("title"));
			m.setDate(this.getValue("date"));
			m.setUno(this.getInt("uno"));
			m.setType(this.getValue("type"));
			
			list.add(m);
		}
		this.closeQuery();
		this.DBClose();
		return list;
	}		


	//mypost.jsp 접속 시 -> 전체 게시글 조회 & 페이징 메소드
	public ArrayList<MypageVO> getPostList(int uno, int pageno){
		int seqno = 0;
		int startno = (pageno - 1) * perList;
		ArrayList<MypageVO> list = new ArrayList<MypageVO>();
		
		this.DBOpen();
				
		String sql = "";
		sql = "SELECT (SELECT COUNT(*) FROM myroom where uno = " + uno + ") + ";
		sql += "(SELECT COUNT(*) FROM qna where uno = " + uno +") ";
		sql += "as total";			
			
		System.out.println("MypageDTO getPostList 메소드... as total sql 구문 : " + sql);
		
		this.openQuery(sql);
		this.next();
		
		total = this.getInt("total"); //MypageDTO private 변수 total에 저장
		
		this.closeQuery();
		System.out.println("내방+qna 전체글 개수 : " + total);
		
		seqno = total - ((pageno - 1) * perList);

		sql = "";
		sql += "select b.no, b.title, b.date, b.uno, b.type from (";
		sql += "select no, title, date, uno, 'myroom' as type from myroom ";
		sql += "union ";
		sql += "select qno as no, title, date, uno, 'qna' as type from qna) b ";
		sql += "where b.uno = " + uno ;
		sql += " order by b.date desc ";
		sql += "limit " + startno + ", " + perList + " ";
		
		
		System.out.println("MypageDTO getPostList 메소드 select 최종 구문 : " + sql);

		this.openQuery(sql);
		while(this.next() == true) {
			
			MypageVO m = new MypageVO();
	
			m.setNo(this.getInt("no"));
			m.setTitle(this.getValue("title"));
			m.setDate(this.getValue("date"));
			m.setUno(this.getInt("uno"));
			m.setType(this.getValue("type"));
			
			System.out.println("NO? : " + m.getNo());
			
			list.add(m);
			seqno--;
		}
		
		this.closeQuery();
		this.DBClose();
		return list;
	}
	
	//myreply.jsp 접속 시 -> 전체 댓글 조회 & 페이징 메소드
	public ArrayList<MypageVO> getReplyList(int uno, int pageno){
		int seqno = 0;
		int startno = (pageno - 1) * perList;
		ArrayList<MypageVO> list = new ArrayList<MypageVO>();
		
		this.DBOpen();
		
		String sql = "";
		sql = "SELECT (SELECT COUNT(*) FROM mreply where uno = " + uno + ") + ";
		sql += "(SELECT COUNT(*) FROM creply where uno = " + uno +") + ";
		sql += "(SELECT COUNT(*) FROM qreply where uno = " + uno +") ";
		sql += "as total";			

		System.out.println("MypageDTO getReplyList 메소드... as total sql 구문 : " + sql);

		this.openQuery(sql);
		this.next();

		total = this.getInt("total");
		this.closeQuery();
		System.out.println("내방+class+qna 전체댓글 개수 : " + total);

		seqno = total - ((pageno - 1) * perList);

		sql = "";
		sql += "select b.no, b.title, b.date, b.uno, b.type from (";
		sql += "select no, mre as title, mredate as date, uno, 'mreply' as type from mreply ";
		sql += "union ";
		sql += "select qno as no, qre as title, qredate as date, uno, 'qreply' as type from qreply ";
		sql += "union ";
		sql += "select cno as no, cre as title, credate as date, uno, 'creply' as type from creply) b ";
		sql += "where b.uno = " + uno ;
		sql += " order by b.date desc ";
		sql += "limit " + startno + ", " + perList + " ";
		
		System.out.println("MypageDTO getReplyList 메소드 select 최종 구문 : " + sql);

		this.openQuery(sql);
		while(this.next() == true) {
			
			MypageVO m = new MypageVO();
		
			m.setNo(this.getInt("no"));
			m.setTitle(this.getValue("title"));
			m.setDate(this.getValue("date"));
			m.setUno(this.getInt("uno"));
			m.setType(this.getValue("type"));
			
			System.out.println("NO? : " + m.getNo());
			
			list.add(m);
			seqno--;
		}
		
		this.closeQuery();
		this.DBClose();
		return list;	
	}

	//mypost.jsp, myreply.jsp 에서 내 게시글/내 댓글 삭제  -> no(no,qno)와 type(클래스이름) 
	public void delete(String type, String no){

		try{
			DBOpen();
			String sql = "";
			
			//내 게시글 삭제하기..
			if(type.equals("myroom")) {
				sql += "delete from myroom where no = " + no;
			}
			if(type.equals("qna")) {
				sql += "delete from qna where qno = " + no;
			}
			
			//내 댓글 삭제하기
			if(type.equals("mreply")) {
				sql += "delete from mreply where mreno = " + no;
			}
			if(type.equals("creply")) {
				sql += "delete from creply where creno = " + no;
			}
			if(type.equals("qreply")) {
				sql += "delete from qreply where qreno = " + no;
			}
			
			this.execute(sql);
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
			DBClose();
		}
	}
	
	//mypage.jsp, mylike.jsp, myclass.jsp 에서 좋아요, 찜한 갯수 구하는 메소드
	public int mycount(int uno, String board, String check) {
		this.DBOpen();
		
		//board = {mrelike, classpick}, check = {likecheck, pickcheck}
		String sql = "";
		sql = "select count(*) as total from " + board;
		sql += " where uno='"+ uno + "' and " + check + " = 'Y'" ;		
			
		System.out.println("MypageDTO mycount sql...? : " + sql);
		
		this.openQuery(sql);
		this.next();
		
		total = this.getInt("total");
		this.closeQuery();
		this.DBClose();		
		return total;
	}
	
	
	//mypage.jsp 접속 시 -> 내가 좋아요한 myroom 게시글 들을 불러옴
	public ArrayList<MypageVO> getLikeList(int uno, int pageno){
		int seqno = 0;
		int startno = (pageno - 1) * 6;
		ArrayList<MypageVO> list = new ArrayList<MypageVO>();
		
		this.DBOpen();
		
		String sql = "";
		sql = "select count(*) as total from mrelike ";
		sql += "where uno='"+ uno + "' and likecheck = 'Y'" ;		
			
		System.out.println("MypageDTO getLikeList 메소드... as total sql 구문 : " + sql);
		
		this.openQuery(sql);
		this.next();
		
		total = this.getInt("total");
		this.closeQuery();
		
		seqno = total - ((pageno - 1) * 6);
		
		//해당 유저가 좋아요 한 myroom 게시글의 제목, 글 작성자, 날짜, 대표사진을 가져온다.
		sql = "";
		sql += "select no, title, name, date, (select mattach from mattach where no = myroom.no) as dimage ";
		sql += "from myroom where no in ";
		sql += "(select no from mrelike where uno = '" + uno + "' and likecheck = 'Y') ";
		sql += "order by date desc ";
		sql += "limit " + startno + ", " + perList ;
		
		System.out.println("getLikeList select sql : " + sql);
		this.openQuery(sql);
		while(this.next() == true) {
			
			MypageVO m = new MypageVO();
			
			m.setNo(this.getInt("no"));
			m.setTitle(this.getValue("title"));
			m.setName(this.getValue("name"));
			m.setDate(this.getValue("date"));
			m.setDimage(this.getValue("dimage"));
			
			System.out.println("dimage? : " + m.getDimage());
			
			list.add(m);			
			seqno--;
		}
		this.closeQuery();
		this.DBClose();
		return list;		
	}
	
	//mypage.jsp 접속 시 -> 내가 찜한 classboard 게시글 들을 불러옴
	public ArrayList<MypageVO> getPickList(int uno, int pageno){
		int seqno = 0;
		int startno = (pageno - 1) * (perList - 1);
		ArrayList<MypageVO> list = new ArrayList<MypageVO>();
		
		this.DBOpen();
		
		String sql = "";
		sql = "select count(*) as total from classpick ";
		sql += "where uno='"+ uno + "' and pickcheck = 'Y'" ;		
			
		System.out.println("MypageDTO getPickList 메소드... as total sql 구문 : " + sql);
		
		this.openQuery(sql);
		this.next();
		
		total = this.getInt("total");
		this.closeQuery();
		
		seqno = total - ((pageno - 1) * perList);
		
		//해당 유저가 좋아요 한 classboard 게시글의 제목, 글 작성자, 날짜, 대표사진을 가져온다.
		sql = "";
		sql += "select cno, title, name, date, (select dcattach from dcattach where cno = classboard.cno) as dimage ";
		sql += "from classboard where cno in ";
		sql += "(select cno from classpick where uno = '" + uno + "' and pickcheck = 'Y') ";
		sql += "order by date desc ";
		sql += "limit " + startno + ", " + perList ;
		
		System.out.println("getPickList select sql : " + sql);
		this.openQuery(sql);
		while(this.next() == true) {
			
			MypageVO m = new MypageVO();
			
			m.setNo(this.getInt("cno"));	
			m.setTitle(this.getValue("title"));
			m.setName(this.getValue("name"));
			m.setDate(this.getValue("date"));
			m.setDimage(this.getValue("dimage"));
			
			System.out.println("dimage? : " + m.getDimage());
			
			list.add(m);			
			seqno--;
		}
		this.closeQuery();
		this.DBClose();
		return list;		
	}
	
	//mypage.jsp 접속 시 -> 수강신청한 클래스 목록을 불러온다. 
	public ArrayList<StudentVO> sList(int uno, int pageno){		
		
		int seqno = 0;
		int startno = (pageno - 1) * (perList - 1);
		ArrayList<StudentVO> sList = new ArrayList<StudentVO>();
		
		this.DBOpen();
		
		String sql = "";
		sql  = "select count(*) as total from student ";
		sql += "where uno="+ uno ;		
			
		System.out.println("MypageDTO getsList 메소드... as total sql 구문 : " + sql);
		
		this.openQuery(sql);
		this.next();
		
		total = this.getInt("total");
		this.closeQuery();
		
		seqno = total - ((pageno - 1) * perList);
		
		sql  = "select cno,title,date from student where uno="+uno;
		sql += " order by date desc";
		System.out.println("ListDTO의 sList메소드 : " + sql);
		this.openQuery(sql);			

		
		while(this.next() == true){
			StudentVO s = new StudentVO();
					
			s.setCno(this.getInt("cno"));	
			s.setTitle(this.getValue("title"));	
			s.setDate(this.getValue("date"));	
			System.out.println("ListDTO의 sList cno : " + s.getCno());
			System.out.println("ListDTO의 sList title : " + s.getTitle());
			System.out.println("ListDTO의 sList date : " + s.getDate());
			
			sList.add(s);	
			seqno--;
		}
		closeQuery();
		DBClose();
		
		return sList;
			
	
	}
	
}
