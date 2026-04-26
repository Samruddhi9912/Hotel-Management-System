<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Hotel Management | Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .hero-section { background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'); 
                        height: 400px; background-size: cover; color: white; display: flex; align-items: center; justify-content: center; flex-direction: column; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">🏨 Grand Hotel</a>
        </div>
    </nav>

    <div class="hero-section text-center">
        <h1 class="display-3 fw-bold">Management Portal</h1>
        <p class="lead">Efficiently manage reservations, rooms, and revenue.</p>
    </div>

    <div class="container my-5">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body text-center">
                        <h5 class="card-title">Reservations</h5>
                        <p class="text-muted">Book new guests or update details.</p>
                        <a href="reservationadd.jsp" class="btn btn-primary w-100 mb-2">Add New Booking</a>
                        <a href="reservationdisplay.jsp" class="btn btn-outline-primary w-100">View All Bookings</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body text-center">
                        <h5 class="card-title">Modifications</h5>
                        <p class="text-muted">Change or cancel existing stays.</p>
                        <a href="reservationupdate.jsp" class="btn btn-warning w-100 mb-2">Update Details</a>
                        <a href="reservationdelete.jsp" class="btn btn-danger w-100">Cancel Reservation</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body text-center">
                        <h5 class="card-title">Analytics</h5>
                        <p class="text-muted">View revenue and occupancy reports.</p>
                        <a href="report_form.jsp" class="btn btn-success w-100">Generate Reports</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>