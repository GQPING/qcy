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
			<span class="c-gray en">&gt;</span> 客户管理
			<span class="c-gray en">&gt;</span> 客户列表
			<span class="c-gray en">&gt;</span> 联系信息
            <a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);"><i class="Hui-iconfont">&#xe68f;</i></a>
		</nav>
		<div class="page-container">
			<table class="layui-hide" id="LAY_table_user" lay-filter="LAY_table_user"></table>
		</div>
	</div>
	<!--工具栏-->
	<script type="text/html" id="toolbarDemo">
        <div class="layui-btn-container">
			<button id="createbtn" style="display: none;" class="layui-btn layui-btn-sm" lay-event="create"><i class="Hui-iconfont">&#xe604;</i> 创建</button>
			<button id="updatebtn" style="display: none;" class="layui-btn layui-btn-sm" lay-event="update"><i class="Hui-iconfont">&#xe72a;</i> 修改</button>
			<button id="deletebtn" style="display: none;" class="layui-btn layui-btn-sm" lay-event="delete"><i class="Hui-iconfont">&#xe6e2;</i> 删除</button>
        </div>
    </script>
	<!--自增序号-->
	<script type="text/html" id="xuhao">
		<span data-d="{{d.LAY_TABLE_INDEX+1}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.LAY_TABLE_INDEX+1}}</span>
	</script>
	<!-- 客户名称-->
	<script type="text/html" id="customerNameTpl">
		<span data-d="{{d.customer.customerName}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.customer.customerName}}</span>
	</script>
	<!-- 联系人-->
	<script type="text/html" id="contactPersonTpl">
		<span data-d="{{d.contactPerson}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.contactPerson}}</span>
	</script>
	<!-- 联系电话 -->
	<script type="text/html" id="contactPhoneTpl">
		<span data-d="{{d.contactPhone}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.contactPhone}}</span>
	</script>
	<!-- 发票地址 -->
	<script type="text/html" id="contactAddressTpl">
		<span data-d="{{d.contactAddress}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.contactAddress}}</span>
	</script>
	<!-- 联系人备注 -->
	<script type="text/html" id="contactRemarkDescriptionTpl">
		<span data-d="{{d.contactRemarkDescription}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.contactRemarkDescription}}</span>
	</script>
	<%@include file="../../other/conjs.html" %>
    <script type="text/javascript">
		// 初始化脚本
		$(function () {
			// lay加载
			layui.use(['form', 'table'], function () {
				let table = layui.table;
				let form = layui.form;
				// 执行一个table实例
				table.render({
					elem: '#LAY_table_user' // 指定表格
					, id: 'LAY_table_user'
					, url: '${pageContext.request.contextPath }/contact/searchAll' //数据请求路径
					, method: 'post'
					, contentType: "application/json;charset=UTF-8"
					, where: { customerID : "${customerID}" }
					, size: 'lg' //sm小尺寸的表格 lg大尺寸
					, cellMinWidth: 150 // 表格单元格最小宽度
					, toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
					, defaultToolbar: ['filter', 'exports', 'print']
					, cols: [[
						{type: 'radio'}
						, {
							field: 'id',
							title: '序号',
							sort: true,
							width: 80,
							align: 'center',
							templet: '#xuhao'
						}
						, {
							field: 'customerName',
							minWidth:240,
							title: '客户名称',
							sort: true,
							align: 'center',
							templet: "#customerNameTpl"
						}
						, {
							field: 'contactPerson',
							title: '联系人',
							sort: true,
							align: 'center',
							templet: "#contactPersonTpl"
						}
						, {
							field: 'contactPhone',
							title: '联系方式',
							sort: true,
							align: 'center',
							templet: "#contactPhoneTpl"
						}
						, {
							field: 'contactAddress',
							title: '联系地址',
							sort: true,
							align: 'center',
							templet: "#contactAddressTpl"
						}
						, {
							field: 'contactRemarkDescription',
							title: '联系人备注',
							sort: true,
							align: 'center',
							templet: "contactRemarkDescriptionTpl"
						}
					]]
					, page: false  //关闭分页
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
									var contactPerson = $("#contactPerson").val().trim();
									if (contactPerson == "") {
										layer.msg('请输入联系人', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var contactPhone = $("#contactPhone").val().trim();
									if (contactPhone == "") {
										layer.msg('请输入联系方式', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									// 手机号合法规则
									var reg = /(^$)|^1\d{10}$/;
									if (!reg.test(contactPhone)) {
										layer.msg('请输入正确的手机号', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var contactAddress = $("#contactAddress").val().trim();
									if (contactAddress == "") {
										layer.msg('请输入联系地址', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var contactRemarkDescription = $("#contactRemarkDescription").val().trim();
									$.ajax({
										type: 'post',
										url: "${pageContext.request.contextPath }/contact/add",
										data: JSON.stringify({
											customerID: "${customerID}",
											contactPerson: contactPerson,
											contactPhone: contactPhone,
											contactAddress: contactAddress,
											contactRemarkDescription: contactRemarkDescription
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
											layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6});
										}
									});
								}
								, xs2: function (index, layero) {
									layer.close(index);
								}, success: function (layero) {
									$("#contactPerson").val('');
									$("#contactPhone").val('');
									$("#contactAddress").val('');
									$("#contactRemarkDescription").val('');
								}
							}
							tk('添加联系人', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '关闭'], _funbtnxs);
							break;
						case 'update':
							var dataRow = checkStatus.data;  //获取选中行数据
							if (dataRow.length == 0) {
								layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
								return false;
							}
							var _funbtnxs = {
								yesxs1: function (index, layero) {
									var contactPerson = $("#contactPerson").val().trim();
									if (contactPerson == "") {
										layer.msg('请输入联系人', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var contactPhone = $("#contactPhone").val().trim();
									if (contactPhone == "") {
										layer.msg('请输入联系方式', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									// 手机号合法规则
									var reg = /(^$)|^1\d{10}$/;
									if (!reg.test(contactPhone)) {
										layer.msg('请输入正确的手机号', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var contactAddress = $("#contactAddress").val().trim();
									if (contactAddress == "") {
										layer.msg('请输入联系地址', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var contactRemarkDescription = $("#contactRemarkDescription").val().trim();
									$.ajax({
										type: 'post',
										url: "${pageContext.request.contextPath }/contact/update",
										data: JSON.stringify({
											id: dataRow[0].id,
											contactPerson: contactPerson,
											contactPhone: contactPhone,
											contactAddress: contactAddress,
											contactRemarkDescription: contactRemarkDescription
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
									$("#contactPerson").val(dataRow[0].contactPerson);
									$("#contactPhone").val(dataRow[0].contactPhone);
									$("#contactAddress").val(dataRow[0].contactAddress);
									$("#contactRemarkDescription").val(dataRow[0].contactRemarkDescription);
								}
							}
							tk('修改联系人', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '关闭'], _funbtnxs);
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
									url: '${pageContext.request.contextPath }/contact/delete',
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
				permission();//权限验证
			});
		});
		// 权限
		function permission(){
			$.ajax({
				url: '${pageContext.request.contextPath }/rolePermission/searchList',
				method: 'post',
				data: JSON.stringify({id:'${sessionScope.CurrentUser.roleID}',menuNameString:'联系信息'}),
				contentType: "application/json;charset=UTF-8",
				dataType: "json",
				success: function (data) {
					let obj = eval(data);
					$(obj).each(function (index) {
						let item = obj[index];
						switch (item.operation.operateName) {
							case "创建":document.getElementById("createbtn").style.display = "";break;
							case "修改":document.getElementById("updatebtn").style.display = "";break;
							case "删除":document.getElementById("deletebtn").style.display = "";break;
						}
					});
				}, error: function (data) {
					//layer.msg('权限获取异常!', {icon: 5, time: 1000, anim: 6});
				}
			});
		}
    </script>
	<!--创建修改弹窗-->
	<div id="bjnr" style="display: none;">
		<form class="layui-form">
			<table class="layui-table layui-xs" lay-skin="nob">
				<tbody>
				<tr>
					<td align="right" width="80"><label style="letter-spacing:0.5em;margin-right:-0.5em;">联系人</label>：</td>
					<td align="left">
						<input type="text" id="contactPerson" autocomplete="off" placeholder="请输入" class="layui-input">
					</td>
				</tr>
				<tr>
					<td align="right">联系电话：</td>
					<td align="left">
						<input type="text" id="contactPhone" autocomplete="off" placeholder="请输入" class="layui-input">
					</td>
				</tr>
				<tr>
					<td align="right">联系地址：</td>
					<td align="left">
						<input type="text" id="contactAddress" autocomplete="off" placeholder="请输入" class="layui-input">
					</td>
				</tr>
				<tr>
					<td align="right">备注说明：</td>
					<td align="left">
						<textarea id="contactRemarkDescription" rows="20" autocomplete="off" placeholder="请输入" class="layui-textarea"></textarea>
					</td>
				</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>