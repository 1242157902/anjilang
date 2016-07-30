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

import com.anjilang.entity.Book;
import com.anjilang.entity.DiseaseProject;
import com.anjilang.entity.FriendLink;
import com.anjilang.service.BookService;
import com.anjilang.util.AjlException;


@Controller
@RequestMapping("book")
public class BookController {
	@Autowired
	private BookService bookService;
	
	
	
	/**
	 * 书列表查询
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "list.do", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody
	String query(HttpServletRequest request) {
		List<Book> list=bookService.query();
		JSONArray jSONArray=JSONArray.fromObject(list);
		return jSONArray.toString();
	}
	
	/**
	 * 保存书
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "save.do", produces = { "application/json;charset=UTF-8" })
	public String save(HttpServletRequest request,  Model model) throws Exception {
		//1 获取参数
		String bookName=request.getParameter("bookname");
		String url=request.getParameter("bookurl");
		Book book=new Book();
		book.setBookname(bookName);
		book.setBookURL(url);
		
		//2 保存
		bookService.save(book);
		
		return "/managers/bookrecommendation/list";
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
		Book book=bookService.findById(new Long(id));
		model.addAttribute("book", book);
		
		//3 跳转页面
		return "/managers/bookrecommendation/edit";
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
		String name=request.getParameter("bookname");
		String Url=request.getParameter("bookurl");
		//2 查询
		Book book=bookService.findById(new Long(id));
		book.setAuthorname(name);
		book.setBookURL(Url);
		bookService.save(book);
		
		//3 跳转页面
		return "/managers/bookrecommendation/list";
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
				Book book=bookService.findById(new Long(ids[i]));
				bookService.delete(book);
			}
		}	
		
		//3 跳转页面
		return "/managers/bookrecommendation/list";
	}
}


