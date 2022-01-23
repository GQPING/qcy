package com.zyjd.cts.service;

import com.zyjd.cts.dao.CustomerDao;
import com.zyjd.cts.model.Customer;

public interface CustomerService extends CustomerDao {

    Customer findByName(String customerName);// 指定名称查找

}
