<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>login</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="${request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
  <link rel="stylesheet" href="${request.contextPath}/layuiadmin/style/admin.css" media="all">
  <link rel="stylesheet" href="${request.contextPath}/layuiadmin/style/login.css" media="all">
</head>
<body>

  <div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">

    <div class="layadmin-user-login-main">
      <div class="layadmin-user-login-box layadmin-user-login-header">
        <h2>Online learning system</h2>
      </div>

      <form action="/loginCheck" method="post">
        <div class=" layui-form">
          <div class="layui-form-item">
            <input type="text" name="loginname" id="LAY-user-login-username" lay-verify="required" placeholder="username" class="layui-input">
          </div>
          <div class="layui-form-item">
            <input type="password" name="pwd" id="LAY-user-login-password" lay-verify="required" placeholder="password" class="layui-input">
          </div>

          </div>
        <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="formDemo">login</button>

      </form>
    </div>

    <div class="layui-trans layadmin-user-login-footer">

<#--      <p>© 2020 &nbsp;&nbsp; su-tui.com</p>-->
<#--      <p>-->
<#--        <span><a href="http://www.layui.com/admin/#get" target="_blank">获取授权</a></span>-->
<#--        <span><a href="http://www.layui.com/admin/pro/" target="_blank">在线演示</a></span>-->
<#--        <span><a href="http://www.layui.com/admin/" target="_blank">前往官网</a></span>-->
<#--      </p>-->
    </div>

    <!--<div class="ladmin-user-login-theme">
      <script type="text/html" template>
          <li data-theme=""><img src="{{ layui.setter.base }}style/res/bg-none.jpg"></li>
          <li data-theme="#03152A" style="background-color: #03152A;"></li>
          <li data-theme="#2E241B" style="background-color: #2E241B;"></li>
          <li data-theme="#50314F" style="background-color: #50314F;"></li>
          <li data-theme="#344058" style="background-color: #344058;"></li>
          <li data-theme="#20222A" style="background-color: #20222A;"></li>
        </ul>
      </script>
    </div>-->

  </div>
  <input id="msg" value="${msg?if_exists}" hidden/>
  <script src="${request.contextPath}/layuiadmin/layui/layui.js"></script>
  <script>
    //根据layui用法，引入jquery和layer模块
    layui.use(['jquery', 'layer','form'], function(){

      var $=layui.jquery;
      var layer=layui.layer;
      var form=layui.form;
      //取input框里的提示信息
      var msg=$("#msg").val();
      //如果信息不为空，则弹框提示
      if(msg!==''){
        layer.msg(msg);
      }
    });
  </script>
</body>
</html>