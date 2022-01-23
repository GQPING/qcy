package com.zyjd.cts.service.impl;

import java.util.List;
import javax.annotation.Resource;

import com.zyjd.cts.model.Operation;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.zyjd.cts.dao.OperationDao;
import com.zyjd.cts.model.Operation;
import com.zyjd.cts.service.OperationService;

/**
 * @Transactional(rollbackFor = Exception.class)
 * 添加该注解的方法为Spring事务处理
 */
@Service
public class OperationServiceImpl implements OperationService {

	@Resource
	private OperationDao operationDao;
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int add(Operation operation) {
		int result = 0;
		try {
			result = operationDao.add(operation);
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
			result = operationDao.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int update(Operation operation) {
		int result = 0;
		try {
			result = operationDao.update(operation);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public Operation findByName(String operateName) {
		List<Operation> operations =operationDao.findByConditions(new Operation(operateName));
		if(operations!=null && !operations.isEmpty() && operations.size()==1){
			return operations.get(0);
		}
		return null;
	}
	
	@Override
	public Operation findById(int id) {
		return operationDao.findById(id);
	}

	@Override
	public List<Operation> findAll() {
		return operationDao.findAll();
	}

	@Override
	public List<Operation> findByCondition(Operation operation) {
		return operationDao.findByCondition(operation);
	}

	@Override
	public List<Operation> findByConditions(Operation operation) {
		return operationDao.findByConditions(operation);
	}

	@Override
	public List<Operation> findByConditionPage(Operation operation) {
		return operationDao.findByConditionPage(operation);
	}
}
