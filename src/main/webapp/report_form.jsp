<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card mx-auto shadow border-success" style="max-width: 500px;">
            <div class="card-body">
                <h4 class="card-title text-success">Revenue & Occupancy Report</h4>
                <hr>
                <form action="ReportServlet" method="get">
                    <div class="mb-3"><label class="form-label">Start Date</label><input type="date" name="startDate" class="form-control border-success"></div>
                    <div class="mb-3"><label class="form-label">End Date</label><input type="date" name="endDate" class="form-control border-success"></div>
                    <button type="submit" class="btn btn-success w-100">Generate Report</button>
                    <a href="index.jsp" class="btn btn-link w-100 mt-2 text-success">Back to Dashboard</a>
                </form>
            </div>
        </div>
    </div>
</body>
</html>