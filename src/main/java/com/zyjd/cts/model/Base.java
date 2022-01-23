package com.zyjd.cts.model;

import com.zyjd.cts.util.QcyConstants;

import java.util.Date;

// 基础模型
public class Base {

    protected Date searchDate;// 搜索日期

    protected String searchString;// 搜索字符串

    protected Integer searchInteger;// 搜索数值

    // 角色权限
    protected String menuNameString;// 权限菜单

    protected String operationNameString;// 权限操作

    // 区间查询
    protected Date timeStart;// 时间开始

    protected Date timeFinal;// 时间结束

    // 分页显示
    protected Integer page = QcyConstants.PAGE_DEFAULT_PAGE; // 当前页码

    protected Integer limit = QcyConstants.PAGE_DEFAULT_SIZE; // 每页数量

    protected Integer start = QcyConstants.PAGE_DEFAULT_START;// 开始地址

    // 特定条件
    protected Integer isYear;// 是否按年份查询

    protected Integer isMonth;// 是否按月份查询

    protected Integer isToday;// 是否按今日查询

    protected Integer isDeadLine;// 是否项目到期查询

    protected Integer isCustomer;// 是否按客户查询

    protected Integer isContract;// 是否按合同查询

    protected Integer isContractDetail;// 是否按车辆查询

    protected Integer isStage;// 是否按阶段查询

    protected Integer isFuzzy;// 是否按模糊查询

    protected Integer isRent;// 是否为租赁模式

    protected Integer isSale;// 是否为出售模式

    public String getMenuNameString() { return menuNameString; }

    public void setMenuNameString(String menuNameString) { this.menuNameString = menuNameString; }

    public String getOperationNameString() { return operationNameString; }

    public void setOperationNameString(String operationNameString) { this.operationNameString = operationNameString; }

    public Date getSearchDate() {
        return searchDate;
    }

    public void setSearchDate(Date searchDate) {
        this.searchDate = searchDate;
    }

    public String getSearchString() {
        return searchString;
    }

    public void setSearchString(String searchString) {
        this.searchString = searchString;
    }

    public Integer getSearchInteger() {
        return searchInteger;
    }

    public void setSearchInteger(Integer searchInteger) {
        this.searchInteger = searchInteger;
    }

    public Date getTimeStart() {
        return timeStart;
    }

    public void setTimeStart(Date timeStart) {
        this.timeStart = timeStart;
    }

    public Date getTimeFinal() {
        return timeFinal;
    }

    public void setTimeFinal(Date timeFinal) {
        this.timeFinal = timeFinal;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    public Integer getStart() {
        return start;
    }

    public void setStart(Integer start) {
        this.start = start;
    }

    public Integer getIsYear() {
        return isYear;
    }

    public void setIsYear(Integer isYear) {
        this.isYear = isYear;
    }

    public Integer getIsMonth() {
        return isMonth;
    }

    public void setIsMonth(Integer isMonth) {
        this.isMonth = isMonth;
    }

    public Integer getIsToday() {
        return isToday;
    }

    public void setIsToday(Integer isToday) {
        this.isToday = isToday;
    }

    public Integer getIsDeadLine() {
        return isDeadLine;
    }

    public void setIsDeadLine(Integer isDeadLine) {
        this.isDeadLine = isDeadLine;
    }

    public Integer getIsCustomer() {
        return isCustomer;
    }

    public void setIsCustomer(Integer isCustomer) {
        this.isCustomer = isCustomer;
    }

    public Integer getIsContract() {
        return isContract;
    }

    public void setIsContract(Integer isContract) {
        this.isContract = isContract;
    }

    public Integer getIsContractDetail() {
        return isContractDetail;
    }

    public void setIsContractDetail(Integer isContractDetail) {
        this.isContractDetail = isContractDetail;
    }

    public Integer getIsStage() {
        return isStage;
    }

    public void setIsStage(Integer isStage) {
        this.isStage = isStage;
    }

    public Integer getIsFuzzy() {
        return isFuzzy;
    }

    public void setIsFuzzy(Integer isFuzzy) {
        this.isFuzzy = isFuzzy;
    }

    public Integer getIsRent() {
        return isRent;
    }

    public void setIsRent(Integer isRent) {
        this.isRent = isRent;
    }

    public Integer getIsSale() {
        return isSale;
    }

    public void setIsSale(Integer isSale) {
        this.isSale = isSale;
    }

    @Override
    public String toString() {
        return "Base{" +
                "searchDate=" + searchDate +
                ", searchString='" + searchString + '\'' +
                ", searchInteger=" + searchInteger +
                ", timeStart=" + timeStart +
                ", timeFinal=" + timeFinal +
                ", page=" + page +
                ", limit=" + limit +
                ", start=" + start +
                ", isYear=" + isYear +
                ", isMonth=" + isMonth +
                ", isToday=" + isToday +
                ", isDeadLine=" + isDeadLine +
                ", isCustomer=" + isCustomer +
                ", isContract=" + isContract +
                ", isContractDetail=" + isContractDetail +
                ", isStage=" + isStage +
                ", isFuzzy=" + isFuzzy +
                ", isRent=" + isRent +
                ", isSale=" + isSale +
                '}';
    }
}
