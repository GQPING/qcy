package com.zyjd.cts.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.zyjd.cts.util.Layui;
import com.zyjd.cts.model.Menu;
import com.zyjd.cts.service.MenuService;

/***
 * 菜单信息
 * 后台操作处理
 */
@Controller
@RequestMapping("/menu")
public class MenuController {

	@Autowired
	private MenuService menuService;

	// 列表界面
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String List() {
		return "rbac/list/menuList";
	}

	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody Menu menu) {
		// 设置地址
		menu.setStart((menu.getPage() - 1) * menu.getLimit());
		// 查询记录
		List<Menu> alls = menuService.findByCondition(menu);
		// 当页记录
		List<Menu> menus = menuService.findByConditionPage(menu);
		if (menus != null && !menus.isEmpty()) {
			return Layui.data(alls.size(), SyncParentChildren(menus));
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody Menu menu) {
		List<Menu> alls = menuService.findByConditions(menu);
		if (alls != null && !alls.isEmpty()) {
			return Layui.data(alls.size(),SyncParentChildren(alls));
		}
		return Layui.data(0, null);
	}
	
	// 菜单查询
	/***
	 * 查询指定菜单ID
	 * @param menuName 名称
	 * @return 菜单ID
	 */
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	@ResponseBody
	public int Search(@RequestParam(value = "menuName", required = false) String menuName) {
		return menuService.findByName(menuName).getId();
	}
	
	// 获取菜单
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<Menu> GetList(@RequestBody Menu menu) {
		List<Menu> menus = menuService.findByConditions(menu);
		if(menus!=null && !menus.isEmpty()) {
			return SyncParentChildren(menus);
		}
		return null;
	}

	// 添加菜单
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody Menu menu) {
		return String.valueOf(menuService.add(menu));
	}

	// 删除菜单
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String Delete(@RequestParam(value = "id") Integer id) {
		return String.valueOf(menuService.delete(id));
	}

	// 修改菜单
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String Update(@RequestBody Menu menu) {
		return String.valueOf(menuService.update(menu));
	}

	// 同步父子菜单信息
	private List<Menu> SyncParentChildren(List<Menu> menus){
		for(int i =0; i<menus.size(); i++) {
			if(menus.get(i).getParentID()==0){
				// 一级菜单
				menus.get(i).setParent(null);// 无父级
				menus.get(i).setChildren(menuService.findByParentId(0));// 找子级
			}else{
				// 下级菜单
				menus.get(i).setParent(menuService.findById(menus.get(i).getParentID()));  // 找父级
				menus.get(i).setChildren(menuService.findByParentId(menus.get(i).getId()));// 找子级
			}
		}
		return menus;
	}
}
