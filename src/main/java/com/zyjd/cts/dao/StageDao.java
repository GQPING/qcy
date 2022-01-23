package com.zyjd.cts.dao;

import com.zyjd.cts.model.Stage;
import com.zyjd.cts.model.Total;

// 分期数据接口
public interface StageDao extends Base<Stage>{

	Total findQuotasByCondition(Stage stage);// 条件获取分期额度

}
