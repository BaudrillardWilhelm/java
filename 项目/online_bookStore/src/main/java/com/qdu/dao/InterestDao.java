package com.qdu.dao;

import com.qdu.model.Book_info;
import com.qdu.model.Interest;

import java.util.List;

public interface InterestDao {
    Interest findInterestById(int uid);
}
