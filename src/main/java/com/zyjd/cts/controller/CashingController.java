package com.zyjd.cts.controller;

import java.util.List;

import com.zyjd.cts.model.Stage;
import com.zyjd.cts.service.StageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.zyjd.cts.model.Cashing;
import com.zyjd.cts.util.Layui;
import com.zyjd.cts.service.CashingService;

/***
 * 合同收款
 * 后台操作处理
 */
@Controller
@RequestMapping("/cash")
public class CashingController {

	@Autowired
	private StageService stageService;
	
	@Autowired
	private CashingService cashingService;

	// 详情界面
	/***
	 * 位于合同明细处的收款按钮
	 * @param contractDetailID 合同明细ID
	 * @param type 合同类型
	 * @param model 视图模型
	 * @return 返回页面地址
	 */
	@RequestMapping(value = "/detail/{contractDetailID}/{type}", method = RequestMethod.GET)
	public String Detail1(@PathVariable("contractDetailID") Integer contractDetailID, @PathVariable("type") String type, Model model) {
		model.addAttribute("type",type);
		model.addAttribute("contractDetailID",contractDetailID);
		return "contract/list/cashList";
	}

	// 详情界面
	/***
	 * 位于合同明细->分期信息中收款按钮
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
		return "contract/list/cashList2";
	}

	// 列表界面
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String List() {
		return "contract/list/cashList";
	}
	
	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody Cashing cashing) {
		// 设置地址
		cashing.setStart((cashing.getPage() - 1) * cashing.getLimit());
		// 查询记录
		List<Cashing> alls = cashingService.findByCondition(cashing);
		// 当页记录
		List<Cashing> customers = cashingService.findByConditionPage(cashing);
		if (customers != null && !customers.isEmpty()) {
			return Layui.data(alls.size(), customers);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody Cashing cashing) {
		List<Cashing> alls = cashingService.findByConditions(cashing);
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

	// 获取收款
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<Cashing> getList(@RequestBody Cashing cashing) {
		return cashingService.findByConditions(cashing);
	}

	// 添加收款
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody Cashing cashing) {
		return String.valueOf(cashingService.add(cashing));
	}
	
	// 删除收款
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String Delete(@RequestParam(value = "id") Integer id) {
		return String.valueOf(cashingService.delete(id));
	}

	// 修改收款
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String Update(@RequestBody Cashing cashing) {
		return String.valueOf(cashingService.update(cashing));
	}
}
