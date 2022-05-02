package com.demo.service;

import com.demo.bean.User;
import com.demo.dao.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserService {
    @Autowired
    UserDao dao;
    public User loginCheck(User user) {
        User originCustomer= dao.getUserByUserNameAndPassword(user);
        if(originCustomer==null){
            return null;
        }
        return originCustomer;
    }

    public void updateUser(User user) {
        dao.updateUser(user);
    }

    //    获取分页列表
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
    //保存数据，自动根据有无id判断是新增还是更新
    public void saveItem(Map item) {
        Object id = item.get("id");
        if(id==null||"".endsWith(id.toString())){
            dao.addItem(item);
        }else {
            dao.updateItem(item);
        }
    }


    public List<Map> getAll() {
        return dao.getAll();
    }

    public User getByloginname(String loginname) {
        return dao.getByloginname(loginname);
    }
}
