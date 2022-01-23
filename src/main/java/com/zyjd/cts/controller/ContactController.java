package com.zyjd.cts.controller;

import java.util.List;

import com.zyjd.cts.model.Bill;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.zyjd.cts.util.Layui;
import com.zyjd.cts.service.ContactService;
import com.zyjd.cts.model.Contact;

/***
 * 客户联系人
 * 后台操作处理
 */
@Controller
@RequestMapping("/contact")
public class ContactController {

	@Autowired
	private ContactService contactService;

	// 详情界面
	/***
	 * 位于客户列表中联系人按钮
	 * @param id 客户ID
	 * @param model 视图模型
	 * @return 返回页面地址
	 */
	@RequestMapping(value = "/detail/{id}", method = RequestMethod.GET)
	public String Detail(@PathVariable("id") Integer id, Model model) {
		model.addAttribute("customerID",id);
		return "customer/list/contactList";
	}

	// 列表界面
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String List() {
		return "customer/list/contactList";
	}

	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody Contact contact) {
		// 设置地址
		contact.setStart((contact.getPage() - 1) * contact.getLimit());
		// 查询记录
		List<Contact> alls = contactService.findByCondition(contact);
		// 当页记录
		List<Contact> contacts = contactService.findByConditionPage(contact);
		if (contacts != null && !contacts.isEmpty()) {
			return Layui.data(alls.size(), contacts);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody Contact contact) {
		List<Contact> alls = contactService.findByConditions(contact);
		if (alls != null && !alls.isEmpty()) {
			return Layui.data(alls.size(), alls);
		}
		return Layui.data(0, null);
	}

	// 获取联系人
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<Contact> getList(@RequestBody Contact contact) {
		return contactService.findByConditions(contact);
	}

	// 添加联系人
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody Contact contact) {
		return String.valueOf(contactService.add(contact));
	}

	// 删除联系人
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String Delete(@RequestParam(value = "id") Integer id) {
		return String.valueOf(contactService.delete(id));
	}

	// 修改联系人
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String Update(@RequestBody Contact contact) {
		return String.valueOf(contactService.update(contact));
	}
}
