package com.anjilang.controller.base;

import org.springframework.ui.Model;

import com.alibaba.fastjson.JSONObject;
import com.anjilang.util.AjlException;

public class BaseController {
	protected void success(Model model) {
		model.addAttribute("code", "0");
		model.addAttribute("msg", "成功");
	}
	
	protected void error(Model model, AjlException e) {
		model.addAttribute("code", e.getCode());
		model.addAttribute("msg", e.getMsg());
	}
	
	protected void success(JSONObject json) {
		json.put("code", "0");
		json.put("msg", "成功");
	}
	
	protected void error(JSONObject json, AjlException e) {
		json.put("code", e.getCode());
		json.put("msg", e.getMsg());
	}
}
