package com.zyjd.cts.service.impl;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zyjd.cts.dao.ContactDao;
import com.zyjd.cts.model.Contact;
import com.zyjd.cts.service.ContactService;

/**
 * @Transactional(rollbackFor = Exception.class)
 * 添加该注解的方法为Spring事务处理
 */
@Service
public class ContactServiceImpl implements ContactService {

	@Resource
	private ContactDao contactDao;
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int add(Contact contact) {
		int result = 0;
		try {
			result = contactDao.add(contact);
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
			result = contactDao.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int update(Contact contact) {
		int result = 0;
		try {
			result = contactDao.update(contact);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public Contact findById(int id) {
		return contactDao.findById(id);
	}

	@Override
	public List<Contact> findAll() {
		return contactDao.findAll();
	}

	@Override
	public List<Contact> findByCondition(Contact contact) { return contactDao.findByCondition(contact); }

	@Override
	public List<Contact> findByConditions(Contact contact) { return contactDao.findByConditions(contact); }

	@Override
	public List<Contact> findByConditionPage(Contact contact) {
		return contactDao.findByConditionPage(contact);
	}
}
