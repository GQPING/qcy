package com.zyjd.cts.service.impl;

import java.util.List;
import javax.annotation.Resource;
import com.zyjd.cts.dao.ContractDetailDao;
import com.zyjd.cts.dao.StageDao;
import com.zyjd.cts.model.ContractDetail;
import com.zyjd.cts.model.Stage;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.zyjd.cts.dao.BillDao;
import com.zyjd.cts.model.Bill;
import com.zyjd.cts.service.BillService;

/**
 * @Transactional(rollbackFor = Exception.class)
 * 添加该注解的方法为Spring事务处理
 */
@Service
public class BillServiceImpl implements BillService {

	@Resource
	private StageDao stageDao;

	@Resource
	private BillDao billDao;

	@Resource
	private ContractDetailDao contractDetailDao;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int add(Bill bill) {
		int result = 0;
		try {
			result = billDao.add(bill);
			SyncHasBillsAndStates(bill);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int delete(int id) {
		Bill bill = billDao.findById(id);
		int result = 0;
		try {
			result = billDao.delete(id);
			SyncHasBillsAndStates(bill);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int update(Bill bill) {
		int result = 0;
		try {
			result = billDao.update(bill);
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
			result = billDao.updateNullByStageID(id);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	@Override
	public List<Bill> findAll() {
		return billDao.findAll();
	}

	@Override
	public Bill findById(int id) { return billDao.findById(id); }

	@Override
	public List<Bill> findByCondition(Bill bill) {
		return billDao.findByCondition(bill);
	}

	@Override
	public List<Bill> findByConditions(Bill bill) {
		return billDao.findByConditions(bill);
	}

	@Override
	public Double findQuotasByCondition(Bill bill) {
		return billDao.findQuotasByCondition(bill);
	}

	@Override
	public List<Bill> findByConditionPage(Bill bill) {
		return billDao.findByConditionPage(bill);
	}

	// 同步合同明细或合同明细分期中是否开票状态
	private void SyncHasBillsAndStates(Bill bill){
		List<Bill> bills = null;
		Bill condition = new Bill();
		// 合同明细
		if(bill.getContractDetailID()!=null){
			condition.setContractDetailID(bill.getContractDetailID());//指定详情ID
			bills = billDao.findByConditions(condition);
			ContractDetail contractDetail = new ContractDetail();
			if (bills != null && !bills.isEmpty()) {
				contractDetail.setHasBill(1);
			} else {
				contractDetail.setHasBill(0);
			}
			contractDetail.setId(bill.getContractDetailID());
			contractDetailDao.update(contractDetail);// 执行修改
		}else{

		}
		// 合同明细分期
		if(bill.getStageID()!=null) {
			condition.setContractDetailID(null);//不需要指定详情ID
			condition.setStageID(bill.getStageID());//阶段ID,只需要这个
			bills = billDao.findByConditions(condition);
			Stage stage =new Stage();
			if (bills != null && !bills.isEmpty()) {
				stage.setStageHasBill(1);
			} else {
				stage.setStageHasBill(0);
			}
			stage.setId(bill.getStageID());
			stageDao.update(stage);// 执行修改
		}else{

		}
	}
}
