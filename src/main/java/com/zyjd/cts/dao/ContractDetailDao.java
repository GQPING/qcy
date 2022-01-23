package com.zyjd.cts.dao;

import com.zyjd.cts.model.ContractDetail;
import com.zyjd.cts.model.Record;
import com.zyjd.cts.model.Total;

import java.util.List;

// 合同明细数据接口
public interface ContractDetailDao extends Base<ContractDetail> {

	Total findTotalByCondition(ContractDetail contractDetail);// 条件获取合同明细汇总对象

	Integer findCountByCondition(ContractDetail contractDetail);// 条件获取合同数量

	List<Record> findByRecord(ContractDetail contractDetail);// 条件获取车辆档案

	List<Record> findByRecordPage(ContractDetail contractDetail);// 分页条件获取车辆档案
}
