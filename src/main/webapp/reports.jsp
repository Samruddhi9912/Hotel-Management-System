<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Hotel Reports</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="text-center mb-5">
            <h1 class="display-5 fw-bold">Analytics & Reports</h1>
            <p class="text-muted">Select a report type to view hotel performance data.</p>
        </div>
        
        <div class="row justify-content-center g-4">
            <div class="col-md-4">
                <div class="card shadow-sm h-100 border-0">
                    <div class="card-body text-center">
                        <div class="fs-1 mb-3">📅</div>
                        <h5 class="card-title">Date Range Report</h5>
                        <p class="card-text text-muted">View all reservations booked within a specific timeframe.</p>
                        <a href="report_form.jsp" class="btn btn-outline-primary stretched-link">Configure</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card shadow-sm h-100 border-0">
                    <div class="card-body text-center">
                        <div class="fs-1 mb-3">💰</div>
                        <h5 class="card-title">Revenue Summary</h5>
                        <p class="card-text text-muted">Total income generated from all room bookings.</p>
                        <a href="report_form.jsp" class="btn btn-outline-success stretched-link">View Revenue</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="text-center mt-5">
            <a href="index.jsp" class="btn btn-link text-decoration-none text-secondary">← Back to Dashboard</a>
        </div>
    </div>
</body>
</html>