package com.anjilang.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anjilang.entity.DiseaseProject;
import com.anjilang.service.DiseaseProjectService;
import com.anjilang.util.AjlException;

/**   
 * @Title: DiseaseProjectController.java 
 * @Package com.anjilang.controller 
 * @Description: 疾病管理
 * @author linqingsong
 * @date 2015-1-1 下午8:36:29 
 * @version V1.0   
 */
@Controller
@RequestMapping("disease")
public class DiseaseProjectController {
	
	@Autowired
	private DiseaseProjectService diseaseProjectService;
	
	/**
	 * 查询疾病列表
	 * @param request
	 * @param model
	 * @return
	 * @throws AjlException 
	 * @throws Exception
	 */
	@RequestMapping(value = "queryAjax.do", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody
	String query(HttpServletRequest request) throws AjlException {
		List<DiseaseProject> list=diseaseProjectService.queryAll();
		JSONArray jSONArray=JSONArray.fromObject(list);
		return jSONArray.toString();
	}
	
	/**
	 * 疾病保存
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "save.do", produces = { "application/json;charset=UTF-8" })
	public String save(HttpServletRequest request,  Model model) throws Exception {
		//1 获取参数
		String diseaseName=request.getParameter("name");
		String picture=request.getParameter("picture");
		DiseaseProject diseaseProject=new DiseaseProject();
		diseaseProject.setDiseaseName(diseaseName);
		Date date=new Date();
		/*SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String crTime=sdf.format(date);*/
		diseaseProject.setCreateTime(date);
		diseaseProject.setPicUrl(picture);
		
		//2 保存
		diseaseProjectService.save(diseaseProject);
		
		return "/managers/disease/list";
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
		DiseaseProject diseaseProject=diseaseProjectService.findById(new Long(id));
		model.addAttribute("diseaseProject", diseaseProject);
		
		//3 跳转页面
		return "/managers/disease/edit";
	}
	
	/**
	 * 编辑
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "edit.do", produces = { "application/json;charset=UTF-8" })
	public String edit(HttpServletRequest request,  Model model) throws Exception {
		//1 获取数据
		String id=request.getParameter("id");
		String name=request.getParameter("name");
		String picUrl=request.getParameter("picture");
		//2 查询
		DiseaseProject diseaseProject=diseaseProjectService.findById(new Long(id));
		diseaseProject.setDiseaseName(name);
		diseaseProject.setPicUrl(picUrl);
		diseaseProjectService.save(diseaseProject);
		
		//3 跳转页面
		return "/managers/disease/list";
	}
	
	
	/**
	 * 疾病删除
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
				DiseaseProject diseaseProject=diseaseProjectService.findById(new Long(ids[i]));
				diseaseProjectService.delete(diseaseProject);
			}
		}	
		
		//3 跳转页面
		return "/managers/disease/list";
	}
}
