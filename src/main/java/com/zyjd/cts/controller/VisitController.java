package com.zyjd.cts.controller;

import java.util.List;
import com.zyjd.cts.model.Bill;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.zyjd.cts.util.Layui;
import com.zyjd.cts.model.Visit;
import com.zyjd.cts.service.VisitService;

/***
 * 回访信息
 * 后台操作处理
 */
@Controller
@RequestMapping("/visit")
public class VisitController {

	@Autowired
	private VisitService visitService;

	// 详情界面
	/***
	 * 位于客户列表中回访按钮
	 * @param id 客户ID
	 * @param model 视图模型
	 * @return 返回页面地址
	 */
	@RequestMapping(value = "/detail/{id}", method = RequestMethod.GET)
	public String Detail(@PathVariable("id") Integer id, Model model) {
		model.addAttribute("customerID",id);
		return "customer/list/visitList";
	}

	// 列表界面
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String List() {
		return "customer/list/visitList";
	}

	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody Visit visit) {
		// 设置地址
		visit.setStart((visit.getPage() - 1) * visit.getLimit());
		// 查询记录
		List<Visit> alls = visitService.findByCondition(visit);
		// 当页记录
		List<Visit> visits = visitService.findByConditionPage(visit);
		if (visits != null && !visits.isEmpty()) {
			return Layui.data(alls.size(), visits);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody Visit visit) {
		List<Visit> alls = visitService.findByConditions(visit);
		if (alls != null && !alls.isEmpty()) {
			return Layui.data(alls.size(), alls);
		}
		return Layui.data(0, null);
	}

	// 获取回访
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<Visit> getList(@RequestBody Visit visit) {
		return visitService.findByConditions(visit);
	}

	// 添加回访
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody Visit visit) {
		return String.valueOf(visitService.add(visit));
	}

	// 删除回访
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String Delete(@RequestParam(value = "id") Integer id) {
		return String.valueOf(visitService.delete(id));
	}

	// 修改回访
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String Update(@RequestBody Visit visit) {
		return String.valueOf(visitService.update(visit));
	}
}
