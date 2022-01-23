package com.zyjd.cts.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.zyjd.cts.util.Layui;
import com.zyjd.cts.model.User;
import com.zyjd.cts.service.RoleService;
import com.zyjd.cts.service.UserService;

/***
 * 用户信息
 * 后台操作处理
 */
@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private RoleService roleService;

	@Autowired
	private HelperController helperController;

	// 登录界面
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String Login(HttpServletRequest request) {
		if("".equals(helperController.IPAddress)){
			helperController.SetRemoteIP(request);// 记录IP
		}
		return "login/login";
	}
	
	// 用户登录
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody 
	public String Login(@RequestBody User user,HttpSession session) {
		User currentUser;
		String logStr = "登录了系统";
		try {	
			currentUser = userService.findByName(user.getNickName());//找到指定用户
			if(currentUser == null) {
				return "2";// 账户错误
			}else {
				if (currentUser.getPassword().equals(user.getPassword())) {
					currentUser.setPermissions(roleService.findByRolePermissions(currentUser.getRole())); // 设置用户会话
					session.setAttribute("CurrentUser", currentUser);
					helperController.SetUserID(currentUser.getId());// 记录用户ID
					helperController.Logs(logStr); // 记录登录日志
					return "1";// 登录成功
				} else {
					return "3";// 密码错误
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "0";// 服务器异常
		}
	}

	// 列表界面
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String List() {
		return "user/list/userList";
	}
	
	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody User user) {
		// 设置地址
		user.setStart((user.getPage()-1)*user.getLimit());
		// 查询记录
		List<User> alls = userService.findByCondition(user);
		// 当页记录
		List<User> users = userService.findByConditionPage(user);
		if (users != null && !users.isEmpty()) {
			return Layui.data(alls.size(), users);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody User user) {
		List<User> alls = userService.findByConditions(user);
		if (alls != null && !alls.isEmpty()) {
			return Layui.data(alls.size(), alls);
		}
		return Layui.data(0, null);
	}

	// 获取用户
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<User> getList(@RequestBody User user) {
		return userService.findByConditions(user);
	}
	
	// 添加用户
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody User user) {
		return String.valueOf(userService.add(user));
	}
	
	// 删除用户
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String Delete(@RequestParam(value = "id") Integer id) {
		return String.valueOf(userService.delete(id));
	}
	
	// 修改用户
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String Update(@RequestBody User user) {
		return String.valueOf(userService.update(user));
	}

	// 密码弹窗
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String Update() {
		return "user/update";
	}

	// 修改密码
	@RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
	@ResponseBody
	public String UpdatePassword(@RequestBody User user,HttpSession session) {
		if (userService.update(user) != 0) {
			session.invalidate();//修改密码成功后，需要返回登录页重新登录
			return "1";
		} else {
			return "0";
		}
	}
}
