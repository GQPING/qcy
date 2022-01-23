package com.zyjd.cts.service.impl;

import java.util.List;

import javax.annotation.Resource;

import com.zyjd.cts.model.Record;
import com.zyjd.cts.model.Total;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zyjd.cts.dao.ContractDetailDao;
import com.zyjd.cts.model.Contract;
import com.zyjd.cts.model.ContractDetail;
import com.zyjd.cts.service.ContractDetailService;

/**
 * @Transactional(rollbackFor = Exception.class)
 * 添加该注解的方法为Spring事务处理
 */
@Service
public class ContractDetailServiceImpl implements ContractDetailService {

	@Resource
	private ContractDetailDao contractDetailDao;
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int add(ContractDetail contractDetail) {
		int result = 0;
		try {
			result = contractDetailDao.add(contractDetail);
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
			result = contractDetailDao.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int update(ContractDetail contractDetail) {
		int result = 0;
		try {
			result = contractDetailDao.update(contractDetail);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public ContractDetail findById(int id) {
		return contractDetailDao.findById(id);
	}

	@Override
	public List<ContractDetail> findAll() {
		return contractDetailDao.findAll();
	}

	@Override
	public List<ContractDetail> findByCondition(ContractDetail contractDetail) { return contractDetailDao.findByCondition(contractDetail); }

	@Override
	public List<ContractDetail> findByConditions(ContractDetail contractDetail) { return contractDetailDao.findByConditions(contractDetail); }

	@Override
	public List<ContractDetail> findByConditionPage(ContractDetail contractDetail) { return contractDetailDao.findByConditionPage(contractDetail); }

	@Override
	public Total findTotalByCondition(ContractDetail contractDetail) { return contractDetailDao.findTotalByCondition(contractDetail); }

	@Override
	public Integer findCountByCondition(ContractDetail contractDetail) { return contractDetailDao.findCountByCondition(contractDetail); }

	@Override
	public List<Record> findByRecord(ContractDetail contractDetail) { return contractDetailDao.findByRecord(contractDetail); }

	@Override
	public List<Record> findByRecordPage(ContractDetail contractDetail) { return contractDetailDao.findByRecordPage(contractDetail); }
}
