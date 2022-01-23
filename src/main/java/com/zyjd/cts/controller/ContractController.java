package com.zyjd.cts.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.zyjd.cts.model.ContractDetail;
import com.zyjd.cts.model.Stage;
import com.zyjd.cts.model.Total;
import com.zyjd.cts.service.ContractDetailService;
import com.zyjd.cts.service.StageService;
import com.zyjd.cts.vo.SalesBean;
import com.zyjd.cts.vo.UnitsBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.zyjd.cts.model.Contract;
import com.zyjd.cts.util.Layui;
import com.zyjd.cts.service.ContractService;
import cn.hutool.core.date.DateUtil;

/***
 * 合同信息
 * 后台操作处理
 */
@Controller
@RequestMapping("/contract")
public class ContractController {

	@Autowired
	private StageService stageService;

	@Autowired
	private ContractService contractService;

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
				listUrl = "contract/list/agent/contractList";break;
			case 2:
				listUrl = "contract/list/rent/contractList";break;
			case 3:
				listUrl = "contract/list/sale/contractList";break;
		}
		return listUrl;
	}

	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody Contract contract) {
		// 设置地址
		contract.setStart((contract.getPage()-1)*contract.getLimit());
		// 查询记录
		List<Contract> alls = contractService.findByCondition(contract);
		// 当页记录
		List<Contract> contracts = contractService.findByConditionPage(contract);
		if (contracts != null && !contracts.isEmpty()) { 
			return Layui.data(alls.size(), contracts);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody Contract contract) {
		List<Contract> alls = contractService.findByConditions(contract);
		if (alls != null && !alls.isEmpty()) {
			return Layui.data(alls.size(), alls);
		}
		return Layui.data(0, null);
	}
	
	// 获取合同
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<Contract> GetList(@RequestBody Contract contract) {
		return contractService.findByCondition(contract);
	}

	// 添加界面(主页快速添加按钮处触发)
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String Add() {
		return "contract/add";
	}

	// 添加合同
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody Contract contract) {
		return String.valueOf(contractService.add(contract));
	}

	// 删除合同
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String Delete(@RequestParam(value = "id") Integer id) {
		return String.valueOf(contractService.delete(id));
	}

	// 修改合同
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String Update(@RequestBody Contract contract) {
		return String.valueOf(contractService.update(contract));
	}

	// 分类统计汇总界面(饼状图)
	@RequestMapping(value = "/sorts", method = RequestMethod.GET)
	public String Sorts() {
		return "contract/report/sorts";
	}

	// 查询合同分类数量统计(饼状图)
	@RequestMapping(value = "/searchSorts", method = RequestMethod.POST)
	@ResponseBody
	public UnitsBean SearchSortsBean(@RequestParam(value = "time") String time) {
		Integer count = null;
		UnitsBean bean = new UnitsBean();
		if (time != null && !"".equals(time)) {
			if(time.contains("-")) {
				// 按月汇总
				Contract month = new Contract(DateUtil.parse(time, "yyyy-MM"));
				month.setIsMonth(1);
				count = contractService.findCountByCondition(month);
				bean.setTotalContacts(count==null?0:count);
				month.setContractType("代理商");
				count = contractService.findCountByCondition(month);
				bean.setAgentContacts(count==null?0:count);
				month.setContractType("出售");
				count = contractService.findCountByCondition(month);
				bean.setSalesContacts(count==null?0:count);
				month.setContractType("租赁");
				count = contractService.findCountByCondition(month);
				bean.setRentContacts(count==null?0:count);
			}else {
				// 按年汇总
				Contract year = new Contract(DateUtil.parse(time, "yyyy"));
				year.setIsYear(1);
				count = contractService.findCountByCondition(year);
				bean.setTotalContacts(count==null?0:count);
				year.setContractType("代理商");
				count = contractService.findCountByCondition(year);
				bean.setAgentContacts(count==null?0:count);
				year.setContractType("出售");
				count = contractService.findCountByCondition(year);
				bean.setSalesContacts(count==null?0:count);
				year.setContractType("租赁");
				count = contractService.findCountByCondition(year);
				bean.setRentContacts(count==null?0:count);
			}
		}
		return bean;
	}

	// 车辆统计汇总界面(柱状图)
	@RequestMapping(value = "/rentUnits", method = RequestMethod.GET)
	public String RentUnits() {
		return "contract/report/rentUnits";
	}

	// 查询车辆统计汇总(柱状图)
	@RequestMapping(value = "/searchRentUnits", method = RequestMethod.POST)
	@ResponseBody
	public List<UnitsBean> SearchRentUnitsBean(@RequestParam(value = "time") String time) {
		int year = DateUtil.year(new Date());// 取得当年年份
		if(!"".equals(time)){
			try {
				year = Integer.parseInt(time);// 字符串转化成年份条件
			}catch(Exception e){
				year = DateUtil.year(new Date());// 发生异常时，默认当年
			}
		}
		Integer count = 0;
		UnitsBean bean = null;
		List<UnitsBean> beans = new ArrayList<UnitsBean>();
		ContractDetail condition = new ContractDetail();
		condition.setIsMonth(1);// 按月汇总
		for (int i = 1; i <= 12; i++) {
			bean = new UnitsBean();// 每个月创建一个
			String dateStr = year + "-" + (i < 10 ? "0" + i : "" + i);
			condition.setExportDate(DateUtil.parse(dateStr, "yyyy-MM"));
			// 租赁
			condition.getContract().setContractType("租赁");
			count = contractDetailService.findCountByCondition(condition);
			bean.setRentsVehicles(count==null?0:count);
			condition.setPayState("已付清");
			count = contractDetailService.findCountByCondition(condition);
			bean.setRentsInPayVehicles(count==null?0:count);
			condition.setPayState("未付清");
			count = contractDetailService.findCountByCondition(condition);
			bean.setRentsUnPayVehicles(count==null?0:count);
			beans.add(bean);
		}
		return beans;
	}

	// 出售车辆统计汇总界面(柱状图)
	@RequestMapping(value = "/saleUnits", method = RequestMethod.GET)
	public String SaleUnits() {
		return "contract/report/saleUnits";
	}

	// 查询出售车辆统计汇总(柱状图)
	@RequestMapping(value = "/searchSaleUnits", method = RequestMethod.POST)
	@ResponseBody
	public List<UnitsBean> SearchSaleUnitsBean(@RequestParam(value = "time") String time) {
		int year = DateUtil.year(new Date());// 取得当年年份
		if(!"".equals(time)){
			try {
				year = Integer.parseInt(time);// 字符串转化成年份条件
			}catch(Exception e){
				year = DateUtil.year(new Date());// 发生异常时，默认当年
			}
		}
		Integer count = 0;
		UnitsBean bean = null;
		List<UnitsBean> beans = new ArrayList<UnitsBean>();
		ContractDetail condition = new ContractDetail();
		condition.setIsMonth(1);// 按月汇总
		for (int i = 1; i <= 12; i++) {
			bean = new UnitsBean();// 每个月创建一个
			String dateStr = year + "-" + (i < 10 ? "0" + i : "" + i);
			condition.setExportDate(DateUtil.parse(dateStr, "yyyy-MM"));
			condition.getContract().setContractType("出售");
			count = contractDetailService.findCountByCondition(condition);
			bean.setSalesVehicles(count==null?0:count);
			condition.setPayState("已付清");
			count = contractDetailService.findCountByCondition(condition);
			bean.setSalesInPayVehicles(count==null?0:count);
			condition.setPayState("未付清");
			count = contractDetailService.findCountByCondition(condition);
			bean.setSalesUnPayVehicles(count==null?0:count);
			beans.add(bean);
		}
		return beans;
	}

	// 代理合同统计汇总界面(柱状图)
	@RequestMapping(value = "/agentUnits", method = RequestMethod.GET)
	public String AgentUnits() {
		return "contract/report/agentUnits";
	}

	// 查询代理车辆统计汇总(柱状图)
	@RequestMapping(value = "/searchAgentUnits", method = RequestMethod.POST)
	@ResponseBody
	public List<UnitsBean> SearchAgentUnitsBean(@RequestParam(value = "time") String time) {
		int year = DateUtil.year(new Date());// 取得当年年份
		if(!"".equals(time)){
			try {
				year = Integer.parseInt(time);// 字符串转化成年份条件
			}catch(Exception e){
				year = DateUtil.year(new Date());// 发生异常时，默认当年
			}
		}
		Integer count = 0;
		UnitsBean bean = null;
		List<UnitsBean> beans = new ArrayList<UnitsBean>();
		ContractDetail condition = new ContractDetail();
		condition.setIsMonth(1);// 按月汇总
		for (int i = 1; i <= 12; i++) {
			bean = new UnitsBean();// 每个月创建一个
			String dateStr = year + "-" + (i < 10 ? "0" + i : "" + i);
			condition.setExportDate(DateUtil.parse(dateStr, "yyyy-MM"));
			condition.getContract().setContractType("代理商");
			count = contractDetailService.findCountByCondition(condition);
			bean.setAgentContacts(count==null?0:count);
			condition.setPayState("已付清");
			count = contractDetailService.findCountByCondition(condition);
			bean.setAgentInPayContacts(count==null?0:count);
			condition.setPayState("未付清");
			count = contractDetailService.findCountByCondition(condition);
			bean.setAgentUnPayContacts(count==null?0:count);
			beans.add(bean);
		}
		return beans;
	}

	/*以下汇总报表因系统初始需求变化，需要时自行根据实际需求修改调试*/
	/*
	// 销售额统计汇总界面(柱状图)
	@RequestMapping(value = "/sales", method = RequestMethod.GET)
	public String Sales() {
		return "contract/other/totals/sales";
	}
	
	// 查询销售额统计汇总(柱状图)
	@RequestMapping(value = "/searchSales", method = RequestMethod.POST)
	@ResponseBody
	public List<SalesBean> SearchSalesBean(@RequestParam(value = "time") String time, @RequestParam(value = "type") String type) {
		int year = DateUtil.year(new Date());// 取得当年年份
		if(!"".equals(time)){
			try {
				year = Integer.parseInt(time);// 字符串转化成年份条件
			}catch(Exception e){
				year = DateUtil.year(new Date());// 发生异常时，默认当年
			}
		}
		Total total = null;
		SalesBean bean = null;
		ContractDetail condition = new ContractDetail();
		condition.setIsMonth(1);// 按月汇总
		List<SalesBean> beans = new ArrayList<SalesBean>();
		for (int i = 1; i <= 12; i++) {
			bean = new SalesBean();// 每个月创建一个
			String dateStr = year + "-" + (i < 10 ? "0" + i : "" + i);
			condition.setExportDate(DateUtil.parse(dateStr, "yyyy-MM"));
			switch(type){
				case "1"://合计
					total = contractDetailService.findTotalByCondition(condition);
					if(total!=null){
						bean.setTotalCanQuota(GetQuotas(total.getCanQuotas()));
						bean.setTotalDisQuota(GetQuotas(total.getDiscounts()));
						bean.setTotalHasQuota(GetQuotas(total.getInQuotas()));
						bean.setTotalNonQuota(GetQuotas(total.getUnQuotas()));
					}
					condition.setIsDeadLine(1);// 到期查询
					total = contractDetailService.findTotalByCondition(condition);
					if(total!=null){
						bean.setTotalEndHasQuota(GetQuotas(total.getInQuotas()));
						bean.setTotalEndNonQuota(GetQuotas(total.getUnQuotas()));
					}
					break;
				case "2"://代理商
					condition.getContract().setContractType("代理商");
					total = contractDetailService.findTotalByCondition(condition);
					if(total!=null){
						bean.setAgentCanQuota(GetQuotas(total.getCanQuotas()));
						bean.setAgentDisQuota(GetQuotas(total.getDiscounts()));
						bean.setAgentHasQuota(GetQuotas(total.getInQuotas()));
						bean.setAgentNonQuota(GetQuotas(total.getUnQuotas()));
					}
					condition.setIsDeadLine(1);// 到期查询
					total = contractDetailService.findTotalByCondition(condition);
					if(total!=null) {
						bean.setAgentEndHasQuota(GetQuotas(total.getInQuotas()));
						bean.setAgentEndNonQuota(GetQuotas(total.getUnQuotas()));
					}
					break;
				case "3"://出售
					condition.getContract().setContractType("出售");
					total = contractDetailService.findTotalByCondition(condition);
					if(total!=null){
						bean.setSalesCanQuota(GetQuotas(total.getCanQuotas()));
						bean.setSalesDisQuota(GetQuotas(total.getDiscounts()));
						bean.setSalesHasQuota(GetQuotas(total.getInQuotas()));
						bean.setSalesNonQuota(GetQuotas(total.getUnQuotas()));
					}
					condition.setIsDeadLine(1);// 到期查询
					total = contractDetailService.findTotalByCondition(condition);
					if(total!=null){
						bean.setSalesEndHasQuota(GetQuotas(total.getInQuotas()));
						bean.setSalesEndNonQuota(GetQuotas(total.getUnQuotas()));
					}
					break;
				case "4"://租赁
					condition.getContract().setContractType("租赁");
					total = contractDetailService.findTotalByCondition(condition);
					if(total!=null){
						bean.setRentsCanQuota(GetQuotas(total.getCanQuotas()));
						bean.setRentsDisQuota(GetQuotas(total.getDiscounts()));
						bean.setRentsHasQuota(GetQuotas(total.getInQuotas()));
						bean.setRentsNonQuota(GetQuotas(total.getUnQuotas()));
					}
					condition.setIsDeadLine(1);// 到期查询
					total = contractDetailService.findTotalByCondition(condition);
					if(total!=null){
						bean.setRentsEndHasQuota(GetQuotas(total.getInQuotas()));
						bean.setRentsEndNonQuota(GetQuotas(total.getUnQuotas()));
					}
					break;
			}
			beans.add(bean);
		}
		return beans;
	}

	// 分期额统计汇总界面(柱状图)
	@RequestMapping(value = "/stages", method = RequestMethod.GET)
	public String Stages() {
		return "contract/other/totals/stages";
	}

	// 查询分期额统计汇总(柱状图)
	@RequestMapping(value = "/searchStages", method = RequestMethod.POST)
	@ResponseBody
	public List<SalesBean> SearchStagesBean(@RequestParam(value = "time") String time) {
		int year = DateUtil.year(new Date());// 取得当年年份
		if(!"".equals(time)){
			try {
				year = Integer.parseInt(time);// 字符串转化成年份条件
			}catch(Exception e){
				year = DateUtil.year(new Date());// 发生异常时，默认当年
			}
		}
		Total total = null;
		SalesBean bean = null;
		List<SalesBean> beans = new ArrayList<SalesBean>();
		Stage condition = new Stage();
		condition.setIsMonth(1);// 按月汇总
		for (int i = 1; i <= 12; i++) {
			bean = new SalesBean();// 每个月创建一个
			String dateStr = year + "-" + (i < 10 ? "0" + i : "" + i);
			condition.setSearchDate(DateUtil.parse(dateStr, "yyyy-MM"));
			total = stageService.findQuotasByCondition(condition);
			if(total!=null){
				bean.setStageCanQuota(GetQuotas(total.getCanQuotas()));
				bean.setStageBadQuota(GetQuotas(total.getDiscounts()));
				bean.setStageHasQuota(GetQuotas(total.getInQuotas()));
				bean.setStageNonQuota(GetQuotas(total.getUnQuotas()));
			}
			condition.setIsDeadLine(1);// 到期查询
			total = stageService.findQuotasByCondition(condition);
			if(total!=null){
				bean.setStageEndHasQuota(GetQuotas(total.getInQuotas()));
				bean.setStageEndNonQuota(GetQuotas(total.getUnQuotas()));
			}
			beans.add(bean);
		}
		return beans;
	}

	// 获取额度(为null时，默认为0)
	private Double GetQuotas(Double quota) {
		return quota == null ? 0.0 : quota;
	}*/
}
