package com.zyjd.cts.util;

import java.util.HashMap;
import java.util.List;

/**
 * layui加载类
 */
@SuppressWarnings("serial")
public class Layui extends HashMap<String, Object> {
    public static Layui data(Integer count,List<?> data){
        Layui r = new Layui();
        r.put("code", 200);//状态码
        r.put("msg", "");// 回调消息
        r.put("count", count);// 合计数量
        r.put("data", data);// 数据
        return r;
    }   
}
