package com.zyjd.cts.model;

// 联系人模型
public class Contact extends Base{

	private Integer id;// 联系人ID

	private Integer customerID;// 客户ID

	private String contactPerson;// 联系人名称

	private String contactPhone;// 联系人电话

	private String contactAddress;// 联系人地址

	private String contactRemarkDescription;// 联系人备注
	
	private Customer customer = new Customer();// 关联客户

	public Contact() {
		super();
	}

	public Contact(Integer customerID) {
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

	public String getContactPerson() {
		return contactPerson;
	}

	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}

	public String getContactPhone() {
		return contactPhone;
	}

	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}

	public String getContactAddress() {
		return contactAddress;
	}

	public void setContactAddress(String contactAddress) {
		this.contactAddress = contactAddress;
	}

	public String getContactRemarkDescription() {
		return contactRemarkDescription;
	}

	public void setContactRemarkDescription(String contactRemarkDescription) {
		this.contactRemarkDescription = contactRemarkDescription;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	@Override
	public String toString() {
		return "Contact{" +
				"id=" + id +
				", customerID=" + customerID +
				", contactPerson='" + contactPerson + '\'' +
				", contactPhone='" + contactPhone + '\'' +
				", contactAddress='" + contactAddress + '\'' +
				", contactRemarkDescription='" + contactRemarkDescription + '\'' +
				", customer=" + customer +
				'}';
	}
}
