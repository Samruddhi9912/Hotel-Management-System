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
        Reservation r = new Reservation(Integer.parseInt(req.getParameter("id")), req.getParameter("name"), req.getParameter("room"),
                        Date.valueOf(req.getParameter("in")), Date.valueOf(req.getParameter("out")), Double.parseDouble(req.getParameter("amount")));
        try { new ReservationDAO().addReservation(r); resp.sendRedirect("reservationdisplay.jsp"); } catch(Exception e) { throw new ServletException(e); }
    }
}