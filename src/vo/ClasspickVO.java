package vo;

public class ClasspickVO {
	
	private int pno;			//찜번호
	private int uno;			//회원번호
	private int cno;			//게시물번호
	private String pickcheck; 	//찜여부
	
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
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
	public String setCno(int cno) {
		this.cno = cno;
		return pickcheck;
	}
	public String getPickcheck() {
		return pickcheck;
	}
	public void setPickcheck(String pickcheck) {
		this.pickcheck = pickcheck;
	}
}
