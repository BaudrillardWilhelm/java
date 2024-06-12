package com.qdu.dao;

import com.qdu.model.Book_info;

import java.util.List;

public interface Book_infoDao {
    List<Book_info> getBook_infoList();
    Book_info findBookById(int bid);
}
