package com.zyjd.cts.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;
import cn.hutool.core.date.DateUtil;
import com.zyjd.cts.model.*;
import com.zyjd.cts.service.*;
import com.zyjd.cts.util.QcyConstants;
import com.zyjd.cts.util.TreeVo;
import com.zyjd.cts.vo.SalesBean;
import com.zyjd.cts.vo.UnitsBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/***
 * 控制器帮助类
 */
@Controller
public class HelperController {

	@Autowired
	private LogService logService;

	// UserID静态记录
	public  static Integer UserID = 0;

	// IP静态记录
	public  static String IPAddress = "";

	// 保存UserID(登录成功时设置)
	public void SetUserID(Integer userID) {
		UserID = userID;
	}

	// 保存IP地址
	public void SetRemoteIP(HttpServletRequest request) {
		String ip = "127.0.0.1";
		if (request.getHeader("x-forwarded-for") == null)
		{
			ip= request.getRemoteAddr();
		}else{
			ip = request.getHeader("x-forwarded-for");
		}
		IPAddress =ip;
	}

	// 日志记录(添加日志记录，目前只有登录日志)
	public void Logs(String operateDetail) {
		logService.add(new Log(UserID,operateDetail,IPAddress,new Date()));
	}
}
