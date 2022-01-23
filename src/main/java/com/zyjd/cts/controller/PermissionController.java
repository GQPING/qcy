package com.zyjd.cts.controller;

import java.util.ArrayList;
import java.util.List;
import com.zyjd.cts.model.Menu;
import com.zyjd.cts.model.Operation;
import com.zyjd.cts.model.Role;
import com.zyjd.cts.service.MenuService;
import com.zyjd.cts.service.OperationService;
import com.zyjd.cts.service.RoleService;
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
import com.zyjd.cts.service.PermissionService;

/***
 * 权限信息
 * 后台操作处理
 */
@Controller
@RequestMapping("/permission")
public class PermissionController {

	@Autowired
	private RoleService roleService;

	@Autowired
	private MenuService menuService;

	@Autowired
	private OperationService operationService;

	@Autowired
	private PermissionService permissionService;

	// 列表界面
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String List() {
		return "rbac/list/permissionList";
	}

	// 列表查询(分页)
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchList(@RequestBody Permission permission) {
		// 设置地址
		permission.setStart((permission.getPage() - 1) * permission.getLimit());
		// 查询记录
		List<Permission> alls = permissionService.findByCondition(permission);
		// 当页记录
		List<Permission> permissions = permissionService.findByConditionPage(permission);
		if (permissions != null && !permissions.isEmpty()) {
			return Layui.data(alls.size(), permissions);
		}
		return Layui.data(0, null);
	}

	// 列表查询(不分页)
	@RequestMapping(value = "/searchAll", method = RequestMethod.POST)
	@ResponseBody
	public Layui SearchAll(@RequestBody Permission permission) {
		List<Permission> alls = permissionService.findByConditions(permission);
		if (alls != null && !alls.isEmpty()) {
			return Layui.data(alls.size(), alls);
		}
		return Layui.data(0, null);
	}
	
	// 获取权限
	@RequestMapping(value = "/getList", method = RequestMethod.POST)
	@ResponseBody
	public List<Permission> GetList(@RequestBody Permission permission) {
		return permissionService.findByCondition(permission);
	}

	// 初始化权限树(配置角色权限时)
	@RequestMapping(value = "/getTree", method = RequestMethod.POST)
	@ResponseBody
	public Object GetTree(@RequestBody Role role){
		return GetPermissionTree(role);
	}
	
	// 添加权限
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String Add(@RequestBody Permission permission) {
		return String.valueOf(permissionService.add(permission));
	}

	// 删除权限
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String Delete(@RequestParam(value = "id") Integer id) {
		return String.valueOf(permissionService.delete(id));
	}

	// 修改权限
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String Update(@RequestBody Permission permission) {
		return String.valueOf(permissionService.update(permission));
	}

	// 构造权限树结构
	private Object GetPermissionTree(Role role){
		return GetPermissionTree(roleService.findByRolePermissions(role));
	}

	// 构造权限树
	private TreeVo<String> GetPermissionTree(List<Permission> permissions){
		// 树根节点
		TreeVo<String> root = new TreeVo<String>();
		root.setId(0);
		root.setTitle("所有权限");
		root.setHasParent(false);
		root.setHasChildren(true);
		root.setValue("所有权限-查看");
		// 二级节点
		List<Menu> firsts = menuService.findByParentId(0);// firsts：合同管理、客户管理、用户管理、系统管理、阶段提醒弹窗、合同提醒弹窗
		// 有下级菜单情况
		if(firsts!=null && !firsts.isEmpty()) {
			TreeVo<String> tree1;
			root.setHasChildren(true);
			List<TreeVo<String>> trees1 = new ArrayList<TreeVo<String>>();
			for(int i =0; i<firsts.size(); i++) {
				tree1= new TreeVo<String>();
				tree1.setHref(null);
				tree1.setHasParent(true);
				tree1.setParentId(root.getId());
				tree1.setId(firsts.get(i).getId());
				tree1.setTitle(firsts.get(i).getMenuName());
				tree1.setValue(firsts.get(i).getMenuName()+"-查看");
				// 三级节点
				List<Menu> seconds = menuService.findByParentId(firsts.get(i).getId());// seconds:租赁合同列表、售后车辆查询、销售数据报表等等
				// 有下级菜单情况
				if(seconds!=null && !seconds.isEmpty()) {
					TreeVo<String> tree2;
					tree1.setHasChildren(true);
					List<TreeVo<String>> trees2 = new ArrayList<TreeVo<String>>();
					for(int j =0; j<seconds.size(); j++) {
						tree2= new TreeVo<String>();
						tree2.setHref(null);
						tree2.setHasParent(true);
						tree2.setParentId(tree1.getId());
						tree2.setId(seconds.get(j).getId());
						tree2.setTitle(seconds.get(j).getMenuName());
						tree2.setValue(seconds.get(j).getMenuName()+"-查看");
						// 四级节点
						List<Menu> thirds = menuService.findByParentId(seconds.get(j).getId());// thirds:按车识别码查询、按销售数量统计等
						// 有下级菜单情况
						if(thirds!=null && !thirds.isEmpty()) {
							TreeVo<String> tree3;
							tree2.setHasChildren(true);
							List<TreeVo<String>> trees3 = new ArrayList<TreeVo<String>>();
							for(int k =0; k<thirds.size(); k++) {
								tree3= new TreeVo<String>();
								tree3.setHref(null);
								tree3.setHasParent(true);
								tree3.setHasChildren(false);// 只是叶子菜单
								tree3.setChecked(IsTreeNodeChecked(permissions,thirds.get(k).getMenuName(),"查看"));// 设置叶子菜单状态
								tree3.setParentId(tree2.getId());
								tree3.setId(thirds.get(k).getId());
								tree3.setTitle(thirds.get(k).getMenuName());
								tree3.setValue(thirds.get(k).getMenuName()+"-查看");
								tree3.setChildren(SetTreeOperation(thirds.get(k).getId(),thirds.get(k).getMenuName(),permissions));// 操作节点
								trees3.add(tree3);
							}
							tree2.setChildren(trees3);
						}
						// 没有下级菜单情况，列表
						else{
							if(seconds.get(j).getHasOperationChildren()==1){// 有无操作子节点
								tree2.setHasChildren(true);
								tree2.setChildren(SetTreeOperation(seconds.get(j).getId(),seconds.get(j).getMenuName(),permissions));// 操作节点
							}else{
								tree2.setHasChildren(false);
								tree2.setChecked(IsTreeNodeChecked(permissions,seconds.get(j).getMenuName(),"查看"));// 设置叶子菜单状态
							}
						}
						trees2.add(tree2);
					}
					tree1.setChildren(trees2);
				}
				// 没有下级菜单情况，弹窗
				else{
					if(firsts.get(i).getHasOperationChildren()==1){// 有无操作子节点
						tree1.setHasChildren(true);
						tree1.setChildren(SetTreeOperation(firsts.get(i).getId(),firsts.get(i).getMenuName(),permissions));// 操作节点
					}else{
						tree1.setHasChildren(false);
						tree1.setChecked(IsTreeNodeChecked(permissions,firsts.get(i).getMenuName(),"查看"));// 设置叶子菜单状态
					}
				}
				trees1.add(tree1);
			}
			root.setChildren(trees1);
		}
		// 没有下级菜单情况,菜单
		else{
			//root.setHasChildren(true);
			//root.setChildren(SetTreeOperation(root.getId(), root.getTitle(),permissions));// 操作节点
		}
		return root;
	}

	// 设置权限操作节点
	// 叶子菜单节点选中即可查看
	// 叶子操作节点选中即可操作
	private List<TreeVo<String>> SetTreeOperation(Integer menuId, String menuName,List<Permission> permissions){
		List<TreeVo<String>> operations = new ArrayList<TreeVo<String>>();
		operations.add(GetTreeOperation(menuId,menuName, QcyConstants.LOOKUP,permissions));
		operations.add(GetTreeOperation(menuId,menuName,QcyConstants.CREATE,permissions));
		operations.add(GetTreeOperation(menuId,menuName,QcyConstants.UPDATE,permissions));
		operations.add(GetTreeOperation(menuId,menuName,QcyConstants.DELETE,permissions));
		return operations;
	}

	// 设置是否选中节点(初始化)
	private Boolean IsTreeNodeChecked(List<Permission> permissions,String menuName,String operationName) {
		for (Permission permission : permissions) {
			if (permission.getMenu().getMenuName().equals(menuName)
					&& permission.getOperation().getOperateName().equals(operationName)) {
				return true;
			}
			continue;
		}
		return false;
	}

	// 获取操作节点
	private TreeVo<String> GetTreeOperation(Integer menuId,String menuName,String operationName,List<Permission> permissions){
		TreeVo<String> operation = new TreeVo<String>();
		Operation temp = operationService.findByName(operationName);
		if(temp!=null) {
			operation.setHref(null);
			operation.setHasParent(true);
			operation.setOperation(true);
			operation.setParentId(menuId);
			operation.setId(menuId*100+temp.getId());// 设置唯一性规则(不重复)
			operation.setChecked(IsTreeNodeChecked(permissions,menuName,operationName));
			operation.setHasChildren(false);
			operation.setValue(menuName+"-"+operationName);// 对应权限名称
			operation.setTitle(operationName);
		}
		return operation;
	}
}
