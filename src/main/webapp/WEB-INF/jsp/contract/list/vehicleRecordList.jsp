<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../other/meta.html"%>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/h-ui/css/H-ui.min2.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/business/css/style.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/lib/Hui-iconfont/1.0.9/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/jquery-feature-carousel/css/feature-carousel.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/lib/layui/css/layui.css" media="all">
</head>
<body>
<div class="wap-container">
    <nav class="breadcrumb">
        <i class="Hui-iconfont" style="margin-left: 20px;">&#xe67f;</i> 首页
        <span class="c-gray en">&gt;</span> 合同管理
        <span class="c-gray en">&gt;</span> 档案信息
        <span class="c-gray en">&gt;</span> 车辆档案
        <a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px;margin-right: 20px;"
           href="javascript:location.replace(location.href);">
            <i class="Hui-iconfont">&#xe68f;</i></a>
    </nav>
    <div class="page-container">
        <div class="mt" style="padding:12px 24px 0px 24px;">
            <div class="demoTable layui-form">
                <div class="layui-inline" style="width: 100%;">
                    <div class="layui-inline" style="width: 20%;position:relative;min-width: 330px;padding: 12px 12px 12px 0px;">
                        <div style="position:absolute;right:2px;top:10px;cursor:pointer;display: none;padding: 12px 12px 12px 0px;" class="input_clear">
                            <button type="button" class="clear" style="border: 0px;background-color:white;">
                                <i class="Hui-iconfont" style="color: red;">&#xe60b;</i>
                            </button>
                        </div>
                        <input class="layui-input" oninput="showClear(this)" id="vehicleNumber" autocomplete="off" placeholder="请输入车架号查询">
                    </div>
                    <button class="layui-btn" data-type="reload" style="margin:0px 0px 0px 0px;padding: 0px 12px 0px 12px;">
                        <i class="Hui-iconfont">&#xe665;</i>
                    </button>
                </div>
            </div>
        </div>
        <div style="max-height:708px;overflow:auto;margin-top: -12px;">
            <article class="Hui-admin-content clearfix" id="flow">
                <div class="row-24 clearfix flow-default" style="margin-left: -12px; margin-right: -12px;" id="LAY_demo1"></div>
            </article>
        </div>
    </div>
</div>
<%@include file="../../other/conjs.html" %>
<script type="text/javascript" src="${ctx}/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="${ctx}/static/h-ui.admin.pro.iframe/js/h-ui.admin.pro.iframe.min.js"></script>
<script type="text/javascript">
    var layer;// 全局变量
    // 初始数据
    $(function () {
        lay();// 首次流加载函数
        $(".layui-btn").click(function(){
            $("#LAY_demo1").remove();// 移除容器元素
            $(document).unbind();//把容器的事件解除绑定
            $('#flow').append('<div class="row-24 clearfix flow-default" style="margin-left: -12px; margin-right: -12px;" id="LAY_demo1"></div>');
            lay();//重新执行流加载函数
        });
    });
    // lay 加载
    function lay() {
        layui.use(['flow', 'util', 'layer', 'element'], function () {
            let flow = layui.flow, util = layui.util,
                $ = layui.jquery, element = layui.element;
                layer=layui.layer;
            // 流加载
            flow.load({
                elem: '#LAY_demo1', //流加载容器
                scrollElem: '#LAY_demo1', //滚动条所在元素，一般不用填
                isAuto: false,
                isLazyimg: true,
                done: function (page, next) { //执行下一页的回调
                    //模拟数据插入
                    setTimeout(function () {
                        let lis = [];
                        //数据请求地址，page，第几页，默认page是从2开始返回
                        $.post('${pageContext.request.contextPath }/contractDetail/getRecord', {
                            page: page,
                            vehicleNumber: $('#vehicleNumber').val().trim()
                        }, function (res) {

                            layui.each(res.data, function (index, item) {
                                //执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
                                // 加载数据
                                lis.push("<a href='javascript:;' class='layui-table-link' onclick='Hui_admin_tab(this)' data-href='${ctx}/contractDetail/recordDetail/"+item.vehicleNumber+"' data-title='【"+item.vehicleNumber+"】档案详情'><div class='col-24-xs-24 col-24-sm-12 col-24-md-12 col-24-lg-12 col-24-xl-6' style='width:300px;padding-left: 12px; padding-right: 12px; margin-bottom: 24px;'>"
                                    + "<div class='panel'>"
                                    + "<div class='panel-body' style='padding:0 0px;'>"
                                    + "<div class='panel-header' style='text-align:center;padding:15px 24px;font-weight: 400;color:#999;'>" + item.vehicleNumber + "</div>"
                                    + "<div class='c-success' style='text-align:center;font-size: 30px;line-height: 38px;padding:12px 24px;'>"
                                    + "----"
                                    + "</div></div></div></div></a>");
                            });
                            //pages为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多
                            next(lis.join(''), page < res.pages);
                        });
                    }, 500);
                }
            });
        });
    }
</script>
</body>
</html>
