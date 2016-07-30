package com.anjilang.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.anjilang.controller.base.BaseController;
import com.anjilang.entity.City;
import com.anjilang.service.CityService;
import com.anjilang.util.AjlException;
import com.anjilang.util.Validator;
@Controller
@RequestMapping("city")
public class CityController extends BaseController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private CityService cityService;
	
	@RequestMapping(value="queryChild.do", produces={"application/json;charset=UTF-8"})
	public @ResponseBody String queryCity(HttpServletRequest request,Long parentId) {
		JSONObject req = new JSONObject();
		req.put("parentId", parentId);
		
		JSONObject ret = new JSONObject();
		try{
			
			// 校验接口参数
			Validator.validator(request.getRequestURI(), req);
			List<City> cList = cityService.queryCityByParentId(parentId);
			if(cList != null) {
				JSONArray jSONArray=JSONArray.fromObject(cList);
				return jSONArray.toString();
			}
			success(ret);
		}catch(AjlException e) {
			error(ret, e);
		}catch(Throwable e) {
			log.error("查询城市列表失败parentId="+parentId, e);
			error(ret, AjlException.createErr("5003"));
		}
		return new JSONArray().toString();
	}
}
