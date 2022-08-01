package dto;

import dbms.DBManager;
import vo.*;

public class StudentDTO extends DBManager{
	
	private String sno;
	public String getCno(){ return sno; }
	
	//클래스 수강신청
	public void classing(StudentVO st){
		try{
			
			DBOpen();
	
			String sql = "";
			sql += "insert into student ";
			sql += "(uno, cno, name, phone, date, title, image, email) ";
			sql += "values ";
			sql += "('" ;
			sql += st.getUno() + "', '";
			sql += st.getCno() + "', '";
			sql += st.getName() + "', '";
			sql += st.getPhone() + "', ";
			sql += " now(), '";
			sql += st.getTitle() + "', '";
			sql += st.getImage() + "', '";
			sql += st.getEmail() + "'";
			sql += ") ";
	
			System.out.println("StudentDTO의 classing 메소드 : " + sql);
			execute(sql);
			sql = "select last_insert_id() as sno";
			this.openQuery(sql);
			
			if(this.next()==true){
				this.sno = this.getValue("sno");
			}
						
			closeQuery();
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();			
		}
	}
	
	//수강신청목록 		
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
	
	//수강여부	
	public StudentVO check(String cno, String uno){
		StudentVO s = null;
		
		try{
			
			DBOpen();
			String sql ="";
			
			sql  = "select sno from student ";
			sql += "where uno = " + uno + " and cno = " + cno;
			
			System.out.println(sql);
			this.openQuery(sql);			

			if(this.next() == false){
				this.DBClose();
				return null;
			}
			
			s = new StudentVO();
				
			s.setSno(this.getInt("sno"));
			
			closeQuery();
			DBClose();
			
			return s;
			
		}catch(Exception e) {
			e.printStackTrace();
			DBClose();
			return null;
		}
	}

}
