package vo;

//내방댓글
public class MreplyVO {

	private int mreno;			//댓글번호
	private int uno;			//회원번호
	private int no;				//게시물번호
	private String mre;			//댓글내용
	private String mrename;		//댓글작성자
	private String mredate;		//댓글작성일
	private String file;		//프로필사진 댓글작성자별
	
	public int getMreno() {
		return mreno;
	}
	public void setMreno(int mreno) {
		this.mreno = mreno;
	}
	public int getUno() {
		return uno;
	}
	public void setUno(int uno) {
		this.uno = uno;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getMre() {
		return mre;
	}
	public void setMre(String mre) {
		this.mre = mre;
	}
	public String getMrename() {
		return mrename;
	}
	public void setMrename(String mrename) {
		this.mrename = mrename;
	}
	public String getMredate() {
		//mredate = mredate.substring(0, 16);
		return mredate;
	}
	public void setMredate(String mredate) {
		this.mredate = mredate;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	
	
	
}
