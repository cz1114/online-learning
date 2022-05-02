package com.demo.controller;

import com.demo.common.Result;

import com.demo.service.RouterService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
public class RouterController {
    @Autowired
    RouterService service;
    @RequestMapping("to/{page}")
    public String toPage(HttpServletRequest request, @PathVariable String page, Model model){
        String type = request.getParameter("type");
        String id = request.getParameter("id");
        if(!StringUtils.isEmpty(id)){
            Map param=new HashMap();
            param.put("table",page);
            param.put("id",id);
            Map item=service.getItemByParam(param);
            model.addAttribute("item",item);
        }
        model.addAttribute("page",page);
        if(StringUtils.isEmpty(type)){
            return "views/"+page+"/"+page+"List";
        }else {
            return "views/"+page+"/"+page+"Layer";
        }
    }

    @RequestMapping("getPageList")
    @ResponseBody
    public Result getPageList(@RequestBody Map param){
        int pageNum = (int) param.get("page");
        int limitNum = (int) param.get("limit");
        pageNum = (pageNum-1) * limitNum ;

        param.put("page", pageNum);
        param.put("limit", limitNum);
        System.out.println(param);
        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
        if(param.get("time")!=null&&!"".equals(String.valueOf(param.get("time")))){
            String timeAreaStr = param.get("time").toString();
            String starTimeStr=timeAreaStr.split(" - ")[0];
            String endTimeStr=timeAreaStr.split(" - ")[1];
            System.out.println(starTimeStr);
            System.out.println(endTimeStr);
            try {
                Date startTime=simpleDateFormat.parse(starTimeStr);
                Date endTime=simpleDateFormat.parse(endTimeStr);
                param.put("startTime",startTime);
                param.put("endTime",endTime);
            } catch (ParseException e) {
                e.printStackTrace();
            }

        }

        System.out.println(param);
        Map<String, Object> pageList = service.getPageList(param);
        return Result.ok().Data(pageList);
    }

    @RequestMapping("/saveItem")
    @ResponseBody
    public Result saveItem(@RequestBody Map item){
        System.out.println(item);
        service.saveItem(item);
        return Result.ok();
    }
    @RequestMapping("/deleteItemsByIds")
    @ResponseBody
    public Result deleteItemsByIds(@RequestBody Map param){
        service.deleteItemsByParam(param);
        return Result.ok();
    }


}
