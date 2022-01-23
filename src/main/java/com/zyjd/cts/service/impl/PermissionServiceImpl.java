package com.zyjd.cts.service.impl;

import java.util.List;

import javax.annotation.Resource;

import com.zyjd.cts.model.Permission;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zyjd.cts.dao.PermissionDao;
import com.zyjd.cts.model.Permission;
import com.zyjd.cts.service.PermissionService;

/**
 * @Transactional(rollbackFor = Exception.class)
 * 添加该注解的方法为Spring事务处理
 */
@Service
public class PermissionServiceImpl implements PermissionService {

    @Resource
	private PermissionDao permissionDao;
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int add(Permission permission) {
		int result = 0;
		try {
			result = permissionDao.add(permission);
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
			result = permissionDao.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int update(Permission permission) {
		int result = 0;
		try {
			result = permissionDao.update(permission);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public Permission findByName(String permissionName) {
		List<Permission> permissions =permissionDao.findByConditions(new Permission(permissionName));
		if(permissions!=null && !permissions.isEmpty() && permissions.size()==1){
			return permissions.get(0);
		}
		return  null;
	}

	@Override
	public Permission findById(int id) {
		return permissionDao.findById(id);
	}
	
	@Override
	public List<Permission> findAll() {
		return permissionDao.findAll();
	}

	@Override
	public List<Permission> findByCondition(Permission permission) {
		return permissionDao.findByCondition(permission);
	}

	@Override
	public List<Permission> findByConditions(Permission permission) {
		return permissionDao.findByConditions(permission);
	}
	
	@Override
	public List<Permission> findByConditionPage(Permission permission) { return permissionDao.findByConditionPage(permission); }	
}
