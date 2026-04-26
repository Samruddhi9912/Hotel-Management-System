package com.servlet;
import java.io.*;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.dao.ReservationDAO;
import com.model.Reservation;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String start = req.getParameter("startDate");
        String end = req.getParameter("endDate");
        try {
            List<Reservation> list = new ReservationDAO().getByDateRange(start, end);
            req.setAttribute("reportList", list);
            req.getRequestDispatcher("report_result.jsp").forward(req, resp);
        } catch(Exception e) { throw new ServletException(e); }
    }
}