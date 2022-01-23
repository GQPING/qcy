package com.zyjd.cts.model;

// 操作模型
public class Operation extends Base{

	private Integer id;// 操作ID

	private String operateName;// 操作名称

	private String remarkDescription;// 操作备注

	public Operation() {
		super();
	}

	public Operation(Integer id) {
		this.id = id;
	}

	public Operation(String operateName) {
		this.operateName = operateName;
	}

	public Operation(Integer id, String operateName, String remarkDescription) {
		this.id = id;
		this.operateName = operateName;
		this.remarkDescription = remarkDescription;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getOperateName() {
		return operateName;
	}

	public void setOperateName(String operateName) {
		this.operateName = operateName;
	}

	public String getRemarkDescription() {
		return remarkDescription;
	}

	public void setRemarkDescription(String remarkDescription) {
		this.remarkDescription = remarkDescription;
	}

	@Override
	public String toString() {
		return "Operation{" +
				"id=" + id +
				", operateName='" + operateName + '\'' +
				", remarkDescription='" + remarkDescription + '\'' +
				'}';
	}
}
