package com.demo.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public interface TaskDao {

    Long getTotalCount(Map<String, Object> paramMap);

    List<Map<String, Object>> getMapListByParam(Map<String, Object> paramMap);

    void addItem(Map param);

    void updateItem(Map param);

    Map getItemByParam(Map param);

    void deleteItemsByParam(@Param("table")String table,@Param("ids") List<String>ids);

    Integer getMaxId(@Param("categoryId") String categoryId);

    List<Map> getAll();

    List<Map> getByParams(@Param("stime") String stime,@Param("etime") String etime);
}

