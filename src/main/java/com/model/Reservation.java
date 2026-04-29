package com.model;
import java.sql.Date;

public class Reservation {
    private int reservationID;
    private String customerName;
    private String roomNumber;
    private String roomType; 
    private Date checkIn;
    private Date checkOut;
    private double totalAmount;

    public Reservation() {}
    public Reservation(int id, String name, String room, String type, Date in, Date out, double amount) {
        this.reservationID = id;
        this.customerName = name;
        this.roomNumber = room;
        this.roomType = type;
        this.checkIn = in;
        this.checkOut = out;
        this.totalAmount = amount;
    }

    public int getReservationID() { return reservationID; }
    public void setReservationID(int id) { this.reservationID = id; }
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String name) { this.customerName = name; }
    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String room) { this.roomNumber = room; }
    public String getRoomType() { return roomType; }
    public void setRoomType(String type) { this.roomType = type; }
    public Date getCheckIn() { return checkIn; }
    public void setCheckIn(Date in) { this.checkIn = in; }
    public Date getCheckOut() { return checkOut; }
    public void setCheckOut(Date out) { this.checkOut = out; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double amount) { this.totalAmount = amount; }
}