package com.zyjd.cts.controller;

import java.util.ArrayList;
import java.util.List;
import com.zyjd.cts.model.Menu;
import com.zyjd.cts.model.Operation;
import com.zyjd.cts.util.QcyConstants;
import com.zyjd.cts.util.TreeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.zyjd.cts.util.Layui;
import com.zyjd.cts.model.Permission;
import com.zyjd.cts.model.Role;
import com.zyjd.cts.service.RoleService;

/***
 * 角色信息
 * 后台操作处理
 */
@Controller
@RequestMapping("/role")
public class RoleController {

	@Autowired
	private RoleService roleService;

	// 列表界面
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String List() {
		return "rbac/list/roleList";
	}
	
	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody Role role) {
		// 设置地址
		role.setStart((role.getPage()-1)*role.getLimit());
		// 查询记录
		List<Role> alls = roleService.findByCondition(role);
		// 当页记录
		List<Role> roles = roleService.findByConditionPage(role);
		if (roles != null && !roles.isEmpty()) {
			// 权限获取
			for(Role r : roles) {
				r.setPermissions(roleService.findByRolePermissions(r));
			}
			return Layui.data(alls.size(), roles);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody Role role) {
		List<Role> alls = roleService.findByConditions(role);
		if (alls != null && !alls.isEmpty()) {
			// 权限获取
			for(Role r : alls) {
				r.setPermissions(roleService.findByRolePermissions(r));
			}
			return Layui.data(alls.size(), alls);
		}
		return Layui.data(0, null);
	}
	
	// 角色查询
	/***
	 * 查询指定角色ID
	 * @param roleName 名称
	 * @return 角色ID
	 */
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	@ResponseBody
	public int Search(@RequestParam(value="roleName",required=false) String roleName) { return roleService.findByName(roleName).getId(); }
	
	// 获取角色
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<Role> GetList(@RequestBody Role role) {
		return roleService.findByCondition(role);
	}

	// 添加角色
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody Role role) {
		return String.valueOf(roleService.add(role));
	}
	
	// 删除角色
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String Delete(@RequestParam(value = "id") Integer id) {
		return String.valueOf(roleService.delete(id));
	}
	
	// 修改角色
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String Update(@RequestBody Role role) {
		return String.valueOf(roleService.update(role));
	}
}
