package com.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.model.Reservation;

public class ReservationDAO {
    // Database credentials
    private String url = "jdbc:mysql://localhost:3306/hotel_db";
    private String user = "root"; 
    private String pass = "password"; 

    // Establish Connection
    protected Connection getConnection() throws SQLException {
        try { 
            Class.forName("com.mysql.cj.jdbc.Driver"); 
        } catch (ClassNotFoundException e) { 
            e.printStackTrace(); 
        }
        return DriverManager.getConnection(url, user, pass);
    }

    // --- CREATE ---
    public void addReservation(Reservation r) throws SQLException {
        String sql = "INSERT INTO Reservations (CustomerName, GuestAddress, RoomNumber, RoomType, CheckIn, CheckOut, TotalAmount) VALUES (?,?,?,?,?,?,?)";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, r.getCustomerName());
            ps.setString(2, r.getGuestAddress());
            ps.setString(3, r.getRoomNumber());
            ps.setString(4, r.getRoomType());
            ps.setDate(5, r.getCheckIn());
            ps.setDate(6, r.getCheckOut());
            ps.setDouble(7, r.getTotalAmount());
            ps.executeUpdate();
        }
    }

    // --- READ ALL ---
    public List<Reservation> getAllReservations() throws SQLException {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM Reservations";
        try (Connection c = getConnection(); Statement st = c.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(extractReservation(rs));
            }
        }
        return list;
    }

    // --- READ BY ID (New Method) ---
    public Reservation getById(int id) throws SQLException {
        Reservation reservation = null;
        String sql = "SELECT * FROM Reservations WHERE ReservationID = ?";
        
        try (Connection c = getConnection(); 
             PreparedStatement ps = c.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    reservation = extractReservation(rs);
                }
            }
        }
        return reservation;
    }

    // --- UPDATE ---
    public void updateReservation(Reservation r) throws SQLException {
        String sql = "UPDATE Reservations SET CustomerName=?, GuestAddress=?, RoomNumber=?, RoomType=?, CheckIn=?, CheckOut=?, TotalAmount=? WHERE ReservationID=?";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, r.getCustomerName());
            ps.setString(2, r.getGuestAddress());
            ps.setString(3, r.getRoomNumber());
            ps.setString(4, r.getRoomType());
            ps.setDate(5, r.getCheckIn());
            ps.setDate(6, r.getCheckOut());
            ps.setDouble(7, r.getTotalAmount());
            ps.setInt(8, r.getReservationID());
            ps.executeUpdate();
        }
    }

    // --- DELETE ---
    public void deleteReservation(int id) throws SQLException {
        String sql = "DELETE FROM Reservations WHERE ReservationID = ?";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // --- REPORTING METHODS ---
    public List<Reservation> getByType(String type) throws SQLException {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM Reservations WHERE RoomType = ?";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, type);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(extractReservation(rs));
        }
        return list;
    }

    public List<Reservation> getByDateRange(String start, String end) throws SQLException {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM Reservations WHERE CheckIn BETWEEN ? AND ? ORDER BY CheckIn ASC";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setDate(1, java.sql.Date.valueOf(start));
            ps.setDate(2, java.sql.Date.valueOf(end));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(extractReservation(rs));
        }
        return list;
    }

    public int getBookedCountByType(String type) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Reservations WHERE RoomType = ?";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, type);
            ResultSet rs = ps.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        }
    }
    
    // Logic for Add Reservation page to show the next available ID
    public int getNextReservationId() {
        int nextId = 1; 
        String sql = "SELECT COALESCE(MAX(ReservationID), 0) + 1 FROM Reservations";
        
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                nextId = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace(); 
        }
        return nextId;
    }
    
    // --- HELPER METHOD (Extracts data from DB row to Object) ---
    private Reservation extractReservation(ResultSet rs) throws SQLException {
        return new Reservation(
            rs.getInt("ReservationID"),
            rs.getString("CustomerName"),
            rs.getString("GuestAddress"),
            rs.getString("RoomNumber"),
            rs.getString("RoomType"),
            rs.getDate("CheckIn"),
            rs.getDate("CheckOut"),
            rs.getDouble("TotalAmount")
        );
    }
}