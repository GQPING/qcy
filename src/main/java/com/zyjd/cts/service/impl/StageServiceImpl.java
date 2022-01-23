package com.zyjd.cts.service.impl;

import java.util.List;
import javax.annotation.Resource;

import com.zyjd.cts.dao.BillDao;
import com.zyjd.cts.dao.CashingDao;
import com.zyjd.cts.dao.ContractDetailDao;
import com.zyjd.cts.model.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.zyjd.cts.dao.StageDao;
import com.zyjd.cts.service.StageService;

/**
 * @Transactional(rollbackFor = Exception.class)
 * 添加该注解的方法为Spring事务处理
 */
@Service
public class StageServiceImpl implements StageService {

	@Resource
	private StageDao stageDao;

	@Resource
	private CashingDao cashingDao;

	@Resource
	private BillDao billDao;

	@Resource
	private ContractDetailDao contractDetailDao;
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int add(Stage stage) {
		int result = 0;
		try {
			if(CanAdd(stage)){
				if(IsConflict(stage)) {
					result = 3; // 划分时间交叉
				} else{
					result = stageDao.add(stage);
				}
			}else{
				result = 2;// 划分额度不足
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int delete(int id) {
		int result = 0;
		try {
			result = stageDao.delete(id);
			// 删除分期，需要将开票关联的stageID字段置为NULL;
			billDao.updateNullByStageID(id);
			// 删除分期，需要将收款关联的stageID字段置为NULL;
			cashingDao.updateNullByStageID(id);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int update(Stage stage) {
		int result = 0;
		try {
			if(IsConflict(stage)) {
				result = 3; // 划分时间交叉
			}else{
				if(CanUpdate(stage)){
					result = stageDao.update(stage);
				}else{
					result = 2;// 划分额度不足
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public Stage findById(int id) { return stageDao.findById(id); }

	@Override
	public List<Stage> findAll() {
		return stageDao.findAll();
	}

	@Override
	public List<Stage> findByCondition(Stage stage) {
		return stageDao.findByCondition(stage);
	}

	@Override
	public List<Stage> findByConditions(Stage stage) {
		return stageDao.findByConditions(stage);
	}

	@Override
	public List<Stage> findByConditionPage(Stage stage) {
		return stageDao.findByConditionPage(stage);
	}

	@Override
	public Total findQuotasByCondition(Stage stage) { return stageDao.findQuotasByCondition(stage); }

	// 检测合同明细是否可添加分期
	private boolean CanAdd(Stage stage) {
		// 指定合同明细
		ContractDetail contractDetail = contractDetailDao.findById(stage.getContractDetailID());
		// 指定合同明细所有分期应收金额汇总
		Total total = stageDao.findQuotasByCondition(new Stage(stage.getContractDetailID()));
		// 指定合同明细尚未划分
		if(total == null) {
			// 继续判断，若新增分期金额 >合同明细应收金额，返回false
			if (Double.doubleToLongBits(stage.getStageCanPayQuota()) > Double.doubleToLongBits(contractDetail.getCanPayQuota())) {
				return false;// 划分额度不足
			}
			return true;// 可以添加
		}else {
			// 若分期已汇总金额 < 合同明细应收金额 ，返回true
			if (Double.doubleToLongBits(total.getCanQuotas()) < Double.doubleToLongBits(contractDetail.getCanPayQuota())) {
				// 继续判断，若分期已汇总金额 +新增分期金额 > 合同明细应收金额，返回false
				if (Double.doubleToLongBits(total.getCanQuotas() + stage.getStageCanPayQuota()) > Double.doubleToLongBits(contractDetail.getCanPayQuota())) {
					return false;// 划分额度不足
				}
				return true;// 可以添加
			} else {
				return false;
			}
		}
	}

	// 检测是否可修改分期
	private boolean CanUpdate(Stage stage) {
		if (stage.getStageCanPayQuota() != null) {
			return CanUpdateQuota(stage);
		}
		return true;
	}

	// 检测修改的金额是否符合要求
	private boolean CanUpdateQuota(Stage stage) {
		// 原来分期数据
		Stage origin = stageDao.findById(stage.getId());
		// 分期所属合同明细
		ContractDetail contractDetail = contractDetailDao.findById(stage.getContractDetailID());
		// 合同明细分期汇总应收金额
		Total total = stageDao.findQuotasByCondition(new Stage(stage.getContractDetailID()));
		// 修改后金额<原来的金额
		if(Double.doubleToLongBits(stage.getStageCanPayQuota()) <= Double.doubleToLongBits(origin.getStageCanPayQuota())) {
			return true;// 金额变小，可以修改
		} else {
			// 合同明细应收金额<合同明细分期汇总金额(修改后)
			if (Double.doubleToLongBits(contractDetail.getCanPayQuota()) < Double.doubleToLongBits(
					total.getCanQuotas() - origin.getStageCanPayQuota() + stage.getStageCanPayQuota())) {
				return false;// 修改过大，超过应收金额，不可修改
			} else {
				return true;// 修改适度，可以修改
			}
		}
	}

	// 检测分期日期是否与合同明细现有划分分期冲突
	private boolean IsConflict(Stage stage) {
		List<Stage> temps = stageDao.findByConditions(stage);
		if(temps!=null && !temps.isEmpty()) {
			return true;// 分期时间交叉
		}
		return false;
	}
}
