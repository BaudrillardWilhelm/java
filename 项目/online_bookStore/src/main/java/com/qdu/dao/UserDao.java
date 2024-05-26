package com.qdu.dao;

import com.qdu.model.Users;

import java.util.List;

public interface UserDao {
    List<Users> getUserList();//获取所有用户
    Users findUserListById(int uid);//获取某个用户信息
    boolean haveThePeopleByUnameAndUpassword(String uname,String upassword);//根据用户名和密码判断用户是否存在
    boolean ifPeopleIsTheAdministratorsByUnameAndUpassword (String uname,String upassword);//判断这个用户是否为管理员且是否存在
}

