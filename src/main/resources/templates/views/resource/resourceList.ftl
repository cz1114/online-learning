<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>resourceList</title>
    <link rel="stylesheet" href="${request.contextPath}/layuiadmin/layui/css/layui.css" media="all">
    <style>
        .layui-form-label{
            width: 50px;
        }
        .title{
            font-size: 20px;
            font-weight: bolder;
            margin-top:20px ;
            margin-bottom: 10px;
        }
        a{
            color: #1e83ff;
            text-decoration:underline ;
        }
    </style>
</head>
<body style="background-color: #F2F2F2;" >
<div style="padding: 20px; ">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">
                    <span style="font-weight: bolder;font-size: 30px">lectures</span>
                </div>
                <div class="layui-card-body">

                    <span class="title">Video lectures</span><br>
                    In this week's learning material, we will introduce what is computer vision. The following links are to videos and learning resources (all from publicly available sources on the internet)
                    [<a target="_blank" href="https://www.youtube.com/watch?v=wVE8SFMSBJ0">video</a>,<a target="_blank" href="https://www.ibm.com/uk-en/topics/computer-vision">materital</a>]
                    <hr>
                    <span class="title">Practical</span><br>
                    In this week's practice material, we will review what we have learned. here are two quiz that contains questions with answers.(all from publicly available sources on the internet)
                    <br>
                    <a target="_blank" href="https://www.bestinterviewquestion.com/computer-vision-interview-questions">https://www.bestinterviewquestion.com/computer-vision-interview-questions</a>
                    <br>
                    <a target="_blank" href="https://networkingfunda.com/introduction-to-computer-vision-and-image-processing-quiz-answers/">https://networkingfunda.com/introduction-to-computer-vision-and-image-processing-quiz-answers/</a>

                    <hr>
                    <span class="title"> Reading</span><br>
                    "Physically Based Rendering: From Theory To Implementation" online book, chapter 1.<br>
                    <a target="_blank" href="http://web4.cs.ucl.ac.uk/staff/s.prince/book/book.pdf">http://web4.cs.ucl.ac.uk/staff/s.prince/book/book.pdf</a>

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
        var laydate=layui.laydate;

        //日期选择
        laydate.render({
            elem: '#year'
            ,trigger: 'click'//呼出事件改成click
            ,type: 'year'
        });

        var addLayerIndex='';
        table.render({
            elem: '#table'
            ,url:'${request.contextPath}/${page}/getPageList'
            ,method:'post'
            ,contentType: "application/json;charset=UTF-8"
            ,dataType: 'json'
            ,done:function (res,curr,count) {
            }
            ,toolbar: '#toolbar' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: [
            ]
            ,title: '${page}'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'isbn', title:'ISBN'}
                ,{field:'name', title:'书名'}
                ,{field:'press',title:'出版社'}
                ,{field:'type',title:'类型'}
                ,{field:'author',title:'作者'}
                ,{field:'quantity',title:'剩余数量'}
                ,{fixed: 'right', title:'操作', toolbar: '#bar', width:120}
            ]]
            ,page: true
            ,where:{table:'${page}'}
            ,parseData: function(res){ //res 即为原始返回的数据
                console.log(res)
                return {
                    "code": res.data.code, //解析接口状态
                    "msg": res.data.msg, //解析提示文本
                    "count": res.data.count, //解析数据长度
                    "data": res.data.data //解析数据列表
                };
            }
        });

        //头工具栏事件
        table.on('toolbar(table)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'getCheckData':
                    var data = checkStatus.data;
                    console.log(data)
                    layer.alert(JSON.stringify(data));
                    break;
                case 'getCheckLength':
                    var data = checkStatus.data;
                    layer.msg('选中了：'+ data.length + ' 个');
                    break;
                case 'isAll':
                    layer.msg(checkStatus.isAll ? '全选': '未全选');
                    break;

                //自定义头工具栏右侧图标 - 提示
                case 'LAYTABLE_TIPS':
                    layer.alert('这是工具栏右侧自定义的一个图标按钮');
                    break;
                //自定义头工具栏右侧图标 - 提示
                case 'add':
                    layer.open({
                        title:'新增',
                        type: 2,
                        area: ['500px', '440px'],
                        // area: '30%',
                        content: ['${request.contextPath}/to/${page}?type=layer'], //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                        btn: ['确认','取消'], //按钮
                        yes:function (index,layero) {
                            addLayerIndex=index;
                            // var son = window['layui-layer-iframe' + index];
                            // son.child(111);
                            //获取子窗口的函数
                            var formSubmit=layer.getChildFrame('form', index);
                            console.log(formSubmit)
                            var submited = formSubmit.find('button')[0];
                            submited.click()
                        }
                    });
                    break;
                    //批量删除
                    case 'multiDelete':

                        layer.confirm('确认删除选中的数据吗？', function(index){
                            var data = checkStatus.data;
                            var idAry=[];
                            if(data.length===0){
                                layer.msg("请至少选择一条数据！！");
                                return false;
                            }
                            for(var i=0;i<data.length;i++){
                                var row=data[i];
                                idAry.push(row.id);
                            }
                            var param={}
                            param.table='${page}';
                            param.ids=idAry;
                            $.ajax({
                                type:"post",
                                url: "${request.contextPath}/deleteItemsByIds",
                                //这里没有用json传值，所以contentType
                                contentType:'application/json; charset=UTF-8',
                                data : JSON.stringify(param),
                                success: function(res) {
                                    if(res.code===200){
                                        layer.msg(res.msg)
                                        layer.close(index);
                                        table.reload('table')
                                    }
                                },
                                error: function(res) {
                                    layer.alert(res.msg,{icon:2})
                                }
                            })
                            layer.close(index);
                        });
            };
        });

        //监听行工具事件
        table.on('tool(table)', function(obj){
            var data = obj.data;
            var idAry=[];
            idAry.push(data.id);
            var param={}
            param.ids=idAry;
            param.table='${page}'

            if(obj.event === 'edit'){
                layer.open({
                    title:'编辑',
                    type: 2,
                    area: ['500px', '440px'],
                    // area: '30%',
                    content: ['${request.contextPath}/to/${page}?type=layer&id='+data.id], //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
                    btn: ['确认','取消'], //按钮
                    yes:function (index,layero) {
                        addLayerIndex=index;
                        // var son = window['layui-layer-iframe' + index];
                        // son.child(111);
                        //获取子窗口的函数
                        var formSubmit=layer.getChildFrame('form', index);
                        console.log(formSubmit)
                        var submited = formSubmit.find('button')[0];
                        submited.click()

                    }
                });
            }else if(obj.event === 'del'){
                layer.confirm('确认删除吗？', function(index){
                    $.ajax({
                        type:"post",
                        url: "${request.contextPath}/deleteItemsByIds",
                        //这里没有用json传值，所以contentType
                        contentType:'application/json; charset=UTF-8',
                        data :JSON.stringify(param),
                        success: function(res) {
                            if(res.code===200){
                                layer.msg(res.msg)
                                layer.close(index);
                                table.reload('table')
                            }
                        },
                        error: function(res) {
                            layer.alert(res.msg,{icon:2})
                        }
                    })
                    layer.close(index);
                });
            }
        });

        //查询按钮
        $("#search").click(function () {
            var name=$("input[name='name']").val();
            var press=$("input[name='press']").val();
            var author=$("input[name='author']").val();
            //列表的重载
            table.reload('table', {
                page:{curr:1}
                ,where: {name: name,press:press,author:author}
                }
            );


        });

        //清空按钮
        $("#reset").click(function () {
           $("input").val("")
        });
        //关闭新增layer
        window.closeAddLayer=function () {
            layer.close(addLayerIndex)
        }
        //重载客户列表
        window.reloadList=function(){
            table.reload('table')
        }
    });

</script>
<script type="text/html" id="imgtmp">
    <img src="{{d.headimgurl}}" style="height: 50px;width: 50px">
</script>
</body>
</html>