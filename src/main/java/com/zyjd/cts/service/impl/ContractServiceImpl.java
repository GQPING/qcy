package com.zyjd.cts.service.impl;

import java.util.List;
import javax.annotation.Resource;

import com.zyjd.cts.model.Customer;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.zyjd.cts.dao.ContractDao;
import com.zyjd.cts.model.Contract;
import com.zyjd.cts.service.ContractService;

/**
 * @Transactional(rollbackFor = Exception.class)
 * 添加该注解的方法为Spring事务处理
 */
@Service
public class ContractServiceImpl implements ContractService {
	
	@Resource
	private ContractDao contractDao;
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int add(Contract contract) {
		int result = 0;
		try {
			result = contractDao.add(contract);
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
			result = contractDao.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int update(Contract contract) {
		int result = 0;
		try {
			result = contractDao.update(contract);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
	
	@Override
	public Contract findByName(String contractNumber) {
		List<Contract> contracts = contractDao.findByConditions(new Contract(contractNumber));
		if(contracts!=null && !contracts.isEmpty()
			&& contracts.size()==1){
			return contracts.get(0);
		}
		return  null;
	}

	@Override
	public Contract findById(int id) {
		return contractDao.findById(id);
	}

	@Override
	public List<Contract> findAll() {
		return contractDao.findAll();
	}
	
	@Override
	public List<Contract> findByCondition(Contract contract) {
		return contractDao.findByCondition(contract);
	}

	@Override
	public List<Contract> findByConditions(Contract contract) {
		return contractDao.findByConditions(contract);
	}

	@Override
	public List<Contract> findByConditionPage(Contract contract) {
		return contractDao.findByConditionPage(contract);
	}
	
	@Override
	public Integer findCountByCondition(Contract contract) { return contractDao.findCountByCondition(contract); }
}
