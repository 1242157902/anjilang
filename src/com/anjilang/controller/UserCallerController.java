package com.anjilang.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.anjilang.controller.base.BaseController;
import com.anjilang.entity.User;
import com.anjilang.entity.UserCaller;
import com.anjilang.service.UserCallerService;
import com.anjilang.service.UserService;
import com.anjilang.util.AjlException;
import com.anjilang.util.Constants;

@Controller
@RequestMapping("userCaller")
public class UserCallerController extends BaseController {
	private Logger log = Logger.getLogger(this.getClass());

	@Autowired
	private UserCallerService userCallerService;
	
	@Autowired
	private UserService userService;
	
	/**
	 * 获取个人资料
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "toUserCallerList.do", produces = { "application/json;charset=UTF-8" })
	public String queryUserCaller(HttpServletRequest request,  Model model) throws Exception {
		String userId = request.getParameter("userId");
		String pageSize = request.getParameter("pageSize");
		String pageNo = request.getParameter("pageNo");
		
		Map<String,String> maps = new HashMap<String,String>();
		maps.put("userId", userId);
		if(pageSize != null && !"".equals(pageSize)){
			maps.put("pageSize", pageSize);
		}else{
			maps.put("pageSize", "10");
		}
		if(pageNo != null && !"".equals(pageNo)){
			maps.put("pageNo", pageNo);
		}else{
			pageNo = "1";
		}
		
		List<UserCaller> userCallers = userCallerService.query(maps);
		model.addAttribute("userCallers", userCallers);
		model.addAttribute("totalCount", userCallerService.queryCount(maps));
		model.addAttribute("pageNo", pageNo);
		//3 跳转页面
		return "personPage/userCallers";
	}
	@RequestMapping(value = "toPersonCaller.do", produces = { Constants.PRODUCES })
	public @ResponseBody
	String topersonCaller(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		String userId = request.getParameter("userId");
		User user = (User) request.getSession().getAttribute("user");
		if(user != null && user.getId().toString().equals(userId)){
			return "";
		}
		try {
//			User userCaller = userService.queryUserById(Long.parseLong(userId));
			UserCaller caller = new UserCaller();
			caller.setCallerUserId(Long.parseLong(userId));
			if(user!=null){
				caller.setUser(user);
			}
			caller.setCrTime(new Date());
			userCallerService.save(caller);
		} catch (NumberFormatException e) {
			log.error("访客添加失败",e);
		} catch (AjlException e) {
			log.error("访客添加失败",e);
		} catch (Exception e) {
			log.error("访客添加失败",e);
		}
		return json.toJSONString();
	}
}
