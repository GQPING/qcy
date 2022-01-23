<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../other/meta.html"%>
    <%@include file="../../other/style.html" %>
</head>
<body>
<div>
    <nav class="breadcrumb">
        <i class="Hui-iconfont">&#xe67f;</i> 首页
        <span class="c-gray en">&gt;</span> 合同管理
        <span class="c-gray en">&gt;</span> ${type}合同
        <span class="c-gray en">&gt;</span> 合同明细
        <span class="c-gray en">&gt;</span> 车辆信息
        <a class="btn btn-success radius r" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);"><i class="Hui-iconfont">&#xe68f;</i></a>
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
<!--车辆编号-->
<script type="text/html" id="vehicleIDTpl">
    <span data-d="{{d.id}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.id}}</span>
</script>
<!--车辆型号-->
<script type="text/html" id="vehicleModeTpl">
    <span data-d="{{d.vehicleMode}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.vehicleMode}}</span>
</script>
<!--车辆数量-->
<script type="text/html" id="vehicleVolumeTpl">
    <span data-d="{{d.vehicleVolume}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.vehicleVolume }}台</span>
</script>
<!--车辆单价-->
<script type="text/html" id="vehiclePriceTpl">
    <span data-d="{{d.vehiclePrice}}元/月/台" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{ d.vehiclePrice }}元/月/台</span>
</script>
<!--车辆备注-->
<script type="text/html" id="vehicleDescriptionTpl">
    <span data-d="{{d.vehicleDescription}}" onmouseover="show_shopm(this)" onmouseout="exit_shopm()" class="layui-table-label">{{d.vehicleDescription}}</span>
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
                layui.use(['form', 'table'], function () {
                    let form = layui.form;
                    let table = layui.table;
                    // 初始化表格
                    table.render({
                        elem: '#LAY_table_user'
                        , id: 'LAY_table_user'
                        , url: '${pageContext.request.contextPath }/vehicleDetail/searchAll' //数据请求路径
                        , method: 'post'
                        , contentType: "application/json;charset=UTF-8"
                        , where: { contractDetailID : "${contractDetailID}" }
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
                                align: 'center',
                                templet: '#xuhao'
                            }
                            , {
                                field: 'vehicleMode',
                                title: '型号',
                                align: 'center',
                                templet: "#vehicleModeTpl"
                            }
                            , {
                                field: 'vehicleVolume',
                                title: '数量',
                                align: 'center',
                                templet: "#vehicleVolumeTpl"
                            }
                            , {
                                field: 'vehiclePrice',
                                title: '价格',
                                align: 'center',
                                templet: '#vehiclePriceTpl'
                            }
                            , {
                                field: 'vehicleDescription',
                                title: '备注',
                                align: 'center',
                                templet: '#vehicleDescriptionTpl'
                            }
                        ]]
                        , page: false  //关闭分页
                        , response: {
                            statusCode: 200 //重新规定成功的状态码为 200
                        }
                    });
                    //头工具栏事件
                    table.on('toolbar(LAY_table_user)', function(obj){
                        var checkStatus = table.checkStatus(obj.config.id); //获取选中行状态
                        switch(obj.event){
                            case 'create':
                                if(origin.contract.contractState!="正常"){
                                    layer.msg('合同处于终止状态', {icon: 0, time: 1000, anim: 6});
                                    return false;
                                }
                                var _funbtnxs = {
                                    yesxs1: function (index, layero) {
                                        var vehicleMode = $("#vehicleModeInput").val().trim();
                                        if (vehicleMode == "") {
                                            layer.msg('请选择车辆型号', {icon: 0, time: 1000, anim: 6});
                                            return false;
                                        }
                                        var vehicleVolume = $("#vehicleVolume").val().trim();
                                        if (vehicleVolume == "") {
                                            layer.msg('请输入车辆数量', {icon: 0, time: 1000, anim: 6});
                                            return false;
                                        }
                                        if(vehicleVolume == "0"){
                                            layer.msg('车辆数量至少为1', {icon: 0, time: 1000, anim: 6});
                                            return false;
                                        }
                                        var vehiclePrice = $("#vehiclePrice").val().trim();
                                        if (vehiclePrice == "") {
                                            layer.msg('请输入车辆单价', {icon: 0, time: 1000, anim: 6});
                                            return false;
                                        }
                                        var vehicleDescription = $("#vehicleDescription").val().trim();
                                        $.ajax({
                                            type: 'post',
                                            url: '${pageContext.request.contextPath }/vehicleDetail/add',
                                            data: JSON.stringify({
                                                contractDetailID: "${contractDetailID}",
                                                vehicleMode: vehicleMode.toUpperCase(),
                                                vehicleVolume: vehicleVolume,
                                                vehiclePrice: vehiclePrice,
                                                vehicleDescription: vehicleDescription
                                            }),
                                            contentType: "application/json;charset=UTF-8",
                                            dataType: "json",
                                            success: function (data) {
                                                layer.msg('添加成功!', {
                                                    icon: 1, time: 1000, end: function () {
                                                        //location.reload();
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
                                        $("#vehicleMode").val('QT1000C');
                                        form.render('select');
                                        $("#vehicleModeInput").val('QT1000C');
                                        document.getElementById("vehicleModeInput").style.display="none";
                                        $("#vehicleVolume").val('1');
                                        $("#vehiclePrice").val('0');
                                        $("#vehicleDescription").val('');
                                    }
                                }
                                tk('添加代理车辆', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '关闭'], _funbtnxs);
                                // 下拉框值改变动态设置其它输入
                                form.on('select(vehicleMode)', function (data) {
                                    if(data.value == "其它__") {
                                        $("#vehicleModeInput").val('');
                                        document.getElementById("vehicleModeInput").style.display="";
                                    } else{
                                        $("#vehicleModeInput").val(data.value);
                                        document.getElementById("vehicleModeInput").style.display="none";
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
                                        var vehicleMode = $("#vehicleModeInput").val().trim();
                                        if (vehicleMode == "") {
                                            layer.msg('请选择车辆型号', {icon: 0, time: 1000, anim: 6});
                                            return false;
                                        }
                                        var vehicleVolume = $("#vehicleVolume").val().trim();
                                        if (vehicleVolume == "") {
                                            layer.msg('请输入车辆数量', {icon: 0, time: 1000, anim: 6});
                                            return false;
                                        }
                                        var vehiclePrice = $("#vehiclePrice").val().trim();
                                        if (vehiclePrice == "") {
                                            layer.msg('请输入车辆单价', {icon: 0, time: 1000, anim: 6});
                                            return false;
                                        }
                                        var vehicleDescription = $("#vehicleDescription").val().trim();
                                        $.ajax({
                                            type: 'post',
                                            url: '${pageContext.request.contextPath }/vehicleDetail/update',
                                            data: JSON.stringify({
                                                id: dataRow[0].id,
                                                vehicleMode: vehicleMode.toUpperCase(),
                                                vehicleVolume: vehicleVolume,
                                                vehiclePrice: vehiclePrice,
                                                vehicleDescription: vehicleDescription
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
                                        $("#vehicleMode").val(dataRow[0].vehicleMode);
                                        $("#vehicleModeInput").val(dataRow[0].vehicleMode);
                                        if($("#vehicleMode").val()==null || $("#vehicleMode").val()==""){
                                            $("#vehicleMode").val("其它__");
                                            document.getElementById("vehicleModeInput").style.display="";
                                        }else{
                                            document.getElementById("vehicleModeInput").style.display="none";
                                        }
                                        form.render('select');
                                        $("#vehicleVolume").val(dataRow[0].vehicleVolume);
                                        $("#vehiclePrice").val(dataRow[0].vehiclePrice);
                                        $("#vehicleDescription").val(dataRow[0].vehicleDescription);
                                    }
                                }
                                tk('修改代理车辆', ['100%', '100%'], 'userbj', $("#bjnr"), ['确定', '关闭'], _funbtnxs);
                                // 下拉框值改变动态设置其它输入
                                form.on('select(vehicleMode)', function (data) {
                                    if(data.value == "其它__") {
                                        $("#vehicleModeInput").val('');
                                        document.getElementById("vehicleModeInput").style.display="";
                                    } else{
                                        $("#vehicleModeInput").val(data.value);
                                        document.getElementById("vehicleModeInput").style.display="none";
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
                                if(dataRow[0].contractcontract.contractState!="正常"){
                                    layer.msg('合同处于终止状态', {icon: 0, time: 1000, anim: 6});
                                    return false;
                                }
                                layer.confirm('确认要删除吗？', function (index) {
                                    $.ajax({
                                        type: 'post',
                                        url: '${pageContext.request.contextPath }/vehicleDetail/delete',
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
                        };
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
            data: JSON.stringify({id:'${sessionScope.CurrentUser.roleID}',menuNameString:'车辆信息'}),
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
    <form class="layui-form" id="form-validate">
        <table class="layui-table layui-xs" lay-skin="nob">
            <tbody>
            <tr>
                <td align="right" width="90">车辆型号：</td>
                <td align="left">
                    <select class="layui-input" id="vehicleMode" placeholder="请选择" lay-filter="vehicleMode">
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
                    <input type="text" style="display: none" id="vehicleModeInput" autocomplete="off"
                           class="layui-input" placeholder="请输入">
                </td>
            </tr>
            <tr>
                <td align="right">车辆数量：<span style="margin-right: 22px">（台）</span></td>
                <td align="left">
                    <input type="text" id="vehicleVolume" autocomplete="off" class="layui-input" placeholder="请选择"
                           onblur="if(value=='')execCommand('undo')" Onkeyup="this.value=this.value.replace(/\D/g,'')" Onpaste="return false;">
                </td>
            </tr>
            <tr>
                <td align="right">车辆单价：<span style="margin-right: 0px;">（元/月/台）</span></td>
                <td align="left">
                    <input type="text" id="vehiclePrice" autocomplete="off" class="layui-input" placeholder="请选择"
                           onblur="if(value=='')execCommand('undo')" Onkeyup="if(isNaN(value))execCommand('undo')" Onpaste="return false;">
                </td>
            </tr>
            <tr>
                <td align="right">备注信息：</td>
                <td align="left">
                    <textarea rows="20" id="vehicleDescription" autocomplete="off" class="layui-textarea" placeholder="请输入"></textarea>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
</body>
</html>