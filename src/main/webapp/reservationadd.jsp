<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.ReservationDAO" %>
<%
    ReservationDAO dao = new ReservationDAO();
    int nextId = dao.getNextReservationId(); 
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hotel | New Reservation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; font-family: 'Segoe UI', sans-serif; }
        
        .hotel-card { 
            max-width: 600px; margin: 50px auto; border-radius: 30px; 
            background-color: white; padding: 40px; border: 1px solid transparent; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.05); transition: 0.3s ease-out;
        }
        .hotel-card:hover { border-color: #198754; transform: translateY(-5px); }

        .page-title { color: #198754; font-weight: bold; margin-bottom: 30px; text-align: center; }
        .form-label { font-weight: 600; color: #444; font-size: 0.85rem; text-transform: uppercase; }

        .form-control, .form-select {
            border-radius: 12px; padding: 12px; border: 1px solid transparent; 
            background-color: #fcfcfc; font-weight: 400; transition: 0.3s; color: #000;
        }
        .form-control:hover, .form-select:hover, .form-control:focus {
            border: 1px solid #198754; background-color: white; outline: none; box-shadow: none;
        }

        .btn-confirm {
            background-color: white; color: #198754; border: 1.5px solid #198754;
            font-weight: 600; padding: 13px; border-radius: 12px; width: 100%; transition: 0.3s;
        }
        .btn-confirm:hover { background-color: #198754; color: white; }

        /* MODAL VIBE UPDATES */
        .modal-content { 
            border-radius: 30px; 
            border: 1px solid transparent; /* Thin border starts transparent */
            padding: 30px; 
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            transition: border-color 0.3s ease;
        }
        
        /* Thin green border on hover for the box */
        .modal-content:hover {
            border-color: #198754;
        }
        
        .modal-title-custom {
            color: #198754;
            font-weight: bold;
            font-size: 1.5rem;
            margin-bottom: 15px;
        }

        /* Modal Buttons: White background, Green border */
        .btn-modal-action { 
            background-color: white; 
            color: #198754; 
            border: 1.5px solid #198754;
            border-radius: 12px; 
            width: 120px; 
            font-weight: 600; 
            padding: 10px;
            transition: 0.3s ease;
        }

        /* Hover & Active/Click: Green background, White text */
        .btn-modal-action:hover, .btn-modal-action:active { 
            background-color: #198754 !important; 
            color: white !important;
            box-shadow: 0 4px 10px rgba(25, 135, 84, 0.2);
        }

        /* Secondary Button (No) - keeps standard borders but follows same hover logic */
        .btn-modal-secondary {
            background-color: white;
            color: #666;
            border: 1px solid #ddd;
            border-radius: 12px;
            width: 120px;
            font-weight: 600;
            padding: 10px;
            transition: 0.3s ease;
        }
        .btn-modal-secondary:hover {
            background-color: #666 !important;
            color: white !important;
            border-color: #666;
        }

        .dash-link { color: #198754; text-decoration: none; font-weight: 600; }
        .dash-link:hover { text-decoration: underline; }
    </style>
</head>
<body onload="initPage()">

<div class="container">
    <div class="hotel-card">
        <h3 class="page-title">NEW RESERVATION</h3>
        
        <form id="addForm" action="addReservation" method="post">
            <!-- Form fields remain the same -->
            <div class="row">
                <div class="col-md-4 mb-3">
                    <label class="form-label">Booking ID</label>
                    <input type="text" name="id" class="form-control" value="<%= nextId %>" readonly>
                </div>
                <div class="col-md-8 mb-3">
                    <label class="form-label">Guest Name</label>
                    <input type="text" name="name" class="form-control" placeholder="Enter guest name" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Guest Address</label>
                <textarea name="address" class="form-control" rows="2" placeholder="Enter address" required></textarea>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Room Type</label>
                    <select name="type" id="roomType" class="form-select" onchange="updateRooms()">
                        <option value="Non-AC" data-price="1000">Non-AC (₹1000)</option>
                        <option value="AC" data-price="3000">AC (₹3000)</option>
                        <option value="Deluxe" data-price="7000">Deluxe (₹7000)</option>
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Room No.</label>
                    <select name="room" id="roomSelect" class="form-select"></select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Check-In</label>
                    <input type="date" name="in" id="inDate" class="form-control" required onchange="handleCheckInChange()">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Check-Out</label>
                    <input type="date" name="out" id="outDate" class="form-control" required onchange="calculate()">
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label">Estimated Total (₹)</label>
                <input type="text" name="amount" id="totalAmt" class="form-control" value="0.00" readonly>
            </div>

            <button type="button" class="btn btn-confirm" onclick="showConfirm()">CONFIRM BOOKING</button>
            
            <div class="text-center mt-4">
                <a href="index.jsp" class="dash-link">← Return to Dashboard</a>
            </div>
        </form>
    </div>
</div>

<!-- Refined Modal -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body text-center">
                <h4 class="modal-title-custom">Finalize Booking?</h4>
                <p class="text-muted" style="font-weight: 500;">
                    Are you sure you want to save this reservation in the records?
                </p>
                
                <div class="d-flex justify-content-center gap-3 mt-4">
                    <button type="button" class="btn-modal-action" onclick="submitForm()">YES</button>
                    <button type="button" class="btn-modal-secondary" data-bs-dismiss="modal">NO</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let myModal;

    function initPage() {
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('inDate').setAttribute('min', today);
        updateRooms();
    }

    function handleCheckInChange() {
        const inDate = document.getElementById('inDate').value;
        const outDateInput = document.getElementById('outDate');
        if (inDate) {
            let nextDay = new Date(inDate);
            nextDay.setDate(nextDay.getDate() + 1);
            const minOut = nextDay.toISOString().split('T')[0];
            outDateInput.setAttribute('min', minOut);
            if (outDateInput.value && outDateInput.value < minOut) {
                outDateInput.value = "";
                document.getElementById('totalAmt').value = "0.00";
            }
        }
        calculate();
    }

    function showConfirm() {
        const form = document.getElementById('addForm');
        if (form.checkValidity()) {
            myModal = new bootstrap.Modal(document.getElementById('confirmModal'));
            myModal.show();
        } else {
            form.reportValidity();
        }
    }

    function submitForm() {
        document.getElementById('addForm').submit();
    }

    function updateRooms() {
        const type = document.getElementById('roomType').value;
        const sel = document.getElementById('roomSelect');
        sel.innerHTML = "";
        let start = (type === "Non-AC") ? 101 : (type === "AC") ? 201 : 301;
        for(let i=start; i<=start+99; i++) {
            let o = document.createElement('option');
            o.value = i; o.innerText = "Room " + i;
            sel.appendChild(o);
        }
        calculate();
    }

    function calculate() {
        const select = document.getElementById('roomType');
        const price = select.options[select.selectedIndex].getAttribute('data-price');
        const s = new Date(document.getElementById('inDate').value);
        const e = new Date(document.getElementById('outDate').value);
        if(s && e && e > s) {
            const diffDays = Math.ceil(Math.abs(e - s) / (1000 * 60 * 60 * 24)); 
            document.getElementById('totalAmt').value = (diffDays * price).toFixed(2);
        } else { 
            document.getElementById('totalAmt').value = "0.00"; 
        }
    }
</script>

</body>
</html>