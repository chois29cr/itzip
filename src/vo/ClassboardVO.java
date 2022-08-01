package vo;

//일일클래스
public class ClassboardVO {
	
	private int cno;
	private int uno;
	private String title;
	private String body;
	private String name;
	private String date;
	private int hit;
	private String type;	//관리자페이지용 타입(테이블이름 불러오기용)
	private String feed;
	
	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
	public int getUno() {
		return uno;
	}
	public void setUno(int uno) {
		this.uno = uno;
	}
	public void setUno(String uno) {
		try	{
			this.uno = Integer.parseInt(uno);
		}catch(Exception e)	{
			this.uno = 0;
		}
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
	public void setHit(String hit) {
		try	{
			this.hit = Integer.parseInt(hit);
		}catch(Exception e)	{
			this.cno = 0;
		}
	}	
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getFeed() {
		return feed;
	}
	public void setFeed(String feed) {
		this.feed = feed;
	}	
	
}
