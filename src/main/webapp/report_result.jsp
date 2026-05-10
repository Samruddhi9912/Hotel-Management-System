<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.model.Reservation" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hotel | Report Result</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { 
            background-color: #f8f9fa; 
            font-family: 'Segoe UI', sans-serif; 
        }
        
        .table-container { 
            background: white; 
            border-radius: 30px; 
            padding: 40px; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.05); 
            margin: 50px auto;
            border: 1px solid #eee;
            width: 95%;
        }

        .header-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        /* ONLY Bold Element - Nudged slightly toward the middle */
        .page-title {
            font-weight: bold;
            color: #198754;
            margin: 0;
            margin-left: 8%; 
            letter-spacing: 0.5px;
        }

        /* Stats Cards: Transparent border initially */
        .stat-card { 
            background: white; 
            border-radius: 15px; 
            padding: 20px; 
            border: 1px solid transparent; 
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            transition: all 0.3s ease-out;
            cursor: default;
        }
        
        /* Green border and movement appears ONLY on hover */
        .stat-card:hover {
            border-color: #198754; 
            transform: translateY(-5px); 
            box-shadow: 0 8px 20px rgba(0,0,0,0.06);
        }

        .stat-card h6 { font-weight: 600; color: #666; text-transform: uppercase; font-size: 0.75rem; margin-bottom: 5px; }
        .stat-card h4 { font-weight: 600; color: #198754; margin: 0; }
        
        /* Table Styling */
        .table {
            border-collapse: separate;
            border-spacing: 0;
            width: 100%;
        }

        .table thead th {
            background-color: #198754 !important;
            color: white !important;
            border: none;
            padding: 18px 10px;
            text-transform: uppercase;
            font-size: 0.85rem;
            font-weight: 600; 
            text-align: center;
        }

        .table thead th:first-child { border-top-left-radius: 20px; border-bottom-left-radius: 20px; }
        .table thead th:last-child { border-top-right-radius: 20px; border-bottom-right-radius: 20px; }

        .table tbody td {
            padding: 18px 10px;
            border-bottom: 1px solid #eee;
            color: #333;
            font-weight: 600; 
            text-align: center;
            vertical-align: middle;
        }

        .text-amount { color: #198754; font-weight: 600; }
        
        .btn-action {
            font-weight: 600;
            border-radius: 10px;
            padding: 8px 20px;
            transition: 0.3s;
        }

        /* White Button with Green Border */
        .btn-white {
            background-color: white;
            color: #198754;
            border: 1.5px solid #198754;
        }

        .btn-white:hover {
            background-color: #198754;
            color: white;
        }

        /* Dashboard Link with Underline on Hover */
        .dash-link {
            color: #198754;
            text-decoration: none;
            font-weight: 600;
            transition: 0.2s;
            display: inline-block;
        }

        .dash-link:hover {
            text-decoration: underline; /* Underline when mouse moves over it */
        }

        @media print {
            .btn-action, .header-flex a, .mt-5, .dash-link { display: none !important; }
            .table-container { box-shadow: none; border: none; margin: 0; width: 100%; }
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="table-container">
        
        <div class="header-flex">
            <h3 class="page-title">OCCUPANCY & REVENUE REPORT</h3>
            <div>
                <button onclick="window.print()" class="btn btn-outline-success btn-action me-2">Print Report</button>
                <a href="report_form.jsp" class="btn btn-white btn-action" style="text-decoration:none;">Generate New</a>
            </div>
        </div>

        <div class="row g-3 mb-5 text-center">
            <div class="col-md-3">
                <div class="stat-card">
                    <h6>Non-AC Left</h6>
                    <h4>${nonAcRem} / 100</h4>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <h6>AC Left</h6>
                    <h4>${acRem} / 100</h4>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <h6>Deluxe Left</h6>
                    <h4>${deluxeRem} / 100</h4>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <h6>Total Remaining</h6>
                    <h4>${totalRem} / 300</h4>
                </div>
            </div>
        </div>

        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th style="width: 8%">ID</th>
                        <th style="width: 22%">GUEST NAME</th>
                        <th style="width: 10%">ROOM NO</th>
                        <th style="width: 15%">ROOM TYPE</th>
                        <th style="width: 15%">CHECK IN</th>
                        <th style="width: 15%">CHECK OUT</th>
                        <th style="width: 15%">PAID AMOUNT</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<Reservation> list = (List<Reservation>)request.getAttribute("reportList");
                        double grandTotal = 0;
                        if(list != null && !list.isEmpty()) {
                            for(Reservation r : list) { 
                                grandTotal += r.getTotalAmount(); 
                    %>
                        <tr>
                            <td>#<%= r.getReservationID() %></td>
                            <td class="text-uppercase"><%= r.getCustomerName() %></td>
                            <td>Room <%= r.getRoomNumber() %></td>
                            <td><%= r.getRoomType().toUpperCase() %></td>
                            <td><%= r.getCheckIn() %></td>
                            <td><%= r.getCheckOut() %></td>
                            <td class="text-amount">₹<%= String.format("%.2f", r.getTotalAmount()) %></td>
                        </tr>
                    <% } %>
                        <tr style="background-color: #fcfcfc;">
                            <td colspan="6" class="text-end py-4" style="font-weight:600; color:#198754; font-size:1.1rem;">TOTAL REVENUE:</td>
                            <td class="text-amount py-4" style="font-size:1.2rem;">₹<%= String.format("%.2f", grandTotal) %></td>
                        </tr>
                    <% } else { %>
                        <tr><td colspan="7" class="text-center py-5">No records found.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="text-center mt-5">
            <a href="index.jsp" class="dash-link">← Return to Dashboard</a>
        </div>
    </div>
</div>

</body>
</html>