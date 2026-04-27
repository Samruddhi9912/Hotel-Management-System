<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Reservation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow border-success">
                    <div class="card-header bg-success py-3">
                        <h4 class="mb-0 text-white">Modify Reservation</h4>
                    </div>
                    <div class="card-body p-4">
                        <form action="updateReservation" method="post">
                            <div class="alert alert-success py-2 small">
                                <strong>Note:</strong> Enter the <b>Reservation ID</b> of the booking you wish to modify.
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label fw-bold">Reservation ID</label>
                                <input type="number" name="id" class="form-control form-control-lg border-success" placeholder="Ex: 101" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">New Customer Name</label>
                                <input type="text" name="name" class="form-control border-success" placeholder="Update Name" required>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">New Room Number</label>
                                    <input type="text" name="room" class="form-control border-success" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">New Total Amount ($)</label>
                                    <input type="number" step="0.01" min="0" name="amount" class="form-control border-success" required>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">New Check-In</label>
                                    <input type="date" name="in" class="form-control border-success" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">New Check-Out</label>
                                    <input type="date" name="out" class="form-control border-success" required>
                                </div>
                            </div>

                            <div class="d-grid gap-2 mt-3">
                                <button type="submit" class="btn btn-success btn-lg">Update Records</button>
                                <a href="index.jsp" class="btn btn-light text-success">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>