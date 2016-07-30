package com.anjilang.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.Information;
import com.anjilang.entity.InformationType;
import com.anjilang.service.InforService;
import com.anjilang.service.InforTypeService;

/**   
 * @Title: InforController.java 
 * @Package com.anjilang.controller 
 * @Description: 资讯管理
 * @author linqingsong
 * @date 2015-1-1 下午1:30:00 
 * @version V1.0   
 */
@Controller
@RequestMapping("infor")
public class InforController {
	@Autowired
	private InforService inforService;
	@Autowired
	private InforTypeService inforTypeService;
	
	/**
	 * 前台资讯列表
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "toInforChannel.do", produces = { "application/json;charset=UTF-8" })
	public String toInforChannel(HttpServletRequest request,  Model model) throws Exception {
		//1 查询所有分组信息
		List<InformationType>  listType=inforTypeService.query();
		//InformationType informationType=listType.get(0);

		//2 查询分组下资讯信息
		//2.1 获取当前显示的分组资讯ID
		//int typeId=informationType.getId().intValue();
		int typeId=0;
		String typeIds=request.getParameter("typeId");
		if(StringUtils.isNotBlank(typeIds)){
			typeId=Integer.parseInt(typeIds);
		}
		
		//2.2 分页查询
		int pageNo=1;
		String pageNos=request.getParameter("pageNo");
		if(StringUtils.isNotBlank(pageNos)){
			pageNo=Integer.parseInt(pageNos);
		}
		Map<String, Object> params=new HashMap<String,Object>();
		if(typeId!=0){
			params.put("typeId", typeId);
		}
		String order[]={"id"};
		PaginationSupport<Information> paginationSupport=inforService.queryPage(params, order, 10, pageNo);
		List<Information> listInfor=paginationSupport.getItems();
	
		//2.3 过滤html标签
		for(int i=0;i<listInfor.size();i++){
			Information information=listInfor.get(i);
			String content=information.getContent().replaceAll("<.*?>", "").replaceAll("&nbsp;", "").replaceAll("&mdash;", "");
			information.setContent(content);
		}
		
		//3 查询本月热点
		List<Information> listInforHot=inforService.queryHot();
		
		InformationType inforType=inforTypeService.findById(new Long(typeId));
		
		model.addAttribute("listType", listType);
		model.addAttribute("listInfor", listInfor);
		model.addAttribute("listInforHot", listInforHot);
		model.addAttribute("typeId", typeId);
		model.addAttribute("inforType", inforType);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageCount", paginationSupport.getPageCount());
		//model.addAttribute("paginationSupport", paginationSupport);
		
		
		//4 跳转页面
		return "/information/listInfor";
	}
	
	/**
	 * 资讯详细页
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "toInforDetail.do", produces = { "application/json;charset=UTF-8" })
	public String toInforDetail(HttpServletRequest request,  Model model) throws Exception {
		//1 获取资讯ID
		String ids=request.getParameter("id");
		
		//2 查询资讯
		Information information=inforService.findById(Long.parseLong(ids));
		model.addAttribute("information", information);
		
		//3 查询前一条数据
		List<Information> listInformationPrev=inforService.queryPrev(Long.parseLong(ids));
		if(listInformationPrev!=null){
			model.addAttribute("informationPrev", listInformationPrev.get(0));
		}
		
		//4 查询后一条数据
		List<Information> listInformationNext=inforService.queryNext(Long.parseLong(ids));
		if(listInformationNext!=null){
			model.addAttribute("informationNext", listInformationNext.get(0));
		}
		
		//5 查询本月热点
		List<Information> listInforHot=inforService.queryHot();
		model.addAttribute("listInforHot", listInforHot);
		
		//6查询当前咨询所属分类
		InformationType informationType=inforTypeService.findById(new Long(information.getTypeId()));
		model.addAttribute("informationType", informationType);
		
		//2 跳转页面
		return "/information/showInfor";
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
		String typeId=request.getParameter("typeId");
		List<Information> list=inforService.query(Integer.parseInt(typeId));
		JSONArray jSONArray=JSONArray.fromObject(list);
		return jSONArray.toString();
	}
	
	/**
	 * 资讯保存
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
		
		String content=request.getParameter("content");
		String typeId=request.getParameter("typeId");
		//2 保存
		Information information=new Information();
		information.setContent(content);
		information.setTitle(title);
		information.setTypeId(Integer.parseInt(typeId));
		Date date=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String crTime=sdf.format(date);
		information.setCrTime(crTime);
		
		inforService.save(information);
		
		//3 跳转页面
		model.addAttribute("typeId", typeId);
		return "redirect:/infor/toList.do";
	}
	
	
	
	/**
	 * 资讯修改
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "edit.do", produces = { "application/json;charset=UTF-8" })
	public String edit(HttpServletRequest request,  Model model) throws Exception {
		//1 获取数据
		String title=request.getParameter("title");
		if(StringUtils.isBlank(title)){
			throw new Exception("标题不能为空");
		}
		String id=request.getParameter("id");
		String content=request.getParameter("content");
		String typeId=request.getParameter("typeId");
		//2 保存
		Information information=inforService.findById(Long.parseLong(id));
		information.setContent(content);
		information.setTitle(title);
		information.setTypeId(Integer.parseInt(typeId));
		Date date=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String crTime=sdf.format(date);
		information.setCrTime(crTime);
		
		inforService.save(information);
		
		//3 跳转页面
		model.addAttribute("typeId", typeId);
		return "redirect:/infor/toList.do";
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
		String typeId=request.getParameter("typeId");
		
		//2 删除
		if(ids!=null && ids.length>0){
			for(int i=0;i<ids.length;i++){
				Information information=inforService.findById(new Long(ids[i]));
				inforService.delete(information);
			}
		}	
		
		//3 跳转页面
		model.addAttribute("typeId", typeId);
		return "redirect:/infor/toList.do";
	}
	
	/**
	 * 跳转到资讯列表
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "toList.do", produces = { "application/json;charset=UTF-8" })
	public String toList(HttpServletRequest request,  Model model) throws Exception {
		//1 获取数据
		String typeId=request.getParameter("typeId");
		model.addAttribute("typeId", typeId);
		//2 跳转页面
		return "/managers/information/list";
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
		Information information=inforService.findById(new Long(id));
		model.addAttribute("information", information);
		
		//3 跳转页面
		return "/managers/information/edit";
	}
	
	/**
	 * 跳转到资讯列表
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "toSave.do", produces = { "application/json;charset=UTF-8" })
	public String toSave(HttpServletRequest request,  Model model) throws Exception {
		//1 获取数据
		String typeId=request.getParameter("typeId");
		model.addAttribute("typeId", typeId);
		//2 跳转页面
		return "/managers/information/add";
	}
}
