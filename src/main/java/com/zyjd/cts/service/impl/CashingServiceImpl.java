package com.zyjd.cts.service.impl;

import java.util.List;

import javax.annotation.Resource;

import com.zyjd.cts.dao.ContractDetailDao;
import com.zyjd.cts.dao.StageDao;
import com.zyjd.cts.model.Bill;
import com.zyjd.cts.model.ContractDetail;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zyjd.cts.dao.CashingDao;
import com.zyjd.cts.model.Cashing;
import com.zyjd.cts.model.Stage;
import com.zyjd.cts.service.CashingService;

/**
 * @Transactional(rollbackFor = Exception.class)
 * 添加该注解的方法为Spring事务处理
 */
@Service
public class CashingServiceImpl implements CashingService {

	@Resource
	private StageDao stageDao;

	@Resource
	private CashingDao cashingDao;

	@Resource
	private ContractDetailDao contractDetailDao;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int add(Cashing cashing) {
		int result = 0;
		try {
			// 注：已付清的不能继续添加，未付清的才可能继续添加
			ContractDetail contractDetail = contractDetailDao.findById(cashing.getContractDetailID());
			if(Double.doubleToLongBits(contractDetail.getUnPayQuota()) <= 0) { //已付清
				return result;
			}
			result = cashingDao.add(cashing);
			SyncHasPayCashAndState(cashing);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int delete(int id) {
		Cashing cashing = cashingDao.findById(id);
		int result = 0;
		try {
			result = cashingDao.delete(id);
			SyncHasPayCashAndState(cashing);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int update(Cashing cashing) {
		int result = 0;
		try {
			result = cashingDao.update(cashing);
			SyncHasPayCashAndState(cashing);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public int updateNullByStageID(int id) {
		int result = 0;
		try {
			result = cashingDao.updateNullByStageID(id);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public Cashing findById(int id) {
		return cashingDao.findById(id);
	}

	@Override
	public List<Cashing> findAll() {
		return cashingDao.findAll();
	}

	@Override
	public List<Cashing> findByCondition(Cashing cashing) {
		return cashingDao.findByCondition(cashing);
	}

	@Override
	public List<Cashing> findByConditions(Cashing cashing) { return cashingDao.findByConditions(cashing); }

	@Override
	public List<Cashing> findByConditionPage(Cashing cashing) {
		return cashingDao.findByConditionPage(cashing);
	}

	@Override
	public Double findQuotasByCondition(Cashing cashing) { return cashingDao.findQuotasByCondition(cashing); }

	// 同步合同明细或合同明细分期中已收款及状态
	private void SyncHasPayCashAndState(Cashing cashing){
		// 合同明细
		ContractDetail contractDetail = contractDetailDao.findById(cashing.getContractDetailID());// 属于哪个详情
		if(contractDetail!=null) {
			Double totals = cashingDao.findQuotasByCondition(new Cashing(cashing.getContractDetailID()));// 累计收款额
			if (totals != null) {
				// 已付款额 = 累计收款
				contractDetail.setHasPayQuota(totals);
				// 未付款额 = 应收收款 - 优惠 - 已收款额
				contractDetail.setUnPayQuota(contractDetail.getCanPayQuota()-contractDetail.getProductDiscount()-contractDetail.getHasPayQuota());
				// 付款状态，未收款额 <= 0
				if (Double.doubleToLongBits(contractDetail.getUnPayQuota()) <= 0) {
					if ("未付清".equals(contractDetail.getPayState())) {
						contractDetail.setPayState("已付清");
					}
				} else {
					if ("已付清".equals(contractDetail.getPayState())) {
						contractDetail.setPayState("未付清");
					}
				}
				contractDetailDao.update(contractDetail);// 执行修改
			}else{//仅有一个，且已删除
				// 已付款额 = 累计收款
				contractDetail.setHasPayQuota(0.0);
				// 未付款额 = 应收收款 - 折扣 - 已收款额
				contractDetail.setUnPayQuota(contractDetail.getCanPayQuota()-contractDetail.getProductDiscount()-contractDetail.getHasPayQuota());
				// 付款状态，未收款额 <= 0
				if (Double.doubleToLongBits(contractDetail.getUnPayQuota()) <= 0) {
					if ("未付清".equals(contractDetail.getPayState())) {
						contractDetail.setPayState("已付清");
					}
				} else {
					if ("已付清".equals(contractDetail.getPayState())) {
						contractDetail.setPayState("未付清");
					}
				}
				contractDetailDao.update(contractDetail);// 执行修改
			}
		}else{

		}
		// 合同明细分期
		if (cashing.getStageID() != null) {
			Stage stage = stageDao.findById(cashing.getStageID());// 属于哪个阶段
			if (stage != null) {
				Cashing condition = new Cashing();
				condition.setStageID(cashing.getStageID());// 阶段ID条件
				Double totals = cashingDao.findQuotasByCondition(condition);// 累计收款额
				if(totals!=null) {
					// 已付款额 = 累计收款
					stage.setStageHasPayQuota(totals);
					// 未付款额 = 应收收款 - 坏账 - 已收款额
					stage.setStageUnPayQuota(stage.getStageCanPayQuota()-stage.getStageBadPayQuota()-stage.getStageHasPayQuota());
					// 付款状态，未收款额 <= 0
					if (Double.doubleToLongBits(stage.getStageUnPayQuota()) <= 0) {
						if ("未付清".equals(stage.getStagePayState())) {
							stage.setStagePayState("已付清");
						}
					} else {
						if ("已付清".equals(stage.getStagePayState())) {
							stage.setStagePayState("未付清");
						}
					}
					stageDao.update(stage);// 执行修改
				}else{//仅有一个，且已删除
					// 已付款额 = 累计收款
					stage.setStageHasPayQuota(0.0);
					// 未付款额 = 应收收款 - 坏账 - 已收款额
					stage.setStageUnPayQuota(stage.getStageCanPayQuota()-stage.getStageBadPayQuota()-stage.getStageHasPayQuota());
					// 付款状态，未收款额 <= 0
					if (Double.doubleToLongBits(stage.getStageUnPayQuota()) <= 0) {
						if ("未付清".equals(stage.getStagePayState())) {
							stage.setStagePayState("已付清");
						}
					} else {
						if ("已付清".equals(stage.getStagePayState())) {
							stage.setStagePayState("未付清");
						}
					}
					stageDao.update(stage);// 执行修改
				}
			} else{

			}
		}else{

		}
	}
}
