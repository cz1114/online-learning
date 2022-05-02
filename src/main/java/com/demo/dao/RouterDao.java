package com.demo.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public interface RouterDao {

    Long getTotalCount(Map<String, Object> paramMap);

    List<Map<String, Object>> getMapListByParam(Map<String, Object> paramMap);

    void addItem(Map item);

    void updateItem(Map item);

    Map getItemByParam(Map param);

    void deleteItemsByParam(@Param("table")String table,@Param("ids") List<String>ids);

}
