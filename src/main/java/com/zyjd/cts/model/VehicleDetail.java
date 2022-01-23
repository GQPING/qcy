package com.zyjd.cts.model;

// 代理车辆模型
public class VehicleDetail extends Base{

    private Integer id;// 记录ID

    private Integer contractDetailID;// 合同明细ID

    private String vehicleMode;// 车辆型号

    private Integer vehicleVolume;// 车辆数量

    private Double vehiclePrice;// 车辆价格

    private String vehicleDescription;// 车辆备注

    private ContractDetail contractDetail = new ContractDetail();// 关联合同明细

    public VehicleDetail() {
        super();
    }

    public VehicleDetail(Integer contractDetailID) {
        this.contractDetailID = contractDetailID;
    }

    public VehicleDetail(String vehicleMode) {
        this.vehicleMode = vehicleMode;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getContractDetailID() {
        return contractDetailID;
    }

    public void setContractDetailID(Integer contractDetailID) {
        this.contractDetailID = contractDetailID;
    }

    public String getVehicleMode() {
        return vehicleMode;
    }

    public void setVehicleMode(String vehicleMode) {
        this.vehicleMode = vehicleMode;
    }

    public Integer getVehicleVolume() {
        return vehicleVolume;
    }

    public void setVehicleVolume(Integer vehicleVolume) {
        this.vehicleVolume = vehicleVolume;
    }

    public Double getVehiclePrice() {
        return vehiclePrice;
    }

    public void setVehiclePrice(Double vehiclePrice) {
        this.vehiclePrice = vehiclePrice;
    }

    public String getVehicleDescription() {
        return vehicleDescription;
    }

    public void setVehicleDescription(String vehicleDescription) {
        this.vehicleDescription = vehicleDescription;
    }

    public ContractDetail getContractDetail() {
        return contractDetail;
    }

    public void setContractDetail(ContractDetail contractDetail) {
        this.contractDetail = contractDetail;
    }

    @Override
    public String toString() {
        return "vehicleDetail{" +
                "id=" + id +
                ", contractDetailID=" + contractDetailID +
                ", vehicleMode='" + vehicleMode + '\'' +
                ", vehicleVolume=" + vehicleVolume +
                ", vehiclePrice=" + vehiclePrice +
                ", vehicleDescription='" + vehicleDescription + '\'' +
                ", contractDetail=" + contractDetail +
                '}';
    }
}
