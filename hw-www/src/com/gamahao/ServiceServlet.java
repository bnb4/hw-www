package com.gamahao;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ticket.GetAvailableSeats;

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
		else
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		
	}

	private void serviceForward(String service, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		
		if (service.equals("getAvailableSeats"))
			response.getWriter().print(GetAvailableSeats.getSeats(request.getParameter("car_name"), request.getParameter("date"), request.getParameter("begin"), request.getParameter("end")));
		else
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		
	}
	
}
