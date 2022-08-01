package dto;

import dbms.DBManager;
import vo.MrelikeVO;
import vo.MyroomVO;
import vo.UserinfoVO;

public class MrelikeDTO extends DBManager{
	private String lno;

	public String getLno(){ return lno; }

	//if(하트상태.equals(null)) 좋아요(처음)눌렀을 때 좋아요여부 'Y'로 인서트
	public void write(UserinfoVO user, String no){
		try{
			
			DBOpen();
	
			String sql = "";
			sql += "insert into mrelike ";
			sql += "(uno, no, likecheck) ";
			sql += "values ";
			sql += "('";
			sql += user.getUno() + "', '";
			sql += no + "', 'Y')";
	
			System.out.println("MrelikeDTO의 write 메소드 : " + sql);
			execute(sql);
			
			this.lno = this.getLastID("lno");
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();			
		}
	}
	
	//해당 글의 나의 좋아요 상태 확인
	public String likecheck(UserinfoVO user, String no){
		String likecheck = null; 
		
		try{		
			
			DBOpen();
	
			String sql = "";
			sql += "select likecheck from mrelike ";
			sql += "where uno=" +user.getUno();
			sql += " and no=" +no;
	
			
			this.openQuery(sql);			

			if(this.next()==true){
				likecheck = this.getValue("likecheck");				
			}
			
			System.out.println("MrelikeDTO의 likecheck 메소드 : " + sql);
			System.out.println("likecheck 확인:" +likecheck);
					
			closeQuery();
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();			
		}
		return likecheck;
	}
	
	//if(하트상태.equals("Y")) 좋아요여부 'N'으로 업데이트
	public void delete(UserinfoVO user, String no){

		try{
			DBOpen();
			
			String sql = "";
			sql += "update mrelike ";
			sql += "set likecheck= 'N' ";
			sql += "where no = " + no;
			sql += " and uno =" + user.getUno();
			
			System.out.println("MrelikeDTO의 delete메소드 : " + sql);
			
			execute(sql);
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();			
		}	
	}		
	
	//if(하트상태.equals("N")) 좋아요여부 'Y'로 업데이트
	public void modify(UserinfoVO user, String no){
		try{	
			
			DBOpen();
			
			String sql = "";
			sql += "update mrelike ";
			sql += "set likecheck= 'Y' ";
			sql += "where no = " + no;
			sql += " and uno =" + user.getUno();
			
			System.out.println("MrelikeDTO의 modify메소드 : " + sql);
			
			execute(sql);
			DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public int getTotal(int no) {
		
		int total=0;
		
		try{	
			
			DBOpen();
						
			String sql = "";
			sql = "select count(*) as total ";
			sql += "from mrelike ";
			sql +=  "where no = " + no;
			sql += " and likecheck='Y' ";
					
			
			System.out.println("MrelikeDTO의 getTotal메소드 : " + sql);
			
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
	
}
