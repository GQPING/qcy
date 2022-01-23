package com.zyjd.cts.dao;

import com.zyjd.cts.model.Contract;

// 合同数据接口
public interface ContractDao extends Base<Contract>{

	Integer findCountByCondition(Contract contract);// 条件获取合同数量

}
