<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>New Booking | Grand Hotel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>body { background-color: #f8f9fa; }</style>
</head>
<body>
    <nav class="navbar navbar-dark bg-dark">
        <div class="container"><a class="navbar-brand" href="index.jsp">🏨 Grand Hotel</a></div>
    </nav>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white text-center py-3">
                        <h4 class="mb-0">New Reservation</h4>
                    </div>
                    <div class="card-body p-4">
                        <form action="addReservation" method="post">
                            <div class="mb-3">
                                <label class="form-label">Reservation ID</label>
                                <input type="number" name="id" class="form-control" placeholder="Enter ID" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Customer Name</label>
                                <input type="text" name="name" class="form-control" placeholder="Full Name" required>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Room Number</label>
                                    <input type="text" name="room" class="form-control" placeholder="e.g. 101" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Amount ($)</label>
                                    <input type="number" step="0.01" name="amount" class="form-control" placeholder="0.00" required>
                                </div>
                            </div>
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <label class="form-label">Check-In</label>
                                    <input type="date" name="in" class="form-control" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Check-Out</label>
                                    <input type="date" name="out" class="form-control" required>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 py-2">Confirm Booking</button>
                            <a href="index.jsp" class="btn btn-light w-100 mt-2">Back</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>