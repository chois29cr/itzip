package vo;

public class MrelikeVO {
	
	private int lno;			//좋아요번호
	private int uno;			//회원번호
	private int no;				//게시물번호
	private String likecheck; 	//좋아요여부
	
	
	public int getLno() {
		return lno;
	}
	public void setLno(int lno) {
		this.lno = lno;
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
	public String getLikecheck() {
		return likecheck;
	}
	public void setLikecheck(String likecheck) {
		this.likecheck = likecheck;
	}
	
	

}
