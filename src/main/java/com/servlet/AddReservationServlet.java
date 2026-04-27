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
        // ID parameter is no longer required for creation
        Reservation r = new Reservation();
        r.setCustomerName(req.getParameter("name"));
        r.setRoomNumber(req.getParameter("room"));
        r.setCheckIn(Date.valueOf(req.getParameter("in")));
        r.setCheckOut(Date.valueOf(req.getParameter("out")));
        r.setTotalAmount(Double.parseDouble(req.getParameter("amount")));
        
        try { 
            new ReservationDAO().addReservation(r); 
            resp.sendRedirect("reservationdisplay.jsp"); 
        } catch(Exception e) { 
            throw new ServletException(e); 
        }
    }
}