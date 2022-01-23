package com.zyjd.cts.service;

import com.zyjd.cts.dao.OperationDao;
import com.zyjd.cts.model.Operation;

public interface OperationService extends OperationDao{

    Operation findByName(String operateName);// 指定名称查找

}
