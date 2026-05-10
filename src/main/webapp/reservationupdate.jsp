<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.ReservationDAO, com.model.Reservation" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hotel | Update Reservation</title>
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

        /* Constant Theme: Thin green border on hover */
        .form-control, .form-select {
            border-radius: 12px; padding: 12px; border: 1px solid #dee2e6; 
            background-color: #fcfcfc; font-weight: 600; transition: 0.3s; color: #444;
        }
        .form-control:hover, .form-select:hover { border-color: #198754; }
        .form-control:focus, .form-select:focus {
            border: 1px solid #198754; background-color: white; outline: none; box-shadow: none;
        }

        .btn-action {
            background-color: white; color: #198754; border: 1.5px solid #198754;
            font-weight: 600; padding: 12px; border-radius: 12px; transition: 0.3s;
        }
        .btn-action:hover { background-color: #198754; color: white; }

        /* Amount is black but maintains constant weight */
        .amount-black { color: #000 !important; }

        .modal-content { 
            border-radius: 30px; border: 1px solid transparent; padding: 30px; 
            box-shadow: 0 10px 40px rgba(0,0,0,0.1); transition: 0.3s;
        }
        .modal-content:hover { border-color: #198754; }
        .modal-title-custom { color: #198754; font-weight: bold; font-size: 1.5rem; margin-bottom: 15px; }

        .btn-modal-yes { 
            background-color: white; color: #198754; border: 1.5px solid #198754;
            border-radius: 12px; width: 120px; font-weight: 600; padding: 10px; transition: 0.3s;
        }
        .btn-modal-yes:hover { background-color: #198754 !important; color: white !important; }

        .btn-modal-no { 
            background-color: white; color: #666; border: 1px solid #ddd;
            border-radius: 12px; width: 120px; font-weight: 600; padding: 10px; transition: 0.3s;
        }
        .btn-modal-no:hover { background-color: #666 !important; color: white !important; }

        .dash-link { color: #198754; text-decoration: none; font-weight: 600; }
        .dash-link:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="container">
    <div class="hotel-card">
        <h3 class="page-title">UPDATE RESERVATION</h3>
        
        <%
            String sid = request.getParameter("searchId");
            if (sid == null) sid = ""; 
        %>

        <!-- Search Section -->
        <form method="get" class="mb-4">
            <label class="form-label">Enter Ticket ID to Fetch Details</label>
            <div class="input-group">
                <input type="number" name="searchId" class="form-control" 
                       placeholder="Ex: 101" value="<%= sid %>" required>
                <button class="btn btn-action" type="submit" style="border-top-left-radius: 0; border-bottom-left-radius: 0;">FETCH</button>
            </div>
        </form>

        <%
            if(!sid.isEmpty()) {
                Reservation r = new ReservationDAO().getById(Integer.parseInt(sid));
                if(r != null) {
        %>
                <hr style="border-top: 1px solid #eee; margin: 30px 0;">
                
                <form id="updateForm" action="updateReservation" method="post">
                    <input type="hidden" name="id" value="<%= r.getReservationID() %>">
                    
                    <div class="mb-3">
                        <label class="form-label">Ticket ID</label>
                        <input type="text" class="form-control" style="background-color: #f8f9fa;" value="#<%= r.getReservationID() %>" readonly>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Guest Name</label>
                        <input type="text" name="name" value="<%= r.getCustomerName() %>" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Guest Address</label>
                        <textarea name="address" class="form-control" rows="2" required><%= r.getGuestAddress() %></textarea>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Room Type</label>
                            <select name="type" id="roomType" class="form-select" onchange="calculate()">
                                <option value="Non-AC" data-price="1000" <%= r.getRoomType().equals("Non-AC")?"selected":"" %>>Non-AC (₹1000)</option>
                                <option value="AC" data-price="3000" <%= r.getRoomType().equals("AC")?"selected":"" %>>AC (₹3000)</option>
                                <option value="Deluxe" data-price="7000" <%= r.getRoomType().equals("Deluxe")?"selected":"" %>>Deluxe (₹7000)</option>
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
                            <input type="date" name="in" id="inDate" value="<%= r.getCheckIn() %>" class="form-control" required onchange="calculate()">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Check-Out</label>
                            <input type="date" name="out" id="outDate" value="<%= r.getCheckOut() %>" class="form-control" required onchange="calculate()">
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Updated Total (₹)</label>
                        <input type="text" name="amount" id="totalAmt" value="<%= String.format("%.2f", r.getTotalAmount()) %>" 
                               class="form-control amount-black" style="background-color: #f8f9fa;" readonly>
                    </div>

                    <button type="button" class="btn btn-action w-100" onclick="showConfirm()">SAVE CHANGES</button>
                </form>
        <% 
                } else { 
        %>
                <div class="alert mt-3 text-center" style="border-radius:12px; background: #fff5f5; color: #c0392b; border: 1px solid #fbcaca;">
                    Ticket ID <strong>#<%= sid %></strong> not found.
                </div>
        <% 
                }
            } 
        %>
        
        <div class="text-center mt-4">
            <a href="index.jsp" class="dash-link">← Return to Dashboard</a>
        </div>
    </div>
</div>

<!-- Confirm Modal -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body text-center">
                <h4 class="modal-title-custom">Update Reservation?</h4>
                <p class="text-muted" style="font-weight: 500;">Are you sure you want to save the new details for this ticket?</p>
                <div class="d-flex justify-content-center gap-3 mt-4">
                    <button type="button" class="btn-modal-yes" onclick="submitForm()">YES</button>
                    <button type="button" class="btn-modal-no" data-bs-dismiss="modal">NO</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const roomDropdown = document.getElementById('roomSelect');
    const roomTypeDropdown = document.getElementById('roomType');
    const currentRoom = "<%= (request.getParameter("searchId") != null) ? "FETCHED" : "" %>"; 
    // Note: In a real scenario, you'd pass the specific room ID from Java to JS variable here.
    
    function populateRooms() {
        if(!roomTypeDropdown) return;
        const selectedType = roomTypeDropdown.value;
        let start, end;

        if (selectedType === "Non-AC") { start = 101; end = 200; }
        else if (selectedType === "AC") { start = 201; end = 300; }
        else if (selectedType === "Deluxe") { start = 301; end = 400; }

        roomDropdown.innerHTML = "";
        for (let i = start; i <= end; i++) {
            let opt = document.createElement('option');
            opt.value = i;
            opt.innerText = "Room " + i;
            // Matches stored room number on first load
            <% if (request.getParameter("searchId") != null) { 
                 Reservation r2 = new ReservationDAO().getById(Integer.parseInt(request.getParameter("searchId")));
                 if(r2 != null) { %>
                    if (i == "<%= r2.getRoomNumber() %>") opt.selected = true;
            <%   } 
               } %>
            roomDropdown.appendChild(opt);
        }
    }

    function calculate() {
        const price = roomTypeDropdown.options[roomTypeDropdown.selectedIndex].getAttribute('data-price');
        const d1 = new Date(document.getElementById('inDate').value);
        const d2 = new Date(document.getElementById('outDate').value);
        
        populateRooms(); // Dynamic room update

        if (d1 && d2 && d2 > d1) {
            const diff = Math.ceil((d2 - d1) / (1000 * 3600 * 24));
            document.getElementById('totalAmt').value = (diff * price).toFixed(2);
        }
    }

    function showConfirm() {
        const form = document.getElementById('updateForm');
        if (form.checkValidity()) {
            new bootstrap.Modal(document.getElementById('confirmModal')).show();
        } else {
            form.reportValidity();
        }
    }

    function submitForm() {
        document.getElementById('updateForm').submit();
    }

    // Auto-load rooms when details are fetched
    window.onload = populateRooms;
</script>

</body>
</html>