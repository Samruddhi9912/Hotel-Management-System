<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Grand Hotel | Analytics Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; min-height: 100vh; }
        .centered-wrapper { min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        .hotel-card { width: 100%; max-width: 500px; border-radius: 15px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.1); overflow: hidden; background: white; }
        .card-header { padding: 1.5rem; border: none; }
        .form-label { font-weight: 600; color: #495057; font-size: 0.85rem; }
        
        /* Outline Button Style */
        .btn-outline-success {
            border-width: 2px;
            font-weight: 600;
            padding: 12px;
            transition: all 0.3s ease;
        }

        /* Clean Back Link */
        .back-link { 
            color: #198754; 
            text-decoration: none; 
            font-weight: 500; 
            font-size: 0.9rem;
        }
        .back-link:hover { text-decoration: underline; color: #146c43; }

        .form-control:focus {
            border-color: #198754;
            box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.1);
        }
    </style>
</head>
<body>

    <div class="centered-wrapper">
        <div class="card hotel-card">
            <div class="card-header bg-success text-white text-center">
                <h4 class="mb-0 fw-bold">🏨 Analytics Report</h4>
                <small class="opacity-75">Revenue & Occupancy Insights</small>
            </div>
            
            <div class="card-body p-4">
                <form action="ReportServlet" method="get">
                    <p class="text-muted small text-center mb-4">Select a date range to generate the financial report.</p>
                    
                    <div class="mb-3">
                        <label class="form-label">Start Date</label>
                        <input type="date" name="startDate" class="form-control border-success" required>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">End Date</label>
                        <input type="date" name="endDate" class="form-control border-success" required>
                    </div>

                    <button type="submit" class="btn btn-outline-success w-100 fw-bold">
                        Generate Report
                    </button>
                    
                    <div class="text-center mt-4">
                        <a href="index.jsp" class="back-link">← Return to Dashboard</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>