package com.zyjd.cts.service.impl;

import java.util.List;

import javax.annotation.Resource;

import com.zyjd.cts.dao.LogDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zyjd.cts.dao.CustomerDao;
import com.zyjd.cts.model.Customer;
import com.zyjd.cts.service.CustomerService;

/**
 * @Transactional(rollbackFor = Exception.class)
 * 添加该注解的方法为Spring事务处理
 */
@Service
public class CustomerServiceImpl implements CustomerService {
	
	@Resource
	private CustomerDao customerDao;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int add(Customer customer) {
		int result = 0;
		try {
			result = customerDao.add(customer);
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
			result = customerDao.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int update(Customer customer) {
		int result = 0;
		try {
			result = customerDao.update(customer);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public Customer findByName(String customerName) {
		List<Customer> customers = customerDao.findByConditions(new Customer(customerName));
		if(customers!=null && !customers.isEmpty()
			&& customers.size()==1){
			return customers.get(0);
		}
		return  null;
	}
	
	@Override
	public Customer findById(int id) {
		return customerDao.findById(id);
	}

	@Override
	public List<Customer> findAll() {
		return customerDao.findAll();
	}

	@Override
	public List<Customer> findByCondition(Customer customer) {
		return customerDao.findByCondition(customer);
	}

	@Override
	public List<Customer> findByConditions(Customer customer) { return customerDao.findByConditions(customer); }

	@Override
	public List<Customer> findByConditionPage(Customer customer) {
		return customerDao.findByConditionPage(customer);
	}

	@Override
	public Integer findCountByCondition(Customer customer) { return customerDao.findCountByCondition(customer); }
}
