<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
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
		<span class="c-gray en">&gt;</span> 售后查询
		<span class="c-gray en">&gt;</span> 按合同客户查询
        <a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);" data-d="刷新" onmouseover="show_shopm(this)" onmouseout="exit_shopm()"><i class="Hui-iconfont">&#xe68f;</i></a>
	</nav>
	<div class="page-container">
		<div class="layui-form" style="height: 31px;">
		    <label><b>合同客户:</b></label> 
			<div class="layui-inline" style="width: 200px;">
				<select class="layui-input" id="customerID" lay-filter="AutoFilter" lay-search>
                    <option value="">请选择客户</option>       
                </select>
			</div>
			<button class="layui-btn" type="button" onclick="GetData()" data-d="搜索" onmouseover="show_shopm(this)" onmouseout="exit_shopm()"> <i class="Hui-iconfont">&#xe665;</i></button>
		</div>
		<div class="mt-20"> 
		   <div id="demo" style="float:left;width:20%;min-height:600px;"></div>
           <iframe style="float:right;width:80%;min-height:680px;" scrolling="no" frameborder="no" id="iframe" name="iframe"></iframe>
	    </div>
	</div>
	<%@include file="../../other/conjs.html" %>
	<script type="text/javascript">
		let tree;// 全局配置
		/*初始layui*/
		layui.use(['form','tree'], function() {
			tree = layui.tree;
			let form = layui.form;
			// 客户
	  	    $.ajax({
	  		     url: '${pageContext.request.contextPath }/customer/getList',
	  		     method:'post',
	  		     data:JSON.stringify({ }),
		         contentType:"application/json;charset=UTF-8",
		       	 dataType : "json",
	  		     success: function (data) {
	  			    $('#customerID').empty();
	  			    $('#customerID').append(new Option("请选择客户", ""));
	  		        $.each(data, function (index, item) {
	  		            $('#customerID').append(new Option(item.customerName, item.id));
	  		        });
	  		        form.render("select");
	  		     },error:function(data){
	  			    $('#customerID').empty();
	  			    $('#customerID').append(new Option("请选择客户", ""));
	  		        form.render("select");
		       	 }    		  
	  	    });
	  	    // 触发
	  	    form.on('select(AutoFilter)', function(data) {
				GetData();
	  	    });
		});
		/*ajax动态数据*/
		function GetData() {
			// 恢复
			document.getElementById("iframe").src = "";
			// 提交
			$.ajax({
				type : 'POST',
				url : "${pageContext.request.contextPath}/getSearchByCustomer",
				data : {id:$("#customerID").val()},
				async : false,
				success : function(data) {
					tree.render({
						elem : '#demo',//绑定元素id
						data : eval('[' + JSON.stringify(data) + "]"),//数据
						isJump : true,//是否允许点击节点时弹出新窗口跳转
						id : 'demoId1',//索引
						accordion:true,//是否开启手风琴模式
						showLine : true,//是否开启连接线
						click : function(obj) {//点击事件
							$(".layui-tree-txt").attr("target", "iframe");
						}
					});
				},error : function(data) {
					tree.render({
						elem : '#demo',//绑定元素id
						data : []//数据
					});
				}
			});
		}
	</script>
</body>
</html>