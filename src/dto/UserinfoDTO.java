package dto;

import dbms.DBManager;
import vo.UserinfoVO;


public class UserinfoDTO extends DBManager{

	private UserinfoVO user = null;
	public UserinfoVO getUser(){ return user; }
	
	public void deluser(int uno) {
			DBOpen();
			
			String sql = "";
			sql = "delete from userinfo where uno = " + uno ;
			
			this.execute(sql);
			this.DBClose();
	}
	
	

	//DB에서 email 있는지 검사 (중복검사 위한 메소드)
	public boolean idok(String email){
		try{
			
			DBOpen();			
		
			String sql = "";
			sql = "select email from userinfo where email='" + email + "' ";
			
			this.openQuery(sql);
			
			if(this.next() == true){
				this.DBClose();
				return false;  //중복이 있다.
			}else {
				this.DBClose();
				return true;   //중복이 없다.	
			}
			
		}catch(Exception e){
			e.printStackTrace();
			return false; //오류인 상태이다..
		}
	}
	

	//DB에서 name 있는지 검사 (중복검사 위한 메소드)
	public boolean nameok(String name){
		try{
			
			DBOpen();
			
			String sql = "";
			sql = "select name from userinfo where name='" + name + "' ";
			this.openQuery(sql);
			
			if(this.next() == true){
				this.DBClose();
				return false;  //중복이 있다.
			}else {
				this.DBClose();
				return true;  //중복이 없다.
			}
			
		}catch(Exception e){
			e.printStackTrace();
			return false;  //오류인 상태이다..
		}
	}
	
	//DB에서 phone 있는지 검사 (중복검사 위한 메소드)
	public boolean phoneok(String phone){
		try{
			
			DBOpen();			
		
			String sql = "";
			sql = "select phone from userinfo where phone='" + phone + "' ";
			
			this.openQuery(sql);
			
			if(this.next() == true){  //sql 결과가 있으면
				this.DBClose();
				return false;  //중복이 있으므로, false 
			}else {
				this.DBClose();
				return true;   //중복이 없다.	
			}
			
		}catch(Exception e){
			e.printStackTrace();
			return false; //오류인 상태이다..
		}
	}	
	
	
	
	
	//이메일 찾기 (입력한 핸드폰번호로 가입한 email 있는지 검사)
	public String findEmail(String phone){
		String email="";
		try{
			
			DBOpen();
			
			String sql = "";
			sql += "select email from userinfo where phone='" + phone + "' ";
			this.openQuery(sql);
			
			if(this.next() == true){
				
				email = this.getValue("email");
				
				this.DBClose();
				return email;  //입력한 핸드폰 번호로 가입한 내역이 있음
			}else {
				this.DBClose();
				return email;  //중복이 없다.
			}			
		}catch(Exception e){
			e.printStackTrace();
			return email;
		}
	}
	

	//임시비밀번호 발급 (입력한 이메일, 핸드폰 번호로 검사)
	public boolean findPW(String email, String phone){
		try{
			
			DBOpen();
			
			String sql = "";
			sql = "select email from userinfo where ";
			sql += "email = '" + email + "' and ";
			sql += "phone = '" + phone + "' ";
			this.openQuery(sql);
			
			if(this.next() == true){ //입력한 이메일, 핸드폰 번호로 가입한 내역이 있음
				this.DBClose();	
				return true;
			}else {
				this.DBClose();
				return false; 
			}			
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
	
	//발급받은 임시비밀번호로 DB 내용 변경한다
	public boolean setRandomPW(String email, String phone, String randomPW) {
		try {
			DBOpen();
			
			System.out.println(randomPW);
			
			String sql = "";
			sql += "update userinfo set pw = '" + randomPW +"' ";
			sql += "where email = '"+ email +"' and ";
			sql += "phone = '" + phone + "' ";
			
			System.out.println(sql);
			execute(sql);			
			this.DBClose();
			return true;

		}catch(Exception e){
			this.DBClose();
			e.printStackTrace();
			return false;
		}
	}
	
	
	//회원가입
	public boolean join(UserinfoVO user){
		try{
			
			DBOpen();
			
			String sql = "";
			sql +=  "insert into userinfo ";
			sql += "(name, email, pw, phone, texture, file) ";
			sql += "values ";
			sql += "('";
			sql += user.getName() + "', '";
			sql += user.getEmail() + "', ";
			sql += "md5('"+ user.getPw() +"'), '";
			sql += user.getPhone() + "', '";
			sql += user.getTexture() + "', '";
			sql += user.getFile();
			sql += "')";
				
			System.out.println("userinfoDTO join sql구문은... ? : " + sql);
			
			execute(sql);
			this.DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;		
	}
	
	
	//로그인
	public UserinfoVO login(String email, String pw){
		
		try{
			DBOpen();
			
			String sql = ""; 
			sql +=  "select * from userinfo where email ='"+ email + "' and pw= md5('"+ pw + "') ";
			this.openQuery(sql);
			
			//email, pw로 select했을 때 유저 정보가 없으면 null반환
			if(this.next() == false){
				this.DBClose();
				return null;
			}
			
			//유저 정보 있으면 userinfoVO 객체 생성
			user = new UserinfoVO();
			
			user.setUno(this.getInt("uno"));
			user.setName(this.getValue("name"));
			user.setEmail(this.getValue("email"));
			user.setPw(this.getValue("pw"));
			user.setPhone(this.getValue("phone"));
			user.setTexture(this.getValue("texture"));
			user.setFile(this.getValue("file"));
			user.setIsadmin(this.getValue("isadmin"));
			
			System.out.println("userinfoDTO login 메소드... email? : " + email);
			this.DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
		
		return user;			
	}
		
	
	//회원정보 수정
	public boolean update(UserinfoVO user){
		try{
			
			DBOpen();
			
			String sql = "";
			 
			sql += "update userinfo ";
			sql += "set name ='" + user.getName() + "', ";
			sql += "pw = md5('" + user.getPw() + "'), ";
			sql += "phone ='" + user.getPhone() + "', ";
			sql += "texture ='" + user.getTexture() + "', ";
			sql += "file ='" + user.getFile() + "' ";
			sql += "where uno = '" + user.getUno() + "'";
						
			execute(sql);
			System.out.print("UserinfoDTO update 메소드 : " + sql);
			
			this.DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;		
	}
	

	//********************************[TODO] 회원탈퇴
	public boolean remove(UserinfoVO vo){
		
		try{
			
			DBOpen();
			
			String sql = "";
			//sql += "SET foreign_key_checks = 0; ";
			
			sql += "delete from userinfo ";			
			sql += "where uno = '" + vo.getUno() + "' ;"; 
			//sql += " SET foreign_key_checks = 1;";
			System.out.println(sql);
			
			execute(sql);
			
			this.DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;		
	}

	//프로필
	public UserinfoVO profile(int uno){
		
		try{
			DBOpen();
			
			String sql = ""; 
			sql +=  "select * from userinfo where uno ='"+ uno + "' ";
			this.openQuery(sql);
			
			//uno로 select했을 때 유저 정보가 없으면 null반환
			if(this.next() == false){
				this.DBClose();
				return null;
			}

			//유저 정보 있으면 userinfoVO 객체 생성
			user = new UserinfoVO();
			
			user.setUno(this.getInt("uno"));
			user.setName(this.getValue("name"));
			user.setEmail(this.getValue("email"));
			user.setPw(this.getValue("pw"));
			user.setPhone(this.getValue("phone"));
			user.setTexture(this.getValue("texture"));
			user.setFile(this.getValue("file"));
			user.setIsadmin(this.getValue("isadmin"));

			System.out.println("userinfoDTO login 메소드... email? : " + uno);
			this.DBClose();
			
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
		
		return user;			
	}
	
	
	//uno no 를 이용하여 게시물 작성자 정보를 불러온다
	public String getProfile(String table, String where, int no) {
		
		DBOpen();
		
		String file = "";
		String sql = ""; 
		sql +=  "select file from userinfo where uno in (select uno from "+table+" where "+where+"="+no+")";
		
		
		System.out.println("userinfoDTO getProfile 메소드: "+sql);
		this.openQuery(sql);
				
		if(this.next() == true){
			
			file = this.getValue("file");			
			this.DBClose();			
		}
		return file;
	}
}	
		
