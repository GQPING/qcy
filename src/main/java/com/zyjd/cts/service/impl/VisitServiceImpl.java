package com.zyjd.cts.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zyjd.cts.dao.VisitDao;
import com.zyjd.cts.model.Visit;
import com.zyjd.cts.service.VisitService;

/**
 * @Transactional(rollbackFor = Exception.class)
 * 添加该注解的方法为Spring事务处理
 */
@Service
public class VisitServiceImpl implements VisitService {

	@Resource
	private VisitDao visitDao;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int add(Visit visit) {
		int result = 0;
		try {
			result = visitDao.add(visit);
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
			result = visitDao.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int update(Visit visit) {
		int result = 0;
		try {
			result = visitDao.update(visit);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public Visit findById(int id) {
		return visitDao.findById(id);
	}

	@Override
	public List<Visit> findAll() { return visitDao.findAll(); }

	@Override
	public List<Visit> findByCondition(Visit visit) {
		return visitDao.findByCondition(visit);
	}

	@Override
	public List<Visit> findByConditions(Visit visit) {
		return visitDao.findByConditions(visit);
	}

	@Override
	public List<Visit> findByConditionPage(Visit visit) {
		return visitDao.findByConditionPage(visit);
	}
}
