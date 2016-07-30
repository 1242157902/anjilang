package com.anjilang.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anjilang.controller.base.BaseController;
import com.anjilang.service.ServiceDemo;

@Controller
@RequestMapping("demo")
public class ControllerDemo  {
	@Autowired
	private ServiceDemo serviceDemo;
	
	@RequestMapping(value = "demo.do", produces = { "application/json;charset=UTF-8" })
	// model 向页面输出参数集合  方法可以简单数据类型 也可以是自定义的对象vo
	public String demo(HttpServletRequest request,  Model model) {
		model.addAttribute("name", "阿三");
		model.addAttribute("id", 1);
		// 跳转到WEB-INF/jsp/demo/demo.jsp页面
		return "/demo/demo";
	}
	// ajax 写法
	@RequestMapping(value = "demoAjax.do", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody
	String supportBankCardList(HttpServletRequest request) {
		
		return "{'id':1,'name':'阿三'}";
	}
	
}
