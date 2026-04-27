<%@ page import="java.util.List, com.model.Reservation" %>
<!DOCTYPE html>
<html>
<head>
    <title>Report Results</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="card shadow-sm border-success">
            <div class="card-header bg-success text-white d-flex justify-content-between align-items-center py-3">
                <h5 class="mb-0">Generated Report Results</h5>
                <button onclick="window.print()" class="btn btn-sm btn-light text-success fw-bold">Print Report</button>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-success">
                            <tr>
                                <th>Res. ID</th>
                                <th>Customer Name</th>
                                <th>Room</th>
                                <th>Check-In</th>
                                <th>Check-Out</th>
                                <th class="text-end">Amount Paid</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                List<Reservation> list = (List<Reservation>)request.getAttribute("reportList");
                                if(list != null && !list.isEmpty()) { 
                                    double total = 0;
                                    for(Reservation r : list) { 
                                        total += r.getTotalAmount();
                            %>
                            <tr>
                                <td>#<%= r.getReservationID() %></td>
                                <td class="fw-bold"><%= r.getCustomerName() %></td>
                                <td><span class="badge bg-success">Room <%= r.getRoomNumber() %></span></td>
                                <td><%= r.getCheckIn() %></td>
                                <td><%= r.getCheckOut() %></td>
                                <td class="text-end fw-bold text-success">$<%= String.format("%.2f", r.getTotalAmount()) %></td>
                            </tr>
                            <% } %>
                            <tr class="table-success fw-bold">
                                <td colspan="5" class="text-end">Total Revenue:</td>
                                <td class="text-end">$<%= String.format("%.2f", total) %></td>
                            </tr>
                            <% } else { %>
                            <tr>
                                <td colspan="6" class="text-center text-muted py-4">No records found for the selected criteria.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="card-footer bg-white border-0 text-center pb-4">
                <a href="report_form.jsp" class="btn btn-success">Generate Another Report</a>
            </div>
        </div>
    </div>
</body>
</html>