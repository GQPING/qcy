<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../../other/meta.html"%>
	<%@include file="../../other/style.html" %>
</head>
<body>
	<div>
		<nav class="breadcrumb">
			<i class="Hui-iconfont">&#xe67f;</i> 首页 
			<span class="c-gray en">&gt;</span> 系统管理 
			<span class="c-gray en">&gt;</span> 角色列表
            <a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);"><i class="Hui-iconfont">&#xe68f;</i></a>
		</nav>
		<div class="page-container">
		    <input type="hidden" value="${sessionScope.CurrentUser.permissions}" id="permissions"/>
			<div class="mt" style="padding:-12px 0px 0px 0px;">
				<div class="demoTable layui-form">
					<div class="layui-inline" style="width:100%;">
						<div class="layui-inline" style="width: 20%;position:relative;min-width: 330px;padding: 6px 12px 12px 0px;">
							<div style="position:absolute;right:14px;top:16px;cursor:pointer;display: none;" class="input_clear">
								<button type="button" class="clear" style="border: 0px;background-color:white;">
									<i class="Hui-iconfont" style="color: red;">&#xe60b;</i>
								</button>
							</div>
							<input class="layui-input" oninput="showClear(this)" id="searchString" autocomplete="off" placeholder="请输入查询条件">
						</div>
						<button class="layui-btn" data-type="reload" style="margin:-6px 0px 0px 0px;padding: 0px 12px 0px 12px;"><i class="Hui-iconfont">&#xe665;</i></button>
					</div>
				</div>
			</div>
			<table class="layui-hide" id="LAY_table_user" lay-filter="LAY_table_user"></table>
		</div>
	</div>
	<!--工具栏-->
	<script type="text/html" id="toolbarDemo">
        <div class="layui-btn-container">
			<button id="createbtn" class="layui-btn layui-btn-sm" lay-event="create"><i class="Hui-iconfont">&#xe604;</i> 创建</button>
			<button id="updatebtn" class="layui-btn layui-btn-sm" lay-event="update"><i class="Hui-iconfont">&#xe72a;</i> 修改</button>
			<button id="deletebtn" class="layui-btn layui-btn-sm" lay-event="delete"><i class="Hui-iconfont">&#xe6e2;</i> 删除</button>
			<button id="assignbtn" class="layui-btn layui-btn-sm" lay-event="assign"><i class="Hui-iconfont">&#xe63c;</i> 分配</button>
        </div>
    </script>
	<!--自增序号-->
	<script type="text/html" id="xuhao">
		<span data-d="{{d.LAY_TABLE_INDEX+1}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.LAY_TABLE_INDEX+1}}</span>
	</script>
	<!-- 角色名称-->
	<script type="text/html" id="roleNameTpl">
		<span data-d="{{d.roleName}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.roleName}}</span>
	</script>
	<!-- 角色备注 -->
	<script type="text/html" id="remarkDescriptionTpl">
		<span data-d="{{d.remarkDescription}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.remarkDescription}}</span>
	</script>
	<!--通用脚本引入-->
	<%@include file="../../other/conjs.html" %>
    <script type="text/javascript">
		//获取所有选中的节点id
		function getCheckedId(data) {
			var id = "";
			$.each(data, function (index, item) {
				if (id != "") {
					id = id + "," + item.id;
				}
				else {
					id = item.id;
				}
				//item 没有children属性
				if (item.children != null) {
					var i = getCheckedId(item.children);
					if (i != "") {
						id = id + "," + i;
					}
				}
			});
			return id;
		}
		//获取所有选中的节点value
		function getCheckedValue(data) {
			var id = "";
			$.each(data, function (index, item) {
				if (id != "") {
					id = id + "," + item.value;
				}
				else {
					id = item.value;
				}
				//item 没有children属性
				if (item.children != null) {
					var i = getCheckedValue(item.children);
					if (i != "") {
						id = id + "," + i;
					}
				}
			});
			return id;
		}
		// 初始化脚本
		$(function () {
			// lay加载
			layui.use(['form', 'table', 'tree'], function () {
				let form = layui.form;
				let tree = layui.tree;
				let table = layui.table;
				// 初始化表格
				table.render({
					elem: '#LAY_table_user' // 指定表格
					, id: 'LAY_table_user'
					, url: '${pageContext.request.contextPath }/role/searchList' //数据请求路径
					, method: 'post'
					, contentType: "application/json;charset=UTF-8"
					, where: { }
					, size: 'lg' //sm小尺寸的表格 lg大尺寸
					, cellMinWidth: 150 // 表格单元格最小宽度
					, toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
					, defaultToolbar: ['filter', 'exports', 'print']
					, cols: [[
						{type: 'radio'}
						, {
							field: 'id',
							title: '序号',
							width: 80,
							sort: true,
							align: 'center',
							templet: '#xuhao'
						}
						, {
							field: 'roleName',
							unresize:true,
							edit:'text',
							title: '角色名称',
							align: 'center',
							templet: '#roleNameTpl'
						}
						, {
							field: 'remarkDescription',
							unresize:true,
							edit:'text',
							title: '角色备注',
							align: 'center',
							templet: "#remarkDescriptionTpl"
						}
					]]
					, page: true  //开启分页
					, limit: 10   //默认十条数据一页
					, limits: [5, 10, 15, 20, 25, 30] //数据分页条
					, response: {
						statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
					}
				});
				//监听单元格编辑
				table.on('edit(LAY_table_user)', function(obj){
					var $td = $(this).parents('td').eq(0);
					var value = obj.value //得到修改后的值
							,data = obj.data //得到所在行所有键值
							,field = obj.field; //得到字段
					//layer.msg('[ID: '+ data.id +'] ' + field + ' 字段更改为：'+ value);
					switch (field) {
						case "roleName":
							if ($.trim(value)) {
								$.ajax({
									type: 'post',
									url: "${pageContext.request.contextPath }/role/update",
									data: JSON.stringify({
										id: data.id,
										roleName: $.trim(value)
									}),
									contentType: "application/json;charset=UTF-8",
									dataType: "json",
									success: function (data) {
										if (data == '1') {
											layer.msg('修改成功!', {
												icon: 1, time: 1000, end: function () {
													//location.reload();
												}
											});
										} else {
											layer.msg('修改失败!', {
												icon: 5, time: 1000, anim: 6, end: function () {
													location.reload();
												}
											});
										}
									},
									error: function (data) {
										layer.msg('服务器异常!', {
											icon: 5, time: 1000, anim: 6, end: function () {
												location.reload();
											}
										});
									}
								});

							}else{
								//1、获取旧值
								var old = $td.data('content');
								//2、延时设置（必须延时）旧值
								setTimeout(function () {
									obj.update({title: old});
								}, 500);
								location.reload();
							}
							break;
						case "remarkDescription":
							if ($.trim(value)) {
								$.ajax({
									type: 'post',
									url: "${pageContext.request.contextPath }/role/update",
									data: JSON.stringify({
										id: data.id,
										remarkDescription: $.trim(value)
									}),
									contentType: "application/json;charset=UTF-8",
									dataType: "json",
									success: function (data) {
										if (data == '1') {
											layer.msg('修改成功!', {
												icon: 1, time: 1000, end: function () {
													//location.reload();
												}
											});
										} else {
											layer.msg('修改失败!', {icon: 5, time: 1000, anim: 6, end: function () {
													location.reload();
												}});
										}
									},
									error: function (data) {
										layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6,end: function () {
												location.reload();
											}});
									}
								});
							}else{
								//1、获取旧值
								var old = $td.data('content');
								//2、延时设置（必须延时）旧值
								setTimeout(function () {
									obj.update({title: old});
								}, 500);
								location.reload();
							}
							break;
					}
				});
				// 头工具栏事件
				table.on('toolbar(LAY_table_user)', function (obj) {
					var checkStatus = table.checkStatus(obj.config.id); //获取选中行状态
					switch (obj.event) {
						case 'create':
							//弹出框开始
							var _funbtnxs = {
								yesxs1: function (index, layero) {
									//单击提交的回调
									var roleName = $("#roleName").val().trim();
									if (roleName == "") {
										layer.msg('请输入角色名称', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var remarkDescription = $("#remarkDescription").val().trim();
									$.ajax({
										type: 'post',
										url: "${pageContext.request.contextPath }/role/add",
										data: JSON.stringify({
											roleName: roleName,
											remarkDescription: remarkDescription
										}),
										contentType: "application/json;charset=UTF-8",
										dataType: "json",
										success: function (data) {
											layer.msg('添加成功!', {
												icon: 1, time: 1000, end: function () {
													//location.reload();
												}
											});
										},
										error: function (data) {
											layer.msg('角色已存在!', {icon: 5, time: 1000, anim: 6});
										}
									});
								}
								, xs2: function (index, layero) {
									//单击关闭的回调
									layer.close(index);
								}, success: function (layero) {
									//弹出前回调
									$("#roleName").val('');
									$("#remarkDescription").val('');
								}
							}
							tk('添加角色', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '关闭'], _funbtnxs);
							break;
						case 'update':
							var dataRow = checkStatus.data;  //获取选中行数据
							if (dataRow.length == 0) {
								layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
								return false;
							}
							//弹出框开始
							var _funbtnxs = {
								yesxs1: function (index, layero) {
									//单击提交的回调
									var roleName = $("#roleName").val().trim();
									if (roleName == "") {
										layer.msg('请输入角色名称', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var remarkDescription = $("#remarkDescription").val().trim();
									$.ajax({
										type: 'post',
										url: "${pageContext.request.contextPath }/role/update",
										data: JSON.stringify({
											id: dataRow[0].id,
											roleName: roleName,
											remarkDescription: remarkDescription
										}),
										contentType: "application/json;charset=UTF-8",
										dataType: "json",
										success: function (data) {
											layer.msg('修改成功!', {
												icon: 1, time: 1000, end: function () {
													location.reload();
												}
											});
										},
										error: function (data) {
											layer.msg('角色名称重复!', {icon: 5, time: 1000, anim: 6});
										}
									});
								}
								, xs2: function (index, layero) {
									//单击关闭的回调
									layer.close(index);
								}, success: function (layero) {
									//弹出前回调
									$("#roleName").val(dataRow[0].roleName);
									$("#remarkDescription").val(dataRow[0].remarkDescription);
								}
							}
							tk('修改角色', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '关闭'], _funbtnxs);
							break;
						case 'delete':
							var dataRow = checkStatus.data;  //获取选中行数据
							if (dataRow.length == 0) {
								layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
								return false;
							}
							layer.confirm('确认要删除吗？', function (index) {
								$.ajax({
									type: 'post',
									url: '${pageContext.request.contextPath }/role/delete',
									data: {id: dataRow[0].id},
									success: function (data) {
										layer.msg('删除成功!', {
											icon: 1, time: 1000, end: function () {
												location.reload();
											}
										});
									},
									error: function (data) {
										layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6});
									},
								});
							});
							break;
						case 'assign':
							var dataRow = checkStatus.data;  //获取选中行数据
							if (dataRow.length == 0) {
								layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
								return false;
							}
							$('input:checkbox').each(function () {
								$(this).attr('checked', false);
							});
							//弹出框开始
							var _funbtnxs = {
								yesxs1: function (index, layero) {
									//单击提交的回调
									var checkedData = tree.getChecked('root'); //获取选中节点的数据
									var nodeValues = getCheckedValue(checkedData);
									var nodeArrays = nodeValues.split(",");
									var size = nodeArrays.length;
									let fail_count = 0;
									let success_count = 0;
									// 分配勾选权限
									for (var i = 0;i<size;i++) {
										$.ajax({
											type: 'post',
											url: '${pageContext.request.contextPath }/rolePermission/assign',
											data: {roleID: dataRow[0].id, permissionName: nodeArrays[i]},
											success: function (data) {
												if (data == '1') {
													success_count++;
												} else {
													fail_count++;
												}
												if (success_count + fail_count == size) {
													layer.msg('权限授权成功', {
														icon: 1, time: 2000, end: function () {
															//location.reload();
														}
													});
												}
											},
											error: function (data) {
												fail_count++;
											}
										});
									}
									// 删除未勾选权限
									$.ajax({
										type: 'post',
										url: '${pageContext.request.contextPath }/rolePermission/delete',
										data: {roleID: dataRow[0].id, selecteds: nodeValues},
										success: function (data) {
											if (data == '1') { } else {
												layer.msg('权限移除异常!', {icon: 5, time: 1000, anim: 6});
											}
										},
										error: function (data) {
											layer.msg('权限移除异常!', {icon: 5, time: 1000, anim: 6});
										}
									});
								}, xs2: function (index, layero) {
									//单击关闭的回调
									layer.close(index);
								}, success: function (layero) {
									//弹出前回调
									$.ajax({
										type: "POST",
										url: "${pageContext.request.contextPath }/permission/getTree",
										data: JSON.stringify({id:dataRow[0].id}),
										contentType: "application/json;charset=UTF-8",
										dataType: "json",
										success: function (data) {
											// 开启权限树
											tree.render({
												elem: '#permissionTree'
												,id : 'root'
												,accordion:false//是否开启手风琴模式
												,showLine:true//是否开启连接线
												,showCheckbox:true//是否开启复选框
												,isJump :false //是否允许点击节点时弹出新窗口跳转
												,data: eval('[' + JSON.stringify(data) + "]")//数据
												,click : function(obj) {//点击事件
													//var data = obj.data;  //获取当前点击的节点数据
													//layer.msg('状态：'+ obj.state + '<br>节点数据：' + JSON.stringify(data));
												}
											});
										}, error: function (data) {
											tree.render({
												elem : '#permissionTree'
												,id : 'root'
												,accordion:false//是否开启手风琴模式
												,showLine:true//是否开启连接线
												,showCheckbox:true//是否开启复选框
												,isJump : false //是否允许点击节点时弹出新窗口跳转
												,data : []//数据
											});
											layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6});
										}
									});
								}
							}
							tk('分配权限', ['100%', '100%'], 'userbj', $("#bjnr2"), ['确定','关闭'], _funbtnxs);
							break;
					};
				});
				// 重载
				let $ = layui.$, active = {
					reload: function () {
						//执行重载
						table.reload('LAY_table_user', {
							url: '${pageContext.request.contextPath }/role/searchList',
							method: 'post',
							contentType: "application/json;charset=UTF-8",
							page: {
								curr: 1 //重新从第 1 页开始
							}, where: {
								searchString: $('#searchString').val().trim() == "" ? null : $('#searchString').val().trim()
							}
						}, 'data');
					}
				};
				// 刷新
				$('.demoTable .layui-btn').on('click', function () {
					let type = $(this).data('type');
					active[type] ? active[type].call(this) : '';
				});
			});
		});
    </script>
	<!--创建修改弹窗-->
	<div id="bjnr" style="display: none;">
		<form class="layui-form">
			<table class="layui-table layui-xs" lay-skin="nob">
				<tbody>
				<tr>
					<td align="right" width="80">角色名称：</td>
					<td>
						<input type="text" id="roleName" name="roleName" autocomplete="off" class="layui-input">
					</td>
				</tr>
				<tr>
					<td align="right">角色备注：</td>
					<td>
						<textarea id="remarkDescription" rows="20" name="remarkDescription" autocomplete="off" class="layui-textarea" placeholder="请输入"></textarea>
					</td>
				</tr>
				</tbody>
			</table>
		</form>
	</div>
	<!--权限分配弹窗-->
	<div id="bjnr2" style="display: none;">
		<div id="permissionTree" style="float:left;width:30%;min-height:600px;"></div>
	</div>
</body>
</html>