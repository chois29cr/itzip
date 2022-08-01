package dto;

import dbms.DBManager;
import vo.MyroomVO;
import vo.QnaVO;
import vo.UserinfoVO;
import utility.*;

public class QnaDTO extends DBManager{
	
	private String qno;
	public String getQno() { return qno; }
	
	
	//qna 글쓰기
	public void write(UserinfoVO user, QnaVO qna){	
		try {			
			DBOpen();
			
			String sql = "";
			sql += "insert into qna ";
			sql += "(uno, title, body, name, date, hit) ";
			sql += "values ";
			sql += "('";
			sql += user.getUno() + "', '";
			sql += Utility._R(qna.getTitle()) + "', '";
			sql += Utility._R(qna.getBody())  + "', '"; 
			sql += qna.getName() + "', now(), '";
			sql += qna.getHit();
			sql += "') ";

			
			System.out.println("QnaDTO의 write메소드 : " + sql);		
			execute(sql);
			
			this.qno = this.getLastID("qno");
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();			
		}
	}
	
	
	//qna 글수정
	public void modify(UserinfoVO user, QnaVO qna){
		try	{					
			DBOpen();
			
			String sql = "";
			sql += "update qna ";
			sql += "set title= '" + Utility._R(qna.getTitle()) + "', " ;
			sql += "body = '" + Utility._R(qna.getBody()) + "' ";
			sql += "where qno = " + qna.getQno();
			
			System.out.println("QnaDTO의 modify메소드 : " + sql);
			
			execute(sql);
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();			
		}	
	}
	
	//qna 글삭제
	public void delete(String qno){
		try{			
			DBOpen();
			
			String sql = "";
			sql += "delete from qna ";
			sql += "where qno = " + qno;
			
			execute(sql);
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();			
		}	
	}
	
	//쿠키를 사용하여 조회수 무한 증가를 막는다. 
	public void hit(String qno) {
		DBOpen();
		
		String sql ="";
		sql  = "update qna set hit = hit + 1 ";
		sql += "where qno = " + qno;
		
		System.out.println("QnaDTO의 hit 메소드 : "+ sql);
		execute(sql);
		MyroomVO m = new MyroomVO();
		m.setHit(this.getInt("hit"));
		
		DBClose();
	}
	
	//qna 글보기
	public QnaVO view(String qno){	
		QnaVO qna = null;		
		try {				
			DBOpen();
			
			String sql ="";		
			sql  = "select qno,uno,title,body,name,date,hit, ncheck from qna ";
			sql += "where qno = " + qno;					
			this.openQuery(sql);			

			if(this.next() == false){
				this.DBClose();
				return null;
			}
			
			qna = new QnaVO();
				
			qna.setQno(this.getInt("qno"));
			qna.setUno(this.getInt("uno"));
			qna.setTitle(this.getValue("title"));
			qna.setBody(this.getValue("body"));
			qna.setName(this.getValue("name"));					
			qna.setDate(this.getValue("date"));
			qna.setHit(this.getInt("hit"));
			qna.setNcheck(this.getValue("ncheck"));
	
			System.out.println("QnaDTO의 view메소드... title? : " + qna.getTitle());
			System.out.println("QnaDTO의 view메소드... ncheck? : " + qna.getNcheck());
			
			closeQuery();
			DBClose();
			
			return qna;
			
		}catch(Exception e){
			e.printStackTrace();
			DBClose();
			return null;
		}		
	}
	
	//qna 글보기
	public QnaVO modi(String qno){	
		QnaVO qna = null;		
		try {				
			DBOpen();
			
			String sql ="";		
			sql  = "select qno,uno,title,body,name,date,hit, ncheck from qna ";
			sql += "where qno = " + qno;					
			this.openQuery(sql);			

			if(this.next() == false){
				this.DBClose();
				return null;
			}
			
			qna = new QnaVO();
				
			qna.setQno(this.getInt("qno"));
			qna.setUno(this.getInt("uno"));
			qna.setTitle(this.getValue("title"));
			qna.setBody(Utility._M(this.getValue("body")));
			qna.setName(this.getValue("name"));					
			qna.setDate(this.getValue("date"));
			qna.setHit(this.getInt("hit"));
			qna.setNcheck(this.getValue("ncheck"));
	
			System.out.println("QnaDTO의 view메소드... title? : " + qna.getTitle());
			System.out.println("QnaDTO의 view메소드... ncheck? : " + qna.getNcheck());
			
			closeQuery();
			DBClose();
			
			return qna;
			
		}catch(Exception e){
			e.printStackTrace();
			DBClose();
			return null;
		}		
	}
	
	//view페이지에서 하단에 이전글/다음글
	//다음글번호 select
	public QnaVO getNext(String qno) {	
		
		QnaVO qna = null;
		int iqno = Integer.parseInt(qno);
		
		this.DBOpen();
		
		
		String sql = "";
		sql  = "select * from qna ";
		sql += "where qno in ";
		sql +="(select min(qno) from qna where qno > " + iqno + ")";
		
		System.out.println("QnaDTO의 getNext 메소드 : " + sql);
				
		this.openQuery(sql);
		if(this.next() == false){
			this.DBClose();
			return null;
		}
		
		qna = new QnaVO();
			
		qna.setQno(this.getInt("qno"));
		qna.setUno(this.getInt("uno"));
		qna.setTitle(this.getValue("title"));
		qna.setBody(this.getValue("body"));
		qna.setName(this.getValue("name"));					
		qna.setDate(this.getValue("date"));
		qna.setHit(this.getInt("hit"));			
		
		System.out.println("QnaDTO의 getNext 메소드 ... title? : "+qna.getTitle());
		this.closeQuery();	
		this.DBClose();
		
		return qna;
	}	
	
	
	//view페이지에서 하단에 이전글/다음글
	//이전글번호 select
	public QnaVO getPrev(String qno) {	
		QnaVO qna = null;
		int iqno = Integer.parseInt(qno);
		
		this.DBOpen();
		
		String sql = "";
		sql  = "select * from qna ";
		sql += "where qno in ";
		sql += "(select max(qno) from qna where qno < " + iqno + ")";
		
		System.out.println("QnaDTO의 getPrev 메소드 : " + sql);
				
		this.openQuery(sql);
		if(this.next() == false){
			this.DBClose();
			return null;
		}
		
		qna = new QnaVO();
			
		qna.setQno(this.getInt("qno"));
		qna.setUno(this.getInt("uno"));
		qna.setTitle(this.getValue("title"));
		qna.setBody(this.getValue("body"));
		qna.setName(this.getValue("name"));					
		qna.setDate(this.getValue("date"));
		qna.setHit(this.getInt("hit"));			
		
		System.out.println("QnaDTO의 getPrev 메소드... 글 제목 : " + qna.getTitle());
		
		this.closeQuery();	
		this.DBClose();
		
		return qna;
	}
	
	
	
}
