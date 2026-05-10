<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hotel | Reports</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { 
            background-color: #f8f9fa; 
            font-family: 'Segoe UI', sans-serif;
        }
        
        .hotel-card { 
            max-width: 500px; 
            margin: 80px auto; 
            border-radius: 30px; 
            background-color: white;
            padding: 40px;
            border: 1px solid rgba(0,0,0,0.05); 
            box-shadow: 0 4px 15px rgba(0,0,0,0.03); 
            transition: all 0.3s ease-out;
            position: relative;
            min-height: 350px;
        }

        .hotel-card:hover {
            border-color: #198754; 
            transform: translateY(-3px); 
            box-shadow: 0 6px 20px rgba(0,0,0,0.06); 
        }

        .page-title {
            color: #198754;
            font-weight: bold;
            margin-bottom: 30px;
            text-align: center;
        }

        .btn-custom {
            background-color: white; 
            color: #198754; 
            border: 1.5px solid #198754;
            font-weight: 600;
            transition: 0.3s; 
            width: 100%; 
            margin-bottom: 15px; 
            padding: 12px;
            border-radius: 12px;
        }

        .btn-custom:hover { 
            background-color: #198754; 
            color: white; 
        }

        /* UPDATED: Green border on hover logic */
        .form-label {
            font-weight: 600;
            color: #444;
        }

        .form-control, .form-select {
            font-weight: 600;
            color: #444;
            border-radius: 12px;
            border: 1px solid #dee2e6;
            transition: all 0.3s ease;
        }

        .form-control:hover, .form-select:hover {
            border-color: #198754; /* Thin green border */
        }

        .form-control:focus, .form-select:focus {
            border-color: #198754;
            box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.1); /* Soft green glow */
            outline: none;
        }

        .hidden-section { 
            display: none; 
        }

        .dash-link {
            color: #198754;
            text-decoration: none;
            font-weight: 600;
            transition: 0.2s;
            cursor: pointer;
        }

        .dash-link:hover { 
            text-decoration: underline; 
        }

        .fade-in {
            animation: fadeIn 0.4s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <div class="hotel-card">
        
        <!-- SECTION 1: MAIN SELECTION -->
        <div id="selection-view" class="fade-in">
            <h3 class="page-title">ANALYTICS REPORT</h3>
            <div class="text-center">
                <button class="btn btn-custom" onclick="showForm('date-view')">Report by Date</button>
                <button class="btn btn-custom" onclick="showForm('type-view')">Report by Type</button>
                <div class="mt-4 pt-2 border-top">
                    <a href="index.jsp" class="dash-link">← Return to Dashboard</a>
                </div>
            </div>
        </div>

        <!-- SECTION 2: DATE FORM -->
        <div id="date-view" class="hidden-section fade-in">
            <h3 class="page-title">DATE RANGE</h3>
            <form action="ReportServlet" method="get">
                <label class="form-label d-block text-start">Start Date</label>
                <input type="date" name="startDate" class="form-control mb-3" required>
                <label class="form-label d-block text-start">End Date</label>
                <input type="date" name="endDate" class="form-control mb-3" required>
                <button type="submit" class="btn btn-custom">Generate Report</button>
            </form>
            <div class="text-center mt-3">
                <span class="dash-link" onclick="showForm('selection-view')">← Back to Options</span>
            </div>
        </div>

        <!-- SECTION 3: TYPE FORM -->
        <div id="type-view" class="hidden-section fade-in">
            <h3 class="page-title">ROOM TYPE</h3>
            <form action="ReportServlet" method="get">
                <label class="form-label d-block text-start">Select Room Type</label>
                <select name="roomType" class="form-select mb-4">
                    <option value="Non-AC">Non-AC</option>
                    <option value="AC">AC</option>
                    <option value="Deluxe">Deluxe</option>
                </select>
                <button type="submit" class="btn btn-custom">Generate Report</button>
            </form>
            <div class="text-center mt-3">
                <span class="dash-link" onclick="showForm('selection-view')">← Back to Options</span>
            </div>
        </div>

    </div>

    <script>
        function showForm(viewId) {
            document.getElementById('selection-view').style.display = 'none';
            document.getElementById('date-view').style.display = 'none';
            document.getElementById('type-view').style.display = 'none';

            const selectedView = document.getElementById(viewId);
            selectedView.style.display = 'block';
        }
    </script>
</body>
</html>