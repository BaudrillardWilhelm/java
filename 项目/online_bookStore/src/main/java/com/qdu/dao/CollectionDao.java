package com.qdu.dao;

import com.qdu.model.Collection;
import com.qdu.model.Rate;

import java.util.List;

public interface CollectionDao {
    int addCollection(Collection collection);
    List<Collection> getCollectionsByUserId(int uid);
    int removeCollection(int uid, int bid);
}
