<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.ReservationDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Grand Hotel | Add Ticket</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; min-height: 100vh; }
        .centered-wrapper { min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        .hotel-card { width: 100%; max-width: 550px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); border: none; background: white; }
        .card-header { border-radius: 15px 15px 0 0 !important; padding: 1.5rem; }
        .form-label { font-weight: 600; font-size: 0.85rem; color: #495057; }
        
        /* Standardizing Input appearance */
        .form-control, .form-select {
            border: 1px solid #ced4da;
            padding: 10px;
            border-radius: 8px;
        }

        /* The Outline Button requested */
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
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="centered-wrapper">
        <div class="card hotel-card">
            <div class="card-header bg-success text-white text-center">
                <h4 class="mb-0 fw-bold">🏨 Grand Hotel</h4>
                <small class="opacity-75">New Reservation Ticket</small>
            </div>
            <div class="card-body p-4">
                <% 
                    int nextId = 1;
                    try { nextId = new ReservationDAO().getNextId(); } catch(Exception e) {}
                    if(request.getParameter("error") != null) { 
                %>
                    <div class="alert alert-danger py-2 small text-center">Room already booked for these dates!</div>
                <% } %>
                
                <form id="addForm" action="addReservation" method="post">
                    <div class="mb-3">
                        <label class="form-label">Ticket ID</label>
                        <input type="text" class="form-control bg-light fw-bold text-secondary" value="#<%= nextId %>" readonly>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Guest Name</label>
                        <input type="text" name="name" class="form-control" placeholder="Enter guest name" required>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Room Type</label>
                            <select name="type" id="roomType" class="form-select" onchange="calculate()">
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
                            <input type="date" name="in" id="inDate" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Check-Out</label>
                            <input type="date" name="out" id="outDate" class="form-control" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label text-success fw-bold">Total Amount (₹)</label>
                        <input type="number" name="amount" id="totalAmt" class="form-control bg-light fw-bold text-success fs-5" value="0" readonly>
                    </div>

                    <button type="button" class="btn btn-outline-success w-100" onclick="showModal()">
                        Book Ticket
                    </button>

                    <div class="text-center mt-3">
                        <a href="index.jsp" class="back-link">← Return to Dashboard</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="confirmModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content shadow-lg border-0" style="border-radius: 15px;">
                <div class="modal-body text-center p-5">
                    <h4 class="text-success fw-bold mb-3">Confirm Ticket?</h4>
                    <p class="text-muted mb-4">Do you want to confirm this booking ticket?</p>
                    <div class="d-flex justify-content-center gap-3">
                        <button type="button" class="btn btn-success px-5 py-2 fw-bold" onclick="submitForm()">Yes</button>
                        <button type="button" class="btn btn-outline-secondary px-5 py-2" data-bs-dismiss="modal">No</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Populate Rooms
        const sel = document.getElementById('roomSelect');
        for(let i=101; i<=200; i++) { let o = document.createElement('option'); o.value=i; o.innerText="Room "+i; sel.appendChild(o); }

        // Date Restrictions
        const today = new Date().toISOString().split('T')[0];
        const inInput = document.getElementById('inDate');
        const outInput = document.getElementById('outDate');
        inInput.setAttribute('min', today);
        outInput.setAttribute('min', today);

        inInput.addEventListener('change', () => {
            outInput.setAttribute('min', inInput.value);
            calculate();
        });
        outInput.addEventListener('change', calculate);

        function calculate() {
            const p = document.getElementById('roomType').options[document.getElementById('roomType').selectedIndex].getAttribute('data-price');
            const s = new Date(inInput.value);
            const e = new Date(outInput.value);
            if(s && e && e > s) {
                document.getElementById('totalAmt').value = Math.ceil((e-s)/(1000*3600*24)) * p;
            } else {
                document.getElementById('totalAmt').value = 0;
            }
        }

        function showModal() { 
            if(document.getElementById('addForm').checkValidity()) {
                new bootstrap.Modal(document.getElementById('confirmModal')).show(); 
            } else {
                document.getElementById('addForm').reportValidity();
            }
        }
        function submitForm() { document.getElementById('addForm').submit(); }
    </script>
</body>
</html>