package com.zyjd.cts.service;

import com.zyjd.cts.dao.ContractDao;
import com.zyjd.cts.model.Contract;

public interface ContractService extends ContractDao{

    Contract findByName(String contractNumber);// 指定名称查找

}
