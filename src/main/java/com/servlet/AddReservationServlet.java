package com.servlet;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.dao.ReservationDAO;
import com.model.Reservation;

@WebServlet("/addReservation")
public class AddReservationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String address = req.getParameter("address"); // New
        String room = req.getParameter("room");
        String type = req.getParameter("type");
        Date in = Date.valueOf(req.getParameter("in"));
        Date out = Date.valueOf(req.getParameter("out"));
        double amount = Double.parseDouble(req.getParameter("amount"));

        // Use 0 for ID as DB handles Auto-Increment
        Reservation res = new Reservation(0, name, address, room, type, in, out, amount);
        ReservationDAO dao = new ReservationDAO();

        try {
            dao.addReservation(res);
            resp.sendRedirect("displayReservations");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}