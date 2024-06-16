package com.qdu.dao;

import com.qdu.model.Users;

import java.util.List;

public interface UserDao {
    List<Users> getUserList();//获取所有用户
    Users findUserListById(int uid);//获取某个用户信息
    boolean haveThePeopleByUidAndUpassword(String uid, String upassword);//根据用户名和密码判断用户是否存在
    Users GetInformationByidAndPassword(String uid,String upassword);//通过用户名和密码获取用户信息
    String GetQuestionByPhone(String phone);//通过手机号找回密保名字
    boolean AnswerJudge(String answer,String question);//判断密保与回答是否对应
    String  GetPasswordByAnswerByQuestion(String answer,String question);//获取密码通过密保问题和答案
    boolean PushNewUser(Users in);//向数据库中添加新用户
    boolean HavePhone(String in);//检测该手机号是否注册过
    int GetUidByUnameAndUpassword(String uname,String upassword);
    void ChangePassword(String uid,String password);
    void ChangeQuestion(String uid,String Question);
    void ChangeAnswer(String uid,String Answer);
    void ChangeTrue_name(String uid,String True_name);
    void ChangeTel(String uid,String Tel);
    void ChangeE_mail(String uid,String E_mail);
    void ChangeCareer(String uid,String Career);
    void ChangeAddress(String uid,String Address);
    void ChangeMoney(String uid,String money);
    String GetMoney(String uid);
}

