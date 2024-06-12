package com.qdu.service;

import com.qdu.model.Diary;
import java.util.List;

/**
 * DiaryService接口，定义Diary相关的业务功能的方法
 *
 * @author Anna
 */
public interface DiaryService {

    Diary findDiaryById(String id);

    int addNewDiary(Diary diary);
    
    List<Diary> findAllDiary();
    
    List<Diary> findAllDiaryBasicInfo();
}
