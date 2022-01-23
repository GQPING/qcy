package com.zyjd.cts.dao;

import java.util.List;

// 基础数据接口
public interface Base<T>{

    int add(T obj);// 增加

    int update(T obj);// 修改

    int delete(int id);// 删除

    List<T> findAll();// 查询全部

    T findById(int id);// 指定查询

    List<T> findByCondition(T obj);//模糊查询

    List<T> findByConditions(T obj);//条件查询

    List<T> findByConditionPage(T obj);//分页模糊查询

}
