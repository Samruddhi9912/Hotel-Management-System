<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.model.Reservation" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Grand Hotel | Report Summary</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; min-height: 100vh; }
        
        .report-card { 
            border-radius: 15px; 
            overflow: hidden; 
            border: none; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.1); 
        }

        /* Outline Button Style */
        .btn-outline-success {
            border-width: 2px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        /* Print Button specific style */
        .btn-print {
            border: 2px solid white;
            color: white;
            background: transparent;
            font-weight: 600;
        }
        .btn-print:hover {
            background: white;
            color: #198754;
        }

        /* Simple Text Link Style */
        .back-link {
            color: #198754;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
            transition: 0.3s;
        }
        .back-link:hover {
            color: #146c43;
            text-decoration: underline;
        }

        @media print {
            .btn, .no-print, .back-link { display: none !important; }
            body { background: white; }
            .report-card { box-shadow: none; border: 1px solid #dee2e6; }
        }
    </style>
</head>
<body>
    <div class="container mt-5 mb-5">
        <div class="card report-card">
            <div class="card-header bg-success text-white d-flex justify-content-between align-items-center py-3">
                <h5 class="mb-0 fw-bold">🏨 Revenue & Occupancy Summary</h5>
                <button onclick="window.print()" class="btn btn-sm btn-print px-3">Print Report</button>
            </div>
            
            <div class="card-body p-4">
                <div class="table-responsive">
                    <table class="table table-hover align-middle border">
                        <thead class="table-light">
                            <tr class="text-success text-uppercase small fw-bold">
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
                                <td class="text-secondary fw-bold">#<%= r.getReservationID() %></td>
                                <td class="fw-bold text-dark"><%= r.getCustomerName() %></td>
                                <td><span class="badge border border-success text-success bg-transparent">Room <%= r.getRoomNumber() %></span></td>
                                <td><%= r.getCheckIn() %></td>
                                <td><%= r.getCheckOut() %></td>
                                <td class="text-end fw-bold text-success">&#8377;<%= String.format("%.2f", r.getTotalAmount()) %></td>
                            </tr>
                            <% } %>
                            <tr class="table-success fw-bold">
                                <td colspan="5" class="text-end py-3">Total Revenue:</td>
                                <td class="text-end py-3 text-dark">&#8377;<%= String.format("%.2f", total) %></td>
                            </tr>
                            <% } else { %>
                            <tr>
                                <td colspan="6" class="text-center text-muted py-5">
                                    <p class="mb-0">No records found for the selected criteria.</p>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <div class="card-footer bg-white border-0 text-center pb-4 no-print">
                <a href="report_form.jsp" class="btn btn-outline-success px-4 py-2 mb-3 d-block d-md-inline-block">Generate Another Report</a>
                <div class="mt-2">
                    <a href="index.jsp" class="back-link">← Return to Dashboard</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>