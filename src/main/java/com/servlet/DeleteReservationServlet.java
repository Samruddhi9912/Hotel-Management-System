package com.servlet;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.dao.ReservationDAO;

@WebServlet("/deleteReservation")
public class DeleteReservationServlet extends HttpServlet {

    // ADD THIS: It catches the POST from your JSP and sends it to the logic below
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        
        if (idParam != null) {
            int id = Integer.parseInt(idParam);
            ReservationDAO dao = new ReservationDAO();

            try {
                dao.deleteReservation(id);
                // Redirect back to display list after deletion
                resp.sendRedirect("displayReservations"); 
            } catch (SQLException e) {
                throw new ServletException(e);
            }
        }
    }
}