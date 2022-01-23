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
			<span class="c-gray en">&gt;</span> 回访信息
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
	<!-- 产品型号-->
	<script type="text/html" id="productModeTpl">
		<span data-d="{{d.productMode}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.productMode}}</span>
	</script>
	<!-- 出库日期 -->
	<script type="text/html" id="exportDateTpl">
		<span data-d="{{layui.util.toDateString(d.exportDate, 'yyyy-MM-dd')}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{layui.util.toDateString(d.exportDate, 'yyyy-MM-dd')}}</span>
	</script>
	<!-- 项目地址 -->
	<script type="text/html" id="projectAddressTpl">
		<span data-d="{{d.projectAddress}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.projectAddress}}</span>
	</script>
	<!-- 回访详情 -->
	<script type="text/html" id="descriptionTpl">
		<span data-d="{{d.description}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.description}}</span>
	</script>
	<!-- 回访备注 -->
	<script type="text/html" id="visitRemarkDescriptionTpl">
		<span data-d="{{d.visitRemarkDescription}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.visitRemarkDescription}}</span>
	</script>
	<!-- 创建日期 -->
	<script type="text/html" id="visitCreateDateTpl">
		<span data-d="{{layui.util.toDateString(d.visitCreateDate, 'yyyy-MM-dd HH:mm:ss')}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{layui.util.toDateString(d.visitCreateDate, 'yyyy-MM-dd HH:mm:ss')}}</span>
	</script>
	<%@include file="../../other/conjs.html" %>
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
					, url: '${pageContext.request.contextPath }/visit/searchAll' //数据请求路径
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
							templet: '#customerNameTpl'
						}
						, {
							field: 'productMode',
							title: '产品型号',
							sort: true,
							align: 'center',
							templet: "#productModeTpl"
						}
						, {
							field: 'exportDate',
							title: '出库日期',
							sort: true,
							align: 'center',
							templet: "#exportDateTpl"
						}
						, {
							field: 'projectAddress',
							title: '项目地址',
							sort: true,
							align: 'center',
							templet: "#projectAddressTpl"
						}
						, {
							field: 'description',
							title: '回访详情',
							sort: true,
							align: 'center',
							templet: "#descriptionTpl"
						}
						, {
							field: 'visitCreateDate',
							minWidth:240,
							title: '创建日期',
							sort: true,
							align: 'center',
							templet: "#visitCreateDateTpl"
						}
						, {
							field: 'visitRemarkDescription',
							title: '回访备注',
							sort: true,
							align: 'center',
							templet: "#visitRemarkDescriptionTpl"
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
									var exportDateStr = $("#exportDate").val().trim();
									if (exportDateStr == "") {
										layer.msg('请选择出库日期', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var sdate = exportDateStr.split('-');
									var exportDate = new Date(sdate[0], sdate[1]-1, sdate[2]);//时分秒设置为0
									var productMode = $("#productModeInput").val().trim();
									if (productMode == "") {
										layer.msg('请选择产品型号', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var projectAddress = $("#projectAddress").val().trim();
									if (projectAddress == "") {
										layer.msg('请输入项目地址', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var description = $("#description").val().trim();
									if (description == "") {
										layer.msg('请输入回访详情', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var visitRemarkDescription = $("#visitRemarkDescription").val().trim();
									$.ajax({
										type: 'post',
										url: "${pageContext.request.contextPath }/visit/add",
										data: JSON.stringify({
											customerID: "${customerID}",
											exportDate: exportDate,
											productMode: productMode.toUpperCase(),
											projectAddress: projectAddress,
											description: description,
											visitCreateDate: new Date(),
											visitRemarkDescription: visitRemarkDescription
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
									$("#exportDate").val('');
									$("#productMode").val('');
									$("#productModeInput").val('');
									document.getElementById("productModeInput").style.display="none";
									$("#projectAddress").val('');
									$("#description").val('');
									$("#visitRemarkDescription").val('');
									form.render('select');
								}
							}
							tk('添加回访', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '关闭'], _funbtnxs);
							// 下拉框值改变动态设置其它输入
							form.on('select(productMode)', function (data) {
								if(data.value == "其它__") {
									$("#productModeInput").val('');
									document.getElementById("productModeInput").style.display="";
								} else{
									$("#productModeInput").val(data.value);
									document.getElementById("productModeInput").style.display="none";
								}
								form.render('select');
							});
							break;
						case 'update':
							var dataRow = checkStatus.data;  //获取选中行数据
							if (dataRow.length == 0) {
								layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
								return false;
							}
							var _funbtnxs = {
								yesxs1: function (index, layero) {
									var exportDateStr = $("#exportDate").val().trim();
									if (exportDateStr == "") {
										layer.msg('请选择出库日期', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var sdate = exportDateStr.split('-');
									var exportDate = new Date(sdate[0], sdate[1]-1, sdate[2]);//时分秒设置为0
									var productMode = $("#productModeInput").val().trim();
									if (productMode == "") {
										layer.msg('请选择产品型号', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var projectAddress = $("#projectAddress").val().trim();
									if (projectAddress == "") {
										layer.msg('请输入项目地址', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var description = $("#description").val().trim();
									if (description == "") {
										layer.msg('请输入回访详情', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var visitRemarkDescription = $("#visitRemarkDescription").val().trim();
									$.ajax({
										type: 'post',
										url: "${pageContext.request.contextPath }/visit/update",
										data: JSON.stringify({
											id: dataRow[0].id,
											exportDate: exportDate,
											productMode: productMode.toUpperCase(),
											projectAddress:projectAddress,
											description: description,
											visitRemarkDescription: visitRemarkDescription
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
									$("#exportDate").val(layui.util.toDateString(dataRow[0].exportDate, 'yyyy-MM-dd'));
									$("#productMode").val(dataRow[0].productMode);
									$("#productModeInput").val(dataRow[0].productMode);
									if($("#productMode").val()==null || $("#productMode").val()==""){
										$("#productMode").val("其它__");
										document.getElementById("productModeInput").style.display="";
									}else{
										document.getElementById("productModeInput").style.display="none";
									}
									$("#projectAddress").val(dataRow[0].projectAddress);
									$("#description").val(dataRow[0].description);
									$("#visitRemarkDescription").val(dataRow[0].visitRemarkDescription);
									form.render('select');
								}
							}
							tk('修改回访', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '关闭'], _funbtnxs);
							// 下拉框值改变动态设置其它输入
							form.on('select(productMode)', function (data) {
								if(data.value == "其它__") {
									$("#productModeInput").val('');
									document.getElementById("productModeInput").style.display="";
								} else{
									$("#productModeInput").val(data.value);
									document.getElementById("productModeInput").style.display="none";
								}
								form.render('select');
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
									url: '${pageContext.request.contextPath }/visit/delete',
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
				data: JSON.stringify({id:'${sessionScope.CurrentUser.roleID}',menuNameString:'回访信息'}),
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
					<td align="right" width="80">出库日期：</td>
					<td align="left">
						<input type="text" id="exportDate" placeholder="请选择" autocomplete="off" class="layui-input">
					</td>
				</tr>
				<tr>
					<td align="right">产品型号：</td>
					<td align="left">
						<select class="layui-input" id="productMode" placeholder="请选择" lay-filter="productMode">
							<option value="">请选择</option>
							<optgroup label="QT1000系列">
								<option value="QT1000A">QT1000A</option>
								<option value="QT1000B">QT1000B</option>
								<option value="QT1000C">QT1000C</option>
								<option value="QT1000D">QT1000D</option>
								<option value="QT1000PA">QT1000PA</option>
							</optgroup>
							<optgroup label="QT800系列">
								<option value="QT800A">QT800A</option>
								<option value="QT800B">QT800B</option>
								<option value="QT800C">QT800C</option>
								<option value="QT800D">QT800D</option>
							</optgroup>
							<optgroup label="QT600系列">
								<option value="QT600A">QT600A</option>
								<option value="QT600SA">QT600SA</option>
							</optgroup>
							<optgroup label="QT300系列">
								<option value="QT300SA">QT300SA</option>
							</optgroup>
							<optgroup label="其它系列">
								<option value="QT1265D">QT1265D</option>
							</optgroup>
							<option value="其它__">其它__</option>
						</select>
						<input type="text" style="display: none" id="productModeInput" autocomplete="off"
							   class="layui-input" placeholder="请输入">
					</td>
				</tr>
				<tr>
					<td align="right">项目地址：</td>
					<td align="left">
						<input type="text" id="projectAddress" placeholder="请输入" autocomplete="off" class="layui-input">
					</td>
				</tr>
				<tr>
					<td align="right">回访详情：</td>
					<td align="left">
						<textarea id="description" rows="20" autocomplete="off" class="layui-textarea" placeholder="请输入"></textarea>
					</td>
				</tr>
				<tr>
					<td align="right">备注说明：</td>
					<td align="left">
						<textarea id="visitRemarkDescription" rows="20" autocomplete="off" class="layui-textarea" placeholder="请输入"></textarea>
					</td>
				</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>