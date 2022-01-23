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
			<span class="c-gray en">&gt;</span> 权限列表
            <a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);"><i class="Hui-iconfont">&#xe68f;</i></a>
		</nav>
		<div class="page-container">
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
		</div>
    </script>
	<!--自增序号-->
	<script type="text/html" id="xuhao">
		<span data-d="{{d.LAY_TABLE_INDEX+1}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.LAY_TABLE_INDEX+1}}</span>
	</script>
	<!-- 菜单名称-->
	<script type="text/html" id="menuNameTpl">
		<span data-d="{{d.menu.menuName}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.menu.menuName}}</span>
	</script>
	<!-- 操作名称-->
	<script type="text/html" id="operateNameTpl">
		<span data-d="{{d.operation.operateName}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.operation.operateName}}</span>
	</script>
	<!-- 权限名称-->
	<script type="text/html" id="permissionNameTpl">
		<span data-d="{{d.permissionName}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.permissionName}}</span>
	</script>
	<!-- 权限链接-->
	<script type="text/html" id="permissionHrefTpl">
		<span data-d="{{d.permissionHref}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.permissionHref}}</span>
	</script>
	<!-- 权限备注 -->
	<script type="text/html" id="remarkDescriptionTpl">
		<span data-d="{{d.remarkDescription}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.remarkDescription}}</span>
	</script>
	<!--通用脚本引入-->
	<%@include file="../../other/conjs.html" %>
    <script type="text/javascript">
		// 初始化脚本
		$(function () {
            // lay加载
			layui.use(['form', 'table'], function () {
				let table = layui.table;
				let form = layui.form;
				// 初始化表格
				table.render({
					elem: '#LAY_table_user' // 指定表格
					, id: 'LAY_table_user'
					, url: '${pageContext.request.contextPath }/permission/searchList' //数据请求路径
					, method: 'post'
					, contentType: "application/json;charset=UTF-8"
					, where: {}
					, size: 'lg' //sm小尺寸的表格 lg大尺寸
					, cellMinWidth: 150 // 表格单元格最小宽度
					, toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
					, defaultToolbar: ['filter', 'exports', 'print']
					, cols: [[{type: 'radio'}
						, {
							field: 'id',
							title: '序号',
							width: 80,
							sort: true,
							align: 'center',
							templet: '#xuhao'
						}
						, {
							field: 'menuName',
							unresize: true,
							title: '菜单名称',
							align: 'center',
							templet: '#menuNameTpl'
						}
						, {
							field: 'operateName',
							unresize: true,
							title: '操作名称',
							align: 'center',
							templet: '#operateNameTpl'
						}
						, {
							field: 'permissionName',
							unresize: true,
							title: '权限名称',
							align: 'center',
							templet: '#permissionNameTpl'
						}
						, {
							field: 'permissionHref',
							unresize: true,
							edit: 'text',
							title: '权限链接',
							align: 'center',
							templet: '#permissionHrefTpl'
						}
						, {
							field: 'remarkDescription',
							unresize: true,
							edit: 'text',
							title: '权限备注',
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
						case "permissionHref":
							if ($.trim(value)) {
								$.ajax({
									type: 'post',
									url: "${pageContext.request.contextPath }/permission/update",
									data: JSON.stringify({
										id: data.id,
										permissionHref: $.trim(value)
									}),
									contentType: "application/json;charset=UTF-8",
									dataType: "json",
									success: function (data) {
										layer.msg('修改成功!', {
											icon: 1, time: 1000, end: function () {
												//location.reload();
											}
										});
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
									url: "${pageContext.request.contextPath }/permission/update",
									data: JSON.stringify({
										id: data.id,
										remarkDescription: $.trim(value)
									}),
									contentType: "application/json;charset=UTF-8",
									dataType: "json",
									success: function (data) {
										layer.msg('修改成功!', {
											icon: 1, time: 1000, end: function () {
												//location.reload();
											}
										});
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
							var permissionName = "";
							var _funbtnxs = {
								yesxs1: function (index, layero) {
									var menuID = $("#menuID").val();
									if (menuID == "") {
										layer.msg('请选择菜单', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var operateID = $("#operateID").val();
									if (operateID == "") {
										layer.msg('请选择操作', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var permissionHref = $("#permissionHref").val().trim();
									var remarkDescription = $("#remarkDescription").val().trim();
									$.ajax({
										type: 'post',
										url: "${pageContext.request.contextPath }/permission/add",
										data: JSON.stringify({
											menuID: menuID,
											operateID: operateID,
											permissionName: permissionName,
											permissionHref: permissionHref,
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
											layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6});
										}
									});
								}
								, xs2: function (index, layero) {
									//单击关闭的回调
									layer.close(index);
								}, success: function (layero) {
									//弹出前回调
									$("#menuID").val('');
									$("#operateID").val('');
									$("#permissionHref").val('');
									$("#remarkDescription").val('');
									form.render('select');
								}
							}
							tk('添加权限', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '关闭'], _funbtnxs);
							// 下拉框值改变动态
							form.on('select(menuID)', function (data) {
								var menu = $("#menuID option:selected").text();
								var operate = $("#operateID option:selected").text();
								permissionName = menu + "-" + operate;
							});
							form.on('select(operateID)', function (data) {
								var menu = $("#menuID option:selected").text();
								var operate = $("#operateID option:selected").text();
								permissionName = menu + "-" + operate;
							});
							break;
						case 'update':
							var dataRow = checkStatus.data;  //获取选中行数据
							if (dataRow.length == 0) {
								layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
								return false;
							}
							var permissionName = "";
							var _funbtnxs = {
								yesxs1: function (index, layero) {
									var menuID = $("#menuID").val();
									if (menuID == "") {
										layer.msg('请选择菜单', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var operateID = $("#operateID").val();
									if (operateID == "") {
										layer.msg('请选择操作', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var permissionHref = $("#permissionHref").val().trim();
									var remarkDescription = $("#remarkDescription").val().trim();
									$.ajax({
										type: 'post',
										url: "${pageContext.request.contextPath }/permission/update",
										data: JSON.stringify({
											id: dataRow[0].id,
											menuID: menuID,
											operateID: operateID,
											permissionName: permissionName,
											permissionHref: permissionHref,
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
											layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6});
										}
									});
								}
								, xs2: function (index, layero) {
									//单击关闭的回调
									layer.close(index);
								}, success: function (layero) {
									//弹出前回调
									$("#menuID").val(dataRow[0].menuID);
									$("#operateID").val(dataRow[0].operateID);
									$("#permissionHref").val(dataRow[0].permissionHref);
									$("#remarkDescription").val(dataRow[0].remarkDescription);
									form.render('select');
								}
							}
							tk('修改权限', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '关闭'], _funbtnxs);
							// 下拉框值改变动态
							form.on('select(menuID)', function (data) {
								var menu = $("#menuID option:selected").text();
								var operate = $("#operateID option:selected").text();
								permissionName = menu + "-" + operate;
							});
							form.on('select(operateID)', function (data) {
								var menu = $("#menuID option:selected").text();
								var operate = $("#operateID option:selected").text();
								permissionName = menu + "-" + operate;
							});
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
									url: '${pageContext.request.contextPath }/permission/delete',
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
					}
					;
				});
				// 重载
				var $ = layui.$, active = {
					reload: function () {
						//执行重载
						table.reload('LAY_table_user', {
							url: '${pageContext.request.contextPath }/permission/searchList',
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
				// 菜单
				$.ajax({
					url: '${pageContext.request.contextPath }/menu/getList',
					method: 'post',
					data: JSON.stringify({}),
					contentType: "application/json;charset=UTF-8",
					dataType: "json",
					success: function (data) {
						$('#menuID').empty();
						$('#menuID').append(new Option("请选择", ""));
						$.each(data, function (index, item) {
							$('#menuID').append(new Option(item.menuName, item.id));
						});
						form.render("select");
					}, error: function (data) {
						$('#menuID').empty();
						$('#menuID').append(new Option("请选择", ""));
						form.render("select");
					}
				});
				// 操作
				$.ajax({
					url: '${pageContext.request.contextPath }/operation/getList',
					method: 'post',
					data: JSON.stringify({}),
					contentType: "application/json;charset=UTF-8",
					dataType: "json",
					success: function (data) {
						$('#operateID').empty();
						$('#operateID').append(new Option("请选择", ""));
						$.each(data, function (index, item) {
							$('#operateID').append(new Option(item.operateName, item.id));
						});
						form.render("select");
					}, error: function (data) {
						$('#operateID').empty();
						$('#operateID').append(new Option("请选择", ""));
						form.render("select");
					}
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
					<td align="right" width="80">菜单名称：</td>
					<td>
						<select class="layui-input" id="menuID" name="menuID" lay-filter="menuID" lay-search></select>
					</td>
					<td align="right" width="80">操作名称：</td>
					<td>
						<select class="layui-input"  id="operateID" name="operateID" lay-filter="operateID" lay-search></select>
					</td>
				</tr>
				<tr>
					<td align="right" width="80">权限链接：</td>
					<td colspan="3">
						<input type="text" id="permissionHref" name="permissionHref" autocomplete="off" class="layui-input">
					</td>
				</tr>
				<tr>
					<td align="right">权限备注：</td>
					<td colspan="3">
						<textarea id="remarkDescription" rows="20" name="remarkDescription" autocomplete="off" class="layui-textarea" placeholder="请输入"></textarea>
					</td>
				</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>