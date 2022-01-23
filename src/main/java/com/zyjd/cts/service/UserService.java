package com.zyjd.cts.service;

import com.zyjd.cts.dao.UserDao;
import com.zyjd.cts.model.User;

public interface UserService extends UserDao{

    User findByName(String nickName);// 指定名称查找

}
