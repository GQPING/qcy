package com.zyjd.cts.service;

import com.zyjd.cts.dao.PermissionDao;
import com.zyjd.cts.model.Permission;

public interface PermissionService extends PermissionDao{

    Permission findByName(String permissionName);// 指定名称查找

}
