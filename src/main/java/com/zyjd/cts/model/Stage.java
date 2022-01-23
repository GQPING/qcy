package com.zyjd.cts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

// 分期模型
public class Stage extends Base{

	private Integer id;// 分期ID

	private Integer contractDetailID;// 合同明细ID

	private Date stageStartDate;// 分期开始日期

	private Date stageEndDate;// 分期结束日期

	private String stageDateCycle;// 分期周期

	private Double stageCanPayQuota;// 分期应收

	private Double stageBadPayQuota;// 分期坏账

	private Double stageHasPayQuota;// 分期已收

	private Double stageUnPayQuota;// 分期未收

	private String stagePayState;// 分期状态

	private Integer stageHasBill;// 是否开票

	private Integer stagePayRemindDays;// 分期提醒

	private String stageRemarkDescription;// 分期备注
	
	private ContractDetail contractDetail = new ContractDetail();// 关联合同明细

	private List<Cashing> cashs = new ArrayList<Cashing>();// 分期收款信息

	private List<Bill> bills = new ArrayList<Bill>();// 分期开票信息

	public Stage() {
		super();
	}

	public Stage(Integer contractDetailID) {
		this.contractDetailID = contractDetailID;
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

	public Date getStageStartDate() {
		return stageStartDate;
	}

	public void setStageStartDate(Date stageStartDate) {
		this.stageStartDate = stageStartDate;
	}

	public Date getStageEndDate() {
		return stageEndDate;
	}

	public void setStageEndDate(Date stageEndDate) {
		this.stageEndDate = stageEndDate;
	}

	public String getStageDateCycle() {
		return stageDateCycle;
	}

	public void setStageDateCycle(String stageDateCycle) {
		this.stageDateCycle = stageDateCycle;
	}

	public Double getStageCanPayQuota() {
		return stageCanPayQuota;
	}

	public void setStageCanPayQuota(Double stageCanPayQuota) {
		this.stageCanPayQuota = stageCanPayQuota;
	}

	public Double getStageBadPayQuota() {
		return stageBadPayQuota;
	}

	public void setStageBadPayQuota(Double stageBadPayQuota) {
		this.stageBadPayQuota = stageBadPayQuota;
	}

	public Double getStageHasPayQuota() {
		return stageHasPayQuota;
	}

	public void setStageHasPayQuota(Double stageHasPayQuota) {
		this.stageHasPayQuota = stageHasPayQuota;
	}

	public Double getStageUnPayQuota() {
		return stageUnPayQuota;
	}

	public void setStageUnPayQuota(Double stageUnPayQuota) {
		this.stageUnPayQuota = stageUnPayQuota;
	}

	public String getStagePayState() {
		return stagePayState;
	}

	public void setStagePayState(String stagePayState) {
		this.stagePayState = stagePayState;
	}

	public String getStageRemarkDescription() {
		return stageRemarkDescription;
	}

	public void setStageRemarkDescription(String stageRemarkDescription) { this.stageRemarkDescription = stageRemarkDescription; }

	public ContractDetail getContractDetail() {
		return contractDetail;
	}

	public void setContractDetail(ContractDetail contractDetail) {
		this.contractDetail = contractDetail;
	}

	public List<Cashing> getCashs() {
		return cashs;
	}

	public void setCashs(List<Cashing> cashs) {
		this.cashs = cashs;
	}

	public List<Bill> getBills() {
		return bills;
	}

	public void setBills(List<Bill> bills) {
		this.bills = bills;
	}

	public Integer getStageHasBill() {
		return stageHasBill;
	}

	public void setStageHasBill(Integer stageHasBill) {
		this.stageHasBill = stageHasBill;
	}

	public Integer getStagePayRemindDays() {
		return stagePayRemindDays;
	}

	public void setStagePayRemindDays(Integer stagePayRemindDays) {
		this.stagePayRemindDays = stagePayRemindDays;
	}

	@Override
	public String toString() {
		return "Stage{" +
				"id=" + id +
				", contractDetailID=" + contractDetailID +
				", stageStartDate=" + stageStartDate +
				", stageEndDate=" + stageEndDate +
				", stageDateCycle='" + stageDateCycle + '\'' +
				", stageCanPayQuota=" + stageCanPayQuota +
				", stageBadPayQuota=" + stageBadPayQuota +
				", stageHasPayQuota=" + stageHasPayQuota +
				", stageUnPayQuota=" + stageUnPayQuota +
				", stagePayState='" + stagePayState + '\'' +
				", stageHasBill=" + stageHasBill +
				", stagePayRemindDays=" + stagePayRemindDays +
				", stageRemarkDescription='" + stageRemarkDescription + '\'' +
				", contractDetail=" + contractDetail +
				", cashs=" + cashs +
				", bills=" + bills +
				'}';
	}
}
