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
	<div class="page-container">
		<div style="width: 80%;">
			<table class="table table-border table-bordered table-bg table-hover">
				<caption style="margin-bottom: 15px;">
					<font size="5"><b>销售车辆信息</b></font>
				</caption>
				<tbody style="margin-top: 30px;">
				    <colgroup>  
                        <col width="80">  
                        <col>  
                        <col width="80">  
                        <col>  
                    </colgroup>  
					<tr>
						<td colspan="4" style="text-align: center; background: #FAEBD7;"><b>合同信息</b></td>
					</tr>
					<tr>
						<td>合同编号：</td>
						<td>${contractDetail.contract.contractNumber}</td>
					    <td>签订日期：</td>
						<td><f:formatDate value="${contractDetail.contract.signDate}" pattern="yyyy-MM-dd" /></td>
					</tr>
					<tr>
						<td>合同类型：</td>
						<td>${contractDetail.contract.contractType}</td>
					    <td>市场人员：</td>
						<td>${contractDetail.contract.marketPerson}</td>
					</tr>
					<tr>
						<td>收款银行：</td>
						<td>${contractDetail.contract.contractPayBank}</td>
						<td>合同状态：</td>
						<td>${contractDetail.contract.contractState}</td>
					</tr>
					<tr>
						<td colspan="4" style="text-align: center; background: #FAEBD7;"><b>车辆信息</b></td>
					</tr>
					<tr>
					    <td>车识别码：</td>
						<td colspan="3">${contractDetail.vehicleNumber}</td>
					</tr>
					<tr>
					    <td>型 &nbsp;&nbsp; &nbsp;&nbsp; 号：</td>
						<td>${contractDetail.productMode}</td>
						<td>出库日期：</td>
						<td><f:formatDate value="${contractDetail.exportDate}" pattern="yyyy-MM-dd" /></td>
					</tr>
					<tr>
					    <td>单 &nbsp;&nbsp; &nbsp;&nbsp; 价：</td>
						<td><f:formatNumber type="currency" value="${contractDetail.productPrice}" maxFractionDigits="2"/></td>
					    <td>押 &nbsp;&nbsp; &nbsp;&nbsp; 金：</td>
						<td><f:formatNumber type="currency" value="${contractDetail.productDeposit}" maxFractionDigits="2"/></td>
					</tr>
					<tr>
						<td>项目地址：</td>
						<td colspan="3">${contractDetail.projectAddress}</td>
					</tr>
					<tr>
						<td>租期信息：</td>
						<td>
							<f:formatDate value="${contractDetail.startDate}" pattern="yyyy-MM-dd" />
							<c:if test="${not empty contractDetail.startDate}"> ~ </c:if>
							<c:if test="${empty contractDetail.finalDate}"> -- </c:if>
							<f:formatDate value="${contractDetail.finalDate}" pattern="yyyy-MM-dd" />
						</td>
						<td>租赁周期：</td>
						<td>
							<c:if test="${contractDetail.contract.contractType eq '出售'}"> 永久 </c:if>
							<c:if test="${contractDetail.contract.contractType eq '租赁'}"> ${contractDetail.dateCycle}个月 </c:if>
						</td>
					</tr>
					<tr>
						<td>耗材详情：</td>
						<td colspan="3">${contractDetail.supplyDescription}</td>
					</tr>
					<tr>
						<td>付款状态：</td>
						<td>${contractDetail.payState}</td>
						<td>是否开票：</td>
						<td>${contractDetail.hasBill==1?"已开票":"未开票"}</td>
					</tr>
					<tr>
					    <td>售后人员：</td>
						<td colspan="3">${contractDetail.salePerson}</td>
					</tr>
					<tr>
						<td colspan="4" style="text-align: center; background: #FAEBD7;"><b>客户信息</b></td>
					</tr>
					<tr>
						<td>客户名称：</td>
						<td colspan="3">${contractDetail.contract.customer.customerName}</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>