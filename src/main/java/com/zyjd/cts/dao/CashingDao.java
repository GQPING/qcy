package com.zyjd.cts.dao;

import com.zyjd.cts.model.Cashing;

// 收款数据接口
public interface CashingDao extends Base<Cashing> {

	int updateNullByStageID(int id);// 删除分期，需要将收款关联的stageID字段置为NULL;

	Double findQuotasByCondition(Cashing cashing);// 条件获取收款额度

}
