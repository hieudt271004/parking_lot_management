package model;

public class Xe {
    private String maXe;
    private String bienSo;
    private String loaiXe;

    public Xe() {
    }

    public Xe(String maXe, String bienSo, String loaiXe) {
        this.maXe = maXe;
        this.bienSo = bienSo;
        this.loaiXe = loaiXe;
    }

    public String getMaXe() {
        return maXe;
    }

    public void setMaXe(String maXe) {
        this.maXe = maXe;
    }

    public String getBienSo() {
        return bienSo;
    }

    public void setBienSo(String bienSo) {
        this.bienSo = bienSo;
    }

    public String getLoaiXe() {
        return loaiXe;
    }

    public void setLoaiXe(String loaiXe) {
        this.loaiXe = loaiXe;
    }

    @Override
    public String toString() {
        return "Xe{" +
                "maXe='" + maXe + '\'' +
                ", bienSo='" + bienSo + '\'' +
                ", loaiXe='" + loaiXe + '\'' +
                '}';
    }
}
