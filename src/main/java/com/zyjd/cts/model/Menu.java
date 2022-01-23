package com.zyjd.cts.model;

import java.util.List;

// 菜单模型
public class Menu extends Base{
	
	private Integer id;// 菜单ID

	private Integer parentID;// 父级菜单ID

	private String menuName;// 菜单名称

	private String menuHref;// 菜单链接

	private String remarkDescription;// 菜单备注

	private Integer hasOperationChildren;// 有无直接操作节点，0代表无，1代表有

	private Menu parent; // 父级菜单

	private List<Menu> children; // 多个子菜单

	public Menu() { super(); }

	public Menu(Integer parentID) {
		this.parentID = parentID;
	}

	public Menu(String menuName) {
		super();
		this.menuName = menuName;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getRemarkDescription() { return remarkDescription; }

	public void setRemarkDescription(String remarkDescription) { this.remarkDescription = remarkDescription; }

	public Integer getParentID() { return parentID; }

	public void setParentID(Integer parentID) { this.parentID = parentID; }

	public String getMenuHref() { return menuHref; }

	public void setMenuHref(String menuHref) { this.menuHref = menuHref; }

	public Integer getHasOperationChildren() { return hasOperationChildren; }

	public void setHasOperationChildren(Integer hasOperationChildren) { this.hasOperationChildren = hasOperationChildren; }

	public Menu getParent() { return parent; }

	public void setParent(Menu parent) { this.parent = parent; }

	public List<Menu> getChildren() { return children; }

	public void setChildren(List<Menu> children) { this.children = children; }

	@Override
	public String toString() {
		return "Menu{" +
				"id=" + id +
				", parentID=" + parentID +
				", menuName='" + menuName + '\'' +
				", menuHref='" + menuHref + '\'' +
				", remarkDescription='" + remarkDescription + '\'' +
				", hasOperationChildren=" + hasOperationChildren +
				", parent=" + parent +
				", children=" + children +
				'}';
	}
}