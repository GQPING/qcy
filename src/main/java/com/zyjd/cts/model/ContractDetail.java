package com.zyjd.cts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

// 合同明细模型
public class ContractDetail extends Base{
	
	private Integer id;// 合同明细ID
	
	private Integer contractID;// 合同ID

	private Date exportDate;// 出库日期

	private String vehicleNumber;// 车架号

	private String projectAddress;// 项目地址

	private String productMode;// 产品型号

	private Double productPrice;// 价格

	private Double productDeposit;// 押金

	private String supplyDescription;// 耗材

	private Date startDate;// 开始日期

	private Date finalDate;// 结束日期

	private Double dateCycle;// 周期

	private Double canPayQuota;// 应收

	private Double productDiscount;// 优惠

	private Double hasPayQuota;// 已收

	private Double unPayQuota;// 未收

	private String payState;// 付款状态

	private String salePerson;// 售后人员

	private Integer hasBill;// 是否开票

	private Integer payRemindDays;// 到期提醒

	private String contractDetailRemarkDescription;//合同明细备注

	private Contract contract = new Contract();// 关联合同

	private List<Bill> bills = new ArrayList<Bill>();// 开票信息

	private List<Cashing> cashs = new ArrayList<Cashing>();// 收款信息

	private List<Stage> stages = new ArrayList<Stage>();// 分期信息

	private List<VehicleDetail> vehicleDetails = new ArrayList<VehicleDetail>();// 车辆信息(限代理商类型)

	public ContractDetail() {
		super();
	}
	
	public ContractDetail(Integer contractID) {
		super();
		this.contractID = contractID;
	}

	public ContractDetail(Date exportDate) {
		super();
		this.exportDate = exportDate;
	}

	public ContractDetail(String vehicleNumber) {
		this.vehicleNumber = vehicleNumber;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getContractID() {
		return contractID;
	}

	public void setContractID(Integer contractID) {
		this.contractID = contractID;
	}

	public Date getExportDate() {
		return exportDate;
	}

	public void setExportDate(Date exportDate) {
		this.exportDate = exportDate;
	}

	public String getVehicleNumber() {
		return vehicleNumber;
	}

	public void setVehicleNumber(String vehicleNumber) {
		this.vehicleNumber = vehicleNumber;
	}

	public String getProjectAddress() {
		return projectAddress;
	}

	public void setProjectAddress(String projectAddress) {
		this.projectAddress = projectAddress;
	}

	public String getProductMode() {
		return productMode;
	}

	public void setProductMode(String productMode) {
		this.productMode = productMode;
	}

	public Double getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(Double productPrice) {
		this.productPrice = productPrice;
	}

	public Double getProductDeposit() {
		return productDeposit;
	}

	public void setProductDeposit(Double productDeposit) {
		this.productDeposit = productDeposit;
	}

	public String getSupplyDescription() {
		return supplyDescription;
	}

	public void setSupplyDescription(String supplyDescription) {
		this.supplyDescription = supplyDescription;
	}

	public String getSalePerson() {
		return salePerson;
	}

	public void setSalePerson(String salePerson) {
		this.salePerson = salePerson;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getFinalDate() {
		return finalDate;
	}

	public void setFinalDate(Date finalDate) { this.finalDate = finalDate; }

	public Double getDateCycle() {
		return dateCycle;
	}

	public void setDateCycle(Double dateCycle) {
		this.dateCycle = dateCycle;
	}

	public Double getCanPayQuota() {
		return canPayQuota;
	}

	public void setCanPayQuota(Double canPayQuota) {
		this.canPayQuota = canPayQuota;
	}

	public Double getProductDiscount() {
		return productDiscount;
	}

	public void setProductDiscount(Double productDiscount) {
		this.productDiscount = productDiscount;
	}

	public Double getHasPayQuota() {
		return hasPayQuota;
	}

	public void setHasPayQuota(Double hasPayQuota) {
		this.hasPayQuota = hasPayQuota;
	}

	public Double getUnPayQuota() {
		return unPayQuota;
	}

	public void setUnPayQuota(Double unPayQuota) {
		this.unPayQuota = unPayQuota;
	}

	public String getPayState() {
		return payState;
	}

	public void setPayState(String payState) {
		this.payState = payState;
	}

	public Integer getHasBill() {
		return hasBill;
	}

	public void setHasBill(Integer hasBill) {
		this.hasBill = hasBill;
	}

	public Integer getPayRemindDays() {
		return payRemindDays;
	}

	public void setPayRemindDays(Integer payRemindDays) {
		this.payRemindDays = payRemindDays;
	}

	public String getContractDetailRemarkDescription() {
		return contractDetailRemarkDescription;
	}

	public void setContractDetailRemarkDescription(String contractDetailRemarkDescription) { this.contractDetailRemarkDescription = contractDetailRemarkDescription; }

	public Contract getContract() {
		return contract;
	}

	public void setContract(Contract contract) {
		this.contract = contract;
	}

	public List<Bill> getBills() {
		return bills;
	}

	public void setBills(List<Bill> bills) {
		this.bills = bills;
	}

	public List<Cashing> getCashs() {
		return cashs;
	}

	public void setCashs(List<Cashing> cashs) {
		this.cashs = cashs;
	}

	public List<Stage> getStages() {
		return stages;
	}

	public void setStages(List<Stage> stages) {
		this.stages = stages;
	}

	public List<VehicleDetail> getVehicleDetails() { return vehicleDetails; }

	public void setVehicleDetails(List<VehicleDetail> vehicleDetails) { this.vehicleDetails = vehicleDetails; }

	@Override
	public String toString() {
		return "ContractDetail{" +
				"id=" + id +
				", contractID=" + contractID +
				", exportDate=" + exportDate +
				", vehicleNumber='" + vehicleNumber + '\'' +
				", projectAddress='" + projectAddress + '\'' +
				", productMode='" + productMode + '\'' +
				", productPrice=" + productPrice +
				", productDeposit=" + productDeposit +
				", supplyDescription='" + supplyDescription + '\'' +
				", salePerson='" + salePerson + '\'' +
				", startDate=" + startDate +
				", finalDate=" + finalDate +
				", dateCycle=" + dateCycle +
				", canPayQuota=" + canPayQuota +
				", productDiscount=" + productDiscount +
				", hasPayQuota=" + hasPayQuota +
				", unPayQuota=" + unPayQuota +
				", payState='" + payState + '\'' +
				", hasBill=" + hasBill +
				", payRemindDays=" + payRemindDays +
				", contractDetailRemarkDescription='" + contractDetailRemarkDescription + '\'' +
				", contract=" + contract +
				", bills=" + bills +
				", cashs=" + cashs +
				", stages=" + stages +
				", vehicleDetails=" + vehicleDetails +
				'}';
	}
}