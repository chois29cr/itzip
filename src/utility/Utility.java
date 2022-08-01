package utility;

public class Utility {
	
	public static String _R(String html){
		
		if(html != null){
			html = html.replace("<", "&lt;");
			html = html.replace(">", "&gt;");
			html = html.replace(" ", "&nbsp;");
			html = html.replace("\n", "<br>");
			html = html.replace("'", "''");
		}
		return html;
	}
	
	public static String _M(String html){
		
		if(html != null){
			html = html.replace("<br>", "\n");			
		}
		return html;
	}
	
	public static int ToInteger(String n){
		try	{
			return Integer.parseInt(n);
		}catch(Exception e)	{
			return 0;
		}
	}
	
	public static String ToString(int n){
		return Integer.toString(n);
	}
}
