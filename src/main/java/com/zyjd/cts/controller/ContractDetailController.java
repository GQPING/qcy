package com.zyjd.cts.controller;

import java.util.List;

import cn.hutool.core.date.DateUtil;
import com.zyjd.cts.model.Record;
import com.zyjd.cts.util.FlowloadUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.zyjd.cts.model.ContractDetail;
import com.zyjd.cts.util.Layui;
import com.zyjd.cts.service.ContractDetailService;

/***
 * 合同明细信息
 * 后台操作处理
 */
@Controller
@RequestMapping("/contractDetail")
public class ContractDetailController {

	@Autowired
	private ContractDetailService contractDetailService;

	// 列表界面
	/***
	 * 进入合同列表界面
	 * @param id 传递参数，判断代理商、租赁、出售合同
	 * @return 返回页面地址
	 */
	@RequestMapping(value = "/list/{id}", method = RequestMethod.GET)
	public String List(@PathVariable("id") Integer id) {
		String listUrl = "";
		switch (id){
			case 1:
				listUrl = "contract/list/agent/contractDetailList";break;
			case 2:
				listUrl = "contract/list/rent/contractDetailList";break;
			case 3:
				listUrl = "contract/list/sale/contractDetailList";break;
		}
		return listUrl;
	}

	// 列表查询(分页)
	@RequestMapping(value = "/searchList/{contractType}", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody ContractDetail contractDetail , @PathVariable("contractType") String contractType) {
		// 设置类型
		contractDetail.getContract().setContractType(contractType);
		// 设置地址
		contractDetail.setStart((contractDetail.getPage()-1)*contractDetail.getLimit());
		// 查询记录
		List<ContractDetail> alls = contractDetailService.findByCondition(contractDetail);
		// 当页记录
		List<ContractDetail> contractDetails = contractDetailService.findByConditionPage(contractDetail);
		if (contractDetails != null && !contractDetails.isEmpty()) { 
			return Layui.data(alls.size(), contractDetails);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody ContractDetail contractDetail) {
		List<ContractDetail> alls = contractDetailService.findByConditions(contractDetail);
		if (alls != null && !alls.isEmpty()) {
			return Layui.data(alls.size(), alls);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	/***
	 * @param contractDetail 对象搜索信息
	 * @param contractType 合同类型
	 * @return 返回Bean对象
	 */
	@RequestMapping(value = "/searchAll/{contractType}", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody ContractDetail contractDetail,
						   @PathVariable("contractType") String contractType) {
		// 设置类型
		contractDetail.getContract().setContractType(contractType);
		List<ContractDetail> alls = contractDetailService.findByConditions(contractDetail);
		if (alls != null && !alls.isEmpty()) {
			return Layui.data(alls.size(), alls);
		}
		return Layui.data(0, null);
	}

	// 车辆档案界面
	@RequestMapping(value = "/recordList", method = RequestMethod.GET)
	public String RecordList() {
		return "contract/list/vehicleRecordList";
	}

	// 获取档案
	/***
	 * 流加载数据刷新
	 * @param page 页号
	 * @param vehicleNumber 车架号
	 * @return 返回Bean对象
	 */
	@RequestMapping(value = "/getRecord", method = RequestMethod.POST)
	@ResponseBody
	public Object GetRecord(@RequestParam(value = "page") Integer page,
							@RequestParam(value = "vehicleNumber") String vehicleNumber) {
		ContractDetail contractDetail = new ContractDetail();
		// 设置车架号
		contractDetail.setVehicleNumber(vehicleNumber==""?null:vehicleNumber);
		// 设置页码
		contractDetail.setPage(page);
		// 设置地址
		contractDetail.setStart((contractDetail.getPage() - 1) * contractDetail.getLimit());
		// 总记录
		List<Record> alls = contractDetailService.findByRecord(contractDetail);
		// 总页数
		int pages =  alls.size() / contractDetail.getLimit();
		if(alls.size() % contractDetail.getLimit() != 0){
			pages++;
		}
		// 当页记录
		List<Record> records = contractDetailService.findByRecordPage(contractDetail);
		if(records != null && !records.isEmpty()) {
			return FlowloadUtils.buildResult(pages, records);
		}
		return Layui.data(0, null);
	}

	// 车辆档案详情
	/***
	 * 查询获取车辆的租赁或出售记录
	 * @param vehicleNumber 车架号
	 * @param model 视图模型
	 * @return 返回页面地址
	 */
	@RequestMapping(value = "/recordDetail/{vehicleNumber}", method = RequestMethod.GET)
	public String RecordDetail(@PathVariable("vehicleNumber") String vehicleNumber, Model model) {
		model.addAttribute("vehicleNumber",vehicleNumber);
		ContractDetail condition = new ContractDetail();
		condition.setVehicleNumber(vehicleNumber);
		condition.getContract().setContractType("租赁");
		List<ContractDetail> rentRecords = contractDetailService.findByConditions(condition);
		if(rentRecords!=null && !rentRecords.isEmpty()){
			model.addAttribute("rentRecords",rentRecords);
		}
		condition.getContract().setContractType("出售");
		List<ContractDetail> saleRecords = contractDetailService.findByConditions(condition);
		if(saleRecords!=null && !saleRecords.isEmpty()){
			model.addAttribute("saleRecords",saleRecords);
		}
		return "contract/list/vehicleRecord";
	}

	// 获取合同明细信息
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<ContractDetail> GetList(@RequestBody ContractDetail contractDetail) {
		return contractDetailService.findByCondition(contractDetail);
	}

	// 获取合同明细信息
	@RequestMapping(value = "/getById", method = RequestMethod.POST)
	@ResponseBody
	public ContractDetail GetById(@RequestParam(value = "id") Integer id) {
		return contractDetailService.findById(id);
	}
	
	// 添加合同明细信息
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody ContractDetail contractDetail) {
		return String.valueOf(contractDetailService.add(contractDetail));
	}

	// 删除合同明细信息
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String Delete(@RequestParam(value = "id") Integer id) {
		return String.valueOf(contractDetailService.delete(id));
	}

	// 修改合同明细信息
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String Update(@RequestBody ContractDetail contractDetail) {
		return String.valueOf(contractDetailService.update(contractDetail));
	}

	// 检测重复性(同一合同编号、同一车架号下不可以同时出现两次)
	@RequestMapping(value = "/check", method = RequestMethod.POST)
	@ResponseBody
	public ContractDetail Check(@RequestBody ContractDetail contractDetail) {
		List<ContractDetail> contractDetails = contractDetailService.findByConditions(contractDetail);
		if(contractDetails!=null && !contractDetails.isEmpty()
				&& contractDetails.size()==1){
			//修改操作提交检测，过滤掉合同明细本身
			if(contractDetail.getId()!=null && contractDetail.getId() == contractDetails.get(0).getId()){
				return null;
			}
			//添加或修改产生，合同明细已存在
			return contractDetails.get(0);
		}
		return null;//合同明细不存在
	}
}
