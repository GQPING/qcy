<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
  <%@include file="./other/meta.html"%>
  <link rel="stylesheet" type="text/css" href="${ctx}/static/h-ui/css/H-ui.min.css"/>
  <link rel="stylesheet" type="text/css" href="${ctx}/static/business/css/style.css"/>
  <link rel="stylesheet" type="text/css" href="${ctx}/lib/Hui-iconfont/1.0.9/iconfont.css"/>
  <link rel="stylesheet" type="text/css" href="${ctx}/static/h-ui.admin.pro.iframe/skin/default/skin.css" id="skin"/>
  <link rel="stylesheet" type="text/css" href="${ctx}/static/h-ui.admin.pro.iframe/css/h-ui.admin.pro.iframe.min.css"/>
  <style type="text/css">
    .Hui-admin-aside-wrapper .Hui-admin-menu-dropdown .Hui-menu>.Hui-menu-item .Hui-menu>.Hui-menu-title {
        padding-left: 50px;
    }
  </style>
</head>
<body>
  <aside class="Hui-admin-aside-wrapper">
    <div class="Hui-admin-logo-wrapper">
      <a class="logo navbar-logo" href="#" target="_self">
        <i class="va-m iconpic global-logo" style="background-image: url(${ctx}/favicon.ico);"></i>
        <span class="va-m">清晨雨合同跟踪系统</span>
      </a>
    </div>
    <div class="Hui-admin-menu-dropdown bk_2">
      <!-- 合同管理 -->
      <dl id="menu-contract" class="Hui-menu" style="display: none;">
        <dt class="Hui-menu-title"><i class="Hui-iconfont">&#xe639;</i> 合同管理<i class="Hui-iconfont Hui-admin-menu-dropdown-arrow">&#xe6d5;</i></dt>
        <dd class="Hui-menu-item">
          <ul>
            <!--代理合同-->
            <li id="menu-agent" style="display: none;">
              <dl class="Hui-menu">
                <dt class="Hui-menu-title">代理合同<i class="Hui-iconfont Hui-admin-menu-dropdown-arrow">&#xe6d5;</i></dt>
                <dd class="Hui-menu-item">
                  <ul>
                    <li><a data-href="${ctx}/contract/list/1" data-title="代理合同列表" href="javascript:void(0)">合同列表</a></li>
                    <li><a data-href="${ctx}/contractDetail/list/1" data-title="代理合同明细" href="javascript:void(0)">合同明细</a></li>
                  </ul>
                </dd>
              </dl>
            </li>
            <!--租赁合同-->
            <li id="menu-rent" style="display: none;">
              <dl class="Hui-menu">
                <dt class="Hui-menu-title">租赁合同<i class="Hui-iconfont Hui-admin-menu-dropdown-arrow">&#xe6d5;</i></dt>
                <dd class="Hui-menu-item">
                  <ul>
                    <li><a data-href="${ctx}/contract/list/2" data-title="租赁合同列表" href="javascript:void(0)">合同列表</a></li>
                    <li><a data-href="${ctx}/contractDetail/list/2" data-title="租赁合同明细" href="javascript:void(0)">合同明细</a></li>
                  </ul>
                </dd>
              </dl>
            </li>
            <!--出售合同-->
            <li id="menu-sale" style="display: none;">
              <dl class="Hui-menu">
                <dt class="Hui-menu-title">出售合同<i class="Hui-iconfont Hui-admin-menu-dropdown-arrow">&#xe6d5;</i></dt>
                <dd class="Hui-menu-item">
                  <ul>
                    <li><a data-href="${ctx}/contract/list/3" data-title="出售合同列表" href="javascript:void(0)">合同列表</a></li>
                    <li><a data-href="${ctx}/contractDetail/list/3" data-title="出售合同明细" href="javascript:void(0)">合同明细</a></li>
                  </ul>
                </dd>
              </dl>
            </li>
            <!--售后查询（模块放入售后系统，此处废弃）-->
            <li id="menu-service" style="display: none;">
              <dl class="Hui-menu">
                <dt class="Hui-menu-title">售后查询<i class="Hui-iconfont Hui-admin-menu-dropdown-arrow">&#xe6d5;</i></dt>
                <dd class="Hui-menu-item">
                  <ul>
                    <li><a data-href="${ctx}/seachByCustomer" data-title="按合同客户查询" href="javascript:void(0)">按合同客户查询</a></li>
                    <li><a data-href="${ctx}/searchByVehicle" data-title="按车识别码查询" href="javascript:void(0)">按车识别码查询</a></li>
                    <li><a data-href="${ctx}/searchByAddress" data-title="按项目地址查询" href="javascript:void(0)">按项目地址查询</a></li>
                  </ul>
                </dd>
              </dl>
            </li>
            <!--数据报表（具体根据实际使用需求完成，此处废除上一版本）-->
            <li id="menu-report" style="display: none;">
              <dl class="Hui-menu">
                <dt class="Hui-menu-title">数据报表<i class="Hui-iconfont Hui-admin-menu-dropdown-arrow">&#xe6d5;</i></dt>
                <dd class="Hui-menu-item">
                  <ul>
                    <li><a data-href="${ctx}/contract/sorts" data-title="合同数量分类汇总" href="javascript:void(0)">合同数量分类汇总</a></li>
                    <li><a data-href="${ctx}/contract/rentUnits" data-title="租赁车辆回款状态" href="javascript:void(0)">租赁车辆回款状态</a></li>
                    <li><a data-href="${ctx}/contract/saleUnits" data-title="出售车辆回款状态" href="javascript:void(0)">出售车辆回款状态</a></li>
                    <li><a data-href="${ctx}/contract/agentUnits" data-title="代理合同回款状态" href="javascript:void(0)">代理合同回款状态</a></li>
                  </ul>
                </dd>
              </dl>
            </li>
            <!--车辆档案-->
            <li id="menu-record" style="display: none;">
              <dl class="Hui-menu">
                <dt class="Hui-menu-title">档案信息<i class="Hui-iconfont Hui-admin-menu-dropdown-arrow">&#xe6d5;</i></dt>
                <dd class="Hui-menu-item">
                  <ul>
                    <li><a data-href="${ctx}/contractDetail/recordList" data-title="车辆档案" href="javascript:void(0)">车辆档案</a></li>
                  </ul>
                </dd>
              </dl>
            </li>
          </ul>
        </dd>
      </dl>
      <!-- 客户管理 -->
      <dl id="menu-customer" class="Hui-menu" style="display: none;">
        <dt class="Hui-menu-title"><i class="Hui-iconfont">&#xe62b;</i> 客户管理<i class="Hui-iconfont Hui-admin-menu-dropdown-arrow">&#xe6d5;</i></dt>
        <dd class="Hui-menu-item">
          <ul>
            <li id="menu-customerList" style="display: none;"><a data-href="${ctx}/customer/list" data-title="客户列表" href="javascript:void(0)">客户列表</a></li>
          </ul>
        </dd>
      </dl>
      <!-- 用户管理 -->
      <dl id="menu-user" class="Hui-menu" style="display: none;">
        <dt class="Hui-menu-title"><i class="Hui-iconfont">&#xe62c;</i> 用户管理<i class="Hui-iconfont Hui-admin-menu-dropdown-arrow">&#xe6d5;</i></dt>
        <dd class="Hui-menu-item">
          <ul>
            <li><a data-href="${ctx}/user/list" data-title="用户列表" href="javascript:void(0)">用户列表</a></li>
          </ul>
        </dd>
      </dl>
      <!-- 系统管理 -->
      <dl id="menu-system" class="Hui-menu" style="display: none;">
        <dt class="Hui-menu-title"><i class="Hui-iconfont">&#xe62e;</i> 系统管理<i class="Hui-iconfont Hui-admin-menu-dropdown-arrow">&#xe6d5;</i></dt>
        <dd class="Hui-menu-item">
          <ul>
            <li><a data-href="${ctx}/log/list" data-title="系统日志" href="javascript:void(0)">系统日志</a></li>
            <li><a data-href="${ctx}/role/list" data-title="角色列表" href="javascript:void(0)">角色列表</a></li>
            <li><a data-href="${ctx}/menu/list" data-title="菜单列表" href="javascript:void(0)">菜单列表</a></li>
            <li><a data-href="${ctx}/operation/list" data-title="操作列表" href="javascript:void(0)">操作列表</a></li>
            <li><a data-href="${ctx}/permission/list" data-title="权限列表" href="javascript:void(0)">权限列表</a></li>
          </ul>
        </dd>
      </dl>
    </div>
  </aside>
  <div class="Hui-admin-aside-mask"></div>
  <div class="Hui-admin-dislpayArrow">
    <a href="javascript:void(0);" onClick="displaynavbar(this)">
      <i class="Hui-iconfont Hui-iconfont-left">&#xe6d4;</i>
      <i class="Hui-iconfont Hui-iconfont-right">&#xe6d7;</i>
    </a>
  </div>
  <section class="Hui-admin-article-wrapper">
    <header class="Hui-navbar">
      <div class="navbar">
        <div class="container-fluid clearfix">
          <nav id="Hui-topNav" class="nav navbar-nav">
            <ul class="clearfix">
              <li id="addCustomer" style="display:none"><a data-href="${ctx}/customer/add" data-title="新增客户" onclick="Hui_admin_tab(this)" href="javascript:;"><i class="Hui-iconfont">&#xe604;</i> 新增客户</a></li>
              <li id="addContract" style="display:none"><a data-href="${ctx}/contract/add" data-title="新增合同" onclick="Hui_admin_tab(this)" href="javascript:;"><i class="Hui-iconfont">&#xe604;</i> 新增合同</a></li>
            </ul>
          </nav>
          <nav id="Hui-userbar" class="nav navbar-nav navbar-userbar" style="text-align: right;">
            <ul class="clearfix">
              <li>${sessionScope.CurrentUser.role.roleName} : </li>
              <li class="dropDown dropDown_hover"> <a href="#" class="dropDown_A">${sessionScope.CurrentUser.userName} <i class="Hui-iconfont">&#xe6d5;</i></a>
                <ul class="dropDown-menu menu radius box-shadow" style="background-color:rgba(255,255,255,0.5);">
                  <li><a data-href="${ctx}/user/update" data-title="修改密码" onClick="Hui_admin_tab(this)" href="javascript:;"><i class="Hui-iconfont Hui-iconfont-key"></i> 修改密码</a></li>
                  <li><a data-href="#" href="javascript:;" onClick="exit()" title="退出" ><i class="Hui-iconfont Hui-iconfont-power"></i> 退出</a></li>
                </ul>
              </li>
              <!-- 判断弹窗 -->
              <c:if test="${IsPop == 0}">
                <li id="Hui-msg" class="dropDown dropDown_hover right">
                  <a href="javascript:;">
                    <span class="badge"></span>
                    <i class="Hui-iconfont" style="font-size:18px">&#xe68a;</i>
                  </a>
                </li>
              </c:if>
              <c:if test="${IsPop == 1}">
                <li id="Hui-msg" class="dropDown dropDown_hover right">
                  <a class="dropDown_A" title="消息" href="javascript:;">
                    <span class="badge badge-danger">1</span>
                    <i class="Hui-iconfont" style="font-size:18px">&#xe62f;</i>
                  </a>
                  <ul class="dropDown-menu menu radius box-shadow" style="background-color:rgba(255,255,255,0.5);">
                    <li class=""><a data-href="#" href="javascript:;" onClick="pop()">到期提醒</a></li>
                  </ul>
                </li>
              </c:if>
            </ul>
          </nav>
        </div>
      </div>
    </header>
    <div id="Hui-admin-tabNav" class="Hui-admin-tabNav">
      <div class="Hui-admin-tabNav-wp">
        <ul id="min_title_list" class="acrossTab clearfix" style="width: 241px; left: 0px;">
          <li class="active"><span title="我的桌面" data-href="${ctx}/welcome">我的桌面</span><em></em></li>
        </ul>
      </div>
      <div class="Hui-admin-tabNav-more btn-group" style="display: none;">
        <a id="js-tabNav-prev" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a>
        <a id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d7;</i></a>
      </div>
    </div>
    <div id="iframe_box" class="Hui-admin-article">
      <div class="show_iframe">
        <iframe id="iframe-welcome" data-scrolltop="0" scrolling="yes" frameborder="0" src="${ctx}/welcome"></iframe>
      </div>
    </div>
  </section>
  <div class="contextMenu" id="Huiadminmenu">
    <ul>
      <li id="closethis">关闭当前 </li>
      <li id="closeother">关闭其他 </li>
      <li id="closeall">关闭全部 </li>
    </ul>
  </div>
  <script type="text/javascript" src="${ctx}/lib/jquery/1.9.1/jquery.min.js"></script>
  <script type="text/javascript" src="${ctx}/lib/media/js/tk.js"></script>
  <script type="text/javascript" src="${ctx}/lib/layer/3.1.1/layer.js"></script>
  <script type="text/javascript" src="${ctx}/static/h-ui/js/H-ui.min.js"></script>
  <script type="text/javascript" src="${ctx}/lib/jquery.contextmenu/jquery.contextmenu.r2.js"></script>
  <script type="text/javascript" src="${ctx}/static/h-ui.admin.pro.iframe/js/h-ui.admin.pro.iframe.min.js"></script>
  <script>
    // 初始化
    $(function () {
      // 弹窗
      if ("${IsPop}" == '1') {
        layer_show('到期预警', '${ctx}/remind');
      }
      // 权限
      $.ajax({
        url: '${pageContext.request.contextPath }/rolePermission/searchList',
        method: 'post',
        data: JSON.stringify({id: '${sessionScope.CurrentUser.roleID}'}),
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
        success: function (data) {
          let obj = eval(data);
          $(obj).each(function (index) {
            let item = obj[index];
            switch (item.menu.menuName) {
              case "合同管理":document.getElementById("menu-contract").style.display = "";break;
              case "代理合同":document.getElementById("menu-agent").style.display = "";break;
              case "租赁合同":document.getElementById("menu-rent").style.display = "";break;
              case "出售合同":document.getElementById("menu-sale").style.display = "";break;
              case "售后查询":document.getElementById("menu-service").style.display = "";break;
              case "数据报表":document.getElementById("menu-report").style.display = "";break;
              case "档案信息":document.getElementById("menu-record").style.display = "";break;
              case "客户管理":document.getElementById("menu-customer").style.display = "";break;
              case "客户列表":document.getElementById("menu-customerList").style.display = "";break;
              case "用户管理":document.getElementById("menu-user").style.display = "";break;
              case "系统管理":document.getElementById("menu-system").style.display = "";break;
            }
          });
        }, error: function (data) {
          layer.msg('权限获取异常!', {icon: 5, time: 1000, anim: 6});
        }
      });
      $.ajax({
        url: '${pageContext.request.contextPath }/rolePermission/search',
        method: 'post',
        data: JSON.stringify({
          id: '${sessionScope.CurrentUser.roleID}',
          menuNameString: '客户列表',
          operationNameString: '创建'
        }),
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
        success: function (data) {
          document.getElementById("addCustomer").style.display = "";
        }, error: function (data) {
          layer.msg('权限获取异常!', {icon: 5, time: 1000, anim: 6});
        }
      });
      $.ajax({
        url: '${pageContext.request.contextPath }/rolePermission/search',
        method: 'post',
        data: JSON.stringify({
          id: '${sessionScope.CurrentUser.roleID}',
          menuNameString: '合同列表',
          operationNameString: '创建'
        }),
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
        success: function (data) {
          document.getElementById("addContract").style.display = "";
        }, error: function (data) {
          layer.msg('权限获取异常!', {icon: 5, time: 1000, anim: 6});
        }
      });
    });
    // 弹窗消息
    function pop() {
        layer_show('到期预警', '${ctx}/remind');
    }
    // 退出
    function exit(){
        layer.confirm('确认要退出吗？',function(index){
            location.href = "${pageContext.request.contextPath }/exit";
        });
    }
    // 自定义弹窗
    function layer_show(title,url){
        if (title == null || title == '') {
            title=false;
        };
        if (url == null || url == '') {
            url="404.html";
        };
        var index = layer.open({
            type: 2,
            area: ['100%', '600px'],
            fix: false, // 固定
            maxmin: false,// 最大最小化
            shade:0.4,
            title: title,
            content: url,
            success: function(layero,index){
                //layero.find('.layui-layer-max').remove();// 不开放最大化
                //layero.find('.layui-layer-min').remove();// 不开放最小化
                //layer.iframeAuto(index);// 弹窗高度自适应
            }
        });
        parent.layer.full(index);
    }
  </script>
</body>
</html>