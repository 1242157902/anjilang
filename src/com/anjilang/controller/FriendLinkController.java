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

import com.anjilang.entity.FriendLink;
import com.anjilang.service.FriendLinkService;

/**   
 * @Title: FriendLinkController.java 
 * @Package com.anjilang.controller 
 * @Description: 友情链接
 * @author linqingsong
 * @date 2015-2-5 下午8:07:56 
 * @version V1.0   
 */
@Controller
@RequestMapping("friendLink")
public class FriendLinkController {
	@Autowired
	private FriendLinkService friendLinkService;
	
	/**
	 * 友情链接列表查询
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "queryAjax.do", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody
	String query(HttpServletRequest request) {
		List<FriendLink> list=friendLinkService.query();
		JSONArray jSONArray=JSONArray.fromObject(list);
		return jSONArray.toString();
	}
	/**
	 * 友情链接保存
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
		
		String url=request.getParameter("url");
		if(StringUtils.isBlank(url)){
			throw new Exception("url不能为空");
		}
		
		//2 保存
		FriendLink friendLink=new FriendLink();
		friendLink.setTitle(title);
		friendLink.setUrl(url);
		
		friendLinkService.save(friendLink);
		
		//3 跳转页面
		return "/managers/friendlink/list";
	}
	
	/**
	 * 友情链接删除
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
				FriendLink friendLink=friendLinkService.findById(new Long(ids[i]));
				friendLinkService.delete(friendLink);
			}
		}	
		
		//3 跳转页面
		return "/managers/friendlink/list";
	}
	
	/**
	 * 跳转到友情链接编辑
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
		FriendLink friendLink=friendLinkService.findById(new Long(id));
		model.addAttribute("friendLink", friendLink);
		
		//3 跳转页面
		return "/managers/friendlink/edit";
	}
	
	
	/**
	 * 友情链接修改
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
		
		String url=request.getParameter("url");
		if(StringUtils.isBlank(url)){
			throw new Exception("url不能为空");
		}
		
		//2 保存
		String id=request.getParameter("id");
		
		FriendLink friendLink=friendLinkService.findById(Long.parseLong(id));
		friendLink.setTitle(title);
		friendLink.setUrl(url);
		
		friendLinkService.save(friendLink);
		
		//3 跳转页面
		return "/managers/friendlink/list";
	}
}
