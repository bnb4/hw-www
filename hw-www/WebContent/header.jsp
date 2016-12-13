<%@ page contentType="text/html; charset=utf-8"%>

<link href="/css/header.css" rel="stylesheet" />

<%!String createHeader(String currentPage) {
		StringBuilder sb = new StringBuilder();
		sb.append("<header>");
		sb.append("<nav><div class=\"nav-wrapper grey darken-4\">"
				+ "<a href=\"/\" class=\"brand-logo center\"> "
				+ "<i class=\"material-icons\">&nbsp loyalty</i>屍速客運訂票系統</a>"
				+ "</div>" + "<div class=\"nav-wrapper grey darken-4\">");
		switch (currentPage) {
		default:
			sb.append("<div class=\"center\" id=\"current_page\">"
					+ currentPage + "</div>");
			break;
		case "agreement":
			sb.append("<div class=\"center\" id=\"crumbs\">	"
					+ "<ul><li><a class=\"active\">條款</a></li>"
					+ "<li><a>填寫資料</a></li>" + "<li><a>選擇車次</a></li>"
					+ "<li><a>結果</a></li></ul>" + "</div>");
			break;

		case "form":
			sb.append("<div class=\"center\" id=\"crumbs\">"
					+ "<ul><li><a class=\"active\">條款</a></li>"
					+ "<li><a class=\"active\">填寫資料</a></li>"
					+ "<li><a>選擇車次</a></li>" + "<li><a>結果</a></li></ul>"
					+ "</div>");
			break;

		case "reservation":
			sb.append("<div class=\"center\" id=\"crumbs\">	"
					+ "<ul><li><a class=\"active\">條款</a></li>"
					+ "<li><a class=\"active\">填寫資料</a></li>"
					+ "<li><a class=\"active\">選擇車次</a></li>"
					+ "<li><a>結果</a></li></ul>" + "</div>");
			break;

		case "result":
			sb.append("<div class=\"center\" id=\"crumbs\">	"
					+ "<ul><li><a class=\"active\">條款</a></li>"
					+ "<li><a class=\"active\">填寫資料</a></li>"
					+ "<li><a class=\"active\">選擇車次</a></li>"
					+ "<li><a class=\"active\">結果</a></li></ul>" + "</div>");
			break;

		}
		return sb.toString();
	}%>