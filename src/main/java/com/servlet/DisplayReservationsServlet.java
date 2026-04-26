package com.servlet;
import java.io.*;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.dao.ReservationDAO;
import com.model.Reservation;

@WebServlet("/displayReservations")
public class DisplayReservationsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Reservation> list = new ReservationDAO().getAll();
            req.setAttribute("resList", list);
            req.getRequestDispatcher("reservationdisplay.jsp").forward(req, resp);
        } catch(Exception e) { throw new ServletException(e); }
    }
}