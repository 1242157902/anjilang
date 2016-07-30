package com.anjilang.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import com.anjilang.entity.User;
import com.anjilang.service.UserService;

public class SessionUtil {
	

	
	public static void loginSession(HttpServletRequest request, User user) {
		HttpSession session = request.getSession();
		if(user != null) {
			session.setAttribute("userId", user.getId());
			session.setAttribute("realName", user.getRealName());
			session.setAttribute("userName", user.getUserName());
			session.setAttribute("type", user.getType());
			session.setAttribute("phone", user.getPhone());
			session.setAttribute("header", user.getHeader());
			session.setAttribute("sex", user.getSex());
			session.setAttribute("project", user.getProject());
			session.setAttribute("title", user.getTitle());
			session.setAttribute("audit", user.getAudit());
			session.setAttribute("hospital", user.getHospital());
			
			session.setAttribute("user", user);
		}
	}
	
	public static void logoutSession(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("userId");
		session.removeAttribute("realName");
		session.removeAttribute("userName");
		session.removeAttribute("type");
		session.removeAttribute("phone");
		session.removeAttribute("header");
		session.removeAttribute("sex");
		session.removeAttribute("project");
		session.removeAttribute("title");
		session.removeAttribute("hospital");
		
		session.removeAttribute("user");
	}
	
	public static User getLoginUser(HttpServletRequest request){
		HttpSession session = request.getSession();
		User user = null;
		user = (User)session.getAttribute("user");
		return user;
	}
	
	public static boolean isLogined(HttpServletRequest request){
		HttpSession session = request.getSession();
		return null != session.getAttribute("userId");
	}
}
