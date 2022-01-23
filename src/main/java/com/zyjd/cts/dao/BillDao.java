package com.zyjd.cts.dao;

import com.zyjd.cts.model.Bill;

// 开票数据接口
public interface BillDao extends Base<Bill>{

	int updateNullByStageID(int id);// 删除分期，需要将开票关联的stageID字段置为NULL;

	Double findQuotasByCondition(Bill bill);// 条件获取开票额度

}
