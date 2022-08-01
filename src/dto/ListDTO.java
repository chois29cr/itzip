package dto;

import java.util.ArrayList;

import dbms.*;
import vo.*;



public class ListDTO extends DBManager {

	private int perList;
	private int total;
	private String where ="" ;
	
	//getter, setter
	public int getTotal() { return total; }	
	public void setTotal(int total) { this.total = total; }
	public String getWhere() { return where; }
	public void setWhere(String where) { this.where = where; }
	public int getPerList() { return perList; }	
	public void setPerList(int perList) { this.perList = perList; }
	
	
	//클래스 글 목록을 불러온다.
	public ArrayList<ClassboardVO> cList(String num){
		
		ArrayList<ClassboardVO> list = new ArrayList<ClassboardVO>();
				
		
		try {
		
			DBOpen();
					
			String sql = "";
			sql += "select cno,uno,title,name,date,hit from classboard ";
			sql += "where cno = " + num;
			sql += " order by cno desc ";			

			System.out.println("ListDTO의 cList 메소드 : " + sql);		
			this.openQuery(sql);
			
			while(this.next() == true){
				
				ClassboardVO c = new ClassboardVO();

				c.setCno(this.getInt("cno"));
				c.setUno(this.getInt("uno"));
				c.setTitle(this.getValue("title"));
				c.setName(this.getValue("name"));					
				c.setDate(this.getValue("date"));
				c.setHit(this.getInt("hit"));

				list.add(c);	
			}
			
			this.closeQuery();	
			this.DBClose();
			
		}catch(Exception e) {
			e.printStackTrace();
			return list;
		}
		return list;			
	}
	
	//Classboard.jsp로  갔을때 글 목록을 불러온다.
	public ArrayList<ClassboardVO> cList(int pageno, String k, String t) {
		
		int seqno = 0;
		//int PER_LIST = 16;
		int startno = (pageno - 1) * perList;
		
		ArrayList<ClassboardVO> clist = new ArrayList<ClassboardVO>();

		try {
			
			this.DBOpen();
			
			String sql = "";
			sql = "select count(*) as total ";
			sql += "from classboard ";		
			
			
			if(k != null) {
				sql += "where title like '%" + k + "%' ";
			}
			
			
			System.out.println("ClassboardlistVO getlist 메소드... k!=null 검사 이후 sql 구문 : " + sql);
			
			this.openQuery(sql);
			this.next();
			total = this.getInt("total");
			this.setTotal(total);
			this.closeQuery();		
			System.out.println("classboard 글 리스트 개수 : " + total);			
			
			
			seqno = total - ((pageno - 1) * perList);
			
			sql  = "select * ";
			sql += "from classboard ";
			
			if(k != null) {
				sql += "where title like '%" + k + "%' ";
			}
			
			if(t.equals("1")) {
				sql += "order by date desc ";
			}
			if(t.equals("2")) {
				sql += "order by date asc ";
			}
			if(t.equals("3")) {
				sql += "order by hit desc ";
			}
			
			
			sql += "limit " + startno + ", " + perList + " ";
			
			System.out.println("classboard 리스트 select 최종 구문 : " + sql);
			
			this.openQuery(sql);
			while(this.next() == true) {
				
				ClassboardVO item = new ClassboardVO();
				
				item.setCno(this.getInt("cno"));
				item.setUno(this.getInt("uno"));
				item.setTitle(this.getValue("title"));
				item.setBody(this.getValue("body"));
				item.setName(this.getValue("name"));
				item.setDate(this.getValue("date"));
				item.setHit(this.getInt("hit"));	
				
				clist.add(item);
		
				seqno--;
			}
			
			this.closeQuery();
			this.DBClose();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return clist;
	}
	
	//찜한 클래스 목록을 불러온다. 
	public ArrayList<ClassboardVO> pList(String num){		
		ArrayList<ClassboardVO> pList = new ArrayList<ClassboardVO>();
		try{
			
			DBOpen();
			
			String sql ="";
			sql  = "select cno,title,name from classboard where cno in (select cno from classpick where uno="+num+" and pickcheck='Y')";
			System.out.println("ListDTO의 pList메소드 : " + sql);
			this.openQuery(sql);			

			
			while(this.next() == true){
			ClassboardVO p = new ClassboardVO();
					
			p.setCno(this.getInt("cno"));	
			p.setTitle(this.getValue("title"));	
			p.setName(this.getValue("name"));	
			System.out.println("ListDTO의 cno : " + p.getCno());
			System.out.println("ListDTO의 name : " + p.getName());
			System.out.println("ListDTO의 title : " + p.getTitle());

			
			pList.add(p);	
			}
			closeQuery();
			DBClose();
			
			return pList;
			
		}catch(Exception e) {
			e.printStackTrace();
			DBClose();
			return null;
			}
		}
	
	//댓글 
	//classboard 글에서 댓글 목록 뿌려주는 메소드
	public ArrayList<CreplyVO> crList(String num, int pageno, String k, String t){
		int seqno = 0;
		int startno = (pageno - 1) * 5;
		
		ArrayList<CreplyVO> crList = new ArrayList<CreplyVO>();
		CreplyDTO dto = new CreplyDTO();
		
		try {
			DBOpen();			
			
			total = dto.getRcount(num);
			this.setTotal(total);
			System.out.println("ListDTO crList total:"+ this.getTotal());
			
			seqno = total - ((pageno - 1) * 5);
			
			String sql ="";
			sql += "select ";
			sql += "creno, uno, cno, cre, crename, credate, ";
			sql += "(select file from userinfo where uno = creply.uno) as file ";
			sql += "from creply ";				
			sql += "where cno = " + num;
			sql += " order by creno desc ";				
			sql += "limit " + startno + ", 5 ";		
					
			System.out.println("ListDTO의 crList 메소드 : " + sql);
			
			this.openQuery(sql);
			
			while(this.next() == true){
				
				CreplyVO cr = new CreplyVO();
				
				cr.setCreno(this.getInt("creno"));
				cr.setUno(this.getInt("uno"));
				cr.setCno(this.getInt("cno"));
				cr.setCre(this.getValue("cre"));
				cr.setCrename(this.getValue("crename"));
				cr.setCredate(this.getValue("credate"));
				cr.setFile(this.getValue("file"));	
				
				crList.add(cr);		
				seqno--;
			}
			
			this.closeQuery();	
			this.DBClose();
			
		}catch(Exception e) {
			e.printStackTrace();
			return crList;
		}
		return crList;			
	}
	
	//end of class DTO
	
	//myroom DTO start
	
	//[todo] pageDTO import //내방 글목록 & 페이징
	public ArrayList<MyroomVO> mList(int pageno, String k, String t, UserinfoVO u) {
		
		int seqno = 0;
		int startno = (pageno - 1) * 9;
		
		ArrayList<MyroomVO> mList = new ArrayList<MyroomVO>();
		
		this.DBOpen();
		
		String sql = "";
		sql = "select count(*) as total ";
		sql += "from myroom ";		
		
	
		
		if(k != null) {
			sql += "where title like '%" + k + "%' ";
		}
		
		
		System.out.println("MyroomlistDTO getlist 메소드... k!=null 검사 이후 sql 구문 : " + sql);
		
		this.openQuery(sql);
		this.next();
		total = this.getInt("total");
		this.setTotal(total);
		this.closeQuery();		
		System.out.println("myroom 글 리스트 개수 : " + total);
		
		seqno = total - ((pageno - 1) * 9);
		
		sql  = "select * ";
		sql += "from myroom ";
		
		if(k != null) {
			sql += "where title like '%" + k + "%' ";
		}
		
		if(t.equals("1")) {
			sql += "order by date desc ";
		}
		if(t.equals("2")) {
			sql += "order by date asc ";
		}
		if(t.equals("3")) {
			if(u != null) {
				sql  = "select r.uno, r.title, r.name, r.no, r.hit, u.email, u.texture from myroom r, userinfo u ";
				sql += "where r.uno = u.uno order by field(texture,'"+u.getTexture()+"') desc " ;
			}else{
				sql += "order by hit desc ";
			}
		}
		
		sql += "limit " + startno + ", " + 9 + " ";
		
		System.out.println("ListDTO의 mList 메소드 : " + sql);
		
		this.openQuery(sql);
		while(this.next() == true) {
			
			MyroomVO item = new MyroomVO();
			
			UserinfoDTO udto = new UserinfoDTO();
			UserinfoVO tu = new UserinfoVO();
			tu = udto.profile(this.getInt("uno"));
			
			item.setNo(this.getInt("no"));
			item.setUno(this.getInt("uno"));
			item.setTitle(this.getValue("title"));
			item.setBody(this.getValue("body"));
			item.setName(this.getValue("name"));
			item.setDate(this.getValue("date"));
			item.setHit(this.getInt("hit"));
			item.setTexture(tu.getTexture());
			
			
			mList.add(item);
	
			seqno--;
		}
		this.closeQuery();
		this.DBClose();
		return mList;
	}
	
	//mattach 리스트를 가져온다.
	public MattachVO dImage(int no){
		
		MattachVO dImage = new MattachVO();
		
		try {
			
			DBOpen();	
			
			String sql="";
			sql += "select no, mno, mattach from mattach ";
			sql += "where no= " + no ;
	
			System.out.println("ListDTO maList 메소드 : " + sql);
			
			this.openQuery(sql);
			
			while(this.next() == true){
				
				dImage.setNo(this.getInt("no"));
				dImage.setMno(this.getInt("mno"));
				dImage.setMattach(this.getValue("mattach"));					
										
			}
			this.closeQuery();	
			this.DBClose();	
			
		}catch(Exception e) {
			e.printStackTrace();
			return dImage;
		}
		return dImage;
	}
	
	//myroom 글에서 댓글 목록 뿌려주는 메소드
	public ArrayList<MreplyVO> mrList(String num, int pageno, String k, String t){
		int seqno = 0;
		int startno = (pageno - 1) * 5;
		
		ArrayList<MreplyVO> mrList = new ArrayList<MreplyVO>();
		MreplyDTO dto = new MreplyDTO();
		
		DBOpen();
		
		total = dto.getRcount(Integer.parseInt(num));
		this.setTotal(total);
		System.out.println("ListDTO mrList total:"+ this.getTotal());
		
		seqno = total - ((pageno - 1) * 5);
		
		String sql ="";
		sql += "select ";
		sql += "mreno, uno, no, mre, mrename, mredate, ";
		sql += "(select file from userinfo where uno = mreply.uno) as file ";
		sql += "from mreply ";				
		sql += "where no = " + num;
		sql += " order by mreno desc ";				
		sql += "limit " + startno + ", 5 ";
		
		System.out.println("ListDTO의 mrList 메소드 : " + sql);
		
		this.openQuery(sql);
		
		while(this.next() == true){
			
			MreplyVO mr = new MreplyVO();
			mr.setMreno(getInt("mreno"));
			mr.setUno(getInt("uno"));
			mr.setNo(getInt("no"));
			mr.setMre(getValue("mre"));
			mr.setMrename(getValue("mrename"));
			mr.setMredate(getValue("mredate"));
			mr.setFile(getValue("file"));
			
			mrList.add(mr);
			seqno--;
		}
		
		this.closeQuery();
		this.DBClose();
	
		return mrList;	
	}
	
	//end of myroom
	
	//qna DTO start
	public ArrayList<QnaVO> nList() {
		ArrayList<QnaVO> nList = new ArrayList<QnaVO>();
		this.DBOpen();
		String sql = "";
		sql = "select * from qna where ncheck = 'Y' order by date desc ";
		this.openQuery(sql);
		
		while(this.next() == true) {
			
			QnaVO item = new QnaVO();
			
			item.setQno(this.getInt("qno"));
			item.setUno(this.getInt("uno"));
			item.setTitle(this.getValue("title"));
			item.setBody(this.getValue("body"));
			item.setName(this.getValue("name"));
			item.setDate(this.getValue("date"));
			item.setHit(this.getInt("hit"));
			item.setFile(this.getValue("file"));
			item.setNcheck(this.getValue("ncheck"));
			
			nList.add(item);
		}
		this.closeQuery();
		DBClose();
		return nList;
	}
	
	
	public ArrayList<QnaVO> qList(int pageno, String k, String t) {
		ArrayList<QnaVO> qList = new ArrayList<QnaVO>();
		
		int seqno = 0;
		int startno = (pageno - 1) * 5;
		
		this.DBOpen();
		
		String sql = "";
		sql = "select count(*) as total ";
		sql += "from qna ";		
		
		
		if(k != null) {
			sql += "where title like '%" + k + "%' ";
			sql += "or body like '%" + k + "%' ";
		}
		
		this.openQuery(sql);
		this.next();
		total = this.getInt("total");
		this.setTotal(total);
		this.closeQuery();
		
		System.out.println("qna 글 리스트 개수 : " + total);
		
		seqno = total - ((pageno - 1) * 5);
		
		sql = "select qno, uno, title, body, name, date, hit, ";
		sql += "(select file from userinfo where uno = qna.uno) as file ";
		sql += "from qna ";
		
		if(k != null) {
			sql += "where title like '%" + k + "%' ";
			sql += "or body like '%" + k + "%' ";
		}
		
		if(t.equals("1")) {
			sql += "order by date desc ";
		}
		if(t.equals("2")) {
			sql += "order by date asc ";
		}
		if(t.equals("3")) {
			sql += "order by hit desc ";
		}
		
		sql += "limit " + startno + ", " + 5 + " ";
		
		System.out.println("ListDTO qList 메소드 select 최종 구문 : " + sql);
		
		this.openQuery(sql);
		while(this.next() == true) {
			
			QnaVO item = new QnaVO();
			
			item.setQno(this.getInt("qno"));
			item.setUno(this.getInt("uno"));
			item.setTitle(this.getValue("title"));
			item.setBody(this.getValue("body"));
			item.setName(this.getValue("name"));
			item.setDate(this.getValue("date"));
			item.setHit(this.getInt("hit"));
			item.setFile(this.getValue("file"));
			
			System.out.println("qList메소드 file명:"+this.getValue("file"));
			qList.add(item);
	
			seqno--;
		}
		
		this.closeQuery();
		this.DBClose();
		return qList;
	}
	
	//qna 글에서 댓글 목록 뿌려주는 메소드
	public ArrayList<QreplyVO> qrList(String num, int pageno, String k, String t){
		int seqno = 0;
		int startno = (pageno - 1) * 5;
		
		ArrayList<QreplyVO> qrList = new ArrayList<QreplyVO>();
		QreplyDTO dto = new QreplyDTO();
			
		DBOpen();			
		
		total = dto.getRcount(Integer.parseInt(num));
		this.setTotal(total);
		System.out.println("ListDTO total:"+ this.getTotal());
		
		seqno = total - ((pageno - 1) * 5);
		
		String sql ="";
		sql += "select qreno, uno, qno, qre, qrename, qredate, ";
		sql += "(select file from userinfo where uno= qreply.uno) as file ";
		sql += "from qreply ";					
		sql += "where qno = " + num;
		sql += " order by qreno desc ";				
		sql += "limit " + startno + ", 5 ";
		
		System.out.println("ListDTO의 qrList 메소드 : " + sql);
		
		this.openQuery(sql);
		
		while(this.next() == true){
			
			QreplyVO qr = new QreplyVO();
			
			qr.setQreno(this.getInt("qreno"));
			qr.setUno(this.getInt("uno"));
			qr.setQno(this.getInt("qno"));
			qr.setQre(getValue("qre"));
			qr.setQrename(getValue("qrename"));
			qr.setQredate(getValue("qredate"));					
			qr.setFile(getValue("file"));					
									
			qrList.add(qr);			
			seqno--;
		}
		
		this.closeQuery();	
		this.DBClose();
		return qrList;
					
	}	
	
	//end of QNA
	
	
	//---------여기서부터 페이징------------
	//list 불러오는 .jsp에서 setPerList(숫자) 지정하여 사용

	public int getStartPageNo(int curpageno) {		
		int startPageno;
		startPageno = ((curpageno - 1)/perList) * perList + 1;
		return startPageno;
		
	}

	
	public int getLastPageNo(int curpageno) {
		int lastPageno;
		lastPageno = getStartPageNo(curpageno) + (perList - 1);    
		if(lastPageno > getMaxPageNo())
		{
			lastPageno = getMaxPageNo();
			//lastPageno++;
		}
		return lastPageno;
	} 
	
	public int getMaxPageNo() {
		System.out.println(perList);
		System.out.println(getTotal());
		
		int maxPageNo = total / perList;
		
		if(total % perList > 0) {
			maxPageNo++;
		}
		System.out.println("ListDTO getMaxPage...total? : "+this.getTotal());
		System.out.println("ListDTO getMaxPage...끝페이지? : "+maxPageNo);
		return maxPageNo;
		
	}	
}
