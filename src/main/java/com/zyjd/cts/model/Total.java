package com.zyjd.cts.model;

// 汇总模型
public class Total {

    private Integer details = 0;    // 数量

    private Double canQuotas = 0.0; // 应收

    private Double discounts = 0.0; // 折扣(坏账)

    private Double inQuotas = 0.0; // 已收

    private Double unQuotas = 0.0; // 未收

    public Integer getDetails() {
        return details;
    }

    public void setDetails(Integer details) {
        this.details = details;
    }

    public Double getDiscounts() {
        return discounts;
    }

    public void setDiscounts(Double discounts) {
        this.discounts = discounts;
    }

    public Double getCanQuotas() {
        return canQuotas;
    }

    public void setCanQuotas(Double canQuotas) {
        this.canQuotas = canQuotas;
    }

    public Double getInQuotas() {
        return inQuotas;
    }

    public void setInQuotas(Double inQuotas) {
        this.inQuotas = inQuotas;
    }

    public Double getUnQuotas() {
        return unQuotas;
    }

    public void setUnQuotas(Double unQuotas) {
        this.unQuotas = unQuotas;
    }

    @Override
    public String toString() {
        return "Total{" +
                "details=" + details +
                ", discounts=" + discounts +
                ", canQuotas=" + canQuotas +
                ", inQuotas=" + inQuotas +
                ", unQuotas=" + unQuotas +
                '}';
    }
}

