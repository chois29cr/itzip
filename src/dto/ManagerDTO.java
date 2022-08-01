package dto;

import java.util.ArrayList;

import dbms.DBManager;
import vo.*;
import dto.*;

public class ManagerDTO extends DBManager {
	
	final static int PER_LIST = 10;
	private int total;
	
	public int getPER_LIST() {
		return PER_LIST;
	}
	
	public void setTotal(int total) {
		this.total = total;
	}

	public int getTotal() {
		return total;
	}
	
	//qno,ncheck를 받아서 공지사항 등록/해제
	public String notice(int qno, String ncheck){
		this.DBOpen();
		String sql ="";
		String result ="";
			
		if(ncheck.equals("Y")) {
			System.out.println("notice 메소드 첫번째 ");
			sql="update qna set ncheck = 'N' where qno = " + qno ;			
			this.execute(sql);
			this.next();
			this.DBClose();
			result = "N";
		}else {  //ncheck == "N"일 때 실행
			System.out.println("notice 메소드 두번째 ");
			sql="update qna set ncheck = 'Y' where qno = " + qno ;			
			this.execute(sql);
			this.next();
			this.DBClose();
			result= "Y";
		}
		return result;
	}
	
	
	//게시물 목록과 페이징을 처리한다.
	public ArrayList<ManagerVO> getList(int pageno) {
		
		int seqno = 0;
		int startno = (pageno - 1) * PER_LIST;
		ArrayList<ManagerVO> List = new ArrayList<ManagerVO>();
		
		this.DBOpen();
		
		String sql = "";
		sql = "SELECT (SELECT COUNT(*) FROM myroom) + (SELECT COUNT(*) FROM qna) as total";			
			
		System.out.println("ManagerDTO getlist 메소드... as total sql 구문 : " + sql);
		
		this.openQuery(sql);
		this.next();
		total = this.getInt("total");
		this.closeQuery();		
		System.out.println("내방+qna 전체글 개수 : " + total);
		
		seqno = total - ((pageno - 1) * PER_LIST);
		
		sql = "select no,title,name,date,'myroom' as type from myroom ";  
		sql += "union select qno,title,name,date,'qna' as type from qna ";
		sql += "order by date desc ";	
		
		sql += "limit " + startno + ", " + PER_LIST + " ";
		
		System.out.println("manager 리스트 select 최종 구문 : " + sql);
		
		this.openQuery(sql);
		while(this.next() == true) {
			
			ManagerVO m = new ManagerVO();

			m.setTitle(this.getValue("title"));
			m.setNo(this.getInt("no"));
			m.setName(this.getValue("name"));
			m.setDate(this.getValue("date"));
			m.setType(this.getValue("type"));
			
			List.add(m);
	
			seqno--;
		}
		this.closeQuery();
		this.DBClose();
		return List;
	}
	
	public int getStartPageNo(int curpageno) {		
		int startPageno;
		startPageno = ((curpageno - 1)/PER_LIST) * PER_LIST + 1;
		return startPageno;
		
	}

	//현재페이지 위치를 파악하여 끝 페이지 번호를 구한다.
	public int getLastPageNo(int curpageno) {
		int lastPageno;
		lastPageno = getStartPageNo(curpageno) + 9;
		if(lastPageno > getMaxPageNo())
		{
			lastPageno = getMaxPageNo();
			//lastPageno++;
		}
		return lastPageno;
	} 
	
	//전체게시물 수를 파악하여 제일 마지막 페이지번호를 구한다. 
	public int getMaxPageNo() {
		int maxPageNo = total / PER_LIST;
		
		if(total % PER_LIST > 0) {
			maxPageNo++;
		}
		System.out.println("ManagerDTO getMaxPageNO 메소드 ... 끝페이지? : "+maxPageNo);
		return maxPageNo;
		
	}
	
	
	//전체 댓글 목록을 구한다
	public ArrayList<ManagerVO> getRlist(int pageno) {
		ArrayList<ManagerVO> rList = new ArrayList<ManagerVO>();
		
		try {
			int seqno = 0;
			int startno = (pageno - 1) * PER_LIST;
			ArrayList<ManagerVO> Rlist = new ArrayList<ManagerVO>();
			
			this.DBOpen();
			
			String sql = "";
			sql = "SELECT (SELECT COUNT(*) FROM mreply) + (SELECT COUNT(*) FROM qreply) + (SELECT COUNT(*) FROM creply) as total";			
				
			System.out.println("ManagerDTO getRlist 메소드... as total sql 구문 : " + sql);
			
			this.openQuery(sql);
			this.next();
			total = this.getInt("total");
			this.closeQuery();		
			System.out.println("내방+qna+클래스 전체댓글 개수 : " + total);
			
			seqno = total - ((pageno - 1) * PER_LIST);
			
			sql = "select mreno as no, mre as re, mrename as rname, mredate as rdate, 'mreply' as type from mreply ";  
			sql += "union select qreno, qre,qrename,qredate, 'qreply' as type from qreply ";
			sql += "union select creno, cre, crename, credate, 'creply' as type from creply ";
			sql += "order by rdate desc ";
			
			sql += "limit " + startno + ", " + PER_LIST + " ";
					
			System.out.println("ManagerDTO의 getRlist 메소드 : " + sql);		
			this.openQuery(sql);
			
			while(this.next() == true){
				
				ManagerVO m = new ManagerVO();

				m.setNo(this.getInt("no"));
				m.setRe(this.getValue("re"));
				m.setRname(this.getValue("rname"));
				m.setRdate(this.getValue("rdate"));
				m.setType(this.getValue("type"));
				
				rList.add(m);	
			}
			
			this.closeQuery();	
			this.DBClose();
			
		}catch(Exception e) {
			e.printStackTrace();
			return rList;
		}
		return rList;
	}
	
	//클래스 글 목록과 페이징을 처리한다. 
	public ArrayList<ClassboardVO> getClist(int pageno) {
		
		int seqno = 0;
		int startno = (pageno - 1) * PER_LIST;
		ArrayList<ClassboardVO> List = new ArrayList<ClassboardVO>();
		
		this.DBOpen();
		
		String sql = "";
		sql = "SELECT COUNT(*) as total FROM classboard ";			
			
		System.out.println("ManagerDTO getClist 메소드... as total sql 구문 : " + sql);
		
		this.openQuery(sql);
		this.next();
		total = this.getInt("total");
		this.closeQuery();		
		System.out.println("class 전체글 개수 : " + total);
		
		seqno = total - ((pageno - 1) * PER_LIST);
		
		sql = "select cno,title,name,date,'classboard' as type from classboard ";  
		sql += "order by date desc ";	
		
		sql += "limit " + startno + ", " + PER_LIST + " ";
		
		System.out.println("manager c리스트 select 최종 구문 : " + sql);
		
		this.openQuery(sql);
		while(this.next() == true) {
			
			ClassboardVO m = new ClassboardVO();

			m.setTitle(this.getValue("title"));
			m.setCno(this.getInt("cno"));
			m.setName(this.getValue("name"));
			m.setDate(this.getValue("date"));
			m.setType(this.getValue("type"));
			
			List.add(m);
	
			seqno--;
		}
		this.closeQuery();
		this.DBClose();
		return List;
	}
	
	//클래스 글 목록과 페이징을 처리한다. 
	public ArrayList<UserinfoVO> getUlist(int pageno) {
		
		int seqno = 0;
		int startno = (pageno - 1) * PER_LIST;
		ArrayList<UserinfoVO> List = new ArrayList<UserinfoVO>();
		
		this.DBOpen();
		
		String sql = "";
		sql = "SELECT COUNT(*) as total FROM userinfo ";			
			
		System.out.println("ManagerDTO getUlist 메소드... as total sql 구문 : " + sql);
		
		this.openQuery(sql);
		this.next();
		total = this.getInt("total");
		this.closeQuery();		
		System.out.println("전체회원 수 : " + total);
		
		seqno = total - ((pageno - 1) * PER_LIST);
		
		sql = "select uno,email,name,'userinfo' as type from userinfo ";  
		sql += "order by uno desc ";	
		
		sql += "limit " + startno + ", " + PER_LIST + " ";
		
		System.out.println("manager u리스트 select 최종 구문 : " + sql);
		
		this.openQuery(sql);
		while(this.next() == true) {
			
			UserinfoVO m = new UserinfoVO();

			m.setUno(this.getInt("uno"));
			m.setEmail(this.getValue("email"));
			m.setName(this.getValue("name"));
			m.setType(this.getValue("type"));
			
			List.add(m);
	
			seqno--;
		}
		this.closeQuery();
		this.DBClose();
		return List;
	}
	
	//클래스 별 수강생 목록을 구한다. 
	public ArrayList<StudentVO> getSlist(String cno, int pageno){
		int seqno = 0;
		int startno = (pageno - 1) * PER_LIST;
		ArrayList<StudentVO> List = new ArrayList<StudentVO>();
		
		this.DBOpen();
		
		String sql = "";
		sql += "select count(*) as total from student ";
		sql += "where cno=" + cno;
		
		this.openQuery(sql);
		this.next();
		total = this.getInt("total");
		this.closeQuery();		
		System.out.println("해당 클래스 수강생 수 : " + total);
		
		seqno = total - ((pageno - 1) * PER_LIST);
		
		sql = "select uno,name,phone,date,title from student ";  
		sql += "where cno="+cno;
		sql += " order by date desc ";	
		
		sql += "limit " + startno + ", " + PER_LIST + " ";
		
		System.out.println("manager s리스트 select 최종 구문 : " + sql);
		
		this.openQuery(sql);
		while(this.next() == true) {
			
			StudentVO s = new StudentVO();

			s.setUno(this.getInt("uno"));
			s.setName(this.getValue("name"));
			s.setPhone(this.getValue("phone"));
			s.setDate(this.getValue("date"));
			s.setTitle(this.getValue("title"));
			
			List.add(s);
	
			seqno--;
		}
		this.closeQuery();
		this.DBClose();
		return List;
		
	} 
	
	//전체글 삭제 no(no,qno)와 type(클래스이름) 
	public void delete(String no, String type){

		try{
			DBOpen();
			String sql = "";
			
			if(type.equals("myroom")) {
				
				sql += "delete from myroom ";
				sql += "where no = " + no;				
			}
			if(type.equals("qna")) {
				
				sql += "delete from qna ";
				sql += "where qno = " + no;				
			}
			if(type.equals("mreply")) {
				
				sql += "delete from mreply ";
				sql += "where mreno = " + no;				
			}
			if(type.equals("qreply")) {
				
				sql += "delete from qreply ";
				sql += "where qreno = " + no;				
			}
			if(type.equals("creply")) {
				
				sql += "delete from creply ";
				sql += "where creno = " + no;				
			}			
			if(type.equals("classboard")) {
				
				sql += "delete from classboard ";
				sql += "where cno = " + no;				
			}
			if(type.equals("userinfo")) {
				
				sql += "delete from userinfo ";
				sql += "where uno = " + no;				
			}			
			
			System.out.println("ManagerDTO delete sql: "+sql);
			execute(sql);
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();			
		}	
	}	
	
	
	

}
