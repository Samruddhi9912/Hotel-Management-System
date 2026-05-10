package com.servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.dao.ReservationDAO;
import com.model.Reservation;

@WebServlet("/displayReservations")
public class DisplayReservationsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ReservationDAO dao = new ReservationDAO();
        try {
            List<Reservation> list = dao.getAllReservations();
            req.setAttribute("resList", list);
            req.getRequestDispatcher("reservationdisplay.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}