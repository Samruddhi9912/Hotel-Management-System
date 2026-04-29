package com.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.model.Reservation;

public class ReservationDAO {
    // Database connection details - update these to match your setup
    private String url = "jdbc:mysql://localhost:3306/hotel_db";
    private String user = "root"; 
    private String pass = "password"; 

    protected Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(url, user, pass);
    }

    // 1. Get Next Available ID for Display
    public int getNextId() throws SQLException {
        String sql = "SELECT MAX(ReservationID) FROM Reservations";
        try (Connection c = getConnection(); Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1) + 1;
            }
        }
        return 1;
    }

    // 2. Check if a specific Room + Type is booked for given dates
    public boolean isRoomBooked(String room, String type, java.sql.Date in, java.sql.Date out) throws SQLException {
        // Logic: Overlap exists if (RequestedIn < ExistingOut) AND (RequestedOut > ExistingIn)
        String sql = "SELECT COUNT(*) FROM Reservations WHERE RoomNumber=? AND RoomType=? AND NOT (CheckOut <= ? OR CheckIn >= ?)";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, room);
            ps.setString(2, type);
            ps.setDate(3, in);
            ps.setDate(4, out);
            ResultSet rs = ps.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        }
    }

    // 3. Create: Add a new reservation
    public void addReservation(Reservation r) throws SQLException {
        String sql = "INSERT INTO Reservations (CustomerName, RoomNumber, RoomType, CheckIn, CheckOut, TotalAmount) VALUES (?,?,?,?,?,?)";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, r.getCustomerName());
            ps.setString(2, r.getRoomNumber());
            ps.setString(3, r.getRoomType());
            ps.setDate(4, r.getCheckIn());
            ps.setDate(5, r.getCheckOut());
            ps.setDouble(6, r.getTotalAmount());
            ps.executeUpdate();
        }
    }

    // 4. Read: Get all reservations (sorted by Room Type)
    public List<Reservation> getAll() throws SQLException {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM Reservations ORDER BY RoomType, RoomNumber";
        try (Connection c = getConnection(); Statement st = c.createStatement(); 
             ResultSet rs = st.executeQuery(sql)) {
            while(rs.next()) {
                list.add(extractReservation(rs));
            }
        }
        return list;
    }

    // 5. Read: Get single reservation by ID (for Update/Delete previews)
    public Reservation getById(int id) throws SQLException {
        String sql = "SELECT * FROM Reservations WHERE ReservationID=?";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) return extractReservation(rs);
        }
        return null;
    }

    // 6. Update: Modify existing record
    public void updateReservation(Reservation r) throws SQLException {
        String sql = "UPDATE Reservations SET CustomerName=?, RoomNumber=?, RoomType=?, CheckIn=?, CheckOut=?, TotalAmount=? WHERE ReservationID=?";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, r.getCustomerName());
            ps.setString(2, r.getRoomNumber());
            ps.setString(3, r.getRoomType());
            ps.setDate(4, r.getCheckIn());
            ps.setDate(5, r.getCheckOut());
            ps.setDouble(6, r.getTotalAmount());
            ps.setInt(7, r.getReservationID());
            ps.executeUpdate();
        }
    }

    // 7. Delete: Remove a record
    public void deleteReservation(int id) throws SQLException {
        String sql = "DELETE FROM Reservations WHERE ReservationID=?";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // 8. Report: Get data by date range
    public List<Reservation> getByDateRange(String start, String end) throws SQLException {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM Reservations WHERE CheckIn BETWEEN ? AND ? ORDER BY CheckIn ASC";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setDate(1, java.sql.Date.valueOf(start));
            ps.setDate(2, java.sql.Date.valueOf(end));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractReservation(rs));
            }
        }
        return list;
    }

    // Helper method to reduce code duplication
    private Reservation extractReservation(ResultSet rs) throws SQLException {
        return new Reservation(
            rs.getInt("ReservationID"),
            rs.getString("CustomerName"),
            rs.getString("RoomNumber"),
            rs.getString("RoomType"),
            rs.getDate("CheckIn"),
            rs.getDate("CheckOut"),
            rs.getDouble("TotalAmount")
        );
    }
}