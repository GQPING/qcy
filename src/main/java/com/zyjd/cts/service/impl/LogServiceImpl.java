package com.zyjd.cts.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.zyjd.cts.dao.LogDao;
import com.zyjd.cts.model.Log;
import com.zyjd.cts.service.LogService;

/**
 * @Transactional(rollbackFor = Exception.class)
 * 添加该注解的方法为Spring事务处理
 */
@Service
public class LogServiceImpl implements LogService {

	@Resource
	private LogDao logDao;
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int add(Log log) {
		int result = 0;
		try {
			result = logDao.add(log);
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
			result = logDao.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int update(Log log) {
		int result = 0;
		try {
			result = logDao.update(log);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public Log findById(int id) {
		return logDao.findById(id);
	}

	@Override
	public List<Log> findAll() {
		return logDao.findAll();
	}

	@Override
	public List<Log> findByCondition(Log log) {
		return logDao.findByCondition(log);
	}

	@Override
	public List<Log> findByConditions(Log log) { return logDao.findByConditions(log); }

	@Override
	public List<Log> findByConditionPage(Log log) {
		return logDao.findByConditionPage(log);
	}
}
