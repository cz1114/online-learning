package com.demo.service;

import com.demo.dao.WorksheetDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Map;

@Service
public class WorksheetService {
    @Autowired
    WorksheetDao dao;

    //save data
    public void saveItem(Map item) {
        String userId=item.get("userId").toString();
        Map workSheet=dao.getByUserId(userId);
        if(workSheet==null){
            dao.addItem(item);
        }else {
            dao.updateItem(item);
        }
    }

    public Map getByUserId(String userId) {
        return dao.getByUserId(userId);
    }
}
