<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../../other/meta.html" %>
	<%@include file="../../other/style.html" %>
</head>
<body>
	<div>
		<nav class="breadcrumb">
			<i class="Hui-iconfont">&#xe67f;</i> 首页
			<span class="c-gray en">&gt;</span> 合同管理
			<span class="c-gray en">&gt;</span> ${type}合同
			<span class="c-gray en">&gt;</span> 合同明细<c:if test="${type ne '代理'}">【<label id="projectLabelTitle"></label>】</c:if>
			<span class="c-gray en">&gt;</span> 开票信息
			<a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);">
				<i class="Hui-iconfont">&#xe68f;</i>
			</a>
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
	<!--开票编号-->
	<script type="text/html" id="billIDTpl">
		<span data-d="{{d.id}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.id}}</span>
	</script>
	<!-- 所属分期 -->
	<script type="text/html" id="stageIDTpl">
		{{# var fn = function(){
		    if(d.stageID==null){
		         return "--";
		    }else{
		         return layui.util.toDateString(d.stage.stageStartDate, 'yyyy-MM-dd')+" ~ "+layui.util.toDateString(d.stage.stageEndDate, 'yyyy-MM-dd');
		    }
		};}}
		<span data-d="{{ fn() }}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ fn() }}</span>
	</script>
	<!-- 开票类型 -->
	<script type="text/html" id="billTypeTpl">
		<span data-d="{{d.billType}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.billType}}</span>
	</script>
	<!-- 开票金额 -->
	<script type="text/html" id="billQuotaTpl">
		<span data-d="{{d.billQuota}}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label" style="color: #009688;">{{ d.billQuota }}元</span>
	</script>
	<!-- 开票日期 -->
	<script type="text/html" id="billDateTpl">
		<span data-d="{{layui.util.toDateString(d.billDate, 'yyyy-MM-dd')}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{layui.util.toDateString(d.billDate, 'yyyy-MM-dd')}}</span>
	</script>
	<!-- 开票说明 -->
	<script type="text/html" id="billRemarkDescriptionTpl">
		<span data-d="{{d.billRemarkDescription}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.billRemarkDescription}}</span>
	</script>
	<%@include file="../../other/conjs.html" %>
    <script type="text/javascript">
		// 初始化脚本
		$(function () {
			//获取合同明细
			$.ajax({
				url: '${pageContext.request.contextPath }/contractDetail/getById',
				method: 'post',
				data: {id:"${contractDetailID}"},
				dataType: "json",
				success: function (data) {
					let origin = eval(data);// 合同明细对象
					// lay加载
					layui.use(['form', 'table', 'laydate'], function () {
						let table = layui.table;
						let form = layui.form;
						let laydate = layui.laydate;
						//执行一个laydate实例
						laydate.render({
							elem: '#billDate' //指定元素
						});
						// 初始化表格
						table.render({
							elem: '#LAY_table_user' // 指定表格
							, id: 'LAY_table_user'
							, url: '${pageContext.request.contextPath }/bill/searchAll' //数据请求路径
							, method: 'post'
							, contentType: "application/json;charset=UTF-8"
							, where: {
								contractDetailID : "${contractDetailID}"
							}
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
									sort:true,
									align: 'center',
									templet: '#xuhao'
								}
								, {
									field: 'stageID',
									title: '所属分期',
									minWidth:240,
									sort:true,
									align: 'center',
									templet: '#stageIDTpl'
								}
								, {
									field: 'billType',
									title: '开票类型',
									sort:true,
									align: 'center',
									templet: '#billTypeTpl'
								}
								, {
									field: 'billQuota',
									title: '开票金额',
									sort:true,
									align: 'center',
									templet: "#billQuotaTpl"
								}
								, {
									field: 'billDate',
									title: '开票日期',
									sort:true,
									align: 'center',
									templet: "#billDateTpl"
								}
								, {
									field: 'billRemarkDescription',
									title: '开票说明',
									sort:true,
									align: 'center',
									templet: '#billRemarkDescriptionTpl'
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
									if(origin.contract.contractState!="正常"){
										layer.msg('合同处于终止状态', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var _funbtnxs = {
										yesxs1: function (index, layero) {
											var stageID = $("#stageID").val().trim();
											if (stageID == "") {
												stageID = null;
											}
											var billType = $("#billType").val().trim();
											if (billType == "") {
												layer.msg('请选择开票类型', {icon: 0, time: 1000, anim: 6});
												return false;
											}
											var billQuota = $("#billQuota").val().trim();
											if (billQuota == "") {
												layer.msg('请输入开票金额', {icon: 0, time: 1000, anim: 6});
												return false;
											}
											var billDateStr = $("#billDate").val().trim();
											if (billDateStr == "") {
												layer.msg('请输入开票日期', {icon: 0, time: 1000, anim: 6});
												return false;
											}
											var sdate0 = billDateStr.split('-');
											var billDate = new Date(sdate0[0], sdate0[1]-1, sdate0[2]);//时分秒设置为0
											var billRemarkDescription = $("#billRemarkDescription").val().trim();
											$.ajax({
												type: 'post',
												url: "${pageContext.request.contextPath }/bill/add",
												data: JSON.stringify({
													contractDetailID: "${contractDetailID}",
													stageID: stageID,
													billType: billType,
													billQuota: billQuota,
													billDate: billDate,
													billRemarkDescription: billRemarkDescription
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
											$("#stageID").val('');
											$("#billType").val('不含税');
											$("#billQuota").val('0');
											$("#billDate").val(layui.util.toDateString(new Date(), 'yyyy-MM-dd'));
											$("#billRemarkDescription").val('');
											form.render('select');
										}
									}
									tk('添加开票信息', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '取消'], _funbtnxs);
									break;
								case 'update':
									if(origin.contract.contractState!="正常"){
										layer.msg('合同处于终止状态', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var dataRow = checkStatus.data;  //获取选中行数据
									if (dataRow.length == 0) {
										layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var _funbtnxs = {
										yesxs1: function (index, layero) {
											var stageID = $("#stageID").val().trim();
											if (stageID == "") {
												stageID = null;
											}
											var billType = $("#billType").val().trim();
											if (billType == "") {
												layer.msg('请选择开票类型', {icon: 0, time: 1000, anim: 6});
												return false;
											}
											var billQuota = $("#billQuota").val().trim();
											if (billQuota == "") {
												layer.msg('请输入开票金额', {icon: 0, time: 1000, anim: 6});
												return false;
											}
											var billDateStr = $("#billDate").val().trim();
											if (billDateStr == "") {
												layer.msg('请输入开票日期', {icon: 0, time: 1000, anim: 6});
												return false;
											}
											var sdate0 = billDateStr.split('-');
											var billDate = new Date(sdate0[0], sdate0[1]-1, sdate0[2]);//时分秒设置为0
											var billRemarkDescription = $("#billRemarkDescription").val().trim();
											$.ajax({
												type: 'post',
												url: "${pageContext.request.contextPath }/bill/update",
												data: JSON.stringify({
													id: dataRow[0].id,
													contractDetailID: "${contractDetailID}",
													stageID: stageID,
													billType: billType,
													billQuota: billQuota,
													billDate: billDate,
													billRemarkDescription: billRemarkDescription
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
											$("#stageID").val(dataRow[0].stageID);
											$("#billType").val(dataRow[0].billType);
											$("#billQuota").val(dataRow[0].billQuota);
											$("#billDate").val(layui.util.toDateString(dataRow[0].billDate, 'yyyy-MM-dd'));
											$("#billRemarkDescription").val(dataRow[0].billRemarkDescription);
											form.render('select');
										}
									}
									tk('修改开票信息', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '取消'], _funbtnxs);
									break;
								case 'delete':
									if(origin.contract.contractState!="正常"){
										layer.msg('合同处于终止状态', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var dataRow = checkStatus.data;  //获取选中行数据
									if (dataRow.length == 0) {
										layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									layer.confirm('确认要删除吗？', function (index) {
										$.ajax({
											type: 'post',
											url: '${pageContext.request.contextPath }/bill/delete',
											data: {id: dataRow[0].id},
											success: function (data) {
												if (data == '1') {
													layer.msg('删除成功!', {
														icon: 1, time: 1000, end: function () {
															location.reload();
														}
													});
												} else {
													layer.msg('删除失败!', {icon: 5, time: 1000, anim: 6});
												}
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
						// 分期列表
						$.ajax({
							url: '${pageContext.request.contextPath }/stage/getList',
							method: 'post',
							data: JSON.stringify({
								contractDetailID : "${contractDetailID}"
							}),
							contentType: "application/json;charset=UTF-8",
							dataType: "json",
							success: function (data) {
								$('#stageID').empty();
								$('#stageID').append('<option value="">请选择</option>');
								$.each(data, function (index, item) {
									$('#stageID').append('<option value='+item.id+'>'+layui.util.toDateString(item.stageStartDate, 'yyyy-MM-dd')
											+' ~ '+layui.util.toDateString(item.stageEndDate, 'yyyy-MM-dd')+'</option>');
								});
								form.render("select");
							}, error: function (data) {
								$('#stageID').empty();
								$('#stageID').append('<option value="">请选择</option>');
								form.render("select");
							}
						});
						//所属合同明细
						$.ajax({
							url: '${pageContext.request.contextPath }/contractDetail/getById',
							method: 'post',
							data: {id: "${contractDetailID}"},
							success: function (data) {
								if(data!=null) {
									var obj = eval(data);
									$("#projectLabelTitle").text(obj.projectAddress);
								}
							}, error: function (data) {
								layer.msg('读取合同明细异常!', {icon: 5, time: 1000, anim: 6});
							}
						});
						permission();//权限验证
					});
				}, error: function (data) {
					//layer.msg('数据获取异常!', {icon: 5, time: 1000, anim: 6});
				}
			});
		});
		// 权限
		function permission(){
			$.ajax({
				url: '${pageContext.request.contextPath }/rolePermission/searchList',
				method: 'post',
				data: JSON.stringify({id:'${sessionScope.CurrentUser.roleID}',menuNameString:'开票信息'}),
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
	<div id="bjnr" style="display: none;">
		<form class="layui-form">
			<table class="layui-table layui-xs" lay-skin="nob">
				<tbody>
				<tr>
					<td align="right" width="80">所属分期：</td>
					<td align="left">
						<select class="layui-input" id="stageID"></select>
					</td>
				</tr>
				<tr>
					<td align="right">开票类型：</td>
					<td align="left">
						<select class="layui-input" id="billType">
							<option value="">请选择</option>
							<option value="普税">普税</option>
							<option value="专税">专税</option>
							<option value="不含税">不含税</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="right">开票金额：<span style="margin-right: 22px">（元）</span></td>
					<td align="left">
						<input type="text" id="billQuota" autocomplete="off" class="layui-input" placeholder="请输入" onblur="if(value=='')execCommand('undo')" Onkeyup="if(isNaN(value))execCommand('undo')" Onpaste="return false;" >
					</td>
				</tr>
				<tr>
					<td align="right">开票日期：</td>
					<td align="left">
						<input type="text" id="billDate" autocomplete="off" class="layui-input" placeholder="请选择日期">
					</td>
				</tr>
				<tr>
					<td align="right">开票说明：</td>
					<td align="left">
						<textarea id="billRemarkDescription" rows="20" utocomplete="off" class="layui-textarea" placeholder="请输入"></textarea>
					</td>
				</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>