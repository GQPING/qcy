<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../other/meta.html"%>
    <%@include file="../other/style.html" %>
</head>
<body>
<div class="page-container">
    <form class="layui-form">
        <table class="layui-table layui-xs" lay-skin="nob">
            <tbody>
            <tr>
                <td align="right" width="80">客户名称：</td>
                <td>
                    <input type="text" id="customerName" name="customerName" class="layui-input">
                </td>
            </tr>
            <tr>
                <td align="right" width="80">信用星级：</td>
                <td>
                    <select class="layui-input" name="customerLevel" id="customerLevel">
                        <option value="1">1星</option>
                        <option value="2">2星</option>
                        <option value="3">3星</option>
                        <option value="4">4星</option>
                        <option value="5" selected>5星</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="right">备注说明：</td>
                <td>
                    <textarea id="customerRemarkDescription" rows="10" name="customerRemarkDescription" autocomplete="off" class="layui-textarea" placeholder="请输入"></textarea>
                </td>
            </tr>
            </tbody>
        </table>
        <button class="layui-btn layui-btn-fluid layui-btn-radius login-btn" lay-submit lay-filter="save">保存</button>
    </form>
</div>
<script type="text/javascript" src="${ctx}/lib/jquery/3.5.1/jquery-3.5.1.js"></script>
<script type="text/javascript" src="${ctx}/lib/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    $(function () {
        // lay加载
        layui.use(['layer', 'form'], function () {
            var form = layui.form,
                $ = layui.jquery,
                layer = layui.layer;
            //监听提交
            form.on('submit(save)', function(data){
                var customerName = data.field.customerName;
                if (customerName == "") {
                    layer.msg('请输入客户名称', {icon: 0, time: 1000, anim: 6});
                    return false;
                }
                var customerLevel = data.field.customerLevel;
                if (customerLevel == "") {
                    layer.msg('请选择信用星级', {icon: 0, time: 1000, anim: 6});
                    return false;
                }
                var customerCreateDate = new Date();
                var customerRemarkDescription = data.field.customerRemarkDescription;
                $.ajax({
                    type: 'post',
                    url: "${pageContext.request.contextPath }/customer/add",
                    data: JSON.stringify({
                        customerName: customerName,
                        customerLevel: customerLevel,
                        customerCreateDate: customerCreateDate,
                        customerRemarkDescription: customerRemarkDescription
                    }),
                    contentType: "application/json;charset=UTF-8",
                    dataType: "json",
                    success: function (data) {
                        layer.msg('添加成功!', {icon: 1, time: 1000});
                    },
                    error: function (data) {
                        layer.msg('客户已存在!', {icon: 5, time: 1000, anim: 6});
                    }
                });
                return false;// 阻止表单自动提交
            });
        });
    });
</script>
</body>
</html>