/**  
 * @Title: PersonPage.java
 * @Package com.anjilang.controller
 * @author linqingsong
 * @date 2015年1月8日
 */
package com.anjilang.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anjilang.controller.vo.Interlocution;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.ArticleInfo;
import com.anjilang.entity.City;
import com.anjilang.entity.DiseaseProject;
import com.anjilang.entity.Picture;
import com.anjilang.entity.Question;
import com.anjilang.entity.User;
import com.anjilang.entity.UserCaller;
import com.anjilang.service.ArticleInfoService;
import com.anjilang.service.CityService;
import com.anjilang.service.DiseaseProjectService;
import com.anjilang.service.PictureService;
import com.anjilang.service.QuestionService;
import com.anjilang.service.UserCallerService;
import com.anjilang.service.UserService;

/**
 * ClassName: PersonPage 
 * @Description: 个人中心
 * @author linqingsong
 * @date 2015年1月8日
 */
@Controller
@RequestMapping("personPage")
public class PersonPageController {
	@Autowired
	private CityService cityService;
	@Autowired
	private PictureService pictureService;
	@Autowired
	private UserService userService;
	
	@Autowired
	private DiseaseProjectService projectService;
	
	@Autowired
	private QuestionService questionService;
	@Autowired
	private ArticleInfoService articleInfoService;
	@Autowired
	private UserCallerService userCallerService;
	/**
	 * 跳转到个人中心首页
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "toPersonPageIndex.do", produces = { "application/json;charset=UTF-8" })
	public String toPersonPageIndex(HttpServletRequest request,  Model model) throws Exception {
		//1 获取banner图片
		List<Picture> list=pictureService.query(4);
		if(list!=null && list.size()>0){
			int num=(int)(Math.random()*list.size());
			model.addAttribute("topPic", list.get(num).getPicUrl());
		}
		String userIds = request.getParameter("userId");
		Long userId = Long.parseLong(userIds);
		User user = userService.queryUserById(userId);
		City city = cityService.queryById(user.getCity());
		City province = cityService.queryById(user.getProvince());
		List<DiseaseProject> projects = projectService.queryById(user.getProject().split(","));
		model.addAttribute("user", user);
		model.addAttribute("city", city);
		model.addAttribute("province", province);
		if(projects== null || projects.size()==0){
			model.addAttribute("isProjectNot", "1");
		}else{
			model.addAttribute("projects", projects);
		}
		//Map<String, Object> params=new HashMap<String,Object>();
		//Integer pageNo = 1;
		//if(user != null){
		//	params.put("userId", user.getId());
		//}
		//String[] order = {"id"};
		Long answerNum = questionService.queryAnswerNum(userId);
		Map<String,String> maps = new HashMap<String,String>();
		maps.put("userId", userIds);
		model.addAttribute("answerNum",answerNum==null?0:answerNum);
//		PaginationSupport<ArticleInfo> infoList = articleInfoService.queryPage(params, order, 200000000, pageNo);
		model.addAttribute("articleNum",articleInfoService.queryCount(maps));
		model.addAttribute("agreeNum",userService.getTotelAgreeNum(userId));
		
		//4 跳转页面
		return "/personPage/personpage";
	}
	
	
	
	/**
	 * 后台个人中心首页顶部图片列表查询
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "queryTopPicBGAjax.do", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody
	String queryTopPicBG (HttpServletRequest request) {
		List<Picture> list=pictureService.query(4);
		JSONArray jSONArray=JSONArray.fromObject(list);
		return jSONArray.toString();
	}
	
	/**
	 * 个人主页顶部图片删除
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
				Picture picture=pictureService.findById(new Long(ids[i]));
				pictureService.delete(picture);
			}
		}	
		
		//3 跳转页面
		return "/managers/personPage/listTopPic";
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
		Picture picture=pictureService.findById(new Long(id));
		model.addAttribute("pictureTop", picture);
		
		//3 跳转页面
		return "/managers/personPage/editTopPic";
	}
	
	/**
	 * 个人中心顶部图片编辑
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "edit.do", produces = { "application/json;charset=UTF-8" })
	public String edit(HttpServletRequest request,  Model model) throws Exception {
		//1 获取数据
		String id=request.getParameter("id");
		String picUrl=request.getParameter("picture");
		
		//2 修改
		Picture picture=pictureService.findById(new Long(id));
		picture.setPicUrl(picUrl);
		pictureService.save(picture);
		
		//3 跳转页面
		return "/managers/personPage/listTopPic";
	}
	/**
	 * 跳转到查询页面
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "index.do", produces = { "application/json;charset=UTF-8" })
	public String toIndex(HttpServletRequest request,Model model) throws Exception {
		User user = (User) request.getAttribute("user");
		model.addAttribute("userInfo", user);
		// 跳转页面
		return "/personCore/personCoreMain";
	}
	
	
	/**
	 * 个人中心顶部图片编辑
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "save.do", produces = { "application/json;charset=UTF-8" })
	public String save(HttpServletRequest request,  Model model) throws Exception {
		//1 获取数据
		String picUrl=request.getParameter("picture");
		
		//2 修改
		Picture picture=new Picture();
		picture.setType(4);
		picture.setPicUrl(picUrl);
		pictureService.save(picture);
		
		
		//3 跳转页面
		return "/managers/personPage/listTopPic";
	}
	
	/**
	 * 查询问题
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 *//*
	@RequestMapping(value = "toPersonIndex.do", produces = { "application/json;charset=UTF-8" })
	public String toPersonIndex(HttpServletRequest request,  Model model) throws Exception {
		
		String userId = request.getParameter("userId");
		model.addAttribute("userId", userId);
		//4 跳转页面
		return "personPage/questionInfo";
	}*/
	/**
	 * 查询问题
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "toQuestionIndex.do", produces = { "application/json;charset=UTF-8" })
	public String toQuestionIndex(HttpServletRequest request,  Model model) throws Exception {
		
		String userIds = request.getParameter("userId");
		Long userId = Long.parseLong(userIds);
		User user = userService.queryUserById(userId);
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("pageNo", "1");
		map.put("pageNo", "2");
		map.put("userId", userId.toString());
		PaginationSupport<Question> questions= questionService.queryLatest(map);
		model.addAttribute("questions", questions.getItems());
		model.addAttribute("user", user);
		//4 跳转页面
		return "personPage/questionInfo";
	}
	/**
	 * 查询文章
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "toArticleIndex.do", produces = { "application/json;charset=UTF-8" })
	public String toArticleIndex(HttpServletRequest request,  Model model) throws Exception {
		String id = request.getParameter("userId");
		Map<String, Object> params=new HashMap<String,Object>();
		if(id != null && !"".equals(id)){
			params.put("user", Long.parseLong(id));
		}
		String[] order={"id"};
		PaginationSupport<ArticleInfo> infoList = articleInfoService.queryPage(params, order, 2, 1);
		model.addAttribute("infoList", infoList.getItems());
		//4 跳转页面
		return "personPage/listArticleInfo";
	}
	
	@RequestMapping(value = "toPersonIndex.do", produces = { "application/json;charset=UTF-8" })
	public String toPersonIndex(HttpServletRequest request,  Model model) throws Exception {
		
		String userIds = request.getParameter("id");
		Long userId = Long.parseLong(userIds);
		User user = userService.queryUserById(userId);
		//获取问答
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("pageNo", "1");
		map.put("userId", userId.toString());
		map.put("pageSize","2");
//		PaginationSupport<Question> questions= questionService.queryLatest(map);
		PaginationSupport<Interlocution>  listQues = questionService.queryAnswerByQueionId(userId, 1, 2);
		
		
		if(listQues.getItems().size()>0){
			model.addAttribute("isShow", "0");
		}
		model.addAttribute("listQues", listQues.getItems());
		//获取文章
		HashMap<String,Object> mapArticleInfo = new HashMap<String,Object>();
		mapArticleInfo.put("userId", user);
//		PaginationSupport<ArticleInfo> infoList = articleInfoService.queryPage(mapArticleInfo, new String[]{"id"}, 2, 1);
		List<ArticleInfo> infoList = articleInfoService.queryArticleInfo(userId, null, 1, 2);
		if(infoList != null && infoList.size()>0){
			model.addAttribute("isShowInfoList", "0");
		}
		model.addAttribute("articleInfo", infoList);
		model.addAttribute("user", user);
		//
		String pageSize = request.getParameter("pageSize");
		String pageNo = request.getParameter("pageNo");
		
		Map<String,String> mapsUserCaller = new HashMap<String,String>();
		mapsUserCaller.put("userId", userIds);
		if(pageSize != null && !"".equals(pageSize)){
			mapsUserCaller.put("pageSize", pageSize);
		}else{
			mapsUserCaller.put("pageSize", "10");
		}
		if(pageNo != null && !"".equals(pageNo)){
			mapsUserCaller.put("pageNo", pageNo);
		}else{
			pageNo = "1";
		}
		List<UserCaller> userCallers = userCallerService.query(mapsUserCaller);
		model.addAttribute("userCallers", userCallers);
		model.addAttribute("totalCount", userCallerService.queryCount(mapsUserCaller));
		model.addAttribute("pageNo", pageNo);
		//4 跳转页面
		return "personPage/personIndex";
	}
	@RequestMapping(value = "toPersonData.do", produces = { "application/json;charset=UTF-8" })
	public String toPersonData(HttpServletRequest request,  Model model) throws Exception {
		//1 获取营养师ID
		String id=request.getParameter("id");
		//2查询营养师相关信息；
		User user=userService.queryUserById(Long.parseLong(id));
		model.addAttribute("user", user);
		//3跳转页面；
		return "personPage/personData";
		
	}
	
}
