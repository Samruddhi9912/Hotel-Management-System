<%@ page import="com.dao.ReservationDAO, com.model.Reservation, java.util.List" %>
<html>
<head>
    <title>Current Occupancy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-success">Current Reservations</h2>
            <a href="index.jsp" class="btn btn-success btn-sm">Back to Home</a>
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-bordered shadow-sm">
                <thead class="table-success">
                    <tr>
                        <th>ID</th><th>Customer Name</th><th>Room</th><th>Check-In</th><th>Check-Out</th><th>Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<Reservation> list = new ReservationDAO().getAll();
                        for(Reservation r : list) { 
                    %>
                    <tr>
                        <td><%= r.getReservationID() %></td>
                        <td class="fw-bold"><%= r.getCustomerName() %></td>
                        <td><span class="badge bg-success">Room <%= r.getRoomNumber() %></span></td>
                        <td><%= r.getCheckIn() %></td>
                        <td><%= r.getCheckOut() %></td>
                        <td class="text-success fw-bold">$<%= String.format("%.2f", r.getTotalAmount()) %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>