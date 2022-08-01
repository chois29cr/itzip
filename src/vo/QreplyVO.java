package vo;

//질문답변댓글
public class QreplyVO {

	private int qreno; 
	private int uno;
	private int qno;
	private String qre;
	private String qrename;
	private String qredate;
	private String file;
	
	public int getQreno() {
		return qreno;
	}
	public void setQreno(int qreno) {
		this.qreno = qreno;
	}
	public int getUno() {
		return uno;
	}
	public void setUno(int uno) {
		this.uno = uno;
	}
	public int getQno() {
		return qno;
	}
	public void setQno(int qno) {
		this.qno = qno;
	}
	public String getQre() {
		return qre;
	}
	public void setQre(String qre) {
		this.qre = qre;
	}
	public String getQrename() {
		return qrename;
	}
	public void setQrename(String qrename) {
		this.qrename = qrename;
	}
	public String getQredate() {
		//qredate = qredate.substring(0, 16);
		return qredate;
	}
	public void setQredate(String qredate) {
		this.qredate = qredate;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	
	
}
