package com.zyjd.cts.vo;

/**
 * 数量汇总Bean
 */
public class UnitsBean {

	// 合同统计
	private Integer totalContacts = 0;         // 总合同数*
	private Integer totalInPayContacts = 0;    // 已结清款
	private Integer totalUnPayContacts = 0;    // 未结清款
	private Integer totalEndInPayContacts = 0; // 到期已清
	private Integer totalEndUnPayContacts = 0; // 到期未清
	
	private Integer agentContacts = 0;         // 代理合同*
	private Integer agentInPayContacts = 0;    // 已结清款
	private Integer agentUnPayContacts = 0;    // 未结清款
	private Integer agentEndInPayContacts = 0; // 到期已清
	private Integer agentEndUnPayContacts = 0; // 到期未清
	
	private Integer salesContacts = 0;         // 出售合同*
	private Integer salesInPayContacts = 0;    // 已结清款
	private Integer salesUnPayContacts = 0;    // 未结清款
	private Integer salesEndInPayContacts = 0; // 到期已清
	private Integer salesEndUnPayContacts = 0; // 到期未清

	private Integer rentContacts = 0;          // 租赁合同*
	private Integer rentInPayContacts = 0;     // 已结清款
	private Integer rentUnPayContacts = 0;     // 未结清款
	private Integer rentEndInPayContacts = 0;  // 到期已清
	private Integer rentEndUnPayContacts = 0;  // 到期未清

    // 车辆统计
	private Integer totalVehicles = 0;         // 总车辆数
	private Integer totalInPayVehicles = 0;    // 已结清款
	private Integer totalUnPayVehicles = 0;    // 未结清款
	private Integer totalEndInPayVehicles = 0; // 到期已清
	private Integer totalEndUnPayVehicles = 0; // 到期未清
	
	private Integer salesVehicles = 0;         // 出售车辆*
	private Integer salesInPayVehicles = 0;    // 已结清款*
	private Integer salesUnPayVehicles = 0;    // 未结清款*
	private Integer salesEndInPayVehicles = 0; // 到期已清*
	private Integer salesEndUnPayVehicles = 0; // 到期未清*

	private Integer rentsVehicles = 0;         // 租赁车辆*
	private Integer rentsInPayVehicles = 0;    // 已结清款*
	private Integer rentsUnPayVehicles = 0;    // 未结清款*
	private Integer rentsEndInPayVehicles = 0; // 到期已清*
	private Integer rentsEndUnPayVehicles = 0; // 到期未清*

	public Integer getTotalContacts() {
		return totalContacts;
	}

	public void setTotalContacts(Integer totalContacts) {
		this.totalContacts = totalContacts;
	}

	public Integer getTotalInPayContacts() {
		return totalInPayContacts;
	}

	public void setTotalInPayContacts(Integer totalInPayContacts) {
		this.totalInPayContacts = totalInPayContacts;
	}

	public Integer getTotalUnPayContacts() {
		return totalUnPayContacts;
	}

	public void setTotalUnPayContacts(Integer totalUnPayContacts) {
		this.totalUnPayContacts = totalUnPayContacts;
	}

	public Integer getTotalEndInPayContacts() {
		return totalEndInPayContacts;
	}

	public void setTotalEndInPayContacts(Integer totalEndInPayContacts) {
		this.totalEndInPayContacts = totalEndInPayContacts;
	}

	public Integer getTotalEndUnPayContacts() {
		return totalEndUnPayContacts;
	}

	public void setTotalEndUnPayContacts(Integer totalEndUnPayContacts) {
		this.totalEndUnPayContacts = totalEndUnPayContacts;
	}

	public Integer getAgentContacts() {
		return agentContacts;
	}

	public void setAgentContacts(Integer agentContacts) {
		this.agentContacts = agentContacts;
	}

	public Integer getAgentInPayContacts() {
		return agentInPayContacts;
	}

	public void setAgentInPayContacts(Integer agentInPayContacts) {
		this.agentInPayContacts = agentInPayContacts;
	}

	public Integer getAgentUnPayContacts() {
		return agentUnPayContacts;
	}

	public void setAgentUnPayContacts(Integer agentUnPayContacts) {
		this.agentUnPayContacts = agentUnPayContacts;
	}

	public Integer getAgentEndInPayContacts() {
		return agentEndInPayContacts;
	}

	public void setAgentEndInPayContacts(Integer agentEndInPayContacts) {
		this.agentEndInPayContacts = agentEndInPayContacts;
	}

	public Integer getAgentEndUnPayContacts() {
		return agentEndUnPayContacts;
	}

	public void setAgentEndUnPayContacts(Integer agentEndUnPayContacts) {
		this.agentEndUnPayContacts = agentEndUnPayContacts;
	}

	public Integer getSalesContacts() {
		return salesContacts;
	}

	public void setSalesContacts(Integer salesContacts) {
		this.salesContacts = salesContacts;
	}

	public Integer getSalesInPayContacts() {
		return salesInPayContacts;
	}

	public void setSalesInPayContacts(Integer salesInPayContacts) {
		this.salesInPayContacts = salesInPayContacts;
	}

	public Integer getSalesUnPayContacts() {
		return salesUnPayContacts;
	}

	public void setSalesUnPayContacts(Integer salesUnPayContacts) {
		this.salesUnPayContacts = salesUnPayContacts;
	}

	public Integer getSalesEndInPayContacts() {
		return salesEndInPayContacts;
	}

	public void setSalesEndInPayContacts(Integer salesEndInPayContacts) {
		this.salesEndInPayContacts = salesEndInPayContacts;
	}

	public Integer getSalesEndUnPayContacts() {
		return salesEndUnPayContacts;
	}

	public void setSalesEndUnPayContacts(Integer salesEndUnPayContacts) {
		this.salesEndUnPayContacts = salesEndUnPayContacts;
	}

	public Integer getRentContacts() {
		return rentContacts;
	}

	public void setRentContacts(Integer rentContacts) {
		this.rentContacts = rentContacts;
	}

	public Integer getRentInPayContacts() {
		return rentInPayContacts;
	}

	public void setRentInPayContacts(Integer rentInPayContacts) {
		this.rentInPayContacts = rentInPayContacts;
	}

	public Integer getRentUnPayContacts() {
		return rentUnPayContacts;
	}

	public void setRentUnPayContacts(Integer rentUnPayContacts) {
		this.rentUnPayContacts = rentUnPayContacts;
	}

	public Integer getRentEndInPayContacts() {
		return rentEndInPayContacts;
	}

	public void setRentEndInPayContacts(Integer rentEndInPayContacts) {
		this.rentEndInPayContacts = rentEndInPayContacts;
	}

	public Integer getRentEndUnPayContacts() {
		return rentEndUnPayContacts;
	}

	public void setRentEndUnPayContacts(Integer rentEndUnPayContacts) {
		this.rentEndUnPayContacts = rentEndUnPayContacts;
	}

	public Integer getTotalVehicles() {
		return totalVehicles;
	}

	public void setTotalVehicles(Integer totalVehicles) {
		this.totalVehicles = totalVehicles;
	}

	public Integer getTotalInPayVehicles() {
		return totalInPayVehicles;
	}

	public void setTotalInPayVehicles(Integer totalInPayVehicles) {
		this.totalInPayVehicles = totalInPayVehicles;
	}

	public Integer getTotalUnPayVehicles() {
		return totalUnPayVehicles;
	}

	public void setTotalUnPayVehicles(Integer totalUnPayVehicles) {
		this.totalUnPayVehicles = totalUnPayVehicles;
	}

	public Integer getTotalEndInPayVehicles() {
		return totalEndInPayVehicles;
	}

	public void setTotalEndInPayVehicles(Integer totalEndInPayVehicles) {
		this.totalEndInPayVehicles = totalEndInPayVehicles;
	}

	public Integer getTotalEndUnPayVehicles() {
		return totalEndUnPayVehicles;
	}

	public void setTotalEndUnPayVehicles(Integer totalEndUnPayVehicles) {
		this.totalEndUnPayVehicles = totalEndUnPayVehicles;
	}

	public Integer getSalesVehicles() {
		return salesVehicles;
	}

	public void setSalesVehicles(Integer salesVehicles) {
		this.salesVehicles = salesVehicles;
	}

	public Integer getSalesInPayVehicles() {
		return salesInPayVehicles;
	}

	public void setSalesInPayVehicles(Integer salesInPayVehicles) {
		this.salesInPayVehicles = salesInPayVehicles;
	}

	public Integer getSalesUnPayVehicles() {
		return salesUnPayVehicles;
	}

	public void setSalesUnPayVehicles(Integer salesUnPayVehicles) {
		this.salesUnPayVehicles = salesUnPayVehicles;
	}

	public Integer getSalesEndInPayVehicles() {
		return salesEndInPayVehicles;
	}

	public void setSalesEndInPayVehicles(Integer salesEndInPayVehicles) {
		this.salesEndInPayVehicles = salesEndInPayVehicles;
	}

	public Integer getSalesEndUnPayVehicles() {
		return salesEndUnPayVehicles;
	}

	public void setSalesEndUnPayVehicles(Integer salesEndUnPayVehicles) {
		this.salesEndUnPayVehicles = salesEndUnPayVehicles;
	}

	public Integer getRentsVehicles() {
		return rentsVehicles;
	}

	public void setRentsVehicles(Integer rentsVehicles) {
		this.rentsVehicles = rentsVehicles;
	}

	public Integer getRentsInPayVehicles() {
		return rentsInPayVehicles;
	}

	public void setRentsInPayVehicles(Integer rentsInPayVehicles) {
		this.rentsInPayVehicles = rentsInPayVehicles;
	}

	public Integer getRentsUnPayVehicles() {
		return rentsUnPayVehicles;
	}

	public void setRentsUnPayVehicles(Integer rentsUnPayVehicles) {
		this.rentsUnPayVehicles = rentsUnPayVehicles;
	}

	public Integer getRentsEndInPayVehicles() {
		return rentsEndInPayVehicles;
	}

	public void setRentsEndInPayVehicles(Integer rentsEndInPayVehicles) {
		this.rentsEndInPayVehicles = rentsEndInPayVehicles;
	}

	public Integer getRentsEndUnPayVehicles() {
		return rentsEndUnPayVehicles;
	}

	public void setRentsEndUnPayVehicles(Integer rentsEndUnPayVehicles) {
		this.rentsEndUnPayVehicles = rentsEndUnPayVehicles;
	}

	@Override
	public String toString() {
		return "UnitsBean{" +
				"totalContacts=" + totalContacts +
				", totalInPayContacts=" + totalInPayContacts +
				", totalUnPayContacts=" + totalUnPayContacts +
				", totalEndInPayContacts=" + totalEndInPayContacts +
				", totalEndUnPayContacts=" + totalEndUnPayContacts +
				", agentContacts=" + agentContacts +
				", agentInPayContacts=" + agentInPayContacts +
				", agentUnPayContacts=" + agentUnPayContacts +
				", agentEndInPayContacts=" + agentEndInPayContacts +
				", agentEndUnPayContacts=" + agentEndUnPayContacts +
				", salesContacts=" + salesContacts +
				", salesInPayContacts=" + salesInPayContacts +
				", salesUnPayContacts=" + salesUnPayContacts +
				", salesEndInPayContacts=" + salesEndInPayContacts +
				", salesEndUnPayContacts=" + salesEndUnPayContacts +
				", rentContacts=" + rentContacts +
				", rentInPayContacts=" + rentInPayContacts +
				", rentUnPayContacts=" + rentUnPayContacts +
				", rentEndInPayContacts=" + rentEndInPayContacts +
				", rentEndUnPayContacts=" + rentEndUnPayContacts +
				", totalVehicles=" + totalVehicles +
				", totalInPayVehicles=" + totalInPayVehicles +
				", totalUnPayVehicles=" + totalUnPayVehicles +
				", totalEndInPayVehicles=" + totalEndInPayVehicles +
				", totalEndUnPayVehicles=" + totalEndUnPayVehicles +
				", salesVehicles=" + salesVehicles +
				", salesInPayVehicles=" + salesInPayVehicles +
				", salesUnPayVehicles=" + salesUnPayVehicles +
				", salesEndInPayVehicles=" + salesEndInPayVehicles +
				", salesEndUnPayVehicles=" + salesEndUnPayVehicles +
				", rentsVehicles=" + rentsVehicles +
				", rentsInPayVehicles=" + rentsInPayVehicles +
				", rentsUnPayVehicles=" + rentsUnPayVehicles +
				", rentsEndInPayVehicles=" + rentsEndInPayVehicles +
				", rentsEndUnPayVehicles=" + rentsEndUnPayVehicles +
				'}';
	}
}
