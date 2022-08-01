package vo;

//내방
public class MyroomVO {

	private int no;
	private int uno;
	private String title;
	private String body;
	private String name;
	private String date;
	private int hit;
	private String texture; 
		
	public int getNo() {
		return no;
	}
	
	public void setNo(int no) {
		this.no = no;
	}
	
	public void setNo(String no) {
		try	{
			this.no = Integer.parseInt(no);
		}catch(Exception e)	{
			this.no = 0;
		}
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
	
	public int getHit() {
		return hit;
	}
	
	public void setHit(int hit) {
		this.hit = hit;
	}
	
	public void setHit(String hit) {
		try	{
			this.hit = Integer.parseInt(hit);
		}catch(Exception e)	{
			this.no = 0;
		}
	}

	public String getTexture() {
		return texture;
	}

	public void setTexture(String texture) {
		this.texture = texture;
	}
	
	 
}
