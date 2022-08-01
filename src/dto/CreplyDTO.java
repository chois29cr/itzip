package dto;
import dbms.DBManager;
import vo.*;
import java.util.ArrayList;

public class CreplyDTO extends DBManager{
	
	private int total; //게시물 별 댓글 개수
	public int getTotal() {	return total; }
	private String creno;
	public String getCreno() { return creno; }

	//classboard 댓글 쓰기
	public boolean write(UserinfoVO user, CreplyVO cr){
		
		try{	
			DBOpen();
			
			String sql = ""; 
			sql += "insert into creply ";
			sql += "(uno, cno, cre, crename, credate) "; 
			sql += "values ";
			sql += "('";
			sql += user.getUno() + "', '";
			sql += cr.getCno() + "', '";
			sql +=  cr.getCre() + "', '";
			sql += cr.getCrename() + "', now()) ";
			
			System.out.println("CreplyDTO의 write메소드 : " + sql);
			execute(sql);
			
			sql = "select last_insert_id() as creno";
			this.openQuery(sql);
			
			if(this.next()==true){
				this.creno = this.getValue("creno");
			}
			
			sql = "select credate from creply where creno="+creno;
			this.openQuery(sql);
			
			if(this.next()==true){
				cr.setCredate(this.getValue("credate"));
			}
			System.out.println("class댓글 write date: "+ sql);
			
			this.DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	//classboard 후기 수정
	public boolean modify(UserinfoVO user, CreplyVO cr) {

		try {
			DBOpen();
			
			String sql = "";
			sql += "update creply ";
			sql += "set cre = '" + cr.getCre()+ "' ";						
			sql += "where creno = " + cr.getCreno();						
			
			System.out.println("CreplyDTO의 modify 메소드 : " + sql);
			execute(sql);
			
			this.DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;		
	}
	
	//classboard 댓글 삭제
	public boolean delete(UserinfoVO user, CreplyVO cr){
		
		try{
			DBOpen();
			
			String sql = ""; 
			sql += "delete from creply ";			
			sql += "where creno = " + cr.getCreno();
			
			System.out.println("CreplyDTO의 delete 메소드 : " + sql);
			execute(sql);
			 
			this.DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;		
	}
	
	//classboard 게시물번호 cno로 creply의 모든 댓글 갯수 조회 
	public int getRcount(String cno) {	
		
		this.DBOpen();
		
		String sql = "";
		sql = "select count(*) as total ";
		sql += "from creply where cno = " + cno ;
		
		System.out.println("CreplyDTO의 getRcount 메소드 : " + sql);
				
		this.openQuery(sql);
		this.next();
		
		total = this.getInt("total");
		
		this.closeQuery();	
		this.DBClose();
		
		return total;
	}
	
}
