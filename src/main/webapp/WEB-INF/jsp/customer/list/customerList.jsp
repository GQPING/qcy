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
            <a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);"><i class="Hui-iconfont">&#xe68f;</i></a>
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
			<button id="createbtn" style="display: none;" class="layui-btn layui-btn-sm" lay-event="create"><i class="Hui-iconfont">&#xe604;</i> 创建</button>
			<button id="updatebtn" style="display: none;" class="layui-btn layui-btn-sm" lay-event="update"><i class="Hui-iconfont">&#xe72a;</i> 修改</button>
			<button id="deletebtn" style="display: none;" class="layui-btn layui-btn-sm" lay-event="delete"><i class="Hui-iconfont">&#xe6e2;</i> 删除</button>
			<a id="visitInfo" href="javascript:;" style="color: white" class="layui-table-link">
				<button id="visitinfobtn" style="display: none;" class="layui-btn layui-btn-sm" lay-event="visitinfo">
					<i class="Hui-iconfont">&#xe70c;</i> 回访信息
				</button>
			</a>
			<a id="contactInfo" href="javascript:;" style="color: white" class="layui-table-link">
				<button id="contactinfobtn" style="display: none;" class="layui-btn layui-btn-sm" lay-event="contactinfo">
					<i class="Hui-iconfont">&#xe6a3;</i> 联系信息
				</button>
			</a>
        </div>
    </script>
	<!--自增序号-->
	<script type="text/html" id="xuhao">
		<span data-d="{{d.LAY_TABLE_INDEX+1}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.LAY_TABLE_INDEX+1}}</span>
	</script>
	<!-- 客户名称-->
	<script type="text/html" id="customerNameTpl">
		<span data-d="{{d.customerName}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.customerName}}</span>
	</script>
	<!-- 信用星级-->
	<script type="text/html" id="customerLevelTpl">
		{{#  if(d.customerLevel === 5){ }}
		<span data-d="{{d.customerLevel}}星" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label"><i class='Hui-iconfont'>&#xe6ff;</i><i class='Hui-iconfont'>&#xe6ff;</i><i class='Hui-iconfont'>&#xe6ff;</i><i class='Hui-iconfont'>&#xe6ff;</i><i class='Hui-iconfont'>&#xe6ff;</i></span>
		{{#  } else if(d.customerLevel === 4){ }}
		<span data-d="{{d.customerLevel}}星" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label"><i class='Hui-iconfont'>&#xe6ff;</i><i class='Hui-iconfont'>&#xe6ff;</i><i class='Hui-iconfont'>&#xe6ff;</i><i class='Hui-iconfont'>&#xe6ff;</i></span>
		{{#  } else if(d.customerLevel === 3){ }}
		<span data-d="{{d.customerLevel}}星" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label"><i class='Hui-iconfont'>&#xe6ff;</i><i class='Hui-iconfont'>&#xe6ff;</i><i class='Hui-iconfont'>&#xe6ff;</i></span>
		{{#  } else if(d.customerLevel === 2){ }}
		<span data-d="{{d.customerLevel}}星" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label"><i class='Hui-iconfont'>&#xe6ff;</i><i class='Hui-iconfont'>&#xe6ff;</i></span>
		{{#  } else { }}
		<span data-d="{{d.customerLevel}}星" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label"><i class='Hui-iconfont'>&#xe6ff;</i></span>
		{{#  } }}
	</script>
	<!-- 创建日期 -->
	<script type="text/html" id="customerCreateDateTpl">
		<span data-d="{{layui.util.toDateString(d.customerCreateDate, 'yyyy-MM-dd HH:mm:ss')}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{layui.util.toDateString(d.customerCreateDate, 'yyyy-MM-dd HH:mm:ss')}}</span>
	</script>
	<!-- 客户备注 -->
	<script type="text/html" id="customerRemarkDescriptionTpl">
		<span data-d="{{d.customerRemarkDescription}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.customerRemarkDescription}}</span>
	</script>
	<%@include file="../../other/conjs.html" %>
	<script type="text/javascript" src="${ctx}/static/h-ui/js/H-ui.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/h-ui.admin.pro.iframe/js/h-ui.admin.pro.iframe.min.js"></script>
    <script type="text/javascript">
		// 初始化脚本
		$(function () {
			// lay加载
			layui.use(['form', 'table', 'laydate'], function () {
				let table = layui.table;
				let form = layui.form;
				let laydate = layui.laydate;
				//执行一个laydate实例
				laydate.render({
					elem: '#exportDate' // 指定元素
				});
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
				// 执行一个table实例
				table.render({
					elem: '#LAY_table_user' // 指定表格
					, id: 'LAY_table_user'
					, url: '${pageContext.request.contextPath }/customer/searchList' //数据请求路径
					, method: 'post'
					, contentType: "application/json;charset=UTF-8"
					, where: {}
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
							field: 'customerLevel',
							title: '信用星级',
							sort: true,
							align: 'center',
							templet: "#customerLevelTpl"
						}
						, {
							field: 'customerCreateDate',
							minWidth:240,
							title: '创建日期',
							sort: true,
							align: 'center',
							templet: "#customerCreateDateTpl"
						}
						, {
							field: 'customerRemarkDescription',
							title: '客户备注',
							sort: true,
							align: 'center',
							templet: "customerRemarkDescriptionTpl"
						}
					]]
					, page: true  //开启分页
					, limit: 10   //默认十条数据一页
					, limits: [5, 10, 15, 20, 25, 30] //数据分页条
					, response: {
						statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
					}
				});
				// 单选选中事件
				table.on('radio(LAY_table_user)', function(obj){
					$('#visitInfo').attr('onclick','Hui_admin_tab(this)');
					$('#visitInfo').attr('data-href','${ctx}/visit/detail/'+obj.data.id);
					$('#visitInfo').attr('data-title','【'+obj.data.customerName+'】回访信息');

					$('#contactInfo').attr('onclick','Hui_admin_tab(this)');
					$('#contactInfo').attr('data-href','${ctx}/contact/detail/'+obj.data.id);
					$('#contactInfo').attr('data-title','【'+obj.data.customerName+'】联系信息');
				});
				// 头工具栏事件
				table.on('toolbar(LAY_table_user)', function (obj) {
					var checkStatus = table.checkStatus(obj.config.id); //获取选中行状态
					switch (obj.event) {
						case 'create':
							var _funbtnxs = {
								yesxs1: function (index, layero) {
									var customerName = $("#customerName").val().trim();
									if (customerName == "") {
										layer.msg('请输入客户名称', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var customerLevel = $("#customerLevel").val();
									if (customerLevel == "") {
										layer.msg('请选择信用星级', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var customerRemarkDescription = $("#customerRemarkDescription").val().trim();
									$.ajax({
										type: 'post',
										url: "${pageContext.request.contextPath }/customer/add",
										data: JSON.stringify({
											customerName: customerName,
											customerLevel: customerLevel,
											customerCreateDate: new Date(),
											customerRemarkDescription: customerRemarkDescription
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
											layer.msg('客户已存在!', {icon: 5, time: 1000, anim: 6});
										}
									});
								}
								, xs2: function (index, layero) {
									layer.close(index);
								}, success: function (layero) {
									$("#customerName").val('');
									$("#customerLevel").val(5);
									$("#customerRemarkDescription").val('');
									form.render('select');
								}
							}
							tk('添加客户', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '关闭'], _funbtnxs);
							break;
						case 'update':
							var dataRow = checkStatus.data;  //获取选中行数据
							if (dataRow.length == 0) {
								layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
								return false;
							}
							var _funbtnxs = {
								yesxs1: function (index, layero) {
									var customerName = $("#customerName").val().trim();
									if (customerName == "") {
										layer.msg('请输入客户名称', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var customerLevel = $("#customerLevel").val();
									if (customerLevel == "") {
										layer.msg('请选择信用星级', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var customerRemarkDescription = $("#customerRemarkDescription").val().trim();
									$.ajax({
										type: 'post',
										url: "${pageContext.request.contextPath }/customer/update",
										data: JSON.stringify({
											id: dataRow[0].id,
											customerName: customerName,
											customerLevel: customerLevel,
											customerRemarkDescription: customerRemarkDescription
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
											layer.msg('客户名称重复!', {icon: 5, time: 1000, anim: 6});
										}
									});
								}
								, xs2: function (index, layero) {
									layer.close(index);
								}, success: function (layero) {
									$("#customerName").val(dataRow[0].customerName);
									$("#customerLevel").val(dataRow[0].customerLevel);
									$("#customerRemarkDescription").val(dataRow[0].customerRemarkDescription);
									form.render('select');
								}
							}
							tk('修改客户', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '关闭'], _funbtnxs);
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
									url: '${pageContext.request.contextPath }/customer/delete',
									data: {id: dataRow[0].id},
									success: function (data) {
										layer.msg('删除成功!', {
											icon: 1, time: 1000, end: function () {
												location.reload();
											}
										});
									},
									error: function (data) {
										layer.msg('删除失败!', {icon: 5, time: 1000, anim: 6});
									},
								});
							});
							break;
						case 'visitinfo':
							var dataRow = checkStatus.data;  //获取选中行数据
							if (dataRow.length == 0) {
								layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
								return false;
							}
							break;
						case 'contactinfo':
							var dataRow = checkStatus.data;  //获取选中行数据
							if (dataRow.length == 0) {
								layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
								return false;
							}
							break;
					};
				});
				// 搜索
				var $ = layui.$, active = {
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
							url: '${pageContext.request.contextPath }/customer/searchList',
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
						permission();//权限验证
					}
				};
				// 刷新
				$('.demoTable .layui-btn').on('click', function () {
					var type = $(this).data('type');
					active[type] ? active[type].call(this) : '';
				});
				permission();//权限验证
			});
		});
		// 权限
		function permission(){
			$.ajax({
				url: '${pageContext.request.contextPath }/rolePermission/searchList',
				method: 'post',
				data: JSON.stringify({id:'${sessionScope.CurrentUser.roleID}',menuNameString:'客户列表'}),
				contentType: "application/json;charset=UTF-8",
				dataType: "json",
				success: function (data) {
					let obj = eval(data);
					$(obj).each(function (index) {
						let item = obj[index];
						console.log(item.operation.operateName)
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
			$.ajax({
				url: '${pageContext.request.contextPath }/rolePermission/search',
				method: 'post',
				data: JSON.stringify({id:'${sessionScope.CurrentUser.roleID}',menuNameString:'回访信息',operationNameString:'查看'}),
				contentType: "application/json;charset=UTF-8",
				dataType: "json",
				success: function (data) {
					document.getElementById("visitinfobtn").style.display = "";
				}, error: function (data) {
					//layer.msg('权限获取异常!', {icon: 5, time: 1000, anim: 6});
				}
			});
			$.ajax({
				url: '${pageContext.request.contextPath }/rolePermission/search',
				method: 'post',
				data: JSON.stringify({id:'${sessionScope.CurrentUser.roleID}',menuNameString:'联系信息',operationNameString:'查看'}),
				contentType: "application/json;charset=UTF-8",
				dataType: "json",
				success: function (data) {
					document.getElementById("contactinfobtn").style.display = "";
				}, error: function (data) {
					//layer.msg('权限获取异常!', {icon: 5, time: 1000, anim: 6});
				}
			});
		}
    </script>
	<div id="bjnr" style="display: none;">
		<form class="layui-form">
			<table class="layui-table layui-xs" lay-skin="nob">
				<tbody>
				<tr>
					<td align="right" width="80">客户名称：</td>
					<td>
						<input type="text" id="customerName" autocomplete="off" class="layui-input">
					</td>
				</tr>
				<tr>
					<td align="right">信用星级：</td>
					<td>
						<select class="layui-input" id="customerLevel" lay-filter="customerLevel">
							<option value="1">1星</option>
							<option value="2">2星</option>
							<option value="3">3星</option>
							<option value="4">4星</option>
							<option value="5" selected>5星</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="right">备  &nbsp;&nbsp;&nbsp;&nbsp; 注：</td>
					<td>
						<textarea id="customerRemarkDescription" rows="20" autocomplete="off" class="layui-textarea" placeholder="请输入"></textarea>
					</td>
				</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>