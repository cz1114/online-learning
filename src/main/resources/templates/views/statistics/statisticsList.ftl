<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>fullcalendar</title>
    <link rel="stylesheet" href="${request.contextPath}/layuiadmin/layui/css/layui.css" media="all">

    <link rel="stylesheet" href='${request.contextPath}/fullcalendar/core/main.css' rel='stylesheet' />
    <link rel="stylesheet" href='${request.contextPath}/fullcalendar/daygrid/main.css' rel='stylesheet' />
    <link rel="stylesheet" href='${request.contextPath}/fullcalendar/timegrid/main.css' rel='stylesheet' />
    <link rel="stylesheet" href="${request.contextPath}/assets/common.css" media="all">

    <style>
        #calendar {
            max-width: 1200px;
            margin: 0 auto;
        }

        #external-events {
            float: left;
            width: 150px;
            padding: 0 10px;
            border: 1px solid #ccc;
            background: #eee;
            text-align: left;
        }

        #external-events h4 span {
            font-size: 16px;
            margin-top: 0;
            padding-top: 1em;
        }

        .external-event { /* try to mimick the look of a real event */
            margin: 10px 0;
            padding: 2px 4px;
            background: #3366CC;
            color: #fff;
            font-size: .85em;
            cursor: pointer;
        }

        /*日期控件*/
        .layui-laydate-content>.layui-laydate-list {
            padding-bottom: 0px;
            overflow: hidden;
        }
        .layui-laydate-content>.layui-laydate-list>li{
            width:50%
        }

        /* pop */
        .popper,
        .tooltip {
            position: absolute;
            z-index: 9999;
            background: #FFC107;
            color: black;
            width: 150px;
            border-radius: 3px;
            box-shadow: 0 0 2px rgba(0,0,0,0.5);
            padding: 10px;
            text-align: center;
        }
        .style5 .tooltip {
            background: #1E252B;
            color: #FFFFFF;
            max-width: 200px;
            width: auto;
            font-size: .8rem;
            padding: .5em 1em;
        }
        .popper .popper__arrow,
        .tooltip .tooltip-arrow {
            width: 0;
            height: 0;
            border-style: solid;
            position: absolute;
            margin: 5px;
        }

        .tooltip .tooltip-arrow,
        .popper .popper__arrow {
            border-color: #FFC107;
        }
        .style5 .tooltip .tooltip-arrow {
            border-color: #1E252B;
        }
        .popper[x-placement^="top"],
        .tooltip[x-placement^="top"] {
            margin-bottom: 5px;
        }
        .popper[x-placement^="top"] .popper__arrow,
        .tooltip[x-placement^="top"] .tooltip-arrow {
            border-width: 5px 5px 0 5px;
            border-left-color: transparent;
            border-right-color: transparent;
            border-bottom-color: transparent;
            bottom: -5px;
            left: calc(50% - 5px);
            margin-top: 0;
            margin-bottom: 0;
        }
        .popper[x-placement^="bottom"],
        .tooltip[x-placement^="bottom"] {
            margin-top: 5px;
        }
        .tooltip[x-placement^="bottom"] .tooltip-arrow,
        .popper[x-placement^="bottom"] .popper__arrow {
            border-width: 0 5px 5px 5px;
            border-left-color: transparent;
            border-right-color: transparent;
            border-top-color: transparent;
            top: -5px;
            left: calc(50% - 5px);
            margin-top: 0;
            margin-bottom: 0;
        }
        .tooltip[x-placement^="right"],
        .popper[x-placement^="right"] {
            margin-left: 5px;
        }
        .popper[x-placement^="right"] .popper__arrow,
        .tooltip[x-placement^="right"] .tooltip-arrow {
            border-width: 5px 5px 5px 0;
            border-left-color: transparent;
            border-top-color: transparent;
            border-bottom-color: transparent;
            left: -5px;
            top: calc(50% - 5px);
            margin-left: 0;
            margin-right: 0;
        }
        .popper[x-placement^="left"],
        .tooltip[x-placement^="left"] {
            margin-right: 5px;
        }
        .popper[x-placement^="left"] .popper__arrow,
        .tooltip[x-placement^="left"] .tooltip-arrow {
            border-width: 5px 0 5px 5px;
            border-top-color: transparent;
            border-right-color: transparent;
            border-bottom-color: transparent;
            right: -5px;
            top: calc(50% - 5px);
            margin-left: 0;
            margin-right: 0;
        }
        .gray{
            background-color: gainsboro;
            border:none;
        }
        .red{
            background-color: #ea5b5b;
            border:none;
        }
        .orange{
            background-color: #fab33d;
            border:none;
        }
    </style>
</head>
<body style="background-color: #F2F2F2;" >
<div style="padding: 20px; ">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">

                <div class="layui-card-body">
                    <#if (user.type)?? && (user.type)=='0'>
                        welcome login Online learning system
                    </#if>
                    <#if (user.type)?? && (user.type)=='1'>
                        <div class="layui-fluid">
                            <div class="layui-card" style="padding-top: 5px; margin-bottom: 8px;">
                                <div class="layui-row layui-col-space15">
                                    <div class="layui-col-xs12 layui-col-md12">
                                        <div id='calendar'></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</div>

<script  type="text/html" id="calendarForm">
    <form lay-filter="calendarForm" class="layui-form model-form">
        <input name="id" id="id" type="hidden"/>
        <div class="layui-form-item">
            <label class="layui-form-label">topic</label>
            <div class="layui-input-block">
                <input name="title" placeholder="topic" type="text" class="layui-input" maxlength="50" lay-verify="required" required/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">type</label>
            <div class="layui-input-block">
                <select name="type" lay-verify="required">
                    <option value="">please select</option>
                    <option value="blue">to do</option>
                    <option value="gray">done</option>

                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">begin</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="stime" name="stime" placeholder="HH:mm" lay-verify="required" required  autocomplete="off" disableautocomplete>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">end</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="etime" name="etime" placeholder="HH:mm" lay-verify="required" required  autocomplete="off" disableautocomplete>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">participants</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input"  name="participants" placeholder="" >
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">content</label>
            <div class="layui-input-block">
                <textarea name="content" style="width: 95%;height: 90px"></textarea>
            </div>
        </div>
        <div class="layui-form-item text-right">
            <button class="layui-btn layui-btn-primary" type="button" ew-event="closeDialog">cancel</button>
            <button class="layui-btn" lay-filter="formSubmit" lay-submit>save</button>
            <button class="layui-btn" type="button" id="delEdit" onclick="del()">delete</button>
        </div>
    </form>
</script>


<script src="${request.contextPath}/layuiadmin/layui/layui.js"></script>
<script src="${request.contextPath}/layuiadmin/lib/echarts.min5.2.2.js"></script>
<script src='${request.contextPath}/fullcalendar/core/main.js'></script>
<script src='${request.contextPath}/fullcalendar/core/locales-all.js'></script>
<script src='${request.contextPath}/fullcalendar/daygrid/main.js'></script>
<script src='${request.contextPath}/fullcalendar/interaction/main.js'></script>
<script src='${request.contextPath}/fullcalendar/timegrid/main.js'></script>
<script src='${request.contextPath}/fullcalendar/core/locales/zh-cn.js'></script>
<script src='${request.contextPath}/fullcalendar/popper.min.js'></script>
<script src='${request.contextPath}/fullcalendar/tooltip.min.js'></script>
<script type="text/javascript" src="${request.contextPath}/assets/libs/layui/layui.all.js"></script>

<script>
    layui.use(['table','form','jquery','laydate'], function(){

        var addIndex;
        var roomId;
        var calendar;
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var laydate = layui.laydate;

        roomId = $("#room1").attr("roomId");
        $("#room1").css("backgroundColor", "#003399");

        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');

            calendar = new FullCalendar.Calendar(calendarEl, {
                plugins: [ 'interaction', 'dayGrid', 'timeGrid' ],
                defaultView: 'dayGridMonth',
                selectable: true,

                eventLimit: 4,
                displayEventEnd: true,
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'
                },
                events: function(info, successCallback, failureCallback) {
                    console.log('info',info)
                    $.get("/task/getByParams", {roomId: roomId, sTime: info.start.valueOf(), eTime: info.end.valueOf()}, function (res) {
                        if(res.code == 200) {
                            console.log(res)
                            for(var i=0;i<res.data.length;i++){
                                res.data[i].className=res.data[i].type
                            }
                            successCallback(res.data);
                        }else {
                            failureCallback(res.errStr);
                        }
                    });
                }
                ,eventClick: function(info) {
                    console.log('eventClick ' + info);
                    openEditLayer(info);
                }
                ,dateClick: function(info) {
                    console.log('dateClick ' + info.dateStr);
                    openLayer(info);
                }
                ,eventRender: function(info) {
                    var tooltip = new Tooltip(info.el, {
                        title: popContent(info.event.title, info.event.extendedProps.participants, info.event.start, info.event.end, info.event.extendedProps.content),
                        placement: 'top',
                        trigger: 'hover',
                        container: 'body',
                        html: true
                    });
                }
            });

            calendar.render();
        });

        function popContent(title, participants, stime, etime, content) {
            var sDate =new Date(stime);
            var s = sDate.getHours() + '：' + sDate.getMinutes() + '：';
            var eDate =new Date(etime);
            var e = eDate.getHours() + '：' + eDate.getMinutes() + '：';
            var str = '<div style="font-weight: bold;">' + title + '</div>';
            str += '<div style="height: 1px;background-color: black;"></div>'
            str += '<div style="text-align: left;">participants：' + participants + '</div>';
            str += '<div style="text-align: left;">time：' + s + ' -  ' + e + '</div>';
            str += '<div style="text-align: left;">content：' + content + '</div>'
            return str;
        }

        function initDateCtrl() {
            //timepicker
            laydate.render({
                elem: '#stime' //target elem
                ,type: 'time'
                ,format: 'HH:mm'
                ,trigger: 'click'
                ,lang:'en'
                ,done: function(value, date){
                    var etime = $("#etime").val();
                    var ehour = parseInt(etime.split(":")[0]);
                    var eminute = parseInt(etime.split(":")[1]);
                    var hour = date.hours;
                    var minute = date.minutes;
                    if(ehour < hour) {
                        $("#finishtime").val(value);
                    } else {
                        if(eminute < minute) {
                            $("#etime").val(value);
                        }
                    }
                }

            });

            laydate.render({
                elem: '#etime'
                ,type: 'time'
                ,format: 'HH:mm'
                ,trigger: 'click'
                ,lang:'en'
                ,done: function(value, date){
                    var stime = $("#stime").val();
                    var shour = parseInt(stime.split(":")[0]);
                    var sminute = parseInt(stime.split(":")[1]);
                    var hour = date.hours;
                    var minute = date.minutes;
                    if(shour > hour) {
                        $("#stime").val(value);
                    } else {
                        if(sminute > minute) {
                            $("#stime").val(value);
                        }
                    }
                }
            });
            form.render()
        }

        function openEditLayer(info){
            console.log('info',info)
            addIndex=layer.open({
                title : '<i class="fa fa-plus"></i>&nbsp;edit',
                type : 1,
                fix : false,
                // skin : 'layui-layer-rim',
                area : [ '470px', '505px' ],
                content : $('#calendarForm').html(),
                success: function (layero, index) {
                    initDateCtrl();
                    $("#delEdit").show();

                    var data = {};
                    data.id = info.event.id;
                    var sDate =new Date(info.event.start);
                    data.stime = sDate.getHours() + ':' + sDate.getMinutes() ;
                    var eDate =new Date(info.event.end);
                    data.etime = eDate.getHours() + ':' + eDate.getMinutes() ;
                    data.title = info.event.title;
                    data.participants = info.event.extendedProps.participants;
                    data.content = info.event.extendedProps.content;
                    data.type = info.event.extendedProps.type;
                    form.val('calendarForm', data);

                    form.on('submit(formSubmit)', function (d) {
                        var month=sDate.getMonth() + 1
                        if(month<10){
                            month='0'+month
                        }
                        var day=sDate.getDate()
                        if(day<10){
                            day='0'+day
                        }
                        var dataStr = sDate.getFullYear() + '-' + month + '-' +day;
                        // d.field.roomId = roomId;
                        d.field.stime = dataStr + " " + d.field.stime + ":00";
                        d.field.etime = dataStr + " " + d.field.etime + ":00";

                        $.ajax({
                            type: 'POST',
                            url: '/task/saveItem',
                            contentType: "application/json; charset=utf-8",
                            async: false,
                            data: JSON.stringify(d.field),
                            dataType: "json",
                            success: function (res) {
                                layer.closeAll("loading");
                                if(res.code == 200){
                                    calendar.refetchEvents();
                                    layer.closeAll('page');
                                }else{
                                    layer.msg(res.msg, {icon: 2});
                                }
                            }
                        });

                        return false;
                    });
                }
            });
        }

        function openLayer(info){
            addIndex=layer.open({
                title : '<i class="fa fa-plus"></i>&nbsp;add',
                type : 1,
                fix : false,
                // skin : 'layui-layer-rim',

                area : [ '470px', '505px' ],

                content : $('#calendarForm').html(),
                success: function (layero, index) {
                    initDateCtrl();
                    $("#delEdit").hide();
                    form.on('submit(formSubmit)', function (d) {
                        d.field.roomId = roomId;
                        d.field.stime = info.dateStr + " " + d.field.stime + ":00";
                        d.field.etime = info.dateStr + " " + d.field.etime + ":00";

                        $.ajax({
                            type: 'POST',
                            url: '${request.contextPath}/task/saveItem',
                            contentType: "application/json; charset=utf-8",
                            async: true,
                            data: JSON.stringify(d.field),
                            dataType: "json",
                            success: function (res) {
                                layer.closeAll("loading");
                                if(res.code == 200){
                                    layer.msg("success！", {icon: 1});
                                    calendar.refetchEvents();
                                    layer.closeAll();
                                }else{
                                    layer.msg(res.msg, {icon: 2});
                                }
                            }
                        });
                        return false;
                    });
                }
            });
        }

        function changeRoom(id){
            $(".external-event").each(function(i){
                if(this.id==id){
                    $(this).css("backgroundColor", "#003399");
                    roomId = $(this).attr("roomId");
                }else{
                    $(this).css("backgroundColor", "#3366CC");
                }
            });
            calendar.refetchEvents();
        }

        window.del=function(){
            var id=$("#id").val();
            layer.confirm('are you sure？', {
                offset: '65px',
                title: 'confirm',
                btn:['yes','no']
            }, function (i) {
                layer.close(i);
                layer.load(2);
                var param={}
                var ids=[]
                ids.push(id)
                param.ids=ids
                param.table='task'
                $.ajax({
                    type:"post",
                    url: "/deleteItemsByIds",
                    contentType:'application/json; charset=UTF-8',
                    data : JSON.stringify(param),
                    success: function(res) {
                        if(res.code===200){
                            layer.closeAll();
                            calendar.refetchEvents();

                        }
                    },
                    error: function(res) {
                        layer.alert(res.msg,{icon:2})
                    }
                })

            });
        }

        $('body').on('click', '*[ew-event]', function () {
            var event = $(this).attr('ew-event');
            if (event == 'closeDialog') {
                var id = $(this).parents('.layui-layer').attr('id').substring(11);
                layer.close(id);
            }
        });

    });

</script>

</body>
</html>