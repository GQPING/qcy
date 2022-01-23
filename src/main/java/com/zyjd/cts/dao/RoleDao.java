package com.zyjd.cts.dao;

import java.util.List;

import com.zyjd.cts.model.Permission;
import com.zyjd.cts.model.Role;

// 角色数据接口
public interface RoleDao extends Base<Role>{

	Permission findByRolePermission(Role role);// 条件获取合同数量

	List<Permission> findByRolePermissions(Role role);// 条件获取合同数量

}
