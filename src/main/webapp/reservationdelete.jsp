<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.ReservationDAO, com.model.Reservation" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Grand Hotel | Delete Ticket</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; min-height: 100vh; }
        .centered-wrapper { min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 40px 20px; }
        .hotel-card { width: 100%; max-width: 600px; border-radius: 20px; border: none; box-shadow: 0 15px 35px rgba(0,0,0,0.08); background: #ffffff; }
        .card-header { padding: 2rem 1.5rem; border-radius: 20px 20px 0 0 !important; }
        .card-body { padding: 2.5rem !important; }
        
        /* Outline Button Style */
        .btn-outline-success { 
            border-width: 2px; 
            font-weight: 600; 
            padding: 12px; 
            border-radius: 10px;
            transition: 0.3s;
        }

        .back-link { color: #198754; text-decoration: none; font-weight: 500; transition: 0.3s; }
        .back-link:hover { color: #146c43; text-decoration: underline; }
        
        .preview-box {
            background-color: #f1f8f4;
            border-left: 6px solid #198754;
            border-radius: 12px;
            padding: 25px !important;
            margin: 25px 0;
        }
    </style>
</head>
<body>

    <div class="centered-wrapper">
        <div class="card hotel-card">
            <div class="card-header bg-success text-white text-center">
                <h3 class="fw-bold mb-1">🏨 Cancel Ticket</h3>
                <p class="mb-0 opacity-75">Verify details before removal</p>
            </div>
            
            <div class="card-body">
                <%
                    String sid = request.getParameter("searchId");
                    if (sid == null) sid = "";
                %>

                <form method="get" class="mb-5">
                    <label class="form-label fw-bold text-dark mb-2">Search by Ticket ID</label>
                    <div class="input-group">
                        <input type="number" name="searchId" class="form-control border-success" 
                               placeholder="Enter ID..." value="<%= sid %>" required>
                        <button class="btn btn-outline-success" type="submit">Find Ticket</button>
                    </div>
                </form>

                <%
                    if(!sid.isEmpty()) {
                        try {
                            Reservation r = new ReservationDAO().getById(Integer.parseInt(sid));
                            if(r != null) {
                %>
                        <div class="preview-box shadow-sm">
                            <h5 class="text-success fw-bold mb-4">Reservation Summary</h5>
                            <div class="row g-4">
                                <div class="col-6">
                                    <small class="text-muted d-block">Guest Name</small>
                                    <span class="fw-bold fs-5 text-dark"><%= r.getCustomerName() %></span>
                                </div>
                                <div class="col-6">
                                    <small class="text-muted d-block">Room Details</small>
                                    <span class="fw-bold text-dark">Room <%= r.getRoomNumber() %> (<%= r.getRoomType() %>)</span>
                                </div>
                                <div class="col-6">
                                    <small class="text-muted d-block">Stay Period</small>
                                    <span class="text-dark"><%= r.getCheckIn() %> to <%= r.getCheckOut() %></span>
                                </div>
                                <div class="col-6">
                                    <small class="text-muted d-block">Total Bill</small>
                                    <span class="fw-bold text-success fs-5">₹<%= r.getTotalAmount() %></span>
                                </div>
                            </div>
                        </div>

                        <button type="button" class="btn btn-outline-success w-100 mt-2" onclick="showDeleteModal()">
                            Delete Reservation
                        </button>
                        
                        <form id="deleteForm" action="deleteReservation" method="post">
                            <input type="hidden" name="id" value="<%= r.getReservationID() %>">
                        </form>
                <% 
                            } else { 
                %>
                            <div class="alert alert-light text-danger text-center border-danger py-3">
                                <strong>Error:</strong> Ticket #<%= sid %> not found.
                            </div>
                <% 
                            }
                        } catch (Exception e) { 
                %>
                            <div class="alert alert-danger">Error: <%= e.getMessage() %></div>
                <% 
                        }
                    } 
                %>
                
                <div class="text-center mt-5">
                    <a href="index.jsp" class="back-link">← Back to Dashboard</a>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content shadow-lg border-0" style="border-radius: 20px;">
                <div class="modal-body text-center p-5">
                    <h4 class="text-dark fw-bold mb-3">Delete Confirmation</h4>
                    <p class="text-muted mb-4">Are you sure to delete the ticket?</p>
                    <div class="d-flex justify-content-center gap-3">
                        <button type="button" class="btn btn-success px-5 py-2 fw-bold" onclick="executeDelete()">Yes, Delete</button>
                        <button type="button" class="btn btn-outline-secondary px-5 py-2" data-bs-dismiss="modal">No</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const delModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        function showDeleteModal() { delModal.show(); }
        function executeDelete() { document.getElementById('deleteForm').submit(); }
    </script>
</body>
</html>