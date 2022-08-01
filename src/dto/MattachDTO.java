package dto;

import dbms.DBManager;
import vo.MattachVO;
import vo.UserinfoVO;

public class MattachDTO extends DBManager {
	
	//myroom 사진, 글 쓰기
	public void write(UserinfoVO user, MattachVO ma) {
		
		try{
			
			DBOpen();
			 
			String sql = "";
			 
			sql +=  "insert into mattach ";
			sql += "(uno, no, mattach) "; 
			sql += "values ";
			sql += "('";
			sql += user.getUno() + "', '";
			sql += ma.getNo() + "', '";
			sql += ma.getMattach() + "') ";
			
			System.out.println("MattachDTO write 메소드 : " + sql);
			execute(sql);
			
			this.DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//myroom 사진, 글 수정
	public void modify(UserinfoVO user, MattachVO ma) {

		try {
			
			DBOpen();
			
			String sql = "";
			sql += "update mattach ";
			sql += "set mattach ='" + ma.getMattach() + "' ";
			sql += "where no = " + ma.getNo();						
			
			System.out.println("MattachDTO modify 메소드 : " + sql);
			
			execute(sql);		
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
		}		
	}
	
	//myroom 사진, 글 삭제
	public void delete(UserinfoVO user, MattachVO ma){
		
		try{
			
			DBOpen();
			
			String sql = "";
			 
			sql += "delete from mattach ";			
			sql += "where mno = " + ma.getMno();
			
			System.out.println("MattachDTO delete 메소드: " + sql);
			execute(sql);
			 
			this.DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
		}		
	}

}