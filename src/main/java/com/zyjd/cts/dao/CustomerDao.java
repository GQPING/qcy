package com.zyjd.cts.dao;

import com.zyjd.cts.model.Customer;

// 客户数据接口
public interface CustomerDao extends Base<Customer>{

	Integer findCountByCondition(Customer customer);// 条件获取客户数量

}
