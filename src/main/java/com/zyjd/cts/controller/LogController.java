package com.zyjd.cts.controller;

import com.zyjd.cts.util.FlowloadUtils;
import com.zyjd.cts.model.Log;
import com.zyjd.cts.util.Layui;
import com.zyjd.cts.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/***
 * 日志信息
 * 后台操作处理
 */
@Controller
@RequestMapping("/log")
public class LogController {

    @Autowired
    private LogService logService;

    // 列表界面
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String List() {
        return "log/list/logList";
    }

    // 列表查询(分页)
    @RequestMapping(value = "/searchList", method = RequestMethod.POST)
    @ResponseBody
    public Layui SearchList(@RequestBody Log log) {
        // 设置地址
        log.setStart((log.getPage() - 1) * log.getLimit());
        // 查询记录
        List<Log> alls = logService.findByCondition(log);
        // 当页记录
        List<Log> logs = logService.findByConditionPage(log);
        if (logs != null && !logs.isEmpty()) {
            return Layui.data(alls.size(), logs);
        }
        return Layui.data(0, null);
    }

    // 列表查询(不分页)
    @RequestMapping(value = "/searchAll", method = RequestMethod.POST)
    @ResponseBody
    public Layui SearchAll(@RequestBody Log log) {
        List<Log> alls = logService.findByConditions(log);
        if (alls != null && !alls.isEmpty()) {
            return Layui.data(alls.size(), alls);
        }
        return Layui.data(0, null);
    }

    // 获取日志
    @RequestMapping(value = "/getList", method = RequestMethod.POST)
    @ResponseBody
    public List<Log> GetList(@RequestBody Log log) {
        return logService.findByConditions(log);
    }

    // 删除日志
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public String Delete(@RequestParam(value = "id") Integer id) {
        return String.valueOf(logService.delete(id));
    }
}
