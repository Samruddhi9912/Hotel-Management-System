package com.servlet;
import java.io.*;
import java.sql.Date;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.dao.ReservationDAO;
import com.model.Reservation;

@WebServlet("/addReservation")
public class AddReservationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ReservationDAO dao = new ReservationDAO();
        String name = req.getParameter("name");
        String room = req.getParameter("room");
        String type = req.getParameter("type");
        Date in = Date.valueOf(req.getParameter("in"));
        Date out = Date.valueOf(req.getParameter("out"));
        double amount = Double.parseDouble(req.getParameter("amount"));

        try {
            if (dao.isRoomBooked(room, type, in, out)) {
                resp.sendRedirect("reservationadd.jsp?error=booked");
            } else {
                Reservation r = new Reservation(0, name, room, type, in, out, amount);
                dao.addReservation(r);
                resp.sendRedirect("reservationdisplay.jsp");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}