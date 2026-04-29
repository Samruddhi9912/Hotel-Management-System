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

        // Basic validation: check if dates are provided
        if (start == null || end == null || start.isEmpty() || end.isEmpty()) {
            resp.sendRedirect("report_form.jsp?error=missing_dates");
            return;
        }

        try {
            ReservationDAO dao = new ReservationDAO();
            List<Reservation> list = dao.getByDateRange(start, end);
            
            // Calculate total revenue for the report summary
            double totalRevenue = 0;
            for(Reservation r : list) {
                totalRevenue += r.getTotalAmount();
            }

            req.setAttribute("reportList", list);
            req.setAttribute("totalRevenue", totalRevenue);
            req.setAttribute("startDate", start);
            req.setAttribute("endDate", end);
            
            req.getRequestDispatcher("report_result.jsp").forward(req, resp);
        } catch(Exception e) { 
            e.printStackTrace();
            throw new ServletException(e); 
        }
    }
}