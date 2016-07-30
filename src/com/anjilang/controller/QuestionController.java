package com.anjilang.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.anjilang.controller.base.BaseController;
import com.anjilang.controller.vo.Interlocution;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.Answer;
import com.anjilang.entity.DiseaseProject;
import com.anjilang.entity.Question;
import com.anjilang.entity.User;
import com.anjilang.service.AnswerService;
import com.anjilang.service.DiseaseProjectService;
import com.anjilang.service.QuestionService;
import com.anjilang.service.UserService;

@Controller
@RequestMapping("question")
public class QuestionController extends BaseController {
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private QuestionService questionService;
	
	@Autowired
	private UserService userService;
	@Autowired
	private AnswerService answerService;
	@Autowired
	private DiseaseProjectService projectService;
	/**
	 * 跳转到list页面
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "list.do", produces = { "application/json;charset=UTF-8" })
	public String toIndex(HttpServletRequest request,Integer pageNo,Integer pageSize, Model model) throws Exception {
		
		try{
			pageNo =pageNo == null?1:pageNo;
			pageSize =pageSize == null?5:pageSize;
			String userId = request.getParameter("userId");
			HashMap<String,String> map = new HashMap<String,String>();
			Long userIds = Long.parseLong(userId);
			User user = userService.queryUserById(userIds);
			List<DiseaseProject> projects = projectService.queryById(user.getProject().split(","));
			if(projects== null || projects.size()==0){
				model.addAttribute("isProjectNot", "1");
			}else{
				model.addAttribute("projects", projects);
			}
//			PaginationSupport<Question> questions= questionService.queryLatest(map);
			PaginationSupport<Interlocution>  listQues = questionService.queryAnswerByQueionId(userIds, pageNo, pageSize);
			
			
			model.addAttribute("pageNo", pageNo);
			model.addAttribute("userId", userId);
			model.addAttribute("user", user);
			model.addAttribute("pageSize", "5");
			model.addAttribute("listQues", listQues.getItems());
			model.addAttribute("pageCount", listQues.getPageCount());
			model.addAttribute("questionSum",questionService.queryAnswerNum(userIds));
			
		}catch(Exception e){
			log.error("问题查询失败：" , e);
			model.addAttribute("message", "系统异常");
			return "/question/listInfo";
		}
		return "questionInfo/listInfo";
	}
	/**
	 * 跳转到list页面
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "questionView.do", produces = { "application/json;charset=UTF-8" })
	public String toView(HttpServletRequest request,  Model model) throws Exception {
		try{
			String querstionId = request.getParameter("id");
			Map<String,Object> maps = new HashMap<String,Object>();
			maps.put("pageSize", 4);
			maps.put("pageNo", 1);
			maps.put("answerId", querstionId);
			List<Answer> listAnswer = answerService.queryByAny(maps);
			if(StringUtils.isNotBlank(querstionId)){
				Question questionInfo = questionService.findById(Long.parseLong(querstionId));
				model.addAttribute("userInfo",questionInfo.getUser());
				
				model.addAttribute("questionInfo", questionInfo);
			}
			model.addAttribute("listAnswer", listAnswer);
		}catch(Exception e){
			log.error("保存文章失败：" , e);
			model.addAttribute("message", "系统异常");
			return "questionInfo/questionView";
		}
		return "questionInfo/questionView";
	}
}
