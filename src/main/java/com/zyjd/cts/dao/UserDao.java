package com.zyjd.cts.dao;

import com.zyjd.cts.model.User;

// 用户数据接口
public interface UserDao extends Base<User> {

	Integer findCountByCondition(User user);// 条件获取用户数量

}
