<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>worksheet</title>
    <link rel="stylesheet" href="${request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
    <style>
        .layui-form-label{
            width: 50px;
        }
    </style>
</head>
<body style="background-color: #F2F2F2;" >
<div style="padding: 20px; ">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body">
                    <form class="layui-form" action="" style="margin-top: 8px;text-align: center">
                        <textarea id="content" name="content" placeholder="type your words" class="layui-textarea" style="height: 500px"></textarea>
                        <br>
                        <button type="button" class="layui-btn" id="save">save</button>
                    </form>


                </div>
            </div>
        </div>
    </div>
</div>


<script src="${request.contextPath}/layuiadmin/layui/layui.js"></script>

<script>
    layui.use(['table','form','jquery','laydate'], function(){
        var table = layui.table;
        var form=layui.form;
        var $=layui.$;
        var layer=layui.layer;

        var userId='${(user.id)!}'

        //get worksheet
        $.ajax({
            type:"post",
            async:false,
            url: "${request.contextPath}/${page}/getByUserId?userId="+userId,
            contentType:'application/json; charset=UTF-8',
            success: function(res) {
                console.log(res)
              $("#content").val(res.data.content)
            }
        })
        //save worksheet
        $("#save").click(function () {
            var param={}
            param.userId=userId;
            param.content=$("#content").val()
            console.log(param)
            $.ajax({
                type:"post",
                async:false,
                url: "${request.contextPath}/${page}/saveWorksheet",
                contentType:'application/json; charset=UTF-8',
                data:JSON.stringify(param),
                success: function(res) {
                    layer.msg("success")
                }
            })
        })



    });

</script>

</body>
</html>