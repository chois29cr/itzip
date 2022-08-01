package dto;

import java.util.ArrayList;
import dbms.DBManager;
import vo.MattachVO;
import vo.MyroomVO;
import vo.UserinfoVO;
import utility.*;

public class MyroomDTO extends DBManager{
	
	private String no;
	public String getNo(){ return no; }
	
	
	//myroom 글쓰기
	public void write(UserinfoVO user, MyroomVO m){
		try{
			
			DBOpen();
	
			String sql = "";
			sql += "insert into myroom ";
			sql += "(uno, title, body, name, date, hit) ";
			sql += "values ";
			sql += "('";
			sql += user.getUno() + "', '";
			sql += Utility._R(m.getTitle()) + "', '";
			sql += m.getBody() + "', '";
			sql += m.getName()	+ "', now(), '";
			sql += m.getHit();
			sql += "') ";
	
			System.out.println("MyroomDTO의 write 메소드 : " + sql);
			execute(sql);
			sql = "select last_insert_id() as no";
			this.openQuery(sql);			

			if(this.next()==true){
				this.no = this.getValue("no");
			}
					
			closeQuery();
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();			
		}
	}
	
	//myroom title,body 수정 (첨부파일 MattachVO에서 불러옴)
	public void modify(UserinfoVO user, MyroomVO m){
		try{	
			
			DBOpen();
			
			String sql = "";
			sql += "update myroom ";
			sql += "set title= '" + Utility._R(m.getTitle()) + "' ";
			sql += ", body= '" + m.getBody() + "' ";
			sql += "where no = " + m.getNo();
			
			System.out.println("MyroomDTO의 modify메소드 : " + sql);
			
			execute(sql);
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	//myroom 글삭제
	public void delete(String no){

		try{
			DBOpen();
			
			String sql = "";
			sql += "delete from myroom ";
			sql += "where no = " + no;
			
			execute(sql);
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();			
		}	
	}		
	
	//쿠키를 사용하여 조회수 무한 증가를 막는다. 
	public void hit(String no) {
		DBOpen();
		
		String sql ="";
		sql  = "update myroom set hit = hit + 1 ";
		sql += "where no = " + no;
		
		System.out.println("MyroomDTO의 hit 메소드 : "+ sql);
		execute(sql);
		MyroomVO m = new MyroomVO();
		m.setHit(this.getInt("hit"));
		
		DBClose();
	}
	
	//myroom 글보기
	public MyroomVO view(String no){
		
		MyroomVO m = null;
		
		try{
			
			DBOpen();
			
			String sql ="";
			/*
			sql  = "update myroom set hit = hit + 1 ";
			sql += "where no = " + no;
			
			System.out.println("MyroomDTO의 view 메소드 : "+ sql);
			execute(sql);
			*/
			sql  = "select uno, title, body, name, date, hit from myroom ";
			sql += "where no = " + no;
					
			this.openQuery(sql);			

			if(this.next() == false){
				this.DBClose();
				return null;
			}
			
			m = new MyroomVO();
				
			m.setUno(this.getInt("uno"));
			m.setTitle(this.getValue("title"));
			m.setBody(this.getValue("body"));
			m.setName(this.getValue("name"));					
			m.setDate(this.getValue("date"));
			m.setHit(this.getInt("hit"));						
			
			System.out.println("MyroomDTO의 view 메소드 ... title? : " + m.getTitle());
			System.out.println("MyroomDTO의 view 메소드 ... uno? : " + m.getUno());
			closeQuery();
			DBClose();
			
			return m;
			
		}catch(Exception e) {
			e.printStackTrace();
			DBClose();
			return null;
		}	
	}
	
	//view페이지에서 하단에 이전글/다음글
	//다음글번호 select
	public MyroomVO getNext(int no)	{	
		
		MyroomVO m = null;
		
		this.DBOpen();
		
		String sql = "";
		sql  = "select no, uno, title, name, date, hit from myroom ";
		sql += "where no in ";
		sql += "(select min(no) from myroom where no > " + no + ")";
		
		//System.out.println("MyroomDTO의 getNext 메소드 : " + sql);
		
		this.openQuery(sql);
		if(this.next() == false) {
			this.DBClose();
			return null;
		}
		
		m = new MyroomVO();
		
		m.setNo(this.getInt("no"));
		m.setUno(this.getInt("uno"));
		m.setTitle(this.getValue("title"));
		m.setName(this.getValue("name"));					
		m.setDate(this.getValue("date"));
		m.setHit(this.getInt("hit"));			
		
		//System.out.println("MyroomDTO의 getNext 메소드 ... title? : " + m.getTitle());
		this.closeQuery();	
		this.DBClose();
		
		return m;
	}	
	
	//view페이지에서 하단에 이전글/다음글
	//이전글번호 select
	public MyroomVO getPrev(int no) {
		
		MyroomVO m = null;
		
		this.DBOpen();
		
		String sql = "";
		sql  = "select no, uno, title, name, date, hit from myroom ";
		sql += "where no in ";
		sql += "(select max(no) from myroom where no < " + no + ")";
		
		//System.out.println("MyroomDTO의 getPrev 메소드 : " + sql);
				
		this.openQuery(sql);
		if(this.next() == false){
			this.DBClose();
			return null;
		}
		
		m = new MyroomVO();
			
		m.setNo(this.getInt("no"));
		m.setUno(this.getInt("uno"));
		m.setTitle(this.getValue("title"));
		m.setName(this.getValue("name"));					
		m.setDate(this.getValue("date"));
		m.setHit(this.getInt("hit"));			
		
		System.out.println("MyroomDTO의 getPrev메소드... title? : " + m.getTitle());
		this.closeQuery();	
		this.DBClose();
		return m;
	}	

}