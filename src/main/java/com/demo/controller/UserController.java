package com.demo.controller;

import com.demo.common.Result;
import com.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("user")
public class UserController {
    @Autowired
    UserService service;

    @RequestMapping("getPageList")
    public Result getPageList(@RequestBody Map param) {
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
    public Result saveItem(@RequestBody Map item){
        System.out.println(item);
        service.saveItem(item);
        return Result.ok();
    }

    @RequestMapping("/getAll")
    @ResponseBody
    public Result getAll(){
        List<Map> data= service.getAll();
        return Result.ok().Data(data);
    }


}
