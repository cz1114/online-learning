package com.demo.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public interface WorksheetDao {
    void addItem(Map item);
    void updateItem(Map item);

    Map getByUserId(@Param("userId") String userId);
}
