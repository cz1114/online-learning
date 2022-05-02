package com.demo.controller;
import com.demo.common.Result;
import com.demo.service.TaskService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("task")
public class TaskController {

    @Resource
    private TaskService service;
    @RequestMapping("getPageList")
    @ResponseBody
    public Result getPageList(@RequestBody Map param){
        int pageNum = (int) param.get("page");
        int limitNum = (int) param.get("limit");
        pageNum = (pageNum-1) * limitNum ;

        param.put("page", pageNum);
        param.put("limit", limitNum);
        System.out.println(param);
        Map<String, Object> pageList = service.getPageList(param);
        return Result.ok().Data(pageList);
    }

    @RequestMapping("/saveItem")
    @ResponseBody
    public Result saveItem(@RequestBody Map param){
        service.saveItem(param);
        return Result.ok();
    }
    @RequestMapping("/deleteByIds")
    @ResponseBody
    public Result deleteItemsByIds(@RequestBody Map param){
        service.deleteItemsByParam(param);
        return Result.ok();
    }

    @RequestMapping("/getByParams")
    @ResponseBody
    public Result getByParams(@RequestParam("sTime") Long sTimeStr, @RequestParam("eTime")Long eTimeStr){

        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String stime=simpleDateFormat.format(new Date(sTimeStr));
        String etime=simpleDateFormat.format(new Date(eTimeStr));
        System.out.println(stime);
        List<Map> dataList= service.getByParams(stime,etime);

        return Result.ok().Data(dataList);
    }

}

