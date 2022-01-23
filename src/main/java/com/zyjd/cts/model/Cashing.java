package com.zyjd.cts.model;

import java.util.Date;

// 收款模型
public class Cashing extends Base{

	private Integer id;// 收款ID

	private Integer contractDetailID;// 合同明细ID

	private Integer stageID;// 分期ID

	private String payType;// 付款类型

	private String payPerson;// 付款人

	private Double payQuota;// 付款金额

	private Date payDate;// 付款日期

	private String cashRemarkDescription;// 付款备注

	private Stage stage = new Stage();// 关联分期
	
	private ContractDetail contractDetail = new ContractDetail();// 关联合同明细

	public Cashing() {
		super();
	}

	public Cashing(Integer contractDetailID) {
		this.contractDetailID = contractDetailID;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getPayDate() {
		return payDate;
	}

	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public Double getPayQuota() {
		return payQuota;
	}

	public void setPayQuota(Double payQuota) {
		this.payQuota = payQuota;
	}

	public Integer getStageID() {
		return stageID;
	}

	public void setStageID(Integer stageID) {
		this.stageID = stageID;
	}

	public String getPayPerson() {
		return payPerson;
	}

	public void setPayPerson(String payPerson) {
		this.payPerson = payPerson;
	}

	public Integer getContractDetailID() {
		return contractDetailID;
	}

	public void setContractDetailID(Integer contractDetailID) {
		this.contractDetailID = contractDetailID;
	}

	public String getCashRemarkDescription() {
		return cashRemarkDescription;
	}

	public void setCashRemarkDescription(String cashRemarkDescription) { this.cashRemarkDescription = cashRemarkDescription; }

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
		return "Cashing{" +
				"id=" + id +
				", payDate=" + payDate +
				", payType=" + payType +
				", payQuota=" + payQuota +
				", stageID=" + stageID +
				", payPerson=" + payPerson +
				", contractDetailID=" + contractDetailID +
				", cashRemarkDescription='" + cashRemarkDescription + '\'' +
				", stage=" + stage +
				", contractDetail=" + contractDetail +
				'}';
	}
}