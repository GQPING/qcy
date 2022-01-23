package com.zyjd.cts.controller;

import java.util.List;

import com.zyjd.cts.model.Contact;
import com.zyjd.cts.model.Visit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.zyjd.cts.model.Customer;
import com.zyjd.cts.util.Layui;
import com.zyjd.cts.service.ContactService;
import com.zyjd.cts.service.CustomerService;
import com.zyjd.cts.service.VisitService;

/***
 * 客户信息
 * 后台操作处理
 */
@Controller
@RequestMapping("/customer")
public class CustomerController {

	@Autowired
	private VisitService visitService;

	@Autowired
	private ContactService contactService;

	@Autowired
	private CustomerService customerService;

	// 列表界面
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String List() {
		return "customer/list/customerList";
	}

	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody Customer customer) {
		// 设置地址
		customer.setStart((customer.getPage()-1)*customer.getLimit());
		// 查询记录
		List<Customer> alls = customerService.findByCondition(customer);
		// 当页记录
		List<Customer> customers = customerService.findByConditionPage(customer);
		if (customers != null && !customers.isEmpty()) {
			for(int i =0;i<customers.size();i++) {
				//绑定记录联系人、回访信息
				customers.get(i).setContacts(contactService.findByConditions(new Contact(customers.get(i).getId())));
				customers.get(i).setVisits(visitService.findByConditions(new Visit(customers.get(i).getId())));
			}
			return Layui.data(alls.size(), customers);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody Customer customer) {
		List<Customer> alls = customerService.findByConditions(customer);
		if (alls != null && !alls.isEmpty()) {
			return Layui.data(alls.size(), alls);
		}
		return Layui.data(0, null);
	}

	// 获取客户
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<Customer> GetList(@RequestBody Customer customer) {
		return customerService.findByConditions(customer);
	}

	// 客户查询
	/***
	 * 获取指定客户ID
	 * @param customerName 名称
	 * @return 客户ID
	 */
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	@ResponseBody
	public int Search(@RequestParam(value = "customerName", required = false) String customerName) {
		Customer customer = customerService.findByName(customerName);
		if(customer!=null){
			return customer.getId();
		}
		return -1;// 无效值
	}

	// 添加界面(主页快速添加按钮触发)
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String Add() {
		return "customer/add";
	}

	// 添加客户
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody Customer customer) {
		return String.valueOf(customerService.add(customer));
	}
	
	// 删除客户
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String Delete(@RequestParam(value = "id") Integer id) {
		return String.valueOf(customerService.delete(id));
	}
	
	// 修改客户
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String Update(@RequestBody Customer customer) {
		return String.valueOf(customerService.update(customer));
	}
}
