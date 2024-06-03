package com.qdu.dao;
import com.qdu.model.Diary;
import java.util.List;

/**
 * Dao: Data Access Object 数据访问对象，专门用于操作数据库表的对象
 * <br>面向接口编程：定义和实现分离，方法定义/声明在接口中，方法的实现在类中
 * <br>创建DiaryDao接口，定义对Diary表的操作有哪些
 *
 * @author Anna
 */
public interface DiaryDao extends BaseDao {

    int insert(Diary d);
    
    Diary getOneById(String id);

    List<Diary> getAll();
    
    List<Diary> getAllBasicInfo();
}
