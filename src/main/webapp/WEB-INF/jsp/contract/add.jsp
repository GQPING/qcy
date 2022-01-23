<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../other/meta.html"%>
    <%@include file="../other/style.html" %>
    <style type="text/css">
        em.error {
            font-size: 8px;
            color: red;
        }
    </style>
</head>
<body>
<div class="page-container">
    <form class="layui-form" id="form-validate">
        <table class="layui-table layui-xs" lay-skin="nob">
            <tbody>
            <tr>
                <td align="right" width="80">客  &nbsp;&nbsp;&nbsp;&nbsp; 户：</td>
                <td align="left">
                    <select class="layui-input" id="customerID" lay-verify="required" lay-search></select>
                </td>
            </tr>
            <tr>
                <td align="right">合同编号：</td>
                <td align="left">
                    <input type="text" id="contractNumber" name="contractNumber" autocomplete="off" lay-verify="required"
                           class="layui-input" placeholder="请输入" Onkeyup="this.value=this.value.replace(/[^\a-\z\A-\Z0-9]/g,'')">
                </td>
            </tr>
            <tr>
                <td align="right">合同类型：</td>
                <td align="left">
                    <select class="layui-input" lay-verify="required" id="contractType">
                        <option value="" selected>请选择</option>
                        <option value="租赁">租赁</option>
                        <option value="出售">出售</option>
                        <option value="代理商">代理商</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="right">签订日期：</td>
                <td align="left">
                    <input type="text" id="signDate" lay-verify="required" autocomplete="off" class="layui-input" placeholder="请选择日期">
                </td>
            </tr>
            <tr>
                <td align="right">市场人员：</td>
                <td align="left">
                    <select class="layui-input" id="marketPerson" lay-verify="required" lay-filter="marketPerson">
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
                           class="layui-input" lay-verify="required" placeholder="请输入">
                </td>
            </tr>
            <tr>
                <td align="right">收款银行：</td>
                <td align="left">
                    <select class="layui-input" id="contractPayBank" lay-verify="required" lay-filter="contractPayBank">
                        <option value="">请选择</option>
                        <option value="民生银行">民生银行</option>
                        <option value="中原银行">中原银行</option>
                        <option value="工商银行">工商银行</option>
                        <option value="其它__">其它__</option>
                    </select>
                    <input type="text" style="display: none" id="contractPayBankInput" autocomplete="off"
                           class="layui-input" lay-verify="required" placeholder="请输入">
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
        <button class="layui-btn layui-btn-fluid layui-btn-radius login-btn" lay-submit lay-filter="save">保存</button>
    </form>
</div>
<script type="text/javascript" src="${ctx}/lib/jquery/3.5.1/jquery-3.5.1.js"></script>
<script type="text/javascript" src="${ctx}/lib/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/lib/jquery.validation/1.14.0/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/lib/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="${ctx}/lib/jquery.validation/1.14.0/messages_zh.js"></script>
<script type="text/javascript">
    $(function () {
        jQuery.validator.addMethod("inputLimit",function(value, element){
            return /^[a-zA-Z][a-zA-Z0-9]*$/.test(value);
        },"只能包含字母、数字,且以字母开头!");
        var validator = $("#form-validate").validate({
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
        // lay加载
        layui.use(['layer', 'form', 'laydate'], function () {
            var form = layui.form, $ = layui.jquery,
                layer = layui.layer,laydate=layui.laydate;
            //执行一个laydate实例
            laydate.render({
                elem: '#signDate' //指定元素
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
            //监听提交
            form.on('submit(save)', function(data){
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
                    url: "${pageContext.request.contextPath }/contract/add",
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
                        layer.msg('添加成功!', {icon: 1, time: 1000});
                    },
                    error: function (data) {
                        layer.msg('合同已存在!', {icon: 5, time: 1000, anim: 6});
                    }
                });
                return false;// 阻止表单自动提交
            });
        });
    });
</script>
</body>
</html>