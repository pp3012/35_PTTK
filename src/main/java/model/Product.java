package model;

import java.io.Serializable;

public class Product implements Serializable {
    private String id;
    private String name;
    private String mota;
    private double giagoc;
    private double giaban;
    private Category category;

    public Product() {}

    public Product(String id, String name, String mota, double giagoc, double giaban, Category category) {
        this.id = id;
        this.name = name;
        this.mota = mota;
        this.giagoc = giagoc;
        this.giaban = giaban;
        this.category = category;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getMota() { return mota; }
    public void setMota(String mota) { this.mota = mota; }

    public double getGiagoc() { return giagoc; }
    public void setGiagoc(double giagoc) { this.giagoc = giagoc; }

    public double getGiaban() { return giaban; }
    public void setGiaban(double giaban) { this.giaban = giaban; }

    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }
}
