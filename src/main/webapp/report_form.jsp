<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="card mx-auto" style="max-width: 500px;">
            <div class="card-body">
                <h4 class="card-title">Revenue & Occupancy Report</h4>
                <hr>
                <form action="ReportServlet" method="get">
                    <div class="mb-3"><label>Start Date</label><input type="date" name="startDate" class="form-control"></div>
                    <div class="mb-3"><label>End Date</label><input type="date" name="endDate" class="form-control"></div>
                    <button type="submit" class="btn btn-success w-100">Generate Report</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>