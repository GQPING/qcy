package com.zyjd.cts.controller;

import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;
import cn.hutool.core.util.NumberUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.zyjd.cts.model.ContractDetail;
import com.zyjd.cts.util.Layui;
import com.zyjd.cts.model.Stage;
import com.zyjd.cts.service.ContractDetailService;
import com.zyjd.cts.service.StageService;
import cn.hutool.core.date.DateField;
import cn.hutool.core.date.DateUtil;

/***
 * 分期信息
 * 后台操作处理
 */
@Controller
@RequestMapping("/stage")
public class StageController {

	@Autowired
	private StageService stageService;

	@Autowired
	private ContractDetailService contractDetailService;

	// 详情界面(代理、租赁)
	/***
	 * 进入分期列表界面
	 * @param id 传递参数，合同明细ID
	 * @param type 传递参数，判断代理商、租赁合同
	 * @return 返回页面地址
	 */
	@RequestMapping(value = "/detail/{id}/{type}", method = RequestMethod.GET)
	public String Detail(@PathVariable("id") Integer id, @PathVariable("type") String type, Model model) {
		model.addAttribute("type",type);
		model.addAttribute("contractDetailID",id);
		return "contract/list/stageList";
	}

	// 详情界面(出售)
	/***
	 * 进入分期列表界面
	 * @param id 传递参数，合同明细ID
	 * @param type 传递参数，出售合同
	 * @return 返回页面地址
	 */
	@RequestMapping(value = "/detail2/{id}/{type}", method = RequestMethod.GET)
	public String Detail2(@PathVariable("id") Integer id, @PathVariable("type") String type, Model model) {
		model.addAttribute("type",type);
		model.addAttribute("contractDetailID",id);
		return "contract/list/stageList2";
	}

	// 列表界面
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String List() {
		return "contract/list/stageList";
	}
	
	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody Stage stage) {
		// 设置地址
		stage.setStart((stage.getPage()-1)*stage.getLimit());
		// 查询记录
		List<Stage> alls = stageService.findByCondition(stage);
		// 当页记录
		List<Stage> stages = stageService.findByConditionPage(stage);
		if (stages != null && !stages.isEmpty()) {
			return Layui.data(alls.size(), stages);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody Stage stage) {
		List<Stage> alls = stageService.findByConditions(stage);
		if (alls != null && !alls.isEmpty()) {
			return Layui.data(alls.size(), alls);
		}
		return Layui.data(0, null);
	}

	// 获取阶段(列表)
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<Stage> getList(@RequestBody Stage stage) {
		return stageService.findByConditions(stage);
	}

	// 获取阶段(指定ID)
	@RequestMapping(value = "/getById", method = RequestMethod.POST)
	@ResponseBody
	public Stage GetById(@RequestParam(value = "id") Integer id) {
		return stageService.findById(id);
	}

	// 添加阶段
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody Stage stage) {
		return String.valueOf(stageService.add(stage));
	}

	// 删除阶段
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String Delete(@RequestParam(value = "id") Integer id) {
		return String.valueOf(stageService.delete(id));
	}
	
	// 修改阶段
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String Update(@RequestBody Stage stage) {
		return String.valueOf(stageService.update(stage));
	}

	// 添加阶段(自动划分分期，例如3期、4期、6期)
	@RequestMapping(value = "/addAuto", method = RequestMethod.POST)
	@ResponseBody
	public String AddAuto(@RequestBody Stage stage, @RequestParam(value="type",required = false, defaultValue="4") Integer type) {
		String ret = "";
		// 检测车辆是否存在阶段
		List<Stage> stages = stageService.findByConditions(new Stage(stage.getContractDetailID()));
		if(stages!=null && !stages.isEmpty()) {
			return "2";// 已存在，无法自动划分
		} else {
			// 找到阶段所属车辆
			ContractDetail contractDetail = contractDetailService.findById(stage.getContractDetailID());
			// 检测租赁周期与划分类型
			if(contractDetail.getDateCycle().intValue() <= type) {
				return "3";// 划分周期不足
			} else {
				// 可划分个数
				int count = contractDetail.getDateCycle().intValue() / type;
				double stageQuota = (contractDetail.getCanPayQuota()-contractDetail.getProductDiscount()) / count;// (应收金额-优惠金额）/阶段个数
				// 应收金额
				stage.setStageCanPayQuota(NumberUtil.round(stageQuota,4).doubleValue());
				// 未收金额
				stage.setStageUnPayQuota(NumberUtil.round(stageQuota,4).doubleValue());
				// 阶段开始日期
				stage.setStageStartDate(contractDetail.getStartDate());
				// 循环添加阶段
				for(int i=0;i<count;i++) {
					if(i==0){
						// 第一阶段
						stage.setStageEndDate(DateUtil.offset(DateUtil.offset(stage.getStageStartDate(), DateField.MONTH, type), DateField.DAY_OF_MONTH, -1));
					}else {
						// 其余阶段
						stage.setStageStartDate(DateUtil.offset(stage.getStageEndDate(), DateField.DAY_OF_MONTH, 1));
						stage.setStageEndDate(DateUtil.offset(DateUtil.offset(stage.getStageStartDate(), DateField.MONTH, type), DateField.DAY_OF_MONTH, -1));
					}
					stageService.add(stage);
					stage.setId(null);// 恢复ID状态
				}
				// 检测阶段最后结束日期 < 车辆租赁结束日期，额外另加1个阶段
				if(GetBetweenDays(stage.getStageEndDate(),contractDetail.getFinalDate()) > 0) {
					// 日期时间偏移
					stage.setStageStartDate(DateUtil.offset(stage.getStageEndDate(), DateField.DAY_OF_MONTH, 1));
					stage.setStageEndDate(contractDetail.getFinalDate());
					stageService.add(stage);
				}
				return "1";// 成功添加
			}
		}
	}

	// 获取相差天数
	private long GetBetweenDays(Date start, Date end) {
		return (end.getTime() - start.getTime()) / (1000L * 3600L * 24L);
	}
}
