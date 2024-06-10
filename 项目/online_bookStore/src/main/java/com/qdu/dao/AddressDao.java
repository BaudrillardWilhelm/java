package com.qdu.dao;
import com.qdu.model.Address;
import com.qdu.model.Book_info;

import java.util.List;

public interface AddressDao {
    List<Address> findAddressListById(int bid);
}
