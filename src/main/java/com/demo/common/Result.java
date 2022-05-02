package com.demo.common;

import lombok.Data;


@Data
public class Result {
    private int code;
    private String msg;
    private Long count;
    private Object data;

    public static Result ok(){
        Result result = new Result();
        result.setCode(ResultCode.SUCCESS);
        result.setMsg("SUCCESS");
        return result;
    }

    public static Result error(){
        Result result = new Result();
        result.setCode(ResultCode.ERROR);
        result.setMsg("ERROR");
        return result;
    }

    public Result Data( Object obj){
        this.setData(obj);
        return this;
    }
    public Result count(Long count){
        this.setCount(count);
        return this;
    }
    public Result msg(String msg){
        this.setMsg(msg);
        return this;
    }
}
