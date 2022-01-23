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
    <span class="c-gray en">&gt;</span> 按车识别码查询
    <a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);" data-d="刷新" onmouseover="show_shopm(this)" onmouseout="exit_shopm()"><i class="Hui-iconfont">&#xe68f;</i></a>
</nav>
<div class="page-container">
    <div class="layui-form" style="height: 31px;">
        <label><b>项目地址:</b></label>
        <div class="layui-inline" style="width: 200px;">
            <input type="text" id="projectAddress" name="projectAddress" autocomplete="off" class="layui-input" placeholder="请输入项目地址">
        </div>
        <button class="layui-btn" type="button" onclick="GetData()" data-d="搜索" onmouseover="show_shopm(this)" onmouseout="exit_shopm()"> <i class="Hui-iconfont">&#xe665;</i></button>
        <!--<span style="color:red;"><font size=1><b>(*不区分字母大小写)</b></font></span>-->
    </div>
    <div class="mt-20">
        <div id="demo" style="float:left;width:20%;min-height:600px;"></div>
        <iframe style="float:right;width:80%;min-height:680px;" scrolling="no" frameborder="no" id="iframe" name="iframe"></iframe>
    </div>
</div>
<%@include file="../../other/conjs.html" %>
<script type="text/javascript">
    /*全局变量*/
    let tree;
    /*初始layui*/
    layui.use('tree', function() {
        tree = layui.tree;
    });
    /*ajax动态数据*/
    function GetData() {
        // 恢复
        document.getElementById("iframe").src = "";
        // 提交
        $.ajax({
            type : 'POST',
            url : "${pageContext.request.contextPath}/getSearchByAddress",
            data : {projectAddress:$("#projectAddress").val()},
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
            },
            error : function(data) {
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