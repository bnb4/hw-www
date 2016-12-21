<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.google.gson.*"%>
<%@ page import="ticket.SeatsGetter" %>
<%

String temp;

//車次
String car_name = (temp = request.getParameter("car_name")) == null ? "" : temp;
//日期 yyyy-mm-dd
String date = (temp = request.getParameter("date")) == null ? "" : temp;         
int begin = Integer.parseInt((temp = request.getParameter("begin"))== null ? "0" : temp);
int end = Integer.parseInt((temp = request.getParameter("end"))== null ? "0" : temp);

String json = new Gson().toJson(SeatsGetter.getInstance().getSeats(car_name, date, begin, end));

out.print(json);

%>