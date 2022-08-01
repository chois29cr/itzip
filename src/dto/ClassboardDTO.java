package dto;
import java.util.ArrayList;
import dbms.DBManager;
import vo.*;


public class ClassboardDTO extends DBManager{
	
	private String cno;
	public String getCno(){ return cno; }
	
	
	//클래스 글쓰기
	public void write(UserinfoVO user, ClassboardVO c){
		try{
			
			DBOpen();
	
			String sql = "";
			sql += "insert into classboard ";
			sql += "(uno, title, body, name, date, hit) ";
			sql += "values ";
			sql += "('" ;
			sql += user.getUno() + "', '";
			sql += c.getTitle() + "', '";
			sql += c.getBody() + "', '";			
			sql += user.getName() + "', now(), '";
			sql += c.getHit();
			sql += "') ";
	
			System.out.println("ClassboardDTO의 write 메소드 : " + sql);
			execute(sql);
			sql = "select last_insert_id() as cno";
			this.openQuery(sql);
			
			if(this.next()==true){
				this.cno = this.getValue("cno");
			}
						
			closeQuery();
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();			
		}
	}
	
	
	//클래스 피드백
	public void feed(ClassboardVO c){
		try{
			
			DBOpen();
	
			String sql = "";
			sql += "update classboard set feed= '" + c.getFeed() + "' ";
			sql += "where cno = " + c.getCno();

			execute(sql);
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();			
		}
	}
	
	//피드백여부	
	public ClassboardVO check(String cno, String uno){
		ClassboardVO cf = null;
		
		try{
			
			DBOpen();
			String sql ="";
			
			sql  = "select feed from classboard ";
			sql += "where uno = " + uno + " and cno = " + cno;

			this.openQuery(sql);			

			if(this.next() == false){
				this.DBClose();
				return null;
			}
			
			cf = new ClassboardVO();
				
			cf.setFeed(this.getValue("feed"));
			
			closeQuery();
			DBClose();
			
			return cf;
			
		}catch(Exception e) {
			e.printStackTrace();
			DBClose();
			return null;
		}
	}

	
	//글 수정
	public void modify(ClassboardVO c){
		try{	
			
			DBOpen();
			
			String sql = "";
			sql += "update classboard set title= '" + c.getTitle() + "', ";
			sql += "body ='" + c.getBody() + "' ";
			sql += "where cno = " + c.getCno();
			
			execute(sql);
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//글 삭제	
	public void delete(int cno){

		try{
			DBOpen();
			
			String sql = "";
			sql += "delete from classboard ";
			sql += "where cno = " + cno;
			
			execute(sql);
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();			
		}	
	}	
	
	//쿠키를 사용하여 조회수 무한 증가를 막는다. 
	public void hit(String cno) {
		DBOpen();
		
		String sql ="";
		sql  = "update classboard set hit = hit + 1 ";
		sql += "where cno = " + cno;
		
		System.out.println("classBoardDTO의 hit 메소드 : "+ sql);
		execute(sql);
		ClassboardVO c = new ClassboardVO();
		c.setHit(this.getInt("hit"));
		
		DBClose();
	}
	
	//글 보기 		
	public ClassboardVO view(String cno){
		System.out.println("ClassboardDTO의 view 메소드 ... cno?? : " + cno);
		ClassboardVO c = null;
		
		try{
			
			DBOpen();
			
			String sql ="";
			
			sql  = "select * from classboard ";
			sql += "where cno = " + cno;
					
			this.openQuery(sql);			

			if(this.next() == false){
				this.DBClose();
				return null;
			}
			
			c = new ClassboardVO();
				
			c.setUno(this.getInt("uno"));
			c.setTitle(this.getValue("title"));
			c.setBody(this.getValue("body"));
			c.setName(this.getValue("name"));					
			c.setDate(this.getValue("date"));
			c.setHit(this.getInt("hit"));
			c.setFeed(this.getValue("feed"));

			System.out.print("ClassboardDTO의 view 메소드... title? : " + c.getTitle());
			System.out.print("uno? : " + c.getUno());
			
			closeQuery();
			DBClose();
			
			return c;
			
		}catch(Exception e) {
			e.printStackTrace();
			DBClose();
			return null;
		}
	}
	
	//view페이지에서 하단에 이전글/다음글
		//다음글번호 select
		public ClassboardVO getNext(String cno)	{	
			
			ClassboardVO c = null;
			
			this.DBOpen();
			
			String sql = "";
			sql  = "select * from classboard ";
			sql += "where cno in ";
			sql += "(select min(cno) from classboard where cno > " + cno + ")";

			
			this.openQuery(sql);
			if(this.next() == false) {
				this.DBClose();
				return null;
			}
			
			c = new ClassboardVO();
			
			c.setCno(this.getInt("cno"));
			c.setUno(this.getInt("uno"));
			c.setTitle(this.getValue("title"));
			c.setBody(this.getValue("body"));
			c.setName(this.getValue("name"));					
			c.setDate(this.getValue("date"));
			c.setHit(this.getInt("hit"));			

			this.closeQuery();	
			this.DBClose();
			
			return c;
		}	
		
		//view페이지에서 하단에 이전글/다음글
		//이전글번호 select
		public ClassboardVO getPrev(String cno) {
			
			ClassboardVO c = null;
			
			this.DBOpen();
			
			String sql = "";
			sql  = "select * from classboard ";
			sql += "where cno in ";
			sql += "(select max(cno) from classboard where cno < " + cno + ")";
			
					
			this.openQuery(sql);
			if(this.next() == false){
				this.DBClose();
				return null;
			}
			
			c = new ClassboardVO();
				
			c.setCno(this.getInt("cno"));
			c.setUno(this.getInt("uno"));
			c.setTitle(this.getValue("title"));
			c.setBody(this.getValue("body"));
			c.setName(this.getValue("name"));					
			c.setDate(this.getValue("date"));
			c.setHit(this.getInt("hit"));			
			
			System.out.println("ClassboardDTO의 getPrev메소드... title? : " + c.getTitle());
			this.closeQuery();	
			this.DBClose();
			return c;
		}	
	
}