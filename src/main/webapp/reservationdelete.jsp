<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.ReservationDAO, com.model.Reservation" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hotel | Cancel Reservation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; font-family: 'Segoe UI', sans-serif; }
        
        /* Main Card Vibe */
        .hotel-card { 
            max-width: 600px; margin: 50px auto; border-radius: 30px; 
            background-color: white; padding: 40px; border: 1px solid transparent; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.05); transition: 0.3s ease-out;
        }
        .hotel-card:hover { border-color: #198754; transform: translateY(-5px); }

        .page-title { color: #198754; font-weight: bold; margin-bottom: 30px; text-align: center; }
        .form-label { font-weight: 600; color: #444; font-size: 0.85rem; text-transform: uppercase; }

        /* Input Vibe: Thin green border on hover */
        .form-control {
            border-radius: 12px; padding: 12px; border: 1px solid #dee2e6; 
            background-color: #fcfcfc; font-weight: 600; transition: 0.3s; color: #444;
        }
        .form-control:hover { border-color: #198754; }
        .form-control:focus {
            border: 1px solid #198754; background-color: white; outline: none; box-shadow: none;
        }

        /* Consistent Action Button */
        .btn-action {
            background-color: white; color: #198754; border: 1.5px solid #198754;
            font-weight: 600; padding: 12px; border-radius: 12px; transition: 0.3s;
        }
        .btn-action:hover { background-color: #198754; color: white; }

        /* Preview Box Vibe */
        .preview-box {
            background-color: #fcfcfc;
            border: 1px solid #eee;
            border-radius: 20px;
            padding: 25px;
            margin: 25px 0;
            transition: 0.3s;
        }
        .preview-box:hover { border-color: #198754; }

        /* Modal Vibe */
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
        
        .info-label { font-size: 0.75rem; color: #888; text-transform: uppercase; letter-spacing: 1px; }
        .info-value { color: #333; font-weight: 600; display: block; }
    </style>
</head>
<body>

<div class="container">
    <div class="hotel-card">
        <h3 class="page-title">CANCEL RESERVATION</h3>
        
        <%
            String sid = request.getParameter("searchId");
            if (sid == null) sid = "";
        %>

        <form method="get" class="mb-4">
            <label class="form-label">Search Ticket ID to Cancel</label>
            <div class="input-group">
                <input type="number" name="searchId" class="form-control" 
                       placeholder="Ex: 101" value="<%= sid %>" required>
                <button class="btn btn-action" type="submit" style="border-top-left-radius: 0; border-bottom-left-radius: 0;">FETCH</button>
            </div>
        </form>

        <%
            if(!sid.isEmpty()) {
                try {
                    Reservation r = new ReservationDAO().getById(Integer.parseInt(sid));
                    if(r != null) {
        %>
                <div class="preview-box">
                    <h6 class="text-success fw-bold mb-4">RESERVATION SUMMARY</h6>
                    <div class="row g-4">
                        <div class="col-6">
                            <span class="info-label">Guest Name</span>
                            <span class="info-value fs-5"><%= r.getCustomerName() %></span>
                        </div>
                        <div class="col-6">
                            <span class="info-label">Room Details</span>
                            <span class="info-value">Room #<%= r.getRoomNumber() %> (<%= r.getRoomType() %>)</span>
                        </div>
                        <div class="col-6">
                            <span class="info-label">Check In</span>
                            <span class="info-value"><%= r.getCheckIn() %></span>
                        </div>
                        <div class="col-6">
                            <span class="info-label">Check Out</span>
                            <span class="info-value"><%= r.getCheckOut() %></span>
                        </div>
                        <div class="col-12 mt-3 pt-3 border-top">
                            <span class="info-label">Total Amount</span>
                            <span class="info-value fs-4 text-dark">₹<%= r.getTotalAmount() %></span>
                        </div>
                    </div>
                </div>

                <button type="button" class="btn btn-action w-100" onclick="showDeleteModal()">
                    DELETE RESERVATION
                </button>
                
                <form id="deleteForm" action="deleteReservation" method="post">
                    <input type="hidden" name="id" value="<%= r.getReservationID() %>">
                </form>
        <% 
                    } else { 
        %>
                    <div class="alert mt-3 text-center" style="border-radius:12px; background: #fff5f5; color: #c0392b; border: 1px solid #fbcaca;">
                        Ticket ID <strong>#<%= sid %></strong> not found.
                    </div>
        <% 
                    }
                } catch (Exception e) { 
        %>
                    <div class="alert alert-danger mt-3" style="border-radius:12px;">Error connecting to database.</div>
        <% 
                }
            } 
        %>
        
        <div class="text-center mt-4">
            <a href="index.jsp" class="dash-link">← Return to Dashboard</a>
        </div>
    </div>
</div>

<!-- Modal stays green-themed now -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body text-center">
                <h4 class="modal-title-custom">Confirm Deletion?</h4>
                <p class="text-muted" style="font-weight: 500;">Are you sure you want to permanently remove this ticket from the system?</p>
                <div class="d-flex justify-content-center gap-3 mt-4">
                    <button type="button" class="btn-modal-yes" onclick="executeDelete()">YES</button>
                    <button type="button" class="btn-modal-no" data-bs-dismiss="modal">NO</button>
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