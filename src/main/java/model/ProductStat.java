package model;

public class ProductStat extends Product {
    private int tongsoluong;
    private double tongdoanhthu;

    public ProductStat() {
        super();
    }

    public ProductStat(int tongsoluong, double tongdoanhthu) {
        super();
        this.tongsoluong = tongsoluong;
        this.tongdoanhthu = tongdoanhthu;
    }

    public int getTongsoluong() {
        return tongsoluong;
    }

    public void setTongsoluong(int tongsoluong) {
        this.tongsoluong = tongsoluong;
    }

    public double getTongdoanhthu() {
        return tongdoanhthu;
    }

    public void setTongdoanhthu(double tongdoanhthu) {
        this.tongdoanhthu = tongdoanhthu;
    }
}
