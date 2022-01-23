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
    </style>
</head>
<body>
<div>
    <nav class="breadcrumb">
        <i class="Hui-iconfont">&#xe67f;</i> 首页
        <span class="c-gray en">&gt;</span> 合同管理
        <span class="c-gray en">&gt;</span> 出售合同
        <span class="c-gray en">&gt;</span> 合同列表
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
        <button id="detailbtn" style="display: none;" class="layui-btn layui-btn-sm" lay-event="detail"><i class="Hui-iconfont">&#xe604;</i> 合同明细</button>
    </div>
</script>
<!--自增序号-->
<script type="text/html" id="xuhao">
    <span data-d="{{d.LAY_TABLE_INDEX+1}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.LAY_TABLE_INDEX+1}}</span>
</script>
<!--合同客户-->
<script type="text/html" id="customerNameTpl">
    <span data-d="{{d.customer.customerName}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.customer.customerName}}</span>
</script>
<!--合同编号-->
<script type="text/html" id="contractNumberTpl">
    <span data-d="{{d.contractNumber}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.contractNumber}}</span>
</script>
<!--签订日期-->
<script type="text/html" id="signDateTpl">
    <span data-d="{{layui.util.toDateString(d.signDate, 'yyyy-MM-dd')}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{layui.util.toDateString(d.signDate, 'yyyy-MM-dd')}}</span>
</script>
<!--合同类型-->
<script type="text/html" id="contractTypeTpl">
    <span class="label label-warning radius" data-d="{{d.contractType}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.contractType }}</span>
</script>
<!--合同状态-->
<script type="text/html" id="contractStateTpl">
    {{#  if(d.contractState === '正常'){ }}
    <span class="label label-success radius" data-d="{{d.contractState}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.contractState }}</span>
    {{#  } else { }}
    <span class="label radius" data-d="{{d.contractState}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.contractState }}</span>
    {{#  } }}
</script>
<!--市场人员-->
<script type="text/html" id="marketPersonTpl">
    <span data-d="{{d.marketPerson}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.marketPerson}}</span>
</script>
<!--收款银行-->
<script type="text/html" id="contractPayBankTpl">
    <span data-d="{{d.contractPayBank}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.contractPayBank}}</span>
</script>
<!--备注说明-->
<script type="text/html" id="contractRemarkDescriptionTpl">
    <span data-d="{{d.contractRemarkDescription}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.contractRemarkDescription}}</span>
</script>
<%@include file="../../../other/conjs.html" %>
<script type="text/javascript" src="${ctx}/lib/jquery.validation/1.14.0/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/lib/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="${ctx}/lib/jquery.validation/1.14.0/messages_zh.js"></script>
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
        var validator1 = $("#form-validate").validate({
            rules: {
                contractNumber: {
                    required : true,
                    inputLimit:true,
                    rangelength: [6, 20]
                }
            },
            messages: {
                contractNumber: {
                    required : "合同编号不能为空!",
                    rangelength: "合同编号有效长度[6,20]!"
                }
            },
            errorElement: "em",
            errorPlacement: function (error, element) {
                error.appendTo(element.parent());
            },
            onkeyup: false,
            focusCleanup: false
        });
        var validator2 = $("#form-validate2").validate({
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
            //执行一个laydate实例
            laydate.render({
                elem: '#signDate' //指定元素
            });
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
                    // 作为 结束选择 的 开始时间
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
                , id: 'LAY_table_user' // table标识
                , url: '${pageContext.request.contextPath }/contract/searchList' //数据请求路径
                , method: 'post'
                , contentType: "application/json;charset=UTF-8"
                , where: {
                    contractType:'出售'
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
                        field: 'customerName',
                        minWidth:240,
                        title: '合同客户',
                        sort: true,
                        align: 'center',
                        templet: '#customerNameTpl'
                    }
                    , {
                        field: 'contractNumber',
                        title: '合同编号',
                        sort: true,
                        align: 'center',
                        templet: '#contractNumberTpl'
                    }
                    , {
                        field: 'signDate',
                        title: '签订日期',
                        sort: true,
                        align: 'center',
                        templet: "#signDateTpl"
                    }
                    , {
                        field: 'contractType',
                        title: '合同类型',
                        sort: true,
                        align: 'center',
                        templet: '#contractTypeTpl'
                    }
                    , {
                        field: 'marketPerson',
                        title: '市场人员',
                        sort: true,
                        align: 'center',
                        templet: '#marketPersonTpl'
                    }
                    , {
                        field: 'contractPayBank',
                        title: '收款银行',
                        sort: true,
                        align: 'center',
                        templet: '#contractPayBankTpl'
                    }
                    , {
                        field: 'contractState',
                        title: '合同状态',
                        sort: true,
                        align: 'center',
                        templet: '#contractStateTpl'
                    }
                    , {
                        field: 'contractRemarkDescription',
                        title: '备注说明',
                        sort: true,
                        align: 'center',
                        templet: '#contractRemarkDescriptionTpl'
                    }
                ]]
                , page: true  //开启分页
                , limit: 10   //默认十条数据一页
                , limits: [5, 10, 15, 20, 25, 30] //数据分页条
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
                                var customerID = $("#customerID").val().trim();
                                if (customerID == "") {
                                    layer.msg('请选择合同客户', {icon: 0, time: 1000, anim: 6});
                                    return false;
                                }
                                var contractNumber = $("#contractNumber").val().trim();
                                if (contractNumber == "") {
                                    layer.msg('请输入合同编号', {icon: 0, time: 1000, anim: 6});
                                    return false;
                                }
                                //编号规则验证
                                var reg = /^[a-zA-Z]([a-zA-Z0-9]{5,20})$/;
                                if (!reg.test(contractNumber)) {
                                    layer.msg('合同编号只能由字母和数字组成,且以字母开头,6<=长度<=20', {icon: 0, time: 1500, anim: 6});
                                    return false;
                                }
                                var contractType = $("#contractType").val().trim();
                                if (contractType == "") {
                                    layer.msg('请选择合同类型', {icon: 0, time: 1000, anim: 6});
                                    return false;
                                }
                                var signDateStr = $("#signDate").val().trim();
                                if (signDateStr == "") {
                                    layer.msg('请选择签订日期', {icon: 0, time: 1000, anim: 6});
                                    return false;
                                }
                                var sdate =signDateStr.split('-');
                                var signDate = new Date(sdate[0], sdate[1]-1, sdate[2]);//时分秒设置为0
                                var marketPerson = $("#marketPersonInput").val().trim();
                                if (marketPerson == "") {
                                    layer.msg('请选择市场人员', {icon: 0, time: 1000, anim: 6});
                                    return false;
                                }
                                var contractPayBank = $("#contractPayBankInput").val().trim();
                                if (contractPayBank == "") {
                                    layer.msg('请选择收款银行', {icon: 0, time: 1000, anim: 6});
                                    return false;
                                }
                                var contractState = $("#contractState").val().trim();
                                if (contractState == "") {
                                    layer.msg('请设置合同状态', {icon: 0, time: 1000, anim: 6});
                                    return false;
                                }
                                var contractRemarkDescription = $("#contractRemarkDescription").val().trim();
                                $.ajax({
                                    type: 'post',
                                    url: '${pageContext.request.contextPath }/contract/add',
                                    data: JSON.stringify({
                                        customerID: customerID,
                                        contractNumber: contractNumber.toUpperCase(),
                                        contractType: contractType,
                                        signDate: signDate,
                                        marketPerson: marketPerson,
                                        contractPayBank: contractPayBank,
                                        contractState:contractState,
                                        contractRemarkDescription: contractRemarkDescription
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
                                        layer.msg('合同已存在!', {icon: 5, time: 1000, anim: 6});
                                    }
                                });
                            }
                            , xs2: function (index, layero) {
                                layer.close(index);
                            }, success: function (layero) {
                                validator1.resetForm();//清除提示
                                $("#customerID").val('');
                                $("#contractNumber").val('');
                                $("#contractType").val('出售');
                                $("#contractState").val('正常');
                                $("#signDate").val('');
                                // 市场人员
                                $("#marketPerson").val('');
                                $("#marketPersonInput").val('');
                                document.getElementById("marketPersonInput").style.display="none";
                                // 收款银行
                                $("#contractPayBank").val('');
                                $("#contractPayBankInput").val('');
                                document.getElementById("contractPayBankInput").style.display="none";
                                form.render('select');
                                $("#contractRemarkDescription").val('');
                            }
                        }
                        tk('<span style="font-weight: bold">【出售合同】</span>添加合同', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '关闭'], _funbtnxs);
                        // 下拉框值改变动态设置其它输入
                        form.on('select(marketPerson)', function (data) {
                            if(data.value == "其它__") {
                                $("#marketPersonInput").val('');
                                document.getElementById("marketPersonInput").style.display="";
                            } else{
                                $("#marketPersonInput").val(data.value);
                                document.getElementById("marketPersonInput").style.display="none";
                            }
                            form.render('select');
                        });
                        form.on('select(contractPayBank)', function (data) {
                            if(data.value == "其它__") {
                                $("#contractPayBankInput").val('');
                                document.getElementById("contractPayBankInput").style.display="";
                            } else{
                                $("#contractPayBankInput").val(data.value);
                                document.getElementById("contractPayBankInput").style.display="none";
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
                                var customerID = $("#customerID").val().trim();
                                if (customerID == "") {
                                    layer.msg('请选择客户', {icon: 0, time: 1000, anim: 6});
                                    return false;
                                }
                                var contractNumber = $("#contractNumber").val().trim();
                                if (contractNumber == "") {
                                    layer.msg('请输入合同编号', {icon: 0, time: 1000, anim: 6});
                                    return false;
                                }
                                //编号规则验证
                                var reg = /^[a-zA-Z]([a-zA-Z0-9]{5,20})$/;
                                if (!reg.test(contractNumber)) {
                                    layer.msg('合同编号只能由字母和数字组成,且以字母开头,6<=长度<=20', {icon: 0, time: 1500, anim: 6});
                                    return false;
                                }
                                var contractType = $("#contractType").val().trim();
                                if (contractType == "") {
                                    layer.msg('请选择合同类型', {icon: 0, time: 1000, anim: 6});
                                    return false;
                                }
                                var signDateStr = $("#signDate").val().trim();
                                if (signDateStr == "") {
                                    layer.msg('请选择签订日期', {icon: 0, time: 1000, anim: 6});
                                    return false;
                                }
                                var sdate =signDateStr.split('-');
                                var signDate = new Date(sdate[0], sdate[1]-1, sdate[2]);//时分秒设置为0
                                var marketPerson = $("#marketPersonInput").val().trim();
                                if (marketPerson == "") {
                                    layer.msg('请选择市场人员', {icon: 0, time: 1000, anim: 6});
                                    return false;
                                }
                                var contractPayBank = $("#contractPayBankInput").val().trim();
                                if (contractPayBank == "") {
                                    layer.msg('请选择收款银行', {icon: 0, time: 1000, anim: 6});
                                    return false;
                                }
                                var contractState = $("#contractState").val().trim();
                                if (contractState == "") {
                                    layer.msg('请设置合同状态', {icon: 0, time: 1000, anim: 6});
                                    return false;
                                }
                                var contractRemarkDescription = $("#contractRemarkDescription").val().trim();
                                $.ajax({
                                    type: 'post',
                                    url: '${pageContext.request.contextPath }/contract/update',
                                    data: JSON.stringify({
                                        id: dataRow[0].id,
                                        customerID: customerID,
                                        contractNumber: contractNumber.toUpperCase(),
                                        contractType: contractType,
                                        signDate: signDate,
                                        marketPerson: marketPerson,
                                        contractPayBank: contractPayBank,
                                        contractState:contractState,
                                        contractRemarkDescription: contractRemarkDescription
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
                                        layer.msg('合同编号重复!', {icon: 5, time: 1000, anim: 6});
                                    }
                                });
                            }
                            , xs2: function (index, layero) {
                                layer.close(index);
                            }, success: function (layero) {
                                validator1.resetForm();//清除提示
                                $("#customerID").val(dataRow[0].customerID);
                                $("#contractNumber").val(dataRow[0].contractNumber);
                                $("#contractType").val(dataRow[0].contractType);
                                $("#contractState").val(dataRow[0].contractState);
                                $("#signDate").val(layui.util.toDateString(dataRow[0].signDate, 'yyyy-MM-dd'));
                                // 市场人员
                                $("#marketPerson").val(dataRow[0].marketPerson);
                                $("#marketPersonInput").val(dataRow[0].marketPerson);
                                if($("#marketPerson").val()==null || $("#marketPerson").val()==""){
                                    $("#marketPerson").val("其它__");
                                    document.getElementById("marketPersonInput").style.display="";
                                }else{
                                    document.getElementById("marketPersonInput").style.display="none";
                                }
                                // 收款银行
                                $("#contractPayBank").val(dataRow[0].contractPayBank);
                                $("#contractPayBankInput").val(dataRow[0].contractPayBank);
                                if($("#contractPayBank").val()==null || $("#contractPayBank").val()==""){
                                    $("#contractPayBank").val("其它__");
                                    document.getElementById("contractPayBankInput").style.display="";
                                }else{
                                    document.getElementById("contractPayBankInput").style.display="none";
                                }
                                form.render('select');
                                $("#contractRemarkDescription").val(dataRow[0].contractRemarkDescription);
                            }
                        }
                        tk('<span style="font-weight: bold">【出售合同】</span>修改合同', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '关闭'], _funbtnxs);
                        // 下拉框值改变动态设置其它输入
                        form.on('select(marketPerson)', function (data) {
                            if(data.value == "其它__") {
                                $("#marketPersonInput").val('');
                                document.getElementById("marketPersonInput").style.display="";
                            } else{
                                $("#marketPersonInput").val(data.value);
                                document.getElementById("marketPersonInput").style.display="none";
                            }
                            form.render('select');
                        });
                        form.on('select(contractPayBank)', function (data) {
                            if(data.value == "其它__") {
                                $("#contractPayBankInput").val('');
                                document.getElementById("contractPayBankInput").style.display="";
                            } else{
                                $("#contractPayBankInput").val(data.value);
                                document.getElementById("contractPayBankInput").style.display="none";
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
                                url: '${pageContext.request.contextPath }/contract/delete',
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
                    case 'detail':
                        var dataRow = checkStatus.data;  //获取选中行数据
                        if (dataRow.length == 0) {
                            layer.msg('请选中一行数据', {icon: 0, time: 1000, anim: 6});
                            return false;
                        }
                        if(dataRow[0].contractState!="正常"){
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
                                // 检测是否contractID、vehicleNumber一致
                                $.ajax({
                                    type: 'post',
                                    url: "${pageContext.request.contextPath }/contractDetail/check",
                                    data: JSON.stringify({
                                        contractID: dataRow[0].id,//合同ID
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
                                            url: "${pageContext.request.contextPath }/contractDetail/add",
                                            data: JSON.stringify({
                                                contractID: dataRow[0].id,
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
                                                layer.msg('添加成功!', {icon: 1, time: 1000});
                                            },
                                            error: function (data) {
                                                layer.msg('合同明细已存在!', {icon: 5, time: 1000, anim: 6});
                                            }
                                        });
                                    }
                                });
                            }
                            , xs2: function (index, layero) {
                                layer.close(index);
                            }, success: function (layero) {
                                validator2.resetForm();//清除提示
                                //自动赋值
                                $("#customerName2").val(dataRow[0].customer.customerName);
                                $("#contractNumber2").val(dataRow[0].contractNumber);
                                $("#contractType2").val(dataRow[0].contractType);
                                //手动赋值
                                $("#exportDate").val('');
                                $("#vehicleNumber").val('');
                                $("#projectAddress").val('');
                                $("#productMode").val('');
                                $("#productModeInput").val('');
                                document.getElementById("productModeInput").style.display="none";
                                $("#productPrice").val('0');
                                $("#productDeposit").val('0');
                                $("#supplyDescription").val('不含耗材');
                                $("#canPayQuota").val('0');
                                $("#productDiscount").val('0');
                                $("#hasPayQuota").val('0');
                                $("#unPayQuota").val('0');
                                $("#payState").val('未付清');
                                $("#salePerson").val('');
                                $("#salePersonInput").val('');
                                document.getElementById("salePersonInput").style.display="none";
                                $("#contractDetailRemarkDescription").val('');
                                form.render('select');
                            }
                        }
                        tk('<span style="font-weight: bold">【出售合同】</span>添加合同明细', ['100%', '100%'], 'userbj', $("#bjnr2"), ['确定', '关闭'], _funbtnxs);
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
                        url: '${pageContext.request.contextPath }/contract/searchList',
                        method: 'post',
                        contentType: "application/json;charset=UTF-8",
                        page: {
                            curr: 1 //重新从第 1 页开始
                        }, where: {
                            contractType:'出售',
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
            // 客户
            $.ajax({
                url: '${pageContext.request.contextPath }/customer/getList',
                method: 'post',
                data: JSON.stringify({}),
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (data) {
                    $('#customerID').empty();
                    $('#customerID').append('<option value="">请选择</option>');
                    $.each(data, function (index, item) {
                        $('#customerID').append('<option value='+item.id+'>'+item.customerName+'</option>');
                    });
                    form.render("select");
                }, error: function (data) {
                    $('#customerID').empty();
                    $('#customerID').append('<option value="">请选择</option>');
                    form.render("select");
                }
            });
            permission();//权限验证
        });
    });
    // 权限
    function permission(){
        $.ajax({
            url: '${pageContext.request.contextPath }/rolePermission/searchList',
            method: 'post',
            data: JSON.stringify({id:'${sessionScope.CurrentUser.roleID}',menuNameString:'合同列表'}),
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
        $.ajax({
            url: '${pageContext.request.contextPath }/rolePermission/search',
            method: 'post',
            data: JSON.stringify({id:'${sessionScope.CurrentUser.roleID}',menuNameString:'合同明细',operationNameString:'创建'}),
            contentType: "application/json;charset=UTF-8",
            dataType: "json",
            success: function (data) {
                document.getElementById("detailbtn").style.display = "";
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
                <td align="right" width="80">合同客户：</td>
                <td align="left">
                    <select class="layui-input" id="customerID" lay-search></select>
                </td>
            </tr>
            <tr>
                <td align="right">合同编号：</td>
                <td align="left">
                    <input type="text" id="contractNumber" name="contractNumber" autocomplete="off" class="layui-input" placeholder="请输入"
                           Onkeyup="this.value=this.value.replace(/[^\a-\z\A-\Z0-9]/g,'')">
                </td>
            </tr>
            <tr>
                <td align="right">合同类型：</td>
                <td align="left">
                    <select class="layui-input" id="contractType" disabled><!--限制修改-->
                        <option value="租赁">租赁</option>
                        <option value="出售" selected>出售</option>
                        <option value="代理商">代理商</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="right">签订日期：</td>
                <td align="left">
                    <input type="text" id="signDate" autocomplete="off" class="layui-input" placeholder="请选择日期">
                </td>
            </tr>
            <tr>
                <td align="right">市场人员：</td>
                <td align="left">
                    <select class="layui-input" id="marketPerson" lay-filter="marketPerson">
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
                    <input type="text" style="display: none" id="marketPersonInput" autocomplete="off"
                           class="layui-input" placeholder="请输入">
                </td>
            </tr>
            <tr>
                <td align="right">收款银行：</td>
                <td align="left">
                    <select class="layui-input" id="contractPayBank" lay-filter="contractPayBank">
                        <option value="">请选择</option>
                        <option value="民生银行">民生银行</option>
                        <option value="中原银行">中原银行</option>
                        <option value="工商银行">工商银行</option>
                        <option value="其它__">其它__</option>
                    </select>
                    <input type="text" style="display: none" id="contractPayBankInput" autocomplete="off"
                           class="layui-input" placeholder="请输入">
                </td>
            </tr>
            <tr>
                <td align="right">合同状态：</td>
                <td align="left">
                    <select class="layui-input" id="contractState">
                        <option value="正常" selected>正常</option>
                        <option value="终止">终止</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="right">备注说明：</td>
                <td align="left">
                    <textarea id="contractRemarkDescription" rows="10" autocomplete="off" class="layui-textarea" placeholder="请输入"></textarea>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
<div id="bjnr2" style="display: none;">
    <form class="layui-form" id="form-validate2">
        <table class="layui-table layui-xs" lay-skin="nob">
            <tbody>
            <tr>
                <td align="right" width="90">合同客户：</td>
                <td align="left">
                    <input type="text" id="customerName2" class="layui-input layui-btn-disabled" disabled>
                </td>
            </tr>
            <tr>
                <td align="right">合同编号：</td>
                <td align="left">
                    <input type="text" id="contractNumber2" class="layui-input layui-btn-disabled" disabled>
                </td>
            </tr>
            <tr>
                <td align="right">合同类型：</td>
                <td align="left">
                    <input type="text" id="contractType2" class="layui-input layui-btn-disabled" disabled>
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