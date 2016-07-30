package com.anjilang.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anjilang.entity.InformationType;
import com.anjilang.service.InforTypeService;

/**   
 * @Title: ControllerInformationType.java 
 * @Package com.anjilang.controller 
 * @Description: 咨询分组
 * @author linqingsong
 * @date 2014-12-28 下午10:51:52 
 * @version V1.0   
 */
@Controller
@RequestMapping("inforType")
public class InforTypeController {
	@Autowired
	private InforTypeService inforTypeService;
	
	/**
	 * 资讯分组保存
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "save.do", produces = { "application/json;charset=UTF-8" })
	public String save(HttpServletRequest request,  Model model) throws Exception {
		//1 获取数据
		String title=request.getParameter("title");
		if(StringUtils.isBlank(title)){
			throw new Exception("标题不能为空");
		}
		String detailTitle=request.getParameter("detailTitle");
		String detailContent=request.getParameter("detailContent");
		String url=request.getParameter("url");
		String picture=request.getParameter("picture");
		String num=request.getParameter("num");
		
		//2 保存
		InformationType informationType=new InformationType();
		informationType.setTitle(title);
		informationType.setDetailTitle(detailTitle);
		informationType.setDetailContent(detailContent);
		informationType.setUrl(url);
		informationType.setPicture(picture);
		if(num!=null && num.length()>0){
			informationType.setNum(Integer.parseInt(num));
		}else{
			informationType.setNum(0);
		}
		
		inforTypeService.save(informationType);
		
		//3 跳转页面
		return "/managers/information/listType";
	}
	
	/**
	 * 资讯分组删除
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "delete.do", produces = { "application/json;charset=UTF-8" })
	public String delete(HttpServletRequest request,  Model model) throws Exception {
		//1 获取数据
		String[] ids=request.getParameterValues("id");
		
		//2 删除
		if(ids!=null && ids.length>0){
			for(int i=0;i<ids.length;i++){
				InformationType informationType=inforTypeService.findById(new Long(ids[i]));
				inforTypeService.delete(informationType);
			}
		}	
		
		//3 跳转页面
		return "/managers/information/listType";
	}
	
	/**
	 * 跳转到编辑
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "toEdit.do", produces = { "application/json;charset=UTF-8" })
	public String toEdit(HttpServletRequest request,  Model model) throws Exception {
		//1 获取数据
		String id=request.getParameter("id");
		
		//2 查询
		InformationType informationType=inforTypeService.findById(new Long(id));
		model.addAttribute("informationType", informationType);
		
		//3 跳转页面
		return "/managers/information/editType";
	}
	
	/**
	 * 资讯分组保存
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "edit.do", produces = { "application/json;charset=UTF-8" })
	public String edit(HttpServletRequest request,  Model model) throws Exception {
		//1 获取数据
		String id=request.getParameter("id");
		String title=request.getParameter("title");
		if(StringUtils.isBlank(title)){
			throw new Exception("标题不能为空");
		}
		String detailTitle=request.getParameter("detailTitle");
		String detailContent=request.getParameter("detailContent");
		String url=request.getParameter("url");
		String picture=request.getParameter("picture");
		String num=request.getParameter("num");
		
		//2 保存
		InformationType informationType=inforTypeService.findById(new Long(id));
		informationType.setTitle(title);
		informationType.setDetailTitle(detailTitle);
		informationType.setDetailContent(detailContent);
		informationType.setUrl(url);
		informationType.setPicture(picture);
		
		if(num!=null && num.length()>0){
			informationType.setNum(Integer.parseInt(num));
		}else{
			informationType.setNum(0);
		}
		
		inforTypeService.save(informationType);
		
		//3 跳转页面
		return "/managers/information/listType";
	}
	
	/**
	 * 分组列表查询
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "queryAjax.do", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody
	String query(HttpServletRequest request) {
		List<InformationType> list=inforTypeService.query();
		JSONArray jSONArray=JSONArray.fromObject(list);
		return jSONArray.toString();
	}
}
