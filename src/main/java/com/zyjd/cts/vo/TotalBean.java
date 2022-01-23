package com.zyjd.cts.vo;

/**
 * 主页汇总Bean
 */
public class TotalBean {

	// 数量统计
	private Integer totalContacts = 0; // 总合同数
	private Integer todayContacts = 0; // 今日合同数

	private Integer totalAgents = 0; // 代理合同数
	private Integer todayAgents = 0; // 今日代理数

	private Integer totalRents = 0; // 租赁合同数
	private Integer todayRents = 0; // 今日租赁数

	private Integer totalSales = 0; // 出售合同数
	private Integer todaySales = 0; // 今日出售数

	//销售额统计
	private Double totalQuotas = 0.0; // 总销售额
	private Double todayQuotas = 0.0; // 今日销售额

	private Double totalDiscounts = 0.0; // 总优惠额
	private Double todayDiscounts = 0.0; // 今日优惠额

	private Double totalHasQuotas = 0.0; // 总回款额
	private Double todayHasQuotas = 0.0; // 今日回款额

	private Double totalUnQuotas = 0.0; // 总欠账额
	private Double todayUnQuotas = 0.0; // 今日欠账额

	public Integer getTotalContacts() {
		return totalContacts;
	}

	public void setTotalContacts(Integer totalContacts) {
		this.totalContacts = totalContacts;
	}

	public Integer getTodayContacts() {
		return todayContacts;
	}

	public void setTodayContacts(Integer todayContacts) {
		this.todayContacts = todayContacts;
	}

	public Integer getTotalAgents() {
		return totalAgents;
	}

	public void setTotalAgents(Integer totalAgents) {
		this.totalAgents = totalAgents;
	}

	public Integer getTodayAgents() {
		return todayAgents;
	}

	public void setTodayAgents(Integer todayAgents) {
		this.todayAgents = todayAgents;
	}

	public Integer getTotalRents() {
		return totalRents;
	}

	public void setTotalRents(Integer totalRents) {
		this.totalRents = totalRents;
	}

	public Integer getTodayRents() {
		return todayRents;
	}

	public void setTodayRents(Integer todayRents) {
		this.todayRents = todayRents;
	}

	public Integer getTotalSales() {
		return totalSales;
	}

	public void setTotalSales(Integer totalSales) {
		this.totalSales = totalSales;
	}

	public Integer getTodaySales() {
		return todaySales;
	}

	public void setTodaySales(Integer todaySales) {
		this.todaySales = todaySales;
	}

	public Double getTotalQuotas() {
		return totalQuotas;
	}

	public void setTotalQuotas(Double totalQuotas) {
		this.totalQuotas = totalQuotas;
	}

	public Double getTodayQuotas() {
		return todayQuotas;
	}

	public void setTodayQuotas(Double todayQuotas) {
		this.todayQuotas = todayQuotas;
	}

	public Double getTotalHasQuotas() {
		return totalHasQuotas;
	}

	public void setTotalHasQuotas(Double totalHasQuotas) {
		this.totalHasQuotas = totalHasQuotas;
	}

	public Double getTodayHasQuotas() {
		return todayHasQuotas;
	}

	public void setTodayHasQuotas(Double todayHasQuotas) {
		this.todayHasQuotas = todayHasQuotas;
	}

	public Double getTotalDiscounts() {
		return totalDiscounts;
	}

	public void setTotalDiscounts(Double totalDiscounts) {
		this.totalDiscounts = totalDiscounts;
	}

	public Double getTodayDiscounts() {
		return todayDiscounts;
	}

	public void setTodayDiscounts(Double todayDiscounts) {
		this.todayDiscounts = todayDiscounts;
	}

	public Double getTotalUnQuotas() {
		return totalUnQuotas;
	}

	public void setTotalUnQuotas(Double totalUnQuotas) {
		this.totalUnQuotas = totalUnQuotas;
	}

	public Double getTodayUnQuotas() {
		return todayUnQuotas;
	}

	public void setTodayUnQuotas(Double todayUnQuotas) {
		this.todayUnQuotas = todayUnQuotas;
	}

	@Override
	public String toString() {
		return "TotalBean{" +
				"totalContacts=" + totalContacts +
				", todayContacts=" + todayContacts +
				", totalAgents=" + totalAgents +
				", todayAgents=" + todayAgents +
				", totalRents=" + totalRents +
				", todayRents=" + todayRents +
				", totalSales=" + totalSales +
				", todaySales=" + todaySales +
				", totalQuotas=" + totalQuotas +
				", todayQuotas=" + todayQuotas +
				", totalHasQuotas=" + totalHasQuotas +
				", todayHasQuotas=" + todayHasQuotas +
				", totalDiscounts=" + totalDiscounts +
				", todayDiscounts=" + todayDiscounts +
				", totalUnQuotas=" + totalUnQuotas +
				", todayUnQuotas=" + todayUnQuotas +
				'}';
	}
}
