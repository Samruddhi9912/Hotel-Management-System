package com.dao;
import java.sql.*;
import java.util.*;
import com.model.Reservation;

public class ReservationDAO {
    private String url = "jdbc:mysql://localhost:3306/hotel_db";
    private String user = "root"; 
    private String pass = ""; // Update this!

    protected Connection getConnection() throws SQLException {
        try { Class.forName("com.mysql.cj.jdbc.Driver"); } catch (Exception e) {}
        return DriverManager.getConnection(url, user, pass);
    }

    public void addReservation(Reservation r) throws SQLException {
        String sql = "INSERT INTO Reservations VALUES (?,?,?,?,?,?)";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, r.getReservationID()); ps.setString(2, r.getCustomerName());
            ps.setString(3, r.getRoomNumber()); ps.setDate(4, r.getCheckIn());
            ps.setDate(5, r.getCheckOut()); ps.setDouble(6, r.getTotalAmount());
            ps.executeUpdate();
        }
    }

    public void updateReservation(Reservation r) throws SQLException {
        String sql = "UPDATE Reservations SET CustomerName=?, RoomNumber=?, CheckIn=?, CheckOut=?, TotalAmount=? WHERE ReservationID=?";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, r.getCustomerName()); ps.setString(2, r.getRoomNumber());
            ps.setDate(3, r.getCheckIn()); ps.setDate(4, r.getCheckOut());
            ps.setDouble(5, r.getTotalAmount()); ps.setInt(6, r.getReservationID());
            ps.executeUpdate();
        }
    }

    public void deleteReservation(int id) throws SQLException {
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement("DELETE FROM Reservations WHERE ReservationID=?")) {
            ps.setInt(1, id); ps.executeUpdate();
        }
    }

    public List<Reservation> getAll() throws SQLException {
        List<Reservation> list = new ArrayList<>();
        try (Connection c = getConnection(); Statement st = c.createStatement(); 
             ResultSet rs = st.executeQuery("SELECT * FROM Reservations")) {
            while(rs.next()) list.add(new Reservation(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDate(4), rs.getDate(5), rs.getDouble(6)));
        }
        return list;
    }

    public List<Reservation> getByDateRange(String start, String end) throws SQLException {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM Reservations WHERE CheckIn BETWEEN ? AND ?";
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, start); ps.setString(2, end);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) list.add(new Reservation(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDate(4), rs.getDate(5), rs.getDouble(6)));
        }
        return list;
    }
}