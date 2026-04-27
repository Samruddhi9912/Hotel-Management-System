<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="card shadow-sm border-success">
                    <div class="card-header bg-success text-white"><h5>Cancel Reservation</h5></div>
                    <div class="card-body">
                        <form action="deleteReservation" method="post">
                            <p class="text-muted">Enter the ID of the reservation you wish to remove.</p>
                            <input type="number" name="id" class="form-control mb-3 border-success" placeholder="Reservation ID" required>
                            <button type="submit" class="btn btn-success w-100">Delete Permanently</button>
                            <a href="index.jsp" class="btn btn-link w-100 mt-2 text-success">Cancel</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>