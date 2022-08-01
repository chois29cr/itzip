package dbms;
import java.io.FileReader;
import java.util.Properties;

public class DBProperties{
	
	static Properties properties;
	
	
	public DBProperties() {
		
		properties = new Properties();
		
		String path = DBProperties.class.getResource("db.properties").getPath();
	
		try {
			properties.load(new FileReader(path));
			System.out.println("DB프로퍼티 : host ip주소 "+ properties.getProperty("host"));
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public String getHost() {
		return properties.getProperty("host");
	}
	
	public String getDbname() {
		return properties.getProperty("dbname");
	}
	
	public String getId() {
		return properties.getProperty("id");
	}
	
	public String getPw() {
		return properties.getProperty("pw");
	}
		
}
