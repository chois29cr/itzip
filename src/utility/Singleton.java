package utility;

import java.util.ArrayList;

public class Singleton {
	
	//정적필드
	private static Singleton singleton= new Singleton();
	
	private ArrayList<String> attach  = new ArrayList<String>();
	
	//생성자
	private Singleton() {
		System.out.println("싱글톤");	
	}
	
	//정적메소드
	public static Singleton getInstance() {
		return singleton;
	}
	

	public void setAttach(String value) {
		attach.add(value);
	}

	public String getAttach(int i) {
		return attach.get(i);
	}
	
	public int length() {
		return attach.size();
	}
	
	
}
