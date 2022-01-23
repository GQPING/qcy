package com.zyjd.cts.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.zyjd.cts.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.zyjd.cts.util.Layui;
import com.zyjd.cts.service.CashingService;
import com.zyjd.cts.service.ContractDetailService;
import com.zyjd.cts.service.ContractService;
import com.zyjd.cts.service.CustomerService;
import com.zyjd.cts.service.StageService;
import com.zyjd.cts.service.UserService;
import com.zyjd.cts.util.TreeVo;
import com.zyjd.cts.vo.TotalBean;

/***
 * 全局控制器
 */
@Controller
public class MyController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private StageService stageService;
	
	@Autowired
	private CashingService cashingService;
	
	@Autowired
	private ContractService contractService;
	
	@Autowired
	private CustomerService customerService;

	@Autowired
	private HelperController helperController;
	
	@Autowired
	private ContractDetailService contractDetailService;

	// 首页界面
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String Index() {
		return "other/index";
	}

	// 欢迎界面
	@RequestMapping(value = "/welcome", method = RequestMethod.GET)
	public String Welcome(Model model) {

		Integer totals = 0 , todays = 0;
		TotalBean bean = new TotalBean();
		Contract contract = new Contract();
		ContractDetail contractDetail = new ContractDetail();

		// 个数合计查询
		contract.setIsToday(null);
		contract.setContractType(null);
		totals = contractService.findCountByCondition(contract);
		bean.setTotalContacts(totals==null?0:totals);

		contract.setContractType("租赁");
		totals = contractService.findCountByCondition(contract);
		bean.setTotalRents(totals==null?0:totals);

		contract.setContractType("出售");
		totals = contractService.findCountByCondition(contract);
		bean.setTotalSales(totals==null?0:totals);

		contract.setContractType("代理商");
		totals = contractService.findCountByCondition(contract);
		bean.setTotalAgents(totals==null?0:totals);

		// 个数今日查询
		contract.setIsToday(1);
		contract.setContractType(null);
		totals = contractService.findCountByCondition(contract);
		bean.setTodayContacts(totals==null?0:totals);

		contract.setContractType("租赁");
		totals = contractService.findCountByCondition(contract);
		bean.setTodayRents(totals==null?0:totals);

		contract.setContractType("出售");
		totals = contractService.findCountByCondition(contract);
		bean.setTodaySales(totals==null?0:totals);

		contract.setContractType("代理商");
		totals = contractService.findCountByCondition(contract);
		bean.setTodayAgents(totals==null?0:totals);

		// 销售额合计查询
		contractDetail.setIsToday(null);
		Total total = contractDetailService.findTotalByCondition(contractDetail);
		if (total != null) {
			bean.setTotalQuotas(total.getCanQuotas()==null?0.0:total.getCanQuotas());
			bean.setTotalDiscounts(total.getDiscounts()==null?0.0:total.getDiscounts());
			bean.setTotalHasQuotas(total.getInQuotas()==null?0.0:total.getInQuotas());
			bean.setTotalUnQuotas(total.getUnQuotas()==null?0.0:total.getUnQuotas());
		}

		// 销售额今日查询
		contractDetail.setIsToday(1);
		total = contractDetailService.findTotalByCondition(contractDetail);
		if (total != null) {
			bean.setTodayQuotas(total.getCanQuotas()==null?0.0:total.getCanQuotas());
			bean.setTodayDiscounts(total.getDiscounts()==null?0.0:total.getDiscounts());
			bean.setTodayHasQuotas(total.getInQuotas()==null?0.0:total.getInQuotas());
			bean.setTodayUnQuotas(total.getUnQuotas()==null?0.0:total.getUnQuotas());
		}

		model.addAttribute("bean", bean);
		return "other/welcome";
	}

	// 主页界面
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String Main(Model model, HttpSession session) {
		User currentUser = (User) session.getAttribute("CurrentUser");
		if (currentUser == null) {
			return "redirect:user/login";// 未登录，重新登录
		} else {
			List<Permission> temps = new ArrayList<Permission>();//临时变量
			temps.addAll(currentUser.getPermissions().stream().filter(s -> "到期提醒".equals(s.getMenu().getMenuName().toString())).collect(Collectors.toList()));
			// 设置提供弹窗提醒标志
			if(!temps.isEmpty()){
				model.addAttribute("IsPop",1);
			} else{
				model.addAttribute("IsPop",0);
			}
			return "main";
		}
	}

	// 退出系统
	@RequestMapping(value = "/exit", method = RequestMethod.GET)
	public String Exit(HttpSession session) {
		User user = (User)session.getAttribute("CurrentUser");
		if(user!=null) {
			helperController.Logs("退出了系统");
		}
		session.invalidate();// 销毁当前会话
		return "redirect:index.jsp";
	}

	// 提醒弹窗链接
	@RequestMapping(value = "/remind", method = RequestMethod.GET)
	public String Remind() {
		return "contract/remind";
	}

	// 代理商、租赁详情提醒
	/***
	 * 代理商、租赁、出售等合同到期信息
	 * @param contractDetail 合同明细对象
	 * @param id 指明类型
	 * @param customerID 客户ID
	 * @return 返回Bean对象
	 */
	@RequestMapping(value = "/contractDetailRemind/{id}/{customerID}", method = RequestMethod.POST)
	@ResponseBody
	public Layui ContractDetailRemind(@RequestBody ContractDetail contractDetail, @PathVariable(value = "id") Integer id, @PathVariable(value = "customerID") Integer customerID) {
		// 设置客户
		contractDetail.getContract().setCustomerID(customerID==-1?null:customerID);
		// 设置类型
		contractDetail.getContract().setContractType(id==1?"代理商":id==2?"租赁":"出售");
		// 设置状态
		contractDetail.getContract().setContractState("正常");// 默认只查询正常合同的到期数据
		// 设置地址
		contractDetail.setStart((contractDetail.getPage() - 1) * contractDetail.getLimit());
		// 查询记录
		List<ContractDetail> allList = contractDetailService.findByCondition(contractDetail);
		// 当页记录
		List<ContractDetail> contractDetailList = contractDetailService.findByConditionPage(contractDetail);
		if (contractDetailList != null && !contractDetailList.isEmpty()) {
			return Layui.data(allList.size(), contractDetailList);
		}
		return Layui.data(0, null);
	}

	// 回款阶段提醒
	/***
	 * 代理商、租赁分期等到期信息
	 * @param stage 分期对象
	 * @param id 指明类型
	 * @param customerID 客户ID
	 * @return 返回Bean对象
	 */
	@RequestMapping(value = "/stageRemind/{id}/{customerID}", method = RequestMethod.POST)
	@ResponseBody
	public Layui StageRemind(@RequestBody Stage stage, @PathVariable(value = "id") Integer id, @PathVariable(value = "customerID") Integer customerID) {
		// 设置类型
		stage.getContractDetail().getContract().setContractType(id==1?"租赁":"代理商");
		// 设置状态
		stage.getContractDetail().getContract().setContractState("正常");// 默认只查询正常合同的到期数据
		// 设置客户
		stage.getContractDetail().getContract().setCustomerID(customerID==-1?null:customerID);
		// 设置地址
		stage.setStart((stage.getPage() - 1) * stage.getLimit());
		// 查询记录
		List<Stage> allList = stageService.findByCondition(stage);
		// 当页记录
		List<Stage> stageList = stageService.findByConditionPage(stage);
		if (stageList != null && !stageList.isEmpty()) {
			return Layui.data(allList.size(), stageList);
		}
		return Layui.data(0, null);
	}

	/**以下均为售后车辆查询，因系统初始需求变化，需要时自行修改调试**/
	// 合同客户查询车辆
	@RequestMapping(value = "/seachByCustomer", method = RequestMethod.GET)
	public String SeachByCustomer() {
		return "contract/service/searchByCustomer";
	}
	
	// 合同客户查询操作
	@RequestMapping(value = "/getSearchByCustomer", method = RequestMethod.POST)
	@ResponseBody
	public Object GetSearchByCustomer(@RequestParam(value = "id") Integer id, HttpServletRequest request) {
		// 根据ID查询指定合同
		Customer customer = customerService.findById(id);
		TreeVo<String> root = new TreeVo<String>();
		root.setId(0);// 默认ID
		root.setTitle("所有数据");
		if (customer != null) {
			root.setHasChildren(true);// 有孩子节点
			TreeVo<String> tree = new TreeVo<String>();
			List<TreeVo<String>> trees = new ArrayList<TreeVo<String>>();
			tree.setId(id);
			tree.setTitle(customer.getCustomerName());
			tree.setHref(null);
			tree.setHasParent(true);
			tree.setParentId(root.getId());
			// 遍历合同
			List<Contract> contracts = contractService.findByConditions(new Contract(customer.getId()));
			if(contracts!=null && !contracts.isEmpty()){
				tree.setHasChildren(true);// 有孩子节点
				TreeVo<String> treeVo1 = null;
				List<TreeVo<String>> childs1 = new ArrayList<TreeVo<String>>();
				for(Contract contract : contracts) {
					if("代理商".equals(contract.getContractType())){
						continue;// 代理商移除，因为它的合同明细不含有车架号
					}
					treeVo1 = new TreeVo<String>();
					treeVo1.setId(contract.getId());
					treeVo1.setTitle(contract.getContractNumber()+":"+contract.getContractType());
					treeVo1.setHref(null);
					treeVo1.setHasParent(true);
					treeVo1.setParentId(tree.getId());
					// 遍历车辆
					List<ContractDetail> contractDetails = contractDetailService.findByConditions(new ContractDetail(contract.getId()));
					if(contractDetails!=null && !contractDetails.isEmpty()) {
						treeVo1.setHasChildren(true);// 有孩子节点
						TreeVo<String> treeVo2 = null;
						List<TreeVo<String>> childs2 = new ArrayList<TreeVo<String>>();
						for(ContractDetail contractDetail : contractDetails) {
							treeVo2 = new TreeVo<String>();
							treeVo2.setId(contractDetail.getId());
							treeVo2.setTitle(contractDetail.getVehicleNumber()+":"+contractDetail.getProjectAddress());
							treeVo2.setHref(GetBasePath(request) + "searchByVehicleID/" + contractDetail.getId());
							treeVo2.setHasParent(true);
							treeVo2.setParentId(contract.getId());
							childs2.add(treeVo2);// 车辆
						}
						treeVo1.setChildren(childs2);
					}
					childs1.add(treeVo1);// 合同
				}
				tree.setChildren(childs1);
			}
			trees.add(tree); //客户
			root.setChildren(trees);
		}
		return root;
	}
	
	// 车识别码查询车辆
	@RequestMapping(value = "/searchByVehicle", method = RequestMethod.GET)
	public String SearchByVehicle() {
		return "contract/service/searchByVehicles";
	}
	
	// 车识别码查询操作
	@RequestMapping(value = "/getSearchByVehicle", method = RequestMethod.POST)
	@ResponseBody
	public Object GetSearchByVehicle(@RequestParam(value = "vehicleNumber") String vehicleNumber, HttpServletRequest request) {
		// 树根节点
		TreeVo<String> root = new TreeVo<String>();
		root.setId(0);// 默认ID
		root.setTitle("按车识别码查询");
		List<ContractDetail> contractDetails = contractDetailService.findByConditions(new ContractDetail(vehicleNumber));
		if (contractDetails != null && !contractDetails.isEmpty()) {
			root.setHasChildren(true);// 有孩子节点
			// 遍历车辆
			TreeVo<String> treeVo = null;
			List<TreeVo<String>> childs = new ArrayList<TreeVo<String>>();
			for (ContractDetail contractDetail : contractDetails) {
				treeVo = new TreeVo<String>();
				treeVo.setId(contractDetail.getId());
				treeVo.setTitle(contractDetail.getVehicleNumber()+":"+contractDetail.getProjectAddress());
				treeVo.setHref(GetBasePath(request) + "searchByVehicleID/" + contractDetail.getId());
				treeVo.setHasParent(true);
				treeVo.setParentId(root.getId());
				childs.add(treeVo);
			}
			root.setChildren(childs);
		}else{
			root.setHasChildren(true);// 有孩子节点
			List<TreeVo<String>> childs = new ArrayList<TreeVo<String>>();
			TreeVo<String> treeVo = new TreeVo<String>();
			treeVo.setId(-1);
			treeVo.setTitle("无数据");
			treeVo.setHasParent(true);
			treeVo.setParentId(root.getId());
			childs.add(treeVo);
			root.setChildren(childs);
		}
		return root;
	}

	// 项目地址查询车辆
	@RequestMapping(value = "/searchByAddress", method = RequestMethod.GET)
	public String SearchByAddress() {
		return "contract/service/searchByAddress";
	}

	// 项目地址查询操作
	@RequestMapping(value = "/getSearchByAddress", method = RequestMethod.POST)
	@ResponseBody
	public Object GetSearchByAddress(@RequestParam(value = "projectAddress") String projectAddress, HttpServletRequest request) {
		// 树根节点
		TreeVo<String> root = new TreeVo<String>();
		root.setId(0);// 默认ID
		root.setTitle("按项目地址查询");
		ContractDetail condition = new ContractDetail();
		condition.setProjectAddress(projectAddress);
		List<ContractDetail> contractDetails = contractDetailService.findByConditions(condition);
		if (contractDetails != null && !contractDetails.isEmpty()) {
			root.setHasChildren(true);// 有孩子节点
			// 遍历车辆
			TreeVo<String> treeVo = null;
			List<TreeVo<String>> childs = new ArrayList<TreeVo<String>>();
			for (ContractDetail contractDetail : contractDetails) {
				treeVo = new TreeVo<String>();
				treeVo.setId(contractDetail.getId());
				treeVo.setTitle(contractDetail.getVehicleNumber()+":"+contractDetail.getProjectAddress());
				treeVo.setHref(GetBasePath(request) + "searchByVehicleID/" + contractDetail.getId());
				treeVo.setHasParent(true);
				treeVo.setParentId(root.getId());
				childs.add(treeVo);
			}
			root.setChildren(childs);
		}else{
			root.setHasChildren(true);// 有孩子节点
			List<TreeVo<String>> childs = new ArrayList<TreeVo<String>>();
			TreeVo<String> treeVo = new TreeVo<String>();
			treeVo.setId(-1);
			treeVo.setTitle("无数据");
			treeVo.setHasParent(true);
			treeVo.setParentId(root.getId());
			childs.add(treeVo);
			root.setChildren(childs);
		}
		return root;
	}
	
	// 根据车辆ID查询车辆
	@RequestMapping(value = "/searchByVehicleID/{id}", method = RequestMethod.GET)
	public String SearchByVehicleID(@PathVariable("id") Integer id, Model model) {
		// 根据绑定ID查找车辆
		ContractDetail contractDetail = contractDetailService.findById(id);
		// 查找车辆的结果不为空
		if (contractDetail != null) {
			model.addAttribute("contractDetail", contractDetail);
		}
		return "contract/service/description";
	}

	// 获取项目地址
	private String GetBasePath(HttpServletRequest request) {
		return request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
}
