package model;

import java.util.List;

public class Customer extends User {
    private String diachi;
    private List<Order> orders;

    public Customer() {
        super();
        setRole("CUSTOMER");
    }

    public Customer(String diachi) {
        super();
        this.diachi = diachi;
        setRole("CUSTOMER");
    }

    public String getDiachi() {
        return diachi;
    }

    public void setDiachi(String diachi) {
        this.diachi = diachi;
    }

    public List<Order> getOrders() {
        return orders;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }
}
