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
        <span class="c-gray en">&gt;</span> 分期信息【<label id="stageLabelTitle"></label>】
        <span class="c-gray en">&gt;</span> 收款信息
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
<!--收款编号-->
<script type="text/html" id="cashIDTpl">
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
<!-- 收款方式 -->
<script type="text/html" id="payTypeTpl">
    <span data-d="{{d.payType}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.payType }}</span>
</script>
<!-- 收 款 人 -->
<script type="text/html" id="payPersonTpl">
    <span data-d="{{d.payPerson}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.payPerson }}</span>
</script>
<!-- 收款金额 -->
<script type="text/html" id="payQuotaTpl">
    <span data-d="{{d.payQuota}}元" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label" style="color: #009688;">{{ d.payQuota }}元</span>
</script>
<!-- 收款日期 -->
<script type="text/html" id="payDateTpl">
    <span data-d="{{layui.util.toDateString(d.payDate, 'yyyy-MM-dd')}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{layui.util.toDateString(d.payDate, 'yyyy-MM-dd')}}</span>
</script>
<!-- 收款说明 -->
<script type="text/html" id="cashRemarkDescriptionTpl">
    <span data-d="{{d.cashRemarkDescription}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.cashRemarkDescription}}</span>
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
                        elem: '#payDate' //指定元素
                    });
                    // 初始化表格
                    table.render({
                        elem: '#LAY_table_user' // 指定表格
                        , id: 'LAY_table_user'
                        , url: '${pageContext.request.contextPath }/cash/searchAll' //数据请求路径
                        , method: 'post'
                        , contentType: "application/json;charset=UTF-8"
                        , where: {
                            contractDetailID : "${contractDetailID}",
                            stageID : "${stageID}"
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
                                field: 'payType',
                                title: '收款方式',
                                sort:true,
                                align: 'center',
                                templet: '#payTypeTpl'
                            }
                            , {
                                field: 'payPerson',
                                unresize:true,
                                title: '收 款 人',
                                sort:true,
                                align: 'center',
                                templet: '#payPersonTpl'
                            }
                            , {
                                field: 'payQuota',
                                title: '收款金额',
                                sort:true,
                                align: 'center',
                                templet: "#payQuotaTpl"
                            }
                            , {
                                field: 'payDate',
                                title: '收款日期',
                                sort:true,
                                align: 'center',
                                templet: "#payDateTpl"
                            }
                            , {
                                field: 'cashRemarkDescription',
                                title: '收款说明',
                                sort:true,
                                align: 'center',
                                templet: '#cashRemarkDescriptionTpl'
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
                                        $.ajax({
                                            url: '${pageContext.request.contextPath }/stage/getById',
                                            method: 'post',
                                            data: {id: "${stageID}"},
                                            success: function (data) {
                                                if(data!=null) {
                                                    var obj = eval(data);
                                                    if(obj.stagePayState=='已付清'){
                                                        layer.msg('该分期已付清，请更换所属分期', {icon: 0, time: 1000, anim: 6});
                                                    }else{
                                                        var payType = $("#payType").val().trim();
                                                        if (payType == "") {
                                                            layer.msg('请选择收款方式', {icon: 0, time: 1000, anim: 6});
                                                            return false;
                                                        }
                                                        var payPerson = $("#payPerson").val().trim();
                                                        if (payPerson == "") {
                                                            layer.msg('请输入收款人', {icon: 0, time: 1000, anim: 6});
                                                            return false;
                                                        }
                                                        var payQuota = $("#payQuota").val().trim();
                                                        if (payQuota == "") {
                                                            layer.msg('请输入收款金额', {icon: 0, time: 1000, anim: 6});
                                                            return false;
                                                        }
                                                        var payDateStr = $("#payDate").val().trim();
                                                        if (payDateStr == "") {
                                                            layer.msg('请输入收款日期', {icon: 0, time: 1000, anim: 6});
                                                            return false;
                                                        }
                                                        var sdate0 = payDateStr.split('-');
                                                        var payDate = new Date(sdate0[0], sdate0[1]-1, sdate0[2]);//时分秒设置为0
                                                        var cashRemarkDescription = $("#cashRemarkDescription").val().trim();
                                                        $.ajax({
                                                            type: 'post',
                                                            url: "${pageContext.request.contextPath }/cash/add",
                                                            data: JSON.stringify({
                                                                contractDetailID: "${contractDetailID}",
                                                                stageID: "${stageID}",
                                                                payType:payType,
                                                                payPerson:payPerson,
                                                                payDate: payDate,
                                                                payQuota: payQuota,
                                                                cashRemarkDescription: cashRemarkDescription
                                                            }),
                                                            contentType: "application/json;charset=UTF-8",
                                                            dataType: "json",
                                                            success: function (data) {
                                                                layer.msg('添加成功!', {
                                                                    icon: 1, time: 1000, end: function () {
                                                                        location.reload();
                                                                    }
                                                                });
                                                            }, error: function (data) {
                                                                layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6});
                                                            }
                                                        });
                                                    }
                                                }
                                            }, error: function (data) {
                                                layer.msg('读取分期明细异常!', {icon: 5, time: 1000, anim: 6});
                                            }
                                        });
                                    }
                                    , xs2: function (index, layero) {
                                        layer.close(index);
                                    }, success: function (layero) {
                                        $("#payType").val('');
                                        $("#payPerson").val('');
                                        $("#payQuota").val('0');
                                        $("#payDate").val(layui.util.toDateString(new Date(), 'yyyy-MM-dd'));
                                        $("#cashRemarkDescription").val('');
                                        form.render('select');
                                    }
                                }
                                tk('添加收款信息', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '取消'], _funbtnxs);
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
                                        $.ajax({
                                            url: '${pageContext.request.contextPath }/stage/getById',
                                            method: 'post',
                                            data: {id: "${stageID}"},
                                            success: function (data) {
                                                if(data!=null) {
                                                    var obj = eval(data);
                                                    if(obj.stagePayState=='已付清'){
                                                        layer.msg('该分期已付清，请更换所属分期', {icon: 0, time: 1000, anim: 6});
                                                    }else{
                                                        var payType = $("#payType").val().trim();
                                                        if (payType == "") {
                                                            layer.msg('请选择收款方式', {icon: 0, time: 1000, anim: 6});
                                                            return false;
                                                        }
                                                        var payPerson = $("#payPerson").val().trim();
                                                        if (payPerson == "") {
                                                            layer.msg('请输入收款人', {icon: 0, time: 1000, anim: 6});
                                                            return false;
                                                        }
                                                        var payQuota = $("#payQuota").val().trim();
                                                        if (payQuota == "") {
                                                            layer.msg('请输入收款金额', {icon: 0, time: 1000, anim: 6});
                                                            return false;
                                                        }
                                                        var payDateStr = $("#payDate").val().trim();
                                                        if (payDateStr == "") {
                                                            layer.msg('请输入收款日期', {icon: 0, time: 1000, anim: 6});
                                                            return false;
                                                        }
                                                        var sdate0 = payDateStr.split('-');
                                                        var payDate = new Date(sdate0[0], sdate0[1]-1, sdate0[2]);//时分秒设置为0
                                                        var cashRemarkDescription = $("#cashRemarkDescription").val().trim();
                                                        $.ajax({
                                                            type: 'post',
                                                            url: "${pageContext.request.contextPath }/cash/update",
                                                            data: JSON.stringify({
                                                                id:dataRow[0].id,
                                                                contractDetailID: "${contractDetailID}",
                                                                stageID: "${stageID}",
                                                                payType:payType,
                                                                payPerson:payPerson,
                                                                payDate: payDate,
                                                                payQuota: payQuota,
                                                                cashRemarkDescription: cashRemarkDescription
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
                                                }
                                            }, error: function (data) {
                                                layer.msg('读取分期明细异常!', {icon: 5, time: 1000, anim: 6});
                                            }
                                        });
                                    }
                                    , xs2: function (index, layero) {
                                        layer.close(index);
                                    }, success: function (layero) {
                                        $("#payType").val(dataRow[0].payType);
                                        $("#payPerson").val(dataRow[0].payPerson);
                                        $("#payQuota").val(dataRow[0].payQuota);
                                        $("#payDate").val(layui.util.toDateString(dataRow[0].payDate, 'yyyy-MM-dd'));
                                        $("#cashRemarkDescription").val(dataRow[0].cashRemarkDescription);
                                        form.render('select');
                                    }
                                }
                                tk('修改收款信息', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '取消'], _funbtnxs);
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
                                        url: '${pageContext.request.contextPath }/cash/delete',
                                        data: {id: dataRow[0].id},
                                        success: function (data) {
                                            layer.msg('删除成功!', {
                                                icon: 1, time: 1000, end: function () {
                                                    location.reload();
                                                }
                                            });
                                        }, error: function (data) {
                                            layer.msg('服务器异常!', {icon: 5, time: 1000, anim: 6});
                                        },
                                    });
                                });
                                break;
                        };
                    });
                    //所属分期明细
                    $.ajax({
                        url: '${pageContext.request.contextPath }/stage/getById',
                        method: 'post',
                        data: {id: "${stageID}"},
                        success: function (data) {
                            if(data!=null) {
                                var obj = eval(data);
                                $("#projectLabelTitle").text(obj.contractDetail.projectAddress);
                                $("#stageLabelTitle").text(layui.util.toDateString(obj.stageStartDate, 'yyyy-MM-dd')+" ~ "+layui.util.toDateString(obj.stageEndDate, 'yyyy-MM-dd'));
                            }
                        }, error: function (data) {
                            layer.msg('读取分期明细异常!', {icon: 5, time: 1000, anim: 6});
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
            data: JSON.stringify({id:'${sessionScope.CurrentUser.roleID}',menuNameString:'收款信息'}),
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
                <td align="right" width="80">收款方式：</td>
                <td align="left">
                    <select class="layui-input" id="payType">
                        <option value="">请选择</option>
                        <option value="个人">个人</option>
                        <option value="对私">对私</option>
                        <option value="对公">对公</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="right"><label style="letter-spacing:0.5em;margin-right:-0.5em;">收款人</label>：</td>
                <td align="left">
                    <input type="text" id="payPerson" autocomplete="off" class="layui-input" placeholder="请输入">
                </td>
            </tr>
            <tr>
                <td align="right">收款金额：<span style="margin-right: 22px">（元）</span></td>
                <td align="left">
                    <input type="text" id="payQuota" autocomplete="off" class="layui-input" placeholder="请输入" onblur="if(value=='')execCommand('undo')" Onkeyup="if(isNaN(value))execCommand('undo')" Onpaste="return false;" >
                </td>
            </tr>
            <tr>
                <td align="right">收款日期：</td>
                <td align="left">
                    <input type="text" id="payDate" autocomplete="off" class="layui-input" placeholder="请选择日期">
                </td>
            </tr>
            <tr>
                <td align="right">收款说明：</td>
                <td align="left">
                    <textarea id="cashRemarkDescription" rows="20" autocomplete="off" class="layui-textarea" placeholder="请输入"></textarea>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>