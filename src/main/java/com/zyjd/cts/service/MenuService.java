package com.zyjd.cts.service;

import com.zyjd.cts.dao.MenuDao;
import com.zyjd.cts.model.Menu;
import java.util.List;

public interface MenuService extends MenuDao{

    Menu findByName(String nickName);// 指定名称查找

    List<Menu> findByParentId(int parentID);// 指定父级ID查找

}
