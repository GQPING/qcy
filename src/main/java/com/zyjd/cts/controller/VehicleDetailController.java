package com.zyjd.cts.controller;

import com.zyjd.cts.model.VehicleDetail;
import com.zyjd.cts.service.VehicleDetailService;
import com.zyjd.cts.util.Layui;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/***
 * 代理车辆信息
 * 后台操作处理
 */
@Controller
@RequestMapping("/vehicleDetail")
public class VehicleDetailController {

    @Autowired
    private VehicleDetailService vehicleDetailService;

    // 详情界面
    /***
     * 进入代理尚车辆信息页面
     * @param id 合同明细ID
     * @param type 合同类型
     * @param model 视图模型
     * @return 页面地址
     */
    @RequestMapping(value = "/detail/{id}/{type}", method = RequestMethod.GET)
    public String Detail(@PathVariable("id") Integer id, @PathVariable("type") String type, Model model) {
        model.addAttribute("type",type);
        model.addAttribute("contractDetailID",id);
        return "contract/list/vehicleDetailList";
    }

    // 列表界面
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String List() {
        return "contract/list/vehicleDetailList";
    }

    // 列表查询(分页)
    @RequestMapping(value = "/searchList", method = RequestMethod.POST)
    @ResponseBody
    public Layui SearchList(@RequestBody VehicleDetail vehicleDetail) {
        // 设置地址
        vehicleDetail.setStart((vehicleDetail.getPage() - 1) * vehicleDetail.getLimit());
        // 查询记录
        List<VehicleDetail> alls = vehicleDetailService.findByCondition(vehicleDetail);
        // 当页记录
        List<VehicleDetail> vehicleDetails = vehicleDetailService.findByConditionPage(vehicleDetail);
        if (vehicleDetails != null && !vehicleDetails.isEmpty()) {
            return Layui.data(alls.size(), vehicleDetails);
        }
        return Layui.data(0, null);
    }

    // 列表查询(不分页)
    @RequestMapping(value = "/searchAll", method = RequestMethod.POST)
    @ResponseBody
    public Layui SearchAll(@RequestBody VehicleDetail vehicleDetail) {
        List<VehicleDetail> alls = vehicleDetailService.findByConditions(vehicleDetail);
        if (alls != null && !alls.isEmpty()) {
            return Layui.data(alls.size(), alls);
        }
        return Layui.data(0, null);
    }

    // 获取车辆
    @RequestMapping(value = "/getList", method = RequestMethod.POST)
    @ResponseBody
    public List<VehicleDetail> getList(@RequestBody VehicleDetail vehicleDetail) {
        return vehicleDetailService.findByConditions(vehicleDetail);
    }

    // 添加车辆
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public String Add(@RequestBody VehicleDetail vehicleDetail) {
        return String.valueOf(vehicleDetailService.add(vehicleDetail));
    }

    // 删除车辆
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public String Delete(@RequestParam(value = "id") Integer id) {
        return String.valueOf(vehicleDetailService.delete(id));
    }

    // 修改车辆
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public String Update(@RequestBody VehicleDetail vehicleDetail) {
        return String.valueOf(vehicleDetailService.update(vehicleDetail));
    }
}
