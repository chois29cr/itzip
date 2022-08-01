package vo;

//질문답변
public class QnaVO {

	private int qno;
	private int uno;
	private String title;
	private String body;
	private String name;
	private String date;
	private int hit;
	private String file;	//프로필사진 불러오기용
	private String ncheck;
	
	public int getQno() {
		return qno;
	}
	public void setQno(int qno) {
		this.qno = qno;
	}

	public void setQno(String qno) {
		try	{
			this.qno = Integer.parseInt(qno);
		}catch(Exception e)	{
			this.qno = 0;
		}
	}
	
	public int getUno() {
		return uno;
	}
	public void setUno(int uno) {
		this.uno = uno;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDate() {
		String dateTime = date.substring(0, 10);
		return dateTime;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public String getNcheck() {
		return ncheck;
	}
	public void setNcheck(String ncheck) {
		this.ncheck = ncheck;
	}

	
	
	
	
}