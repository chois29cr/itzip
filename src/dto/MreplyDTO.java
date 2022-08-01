package dto;
import dbms.DBManager;
import vo.*;
import utility.*;
import java.util.ArrayList;

public class MreplyDTO extends DBManager {
	
	private int total; //게시물 별 댓글 개수
	public int getTotal() {	return total; }
	private String mreno; 
	
	public String getMreno(){ return mreno; }


	//myroom 댓글 쓰기
	public boolean write(UserinfoVO user, MreplyVO mr){
		
		try{	
			DBOpen();
			
			String sql = ""; 
			sql += "insert into mreply ";
			sql += "(uno, no, mre, mrename, mredate) "; 
			sql += "values ";
			sql += "('";
			sql += user.getUno() + "', '";
			sql += mr.getNo() + "', '";
			sql += Utility._R(mr.getMre()) + "', '";
			sql += mr.getMrename() + "', now()) ";
			
			System.out.println("MreplyDTO의 write메소드 : " + sql);
			execute(sql);
			
			sql = "select last_insert_id() as mreno";
			this.openQuery(sql);
			
			if(this.next()==true){
				this.mreno = this.getValue("mreno");
			}
			
			sql = "select mredate from mreply where mreno="+mreno;
			this.openQuery(sql);
			
			if(this.next()==true){
				mr.setMredate(this.getValue("mredate"));
			}
			System.out.println("댓글 write date: "+ sql);
			
			closeQuery();
			this.DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	//myroom 댓글 수정
	public boolean modify(UserinfoVO user, MreplyVO mr) {

		try {
			DBOpen();
			
			String sql = "";
			sql += "update mreply ";
			sql += "set mre = '" + Utility._R(mr.getMre()) + "' ";						
			sql += "where mreno = " + mr.getMreno();						
			
			System.out.println("MreplyDTO의 modify 메소드 : " + sql);
			execute(sql);
			
			this.DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;		
	}
	
	//myroom 댓글 삭제
	public boolean delete(UserinfoVO user, MreplyVO mr){
		
		try{
			DBOpen();
			
			String sql = ""; 
			sql += "delete from mreply ";			
			sql += "where mreno = " + mr.getMreno();
			
			System.out.println("MreplyDTO의 delete 메소드 : " + sql);
			execute(sql);
			 
			this.DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;		
	}
	
	//myroom 게시물번호 no로 mreply의 모든 댓글 갯수 조회 
	public int getRcount(int no) {	
		
		this.DBOpen();
		
		String sql = "";
		sql = "select count(*) as total ";
		sql += "from mreply where no = " + no ;
		
		System.out.println("MreplyDTO의 getRcount 메소드 : " + sql);
				
		this.openQuery(sql);
		this.next();
		
		total = this.getInt("total");
		
		this.closeQuery();	
		this.DBClose();
		
		return total;
	}

	
}
