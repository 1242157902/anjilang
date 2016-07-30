package com.anjilang.controller;



import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.ArticleInfo;
import com.anjilang.entity.User;
import com.anjilang.entity.UserCaller;
import com.anjilang.service.ArticleInfoService;
import com.anjilang.service.UserCallerService;
import com.anjilang.service.UserService;
import com.anjilang.util.AjlException;
import com.anjilang.util.Constants;

/**   
 * @Title: ArticleInfoController.java 
 * @Package com.anjilang.controller 
 * @Description: 文章
 * @author liudb
 * @date 2015-1-6 上午9:32:00 
 * @version V1.0.0  
 */
@Controller
@RequestMapping("articleInfo")
public class ArticleInfoController {
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private ArticleInfoService articleInfoService;
	@Autowired
	private UserService userService;
	@Autowired
	private UserCallerService userCallerService;
	/**
	 * 跳转到查询页面
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "index.do", produces = { "application/json;charset=UTF-8" })
	public String toIndex(Model model) throws Exception {
		// 跳转页面
		return "/managers/articleInfo/index";
	}
	/**
	 * 分页查询文章
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "list.do", produces = { "application/json;charset=UTF-8" })
	public String toQuery(HttpServletRequest request,Integer pageSize, Model model) throws Exception {
		String userId = request.getParameter("userId");
		String pageNoStr = request.getParameter("pageNo");
		String id = request.getParameter("id");
		Map<String, Object> params=new HashMap<String,Object>();
		Integer pageNo = 1;
		pageSize = (pageSize == null) ? 5 : pageSize;
		pageNo = (pageNo == null) ? 1 : pageNo;
		if(userId != null){
			params.put("userId",Long.parseLong(userId) /*userService.queryUserById(Long.parseLong(userId))*/);
		}
		if(id != null && !"".equals(id)){
			params.put("id", Long.parseLong(id));
		}
		if(pageNoStr != null && !"".equals(pageNoStr)){
			pageNo = Integer.parseInt(pageNoStr);
		}
		User users=(User)request.getSession().getAttribute("user");
		if(users != null && users.getId()==Long.parseLong(userId)){
			model.addAttribute("authorityShow", "0");
		}
		Long userIds = Long.parseLong(userId);
		User user = userService.queryUserById(userIds);
		String[] order={"id"};
		PaginationSupport<ArticleInfo> infoList = articleInfoService.queryPage(params, order, 5, pageNo);
		model.addAttribute("infoList", infoList.getItems());
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("totalArticleCount", infoList.getTotalCount());
		model.addAttribute("pageCount", infoList.getPageCount());
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("user", user);
		model.addAttribute("userIds", userIds);
//		List<ArticleInfo>  hotInfo = articleInfoService.queryByHot();
//		String[] orderNum={"num"};
//		PaginationSupport<ArticleInfo> infoHotList = articleInfoService.queryPage(params, orderNum, 5, pageNo);
//		model.addAttribute("infoHotList", infoHotList.getItems());

		//获取最近10个访客
		Map<String,String> mapsUserCaller = new HashMap<String,String>();
		mapsUserCaller.put("userId", userId);
		List<UserCaller> userCallers = userCallerService.query(mapsUserCaller);
		model.addAttribute("userCallers", userCallers);
		model.addAttribute("totalCount", userCallerService.queryCount(mapsUserCaller));
		// 跳转页面
		return "/atricleInfo/listInfo";
	}
	/**
	 * 跳转到列表
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "queryHot.do", produces = { "application/json;charset=UTF-8" })
	public String toList(Long userId,String title,Integer pageNo,Integer pageSize, Model model) throws Exception {
		if(pageNo == null){
			pageNo = 1;
		}
		if(pageSize == null){
			pageSize = 10;
		}
		model.addAttribute("listInfo", articleInfoService.queryArticleInfo(userId, title, pageNo, pageSize));
		model.addAttribute("count", articleInfoService.countArticleInfo(userId, title));
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageSize", pageSize);
		// 跳转页面
		return "redirect:/managers/articleInfo/list";
	}

	/**
	 * 文章添加跳转
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "articleInfoAdd.do", produces = { "application/json;charset=UTF-8" })
	public String toAdd(HttpServletRequest request,  Model model) throws Exception {
		model.addAttribute("userId", request.getAttribute("userId"));
		return "atricleInfo/addArticleInfo";
	}
	/**
	 * 文章修改跳转
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "articleInfoToUpdate.do", produces = { "application/json;charset=UTF-8" })
	public String toUpdate(HttpServletRequest request,  Model model) throws Exception {
		String id = request.getParameter("id");
		String userId = request.getParameter("userId");
		ArticleInfo  info = articleInfoService.getById(Long.parseLong(id));
		if(info == null){
			log.error("修改文章失败：对象不存在，参数，id=" + id);
			model.addAttribute("message", "对象不存在");
			return "/managers/articleInfo/list";
		}
		model.addAttribute("articleInfo", info);
		model.addAttribute("userId", userId);
		return "/managers/personPage/updateArticleInfo";
	}
		
	/**
	 * 文章保存
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "articleInfoSave.do", produces = { "application/json;charset=UTF-8" })
	public String save(HttpServletRequest request,  Model model) throws Exception {
		//获取页面参数
		String content=request.getParameter("content");
		String title=request.getParameter("title");
		try{
			//设置文章信息
			ArticleInfo articleInfo = new ArticleInfo();
			articleInfo.setContent(content);
			articleInfo.setCreateDate(new Date());
			articleInfo.setNum(0);
			articleInfo.setTitle(title);
			//获取发布人
			User user = (User) request.getSession().getAttribute("user");
			articleInfo.setUserId(user.getId());
			articleInfoService.addArticleInfo(articleInfo);
			model.addAttribute("message", "文章发布成功");
			return "atricleInfo/skipInfo";
		}catch(Exception e){
			log.error("保存文章失败：" , e);
			model.addAttribute("message", "系统异常");
			return "atricleInfo/skipInfo";
		}
	}
	
	/**
	 * 文章修改
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "articleInfoModify.do", produces = { "application/json;charset=UTF-8" })
	public String update(HttpServletRequest request,  Model model) throws Exception {
		//获取页面参数
		String content=request.getParameter("content");
		String title=request.getParameter("title");
		String userId=request.getParameter("userId");
		String id=request.getParameter("id");
		try{
			model.addAttribute("userId", userId);
			ArticleInfo articleInfo = articleInfoService.getById(Long.parseLong(id));
			if(articleInfo == null){
				log.error("修改文章保存失败：对象不存在，参数，id=" + id);
				model.addAttribute("message", "对象不存在");
				return "atricleInfo/listInfo";
			}
			articleInfo.setContent(content);
			articleInfo.setTitle(title);
			articleInfo.setModifyDate(new Date());
			articleInfoService.modifyArticleInfo(articleInfo);
			model.addAttribute("message", "修改成功");
			return "atricleInfo/skipInfo";
		}catch(Exception e){
			log.error("修改文章保存失败：参数，id=" + id,e);
			model.addAttribute("message", "系统异常");
			return "atricleInfo/skipInfo";
		}
	}
	
	/**
	 * 文章删除
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping(value = "articleInfoDelect.do", produces = { "application/json;charset=UTF-8" })
	public String delect(HttpServletRequest request,  Model model) throws Exception {
		//获取页面参数
		String id=request.getParameter("id");
		try{
			articleInfoService.delectArticleInfo(Long.parseLong(id));
			return "00";
		}catch(AjlException e){
			log.error("删除文章失败，" , e);
		}
		return "01";
	}
	
	/**
	 * 文章详情
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "articleInfoView.do", produces = { "application/json;charset=UTF-8" })
	public String view(HttpServletRequest request,  Model model) throws Exception {
		//获取页面参数
		String id=request.getParameter("id");
		String userId=request.getParameter("userId");
		try{
			ArticleInfo articleInfo = articleInfoService.getById(Long.parseLong(id));
			User user = userService.queryUserById(articleInfo.getUserId());
			if(articleInfo!=null){
				model.addAttribute("articleInfo", articleInfo);
				model.addAttribute("userInfo", user);
			}else{
				log.error("获取文章详情失败：对象不存在，参数，id=" + id);
				model.addAttribute("message", "对象不存在");
				return "articleInfo/list";
			}
			//文章浏览量+1
			User userSession = (User) request.getSession().getAttribute("user");
			if(userSession==null || !userSession.getId().toString().equals(userId)){
				articleInfo.setNum(articleInfo.getNum()+1);
				articleInfoService.modifyArticleInfo(articleInfo);
			}
		}catch(Exception e){
			log.error("获取文章详情失败：对象不存在，参数，id=" + id);
		}
		return "atricleInfo/viewArticleInfo";
	}
	
	/**
	 * 文章浏览量+1
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "toArticleInfoNum.do", produces = { Constants.PRODUCES })
	public @ResponseBody
	String toArticleInfoNum(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		String userId = request.getParameter("userId");
		String articleInfoId = request.getParameter("articleInfoId");
		User user = (User) request.getSession().getAttribute("user");
		if(user == null || user.getId().toString().equals(userId)){
			return json.toJSONString();
		}
		try {
			ArticleInfo articleInfo = articleInfoService.getById(Long.parseLong(articleInfoId));
			if(articleInfo != null){
				articleInfo.setNum(articleInfo.getNum()+1);
				articleInfoService.modifyArticleInfo(articleInfo);
			}
		} catch (Exception e) {
			log.error("添加文章浏览量失败",e);
		}
		return json.toJSONString();
	}
	
}
