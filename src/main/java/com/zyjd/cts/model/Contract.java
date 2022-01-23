package com.zyjd.cts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

// 合同模型
public class Contract extends Base{
	
	private Integer id;// 合同ID
	
	private Integer customerID;// 客户ID
	
    private String contractNumber;// 合同编号

	private Date signDate;// 签订日期
    
    private String contractType;// 合同类型

	private String marketPerson;// 市场人员
    
    private String contractPayBank;// 收款银行

	private String contractState;// 合同状态

	private String contractRemarkDescription;//合同备注

    private Customer customer = new Customer();// 关联客户

	private List<Bill> bills = new ArrayList<Bill>();// 开票列表

	private List<Cashing> cashs = new ArrayList<Cashing>();// 收款列表

	private List<Stage> stages = new ArrayList<Stage>();// 分期列表

	private List<ContractDetail> contractDetails = new ArrayList<ContractDetail>();// 合同明细列表

	public Contract() {
		super();
	}

	public Contract(Date signDate) {
		super();
		this.signDate = signDate;
	}
	
	public Contract(Integer customerID) {
		super();
		this.customerID = customerID;
	}

	public Contract(String contractNumber) {
		this.contractNumber = contractNumber;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getCustomerID() {
		return customerID;
	}

	public void setCustomerID(Integer customerID) {
		this.customerID = customerID;
	}

	public String getContractNumber() {
		return contractNumber;
	}

	public void setContractNumber(String contractNumber) {
		this.contractNumber = contractNumber;
	}

	public Date getSignDate() {
		return signDate;
	}

	public void setSignDate(Date signDate) {
		this.signDate = signDate;
	}

	public String getContractType() {
		return contractType;
	}

	public void setContractType(String contractType) {
		this.contractType = contractType;
	}

	public String getMarketPerson() {
		return marketPerson;
	}

	public void setMarketPerson(String marketPerson) {
		this.marketPerson = marketPerson;
	}

	public String getContractPayBank() {
		return contractPayBank;
	}

	public void setContractPayBank(String contractPayBank) {
		this.contractPayBank = contractPayBank;
	}

	public String getContractState() { return contractState; }

	public void setContractState(String contractState) { this.contractState = contractState; }

	public String getContractRemarkDescription() {
		return contractRemarkDescription;
	}

	public void setContractRemarkDescription(String contractRemarkDescription) { this.contractRemarkDescription = contractRemarkDescription; }

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
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

	public List<ContractDetail> getContractDetails() {
		return contractDetails;
	}

	public void setContractDetails(List<ContractDetail> contractDetails) {
		this.contractDetails = contractDetails;
	}

	@Override
	public String toString() {
		return "Contract{" +
				"id=" + id +
				", customerID=" + customerID +
				", contractNumber='" + contractNumber + '\'' +
				", signDate=" + signDate +
				", contractType='" + contractType + '\'' +
				", marketPerson='" + marketPerson + '\'' +
				", contractPayBank='" + contractPayBank + '\'' +
				", contractState='" + contractState + '\'' +
				", contractRemarkDescription='" + contractRemarkDescription + '\'' +
				", customer=" + customer +
				", bills=" + bills +
				", cashs=" + cashs +
				", stages=" + stages +
				", contractDetails=" + contractDetails +
				'}';
	}
}