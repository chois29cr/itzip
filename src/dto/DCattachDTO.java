package dto;

import java.util.ArrayList;

import dbms.DBManager;
import vo.DCattachVO;
import vo.MattachVO;
import vo.UserinfoVO;

public class DCattachDTO extends DBManager {
	
	//classboard 사진 첨부
	public void write(UserinfoVO user, DCattachVO ca) {
		try{
			DBOpen();
			 
			String sql = "";
			sql +=  "insert into dcattach ";
			sql += "(uno, cno, dcattach) "; 
			sql += "values ";
			sql += "('";
			sql += user.getUno() + "', '";
			sql += ca.getCno() + "', '";
			sql += ca.getDcattach() + "') ";
			
			System.out.println("DCattachDTO write 메소드 : " + sql);
			execute(sql);
			
			this.DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	

	//classboard 사진 수정
	public void modify(DCattachVO ma) {
		try {	
			DBOpen();
			
			String sql = "";
			sql += "update dcattach ";
			sql += "set dcattach ='" + ma.getDcattach() + "' ";
			sql += "where cno = " + ma.getCno();						
			
			System.out.println("DCattachDTO modify 메소드 : " + sql);
			
			execute(sql);		
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
		}		
	}
	
	//classboard 사진 삭제
	public void delete(UserinfoVO user, DCattachVO ma){	
		try{	
			DBOpen();
			
			String sql = "";
			sql += "delete from dcattach ";			
			sql += "where cno = " + ma.getCno();
			
			System.out.println("DCattachDTO delete 메소드: " + sql);
			execute(sql);
			 
			this.DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
		}		
	}
	
	//dcattach 대표 이미지를 가져온다.
	public DCattachVO dImage(int cno){
		
		DCattachVO dImage = new DCattachVO();
		
		try {
			
			DBOpen();	
			
			String sql="";
			sql += "select cno, dcattach from dcattach ";
			sql += "where cno= " + cno ;
	
			System.out.println("ListDTO maList 메소드 : " + sql);
			
			this.openQuery(sql);
			
			while(this.next() == true){
				
				dImage.setCno(this.getInt("cno"));
				dImage.setDcno(this.getInt("dcno"));
				dImage.setDcattach(this.getValue("dcattach"));					
										
			}
			this.closeQuery();	
			this.DBClose();	
			
		}catch(Exception e) {
			e.printStackTrace();
			return dImage;
		}
		return dImage;
	}


}