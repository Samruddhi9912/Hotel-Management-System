<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.ReservationDAO, com.model.Reservation" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Grand Hotel | Update Ticket</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; min-height: 100vh; }
        .centered-wrapper { min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        .hotel-card { width: 100%; max-width: 550px; border-radius: 15px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.1); overflow: hidden; background: white; }
        .card-header { padding: 1.5rem; border: none; }
        .form-label { font-weight: 600; color: #495057; font-size: 0.85rem; }
        .btn-outline-success { border-width: 2px; font-weight: 600; padding: 10px; transition: all 0.3s ease; }
        .back-link { color: #198754; text-decoration: none; font-weight: 500; font-size: 0.9rem; }
        .back-link:hover { text-decoration: underline; color: #146c43; }
    </style>
</head>
<body>

    <div class="centered-wrapper">
        <div class="card hotel-card">
            <div class="card-header bg-success text-white text-center">
                <h4 class="mb-0 fw-bold">🏨 Update Ticket</h4>
                <small class="opacity-75">Grand Hotel Management</small>
            </div>
            
            <div class="card-body p-4">
                <%
                    // Get the ID from the URL to keep it visible in the search box
                    String sid = request.getParameter("searchId");
                    if (sid == null) sid = ""; 
                %>

                <form method="get" class="mb-4">
                    <label class="form-label text-secondary">Search Ticket ID to Edit</label>
                    <div class="input-group">
                        <input type="number" name="searchId" class="form-control border-success" 
                               placeholder="Enter ID..." value="<%= sid %>" required>
                        <button class="btn btn-outline-success" type="submit">See Details</button>
                    </div>
                </form>

                <%
                    if(!sid.isEmpty()) {
                        Reservation r = new ReservationDAO().getById(Integer.parseInt(sid));
                        if(r != null) {
                %>
                        <hr class="text-success opacity-25">
                        <form id="updateForm" action="updateReservation" method="post">
                            <input type="hidden" name="id" value="<%= r.getReservationID() %>">
                            
                            <div class="mb-3">
                                <label class="form-label">Ticket ID</label>
                                <input type="text" class="form-control bg-light fw-bold" value="#<%= r.getReservationID() %>" readonly>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Guest Name</label>
                                <input type="text" name="name" value="<%= r.getCustomerName() %>" class="form-control" required>
                            </div>

                            <div class="row">
                                <div class="col-6 mb-3">
                                    <label class="form-label">Room Type</label>
                                    <select name="type" id="roomType" class="form-select" onchange="calculate()">
                                        <option value="Non-AC" data-price="1000" <%= r.getRoomType().equals("Non-AC")?"selected":"" %>>Non-AC</option>
                                        <option value="AC" data-price="3000" <%= r.getRoomType().equals("AC")?"selected":"" %>>AC</option>
                                        <option value="Deluxe" data-price="7000" <%= r.getRoomType().equals("Deluxe")?"selected":"" %>>Deluxe</option>
                                    </select>
                                </div>
                                <div class="col-6 mb-3">
                                    <label class="form-label">Room No.</label>
                                    <select name="room" id="roomSelect" class="form-select"></select>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-6">
                                    <label class="form-label">Check-In</label>
                                    <input type="date" name="in" id="inDate" value="<%= r.getCheckIn() %>" class="form-control" required onchange="calculate()">
                                </div>
                                <div class="col-6">
                                    <label class="form-label">Check-Out</label>
                                    <input type="date" name="out" id="outDate" value="<%= r.getCheckOut() %>" class="form-control" required onchange="calculate()">
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label text-success fw-bold">Total Amount (₹)</label>
                                <input type="number" name="amount" id="totalAmt" value="<%= r.getTotalAmount() %>" class="form-control bg-light fw-bold text-success fs-5" readonly>
                            </div>

                            <button type="button" class="btn btn-outline-success w-100 fw-bold" onclick="showModal()">
                                Save Changes
                            </button>
                        </form>
                        
                        <script>
                            const roomDropdown = document.getElementById('roomSelect');
                            const currentRoom = "<%= r.getRoomNumber() %>";
                            for(let i=101; i<=200; i++) {
                                let opt = document.createElement('option');
                                opt.value = i;
                                opt.innerText = "Room " + i;
                                if(i == currentRoom) opt.selected = true;
                                roomDropdown.appendChild(opt);
                            }
                        </script>
                <% 
                        } else { 
                %>
                        <div class="alert alert-warning text-center small py-2">Ticket #<%= sid %> not found.</div>
                <% 
                        }
                    } 
                %>
                
                <div class="text-center mt-4">
                    <a href="index.jsp" class="back-link">← Return to Dashboard</a>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="upModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content shadow-lg border-0" style="border-radius: 15px;">
                <div class="modal-body text-center p-5">
                    <h4 class="text-success fw-bold mb-3">Confirm Update?</h4>
                    <p class="text-muted mb-4">Save the new details for this ticket?</p>
                    <div class="d-flex justify-content-center gap-3">
                        <button type="button" class="btn btn-success px-5 py-2 fw-bold" onclick="document.getElementById('updateForm').submit()">Yes, Save</button>
                        <button type="button" class="btn btn-outline-secondary px-5 py-2" data-bs-dismiss="modal">No</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function calculate() {
            const roomType = document.getElementById('roomType');
            const price = roomType.options[roomType.selectedIndex].getAttribute('data-price');
            const d1 = new Date(document.getElementById('inDate').value);
            const d2 = new Date(document.getElementById('outDate').value);
            
            if(d1 && d2 && d2 > d1) {
                const diff = Math.ceil((d2 - d1) / (1000 * 3600 * 24));
                document.getElementById('totalAmt').value = diff * price;
            }
        }
        function showModal() { 
            if(document.getElementById('updateForm').checkValidity()) {
                new bootstrap.Modal(document.getElementById('upModal')).show(); 
            } else {
                document.getElementById('updateForm').reportValidity();
            }
        }
    </script>
</body>
</html>