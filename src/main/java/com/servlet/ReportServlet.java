package com.servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.dao.ReservationDAO;
import com.model.Reservation;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String start = req.getParameter("startDate");
        String end = req.getParameter("endDate");
        String type = req.getParameter("roomType"); //
        ReservationDAO dao = new ReservationDAO();

        try {
            List<Reservation> list;
            if (type != null && !type.isEmpty()) {
                list = dao.getByType(type); //
            } else {
                list = dao.getByDateRange(start, end);
            }

            // Occupancy Logic: 100 rooms per type, 300 total
            int nUsed = dao.getBookedCountByType("Non-AC");
            int aUsed = dao.getBookedCountByType("AC");
            int dUsed = dao.getBookedCountByType("Deluxe");

            req.setAttribute("reportList", list);
            req.setAttribute("nonAcRem", 100 - nUsed); //
            req.setAttribute("acRem", 100 - aUsed); //
            req.setAttribute("deluxeRem", 100 - dUsed); //
            req.setAttribute("totalRem", 300 - (nUsed + aUsed + dUsed)); //

            req.getRequestDispatcher("report_result.jsp").forward(req, resp);
        } catch (Exception e) { throw new ServletException(e); }
    }
}