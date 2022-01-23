package com.zyjd.cts.controller;

import java.util.List;
import com.zyjd.cts.model.Stage;
import com.zyjd.cts.service.StageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.zyjd.cts.model.Bill;
import com.zyjd.cts.util.Layui;
import com.zyjd.cts.service.BillService;

/***
 * 合同开票
 * 后台操作处理
 */
@Controller
@RequestMapping("/bill")
public class BillController {
	
	@Autowired
	private BillService billService;

	@Autowired
	private StageService stageService;

	// 详情界面
	/***
	 * 位于合同明细处的开票按钮
	 * @param contractDetailID 合同明细ID
	 * @param type 合同类型
	 * @param model 视图模型
	 * @return 返回页面地址
	 */
	@RequestMapping(value = "/detail/{contractDetailID}/{type}", method = RequestMethod.GET)
	public String Detail1(@PathVariable("contractDetailID") Integer contractDetailID, @PathVariable("type") String type, Model model) {
		model.addAttribute("type",type);
		model.addAttribute("contractDetailID",contractDetailID);
		return "contract/list/billList";
	}

	// 详情界面
	/***
	 * 位于合同明细->分期信息中开票按钮
	 * @param contractDetailID 合同明细ID
	 * @param stageID 分期ID
	 * @param type 合同类型
	 * @param model 视图模型
	 * @return 返回页面地址
	 */
	@RequestMapping(value = "/detail/{contractDetailID}/{stageID}/{type}", method = RequestMethod.GET)
	public String Detail2(@PathVariable("contractDetailID") Integer contractDetailID,
						  @PathVariable("stageID") Integer stageID, @PathVariable("type") String type, Model model) {
		model.addAttribute("type",type);
		model.addAttribute("stageID",stageID);
		model.addAttribute("contractDetailID",contractDetailID);
		return "contract/list/billList2";
	}

	// 列表界面
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String List() {
		return "contract/list/billList";
	}
	
	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody Bill bill) {
		// 设置地址
		bill.setStart((bill.getPage() - 1) * bill.getLimit());
		// 查询记录
		List<Bill> alls = billService.findByCondition(bill);
		// 当页记录
		List<Bill> bills = billService.findByConditionPage(bill);
		if (bills != null && !bills.isEmpty()) {
			return Layui.data(alls.size(), bills);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody Bill bill) {
		List<Bill> alls = billService.findByConditions(bill);
		if (alls != null && !alls.isEmpty()) {
			// 设置查找所属分期
			for(int i = 0;i < alls.size();i++){
				Integer stageID = alls.get(i).getStageID();
				if(stageID!=null){
					Stage stage = stageService.findById(alls.get(i).getStageID());
					if(stage!=null){
						alls.get(i).setStage(stage);
					}
				}
			}
			return Layui.data(alls.size(), alls);
		}
		return Layui.data(0, null);
	}

	// 获取开票
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<Bill> getList(@RequestBody Bill bill) {
		return billService.findByConditions(bill);
	}

	// 添加开票
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody Bill bill) {
		return String.valueOf(billService.add(bill));
	}

	// 删除开票
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String Delete(@RequestParam(value = "id") Integer id) { return String.valueOf(billService.delete(id)); }

	// 修改开票
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String Update(@RequestBody Bill bill) {
		return String.valueOf(billService.update(bill));
	}
}