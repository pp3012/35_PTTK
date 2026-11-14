package model;

public class Employee extends User {
    private String chucvu;

    public Employee() {
        super();
    }

    public Employee(String chucvu) {
        super();
        this.chucvu = chucvu;
    }

    public String getChucvu() {
        return chucvu;
    }

    public void setChucvu(String chucvu) {
        this.chucvu = chucvu;
    }
}
