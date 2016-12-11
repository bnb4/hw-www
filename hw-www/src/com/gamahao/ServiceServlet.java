package com.gamahao;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ServiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ServiceServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String page = request.getParameter("page");
		if (page == null) page = "index";
		
		switch (page) {
		case "index":
			request.getRequestDispatcher(request.getContextPath()+"/index.jsp").forward(request, response);
			break;
		case "agreement":
			request.getRequestDispatcher(request.getContextPath()+"/agreement/agreement.jsp").forward(request, response);
			break;
		case "form":
			request.getRequestDispatcher(request.getContextPath()+"/form/form.jsp").forward(request, response);
			break;
		case "reservation":
			response.getWriter().append("TEST");
			break;
		case "feedback":
			request.getRequestDispatcher(request.getContextPath()+"/feedback/feedback.jsp").forward(request, response);
			break;
		default:
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			break;
		}
	}

}
