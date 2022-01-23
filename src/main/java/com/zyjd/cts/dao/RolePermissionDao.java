package com.zyjd.cts.dao;

import java.util.List;
import com.zyjd.cts.model.RolePermission;

// 角色权限数据接口
public interface RolePermissionDao {
	
	int add(RolePermission rolePermission);// 增加
	
	int delete(RolePermission rolePermission);// 删除(根据指定角色ID、权限ID)

	RolePermission findById(RolePermission rolePermission); // 查询指定
	
	List<RolePermission> findAll();// 查询全部

	List<RolePermission> findByCondition(RolePermission rolePermission);// 条件查询
}
