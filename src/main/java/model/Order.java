package model;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

public class Order implements Serializable {
    private String id;
    private Date ngaytao;
    private double tongtien;
    private String trangthai;
    private Customer customer;
    private Employee employee;
    private List<OrderDetail> orderdetails;

    public Order() {}

    public Order(String id, Date ngaytao, double tongtien, String trangthai, Customer customer, Employee employee) {
        this.id = id;
        this.ngaytao = ngaytao;
        this.tongtien = tongtien;
        this.trangthai = trangthai;
        this.customer = customer;
        this.employee = employee;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getNgaytao() {
        return ngaytao;
    }

    public void setNgaytao(Date ngaytao) {
        this.ngaytao = ngaytao;
    }

    public double getTongtien() {
        return tongtien;
    }

    public void setTongtien(double tongtien) {
        this.tongtien = tongtien;
    }

    public String getTrangthai() {
        return trangthai;
    }

    public void setTrangthai(String trangthai) {
        this.trangthai = trangthai;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public List<OrderDetail> getOrderdetails() {
        return orderdetails;
    }

    public void setOrderdetails(List<OrderDetail> orderdetails) {
        this.orderdetails = orderdetails;
    }
}
