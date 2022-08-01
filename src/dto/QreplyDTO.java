package dto;
import dbms.DBManager;
import vo.*;
import utility.*;
import java.util.ArrayList;

public class QreplyDTO extends DBManager{
	
	private int total; //게시물 별 댓글 개수
	public int getTotal() { return total; }
	
	private String qreno; 
	
	public String getQreno(){ return qreno; }
	
	//qna 댓글 쓰기
	public boolean write(UserinfoVO user, QreplyVO qr){
		
		try{
			DBOpen();
			
			String sql = ""; 
			sql +=  "insert into qreply ";
			sql += "(uno, qno, qre, qrename, qredate) "; 
			sql += "values ";
			sql += "('";
			sql += user.getUno() + "', '";
			sql += qr.getQno() + "', '";
			sql	+= Utility._R(qr.getQre()) + "', '";
			sql += qr.getQrename() + "', now()) ";
			
			System.out.println("QreplyDTO의 write 메소드 : " +sql);
			execute(sql);
			
			sql = "select last_insert_id() as qreno";
			this.openQuery(sql);
			
			if(this.next()==true){
				this.qreno = this.getValue("qreno");
			}
			
			sql = "select qredate from qreply where qreno="+qreno;
			this.openQuery(sql);
			
			if(this.next()==true){
				qr.setQredate(this.getValue("qredate"));
			}
			System.out.println("q댓글 write date: "+ sql);
			
			closeQuery();
			
			
			this.DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	
	//qna 댓글 수정
	public boolean modify(UserinfoVO user, QreplyVO qr) {

		try {		
			DBOpen();
			
			String sql = "";
			sql += "update qreply ";
			sql += "set qre ='" + Utility._R(qr.getQre()) + "' ";						
			sql += "where qreno = " + qr.getQreno();						
			
			System.out.println("QreplyDTO의 modify 메소드 : " + sql);
			execute(sql);
			 		
			this.DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;		
	}
	
	
	//qna 댓글 삭제
	public boolean delete(UserinfoVO user, QreplyVO qr) {
		
		try{	
			DBOpen();
			
			String sql = "";		 
			sql += "delete from qreply ";			
			sql += "where qreno = " + qr.getQreno();
			
			System.out.println("QreplyDTO의 delete 메소드 : " + sql);
			execute(sql);
			 
			this.DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;		
	}
	
	//qno 게시물번호 qno로 qreply의 모든 댓글 갯수 조회 
	public int getRcount(int qno) {	
		
		this.DBOpen();
		
		String sql = "";
		sql = "select count(*) as total ";
		sql += "from qreply where qno = " + qno ;
		
		System.out.println("QreplyDTO의 getRcount 메소드 : " + sql);
				
		this.openQuery(sql);
		this.next();
		
		total = this.getInt("total");
		
		this.closeQuery();	
		this.DBClose();
		
		return total;
	}	

	
}
