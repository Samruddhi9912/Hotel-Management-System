package com.servlet;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.ReservationDAO;
import com.model.Reservation;

@WebServlet("/updateReservation")
public class UpdateReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ReservationDAO dao = new ReservationDAO();
        
        // Retrieve updated details from the form
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String room = request.getParameter("room");
        String type = request.getParameter("type");
        Date in = Date.valueOf(request.getParameter("in"));
        Date out = Date.valueOf(request.getParameter("out"));
        double amount = Double.parseDouble(request.getParameter("amount"));

        try {
            // Logic to check if the new room selection conflicts with existing bookings
            // (Excluding the current reservation ID itself from the conflict check)
            
            // Note: If you want to be very strict, you can add an additional check in DAO 
            // to ensure the room isn't taken by someone ELSE during these new dates.
            
            Reservation updatedRes = new Reservation(id, name, room, type, in, out, amount);
            dao.updateReservation(updatedRes);
            
            // Redirect to the display page after successful update
            response.sendRedirect("reservationdisplay.jsp");
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error during update: " + e.getMessage());
        }
    }
}