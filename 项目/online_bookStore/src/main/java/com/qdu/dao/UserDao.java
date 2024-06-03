package com.qdu.dao;

import com.qdu.model.Users;

import java.util.List;

public interface UserDao {
    List<Users> getUserList();//获取所有用户
    Users findUserListById(int uid);//获取某个用户信息
    boolean haveThePeopleByUnameAndUpassword(String uname,String upassword);//根据用户名和密码判断用户是否存在
    Users GetInformationByNameAndPassword(String uname,String upassword);//通过用户名和密码获取用户信息
    String GetQuestionByPhone(String phone);//通过手机号找回密码
    boolean AnswerJudge(String answer,String question);//判断密保与回答是否对应
    String  GetPasswordByAnswerByQuestion(String answer,String question);
}

