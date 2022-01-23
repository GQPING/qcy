package com.zyjd.cts.service.impl;

import com.zyjd.cts.dao.VehicleDetailDao;
import com.zyjd.cts.model.VehicleDetail;
import com.zyjd.cts.service.VehicleDetailService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import javax.annotation.Resource;
import java.util.List;

/**
 * @Transactional(rollbackFor = Exception.class)
 * 添加该注解的方法为Spring事务处理
 */
@Service
public class VehicleDetailServiceImpl implements VehicleDetailService {

    @Resource
    private VehicleDetailDao vehicleDetailDao;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int add(VehicleDetail vehicleDetail) {
        int result = 0;
        try {
            result = vehicleDetailDao.add(vehicleDetail);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int update(VehicleDetail vehicleDetail) {
        int result = 0;
        try {
            result = vehicleDetailDao.update(vehicleDetail);
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
            result = vehicleDetailDao.delete(id);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return result;
    }

    @Override
    public List<VehicleDetail> findAll() {
        return vehicleDetailDao.findAll();
    }

    @Override
    public VehicleDetail findById(int id) {
        return vehicleDetailDao.findById(id);
    }

    @Override
    public List<VehicleDetail> findByCondition(VehicleDetail vehicleDetail) {
        return vehicleDetailDao.findByCondition(vehicleDetail);
    }

    @Override
    public List<VehicleDetail> findByConditions(VehicleDetail vehicleDetail) {
        return vehicleDetailDao.findByConditions(vehicleDetail);
    }

    @Override
    public List<VehicleDetail> findByConditionPage(VehicleDetail vehicleDetail) {
        return vehicleDetailDao.findByConditionPage(vehicleDetail);
    }
}
