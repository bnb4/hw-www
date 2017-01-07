package ticket;

public class HeaderCreater {
	public static String createHeader(String currentPage) {
		if (currentPage == null)
			currentPage = "";

		StringBuilder sb = new StringBuilder();
		sb.append("<link href=\"/css/header.css\" rel=\"stylesheet\" />");
		sb.append("<header>");
		sb.append("<nav><div class=\"nav-wrapper grey darken-4\">" + "<a href=\"/\" class=\"brand-logo center\"> "
				+ "<i class=\"material-icons\">&nbsp loyalty</i>屍速客運訂票系統</a>" + "</div>"
				+ "<div class=\"nav-wrapper grey darken-4\">");

		if (currentPage.equals("agreement"))
			sb.append("<div class=\"center\" id=\"crumbs\">	" + "<ul><li><a class=\"active\">條款</a></li>"
					+ "<li><a>填寫資料</a></li>" + "<li><a>選擇車次</a></li>" + "<li><a>結果</a></li></ul>" + "</div>");
		else if (currentPage.equals("form"))
			sb.append("<div class=\"center\" id=\"crumbs\">" + "<ul><li><a class=\"active\">條款</a></li>"
					+ "<li><a class=\"active\">填寫資料</a></li>" + "<li><a>選擇車次</a></li>" + "<li><a>結果</a></li></ul>"
					+ "</div>");
		else if (currentPage.equals("reservation"))
			sb.append("<div class=\"center\" id=\"crumbs\">	" + "<ul><li><a class=\"active\">條款</a></li>"
					+ "<li><a class=\"active\">填寫資料</a></li>" + "<li><a class=\"active\">選擇車次</a></li>"
					+ "<li><a>結果</a></li></ul>" + "</div>");
		else if (currentPage.equals("result"))
			sb.append("<div class=\"center\" id=\"crumbs\">	" + "<ul><li><a class=\"active\">條款</a></li>"
					+ "<li><a class=\"active\">填寫資料</a></li>" + "<li><a class=\"active\">選擇車次</a></li>"
					+ "<li><a class=\"active\">結果</a></li></ul>" + "</div>");
		else
			sb.append("<div class=\"center\" id=\"current_page\">" + currentPage + "</div>");

		sb.append("</div><div  style=\"height:65px;\"></nav></header>");
		return sb.toString();
	}
}
