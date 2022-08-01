package vo;

//내방첨부파일
public class MattachVO {

	private int mno;		//내방첨부파일 게시물번호
	private int uno;		//회원번호
	private int no;			//내방 게시물번호
	private String mattach;	//첨부파일 경로
	
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
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
	public String getMattach() {
		return mattach;
	}
	public void setMattach(String mattach) {
		this.mattach = mattach;
	}	
}
