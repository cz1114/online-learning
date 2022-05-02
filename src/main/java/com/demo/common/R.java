package com.demo.common;

import lombok.Data;

import java.util.HashMap;
import java.util.Map;


@Data
public class R {

    private Boolean success;
    private Integer code;
    private String message;
    private Map<String,Object> data=new HashMap<>();

    public R (){};

    public static R ok(){
       R r = new R();
       r.setSuccess(true);
       r.setCode(ResultCode.SUCCESS);
       r.setMessage("success");
       return r;
    }

    public static R error(){
        R r = new R();
        r.setSuccess(false);
        r.setCode(ResultCode.ERROR);
        r.setMessage("error");
        return r;
    }


    public R success(Boolean success){
        this.setSuccess(success);
        return this;
    }

    public R Message(String message){
        this.setMessage(message);
        return this;
    }
    public R Data(String key,Object value){
        this.data.put(key,value);
        return this;
    }
    public R Data(Map<String,Object> data){
        this.setData(data);
        return this;
    }
    public R Code(Integer code){
        this.setCode(code);
        return this;
    }
}
