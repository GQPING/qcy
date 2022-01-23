package com.zyjd.cts.model;

import java.util.Date;

// 日志模型
public class Log extends  Base{

	private Integer id;// 日志ID
	
	private Integer userID;// 用户ID

	private String operateDetail;// 操作明细

	private String logsIpAddress;// 登录IP地址

	private Date createDate;// 创建日期
	
	private User user = new User();// 关联用户

	public Log() {
		super();
	}

	public Log(Integer userID, String operateDetail, String logsIpAddress, Date createDate) {
		this.userID = userID;
		this.operateDetail = operateDetail;
		this.logsIpAddress = logsIpAddress;
		this.createDate = createDate;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserID() {
		return userID;
	}

	public void setUserID(Integer userID) {
		this.userID = userID;
	}

	public String getOperateDetail() {
		return operateDetail;
	}

	public void setOperateDetail(String operateDetail) {
		this.operateDetail = operateDetail;
	}

	public String getLogsIpAddress() {
		return logsIpAddress;
	}

	public void setLogsIpAddress(String logsIpAddress) {
		this.logsIpAddress = logsIpAddress;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "Log{" +
				"id=" + id +
				", userID=" + userID +
				", operateDetail='" + operateDetail + '\'' +
				", logsIpAddress='" + logsIpAddress + '\'' +
				", createDate=" + createDate +
				", user=" + user +
				'}';
	}
}
