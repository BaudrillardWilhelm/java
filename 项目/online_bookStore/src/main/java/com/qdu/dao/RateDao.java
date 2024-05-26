package com.qdu.dao;

import com.qdu.model.Address;
import com.qdu.model.Rate;

import java.util.List;

public interface RateDao {
    //查所有评论
    List<Rate> getAllRateList();

    //查个人的所有评论
    List<Rate> findRateListByUserId(int uid);

    //查图书所有的评论
    List<Rate> findRateListByBookId(int bid);
}
