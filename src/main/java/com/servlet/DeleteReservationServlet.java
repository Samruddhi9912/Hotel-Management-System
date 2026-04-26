package com.servlet;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.dao.ReservationDAO;

@WebServlet("/deleteReservation")
public class DeleteReservationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        try { new ReservationDAO().deleteReservation(id); resp.sendRedirect("reservationdisplay.jsp"); } catch(Exception e) { throw new ServletException(e); }
    }
}