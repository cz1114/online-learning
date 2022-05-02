package com.demo.service;

import com.demo.dao.TaskDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class TaskService {
    @Autowired
    private TaskDao dao;

    public Map<String,Object> getPageList(Map<String, Object> paramMap) {
        Long totalCount=dao.getTotalCount(paramMap);
        List<Map<String,Object>> data=dao.getMapListByParam(paramMap);

        Map<String,Object>resultMap=new HashMap<>();
        resultMap.put("data",data);
        resultMap.put("count",totalCount);
        resultMap.put("code",0);
        resultMap.put("msg","ok");
        return resultMap;
    }

    public void addItem(Map param) {
        dao.addItem(param);
    }
    public void updateItem(Map param) {
        dao.updateItem(param);
    }

    public void saveItem(Map param) {

        if(param.get("id")==null||param.get("id").toString()==""){
            dao.addItem(param);
        }else {
            dao.updateItem(param);
        }
    }

    public Map getItemByParam(Map param) {
        return dao.getItemByParam(param);
    }

    public void deleteItemsByParam(Map param) {
        List<String>ids= (List<String>) param.get("ids");
        String table = param.get("table").toString();
        dao.deleteItemsByParam(table,ids);
    }

    public Integer getMaxId(String categoryId) {
        return  dao.getMaxId(categoryId);
    }

    public List<Map> getAll() {
        return dao.getAll();
    }

    public List<Map> getByParams(String stime, String etime) {
        return dao.getByParams(stime,etime);
    }
}
