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
<div class="wap-container">
    <nav class="breadcrumb">
        <i class="Hui-iconfont">&#xe67f;</i> 首页
        <span class="c-gray en">&gt;</span> 合同管理
        <span class="c-gray en">&gt;</span> 档案信息
        <span class="c-gray en">&gt;</span> 车辆档案
        <a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px;"
           href="javascript:location.replace(location.href);">
            <i class="Hui-iconfont">&#xe68f;</i></a>
    </nav>
    <div class="page-container">
        <div style="padding: 13px;text-align: center;">
            <label id="vehicleNumberTitle" style="font-size: 20px;font-weight: bold;">${vehicleNumber}</label>
            <hr style="width:50%;margin-left: 25%;"/>
        </div>
        <div class="layui-tab" lay-filter="recordTab">
            <ul class="layui-tab-title">
                <li class="layui-this" lay-id="1">租赁记录</li>
                <li lay-id="2">出售记录</li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <ul class="layui-timeline">
                        <c:forEach items="${rentRecords}" var="row">
                            <li class="layui-timeline-item">
                                <i class="layui-icon layui-timeline-axis">&#xe63f;</i>
                                <div class="layui-timeline-content layui-text">
                                    <h3 class="layui-timeline-title"><f:formatDate value="${row.exportDate}" pattern="yyyy-MM-dd"/></h3>
                                    <p>
                                            ${row.contract.customer.customerName}
                                        <br>${row.projectAddress}
                                        <br><f:formatDate value="${row.startDate}" pattern="yyyy-MM-dd"/>~<f:formatDate value="${row.finalDate}" pattern="yyyy-MM-dd"/>
                                        <br>${row.supplyDescription}
                                        <br>${row.payState}
                                    </p>
                                </div>
                            </li>
                        </c:forEach>
                        <li class="layui-timeline-item">
                            <i class="layui-icon layui-timeline-axis">&#xe63f;</i>
                        </li>
                    </ul>
                </div>
                <div class="layui-tab-item">
                    <c:forEach items="${saleRecords}" var="row">
                        <li class="layui-timeline-item">
                            <i class="layui-icon layui-timeline-axis">&#xe63f;</i>
                            <div class="layui-timeline-content layui-text">
                                <h3 class="layui-timeline-title"><f:formatDate value="${row.exportDate}" pattern="yyyy-MM-dd"/></h3>
                                <p>
                                    ${row.contract.customer.customerName}
                                    <br>${row.projectAddress}
                                    <br>${row.supplyDescription}
                                    <br>${row.payState}
                                </p>
                            </div>
                        </li>
                    </c:forEach>
                    <li class="layui-timeline-item">
                        <i class="layui-icon layui-timeline-axis">&#xe63f;</i>
                    </li>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="../../other/conjs.html" %>
<script type="text/javascript">
    // 初始数据
    $(function () {
        layui.use('element', function () {
            var element = layui.element;
        });
    });
</script>
</body>
</html>
