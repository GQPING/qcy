package com.zyjd.cts.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.zyjd.cts.dao.UserDao;
import com.zyjd.cts.model.User;
import com.zyjd.cts.service.UserService;

/**
 * @Transactional(rollbackFor = Exception.class)
 * 添加该注解的方法为Spring事务处理
 */
@Service
public class UserServiceImpl implements UserService {
	
	@Resource
	private UserDao userDao;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int add(User user) {
		int result = 0;
		try {
			result = userDao.add(user);
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
			result = userDao.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int update(User user) {
		int result = 0;
		try {
			result = userDao.update(user);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public User findByName(String nickName) {
		List<User> users = userDao.findByConditions(new User(nickName));
		if(users!=null && !users.isEmpty()
			&& users.size()==1){
			return users.get(0);
		}
		return  null;
	}
	
	@Override
	public User findById(int id) {
		return userDao.findById(id);
	}
	
	@Override
	public List<User> findAll() {
		return userDao.findAll();
	}
	
	@Override
	public List<User> findByCondition(User user) {
		return userDao.findByCondition(user);
	}

	@Override
	public List<User> findByConditions(User obj) { return userDao.findByConditions(obj); }

	@Override
	public List<User> findByConditionPage(User user) {
		return userDao.findByConditionPage(user);
	}

	@Override
	public Integer findCountByCondition(User user) { return userDao.findCountByCondition(user); }
}
