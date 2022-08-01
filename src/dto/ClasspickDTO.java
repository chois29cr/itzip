package dto;

import java.util.ArrayList;

import dbms.DBManager;
import vo.ClasspickVO;
import vo.ClassboardVO;
import vo.UserinfoVO;

public class ClasspickDTO extends DBManager{
	private String pno;

	public String getPno(){ return pno; }

	//if(별상태.equals(null)) 찜(처음)눌렀을 때 찜여부 'Y'로 인서트
	public void write(UserinfoVO user, String cno){
		try{
			
			DBOpen();
	
			String sql = "";
			sql += "insert into classpick ";
			sql += "(uno, cno, pickcheck) ";
			sql += "values ";
			sql += "('";
			sql += user.getUno() + "', '";
			sql += cno + "', 'Y')";
	
			System.out.println("ClasspickDTO의 write 메소드 : " + sql);
			execute(sql);
			
			this.pno = this.getLastID("pno");
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();			
		}
	}
	
	//해당 글의 나의 좋아요 상태 확인
	public String pickcheck(UserinfoVO user, String cno){
		String pickcheck = null; 
		
		try{		
			
			DBOpen();
	
			String sql = "";
			sql += "select pickcheck from classpick ";
			sql += "where uno=" +user.getUno();
			sql += " and cno=" +cno;
	
			
			this.openQuery(sql);			

			if(this.next()==true){
				pickcheck = this.getValue("pickcheck");				
			}
			
			System.out.println("ClasspickDTO의 pickcheck 메소드 : " + sql);
			System.out.println("Pickcheck 확인:" +pickcheck);
					
			closeQuery();
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();			
		}
		return pickcheck;
	}
	
	//if(하트상태.equals("Y")) 좋아요여부 'N'으로 업데이트
	public void delete(UserinfoVO user, String cno){

		try{
			DBOpen();
			
			String sql = "";
			sql += "update classpick ";
			sql += "set pickcheck= 'N' ";
			sql += "where cno = " + cno;
			sql += " and uno =" + user.getUno();
			
			System.out.println("ClasspickDTO의 delete메소드 : " + sql);
			
			execute(sql);
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();			
		}	
	}		
	
	//if(하트상태.equals("N")) 좋아요여부 'Y'로 업데이트
	public void modify(UserinfoVO user, String cno){
		
		try{	
			
			DBOpen();
			
			String sql = "";
			sql += "update classpick ";
			sql += "set pickcheck= 'Y' ";
			sql += "where cno = " + cno;
			sql += " and uno =" + user.getUno();
			
			System.out.println("ClasspickDTO의 modify메소드 : " + sql);
			
			execute(sql);
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public int getTotal(String cno){
		
		int total=0;
		
		try{	
			
			DBOpen();
						
			String sql = "";
			sql = "select count(*) as total ";
			sql += "from classpick ";
			sql +=  "where cno = " + cno;
			sql += " and pickcheck='Y' ";
					
			
			System.out.println("ClasspickDTO의 getTotal메소드 : " + sql);
			
			this.openQuery(sql);			

			if(this.next()==true){
				total = this.getInt("total");
			}
					
			closeQuery();
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return total;
		
	}
	
	/*listDAO로 넘김
	public ArrayList<ClassboardVO> list(int uno){
	System.out.println("ClasspickDTO의 list 메소드 ... uno?? : " + uno);
	ArrayList<ClassboardVO> clist = new ArrayList<ClassboardVO>();
	try{
		
		DBOpen();
		
		String sql ="";
		sql  = "select cno,title,name from classboard where cno in (select cno from classpick where uno="+uno+" and pickcheck='Y')";
		System.out.println("ClasspickDTO의 list메소드 : " + sql);
		this.openQuery(sql);			

		
		while(this.next() == true){
		ClassboardVO p = new ClassboardVO();
				
		p.setCno(this.getInt("cno"));	
		p.setTitle(this.getValue("title"));	
		p.setName(this.getValue("name"));	
		System.out.println("ClasspickDTO의 cno : " + p.getCno());
		System.out.println("ClasspickDTO의 name : " + p.getName());
		System.out.println("ClasspickDTO의 title : " + p.getTitle());

		
		clist.add(p);	
		}
		closeQuery();
		DBClose();
		
		return clist;
		
	}catch(Exception e) {
		e.printStackTrace();
		DBClose();
		return null;
		}
	}
	*/
	
	//[todo: 사용여부 확인할 것 ]찜목록의 cno를 가져온다.????? 
	public ClasspickVO listcno(int uno){
		System.out.println("ClasspickDTO의 view 메소드 ... uno?? : " + uno);
		try{
			
			DBOpen();
			
			String sql ="";
			sql  = "select cno from classpick where uno="+uno+" and pickcheck='Y'";
			System.out.println("ClasspickDTO의 list메소드 : " + sql);
			this.openQuery(sql);			

			if(this.next() == false){
				this.DBClose();
				return null;
			}
			ClasspickVO cp = new ClasspickVO();

				
			cp.setCno(this.getInt("cno"));	

			closeQuery();
			DBClose();
			
			return cp;
			
		}catch(Exception e) {
			e.printStackTrace();
			DBClose();
			return null;
			}
		}
	
}
