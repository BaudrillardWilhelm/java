package com.qdu.service.impl;

import com.qdu.model.Diary;
import java.util.List;
import com.qdu.dao.impl.DiaryDaoImpl;
import com.qdu.dao.DiaryDao;
import com.qdu.service.DiaryService;

/**
 * DiaryService接口的实现类，包含了Diary相关业务功能的实现
 *
 * @author Anna
 */
public class DiaryServiceImpl implements DiaryService {

    DiaryDao diaryDao = new DiaryDaoImpl();

    @Override
    public Diary findDiaryById(String id) {
        return diaryDao.getOneById(id);
    }

    @Override
    public int addNewDiary(Diary d) {
        return diaryDao.insert(d);
    }

    @Override
    public List<Diary> findAllDiary() {
        return diaryDao.getAll();
    }

    @Override
    public List<Diary> findAllDiaryBasicInfo() {
        return diaryDao.getAllBasicInfo();
    }
}
