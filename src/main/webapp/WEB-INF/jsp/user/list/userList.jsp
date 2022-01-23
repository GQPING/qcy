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
			<span class="c-gray en">&gt;</span> 用户管理 
			<span class="c-gray en">&gt;</span> 用户列表
            <a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px"
			   href="javascript:location.replace(location.href);">
				<i class="Hui-iconfont">&#xe68f;</i>
			</a>
		</nav>
		<div class="page-container">
			<div class="mt" style="padding:-12px 0px 0px 0px;">
				<div class="demoTable layui-form">
					<div class="layui-inline" style="width: 100%;">
						<div class="layui-inline" style="width: 20%;position:relative;min-width: 330px;padding: 6px 12px 12px 0px;">
							<div style="position:absolute;right:2px;top:10px;cursor:pointer;display: none;padding: 6px 12px 12px 0px;" class="input_clear">
								<button type="button" class="clear" style="border: 0px;background-color:white;">
									<i class="Hui-iconfont" style="color: red;">&#xe60b;</i>
								</button>
							</div>
							<input class="layui-input" oninput="showClear(this)" id="searchString" autocomplete="off" placeholder="请输入内容查询">
						</div>
						<div class="layui-inline" style="width: 10%;min-width: 110px;padding: 6px 0px 12px 0px;">
							<input class="layui-input" id="timeStart" autocomplete="off" placeholder="开始日期">
						</div>
						<span style="color:#555;font-weight: bold;font-size:16px;padding: 12px 0px 12px 0px;">-</span>
						<div class="layui-inline" style="width: 10%;min-width: 110px;padding: 6px 12px 12px 0px;">
							<input class="layui-input" id="timeFinal" autocomplete="off" placeholder="结束日期">
						</div>
						<button class="layui-btn" data-type="reload" style="margin:-6px 0px 0px 0px;padding: 0px 12px 0px 12px;">
							<i class="Hui-iconfont">&#xe665;</i>
						</button>
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
	<!-- 昵称-->
	<script type="text/html" id="nickNameTpl">
		<span data-d="{{d.nickName}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.nickName}}</span>
	</script>
	<!-- 密码-->
	<script type="text/html" id="passwordTpl">
		<span data-d="{{MD5(d.password)}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{MD5(d.password)}}</span>
	</script>
	<!-- 姓名 -->
	<script type="text/html" id="userNameTpl">
		<span data-d="{{d.userName}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.userName}}</span>
	</script>
	<!-- 角色 -->
	<script type="text/html" id="roleNameTpl">
		<span data-d="{{d.role.roleName}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.role.roleName}}</span>
	</script>
	<!-- 备注 -->
	<script type="text/html" id="remarkDescriptionTpl">
		<span data-d="{{d.remarkDescription}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.remarkDescription}}</span>
	</script>
	<!-- 创建日期 -->
	<script type="text/html" id="createDateTpl">
		<span data-d="{{layui.util.toDateString(d.createDate, 'yyyy-MM-dd HH:mm:ss')}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{layui.util.toDateString(d.createDate, 'yyyy-MM-dd HH:mm:ss')}}</span>
	</script>
	<!--通用脚本引入-->
	<%@include file="../../other/conjs.html" %>
    <script type="text/javascript">
		// 密码隐藏显示
		function MD5(obj) {
			return obj.replace(/[a-zA-Z0-9_|.,;!?<>()+=@#&$%]/g, "*");//隐藏
		}
		// 初始化脚本
		$(function () {
			// lay加载
			layui.use(['form', 'table', 'laydate'], function () {
				var table = layui.table;
				var form = layui.form;
				let laydate = layui.laydate;
				//执行一个laydate实例
				let dateEntryStart = laydate.render({
					elem: '#timeStart',
					//theme: '#0079c4',
					trigger: 'click',
					//btns: ['clear', 'confirm'],
					// showBottom: false,
					done: function (value, date) {
						dateEntryEnd.config.min = {
							year: date.year,
							month: date.month - 1,
							date: date.date,
							hours: date.hours,
							minutes: date.minutes,
							seconds: date.seconds
						};
						// 作为 结束选择 的 开始时间
						dateEntryEnd.config.value = value;
					}
				});
				let dateEntryEnd = laydate.render({
					elem: '#timeFinal',
					//theme: '#0079c4',
					trigger: 'click',//  触发方式
					//btns: ['clear', 'confirm'],// 底部按钮
					// showBottom: false,
					done: function (value, date) {// 选择完成回调
						dateEntryStart.config.max = {
							year: date.year,
							month: date.month - 1,
							date: date.date,
							hours: date.hours,
							minutes: date.minutes,
							seconds: date.seconds
						};
						dateEntryStart.config.value = value;
					}
				});
				// 初始化表格
				table.render({
					elem: '#LAY_table_user' // 指定表格
					, id: 'LAY_table_user'
					, url: '${pageContext.request.contextPath }/user/searchList' //数据请求路径
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
							field: 'nickName',
							unresize: true,
							title: '昵称',
							align: 'center',
							templet: "#nickNameTpl"
						}
						, {
							field: 'password',
							unresize: true,
							title: '密码',
							align: 'center',
							templet: '#passwordTpl'
						}
						, {
							field: 'userName',
							unresize: true,
							title: '姓名',
							align: 'center',
							templet: "#userNameTpl"
						}
						, {
							field: 'role.roleName',
							unresize: true,
							title: '角色',
							align: 'center',
							templet: "#roleNameTpl"
						}
						, {
							field: 'createDate',
							unresize: true,
							title: '创建日期',
							align: 'center',
							templet: "#createDateTpl"
						}, {
							field: 'remarkDescription',
							unresize: true,
							title: '备注',
							align: 'center',
							templet: '#remarkDescriptionTpl'
						}
					]]
					, page: true  //开启分页
					, limit: 10   //默认十条数据一页
					, limits: [5, 10, 15, 20, 25, 30] //数据分页条
					, response: {
						statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
					}
				});
				// 头工具栏事件
				table.on('toolbar(LAY_table_user)', function (obj) {
					var checkStatus = table.checkStatus(obj.config.id); //获取选中行状态
					switch (obj.event) {
						case 'create':
							var _funbtnxs = {
								yesxs1: function (index, layero) {
									var nickName = $("#nickName").val().trim();
									if (nickName == "") {
										layer.msg('请输入昵称', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									if (nickName.length < 6) {
										layer.msg('昵称长度>=6', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var password = $("#password").val().trim();
									if (password == "") {
										layer.msg('请输入密码', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									if (password.length < 6) {
										layer.msg('密码长度>=6', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var userName = $("#userName").val().trim();
									if (userName == "") {
										layer.msg('请输入姓名', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var roleID = $("#roleID").val();
									if (roleID == "") {
										layer.msg('请选择角色', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var createDate = new Date();
									var remarkDescription = $("#remarkDescription").val().trim();
									$.ajax({
										type: 'post',
										url: "${pageContext.request.contextPath }/user/add",
										data: JSON.stringify({
											roleID: roleID,
											nickName: nickName,
											password: password,
											userName: userName,
											createDate: createDate,
											remarkDescription: remarkDescription
										}),
										contentType: "application/json;charset=UTF-8",
										dataType: "json",
										success: function (data) {
											layer.msg('添加成功!', {
												icon: 1, time: 1000, end: function () {
													location.reload();
												}
											});
										},
										error: function (data) {
											layer.msg('账户已存在!', {icon: 5, time: 1000, anim: 6});
										}
									});
								}
								, xs2: function (index, layero) {
									layer.close(index);
								}, success: function (layero) {
									$("#roleID").val('');
									$("#nickName").val("");
									$("#password").val("123456");
									$("#userName").val("");
									$("#remarkDescription").val('');
									form.render('select');
								}
							}
							tk('添加用户', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '关闭'], _funbtnxs);
							break;
						case 'update':
							var dataRow = checkStatus.data;  //获取选中行数据
							if (dataRow.length == 0) {
								layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
								return false;
							}
							var _funbtnxs = {
								yesxs1: function (index, layero) {
									var nickName = $("#nickName").val().trim();
									if (nickName == "") {
										layer.msg('请输入昵称', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									if (nickName.length < 6) {
										layer.msg('昵称长度>=6', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var password = $("#password").val().trim();
									if (password == "") {
										layer.msg('请输入密码', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									if (password.length < 6) {
										layer.msg('密码长度>=6', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var userName = $("#userName").val().trim();
									if (userName == "") {
										layer.msg('请输入姓名', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var roleID = $("#roleID").val();
									if (roleID == "") {
										layer.msg('请选择角色', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var remarkDescription = $("#remarkDescription").val().trim();
									$.ajax({
										type: 'post',
										url: "${pageContext.request.contextPath }/user/update",
										data: JSON.stringify({
											id: dataRow[0].id,
											roleID: roleID,
											nickName: nickName,
											password: password,
											userName: userName,
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
									layer.close(index);
								}, success: function (layero) {
									$("#roleID").val(dataRow[0].roleID);
									$("#nickName").val(dataRow[0].nickName);
									$("#password").val(dataRow[0].password);
									$("#userName").val(dataRow[0].userName);
									$("#remarkDescription").val(dataRow[0].remarkDescription);
									form.render('select')
								}
							}
							tk('修改用户', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '关闭'], _funbtnxs);
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
									url: '${pageContext.request.contextPath }/user/delete',
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
					};
				});
				// 搜索
				let $ = layui.$, active = {
					reload: function () {
						var timeStart = null;
						var timeStartStr = $("#timeStart").val().trim();
						if (timeStartStr != "") {
							var sdate = timeStartStr.split('-');
							timeStart = new Date(sdate[0], sdate[1]-1, sdate[2]);//时分秒设置为0
						}
						var timeFinal = null;
						var timeFinalStr = $("#timeFinal").val().trim();
						if (timeFinalStr != "") {
							var sdate = timeFinalStr.split('-');
							timeFinal = new Date(sdate[0], sdate[1]-1, sdate[2]);//时分秒设置为0
						}
						//执行重载
						table.reload('LAY_table_user', {
							url: '${pageContext.request.contextPath }/user/searchList',
							method: 'post',
							contentType: "application/json;charset=UTF-8",
							page: {
								curr: 1 //重新从第 1 页开始
							}, where: {
								timeStart: timeStart,
								timeFinal: timeFinal,
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
				// 角色
				$.ajax({
					url: '${pageContext.request.contextPath }/role/getList',
					method: 'post',
					data: JSON.stringify({}),
					contentType: "application/json;charset=UTF-8",
					dataType: "json",
					success: function (data) {
						$('#roleID').empty();
						$('#roleID').append(new Option("请选择", ""));
						$.each(data, function (index, item) {
							$('#roleID').append(new Option(item.roleName, item.id));
						});
						form.render("select");
					}, error: function (data) {
						$('#roleID').empty();
						$('#roleID').append(new Option("请选择", ""));
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
				<colgroup>
					<col width="5%" style="min-width: 60px;max-width: 60px;">
					<col>
				</colgroup>
				<tbody>
				<tr>
					<td align="right" style="padding: 9px 0px 9px 0px;"><span style="color:red;">*</span>昵称：</td>
					<td align="left" style="padding: 9px 15px 9px 0px;">
						<input type="text" id="nickName" autocomplete="off" class="layui-input"
							   placeholder="请输入">
					</td>
				</tr>
				<tr>
					<td align="right" style="padding: 9px 0px 9px 0px;"><span style="color:red;">*</span>密码：</td>
					<td align="left" style="padding: 9px 15px 9px 0px;">
						<input type="text" id="password" autocomplete="off" class="layui-input"
							   placeholder="请输入">
					</td>
				</tr>
				<tr>
					<td align="right" style="padding: 9px 0px 9px 0px;"><span style="color:red;">*</span>姓名：</td>
					<td align="left" style="padding: 9px 15px 9px 0px;">
						<input type="text" id="userName" autocomplete="off" class="layui-input"
							   placeholder="请输入">
					</td>
				</tr>
				<tr>
					<td align="right" style="padding: 9px 0px 9px 0px;"><span style="color:red;">*</span>角色：</td>
					<td align="left" style="padding: 9px 15px 9px 0px;">
						<select id="roleID" lay-filter="roleID" lay-search>
							<option value="">请选择</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="right" style="padding: 9px 0px 9px 0px;">备注：</td>
					<td align="left" style="padding: 9px 15px 9px 0px;">
						<textarea id="remarkDescription" rows="20" autocomplete="off" class="layui-textarea" placeholder="请输入..."></textarea>
					</td>
				</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>