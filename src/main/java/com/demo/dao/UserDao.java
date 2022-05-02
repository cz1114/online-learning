package com.demo.dao;

import com.demo.bean.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public interface UserDao {
    User getUserByUserNameAndPassword(User user);

    void updateUser(User user);

    Long getTotalCount(Map<String, Object> paramMap);

    List<Map<String, Object>> getMapListByParam(Map<String, Object> paramMap);
    void addItem(Map item);
    void updateItem(Map item);
    List<Map> getAll();
    User getByloginname(@Param("loginname") String loginname);
}
