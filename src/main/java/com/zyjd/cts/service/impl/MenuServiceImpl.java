package com.zyjd.cts.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.zyjd.cts.dao.MenuDao;
import com.zyjd.cts.model.Menu;
import com.zyjd.cts.service.MenuService;

/**
 * @Transactional(rollbackFor = Exception.class)
 * 添加该注解的方法为Spring事务处理
 */
@Service
public class MenuServiceImpl implements MenuService {

	@Resource
	private MenuDao menuDao;
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int add(Menu menu) {
		int result = 0;
		try {
			result = menuDao.add(menu);
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
			result = menuDao.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int update(Menu menu) {
		int result = 0;
		try {
			result = menuDao.update(menu);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public Menu findByName(String menuName) {
		List<Menu> menus =menuDao.findByConditions(new Menu(menuName));
		if(menus!=null && !menus.isEmpty() && menus.size()==1){
			return menus.get(0);
		}
		return  null;
	}

	@Override
	public List<Menu> findByParentId(int parentID) {
		return menuDao.findByConditions(new Menu(parentID));
	}

	@Override
	public Menu findById(int id) {
		return menuDao.findById(id);
	}

	@Override
	public List<Menu> findAll() { return menuDao.findAll(); }

	@Override
	public List<Menu> findByCondition(Menu menu) {
		return menuDao.findByCondition(menu);
	}

	@Override
	public List<Menu> findByConditions(Menu menu) {
		return menuDao.findByConditions(menu);
	}

	@Override
	public List<Menu> findByConditionPage(Menu menu) {
		return menuDao.findByConditionPage(menu);
	}
}
