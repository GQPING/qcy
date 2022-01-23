package com.zyjd.cts.model;

import java.util.Date;

// 开票模型
public class Bill extends Base{

	private Integer id;// 开票ID

	private Integer contractDetailID;// 合同明细ID

	private Integer stageID;// 分期ID

	private String billType;//开票类型
	
	private Double billQuota;// 开票金额

	private Date billDate;// 开票日期

	private String billRemarkDescription;// 开票备注

	private Stage stage = new Stage();// 关联分期

	private ContractDetail contractDetail = new ContractDetail();// 关联合同明细

	public Bill() {
		super();
	}

	public Bill(Integer contractDetailID) {
		this.contractDetailID = contractDetailID;
	}

	public Integer getStageID() {
		return stageID;
	}

	public void setStageID(Integer stageID) {
		this.stageID = stageID;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getBillDate() {
		return billDate;
	}

	public void setBillDate(Date billDate) {
		this.billDate = billDate;
	}

	public String getBillType() {
		return billType;
	}

	public void setBillType(String billType) {
		this.billType = billType;
	}

	public Double getBillQuota() {
		return billQuota;
	}

	public void setBillQuota(Double billQuota) {
		this.billQuota = billQuota;
	}

	public Integer getContractDetailID() {
		return contractDetailID;
	}

	public void setContractDetailID(Integer contractDetailID) {
		this.contractDetailID = contractDetailID;
	}

	public String getBillRemarkDescription() {
		return billRemarkDescription;
	}

	public void setBillRemarkDescription(String billRemarkDescription) {
		this.billRemarkDescription = billRemarkDescription;
	}

	public Stage getStage() {
		return stage;
	}

	public void setStage(Stage stage) {
		this.stage = stage;
	}

	public ContractDetail getContractDetail() {
		return contractDetail;
	}

	public void setContractDetail(ContractDetail contractDetail) {
		this.contractDetail = contractDetail;
	}

	@Override
	public String toString() {
		return "Bill{" +
				"id=" + id +
				", contractDetailID=" + contractDetailID +
				", stageID=" + stageID +
				", billType='" + billType + '\'' +
				", billQuota=" + billQuota +
				", billDate=" + billDate +
				", billRemarkDescription='" + billRemarkDescription + '\'' +
				", stage=" + stage +
				", contractDetail=" + contractDetail +
				'}';
	}
}
