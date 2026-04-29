<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.ReservationDAO, com.model.Reservation, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Occupancy | Grand Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .table-responsive { border-radius: 15px; overflow: hidden; border: 1px solid #dee2e6; }
        .table thead { background-color: #198754; color: white; }
        .navbar-brand { font-weight: bold; }
        
        .back-link { 
            color: #198754; 
            text-decoration: none; 
            font-weight: 600; 
            font-size: 1.1rem;
            transition: 0.2s;
        }
        .back-link:hover { 
            color: #146c43; 
            text-decoration: underline; 
        }

        /* Custom Green Badge Styling */
        .badge-green {
            background-color: #e8f5e9;
            color: #1b5e20;
            border: 1px solid #c8e6c9;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-dark bg-success mb-4 shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">🏨 Grand Hotel</a>
        </div>
    </nav>

    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-success fw-bold mb-0">Current Reservations</h2>
            <a href="index.jsp" class="back-link">← Return to Dashboard</a>
        </div>

        <div class="table-responsive bg-white shadow-sm">
            <table class="table table-hover align-middle mb-0">
                <thead>
                    <tr>
                        <th class="ps-3">ID</th>
                        <th>Guest Name</th>
                        <th>Room Type</th>
                        <th>Room No.</th>
                        <th>Check-In</th>
                        <th>Check-Out</th>
                        <th class="pe-3">Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        try {
                            List<Reservation> list = new ReservationDAO().getAll();
                            if (list == null || list.isEmpty()) {
                    %>
                        <tr>
                            <td colspan="7" class="text-center py-5 text-muted">No reservations found in the system.</td>
                        </tr>
                    <%
                            } else {
                                for(Reservation r : list) { 
                    %>
                        <tr>
                            <td class="ps-3 text-secondary">#<%= r.getReservationID() %></td>
                            <td class="fw-bold"><%= r.getCustomerName() %></td>
                            <td>
                                <span class="badge bg-success rounded-pill px-3"><%= r.getRoomType() %></span>
                            </td>
                            <td><span class="text-dark">Room <%= r.getRoomNumber() %></span></td>
                            <td><%= r.getCheckIn() %></td>
                            <td><%= r.getCheckOut() %></td>
                            <td class="pe-3 text-success fw-bold">₹<%= r.getTotalAmount() %></td>
                        </tr>
                    <% 
                                } 
                            }
                        } catch(Exception e) { 
                    %>
                        <tr><td colspan="7" class="text-danger text-center">Error: <%= e.getMessage() %></td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>