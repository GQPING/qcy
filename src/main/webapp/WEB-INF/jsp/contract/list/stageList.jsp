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
			<span class="c-gray en">&gt;</span> 分期信息
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
			<button id="createbtn" style="display: none;" class="layui-btn layui-btn-sm" lay-event="create"><i class="Hui-iconfont">&#xe600;</i> 创建</button>
			<button id="acreatbtn" style="display: none;" class="layui-btn layui-btn-sm" lay-event="acreat"><i class="Hui-iconfont">&#xe604;</i> 创建</button>
			<button id="updatebtn" style="display: none;" class="layui-btn layui-btn-sm" lay-event="update"><i class="Hui-iconfont">&#xe72a;</i> 修改</button>
			<button id="deletebtn" style="display: none;" class="layui-btn layui-btn-sm" lay-event="delete"><i class="Hui-iconfont">&#xe6e2;</i> 删除</button>
			<a id="cashInfo" href="javascript:;" style="color: white" class="layui-table-link">
				<button id="cashinfobtn" style="display: none;" class="layui-btn layui-btn-sm" lay-event="cashinfo">
					<i class="Hui-iconfont">&#xe735;</i> 收款信息
				</button>
			</a>
			<a id="billInfo" href="javascript:;" style="color: white" class="layui-table-link">
				<button id="billinfobtn" style="display: none;" class="layui-btn layui-btn-sm" lay-event="billinfo">
					<i class="Hui-iconfont">&#xe73b;</i> 开票信息
				</button>
			</a>
        </div>
    </script>
	<!--自增序号-->
	<script type="text/html" id="xuhao">
		<span data-d="{{d.LAY_TABLE_INDEX+1}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.LAY_TABLE_INDEX+1}}</span>
	</script>
	<!--分期编号-->
	<script type="text/html" id="stageIDTpl">
		<span data-d="{{d.id}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.id}}</span>
	</script>
	<!-- 分期区间 -->
    <script type="text/html" id="stageBetweenDateTpl">
         {{#
		     var fn = function(){
                return layui.util.toDateString(d.stageStartDate, 'yyyy-MM-dd') + "~" + layui.util.toDateString(d.stageEndDate, 'yyyy-MM-dd');   
             };
         }}
         <span data-d="{{fn()}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ fn() }}</span>
    </script>
	<!-- 分期周期 -->
	<script type="text/html" id="stageDateCycleTpl">
		{{# var fn = function(){
		    return parseFloat(d.stageDateCycle.toString()).toFixed(1);
		};}}
		<span data-d="{{ fn() }}个月" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ fn() }}个月</span>
	</script>
	<!-- 分期状态 -->
	<script type="text/html" id="stageDateStateTpl">
		{{# var fn = function(){
		var cur = new Date(Date.parse(layui.util.toDateString(new Date(), 'yyyy-MM-dd')));
		var end = new Date(Date.parse(layui.util.toDateString(d.stageEndDate, 'yyyy-MM-dd')));
		var t1 = cur.getTime();
		var t2 = end.getTime();
		var datetime=1000*60*60*24;
		var minusDays = Math.floor(((t2-t1)/datetime));
		if(minusDays<=-1){
		return "过期" + Math.abs(minusDays) + "天";
		}else{
		return "剩余" + Math.abs(minusDays) + "天";
		}
		};}}
		{{#  if(fn().indexOf("过期")!=-1){ }}
		<span data-d="{{ fn() }}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" style="color: #FF5722;" class="layui-table-label">{{ fn() }}</span>
		{{#  } else { }}
		<span data-d="{{ fn() }}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" style="color: #009688;" class="layui-table-label">{{ fn() }}</span>
		{{#  } }}
	</script>
	<!-- 应收金额 -->
    <script type="text/html" id="stageCanPayQuotaTpl">
         <span data-d="{{d.stageCanPayQuota}}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.stageCanPayQuota }}元</span>
    </script>
	<!-- 坏账金额 -->
	<script type="text/html" id="stageBadPayQuotaTpl">
		<span data-d="{{d.stageBadPayQuota}}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.stageBadPayQuota }}元</span>
	</script>
	<!-- 已收收款 -->
    <script type="text/html" id="stageHasPayQuotaTpl">
         <span data-d="{{d.stageHasPayQuota}}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.stageHasPayQuota }}元</span>
    </script>
	<!-- 未收金额 -->
	<script type="text/html" id="stageUnPayQuotaTpl">
		<span data-d="{{d.stageUnPayQuota}}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.stageUnPayQuota }}元</span>
	</script>
	<!-- 收款状态 -->
	<script type="text/html" id="stagePayStateTpl">
		{{#  if(d.stagePayState === "已付清"){ }}
		<span  class="label label-success radius" data-d="{{ d.stagePayState }}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.stagePayState }}</span>
		{{#  } else { }}
		<span  class="label label-default radius" data-d="{{ d.stagePayState }}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.stagePayState }}</span>
		{{#  } }}
	</script>
	<!-- 是否开票 -->
	<script type="text/html" id="stageHasBillTpl">
		<input type="checkbox" data-d="{{d.stageHasBill==1?'已开票':'未开票' }}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" lay-skin="switch" lay-text="已开票|未开票" {{ d.stageHasBill==1?'checked':'' }} disabled>
	</script>
	<!-- 备注说明 -->
	<script type="text/html" id="stageRemarkDescriptionTpl">
		<span data-d="{{d.stageRemarkDescription}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.stageRemarkDescription}}</span>
	</script>
	<%@include file="../../other/conjs.html" %>
	<script type="text/javascript" src="${ctx}/static/h-ui/js/H-ui.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/h-ui.admin.pro.iframe/js/h-ui.admin.pro.iframe.min.js"></script>
    <script type="text/javascript">
		// 应收输入变化 -> 未收变化、状态变化
		function CanPayChange(){
			var stageCanPayQuota = $('#stageCanPayQuota').val() == '' ? 0.0 : parseFloat($('#stageCanPayQuota').val());// 应收变化
			var stageBadPayQuota = $('#stageBadPayQuota').val() == '' ? 0.0 : parseFloat($('#stageBadPayQuota').val());// 坏账
			var stageHasPayQuota = $('#stageHasPayQuota').val() == '' ? 0.0 : parseFloat($('#stageHasPayQuota').val());// 已收
			var unQuota = stageCanPayQuota - stageBadPayQuota - stageHasPayQuota;// 未收 = 应收 - 坏账 - 已收
			unQuota = unQuota.toFixed(2);//保留两位小数
			$('#stageUnPayQuota').val(unQuota);// 未收变化
			// 未收 -> 状态
			if(unQuota <= 0 ){
				$("#stagePayState").val('已付清');
			} else{
				$("#stagePayState").val('未付清');
			}
		}
		// 坏账输入变化 -> 未收变化、状态变化
		function BadPayChange(){
			var stageCanPayQuota = $('#stageCanPayQuota').val() == '' ? 0.0 : parseFloat($('#stageCanPayQuota').val());// 应收
			var stageBadPayQuota = $('#stageBadPayQuota').val() == '' ? 0.0 : parseFloat($('#stageBadPayQuota').val());// 坏账变化
			var stageHasPayQuota = $('#stageHasPayQuota').val() == '' ? 0.0 : parseFloat($('#stageHasPayQuota').val());// 已收
			var unQuota = stageCanPayQuota - stageBadPayQuota - stageHasPayQuota;// 未收 = 应收 - 坏账 - 已收
			unQuota = unQuota.toFixed(2);//保留两位小数
			$('#stageUnPayQuota').val(unQuota);// 未收变化
			// 未收 -> 状态
			if(unQuota <= 0 ){
				$("#stagePayState").val('已付清');
			} else{
				$("#stagePayState").val('未付清');
			}
		}
		// 初始化脚本
		$(function () {
			var times="";//保存变更前开始时间
			var timef="";//保存变更前结束时间
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
						let dateEntryStart2 = laydate.render({
							elem: '#stageStartDate',
							trigger: 'click',
							done: function (value, date) {
								dateEntryEnd2.config.min = {
									year: date.year,
									month: date.month - 1,
									date: date.date,
									hours: date.hours,
									minutes: date.minutes,
									seconds: date.seconds
								};
								dateEntryEnd2.config.value = value;
								let startDate = value;//开始日期
								let finalDate = $("#stageEndDate").val();//结束日期
								if(startDate!='' && finalDate!=''){
									let time1 = new Date(Date.parse(startDate));
									let time2 = new Date(Date.parse(finalDate));
									let t1 = time1.getTime();
									let t2 = time2.getTime();
									let datetime=1000*60*60*24*30;
									let minusDays = (t2-t1)/datetime;
									//minusDays = minusDays.toFixed(1);//保留一位小数
									minusDays = Math.floor(minusDays);//向下取整
									if(minusDays < 0){
										$("#stageStartDate").val(times);
										minusDays = $("#stageDateCycle").val();
										layer.msg('开始日期大于结束日期!', {icon: 0, time: 1000, anim: 6});
										form.render('select');
									}
									//开始日期变化 -> 周期变化
									$("#stageDateCycle").val(minusDays);//周期变化
								} else{
									document.getElementById("stageDateCycle").value = 0;
								}
							}
						});
						let dateEntryEnd2 = laydate.render({
							elem: '#stageEndDate',
							trigger: 'click',//  触发方式
							done: function (value, date) {// 选择完成回调
								dateEntryStart2.config.max = {
									year: date.year,
									month: date.month - 1,
									date: date.date,
									hours: date.hours,
									minutes: date.minutes,
									seconds: date.seconds
								};
								dateEntryStart2.config.value = value;
								let finalDate = value;//结束日期
								let startDate = $("#stageStartDate").val();//开始日期
								if(finalDate!='' && startDate!=''){
									let time1 = new Date(Date.parse(startDate));
									let time2 = new Date(Date.parse(finalDate));
									let t1 = time1.getTime();
									let t2 = time2.getTime();
									let datetime=1000*60*60*24*30;
									let minusDays = (t2-t1)/datetime;
									//minusDays = minusDays.toFixed(1);//保留一位小数
									minusDays = Math.floor(minusDays);//向下取整
									if(minusDays<0){
										$("#stageEndDate").val(timef);
										minusDays = $("#stageDateCycle").val();
										layer.msg('开始日期大于结束日期!', {icon: 0, time: 1000, anim: 6});
										form.render('select');
									}
									//结束日期变化 -> 周期变化
									$("#stageDateCycle").val(minusDays);//周期变化
								}else{
									document.getElementById("stageDateCycle").value = 0;
								}
							}
						});
						// 初始化表格
						table.render({
							elem: '#LAY_table_user' // 指定表格
							, id: 'LAY_table_user'
							, url: '${pageContext.request.contextPath }/stage/searchAll' //数据请求路径
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
									sort: true,
									align: 'center',
									templet: '#xuhao'
								}
								, {
									field: 'stageDate',
									minWidth: 240,
									title: '分期区间',
									sort: true,
									align: 'center',
									templet: "#stageBetweenDateTpl"
								}
								, {
									field: 'stageDate',
									unresize:true,
									minWidth: 200,
									title: '分期周期',
									sort: true,
									align: 'center',
									templet: "#stageDateCycleTpl"
								}
								, {
									field: 'stageDate',
									title: '分期状态',
									sort: true,
									align: 'center',
									templet: "#stageDateStateTpl"
								}
								, {
									field: 'stageCanPayQuota',
									title: '应收金额',
									sort: true,
									align: 'center',
									templet: "#stageCanPayQuotaTpl"
								}
								, {
									field: 'stageCanPayQuota',
									title: '坏账金额',
									sort: true,
									align: 'center',
									templet: "#stageBadPayQuotaTpl"
								}
								, {
									field: 'stageHasPayQuota',
									title: '已收收款',
									sort: true,
									align: 'center',
									templet: "#stageHasPayQuotaTpl"
								}
								, {
									field: 'stageUnPayQuota',
									title: '未收金额',
									sort: true,
									align: 'center',
									templet: "#stageUnPayQuotaTpl"
								}
								, {
									field: 'stagePayState',
									title: '收款状态',
									sort: true,
									align: 'center',
									templet: '#stagePayStateTpl'
								}
								, {
									field: 'stageHasBill',
									title: '是否开票',
									sort: true,
									align: 'center',
									templet: '#stageHasBillTpl'
								}
								, {
									field: 'stageRemarkDescription',
									title: '分期说明',
									sort: true,
									align: 'center',
									templet: '#stageRemarkDescriptionTpl'
								}
							]]
							, page: false  //关闭分页
							, response: {
								statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
							}
						});
						// 单选选中事件
						table.on('radio(LAY_table_user)', function(obj){
							if(obj.data.contractDetail.projectAddress==null || obj.data.contractDetail.projectAddress==""){
								//代理商
								$('#cashInfo').attr('onclick','Hui_admin_tab(this)');
								$('#cashInfo').attr('data-href','${ctx}/cash/detail/${contractDetailID}/'+obj.data.id+'/${type}');
								$('#cashInfo').attr('data-title','【'+obj.data.contractDetail.contract.customer.customerName+'】收款信息');

								$('#billInfo').attr('onclick','Hui_admin_tab(this)');
								$('#billInfo').attr('data-href','${ctx}/bill/detail/${contractDetailID}/'+obj.data.id+'/${type}');
								$('#billInfo').attr('data-title','【'+obj.data.contractDetail.contract.customer.customerName+'】开票信息');
							}else{
								$('#cashInfo').attr('onclick','Hui_admin_tab(this)');
								$('#cashInfo').attr('data-href','${ctx}/cash/detail/${contractDetailID}/'+obj.data.id+'/${type}');
								$('#cashInfo').attr('data-title','【'+obj.data.contractDetail.projectAddress+'】收款信息');

								$('#billInfo').attr('onclick','Hui_admin_tab(this)');
								$('#billInfo').attr('data-href','${ctx}/bill/detail/${contractDetailID}/'+obj.data.id+'/${type}');
								$('#billInfo').attr('data-title','【'+obj.data.contractDetail.projectAddress+'】开票信息');
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
											//开始日期
											var stageStartDateStr = $("#stageStartDate").val();
											if (stageStartDateStr == "") {
												layer.msg('请选择开始日期', {icon: 0, time: 1000, anim: 6});
												return false;
											}
											var sdate1 = stageStartDateStr.split('-');
											var stageStartDate = new Date(sdate1[0], sdate1[1]-1, sdate1[2]);//时分秒设置为0
											//结束日期
											var stageEndDateStr = $("#stageEndDate").val();
											if (stageEndDateStr == "") {
												layer.msg('请选择结束日期', {icon: 0, time: 1000, anim: 6});
												return false;
											}
											var sdate2 = stageEndDateStr.split('-');
											var stageEndDate = new Date(sdate2[0], sdate2[1]-1, sdate2[2]);//时分秒设置为0
											//分期周期
											var stageDateCycle = $("#stageDateCycle").val().trim();
											//应收金额
											var stageCanPayQuota = $("#stageCanPayQuota").val().trim();
											if (stageCanPayQuota == "") {
												layer.msg('请输入应收金额', {icon: 0, time: 1000, anim: 6});
												return false;
											}
											//坏账金额
											var stageBadPayQuota = $("#stageBadPayQuota").val().trim();
											if (stageBadPayQuota == "") {
												layer.msg('请输入坏账金额', {icon: 0, time: 1000, anim: 6});
												return false;
											}
											//已收金额
											var stageHasPayQuota = $("#stageHasPayQuota").val().trim();
											//未收金额
											var stageUnPayQuota = $("#stageUnPayQuota").val().trim();
											//收款状态
											var stagePayState = $("#stagePayState").val().trim();
											//设置提醒
											var stagePayRemindDays = $("#stagePayRemindDaysInput").val().trim();
											if (stagePayRemindDays == "") {
												layer.msg('请选择设置提醒', {icon: 0, time: 1000, anim: 6});
												return false;
											}
											//分期说明
											var stageRemarkDescription = $("#stageRemarkDescription").val().trim();
											$.ajax({
												type: 'post',
												url: "${pageContext.request.contextPath }/stage/add",
												data: JSON.stringify({
													contractDetailID:"${contractDetailID}",
													stageStartDate:stageStartDate,
													stageEndDate:stageEndDate,
													stageDateCycle:stageDateCycle,
													stageCanPayQuota:stageCanPayQuota,
													stageBadPayQuota:stageBadPayQuota,
													stageHasPayQuota:stageHasPayQuota,
													stageUnPayQuota:stageUnPayQuota,
													stagePayState:stagePayState,
													stagePayRemindDays:stagePayRemindDays,
													stageRemarkDescription: stageRemarkDescription,
												}),
												contentType: "application/json;charset=UTF-8",
												dataType: "json",
												success: function (data) {
													if (data == "1") {
														layer.msg('添加成功!', {icon: 1, time: 1000});
													} else if (data == "2") {
														layer.msg('划分额度不足,不可划分!', {icon: 5, time: 1000, anim: 6});
													} else if (data == "3") {
														layer.msg('划分时间与已有分期有交叉!', {icon: 5, time: 1000, anim: 6});
													} else {
														layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6});
													}
												},
												error: function (data) {
													layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6});
												}
											});
										}
										, xs2: function (index, layero) {
											layer.close(index);
										}, success: function (layero) {
											$("#stageStartDate").val('');
											$("#stageEndDate").val('');
											$("#stageDateCycle").val('0');
											$("#stageCanPayQuota").val('0');
											$("#stageBadPayQuota").val('0');
											$("#stageHasPayQuota").val('0');
											$("#stageUnPayQuota").val('0');
											$("#stagePayState").val('未付清');
											$("#stagePayRemindDays").val('7');
											$("#stagePayRemindDaysInput").val('7');
											document.getElementById("stagePayRemindDaysInput").style.display="none";
											$("#stageRemarkDescription").val('');
											form.render('select');
										}
									}
									tk('添加分期信息', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '取消'], _funbtnxs);
									form.on('select(stagePayRemindDays)', function (data) {
										if(data.value == "其它__") {
											$("#stagePayRemindDaysInput").val('');
											document.getElementById("stagePayRemindDaysInput").style.display="";
										} else{
											$("#stagePayRemindDaysInput").val(data.value);
											document.getElementById("stagePayRemindDaysInput").style.display="none";
										}
										form.render('select');
									});
									break;
								case 'acreat':
									if(origin.contract.contractState!="正常"){
										layer.msg('合同处于终止状态', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									var _funbtnxs = {
										yesxs1: function (index, layero) {
											var countAuto = $("#countAutoInput").val().trim();
											if (countAuto == "") {
												layer.msg('请选择划分类型', {icon: 0, time: 1000, anim: 6});
												return false;
											}
											if(countAuto=="0"){
												layer.msg('划分周期至少1个月', {icon: 0, time: 1000, anim: 6});
												return false;
											}
											//设置提醒
											var stagePayRemindDays = $("#stagePayRemindDaysInput2").val().trim();
											if (stagePayRemindDays == "") {
												layer.msg('请选择设置提醒', {icon: 0, time: 1000, anim: 6});
												return false;
											}
											// 提交
											$.ajax({
												type: 'post',
												url: "${pageContext.request.contextPath }/stage/addAuto?type=" + countAuto,
												data: JSON.stringify({
													contractDetailID: "${contractDetailID}",
													stagePayRemindDays:stagePayRemindDays,
													stageDateCycle:countAuto,
												}),
												contentType: "application/json;charset=UTF-8",
												dataType: "json",
												success: function (data) {
													if (data == "1") {
														layer.msg('划分成功!', {
															icon: 1, time: 1000, end: function () {
																location.reload();
															}
														});
													} else if (data == "2") {
														layer.msg('已有阶段，无法自动划分!', {icon: 5, time: 1000, anim: 6});
													} else if (data == "3") {
														layer.msg('划分额度不足,不可划分!', {icon: 5, time: 1000, anim: 6});
													} else {
														layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6});
													}
												},
												error: function (data) {
													layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6});
												}
											});
										}
										, xs2: function (index, layero) {
											layer.close(index);
										}, success: function (layero) {
											$("#countAuto").val("4");
											$("#countAutoInput").val('4');
											document.getElementById("countAutoInput").style.display="none";
											$("#stagePayRemindDays2").val('15');
											$("#stagePayRemindDaysInput2").val('15');
											document.getElementById("stagePayRemindDaysInput2").style.display="none";
											form.render('select');
										}
									}
									tk('添加分期信息', ['100%', '100%'], 'userbj', $("#bjnr2"), ['确定', '取消'], _funbtnxs);
									form.on('select(countAuto)', function (data) {
										if(data.value == "其它__") {
											$("#countAutoInput").val('');
											document.getElementById("countAutoInput").style.display="";
										} else{
											$("#countAutoInput").val(data.value);
											document.getElementById("countAutoInput").style.display="none";
										}
										form.render('select');
									});
									form.on('select(stagePayRemindDays2)', function (data) {
										if(data.value == "其它__") {
											$("#stagePayRemindDaysInput2").val('');
											document.getElementById("stagePayRemindDaysInput2").style.display="";
										} else{
											$("#stagePayRemindDaysInput2").val(data.value);
											document.getElementById("stagePayRemindDaysInput2").style.display="none";
										}
										form.render('select');
									});
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
											//开始日期
											var stageStartDateStr = $("#stageStartDate").val();
											if (stageStartDateStr == "") {
												layer.msg('请选择开始日期', {icon: 0, time: 1000, anim: 6});
												return false;
											}
											var sdate1 = stageStartDateStr.split('-');
											var stageStartDate = new Date(sdate1[0], sdate1[1]-1, sdate1[2]);//时分秒设置为0
											//结束日期
											var stageEndDateStr = $("#stageEndDate").val();
											if (stageEndDateStr == "") {
												layer.msg('请选择结束日期', {icon: 0, time: 1000, anim: 6});
												return false;
											}
											var sdate2 = stageEndDateStr.split('-');
											var stageEndDate = new Date(sdate2[0], sdate2[1]-1, sdate2[2]);//时分秒设置为0
											//分期周期
											var stageDateCycle = $("#stageDateCycle").val().trim();
											//应收金额
											var stageCanPayQuota = $("#stageCanPayQuota").val().trim();
											if (stageCanPayQuota == "") {
												layer.msg('请输入应收金额', {icon: 0, time: 1000, anim: 6});
												return false;
											}
											//坏账金额
											var stageBadPayQuota = $("#stageBadPayQuota").val().trim();
											if (stageBadPayQuota == "") {
												layer.msg('请输入坏账金额', {icon: 0, time: 1000, anim: 6});
												return false;
											}
											//已收金额
											var stageHasPayQuota = $("#stageHasPayQuota").val().trim();
											//未收金额
											var stageUnPayQuota = $("#stageUnPayQuota").val().trim();
											//收款状态
											var stagePayState = $("#stagePayState").val().trim();
											//设置提醒
											var stagePayRemindDays = $("#stagePayRemindDaysInput").val().trim();
											if (stagePayRemindDays == "") {
												layer.msg('请选择设置提醒', {icon: 0, time: 1000, anim: 6});
												return false;
											}
											//分期说明
											var stageRemarkDescription = $("#stageRemarkDescription").val().trim();
											$.ajax({
												type: 'post',
												url: "${pageContext.request.contextPath }/stage/update",
												data: JSON.stringify({
													id: dataRow[0].id,
													contractDetailID:"${contractDetailID}",
													stageStartDate:stageStartDate,
													stageEndDate:stageEndDate,
													stageDateCycle:stageDateCycle,
													stageCanPayQuota:stageCanPayQuota,
													stageBadPayQuota:stageBadPayQuota,
													stageHasPayQuota:stageHasPayQuota,
													stageUnPayQuota:stageUnPayQuota,
													stagePayState:stagePayState,
													stagePayRemindDays:stagePayRemindDays,
													stageRemarkDescription: stageRemarkDescription,
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
											$("#stageStartDate").val(layui.util.toDateString(dataRow[0].stageStartDate, 'yyyy-MM-dd'));
											times=layui.util.toDateString(dataRow[0].stageStartDate, 'yyyy-MM-dd');
											timef=layui.util.toDateString(dataRow[0].stageEndDate, 'yyyy-MM-dd');
											$("#stageEndDate").val(layui.util.toDateString(dataRow[0].stageEndDate, 'yyyy-MM-dd'));
											$("#stageDateCycle").val(dataRow[0].stageDateCycle);
											$("#stageCanPayQuota").val(dataRow[0].stageCanPayQuota);
											$("#stageBadPayQuota").val(dataRow[0].stageBadPayQuota);
											$("#stageHasPayQuota").val(dataRow[0].stageHasPayQuota);
											$("#stageUnPayQuota").val(dataRow[0].stageUnPayQuota);
											$("#stagePayState").val(dataRow[0].stagePayState);
											$("#stagePayRemindDays").val(dataRow[0].stagePayRemindDays);
											$("#stagePayRemindDaysInput").val(dataRow[0].stagePayRemindDays);
											if($("#stagePayRemindDays").val()==null || $("#stagePayRemindDays").val()==""){
												$("#stagePayRemindDays").val("其它__");
												document.getElementById("stagePayRemindDaysInput").style.display="";
											}else{
												document.getElementById("stagePayRemindDaysInput").style.display="none";
											}
											$("#stageRemarkDescription").val(dataRow[0].stageRemarkDescription);
											form.render('select');
										}
									}
									tk('修改分期信息', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '取消'], _funbtnxs);
									form.on('select(stagePayRemindDays)', function (data) {
										if(data.value == "其它__") {
											$("#stagePayRemindDaysInput").val('');
											document.getElementById("stagePayRemindDaysInput").style.display="";
										} else{
											$("#stagePayRemindDaysInput").val(data.value);
											document.getElementById("stagePayRemindDaysInput").style.display="none";
										}
										form.render('select');
									});
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
											url: '${pageContext.request.contextPath }/stage/delete',
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
									// 收款信息
								case 'cashinfo':
									var dataRow = checkStatus.data;  //获取选中行数据
									if (dataRow.length == 0) {
										layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									break;
									// 开票信息
								case 'billinfo':
									var dataRow = checkStatus.data;  //获取选中行数据
									if (dataRow.length == 0) {
										layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
										return false;
									}
									break;
							};
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
				data: JSON.stringify({id:'${sessionScope.CurrentUser.roleID}',menuNameString:'分期信息'}),
				contentType: "application/json;charset=UTF-8",
				dataType: "json",
				success: function (data) {
					let obj = eval(data);
					$(obj).each(function (index) {
						let item = obj[index];
						switch (item.operation.operateName) {
							case "创建":document.getElementById("createbtn").style.display = "";document.getElementById("acreatbtn").style.display = "";break;
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
				data: JSON.stringify({id:'${sessionScope.CurrentUser.roleID}',menuNameString:'收款信息',operationNameString:'查看'}),
				contentType: "application/json;charset=UTF-8",
				dataType: "json",
				success: function (data) {
					document.getElementById("cashinfobtn").style.display = "";
				}, error: function (data) {
					//layer.msg('权限获取异常!', {icon: 5, time: 1000, anim: 6});
				}
			});
			$.ajax({
				url: '${pageContext.request.contextPath }/rolePermission/search',
				method: 'post',
				data: JSON.stringify({id:'${sessionScope.CurrentUser.roleID}',menuNameString:'开票信息',operationNameString:'查看'}),
				contentType: "application/json;charset=UTF-8",
				dataType: "json",
				success: function (data) {
					document.getElementById("billinfobtn").style.display = "";
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
					<td align="right" width="80">开始日期：</td>
					<td align="left">
						<input type="text" id="stageStartDate" autocomplete="off" class="layui-input" placeholder="请选择日期">
					</td>
				</tr>
				<tr>
					<td align="right">结束日期：</td>
					<td align="left">
						<input type="text" id="stageEndDate" autocomplete="off" class="layui-input" placeholder="请选择日期">
					</td>
				</tr>
				<tr>
					<td align="right">分期周期：<span style="margin-right: 22px">（月）</span></td>
					<td align="left">
						<input type="text" id="stageDateCycle" value="0" class="layui-input layui-btn-disabled" disabled>
					</td>
				</tr>
				<tr>
					<td align="right">应收金额：<span style="margin-right: 22px">（元）</span></td>
					<td align="left">
						<input type="text" id="stageCanPayQuota" value="0" oninput="CanPayChange()" autocomplete="off" class="layui-input"
							   onblur="if(value=='')execCommand('undo')" Onkeyup="if(isNaN(value))execCommand('undo')" Onpaste="return false;" placeholder="请输入">
					</td>
				</tr>
				<tr>
					<td align="right">坏账金额：<span style="margin-right: 22px">（元）</span></td>
					<td align="left">
						<input type="text" id="stageBadPayQuota" value="0" oninput="BadPayChange()" autocomplete="off" class="layui-input"
							   onblur="if(value=='')execCommand('undo')" Onkeyup="if(isNaN(value))execCommand('undo')" Onpaste="return false;" placeholder="请输入">
					</td>
				</tr>
				<tr>
					<td align="right">已收金额：<span style="margin-right: 22px">（元）</span></td>
					<td align="left">
						<input type="text" id="stageHasPayQuota" value="0" class="layui-input layui-btn-disabled" disabled>
					</td>
				</tr>
				<tr>
					<td align="right">未收金额：<span style="margin-right: 22px">（元）</span></td>
					<td align="left">
						<input type="text" id="stageUnPayQuota" value="0" class="layui-input layui-btn-disabled" disabled>
					</td>
				</tr>
				<tr>
					<td align="right">收款状态：</td>
					<td align="left">
						<input type="text" id="stagePayState" value="未付清" class="layui-input layui-btn-disabled" disabled>
					</td>
				</tr>
				<tr>
					<td align="right">设置提醒：<span style="margin-right: 22px">（天）</span></td>
					<td align="left">
						<select class="layui-input" id="stagePayRemindDays" placeholder="请选择" lay-filter="stagePayRemindDays">
							<option value="">请选择</option>
							<option value="7">7天内到期提醒</option>
							<option value="15">15天内到期提醒</option>
							<option value="30">30天内到期提醒</option>
							<option value="其它__">其它__</option>
						</select>
						<input type="text" style="display: none" id="stagePayRemindDaysInput" autocomplete="off" onblur="if(value=='')execCommand('undo')"
							   class="layui-input" placeholder="请输入" Onkeyup="this.value=this.value.replace(/\D/g,'')" Onpaste="return false;">
					</td>
				</tr>
				<tr>
					<td align="right">分期说明：</td>
					<td align="left">
						<textarea id="stageRemarkDescription" rows="20" autocomplete="off" class="layui-textarea" placeholder="请输入"></textarea>
					</td>
				</tr>
				</tbody>
			</table>
		</form>
	</div>
	<div id="bjnr2" style="display: none;">
		<form class="layui-form">
			<table class="layui-table layui-xs" lay-skin="nob">
				<tbody>
				<tr>
					<td align="right" width="80">自动划分：</td>
					<td align="left">
						<select class="layui-input" id="countAuto" lay-verify="required" lay-filter="countAuto">
							<option value="">请选择</option>
							<option value="3">3个月/付</option>
							<option value="4">4个月/付</option>
							<option value="6">6个月/付</option>
							<option value="其它__">其它__</option>
						</select>
						<input type="text" style="display: none" id="countAutoInput" autocomplete="off" onblur="if(value=='')execCommand('undo')"
							   class="layui-input" placeholder="请输入" Onkeyup="this.value=this.value.replace(/\D/g,'')" Onpaste="return false;">
					</td>
				</tr>
				<tr>
					<td align="right">设置提醒：<span style="margin-right: 22px">（天）</span></td>
					<td align="left">
						<select class="layui-input" id="stagePayRemindDays2" placeholder="请选择" lay-filter="stagePayRemindDays2">
							<option value="">请选择</option>
							<option value="7">7天内到期提醒</option>
							<option value="15">15天内到期提醒</option>
							<option value="30">30天内到期提醒</option>
							<option value="其它__">其它__</option>
						</select>
						<input type="text" style="display: none" id="stagePayRemindDaysInput2" autocomplete="off" onblur="if(value=='')execCommand('undo')"
							   class="layui-input" placeholder="请输入" Onkeyup="this.value=this.value.replace(/\D/g,'')" Onpaste="return false;">
					</td>
				</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>