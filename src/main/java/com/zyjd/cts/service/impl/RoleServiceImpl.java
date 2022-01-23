package com.zyjd.cts.service.impl;

import java.util.List;

import javax.annotation.Resource;

import com.zyjd.cts.model.Role;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zyjd.cts.dao.RoleDao;
import com.zyjd.cts.model.Permission;
import com.zyjd.cts.model.Role;
import com.zyjd.cts.service.RoleService;

/**
 * @Transactional(rollbackFor = Exception.class)
 * 添加该注解的方法为Spring事务处理
 */
@Service
public class RoleServiceImpl implements RoleService {

	@Resource
	private RoleDao roleDao;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int add(Role role) {
		int result = 0;
		try {
			result = roleDao.add(role);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int delete(int id) {
		int result = 0;
		try {
			result = roleDao.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int update(Role role) {
		int result = 0;
		try {
			result = roleDao.update(role);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public Role findByName(String roleName) {
		List<Role> roles = roleDao.findByConditions(new Role(roleName));
		if(roles!=null && !roles.isEmpty() && roles.size()==1){
			return roles.get(0);
		}
		return  null;
	}

	@Override
	public Role findById(int id) {
		return roleDao.findById(id);
	}
	
	@Override
	public List<Role> findAll() {
		return roleDao.findAll();
	}

	@Override
	public List<Role> findByCondition(Role role) {
		return roleDao.findByCondition(role);
	}

	@Override
	public List<Role> findByConditions(Role role) {
		return roleDao.findByConditions(role);
	}

	@Override
	public List<Role> findByConditionPage(Role role) {
		return roleDao.findByConditionPage(role);
	}

	@Override
	public Permission findByRolePermission(Role role) {
		return roleDao.findByRolePermission(role);
	}

	@Override
	public List<Permission> findByRolePermissions(Role role) {
		return roleDao.findByRolePermissions(role);
	}
}
