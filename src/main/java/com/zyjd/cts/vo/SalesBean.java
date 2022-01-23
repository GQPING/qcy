package com.zyjd.cts.vo;

/**
 * 销售额汇总Bean
 */
public class SalesBean {

    //销售额统计
    private Double totalCanQuota = 0.0;   // 应收合计
	private Double totalDisQuota = 0.0;   // 优惠合计
    private Double totalHasQuota = 0.0;   // 已收合计
	private Double totalNonQuota = 0.0;   // 未收合计
    private Double totalEndHasQuota = 0.0; // 到期已收
    private Double totalEndNonQuota = 0.0; // 到期未收

    //代理商统计
    private Double agentCanQuota = 0.0;   // 代理应收
    private Double agentDisQuota = 0.0;   // 代理优惠
    private Double agentHasQuota = 0.0;   // 代理已收
    private Double agentNonQuota = 0.0;   // 代理未收
    private Double agentEndHasQuota = 0.0; // 代理到期已收
    private Double agentEndNonQuota = 0.0; // 代理到期未收

    //出售额统计
    private Double salesCanQuota = 0.0;   // 出售应收
    private Double salesDisQuota = 0.0;   // 出售优惠
    private Double salesHasQuota = 0.0;   // 出售已收
    private Double salesNonQuota = 0.0;   // 出售未收
    private Double salesEndHasQuota = 0.0; // 出售到期已收
    private Double salesEndNonQuota = 0.0; // 出售到期未收

    //租赁额统计
    private Double rentsCanQuota = 0.0;   // 租赁应收
    private Double rentsDisQuota = 0.0;   // 租赁优惠
    private Double rentsHasQuota = 0.0;   // 租赁已收
    private Double rentsNonQuota = 0.0;   // 租赁未收
    private Double rentsEndHasQuota = 0.0; // 租赁到期已收
    private Double rentsEndNonQuota = 0.0; // 租赁到期未收

    //阶段额统计
    private Double stageCanQuota = 0.0;   // 阶段应收
    private Double stageBadQuota = 0.0;   // 阶段坏账
    private Double stageHasQuota = 0.0;   // 阶段已收
    private Double stageNonQuota = 0.0;   // 阶段未收
    private Double stageEndHasQuota = 0.0; // 阶段到期已收
    private Double stageEndNonQuota = 0.0; // 阶段到期未收

    public Double getTotalCanQuota() {
        return totalCanQuota;
    }

    public void setTotalCanQuota(Double totalCanQuota) {
        this.totalCanQuota = totalCanQuota;
    }

    public Double getTotalDisQuota() {
        return totalDisQuota;
    }

    public void setTotalDisQuota(Double totalDisQuota) {
        this.totalDisQuota = totalDisQuota;
    }

    public Double getTotalHasQuota() {
        return totalHasQuota;
    }

    public void setTotalHasQuota(Double totalHasQuota) {
        this.totalHasQuota = totalHasQuota;
    }

    public Double getTotalNonQuota() {
        return totalNonQuota;
    }

    public void setTotalNonQuota(Double totalNonQuota) {
        this.totalNonQuota = totalNonQuota;
    }

    public Double getTotalEndHasQuota() {
        return totalEndHasQuota;
    }

    public void setTotalEndHasQuota(Double totalEndHasQuota) {
        this.totalEndHasQuota = totalEndHasQuota;
    }

    public Double getTotalEndNonQuota() {
        return totalEndNonQuota;
    }

    public void setTotalEndNonQuota(Double totalEndNonQuota) {
        this.totalEndNonQuota = totalEndNonQuota;
    }

    public Double getAgentCanQuota() {
        return agentCanQuota;
    }

    public void setAgentCanQuota(Double agentCanQuota) {
        this.agentCanQuota = agentCanQuota;
    }

    public Double getAgentDisQuota() {
        return agentDisQuota;
    }

    public void setAgentDisQuota(Double agentDisQuota) {
        this.agentDisQuota = agentDisQuota;
    }

    public Double getAgentHasQuota() {
        return agentHasQuota;
    }

    public void setAgentHasQuota(Double agentHasQuota) {
        this.agentHasQuota = agentHasQuota;
    }

    public Double getAgentNonQuota() {
        return agentNonQuota;
    }

    public void setAgentNonQuota(Double agentNonQuota) {
        this.agentNonQuota = agentNonQuota;
    }

    public Double getAgentEndHasQuota() {
        return agentEndHasQuota;
    }

    public void setAgentEndHasQuota(Double agentEndHasQuota) {
        this.agentEndHasQuota = agentEndHasQuota;
    }

    public Double getAgentEndNonQuota() {
        return agentEndNonQuota;
    }

    public void setAgentEndNonQuota(Double agentEndNonQuota) {
        this.agentEndNonQuota = agentEndNonQuota;
    }

    public Double getSalesCanQuota() {
        return salesCanQuota;
    }

    public void setSalesCanQuota(Double salesCanQuota) {
        this.salesCanQuota = salesCanQuota;
    }

    public Double getSalesDisQuota() {
        return salesDisQuota;
    }

    public void setSalesDisQuota(Double salesDisQuota) {
        this.salesDisQuota = salesDisQuota;
    }

    public Double getSalesHasQuota() {
        return salesHasQuota;
    }

    public void setSalesHasQuota(Double salesHasQuota) {
        this.salesHasQuota = salesHasQuota;
    }

    public Double getSalesNonQuota() {
        return salesNonQuota;
    }

    public void setSalesNonQuota(Double salesNonQuota) {
        this.salesNonQuota = salesNonQuota;
    }

    public Double getSalesEndHasQuota() {
        return salesEndHasQuota;
    }

    public void setSalesEndHasQuota(Double salesEndHasQuota) {
        this.salesEndHasQuota = salesEndHasQuota;
    }

    public Double getSalesEndNonQuota() {
        return salesEndNonQuota;
    }

    public void setSalesEndNonQuota(Double salesEndNonQuota) {
        this.salesEndNonQuota = salesEndNonQuota;
    }

    public Double getRentsCanQuota() {
        return rentsCanQuota;
    }

    public void setRentsCanQuota(Double rentsCanQuota) {
        this.rentsCanQuota = rentsCanQuota;
    }

    public Double getRentsDisQuota() {
        return rentsDisQuota;
    }

    public void setRentsDisQuota(Double rentsDisQuota) {
        this.rentsDisQuota = rentsDisQuota;
    }

    public Double getRentsHasQuota() {
        return rentsHasQuota;
    }

    public void setRentsHasQuota(Double rentsHasQuota) {
        this.rentsHasQuota = rentsHasQuota;
    }

    public Double getRentsNonQuota() {
        return rentsNonQuota;
    }

    public void setRentsNonQuota(Double rentsNonQuota) {
        this.rentsNonQuota = rentsNonQuota;
    }

    public Double getRentsEndHasQuota() {
        return rentsEndHasQuota;
    }

    public void setRentsEndHasQuota(Double rentsEndHasQuota) {
        this.rentsEndHasQuota = rentsEndHasQuota;
    }

    public Double getRentsEndNonQuota() {
        return rentsEndNonQuota;
    }

    public void setRentsEndNonQuota(Double rentsEndNonQuota) {
        this.rentsEndNonQuota = rentsEndNonQuota;
    }

    public Double getStageCanQuota() {
        return stageCanQuota;
    }

    public void setStageCanQuota(Double stageCanQuota) {
        this.stageCanQuota = stageCanQuota;
    }

    public Double getStageBadQuota() {
        return stageBadQuota;
    }

    public void setStageBadQuota(Double stageBadQuota) {
        this.stageBadQuota = stageBadQuota;
    }

    public Double getStageHasQuota() {
        return stageHasQuota;
    }

    public void setStageHasQuota(Double stageHasQuota) {
        this.stageHasQuota = stageHasQuota;
    }

    public Double getStageNonQuota() {
        return stageNonQuota;
    }

    public void setStageNonQuota(Double stageNonQuota) {
        this.stageNonQuota = stageNonQuota;
    }

    public Double getStageEndHasQuota() {
        return stageEndHasQuota;
    }

    public void setStageEndHasQuota(Double stageEndHasQuota) {
        this.stageEndHasQuota = stageEndHasQuota;
    }

    public Double getStageEndNonQuota() {
        return stageEndNonQuota;
    }

    public void setStageEndNonQuota(Double stageEndNonQuota) {
        this.stageEndNonQuota = stageEndNonQuota;
    }

    @Override
    public String toString() {
        return "SalesBean{" +
                "totalCanQuota=" + totalCanQuota +
                ", totalDisQuota=" + totalDisQuota +
                ", totalHasQuota=" + totalHasQuota +
                ", totalNonQuota=" + totalNonQuota +
                ", totalEndHasQuota=" + totalEndHasQuota +
                ", totalEndNonQuota=" + totalEndNonQuota +
                ", agentCanQuota=" + agentCanQuota +
                ", agentDisQuota=" + agentDisQuota +
                ", agentHasQuota=" + agentHasQuota +
                ", agentNonQuota=" + agentNonQuota +
                ", agentEndHasQuota=" + agentEndHasQuota +
                ", agentEndNonQuota=" + agentEndNonQuota +
                ", salesCanQuota=" + salesCanQuota +
                ", salesDisQuota=" + salesDisQuota +
                ", salesHasQuota=" + salesHasQuota +
                ", salesNonQuota=" + salesNonQuota +
                ", salesEndHasQuota=" + salesEndHasQuota +
                ", salesEndNonQuota=" + salesEndNonQuota +
                ", rentsCanQuota=" + rentsCanQuota +
                ", rentsDisQuota=" + rentsDisQuota +
                ", rentsHasQuota=" + rentsHasQuota +
                ", rentsNonQuota=" + rentsNonQuota +
                ", rentsEndHasQuota=" + rentsEndHasQuota +
                ", rentsEndNonQuota=" + rentsEndNonQuota +
                ", stageCanQuota=" + stageCanQuota +
                ", stageBadQuota=" + stageBadQuota +
                ", stageHasQuota=" + stageHasQuota +
                ", stageNonQuota=" + stageNonQuota +
                ", stageEndHasQuota=" + stageEndHasQuota +
                ", stageEndNonQuota=" + stageEndNonQuota +
                '}';
    }
}
