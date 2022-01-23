package com.zyjd.cts.util;

import java.util.HashMap;
import java.util.List;

/**
 * 流加载工具类
 */
public class FlowloadUtils {
    public static HashMap<String, Object> buildResult(Integer pages,List<?> data) {
        HashMap<String, Object> result=new HashMap<>();
        result.put("code", 0);// 状态码
        result.put("msg","");// 回调消息
        result.put("pages", pages);// 页码
        result.put("data",data);// 页面数据
        return result;
    }
}
