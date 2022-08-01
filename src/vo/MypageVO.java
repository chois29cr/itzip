package vo;

public class MypageVO {
	
	private int uno;		//유저 번호
	private String title;	//내 글 제목/댓글 내용
	private String name;	//작성자
	private String date;	//내 글/댓글 작성일
	private int no;			//내 게시글 번호
	private String type;	//테이블이름
	private String dimage;	//myroom 좋아요, classboard 찜 클래스 대표 이미지
	
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDate() {
		date = date.substring(0, 16);	
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDimage() {
		return dimage;
	}
	public void setDimage(String dimage) {
		this.dimage = dimage;
	}	
	
	
}
