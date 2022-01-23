<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../other/meta.html"%>
	<%@include file="../other/style.html" %>
	<style type="text/css">
		#oldPassword-error {
			margin-top: 1px;
			line-height:45px;
		}
		#newPassword-error {
			margin-top: 1px;
			line-height:45px;
		}
		#confirmPassword-error {
			margin-top: 1px;
			line-height:45px;
		}
	</style>
</head>
<body>
	<div class="page-container">
		<form class="form layui-form form-horizontal" id="form-admin-submit">
		    <input type="hidden" value="${sessionScope.CurrentUser.id}" id="id" name="id">
	        <input type="hidden" value="${sessionScope.CurrentUser.password}" id="password" name="password">
			<table class="layui-table layui-xs" lay-skin="nob">
				<tbody>
				<tr>
					<td align="right" width="80">旧 &nbsp;密 码：</td>
					<td>
						<input type="text" class="layui-input" placeholder="请输入旧密码" id="oldPassword" name="oldPassword" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td align="right" width="80">新 &nbsp;密 码：</td>
					<td>
						<input type="password"class="layui-input" placeholder="请输入新密码" id="newPassword" name="newPassword" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td align="right">确认密码：</td>
					<td>
						<input type="password" class="layui-input" placeholder="请确认新密码" id="confirmPassword" name="confirmPassword" autocomplete="off">
					</td>
				</tr>
				</tbody>
			</table>
			<button class="layui-btn layui-btn-fluid layui-btn-radius login-btn" style="margin-left: 0%;">确定修改</button>
		</form>
	</div>
	<script type="text/javascript" src="${ctx}/lib/jquery/3.5.1/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="${ctx}/lib/layui/layui.js" charset="utf-8"></script>
	<script type="text/javascript" src="${ctx}/lib/layer/2.4/layer.js"></script>
	<script type="text/javascript" src="${ctx}/lib/jquery.validation/1.14.0/jquery.validate.js"></script>
	<script type="text/javascript" src="${ctx}/lib/jquery.validation/1.14.0/validate-methods.js"></script>
	<script type="text/javascript" src="${ctx}/lib/jquery.validation/1.14.0/messages_zh.js"></script>
	<script type="text/javascript">
		$(function() {
		    // 判断新旧密码
		    jQuery.validator.addMethod("isNotEqual", function(value, element, param) {       
		         return this.optional(element) || value != $(param).val();       
		    }, "新旧密码一样");	 
			// 表单验证，提交
			$("#form-admin-submit").validate({
				rules : {
					oldPassword : {
						required : true,
						rangelength : [ 6, 16 ],
						equalTo : "#password"
					},
				    newPassword : {
						required : true,
						rangelength : [ 6, 16 ],
						isNotEqual :"#oldPassword"
					},
					confirmPassword : {
						required : true,
						rangelength : [ 6, 16 ],
					    equalTo : "#newPassword"
					}
				},
				messages : {
					oldPassword : {
						required : "密码不能为空",
						rangelength : "密码长度6到16个字符,区分大小写",
						equalTo : "密码输入错误"
					},
					newPassword : {
						required : "密码不能为空",
						rangelength : "密码长度6到16个字符,区分大小写"
					},
					confirmPassword : {
						required : "密码不能为空",
						rangelength : "密码长度6到16个字符,区分大小写",
						equalTo : "两次密码输入不一样"
					},
				},
				onkeyup : false,
				focusCleanup : false,
				submitHandler : function(form) {
					$.ajax({
						type : 'POST',
						url : "${pageContext.request.contextPath }/user/updatePassword",
						data : JSON.stringify({
					     	id:id.value,
					     	password:form.newPassword.value
					    }),
						contentType:"application/json;charset=UTF-8",
						dataType : "json",
						success : function(data) {
							if (data == "1") {
								layer.msg('修改成功!', {
									icon : 1,
									time : 1000,
									offset:"t",
									end :function(){
										parent.location.href="${ctx}/user/login";// 刷新会话
									}
								});
							}else{
								layer.msg('修改失败，请稍后尝试!', {
									icon : 5,
									time : 1000,
									anim: 6 ,
									offset:"t"
								});
							}
						},
						error : function(data) {
							layer.msg('服务器发生异常，请稍后尝试!', {
								icon : 5,
								time : 1000,
								anim: 6 ,
								offset:"t"
							});
						}
					});		
				}
			});
		});
	</script>
</body>
</html>