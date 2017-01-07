package com.gamahao;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ticket.GetAvailableSeats;
import ticket.GetCar;
import ticket.GetDestination;
import ticket.GetStation;

public class ServiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ServiceServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String page = request.getParameter("page");
		String service = request.getParameter("service");
		
		if (page == null && service == null) page = "index";

		response.setCharacterEncoding("UTF-8");
		
		if (page != null) pageForward(page, request, response);
		else serviceForward(service, request, response);
		
	}
	
	private void pageForward(String page, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		
		if (page.equals("index"))
			request.getRequestDispatcher(request.getContextPath()+"/index.jsp").forward(request, response);
		else if (page.equals("agreement"))
			request.getRequestDispatcher(request.getContextPath()+"/agreement/agreement.jsp").forward(request, response);
		else if (page.equals("form"))
			request.getRequestDispatcher(request.getContextPath()+"/form/form.jsp").forward(request, response);
		else if (page.equals("reservation"))
			request.getRequestDispatcher(request.getContextPath()+"/reservation/reservation.jsp").forward(request, response);
		else if (page.equals("feedback"))
			request.getRequestDispatcher(request.getContextPath()+"/feedback/feedback.jsp").forward(request, response);
		else if (page.equals("thanks"))
			request.getRequestDispatcher(request.getContextPath()+"/feedback/thanks.jsp").forward(request, response);
		else if (page.equals("inquire"))
			request.getRequestDispatcher(request.getContextPath()+"/inquiry/inquire.jsp").forward(request, response);
		else
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		
	}

	private void serviceForward(String service, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		
		if (service.equals("getAvailableSeats"))
			response.getWriter().print(
					GetAvailableSeats.getSeats(
							request.getParameter("car_name"), 
							request.getParameter("date"), 
							request.getParameter("begin"), 
							request.getParameter("end")));
		
		else if (service.equals("getDestination"))
			response.getWriter().print(
					GetDestination.getDestination(
							request.getParameter("route"), 
							request.getParameter("start")));
		
		else if (service.equals("getStation"))
			response.getWriter().print(
					GetStation.getStation(
							request.getParameter("route")));
		
		else if (service.equals("getCar"))
			response.getWriter().print(
					GetCar.getCar(
							request.getParameter("route"), 
							request.getParameter("start"), 
							request.getParameter("date"), 
							request.getParameter("destination")));
		else if (service.equals("getTicket"))
			if (GetTicket.getTicket(
					request.getParameter("start"),
					request.getParameter("end"),
					request.getParameter("date"),
					request.getParameter("car_name"))) 
				request.getRequestDispatcher(request.getContextPath()+"/result/complete.jsp").forward(request, response);
			else
				request.getRequestDispatcher(request.getContextPath()+"/result/fail.jsp").forward(request, response);
		else
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		
	}
	
}
