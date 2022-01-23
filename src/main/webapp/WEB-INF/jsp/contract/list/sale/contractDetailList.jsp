<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../../other/meta.html" %>
    <%@include file="../../../other/style.html" %>
    <style type="text/css">
        em.error {
            font-size: 8px;
            color: red;
        }
        a:link{
            text-decoration:none;   /* 指正常的未被访问过的链接*/
        }
        a:visited{
            text-decoration:none; /*指已经访问过的链接*/
        }
        a:hover{
            text-decoration:none;/*指鼠标在链接*/
        }
        a:active{
            text-decoration:none;/* 指正在点的链接*/
        }
    </style>
</head>
<body>
<div>
    <nav class="breadcrumb">
        <i class="Hui-iconfont">&#xe67f;</i> 首页
        <span class="c-gray en">&gt;</span> 合同管理
        <span class="c-gray en">&gt;</span> 出售合同
        <span class="c-gray en">&gt;</span> 合同明细
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
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
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
<!--合同客户-->
<script type="text/html" id="customerNameTpl">
    <span data-d="{{d.contract.customer.customerName}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.contract.customer.customerName}}</span>
</script>
<!--合同编号-->
<script type="text/html" id="contractNumberTpl">
    <span data-d="{{d.contract.contractNumber}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.contract.contractNumber}}</span>
</script>
<!--合同类型-->
<script type="text/html" id="contractTypeTpl">
    <span class="label label-warning radius" data-d="{{d.contract.contractType}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.contract.contractType }}</span>
</script>
<!--合同状态-->
<script type="text/html" id="contractStateTpl">
    {{#  if(d.contract.contractState === '正常'){ }}
    <span class="label label-success radius" data-d="{{d.contract.contractState}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.contract.contractState }}</span>
    {{#  } else { }}
    <span class="label radius" data-d="{{d.contract.contractState}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.contract.contractState }}</span>
    {{#  } }}
</script>
<!--出库日期-->
<script type="text/html" id="exportDateTpl">
    <span data-d="{{layui.util.toDateString(d.exportDate, 'yyyy-MM-dd')}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{layui.util.toDateString(d.exportDate, 'yyyy-MM-dd')}}</span>
</script>
<!--车识别码-->
<script type="text/html" id="vehicleNumberTpl">
    <span data-d="{{d.vehicleNumber}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.vehicleNumber}}</span>
</script>
<!--项目地址-->
<script type="text/html" id="projectAddressTpl">
    <span data-d="{{d.projectAddress}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.projectAddress}}</span>
</script>
<!--产品型号-->
<script type="text/html" id="productModeTpl">
    <span data-d="{{d.productMode}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.productMode}}</span>
</script>
<!--产品单价-->
<script type="text/html" id="productPriceTpl">
    <span data-d="{{d.productPrice}}元/台" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.productPrice }}元/台</span>
</script>
<!--产品押金-->
<script type="text/html" id="productDepositTpl">
    <span data-d="{{d.productDeposit}}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.productDeposit }}元</span>
</script>
<!--产品耗材-->
<script type="text/html" id="supplyDescriptionTpl">
    <span data-d="{{d.supplyDescription}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.supplyDescription}}</span>
</script>
<!--应收金额-->
<script type="text/html" id="canPayQuotaTpl">
    <span data-d="{{ d.canPayQuota }}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.canPayQuota }}元</span>
</script>
<!--优惠金额-->
<script type="text/html" id="productDiscountTpl">
    <span data-d="{{ d.productDiscount }}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.productDiscount }}元</span>
</script>
<!--已收金额-->
<script type="text/html" id="hasPayQuotaTpl">
    <span data-d="{{ d.hasPayQuota }}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.hasPayQuota }}元</span>
</script>
<!--未收金额-->
<script type="text/html" id="unPayQuotaTpl">
    <span data-d="{{ d.unPayQuota }}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.unPayQuota }}元</span>
</script>
<!--付款状态-->
<script type="text/html" id="payStateTpl">
    {{#  if(d.payState === "已付清"){ }}
    <span  class="label label-success radius" data-d="{{ d.payState }}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.payState }}</span>
    {{#  } else { }}
    <span  class="label label-default radius" data-d="{{ d.payState }}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.payState }}</span>
    {{#  } }}
</script>
<!--售后人员-->
<script type="text/html" id="salePersonTpl">
    <span data-d="{{d.salePerson}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.salePerson}}</span>
</script>
<!--是否开票-->
<script type="text/html" id="hasBillTpl">
    <input type="checkbox" data-d="{{d.hasBill==1?'已开票':'未开票' }}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" lay-skin="switch" lay-text="已开票|未开票" {{ d.hasBill==1?'checked':'' }} disabled>
</script>
<!--备注说明-->
<script type="text/html" id="contractDetailRemarkDescriptionTpl">
    <span data-d="{{d.contractDetailRemarkDescription}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.contractDetailRemarkDescription}}</span>
</script>
<%@include file="../../../other/conjs.html" %>
<script type="text/javascript" src="${ctx}/lib/jquery.validation/1.14.0/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/lib/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="${ctx}/lib/jquery.validation/1.14.0/messages_zh.js"></script>
<script type="text/javascript" src="${ctx}/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="${ctx}/static/h-ui.admin.pro.iframe/js/h-ui.admin.pro.iframe.min.js"></script>
<script type="text/javascript">
    // 单价输入变化 -> 应收变化、未收变化、状态变化
    function PriceChange(){
        var productPrice = $('#productPrice').val() == '' ? 0.0 : parseFloat($('#productPrice').val());// 单价变化
        var total = productPrice.toFixed(2);// 应收 = 单价
        $("#canPayQuota").val(total);// 应收变化
        var productDiscount = $('#productDiscount').val() == '' ? 0.0 : parseFloat($('#productDiscount').val());// 优惠
        var hasPayQuota = $('#hasPayQuota').val() == '' ? 0.0 : parseFloat($('#hasPayQuota').val());// 已收
        var unQuota = total - productDiscount - hasPayQuota;// 未收 = 应收 - 优惠 - 已收
        unQuota = unQuota.toFixed(2);//保留两位小数
        $('#unPayQuota').val(unQuota);// 未收变化
        // 未收 -> 状态
        if(unQuota <=0 ){
            $("#payState").val('已付清');
        } else{
            $("#payState").val('未付清');
        }
    }
    // 优惠输入变化 -> 未收变化、状态变化
    function DiscountChange(){
        var productDiscount = $('#productDiscount').val() == '' ? 0.0 : parseFloat($('#productDiscount').val());// 优惠变化
        var canPayQuota = $('#canPayQuota').val() == '' ? 0.0 : parseFloat($('#canPayQuota').val());// 应收
        var hasPayQuota = $('#hasPayQuota').val() == '' ? 0.0 : parseFloat($('#hasPayQuota').val());// 已收
        var unQuota = canPayQuota - productDiscount - hasPayQuota;// 未收 = 应收 - 优惠 - 已收
        unQuota = unQuota.toFixed(2);//保留两位小数
        $('#unPayQuota').val(unQuota);// 未收变化
        // 未收 -> 状态
        if(unQuota <=0 ){
            $("#payState").val('已付清');
        } else{
            $("#payState").val('未付清');
        }
    }
    // 初始化脚本
    $(function () {
        jQuery.validator.addMethod("inputLimit",function(value, element){
            return /^[a-zA-Z][a-zA-Z0-9]*$/.test(value);
        },"只能包含字母、数字,且以字母开头!");
        var validator = $("#form-validate").validate({
            rules: {
                vehicleNumber: {
                    required : true,
                    inputLimit:true,
                    rangelength: [8, 20]
                }
            },
            messages: {
                vehicleNumber: {
                    required : "车识别码不能为空!",
                    rangelength: "车识别码有效长度[8,20]!"
                }
            },
            errorElement: "em",
            errorPlacement: function (error, element) {
                error.appendTo(element.parent());
            },
            onkeyup: false,
            focusCleanup: false
        });
        // lay加载
        layui.use(['form', 'table', 'laydate'], function () {
            let table = layui.table;
            let form = layui.form;
            let laydate = layui.laydate;
            laydate.render({
                elem: '#exportDate' //指定元素
            });
            let dateEntryStart = laydate.render({
                elem: '#timeStart',
                trigger: 'click',
                done: function (value, date) {
                    dateEntryEnd.config.min = {
                        year: date.year,
                        month: date.month - 1,
                        date: date.date,
                        hours: date.hours,
                        minutes: date.minutes,
                        seconds: date.seconds
                    };
                    dateEntryEnd.config.value = value;
                }
            });
            let dateEntryEnd = laydate.render({
                elem: '#timeFinal',
                trigger: 'click',//  触发方式
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
            // 初始化表格
            table.render({
                elem: '#LAY_table_user' // 指定表格
                , id: 'LAY_table_user'
                , url: '${pageContext.request.contextPath }/contractDetail/searchList/出售' //数据请求路径
                , method: 'post'
                , contentType: "application/json;charset=UTF-8"
                , where: {  }
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
                        field: 'customerName',
                        title: '合同客户',
                        minWidth:240,
                        sort:true,
                        align: 'center',
                        templet: '#customerNameTpl'
                    }
                    , {
                        field: 'contractNumber',
                        title: '合同编号',
                        sort:true,
                        align: 'center',
                        templet: '#contractNumberTpl'
                    }
                    , {
                        field: 'contractType',
                        title: '合同类型',
                        sort:true,
                        align: 'center',
                        templet: '#contractTypeTpl'
                    }
                    , {
                        field: 'contractState',
                        title: '合同状态',
                        sort: true,
                        align: 'center',
                        templet: '#contractStateTpl'
                    }
                    , {
                        field: 'exportDate',
                        title: '出库日期',
                        sort:true,
                        align: 'center',
                        templet: "#exportDateTpl"
                    }
                    , {
                        field: 'vehicleNumber',
                        title: '车识别码',
                        sort:true,
                        align: 'center',
                        templet: '#vehicleNumberTpl'
                    }
                    , {
                        field: 'projectAddress',
                        title: '项目地址',
                        sort:true,
                        align: 'center',
                        templet: "#projectAddressTpl"
                    }
                    , {
                        field: 'productMode',
                        title: '型号',
                        sort:true,
                        align: 'center',
                        templet: "#productModeTpl"
                    }
                    , {
                        field: 'productPrice',
                        title: '价格',
                        sort:true,
                        align: 'center',
                        templet: '#productPriceTpl'
                    }
                    , {
                        field: 'productDeposit',
                        title: '押金',
                        sort:true,
                        align: 'center',
                        templet: "#productDepositTpl"
                    }
                    , {
                        field: 'supplyDescription',
                        title: '耗材详情',
                        minWidth: 300,
                        sort:true,
                        align: 'center',
                        templet: "#supplyDescriptionTpl"
                    }
                    , {
                        field: 'canPayQuota',
                        title: '应收金额',
                        sort:true,
                        align: 'center',
                        templet: "#canPayQuotaTpl"
                    }
                    , {
                        field: 'productDiscount',
                        title: '优惠金额',
                        sort:true,
                        align: 'center',
                        templet: "#productDiscountTpl"
                    }
                    , {
                        field: 'hasPayQuota',
                        title: '已收金额',
                        sort:true,
                        align: 'center',
                        templet: "#hasPayQuotaTpl"
                    }
                    , {
                        field: 'unPayQuota',
                        title: '未收金额',
                        sort:true,
                        align: 'center',
                        templet: "#unPayQuotaTpl"
                    }
                    , {
                        field: 'payState',
                        title: '付款状态',
                        sort:true,
                        align: 'center',
                        templet: '#payStateTpl'
                    }
                    , {
                        field: 'salePerson',
                        title: '售后人员',
                        sort:true,
                        align: 'center',
                        templet: '#salePersonTpl'
                    }
                    , {
                        field: 'hasBill',
                        title: '是否开票',
                        sort:true,
                        align: 'center',
                        templet: '#hasBillTpl'
                    }
                    , {
                        field: 'contractDetailRemarkDescription',
                        title: '车辆备注',
                        minWidth: 400,
                        sort:true,
                        align: 'center',
                        templet: '#contractDetailRemarkDescriptionTpl'
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
                $('#cashInfo').attr('onclick','Hui_admin_tab(this)');
                $('#cashInfo').attr('data-href','${ctx}/cash/detail/'+obj.data.id+'/出售');
                $('#cashInfo').attr('data-title','【'+obj.data.projectAddress+'】收款信息');

                $('#billInfo').attr('onclick','Hui_admin_tab(this)');
                $('#billInfo').attr('data-href','${ctx}/bill/detail/'+obj.data.id+'/出售');
                $('#billInfo').attr('data-title','【'+obj.data.projectAddress+'】开票信息');
            });
            // 头工具栏事件
            table.on('toolbar(LAY_table_user)', function (obj) {
                var checkStatus = table.checkStatus(obj.config.id); //获取选中行状态
                switch (obj.event) {
                    // 修改车辆
                    case 'update':
                        var dataRow = checkStatus.data;  //获取选中行数据
                        if (dataRow.length == 0) {
                            layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
                            return false;
                        }
                        if(dataRow[0].contract.contractState!="正常"){
                            layer.msg('合同处于终止状态', {icon: 0, time: 1000, anim: 6});
                            return false;
                        }
                        var _funbtnxs = {
                            yesxs1: function (index, layero) {
                                var exportDateStr = $("#exportDate").val().trim();
                                if (exportDateStr == "") {
                                    layer.msg('请选择出库日期', {icon: 0, time: 1000, anim: 6});
                                    return false;
                                }
                                var sdate0 = exportDateStr.split('-');
                                var exportDate = new Date(sdate0[0], sdate0[1]-1, sdate0[2]);//时分秒设置为0
                                var vehicleNumber = $("#vehicleNumber").val();
                                if (vehicleNumber == "") {
                                    layer.msg('请输入车识别码', {icon: 0, time: 1000, anim: 6});
                                    return false;
                                }
                                var reg = /^[a-zA-Z]([a-zA-Z0-9]{7,20})$/;
                                if (!reg.test(vehicleNumber)) {
                                    layer.msg('车识别码只能由字母和数字组成,且以字母开头,8<=长度<=20',
                                        {icon: 0, time: 1000, anim: 6});
                                    return false;
                                }
                                // 检测是否contractID、vehicleNumber出现了一致
                                $.ajax({
                                    type: 'post',
                                    url: "${pageContext.request.contextPath }/contractDetail/check",
                                    data: JSON.stringify({
                                        id:dataRow[0].id,//明细ID
                                        contractID: dataRow[0].contractID,//合同ID
                                        vehicleNumber: vehicleNumber.toUpperCase()//车识别码
                                    }),
                                    contentType: "application/json;charset=UTF-8",
                                    dataType: "json",
                                    success: function (data) {
                                        layer.msg('合同明细已存在!', {icon: 5, time: 1000, anim: 6});
                                    },
                                    error: function (data) {
                                        var projectAddress = $("#projectAddress").val().trim();
                                        if (projectAddress == "") {
                                            layer.msg('请输入项目地址', {icon: 0, time: 1000, anim: 6});
                                            return false;
                                        }
                                        var productMode = $("#productModeInput").val().trim();
                                        if (productMode == "") {
                                            layer.msg('请选择产品型号', {icon: 0, time: 1000, anim: 6});
                                            return false;
                                        }
                                        var productPrice = $("#productPrice").val().trim();
                                        if (productPrice == "") {
                                            layer.msg('请输入产品单价', {icon: 0, time: 1000, anim: 6});
                                            return false;
                                        }
                                        var productDeposit = $("#productDeposit").val().trim();
                                        if (productDeposit == "") {
                                            layer.msg('请输入产品押金', {icon: 0, time: 1000, anim: 6});
                                            return false;
                                        }
                                        var supplyDescription = $("#supplyDescription").val().trim();
                                        if (supplyDescription == "") {
                                            layer.msg('请输入产品耗材', {icon: 0, time: 1000, anim: 6});
                                            return false;
                                        }
                                        var canPayQuota= $("#canPayQuota").val().trim();;
                                        var productDiscount = $("#productDiscount").val().trim();
                                        if (productDiscount == "") {
                                            layer.msg('请输入优惠金额', {icon: 0, time: 1000, anim: 6});
                                            return false;
                                        }
                                        var unPayQuota = $("#unPayQuota").val().trim();
                                        var payState = $("#payState").val().trim();
                                        var salePerson = $("#salePersonInput").val().trim();
                                        if (salePerson == "") {
                                            layer.msg('请选择售后人员', {icon: 0, time: 1000, anim: 6});
                                            return false;
                                        }
                                        var contractDetailRemarkDescription = $("#contractDetailRemarkDescription").val().trim();
                                        // 提交
                                        $.ajax({
                                            type: 'post',
                                            url: "${pageContext.request.contextPath }/contractDetail/update",
                                            data: JSON.stringify({
                                                id: dataRow[0].id,
                                                contractID: dataRow[0].contractID,
                                                exportDate: exportDate,
                                                vehicleNumber: vehicleNumber.toUpperCase(),
                                                projectAddress: projectAddress,
                                                productMode: productMode.toUpperCase(),
                                                productPrice: productPrice,
                                                productDeposit: productDeposit,
                                                supplyDescription: supplyDescription,
                                                canPayQuota:canPayQuota,
                                                productDiscount: productDiscount,
                                                unPayQuota:unPayQuota,
                                                payState:payState,
                                                salePerson: salePerson,
                                                contractDetailRemarkDescription: contractDetailRemarkDescription
                                            }),
                                            contentType: "application/json;charset=UTF-8",
                                            dataType: "json",
                                            success: function (data) {
                                                layer.msg('修改成功!', {
                                                    icon: 1, time: 1000, end: function () {
                                                        location.reload();
                                                    }
                                                });
                                            }, error: function (data) {
                                                layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6});
                                            }
                                        });
                                    }
                                });
                            }, xs2: function (index, layero) {
                                layer.close(index);
                            }, success: function (layero) {
                                validator.resetForm();//清除提示
                                $("#customerName").val(dataRow[0].contract.customer.customerName);
                                $("#contractNumber").val(dataRow[0].contract.contractNumber);
                                $("#contractType").val(dataRow[0].contract.contractType);
                                $("#exportDate").val(layui.util.toDateString(dataRow[0].exportDate, 'yyyy-MM-dd'));
                                $("#vehicleNumber").val(dataRow[0].vehicleNumber);
                                $("#projectAddress").val(dataRow[0].projectAddress);
                                $("#productMode").val(dataRow[0].productMode);
                                $("#productModeInput").val(dataRow[0].productMode);
                                if($("#productMode").val()==null || $("#productMode").val()==""){
                                    $("#productMode").val("其它__");
                                    document.getElementById("productModeInput").style.display="";
                                }else{
                                    document.getElementById("productModeInput").style.display="none";
                                }
                                $("#productPrice").val(dataRow[0].productPrice);
                                $("#productDeposit").val(dataRow[0].productDeposit);
                                $("#supplyDescription").val(dataRow[0].supplyDescription);
                                $("#canPayQuota").val(dataRow[0].canPayQuota);
                                $("#productDiscount").val(dataRow[0].productDiscount);
                                $("#hasPayQuota").val(dataRow[0].hasPayQuota);
                                $("#unPayQuota").val(dataRow[0].unPayQuota);
                                $("#payState").val(dataRow[0].payState);
                                $("#salePerson").val(dataRow[0].salePerson);
                                $("#salePersonInput").val(dataRow[0].salePerson);
                                if($("#salePerson").val()==null || $("#salePerson").val()==""){
                                    $("#salePerson").val("其它__");
                                    document.getElementById("salePersonInput").style.display="";
                                }else{
                                    document.getElementById("salePersonInput").style.display="none";
                                }
                                $("#contractDetailRemarkDescription").val(dataRow[0].contractDetailRemarkDescription);
                                form.render('select');
                            }
                        }
                        tk('<span style="font-weight: bold">【出售合同】</span>修改合同明细', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '关闭'], _funbtnxs);
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
                        form.on('select(salePerson)', function (data) {
                            if(data.value == "其它__") {
                                $("#salePersonInput").val('');
                                document.getElementById("salePersonInput").style.display="";
                            } else{
                                $("#salePersonInput").val(data.value);
                                document.getElementById("salePersonInput").style.display="none";
                            }
                            form.render('select');
                        });
                        break;
                    // 删除
                    case 'delete':
                        var dataRow = checkStatus.data;  //获取选中行数据
                        if (dataRow.length == 0) {
                            layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
                            return false;
                        }
                        if(dataRow[0].contract.contractState!="正常"){
                            layer.msg('合同处于终止状态', {icon: 0, time: 1000, anim: 6});
                            return false;
                        }
                        layer.confirm('确认要删除吗？', function (index) {
                            $.ajax({
                                type: 'post',
                                url: '${pageContext.request.contextPath }/contractDetail/delete',
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
            // 重载
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
                        url: '${pageContext.request.contextPath }/contractDetail/searchList/出售',
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
            data: JSON.stringify({id:'${sessionScope.CurrentUser.roleID}',menuNameString:'合同明细'}),
            contentType: "application/json;charset=UTF-8",
            dataType: "json",
            success: function (data) {
                let obj = eval(data);
                $(obj).each(function (index) {
                    let item = obj[index];
                    switch (item.operation.operateName) {
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
    <form class="layui-form" id="form-validate">
        <table class="layui-table layui-xs" lay-skin="nob">
            <tbody>
            <tr>
                <td align="right" width="90">合同客户：</td>
                <td align="left">
                    <input type="text" id="customerName" class="layui-input layui-btn-disabled" disabled>
                </td>
            </tr>
            <tr>
                <td align="right">合同编号：</td>
                <td align="left">
                    <input type="text" id="contractNumber" class="layui-input layui-btn-disabled" disabled>
                </td>
            </tr>
            <tr>
                <td align="right">合同类型：</td>
                <td align="left">
                    <input type="text" id="contractType" class="layui-input layui-btn-disabled" disabled>
                </td>
            </tr>
            <tr>
                <td align="right">出库日期：</td>
                <td align="left">
                    <input type="text" id="exportDate" autocomplete="off" class="layui-input" placeholder="请选择">
                </td>
            </tr>
            <tr>
                <td align="right">车识别码：</td>
                <td align="left">
                    <input type="text" name="vehicleNumber" id="vehicleNumber" autocomplete="off" class="layui-input"
                           placeholder="请输入" Onkeyup="this.value=this.value.replace(/[^\a-\z\A-\Z0-9]/g,'')">
                </td>
            </tr>
            <tr>
                <td align="right">项目地址：</td>
                <td align="left">
                    <input type="text" id="projectAddress" autocomplete="off" class="layui-input" placeholder="请输入">
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
                <td align="right">产品单价：<span style="margin-right: 10px;">（元/台）</span></td>
                <td align="left">
                    <input type="text" id="productPrice" oninput="PriceChange()" autocomplete="off" class="layui-input" value="0"
                           onblur="if(value=='')execCommand('undo')" Onkeyup="if(isNaN(value))execCommand('undo')" Onpaste="return false;" placeholder="请输入">
                </td>
            </tr>
            <tr>
                <td align="right">产品押金：<span style="margin-right: 22px">（元）</span></td>
                <td align="left">
                    <input type="text" id="productDeposit" autocomplete="off" class="layui-input" value="0"
                           onblur="if(value=='')execCommand('undo')" Onkeyup="if(isNaN(value))execCommand('undo')" Onpaste="return false;" placeholder="请输入">
                </td>
            </tr>
            <tr>
                <td align="right">耗材详情：</td>
                <td align="left">
                    <textarea rows="10" id="supplyDescription" autocomplete="off" class="layui-textarea" placeholder="请输入"></textarea>
                </td>
            </tr>
            <tr>
                <td align="right">应收金额：<span style="margin-right: 22px">（元）</span></td>
                <td align="left">
                    <input type="text" id="canPayQuota" value="0" class="layui-input layui-btn-disabled" disabled>
                </td>
            </tr>
            <tr>
                <td align="right">优惠金额：<span style="margin-right: 22px">（元）</span></td>
                <td align="left">
                    <input type="text" id="productDiscount" value="0" oninput="DiscountChange()" autocomplete="off" class="layui-input"
                           onblur="if(value=='')execCommand('undo')" Onkeyup="if(isNaN(value))execCommand('undo')" Onpaste="return false;" placeholder="请输入">
                </td>
            </tr>
            <tr>
                <td align="right">已收金额：<span style="margin-right: 22px">（元）</span></td>
                <td align="left">
                    <input type="text" id="hasPayQuota" value="0" class="layui-input layui-btn-disabled" disabled>
                </td>
            </tr>
            <tr>
                <td align="right">未收金额：<span style="margin-right: 22px">（元）</span></td>
                <td align="left">
                    <input type="text" id="unPayQuota" value="0" class="layui-input layui-btn-disabled" disabled>
                </td>
            </tr>
            <tr>
                <td align="right">付款状态：</td>
                <td align="left">
                    <input type="text" id="payState" value="未付清" class="layui-input layui-btn-disabled" disabled>
                </td>
            </tr>
            <tr>
                <td align="right">售后人员：</td>
                <td align="left">
                    <select class="layui-input" id="salePerson" placeholder="请选择" lay-filter="salePerson">
                        <option value="">请选择</option>
                        <option value="王玮">王玮</option>
                        <option value="王凯">王凯</option>
                        <option value="陈明鹏">陈明鹏</option>
                        <option value="韩尚彤">韩尚彤</option>
                        <option value="钱焕春">钱焕春</option>
                        <option value="司志伟">司志伟</option>
                        <option value="赵建党">赵建党</option>
                        <option value="马鹏飞">马鹏飞</option>
                        <option value="其它__">其它__</option>
                    </select>
                    <input type="text" style="display: none" id="salePersonInput" autocomplete="off"
                           class="layui-input" placeholder="请输入">
                </td>
            </tr>
            <tr>
                <td align="right">备注信息：</td>
                <td align="left">
                    <textarea rows="10" id="contractDetailRemarkDescription" autocomplete="off" class="layui-textarea" placeholder="请输入"></textarea>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>