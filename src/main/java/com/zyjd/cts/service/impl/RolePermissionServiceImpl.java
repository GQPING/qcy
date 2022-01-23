package com.zyjd.cts.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.zyjd.cts.dao.RolePermissionDao;
import com.zyjd.cts.model.RolePermission;
import com.zyjd.cts.service.RolePermissionService;

/**
 * @Transactional(rollbackFor = Exception.class)
 * 添加该注解的方法为Spring事务处理
 */
@Service
public class RolePermissionServiceImpl implements RolePermissionService {

	@Resource
	private RolePermissionDao rolePermissionDao;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int add(RolePermission rolePermission) {
		int result = 0;
		try {
			result = rolePermissionDao.add(rolePermission);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int delete(RolePermission rolePermission) {
		int result = 0;
		try {
			result = rolePermissionDao.delete(rolePermission);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public RolePermission findById(RolePermission rolePermission) {
		return rolePermissionDao.findById(rolePermission);
	}

	@Override
	public List<RolePermission> findAll() {
		return rolePermissionDao.findAll();
	}

	@Override
	public List<RolePermission> findByCondition(RolePermission rolePermission) { return rolePermissionDao.findByCondition(rolePermission); }
}
