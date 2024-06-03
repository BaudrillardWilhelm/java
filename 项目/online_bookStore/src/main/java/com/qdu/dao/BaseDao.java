package com.qdu.dao;

/**
 * BaseDao用于包含所有Dao的共同操作
 *
 * @author Anna
 */
public interface BaseDao {

    //如果有接口和实现类，javadoc写在接口中的方法上
    /**
     * 执行指定的DML sql语句
     *
     * @param sql 字符串表示的要执行的sql语句
     * @param params sql语句需要的各个参数
     * @return 一个整数，表示受影响的行数，受影响1行返回1，受影响0行返回0，受影响n行返回n
     */
    int executeUpdate(String sql, Object... params);
}
