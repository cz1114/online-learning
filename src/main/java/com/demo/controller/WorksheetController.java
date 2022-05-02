package com.demo.controller;

import com.demo.common.Result;
import com.demo.service.WorksheetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("worksheet")
public class WorksheetController {
    @Autowired
    WorksheetService service;

    @RequestMapping("/saveWorksheet")
    @ResponseBody
    public Result saveItem(@RequestBody Map item){
        service.saveItem(item);
        return Result.ok();
    }
    @RequestMapping("/getByUserId")
    @ResponseBody
    public Result getByUserId(@RequestParam("userId") String userId){
        Map workSheet=service.getByUserId(userId);
        if(workSheet==null){
            return Result.ok().Data("");
        }
        return Result.ok().Data(workSheet);
    }

}
