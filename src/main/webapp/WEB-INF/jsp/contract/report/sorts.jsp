<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../other/meta.html"%>
	<%@include file="../../other/style.html" %>
</head>
<body>
	<nav class="breadcrumb">
		<i class="Hui-iconfont">&#xe67f;</i> 首页
		<span class="c-gray en">&gt;</span> 合同管理
		<span class="c-gray en">&gt;</span> 数据报表
		<span class="c-gray en">&gt;</span> 合同数量分类汇总
		<a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);"><i class="Hui-iconfont">&#xe68f;</i></a>
	</nav>
	<div class="page-container">
		<div class="layui-form" style="height: 31px;">
			<label><b>汇总条件:</b></label>
			<div class="layui-input-inline">
				<select name="type" id="selectedOption" lay-filter="college">
					<option value="year" selected="selected">按年统计</option>
					<option value="month">按月统计</option>
				</select>
			</div>
			<label class="layui-inline" id="worldlable" style="width: 190px;">
				<input id="worldId" style="width: 220px;" placeholder="请选择时间"
				type="text" class="layui-input laydate-test" autocomplete="off">
			</label>
		</div>
		<div id="container" style="margin-top:60px;min-width: 600px; height: 600px;"></div>
	</div>
	<%@include file="../../other/conjs.html" %>
	<script type="text/javascript" src="${ctx}/lib/layer/2.4/layer.js"></script>
	<script type="text/javascript" src="${ctx}/lib/echarts/4.1.0.rc2/echarts.min.js"></script>
	<script type="text/javascript">
		layui.use(['form', 'laydate'], function () {
			let form = layui.form;
			let laydate = layui.laydate;
			// 默认"年"条件
			laydate.render({
				elem: '#worldId',
				type: 'year',
				max: genTime('day'),
				//value: genTime('year'),
				showBottom: false,// 不会显示控件的底部栏区域
				//btns: ['clear', 'confirm'],
				change: function (value, date) {
					$("#worldId").val(value);
					if (value != "" && value.length > 0) {
						submitAction(value);
					}
				},
				ready: function (date) {
					// 选择后关闭
					$(".layui-laydate").off('click').on('click', '.layui-laydate-list li', function () {
						$(".layui-laydate").remove();
					});
				}
			});
			form.on('select(college)', function (data) {
				let opt = $("#selectedOption").val();
				let ele = $("#selectedOption");
				$("#worldId").remove();
				$("#worldlable").html('<input id="worldId" style="width:220px;" placeholder="请选择时间" type="text" class="layui-input laydate-test" autocomplete="off">');
				// 月
				if (opt == "month") {
					laydate.render({
						elem: '#worldId',
						type: 'month',
						max: genTime('month'),
						//value: genTime('month'),
						showBottom: false,// 不会显示控件的底部栏区域
						//btns: ['clear', 'confirm'],
						change: function (value, date) {
							$("#worldId").val(value);
							if (value != "" && value.length > 0) {
								submitAction(value);
							}
						},
						ready: function (date) {
							// 选择后关闭
							$(".layui-laydate").off('click').on('click', '.layui-laydate-list li', function () {
								$(".layui-laydate").remove();
							});
						}
					});
				} else if (opt == "year") { // 年
					laydate.render({
						elem: '#worldId',
						type: 'year',
						max: genTime('day'),
						//value: genTime('year'),
						showBottom: false,// 不会显示控件的底部栏区域
						//btns: ['clear', 'confirm'],
						change: function (value, date) {
							$("#worldId").val(value);
							if (value != "" && value.length > 0) {
								submitAction(value);
							}
						},
						ready: function (date) {
							// 选择后关闭
							$(".layui-laydate").off('click').on('click', '.layui-laydate-list li', function () {
								$(".layui-laydate").remove();
							});
						}
					});
				}
			});
		});
		// 时间
		function genTime(opt) {
			let now = new Date();
			let year = now.getFullYear();
			let mth = now.getMonth();
			let day = now.getDate();
			let month = mth + 1;
			if (month < 10) {
				month = '0' + month
			}
			if (day < 10) {
				day = '0' + day
			}
			let str;
			if (opt == 'day') {
				str = year + '-' + month + '-' + day;
			} else if (opt == 'month') {
				str = year + '-' + month;
			}
			return str;
		}
		//提交条件查询
		function submitAction(time) {
			let json = null;// 返回汇总数据
			$.ajax({
				type: "POST",
				url: "${pageContext.request.contextPath }/contract/searchSorts",
				data: {time: time},
				async: false,
				success: function (data) {
					json = eval(data);
				},
				error: function (data) {
					layer.msg('服务器异常!', {icon: 5, time: 1000});
				}
			});
			// 动态生成饼状图
			if (json.salesVolumes != 0 || json.rentVolumes != 0) {
				document.getElementById('container').style.display = 'block';
				let echarts1 = echarts.init(document.getElementById('container'));
				let echarts1_option = {};
				if (json.totalContacts != 0) {
					echarts1_option = {
						title: {
							text: '合同数量分类汇总',
							subtext: '共签'+json.totalContacts + '单',
							x: 'center',
							textStyle: {
								fontSize: 18,
							},
							subtextStyle: {
								color: '#595959',
								fontSize: 16,
							}
						},
						tooltip: {
							trigger: 'item',
							formatter: "{b} : {c} ({d}%)"
						},
						label: {
							show: true,
							formatter: function (param) {
								return param.name + '\n' + param.value + ' 单,  ' + Math.round(param.percent) + '%';
							}
						},
						legend: {
							x: 'center',
							y: 'bottom',
							data: ['出售', '租赁', '代理商']
						},
						toolbox: {
							show: true,
							feature: {
								dataView: {show: true, readOnly: false},
								saveAsImage: {show: true}
							},
							padding:[0,30,30,0] //可设定图例[距上方距离，距右方距离，距下方距离，距左方距离]
						},
						series: [
							{
								name: '分类合同汇总',
								type: 'pie',
								radius: '65%',
								center: ['50%', '50%'],
								selectedMode: 'single',
								color: ['#1890ff', '#df5667','#54FF9F'],
								data: [
									{
										value: json.salesContacts,
										name: '出售',
									},
									{
										value: json.rentContacts,
										name: '租赁',
									},
									{
										value: json.agentContacts,
										name: '代理商',
									}]
							}]
					}
				}
				// 初始化统计图
				echarts1.setOption(echarts1_option);
			} else {
				document.getElementById('container').style.display = 'none';
				layer.msg('无数据!', {time : 1000, anim: 6});
			}
		}
		// 初始数据
		$(function () {
			let time = (new Date()).getFullYear();
			submitAction(time);
			$('#worldId').val(time);
		});
</script>
</body>
</html>