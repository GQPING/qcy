package com.zyjd.cts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

// 客户模型
public class Customer extends Base{

	private Integer id;// 客户ID

	private String customerName;// 客户名称

	private Integer customerLevel;// 客户星级

	private Date customerCreateDate;// 创建日期

	private String customerRemarkDescription;// 客户备注

	private List<Visit> visits = new ArrayList<Visit>();// 回访信息

	private List<Bill> bills = new ArrayList<Bill>();// 开票信息

	private List<Contact> contacts = new ArrayList<Contact>();// 联系人信息
	
	private List<Contract> contracts = new ArrayList<Contract>();// 合同信息

	private List<Cashing> cashs = new ArrayList<Cashing>();// 收款信息

	private List<Stage> stages = new ArrayList<Stage>();// 分期信息

	private List<ContractDetail> contractDetails = new ArrayList<ContractDetail>();// 合同明细信息

	public Customer() {
		super();
	}

	public Customer(String customerName) {
		this.customerName = customerName;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public Integer getCustomerLevel() {
		return customerLevel;
	}

	public void setCustomerLevel(Integer customerLevel) {
		this.customerLevel = customerLevel;
	}

	public Date getCustomerCreateDate() {
		return customerCreateDate;
	}

	public void setCustomerCreateDate(Date customerCreateDate) {
		this.customerCreateDate = customerCreateDate;
	}

	public String getCustomerRemarkDescription() {
		return customerRemarkDescription;
	}

	public void setCustomerRemarkDescription(String customerRemarkDescription) { this.customerRemarkDescription = customerRemarkDescription; }

	public List<Visit> getVisits() {
		return visits;
	}

	public void setVisits(List<Visit> visits) {
		this.visits = visits;
	}

	public List<Bill> getBills() {
		return bills;
	}

	public void setBills(List<Bill> bills) {
		this.bills = bills;
	}

	public List<Contact> getContacts() {
		return contacts;
	}

	public void setContacts(List<Contact> contacts) {
		this.contacts = contacts;
	}

	public List<Contract> getContracts() {
		return contracts;
	}

	public void setContracts(List<Contract> contracts) {
		this.contracts = contracts;
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
		return "Customer{" +
				"id=" + id +
				", customerName='" + customerName + '\'' +
				", customerLevel=" + customerLevel +
				", customerCreateDate=" + customerCreateDate +
				", customerRemarkDescription='" + customerRemarkDescription + '\'' +
				", visits=" + visits +
				", bills=" + bills +
				", contacts=" + contacts +
				", contracts=" + contracts +
				", cashs=" + cashs +
				", stages=" + stages +
				", contractDetails=" + contractDetails +
				'}';
	}
}