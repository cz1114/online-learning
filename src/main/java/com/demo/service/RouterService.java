package com.demo.service;



import com.demo.dao.RouterDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RouterService {
    @Autowired
    RouterDao dao;

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

    public void addItem(Map item) {
        dao.addItem(item);
    }
    public void updateItem(Map item) {
        dao.updateItem(item);
    }

    public void saveItem(Map item) {
        Object id = item.get("id");
        if(id==null||"".endsWith(id.toString())){
            dao.addItem(item);
        }else {
            dao.updateItem(item);
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

}
