package vo;

//회원정보
public class UserinfoVO {
	
	private int uno;
	private String name;
	private String email;
	private String pw;
	private String phone;
	private String texture;
	private String file;
	private String isadmin;
	private String type;		//관리자페이지용 타입(테이블이름 불러오기용)
	
	public int getUno() {
		return uno;
	}
	public void getUno(String uno) {
		try	{
			this.uno = Integer.parseInt(uno);
		}catch(Exception e)	{
			this.uno = 0;
		}
	}
	public void setUno(int uno) {
		this.uno = uno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getTexture() {
		return texture;
	}
	public void setTexture(String texture) {
		this.texture = texture;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public String getIsadmin() {
		return isadmin;
	}
	public void setIsadmin(String isadmin) {
		this.isadmin = isadmin;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}	
}
