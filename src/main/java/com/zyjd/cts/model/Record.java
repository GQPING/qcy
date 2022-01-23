package com.zyjd.cts.model;

// 车辆档案模型
public class Record {

    private String  vehicleNumber;// 车架号

    // 此字段可删除，未使用（废弃）
    private Integer onThePresent = 1;// 是否在厂，默认不在厂

    public Record() {
        super();
    }

    public Record(String vehicleNumber, Integer onThePresent) {
        super();
        this.vehicleNumber = vehicleNumber;
        this.onThePresent = onThePresent;
    }

    public Record(String vehicleNumber) {
        super();
        this.vehicleNumber = vehicleNumber;
    }

    public String getVehicleNumber() {
        return vehicleNumber;
    }

    public void setVehicleNumber(String vehicleNumber) {
        this.vehicleNumber = vehicleNumber;
    }

    public Integer getOnThePresent() {
        return onThePresent;
    }

    public void setOnThePresent(Integer onThePresent) {
        this.onThePresent = onThePresent;
    }

    @Override
    public String toString() {
        return "Record{" +
                "vehicleNumber='" + vehicleNumber + '\'' +
                ", onThePresent=" + onThePresent +
                '}';
    }
}
