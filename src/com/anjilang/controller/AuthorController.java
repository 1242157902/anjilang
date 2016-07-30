package com.anjilang.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.Author;
import com.anjilang.entity.Book;
import com.anjilang.entity.Information;
import com.anjilang.entity.SpecCol;
import com.anjilang.service.AuthorService;
import com.anjilang.util.Constants;

@Controller
@RequestMapping("author")
public class AuthorController {
	private Logger log = Logger.getLogger(getClass());
	@Autowired
	private AuthorService authorService;
	
	/**
	 * 作者列表查询
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "list.do", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody
	String query(HttpServletRequest request) {
		List<Author> list=authorService.query();
		JSONArray jSONArray=JSONArray.fromObject(list);
		return jSONArray.toString();
	}
	
	
	/**
	 * 保存作者
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "save.do", produces = { "application/json;charset=UTF-8" })
	public String save(HttpServletRequest request,  Model model) throws Exception {
		//1 获取参数
		String name=request.getParameter("name");
		String profile=request.getParameter("profile");
		String url=request.getParameter("url");
		Author author=new Author();
		author.setName(name);
		author.setProfile(profile);
		author.setUrl(url);
		//2 保存
		authorService.save(author);
		
		return "/managers/author/list";
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
		Author author=authorService.findById(new Long(id));
		model.addAttribute("author", author);
		
		//3 跳转页面
		return "/managers/author/edit";
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
		String profile=request.getParameter("profile");
		String url=request.getParameter("url");
		//2 查询
		Author author=authorService.findById(new Long(id));
		author.setName(name);
		author.setProfile(profile);
		author.setUrl(url);
		authorService.save(author);
		
		//3 跳转页面
		return "/managers/author/list";
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
				Author author=authorService.findById(new Long(ids[i]));
				authorService.delete(author);
			}
		}	
		
		//3 跳转页面
		return "/managers/author/list";
	}
}
