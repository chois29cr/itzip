package dbms;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import vo.UserinfoVO;

public class DBManager extends DBProperties {
	
	public Connection mConnection;
	public ResultSet  mResult;

	
	public void DBOpen(){
		
		try{
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			String constring = "jdbc:mysql://" + getHost() + "/" + getDbname()
							+ "?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
			
			mConnection = DriverManager.getConnection(constring, getId(), getPw());
			//System.out.println("DBManager db오픈 주소 : " + constring);
			
		}catch(Exception e){
			e.printStackTrace();
		}	
	}

	
	public void DBClose(){
		try{			
			mConnection.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void execute(String sql){
		try{
			Statement stmt = null;
			stmt = mConnection.createStatement();
			stmt.executeUpdate(sql);
			stmt.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public boolean openQuery(String sql){
		try{
			Statement stmt = mConnection.createStatement();
			mResult = stmt.executeQuery(sql);
			return true;			
		}catch(Exception e){
			return false;
		}	
	}
	
	public void closeQuery(){
		try{		
			mResult.close();
		}catch(Exception e){
		}
	}
	
	public boolean next(){
		try{		
			return mResult.next();
		}catch(Exception e){
			return false;
		}
	}
	
	public String getValue(String obj){
		try{					
			return mResult.getString(obj);
		}catch(Exception e){
			System.out.println("[debug] DBmanager getValue");
			return null;
		}
	}
	
	public int getInt(String obj){
		try{
			return mResult.getInt(obj);
		}catch(Exception e){
			System.out.println("[debug]: DBManager getint");
			return 0;
		}
	}	
	
	public int GetCount(String Table,String where)
	{
		int total = 0;
		
		
		try{	
			
			DBOpen();
						
			String sql = "";
			sql = "select count(*) as total ";
			sql += "from " + Table + " ";
			if(!where.equals(""))
				sql += "where " + where;
			
			System.out.println("DBManager의 GetCount 메소드 : " + sql);
			
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
	
	

	
	
	public String getLastID(String pk) {
		
		String sql="";
		String lastno="";
				
		sql = "select last_insert_id() as " +pk;
		
		System.out.println("DBManager의 getLastID 메소드 : " + sql);
		this.openQuery(sql);
		
		if(this.next()==true){
			lastno = this.getValue(pk);
		}			
		closeQuery();
		return lastno;
	}
}
