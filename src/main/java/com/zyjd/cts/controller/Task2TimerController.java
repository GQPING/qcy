package com.zyjd.cts.controller;

import java.util.List;

import com.zyjd.cts.service.ContractDetailService;
import com.zyjd.cts.service.StageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import com.zyjd.cts.model.ContractDetail;
import com.zyjd.cts.util.mail.MailClient;
import cn.hutool.core.date.DateUtil;

/**
 * 邮箱发送租赁车辆到期信息
 * @author jishubu111
 *
 */
//@Controller
public class Task2TimerController {

    //@Autowired
    private MailClient mailClient;

    //@Autowired
    private ContractDetailService contractDetailService;

    // 定时任务执行方法
    // “0 0 12 * * ?” 每天中午十二点触发
    // “0 15 10 ? * *” 每天早上10：15触发
    // “0 15 10 * * ?” 每天早上10：15触发
    // “0 15 10 * * ? *” 每天早上10：15触发
    // “0 15 10 * * ? 2005” 2005年的每天早上10：15触发
    // “0 * 14 * * ?” 每天从下午2点开始到2点59分每分钟一次触发
    // “0 0/5 14 * * ?” 每天从下午2点开始到2：55分结束每5分钟一次触发
    // “0 0/5 14,18 * * ?” 每天的下午2点至2：55和6点至6点55分两个时间段内每5分钟一次触发
    // “0 0-5 14 * * ?” 每天14:00至14:05每分钟一次触发
    // “0 10,44 14 ? 3 WED” 三月的每周三的14：10和14：44触发
    // “0 15 10 ? * MON-FRI” 每个周一、周二、周三、周四、周五的10：15触发
    // "0/10 * * * * ?" 间隔10秒执行
    // "0 */1 * * * ?"每隔1分钟执行一次
    //@Scheduled(cron = "0 10 10 * * ?")
    public void execute() {
        StringBuilder title = new StringBuilder("【续租预警】拖地车租赁到期提醒");
        StringBuilder header = new StringBuilder("<h1>以下租赁车辆即将到期，请及时处理!</h1>\n\r"
                + "<table style='background-color: #dedede;text-align:center;"
                + "font-family:verdana,arial,sans-serif;font-size:14px;color:#333333;"
                + "border:1px solid #ccc'><thead>"
                + "<tr>"
                + "<th style='border-bottom:1px solid black;'>项目地址</th>"
                + "<th style='border-bottom:1px solid black;' width='150'>开始时间</th>"
                + "<th style='border-bottom:1px solid black;' width='150'>结束时间</th>"
                + "</tr>"
                + "</thead>"
                + "<tbody>");
        StringBuilder content = new StringBuilder("");
        ContractDetail condition = new ContractDetail();
        condition.setIsDeadLine(1);//设置到期检查
        condition.setPayState("未付清");//设置付款状态
        condition.getContract().setContractType("租赁");//设置合同类型
        condition.getContract().setContractState("正常");// 默认只查询正常合同的到期数据
        List<ContractDetail> contractDetails = contractDetailService.findByConditions(condition);
        if (contractDetails != null && !contractDetails.isEmpty()) {
            for(ContractDetail contractDetail : contractDetails) {
                content.append("<tr>"
                        + "<td style='border-bottom:1px solid #ccc;'>"+ contractDetail.getProjectAddress() +"</td>"
                        + "<td style='border-bottom:1px solid #ccc;'>"+ DateUtil.formatDate(contractDetail.getStartDate()) +"</td>"
                        + "<td style='border-bottom:1px solid #ccc;'>"+ DateUtil.formatDate(contractDetail.getFinalDate()) +"</td>"
                        + "</tr>");
            }
        }
        String footer = "</tbody></table>";
        header.append(content.toString());
        header.append(footer);
        mailClient.sendHtml("m15649865121@163.com", title.toString() , header.toString());// 指定邮箱发送，自行查找此API用法
    }
}
