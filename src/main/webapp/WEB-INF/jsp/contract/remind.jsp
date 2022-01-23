<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../other/meta.html" %>
    <%@include file="../other/style.html" %>
    <style type="text/css">
        em.error {
            font-size: 8px;
            color: red;
        }
    </style>
</head>
<body>
<div>
    <div class="page-container">
        <div class="mt">
            <div class="demoTable layui-form">
                <div class="layui-inline">
                    客户：
                    <div class="layui-inline" style="width: 240px;">
                        <select class="layui-input" id="customerIDFilter" lay-filter="customerIDFilter" lay-search></select>
                    </div>
                </div>
                <a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);"><i class="Hui-iconfont">&#xe68f;</i></a>
            </div>
        </div>
        <div class="layui-tab" lay-filter="remindPopTab">
            <ul class="layui-tab-title">
                <li lay-id="1">代理到期预警</li>
                <li lay-id="3">代理阶段预警</li>
                <li lay-id="2" class="layui-this">租赁到期预警</li>
                <li lay-id="4">租赁阶段预警</li>
                <li lay-id="5">出售回款预警</li>
            </ul>
            <div class="layui-tab-content">
                <!--代理到期预警-->
                <div class="layui-tab-item layui-show">
                    <table class="layui-hide" id="LAY_table_user1" lay-filter="LAY_table_user1"></table>
                </div>
                <!--代理阶段预警-->
                <div class="layui-tab-item">
                    <table class="layui-hide" id="LAY_table_user3" lay-filter="LAY_table_user3"></table>
                </div>
                <!--租赁到期预警-->
                <div class="layui-tab-item">
                    <table class="layui-hide" id="LAY_table_user2" lay-filter="LAY_table_user2"></table>
                </div>
                <!--租赁阶段预警-->
                <div class="layui-tab-item">
                    <table class="layui-hide" id="LAY_table_user4" lay-filter="LAY_table_user4"></table>
                </div>
                <!--出售回款预警-->
                <div class="layui-tab-item">
                    <table class="layui-hide" id="LAY_table_user5" lay-filter="LAY_table_user5"></table>
                </div>
            </div>
        </div>
    </div>
    <div id="bjnrPop" style="display: none;">
        <div class="page-container">
            <table class="layui-hide" id="LAY_table_user6" lay-filter="LAY_table_user6"></table>
        </div>
    </div>
</div>
<!--工具栏-->
<script type="text/html" id="toolbarDemo"></script>
<!--合同客户-->
<script type="text/html" id="customerName">
    <span data-d="{{d.contract.customer.customerName}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.contract.customer.customerName}}</span>
</script>
<script type="text/html" id="stageCustomerName">
    <span data-d="{{d.contractDetail.contract.customer.customerName}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.contractDetail.contract.customer.customerName}}</span>
</script>
<!--合同编号-->
<script type="text/html" id="contractNumber">
    <span data-d="{{d.contract.contractNumber}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.contract.contractNumber}}</span>
</script>
<script type="text/html" id="stageContractNumber">
    <span data-d="{{d.contractDetail.contract.contractNumber}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.contractDetail.contract.contractNumber}}</span>
</script>
<!--合同类型-->
<script type="text/html" id="contractType">
    {{#  if(d.contract.contractType === '租赁'){ }}
    <span class="label label-success radius" data-d="{{d.contract.contractType}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.contract.contractType }}</span>
    {{#  } else if(d.contract.contractType === '出售'){ }}
    <span class="label label-warning radius" data-d="{{d.contract.contractType}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.contract.contractType }}</span>
    {{#  } else if(d.contract.contractType === '代理商'){ }}
    <span class="label label-primary radius" data-d="{{d.contract.contractType}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.contract.contractType }}</span>
    {{#  } }}
</script>
<script type="text/html" id="stageContractType">
    {{#  if(d.contractDetail.contract.contractType === '租赁'){ }}
    <span class="label label-success radius" data-d="{{d.contractDetail.contract.contractType}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.contractDetail.contract.contractType }}</span>
    {{#  } else if(d.contractDetail.contract.contractType === '出售'){ }}
    <span class="label label-warning radius" data-d="{{d.contractDetail.contract.contractType}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.contractDetail.contract.contractType }}</span>
    {{#  } else if(d.contractDetail.contract.contractType === '代理商'){ }}
    <span class="label label-primary radius" data-d="{{d.contractDetail.contract.contractType}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.contractDetail.contract.contractType }}</span>
    {{#  } }}
</script>
<!--合同状态-->
<script type="text/html" id="contractState">
    {{#  if(d.contract.contractState === '正常'){ }}
    <span class="label label-success radius" data-d="{{d.contract.contractState}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.contract.contractState }}</span>
    {{#  } else { }}
    <span class="label radius" data-d="{{d.contract.contractState}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.contract.contractState }}</span>
    {{#  } }}
</script>
<script type="text/html" id="stageContractState">
    {{#  if(d.contractDetail.contract.contractState === '正常'){ }}
    <span class="label label-success radius" data-d="{{d.contractDetail.contract.contractState}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.contractDetail.contract.contractState }}</span>
    {{#  } else { }}
    <span class="label radius" data-d="{{d.contractDetail.contract.contractState}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.contractDetail.contract.contractState }}</span>
    {{#  } }}
</script>
<!--出库日期-->
<script type="text/html" id="exportDate">
    <span data-d="{{layui.util.toDateString(d.exportDate, 'yyyy-MM-dd')}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{layui.util.toDateString(d.exportDate, 'yyyy-MM-dd')}}</span>
</script>
<script type="text/html" id="stageExportDate">
    <span data-d="{{layui.util.toDateString(d.contractDetail.exportDate, 'yyyy-MM-dd')}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{layui.util.toDateString(d.contractDetail.exportDate, 'yyyy-MM-dd')}}</span>
</script>
<!--车识别码-->
<script type="text/html" id="vehicleNumber">
    <span data-d="{{d.vehicleNumber}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.vehicleNumber}}</span>
</script>
<script type="text/html" id="stageVehicleNumber">
    <span data-d="{{d.contractDetail.vehicleNumber}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.contractDetail.vehicleNumber}}</span>
</script>
<!--项目地址-->
<script type="text/html" id="projectAddress">
    <span data-d="{{d.projectAddress}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.projectAddress}}</span>
</script>
<script type="text/html" id="stageProjectAddress">
    <span data-d="{{d.contractDetail.projectAddress}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.contractDetail.projectAddress}}</span>
</script>
<!--型号-->
<script type="text/html" id="productMode">
    <span data-d="{{d.productMode}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.productMode}}</span>
</script>
<!--单价-->
<script type="text/html" id="productPrice">
    {{#  if(d.contract.contractType === '出售'){ }}
    <span data-d="{{d.productPrice}}元/台" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.productPrice }}元/台</span>
    {{#  } else { }}
    <span data-d="{{d.productPrice}}元/月/台" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.productPrice }}元/月/台</span>
    {{#  } }}
</script>
<!--押金-->
<script type="text/html" id="productDeposit">
    <span data-d="{{d.productDeposit}}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.productDeposit }}元</span>
</script>
<!--车辆代理详情-->
<script type="text/html" id="barDemo">
    <a href="javascript:void(0)" lay-event="vehicleDetailPop" data-d="车辆详情" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" style="text-decoration-line: underline" class="layui-table-link">车辆详情</a>
</script>
<!--代理车辆编号-->
<script type="text/html" id="vehicleID">
    <span data-d="{{d.id}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.id}}</span>
</script>
<!--代理车辆型号-->
<script type="text/html" id="vehicleMode">
    <span data-d="{{d.vehicleMode}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.vehicleMode}}</span>
</script>
<!--代理车辆数量-->
<script type="text/html" id="vehicleVolume">
    <span data-d="{{d.vehicleVolume}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.vehicleVolume }}台</span>
</script>
<!--代理车辆单价-->
<script type="text/html" id="vehiclePrice">
    <span data-d="{{d.vehiclePrice}}元/月/台" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.vehiclePrice }}元/月/台</span>
</script>
<!--代理车辆备注-->
<script type="text/html" id="vehicleDescription">
    <span data-d="{{d.vehicleDescription}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.vehicleDescription}}</span>
</script>
<!--耗材详情-->
<script type="text/html" id="supplyDescription">
    <span data-d="{{d.supplyDescription}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.supplyDescription}}</span>
</script>
<script type="text/html" id="stageSupplyDescription">
    <span data-d="{{d.contractDetail.supplyDescription}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.contractDetail.supplyDescription}}</span>
</script>
<!--销售日期-->
<script type="text/html" id="dateStage">
    {{# var fn = function(){
        return layui.util.toDateString(d.startDate, 'yyyy-MM-dd')+" ~ "+layui.util.toDateString(d.finalDate, 'yyyy-MM-dd');
    };}}
    <span data-d="{{ fn() }}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ fn() }}</span>
</script>
<script type="text/html" id="stageDateStage">
    {{# var fn = function(){
        return layui.util.toDateString(d.stageStartDate, 'yyyy-MM-dd')+" ~ "+layui.util.toDateString(d.stageEndDate, 'yyyy-MM-dd');
    };}}
    <span data-d="{{ fn() }}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ fn() }}</span>
</script>
<!--日期周期-->
<script type="text/html" id="dateCycle">
    {{# var fn = function(){
        return parseFloat(d.dateCycle.toString()).toFixed(1);
    };}}
    <span data-d="{{ fn() }}个月" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ fn() }}个月</span>
</script>
<script type="text/html" id="stageDateCycle">
    {{# var fn = function(){
        return parseFloat(d.stageDateCycle.toString()).toFixed(1);
    };}}
    <span data-d="{{ fn() }}个月" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ fn() }}个月</span>
</script>
<!--日期状态-->
<script type="text/html" id="dateState">
    {{# var fn = function(){
    var cur = new Date(Date.parse(layui.util.toDateString(new Date(), 'yyyy-MM-dd')));
    var end = new Date(Date.parse(layui.util.toDateString(d.finalDate, 'yyyy-MM-dd')));
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
<script type="text/html" id="stageDateState">
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
    {{#  } else{ }}
    <span data-d="{{ fn() }}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" style="color: #009688;" class="layui-table-label">{{ fn() }}</span>
    {{#  } }}
</script>
<!--应收金额-->
<script type="text/html" id="canPayQuota">
    <span data-d="{{ d.canPayQuota }}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.canPayQuota }}元</span>
</script>
<script type="text/html" id="stageCanPayQuota">
    <span data-d="{{ d.stageCanPayQuota }}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.stageCanPayQuota }}元</span>
</script>
<!--优惠金额-->
<script type="text/html" id="productDiscount">
    <span data-d="{{ d.productDiscount }}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.productDiscount }}元</span>
</script>
<script type="text/html" id="stageBadPayQuota">
    <span data-d="{{ d.stageBadPayQuota }}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.stageBadPayQuota }}元</span>
</script>
<!--已收金额-->
<script type="text/html" id="hasPayQuota">
    <span data-d="{{ d.hasPayQuota }}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.hasPayQuota }}元</span>
</script>
<script type="text/html" id="stageHasPayQuota">
    <span data-d="{{ d.stageHasPayQuota }}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.stageHasPayQuota }}元</span>
</script>
<!--未收金额-->
<script type="text/html" id="unPayQuota">
    <span data-d="{{ d.unPayQuota }}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.unPayQuota }}元</span>
</script>
<script type="text/html" id="stageUnPayQuota">
    <span data-d="{{ d.stageUnPayQuota }}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.stageUnPayQuota }}元</span>
</script>
<!--付款状态-->
<script type="text/html" id="payState">
    {{#  if(d.payState === "已付清"){ }}
    <span  class="label label-success radius" data-d="{{ d.payState }}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.payState }}</span>
    {{#  } else { }}
    <span  class="label label-default radius" data-d="{{ d.payState }}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.payState }}</span>
    {{#  } }}
</script>
<script type="text/html" id="stagePayState">
    {{#  if(d.stagePayState === "已付清"){ }}
    <span  class="label label-success radius" data-d="{{ d.stagePayState }}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.stagePayState }}</span>
    {{#  } else { }}
    <span  class="label label-default radius" data-d="{{ d.stagePayState }}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()">{{ d.stagePayState }}</span>
    {{#  } }}
</script>
<!--售后人员-->
<script type="text/html" id="salePerson">
    <span data-d="{{d.salePerson}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.salePerson}}</span>
</script>
<!--是否开票-->
<script type="text/html" id="hasBill">
    <input type="checkbox" data-d="{{d.hasBill==1?'已开票':'未开票' }}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" lay-skin="switch" lay-text="已开票|未开票" {{ d.hasBill==1?'checked':'' }} disabled>
</script>
<script type="text/html" id="stageHasBill">
    <input type="checkbox" data-d="{{d.stageHasBill==1?'已开票':'未开票' }}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" lay-skin="switch" lay-text="已开票|未开票" {{ d.stageHasBill==1?'checked':'' }} disabled>
</script>
<!--备注说明-->
<script type="text/html" id="contractDetailRemarkDescription">
    <span data-d="{{d.contractDetailRemarkDescription}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.contractDetailRemarkDescription}}</span>
</script>
<script type="text/html" id="stageRemarkDescription">
    <span data-d="{{d.stageRemarkDescription}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.stageRemarkDescription}}</span>
</script>
<script type="text/javascript" src="${ctx}/lib/jquery/3.5.1/jquery-3.5.1.js"></script>
<script type="text/javascript" src="${ctx}/lib/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/lib/media/js/tk.js" charset="utf-8"></script>
<script type="text/javascript">
    // lay加载
    layui.use(['form','element'], function () {
        let form = layui.form;
        let element = layui.element;
        var i = 2;  // 默认切换
        element.tabChange('remindPopTab', i);
        var customerID = -1;
        rentAlert('LAY_table_user'+i,customerID);//默认显示租赁到期选项
        // 监听Tab切换状态
        element.on('tab(remindPopTab)', function () {
            i = this.getAttribute('lay-id');
            var obj = $('#customerIDFilter').val();
            if(obj!=null && obj!=""){
                customerID = obj;
            }else{
                customerID=-1;
            }
            if (i == 1) {
                agentAlert('LAY_table_user'+i,customerID);
            } else if (i == 2) {
                rentAlert('LAY_table_user'+i,customerID);
            } else if (i == 3) {
                agentBackAlert('LAY_table_user'+i,customerID);
            } else if (i == 4) {
                rentBackAlert('LAY_table_user'+i,customerID);
            } else if (i == 5) {
                saleBackAlert('LAY_table_user'+i,customerID);
            }
        });
        //刷新
        form.on('select(customerIDFilter)', function (data) {
            var obj = data.value;
            if(obj!=null && obj!=""){
                customerID = obj;
            }else{
                customerID=-1;
            }
            if (i == 1) {
                agentAlert('LAY_table_user'+i,customerID);
            } else if (i == 2) {
                rentAlert('LAY_table_user'+i,customerID);
            } else if (i == 3) {
                agentBackAlert('LAY_table_user'+i,customerID);
            } else if (i == 4) {
                rentBackAlert('LAY_table_user'+i,customerID);
            } else if (i == 5) {
                saleBackAlert('LAY_table_user'+i,customerID);
            }
        });
        // 客户
        $.ajax({
            url: '${pageContext.request.contextPath }/customer/getList',
            method: 'post',
            data: JSON.stringify({}),
            contentType: "application/json;charset=UTF-8",
            dataType: "json",
            success: function (data) {
                $('#customerIDFilter').empty();
                $('#customerIDFilter').append(new Option("全部", ""));
                $.each(data, function (index, item) {
                    $('#customerIDFilter').append(new Option(item.customerName, item.id));
                });
                form.render("select");
            }, error: function (data) {
                $('#customerIDFilter').empty();
                $('#customerIDFilter').append(new Option("全部", ""));
                form.render("select");
            }
        });
    });

    // 代理到期预警
    function agentAlert(elem,customerID){
        layui.use(['form', 'table'], function () {
            let form = layui.form;
            let table = layui.table;
            // 初始化表格
            table.render({
                elem: '#' + elem // 指定表格
                , id: elem
                , url: '${pageContext.request.contextPath }/contractDetailRemind/1/'+customerID//数据请求路径
                , method: 'post'
                , contentType: "application/json;charset=UTF-8"
                , where: {
                    payState:'未付清',//设置付款状态
                    isDeadLine:1,//设置到期检查
                }
                , size: 'lg' //sm小尺寸的表格 lg大尺寸
                , cellMinWidth: 150 // 表格单元格最小宽度
                , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                , defaultToolbar: ['filter', 'exports', 'print']
                , cols: [[
                    {
                        field: 'customerName',
                        title: '合同客户',
                        minWidth:240,
                        sort: true,
                        align: 'center',
                        templet: '#customerName'
                    }
                    , {
                        field: 'contractNumber',
                        title: '合同编号',
                        hide:true,
                        sort: true,
                        align: 'center',
                        templet: '#contractNumber'
                    }
                    , {
                        field: 'contractType',
                        title: '合同类型',
                        hide:true,
                        sort: true,
                        align: 'center',
                        templet: '#contractType'
                    }
                    , {
                        field: 'contractState',
                        title: '合同状态',
                        hide: true,
                        sort: true,
                        align: 'center',
                        templet: '#contractState'
                    }
                    , {
                        field: 'exportDate',
                        title: '出库日期',
                        hide:true,
                        sort: true,
                        align: 'center',
                        templet: "#exportDate"
                    }
                    , {
                        field: 'vehicleDetailPop',
                        title: '车辆详情',
                        sort: true,
                        align: 'center',
                        toolbar: "#barDemo"
                    }
                    , {
                        field: 'productDeposit',
                        title: '代理押金',
                        hide:true,
                        sort: true,
                        align: 'center',
                        templet: "#productDeposit"
                    }
                    , {
                        field: 'supplyDescription',
                        title: '耗材详情',
                        minWidth:300,
                        sort: true,
                        align: 'center',
                        templet: "#supplyDescription"
                    }
                    , {
                        field: 'dateStage',
                        title: '代理日期',
                        minWidth:240,
                        sort: true,
                        align: 'center',
                        templet: "#dateStage"
                    }
                    , {
                        field: 'dateCycle',
                        title: '代理周期',
                        hide:true,
                        sort: true,
                        align: 'center',
                        templet: "#dateCycle"
                    }
                    , {
                        field: 'dateState',
                        title: '代理状态',
                        sort: true,
                        align: 'center',
                        templet: '#dateState'
                    }
                    , {
                        field: 'canPayQuota',
                        title: '应收金额',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#canPayQuota"
                    }
                    , {
                        field: 'productDiscount',
                        title: '优惠金额',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#productDiscount"
                    }
                    , {
                        field: 'hasPayQuota',
                        title: '已收金额',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#hasPayQuota"
                    }
                    , {
                        field: 'unPayQuota',
                        title: '未收金额',
                        sort: true,
                        align: 'center',
                        templet: "#unPayQuota"
                    }
                    , {
                        field: 'payState',
                        title: '付款状态',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#payState'
                    }
                    , {
                        field: 'salePerson',
                        title: '售后人员',
                        sort: true,
                        align: 'center',
                        templet: '#salePerson'
                    }
                    , {
                        field: 'hasBill',
                        title: '是否开票',
                        sort: true,
                        align: 'center',
                        templet: '#hasBill'
                    }
                    , {
                        field: 'contractDetailRemarkDescription',
                        title: '备注说明',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#contractDetailRemarkDescription'
                    }
                ]]
                , page: true  //开启分页
                , limit: 10   //默认十条数据一页
                , limits: [5, 10, 15, 20, 25, 30] //数据分页条
                , response: {
                    statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                }
            });
            //监听行工具事件
            table.on('tool('+elem+')', function(obj){
                let dataRow = obj.data;
                switch (obj.event) {
                    case "vehicleDetailPop":
                        var _funbtnxs = {
                            yesxs1: function (index, layero) {
                                layer.close(index);
                            }, xs2: function (index, layero) {
                                layer.close(index);
                            }, success: function (layero) {
                                table.render({
                                    elem: '#LAY_table_user6'
                                    , id: 'LAY_table_user6'
                                    , url: '${pageContext.request.contextPath }/vehicleDetail/searchAll' //数据请求路径
                                    , method: 'post'
                                    , contentType: "application/json;charset=UTF-8"
                                    , where: { contractDetailID : dataRow.id }
                                    , size: 'lg' //sm小尺寸的表格 lg大尺寸
                                    , cols: [[
                                        {
                                            field: 'id',
                                            title: 'ID',
                                            sort: true,
                                            align: 'center',
                                            templet: '#vehicleID'
                                        }
                                        , {
                                            field: 'vehicleMode',
                                            title: '型号',
                                            sort: true,
                                            align: 'center',
                                            templet: "#vehicleMode"
                                        }
                                        , {
                                            field: 'vehicleVolume',
                                            title: '数量',
                                            sort: true,
                                            align: 'center',
                                            templet: "#vehicleVolume"
                                        }
                                        , {
                                            field: 'vehiclePrice',
                                            title: '价格',
                                            sort: true,
                                            align: 'center',
                                            templet: '#vehiclePrice'
                                        }
                                        , {
                                            field: 'vehicleDescription',
                                            title: '备注',
                                            sort: true,
                                            align: 'center',
                                            templet: '#vehicleDescription'
                                        }
                                    ]]
                                    , page: false  //关闭分页
                                    , response: {
                                        statusCode: 200 //重新规定成功的状态码为 200
                                    }
                                });
                            }
                        }
                        tk('<div>【'+dataRow.contract.customer.customerName+'】代理车辆详情</div>', ['50%', '50%'], 'userbjPop', $("#bjnrPop"), ['关闭'], _funbtnxs);
                        break;
                }
            });
        });
    }

    // 代理阶段预警
    function agentBackAlert(elem,customerID){
        layui.use(['form', 'table'], function () {
            let form = layui.form;
            let table = layui.table;
            // 初始化表格
            table.render({
                elem: '#' + elem  // 指定表格
                , id: elem
                , url: '${pageContext.request.contextPath }/stageRemind/2/'+customerID //数据请求路径
                , method: 'post'
                , contentType: "application/json;charset=UTF-8"
                , where: {
                    stagePayState:'未付清',//设置付款状态
                    isDeadLine:1,//设置到期检查
                }
                , size: 'lg' //sm小尺寸的表格 lg大尺寸
                , cellMinWidth: 150 // 表格单元格最小宽度
                , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                , defaultToolbar: ['filter', 'exports', 'print']
                , cols: [[
                    {
                        field: 'stageCustomerName',
                        title: '合同客户',
                        sort: true,
                        minWidth:240,
                        align: 'center',
                        templet: '#stageCustomerName'
                    }
                    , {
                        field: 'stageContractNumber',
                        title: '合同编号',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#stageContractNumber'
                    }
                    , {
                        field: 'stageContractType',
                        title: '合同类型',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#stageContractType'
                    }
                    , {
                        field: 'stageContractState',
                        title: '合同状态',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#stageContractState'
                    }
                    , {
                        field: 'stageExportDate',
                        title: '出库日期',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#stageExportDate'
                    }
                    , {
                        field: 'stageVehicleDetailPop',
                        title: '车辆详情',
                        sort: true,
                        align: 'center',
                        toolbar: "#barDemo"
                    }
                    , {
                        field: 'stageSupplyDescription',
                        title: '耗材详情',
                        sort: true,
                        minWidth:300,
                        align: 'center',
                        templet: "#stageSupplyDescription"
                    }
                    , {
                        field: 'stageDateStage',
                        title: '阶段日期',
                        sort: true,
                        minWidth:240,
                        align: 'center',
                        templet: "#stageDateStage"
                    }
                    , {
                        field: 'stageDateCycle',
                        title: '阶段周期',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#stageDateCycle"
                    }
                    , {
                        field: 'stageDateState',
                        title: '阶段状态',
                        sort: true,
                        align: 'center',
                        templet: '#stageDateState'
                    }
                    , {
                        field: 'stageCanPayQuota',
                        title: '应收金额',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#stageCanPayQuota"
                    }
                    , {
                        field: 'stageBadPayQuota',
                        title: '坏账金额',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#stageBadPayQuota"
                    }
                    , {
                        field: 'stageHasPayQuota',
                        title: '已收金额',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#stageHasPayQuota"
                    }
                    , {
                        field: 'stageUnPayQuota',
                        title: '未收金额',
                        sort: true,
                        align: 'center',
                        templet: "#stageUnPayQuota"
                    }
                    , {
                        field: 'stagePayState',
                        title: '付款状态',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#stagePayState'
                    }
                    , {
                        field: 'stageHasBill',
                        title: '是否开票',
                        sort: true,
                        align: 'center',
                        templet: '#stageHasBill'
                    }
                    , {
                        field: 'stageRemarkDescription',
                        title: '备注说明',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#stageRemarkDescription'
                    }
                ]]
                , page: true  //开启分页
                , limit: 10   //默认十条数据一页
                , limits: [5, 10, 15, 20, 25, 30] //数据分页条
                , response: {
                    statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                }
            });
            //监听行工具事件
            table.on('tool('+elem+')', function(obj){
                let dataRow = obj.data;
                switch (obj.event) {
                    case "vehicleDetailPop":
                        var _funbtnxs = {
                            yesxs1: function (index, layero) {
                                layer.close(index);
                            }, xs2: function (index, layero) {
                                layer.close(index);
                            }, success: function (layero) {
                                table.render({
                                    elem: '#LAY_table_user6'
                                    , id: 'LAY_table_user6'
                                    , url: '${pageContext.request.contextPath }/vehicleDetail/searchAll' //数据请求路径
                                    , method: 'post'
                                    , contentType: "application/json;charset=UTF-8"
                                    , where: { contractDetailID : dataRow.contractDetailID }
                                    , size: 'lg' //sm小尺寸的表格 lg大尺寸
                                    , cols: [[
                                        {
                                            field: 'id',
                                            title: 'ID',
                                            sort: true,
                                            align: 'center',
                                            templet: '#vehicleID'
                                        }
                                        , {
                                            field: 'vehicleMode',
                                            title: '型号',
                                            sort: true,
                                            align: 'center',
                                            templet: "#vehicleMode"
                                        }
                                        , {
                                            field: 'vehicleVolume',
                                            title: '数量',
                                            sort: true,
                                            align: 'center',
                                            templet: "#vehicleVolume"
                                        }
                                        , {
                                            field: 'vehiclePrice',
                                            title: '价格',
                                            sort: true,
                                            align: 'center',
                                            templet: '#vehiclePrice'
                                        }
                                        , {
                                            field: 'vehicleDescription',
                                            title: '备注',
                                            sort: true,
                                            align: 'center',
                                            templet: '#vehicleDescription'
                                        }
                                    ]]
                                    , page: false  //关闭分页
                                    , response: {
                                        statusCode: 200 //重新规定成功的状态码为 200
                                    }
                                });
                            }
                        }
                        tk('<div>【'+dataRow.contractDetail.contract.customer.customerName+'】代理车辆详情</div>', ['50%', '50%'], 'userbjPop', $("#bjnrPop"), ['关闭'], _funbtnxs);
                        break;
                }
            });
        });
    }

    // 租赁到期预警
    function rentAlert(elem,customerID){
        layui.use(['form', 'table'], function () {
            let form = layui.form;
            let table = layui.table;
            // 初始化表格
            table.render({
                elem: '#' + elem  // 指定表格
                , id: elem
                , url: '${pageContext.request.contextPath }/contractDetailRemind/2/'+customerID //数据请求路径
                , method: 'post'
                , contentType: "application/json;charset=UTF-8"
                , where: {
                    payState:'未付清',//设置付款状态
                    isDeadLine:1,//设置到期检查
                }
                , size: 'lg' //sm小尺寸的表格 lg大尺寸
                , cellMinWidth: 150 // 表格单元格最小宽度
                , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                , defaultToolbar: ['filter', 'exports', 'print']
                , cols: [[
                    {
                        field: 'customerName',
                        title: '合同客户',
                        sort: true,
                        minWidth:240,
                        align: 'center',
                        templet: '#customerName'
                    }
                    ,{
                        field: 'contractNumber',
                        title: '合同编号',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#contractNumber'
                     }
                     , {
                        field: 'contractType',
                        title: '合同类型',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#contractType'
                     }
                    , {
                        field: 'contractState',
                        title: '合同状态',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#contractState'
                    }
                     , {
                        field: 'exportDate',
                        title: '出库日期',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#exportDate"
                     }
                     ,{
                        field: 'vehicleNumber',
                        title: '车识别码',
                        sort: true,
                        align: 'center',
                        templet: '#vehicleNumber'
                    }
                    , {
                        field: 'projectAddress',
                        title: '项目地址',
                        sort: true,
                        align: 'center',
                        templet: "#projectAddress"
                    }
                    , {
                        field: 'productMode',
                        title: '型号',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#productMode"
                    }
                    , {
                        field: 'productPrice',
                        title: '价格',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#productPrice'
                    }
                    , {
                        field: 'productDeposit',
                        title: '押金',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#productDeposit"
                    }
                    , {
                        field: 'supplyDescription',
                        title: '耗材详情',
                        sort: true,
                        minWidth:300,
                        align: 'center',
                        templet: "#supplyDescription"
                    }
                    , {
                        field: 'dateStage',
                        title: '租赁日期',
                        sort: true,
                        minWidth:240,
                        align: 'center',
                        templet: "#dateStage"
                    }
                    , {
                        field: 'dateCycle',
                        title: '租赁周期',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#dateCycle"
                    }
                    , {
                        field: 'dateState',
                        title: '租赁状态',
                        sort: true,
                        align: 'center',
                        templet: '#dateState'
                    }
                    , {
                        field: 'canPayQuota',
                        title: '应收金额',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#canPayQuota"
                    }
                    , {
                        field: 'productDiscount',
                        title: '优惠金额',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#productDiscount"
                    }
                    , {
                        field: 'hasPayQuota',
                        title: '已收金额',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#hasPayQuota"
                    }
                    , {
                        field: 'unPayQuota',
                        title: '未收金额',
                        sort: true,
                        align: 'center',
                        templet: "#unPayQuota"
                    }
                    , {
                        field: 'payState',
                        title: '付款状态',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#payState'
                    }
                    , {
                        field: 'salePerson',
                        title: '售后人员',
                        sort: true,
                        align: 'center',
                        templet: '#salePerson'
                    }
                    , {
                        field: 'hasBill',
                        title: '是否开票',
                        sort: true,
                        align: 'center',
                        templet: '#hasBill'
                    }
                    , {
                        field: 'contractDetailRemarkDescription',
                        title: '备注说明',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#contractDetailRemarkDescription'
                    }
                ]]
                , page: true  //开启分页
                , limit: 10   //默认十条数据一页
                , limits: [5, 10, 15, 20, 25, 30] //数据分页条
                , response: {
                    statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                }
            });
        });
    }

    // 租赁阶段预警
    function rentBackAlert(elem,customerID){
        layui.use(['form', 'table'], function () {
            let form = layui.form;
            let table = layui.table;
            // 初始化表格
            table.render({
                elem: '#' + elem  // 指定表格
                , id: elem
                , url: '${pageContext.request.contextPath }/stageRemind/1/'+customerID //数据请求路径
                , method: 'post'
                , contentType: "application/json;charset=UTF-8"
                , where: {
                    stagePayState:'未付清',//设置付款状态
                    isDeadLine:1,//设置到期检查
                }
                , size: 'lg' //sm小尺寸的表格 lg大尺寸
                , cellMinWidth: 150 // 表格单元格最小宽度
                , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                , defaultToolbar: ['filter', 'exports', 'print']
                , cols: [[
                    {
                        field: 'stageCustomerName',
                        title: '合同客户',
                        sort: true,
                        minWidth:240,
                        align: 'center',
                        templet: '#stageCustomerName'
                    }
                    , {
                        field: 'stageContractNumber',
                        title: '合同编号',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#stageContractNumber'
                    }
                    , {
                        field: 'stageContractType',
                        title: '合同类型',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#stageContractType'
                    }
                    , {
                        field: 'stageContractState',
                        title: '合同状态',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#stageContractState'
                    }
                    , {
                        field: 'stageExportDate',
                        title: '出库日期',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#stageExportDate'
                    }
                    ,{
                        field: 'stageVehicleNumber',
                        title: '车识别码',
                        sort: true,
                        align: 'center',
                        templet: '#stageVehicleNumber'
                    }
                    , {
                        field: 'stageProjectAddress',
                        title: '项目地址',
                        sort: true,
                        align: 'center',
                        templet: "#stageProjectAddress"
                    }
                    , {
                        field: 'stageSupplyDescription',
                        title: '耗材详情',
                        sort: true,
                        minWidth:300,
                        align: 'center',
                        templet: "#stageSupplyDescription"
                    }
                    , {
                        field: 'stageDateStage',
                        title: '阶段日期',
                        sort: true,
                        minWidth:240,
                        align: 'center',
                        templet: "#stageDateStage"
                    }
                    , {
                        field: 'stageDateCycle',
                        title: '阶段周期',
                        hide:true,
                        sort: true,
                        align: 'center',
                        templet: "#stageDateCycle"
                    }
                    , {
                        field: 'stageDateState',
                        title: '阶段状态',
                        sort: true,
                        align: 'center',
                        templet: '#stageDateState'
                    }
                    , {
                        field: 'stageCanPayQuota',
                        title: '应收金额',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#stageCanPayQuota"
                    }
                    , {
                        field: 'stageBadPayQuota',
                        title: '坏账金额',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#stageBadPayQuota"
                    }
                    , {
                        field: 'stageHasPayQuota',
                        title: '已收金额',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#stageHasPayQuota"
                    }
                    , {
                        field: 'stageUnPayQuota',
                        title: '未收金额',
                        sort: true,
                        align: 'center',
                        templet: "#stageUnPayQuota"
                    }
                    , {
                        field: 'stagePayState',
                        title: '付款状态',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#stagePayState'
                    }
                    , {
                        field: 'stageHasBill',
                        title: '是否开票',
                        sort: true,
                        align: 'center',
                        templet: '#stageHasBill'
                    }
                    , {
                        field: 'stageRemarkDescription',
                        title: '备注说明',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#stageRemarkDescription'
                    }
                ]]
                , page: true  //开启分页
                , limit: 10   //默认十条数据一页
                , limits: [5, 10, 15, 20, 25, 30] //数据分页条
                , response: {
                    statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                }
            });
        });
    }

    // 出售回款预警
    function saleBackAlert(elem,customerID){
        layui.use(['form', 'table'], function () {
            let form = layui.form;
            let table = layui.table;
            // 初始化表格
            table.render({
                elem: '#' + elem  // 指定表格
                , id: elem
                , url: '${pageContext.request.contextPath }/contractDetailRemind/3/'+customerID //数据请求路径
                , method: 'post'
                , contentType: "application/json;charset=UTF-8"
                , where: {
                    payState:'未付清'//设置付款状态
                }
                , size: 'lg' //sm小尺寸的表格 lg大尺寸
                , cellMinWidth: 150 // 表格单元格最小宽度
                , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                , defaultToolbar: ['filter', 'exports', 'print']
                , cols: [[
                    {
                        field: 'customerName',
                        title: '合同客户',
                        sort: true,
                        minWidth:240,
                        align: 'center',
                        templet: '#customerName'
                    }
                    , {
                        field: 'contractNumber',
                        title: '合同编号',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#contractNumber'
                    }
                    , {
                        field: 'contractType',
                        title: '合同类型',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#contractType'
                    }
                    , {
                        field: 'contractState',
                        title: '合同状态',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#contractState'
                    }
                    , {
                        field: 'exportDate',
                        title: '出库日期',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#exportDate"
                    }
                    ,{
                        field: 'vehicleNumber',
                        title: '车识别码',
                        sort: true,
                        align: 'center',
                        templet: '#vehicleNumber'
                    }
                    , {
                        field: 'projectAddress',
                        title: '项目地址',
                        sort: true,
                        align: 'center',
                        templet: "#projectAddress"
                    }
                    , {
                        field: 'productMode',
                        title: '型号',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#productMode"
                    }
                    , {
                        field: 'productPrice',
                        title: '价格',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#productPrice'
                    }
                    , {
                        field: 'productDeposit',
                        title: '押金',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#productDeposit"
                    }
                    , {
                        field: 'supplyDescription',
                        title: '耗材详情',
                        sort: true,
                        minWidth:300,
                        align: 'center',
                        templet: "#supplyDescription"
                    }
                    , {
                        field: 'canPayQuota',
                        title: '应收金额',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#canPayQuota"
                    }
                    , {
                        field: 'productDiscount',
                        title: '优惠金额',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#productDiscount"
                    }
                    , {
                        field: 'hasPayQuota',
                        title: '已收金额',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: "#hasPayQuota"
                    }
                    , {
                        field: 'unPayQuota',
                        title: '未收金额',
                        sort: true,
                        align: 'center',
                        templet: "#unPayQuota"
                    }
                    , {
                        field: 'payState',
                        title: '付款状态',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#payState'
                    }
                    , {
                        field: 'salePerson',
                        title: '售后人员',
                        sort: true,
                        align: 'center',
                        templet: '#salePerson'
                    }
                    , {
                        field: 'hasBill',
                        title: '是否开票',
                        sort: true,
                        align: 'center',
                        templet: '#hasBill'
                    }
                    , {
                        field: 'contractDetailRemarkDescription',
                        title: '备注说明',
                        sort: true,
                        hide:true,
                        align: 'center',
                        templet: '#contractDetailRemarkDescription'
                    }
                ]]
                , page: true  //开启分页
                , limit: 10   //默认十条数据一页
                , limits: [5, 10, 15, 20, 25, 30] //数据分页条
                , response: {
                    statusCode: 200 //重新规定成功的状态码为 200，table 组件默认为 0
                }
            });
        });
    }
</script>
</body>
</html>