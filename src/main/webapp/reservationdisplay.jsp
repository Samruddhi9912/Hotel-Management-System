<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.model.Reservation, com.dao.ReservationDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hotel | View Bookings</title>
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
            border: 1px solid transparent;
            width: 95%;
            transition: 0.3s ease-out;
        }

        .table-container:hover {
            border: 1px solid #198754;
            transform: translateY(-5px);
        }

        .header-flex {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
            position: relative;
        }

        .page-title {
            font-weight: bold;
            color: #198754;
            margin: 0 auto;
            padding-right: 80px; 
        }

        .btn-print {
            position: absolute;
            right: 0;
            background-color: white;
            color: #198754;
            border: 1.5px solid #198754;
            font-weight: 600;
            padding: 8px 20px;
            border-radius: 10px;
            transition: 0.3s;
        }

        .btn-print:hover {
            background-color: #198754;
            color: white;
        }

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
            font-weight: bold;
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

        /* Semi-bold Revenue Row Styling */
        .revenue-row td {
            background-color: #fcfdfc;
            border-top: 1.5px solid #198754 !important;
            color: #198754 !important;
            font-size: 1.05rem;
            font-weight: 600 !important;
            border-bottom: none !important;
        }

        .revenue-label {
            text-align: right !important;
            padding-right: 30px !important;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .table tbody tr:hover td {
            background-color: #f1f8f4;
        }

        .footer-links {
            margin-top: 30px;
            text-align: center;
        }

        .dash-link {
            color: #198754;
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            transition: 0.2s;
        }
        
        .dash-link:hover { text-decoration: underline; }
        .text-amount { color: #198754; }

        @media print {
            .btn-print, .footer-links { display: none !important; }
            .table-container { box-shadow: none; border: none; width: 100%; margin: 0; }
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="table-container">
        
        <div class="header-flex">
            <h3 class="page-title">BOOKING RECORDS</h3>
            <button onclick="window.print()" class="btn btn-print">
                Print Records
            </button>
        </div>

        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th style="width: 7%">ID</th>
                        <th style="width: 23%">GUEST NAME</th>
                        <th style="width: 10%">ROOM NO</th>
                        <th style="width: 15%">ROOM TYPE</th>
                        <th style="width: 15%">CHECK IN</th>
                        <th style="width: 15%">CHECK OUT</th>
                        <th style="width: 15%">AMOUNT</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        double totalRevenue = 0;
                        try {
                            ReservationDAO dao = new ReservationDAO();
                            List<Reservation> list = dao.getAllReservations();
                            
                            if (list == null || list.isEmpty()) {
                    %>
                        <tr>
                            <td colspan="7" class="text-center py-5">No booking records found.</td>
                        </tr>
                    <% 
                            } else {
                                for (Reservation res : list) {
                                    totalRevenue += res.getTotalAmount();
                    %>
                        <tr>
                            <td>#<%= res.getReservationID() %></td>
                            <td><%= res.getCustomerName().toUpperCase() %></td>
                            <td><%= res.getRoomNumber() %></td>
                            <td><%= res.getRoomType().toUpperCase() %></td>
                            <td><%= res.getCheckIn() %></td>
                            <td><%= res.getCheckOut() %></td>
                            <td class="text-amount">
                                ₹<%= String.format("%.2f", res.getTotalAmount()) %>
                            </td>
                        </tr>
                    <% 
                                }
                    %>
                        <tr class="revenue-row">
                            <td colspan="6" class="revenue-label">Total Revenue</td>
                            <td>₹<%= String.format("%.2f", totalRevenue) %></td>
                        </tr>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<tr><td colspan='7' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                        }
                    %>
                </tbody>
            </table>
        </div>

        <div class="footer-links">
            <a href="index.jsp" class="dash-link">
                ← Return to Dashboard
            </a>
        </div>

    </div>
</div>

</body>
</html>