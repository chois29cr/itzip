package vo;

//내방댓글
public class CreplyVO {

	private int creno;
	private int uno;
	private int cno;
	private String cre;
	private String crename;
	private String credate;
	private String file;	//댓글 프로필사진 불러오기 용
	
	
	
	public int getCreno() {
		return creno;
	}
	public void setCreno(int creno) {
		this.creno = creno;
	}
	public int getUno() {
		return uno;
	}
	public void setUno(int uno) {
		this.uno = uno;
	}
	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
	public String getCre() {
		return cre;
	}
	public void setCre(String cre) {
		this.cre = cre;
	}
	public String getCrename() {
		return crename;
	}
	public void setCrename(String crename) {
		this.crename = crename;
	}
	public String getCredate() {
		//credate = credate.substring(0, 16);
		return credate;
	}
	public void setCredate(String credate) {
		this.credate = credate;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	

	
}
