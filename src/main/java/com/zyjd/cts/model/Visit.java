package com.zyjd.cts.model;

import java.util.Date;

// 回访模型
public class Visit extends Base{

	private Integer id;// 回访ID

	private Integer customerID;// 客户ID

	private Date exportDate;// 出库日期

	private String productMode;// 产品型号

	private String projectAddress;// 项目地址

	private String description;// 回访信息

	private Date visitCreateDate;// 创建日期

	private String visitRemarkDescription;// 回访备注
	
	private Customer customer = new Customer();// 关联客户

	public Visit() {
		super();
	}
	
	public Visit(Integer customerID) {
		super();
		this.customerID = customerID;
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

	public Date getExportDate() {
		return exportDate;
	}

	public void setExportDate(Date exportDate) {
		this.exportDate = exportDate;
	}

	public String getProductMode() {
		return productMode;
	}

	public void setProductMode(String productMode) {
		this.productMode = productMode;
	}

	public String getProjectAddress() {
		return projectAddress;
	}

	public void setProjectAddress(String projectAddress) {
		this.projectAddress = projectAddress;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getVisitCreateDate() {
		return visitCreateDate;
	}

	public void setVisitCreateDate(Date visitCreateDate) {
		this.visitCreateDate = visitCreateDate;
	}

	public String getVisitRemarkDescription() {
		return visitRemarkDescription;
	}

	public void setVisitRemarkDescription(String visitRemarkDescription) {
		this.visitRemarkDescription = visitRemarkDescription;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	@Override
	public String toString() {
		return "Visit{" +
				"id=" + id +
				", customerID=" + customerID +
				", exportDate=" + exportDate +
				", productMode='" + productMode + '\'' +
				", projectAddress='" + projectAddress + '\'' +
				", description='" + description + '\'' +
				", visitCreateDate=" + visitCreateDate +
				", visitRemarkDescription='" + visitRemarkDescription + '\'' +
				", customer=" + customer +
				'}';
	}
}