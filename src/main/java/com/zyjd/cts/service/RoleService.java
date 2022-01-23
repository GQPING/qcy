package com.zyjd.cts.service;

import com.zyjd.cts.dao.RoleDao;
import com.zyjd.cts.model.Role;

public interface RoleService extends RoleDao{

    Role findByName(String roleName);// 指定名称查找

}
