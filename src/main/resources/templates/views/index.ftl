<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Online learning system</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="${request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
  <link rel="stylesheet" href="${request.contextPath}/layuiadmin/style/admin.css" media="all">
<style>

</style>
</head>
<body class="layui-layout-body">

  <div id="LAY_app">
    <div class="layui-layout layui-layout-admin">
      <div class="layui-header">
        <!-- head -->
        <ul class="layui-nav layui-layout-left">
          <li class="layui-nav-item layadmin-flexible" lay-unselect>
            <a href="javascript:;" layadmin-event="flexible" title="flexible">
              <i class="layui-icon layui-icon-shrink-right" id="LAY_app_flexible"></i>
            </a>
          </li>
          <li class="layui-nav-item" lay-unselect>
            <a href="javascript:;" layadmin-event="refresh" title="refresh">
              <i class="layui-icon layui-icon-refresh-3"></i>
            </a>
          </li>
        </ul>
        <ul class="layui-nav layui-layout-right" lay-filter="layadmin-layout-right">
          <li class="layui-nav-item layui-hide-xs" lay-unselect>
            <a href="javascript:;" layadmin-event="theme">
              <i class="layui-icon layui-icon-theme"></i>
            </a>
          </li>
          <li class="layui-nav-item layui-hide-xs" lay-unselect>
            <a href="javascript:;" layadmin-event="fullscreen">
              <i class="layui-icon layui-icon-screen-full"></i>
            </a>
          </li>
          <li class="layui-nav-item" lay-unselect>

            <a href="javascript:;">
              <cite>${(user.name)!}</cite>
            </a>
            <dl class="layui-nav-child">
                <a href="${request.contextPath}/toLogout">logout</a>
            </dl>
          </li>

          <li class="layui-nav-item layui-hide-xs" lay-unselect>
            <a href="javascript:;"><i class="layui-icon layui-icon-more-vertical"></i></a>
          </li>
          <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-unselect>
            <a href="javascript:;" layadmin-event="more"><i class="layui-icon layui-icon-more-vertical"></i></a>
          </li>
        </ul>
      </div>

      <!-- ???????????? -->
      <div class="layui-side layui-side-menu">
        <div class="layui-side-scroll">
          <div class="layui-logo" href="javascript:void(0);">
            <span>Online learning system</span>
          </div>

          <ul class="layui-nav layui-nav-tree" lay-shrink="all" id="LAY-system-side-menu" lay-filter="layadmin-system-side-menu">

              <li data-name="Resource" class="layui-nav-item">
                <a lay-href="${request.contextPath}/to/resource" lay-tips="Resource" lay-direction="2">
                  <i class="layui-icon layui-icon-component"></i>
                  <cite>Resource</cite>
                </a>
              </li>
            <li data-name="Discussion Board" class="layui-nav-item">
              <a lay-href="${request.contextPath}/to/discussion" lay-tips="Discussion Board" lay-direction="2">
                <i class="layui-icon layui-icon-component"></i>
                <cite>Discussion Board</cite>
              </a>
            </li>
            <#if (user.type)?? && (user.type)=='1'>
              <li data-name="worksheet" class="layui-nav-item">
                <a lay-href="${request.contextPath}/to/worksheet" lay-tips="worksheet" lay-direction="2">
                  <i class="layui-icon layui-icon-component"></i>
                  <cite>worksheet</cite>
                </a>
              </li>
            </#if>

          </ul>
        </div>
      </div>

      <!-- ???????????? -->
      <div class="layadmin-pagetabs" id="LAY_app_tabs">
        <div class="layui-icon layadmin-tabs-control layui-icon-prev" layadmin-event="leftPage"></div>
        <div class="layui-icon layadmin-tabs-control layui-icon-next" layadmin-event="rightPage"></div>
        <div class="layui-icon layadmin-tabs-control layui-icon-down">
          <ul class="layui-nav layadmin-tabs-select" lay-filter="layadmin-pagetabs-nav">
            <li class="layui-nav-item" lay-unselect>
              <a href="javascript:;"></a>
              <dl class="layui-nav-child layui-anim-fadein">
                <dd layadmin-event="closeThisTabs"><a href="javascript:;">?????????????????????</a></dd>
                <dd layadmin-event="closeOtherTabs"><a href="javascript:;">?????????????????????</a></dd>
                <dd layadmin-event="closeAllTabs"><a href="javascript:;">?????????????????????</a></dd>
              </dl>
            </li>
          </ul>
        </div>
        <div class="layui-tab" lay-unauto lay-allowClose="true" lay-filter="layadmin-layout-tabs">
          <ul class="layui-tab-title" id="LAY_app_tabsheader">
            <li lay-id="/to/dpzh" lay-attr="/to/dpzh" class="layui-this"><i class="layui-icon layui-icon-home"></i></li>
          </ul>
        </div>
      </div>


      <!-- ???????????? -->
      <div class="layui-body" id="LAY_app_body">
        <div class="layadmin-tabsbody-item layui-show">
          <iframe src="${request.contextPath}/to/statistics" frameborder="0" class="layadmin-iframe"></iframe>
        </div>
      </div>

      <!-- ???????????????????????????????????????????????? -->
      <div class="layadmin-body-shade" layadmin-event="shade"></div>
    </div>
  </div>

  <script src="${request.contextPath}/layuiadmin/layui/layui.js"></script>
  <script>
  layui.config({
    base: '${request.contextPath}/layuiadmin/' //????????????????????????
  }).extend({
    index: 'lib/index' //???????????????
    ,tableEdit:'modules/treeTable/tableEdit'  //??????????????????????????????tableEdit???????????????????????????
    ,tableTree:'modules/treeTable/tableTree'
  }).use('index');
  </script>
</body>
</html>


