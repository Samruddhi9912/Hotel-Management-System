<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hotel Management | Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        
        /* Hero Section */
        .hero-section { 
            background: linear-gradient(rgba(0,50,0,0.6), rgba(0,50,0,0.6)), 
            url('https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'); 
            height: 450px; 
            background-size: cover; 
            background-position: center;
            color: white; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            flex-direction: column; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        /* Card animations */
        .card { 
            border-radius: 15px; 
            transition: all 0.3s ease; 
            border: 1px solid rgba(25, 135, 84, 0.2);
        }
        .card:hover { 
            transform: translateY(-10px); 
            box-shadow: 0 15px 30px rgba(0,0,0,0.1) !important;
            border-color: #198754;
        }

        /* Thinned out green border here */
        .btn-outline-success { 
            border-width: 1px; /* Changed from 2px to 1px for a thinner look */
            font-weight: 600; 
            border-radius: 12px; /* Matched your 12px vibe from update/delete pages */
            padding: 10px;
            transition: 0.3s;
        }
        
        .btn-outline-success:hover {
            background-color: #198754;
            color: white;
        }

        .card-title {
            letter-spacing: 1px;
            text-transform: uppercase;
            font-size: 1.1rem;
        }
    </style>
</head>
<body>

    <div class="hero-section text-center">
        <h1 class="display-2 fw-bold">Grand Hotel</h1>
        <p class="lead fs-4">Management Portal</p>
        <div class="mt-2 opacity-75">Secure • Efficient • Professional</div>
    </div>

    <div class="container my-5">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body text-center p-4">
                        <h5 class="card-title text-success fw-bold mb-3">Reservations</h5>
                        <p class="text-muted small mb-4">Handle incoming guests and view current occupancy status.</p>
                        <a href="reservationadd.jsp" class="btn btn-outline-success w-100 mb-3">Add New Booking</a>
                        <a href="reservationdisplay.jsp" class="btn btn-outline-success w-100">View All Bookings</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body text-center p-4">
                        <h5 class="card-title text-success fw-bold mb-3">Modifications</h5>
                        <p class="text-muted small mb-4">Adjust stay dates, guest details, or cancel active tickets.</p>
                        <a href="reservationupdate.jsp" class="btn btn-outline-success w-100 mb-3">Update Details</a>
                        <a href="reservationdelete.jsp" class="btn btn-outline-success w-100">Cancel Reservation</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body text-center p-4">
                        <h5 class="card-title text-success fw-bold mb-3">Analytics</h5>
                        <p class="text-muted small mb-4">Review daily revenue streams and room usage reports.</p>
                        <a href="report_form.jsp" class="btn btn-outline-success w-100">Generate Reports</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="text-center py-5 text-muted">
        <hr class="container mb-4">
        <small>Grand Hotel Management System &copy; 2026</small>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>