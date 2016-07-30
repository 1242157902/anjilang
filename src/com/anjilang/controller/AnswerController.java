package com.anjilang.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.Answer;
import com.anjilang.entity.AnswerComment;
import com.anjilang.entity.DiseaseProject;
import com.anjilang.entity.Message;
import com.anjilang.entity.Question;
import com.anjilang.entity.User;
import com.anjilang.service.AnswerService;
import com.anjilang.service.DiseaseProjectService;
import com.anjilang.service.MessageService;
import com.anjilang.service.QuestionService;
import com.anjilang.service.UserService;
import com.anjilang.util.AjlException;
import com.anjilang.util.PropertyUtil;
import com.anjilang.util.SessionUtil;
import com.anjilang.util.StringUtil;

/**
 * @Title: AnswerController.java
 * @Package com.anjilang.controller
 * @Description: 问答
 * @author linqingsong
 * @date 2015-1-1 下午9:32:00
 * @version V1.0
 */
@Controller
@RequestMapping("answer")
public class AnswerController {
	@Autowired
	private DiseaseProjectService diseaseProjectService;
	@Autowired
	private QuestionService questionService;
	@Autowired
	private AnswerService answerService;
	@Autowired
	private UserService userService;

	@Autowired
	private MessageService messageService;

	private Logger log = Logger.getLogger(this.getClass());

	/**
	 * 跳转到编辑
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "index.do", produces = { "application/json;charset=UTF-8" })
	public String toIndex(HttpServletRequest request, Model model)
			throws Exception {

		String diseaseId = request.getParameter("disId");

		String queryType = request.getParameter("queryType");

		String pageNo = request.getParameter("pageNo");

		if (StringUtils.isBlank(pageNo)) {
			pageNo = "0";
		}

		// 1 查询疾病
		List<DiseaseProject> disList = diseaseProjectService.queryAll();
		model.addAttribute("disList", disList);

		// 2 查询问答

		// 2.1 查询最新回答
		HashMap<String, String> map = new HashMap<String, String>();

		// if(StringUtils.isBlank(queryType) || ("latest").equals(queryType)){
		map.put("diseaseId", diseaseId);
		map.put("pageNo", pageNo);
		PaginationSupport<Question> newQuestionList = questionService
				.queryLatest(map);
		model.addAttribute("newQuestionList", newQuestionList.getItems());

		log.info("newQuestionList：" + newQuestionList.getPageSize());
		// }
    
		
		
		// 2.2 查询最热回答
		map.clear();
		map.put("num", "0");
		map.put("diseaseId", diseaseId);
		map.put("pageNo", pageNo);
		PaginationSupport<Question> hotQuestionList = questionService
				.queryHotest(map);
		model.addAttribute("hotQuestionList", hotQuestionList.getItems());
		log.info("hotQuestionList：" + hotQuestionList.getPageSize());

		// 2.3 查询待解答回答

		map.clear();
		map.put("answerNum", "0");
		map.put("diseaseId", diseaseId);
		map.put("pageNo", pageNo);
		PaginationSupport<Question> unQuestionList = questionService
				.queryUnAnswerd(map);
		model.addAttribute("unQuestionList", unQuestionList.getItems());
		log.info("unQuestionList：" + unQuestionList.getPageSize());
		
		model.addAttribute("topUserList",userService.queryTopAnswerUser(6, 0).getItems());

		String lenStr =  String.valueOf(questionService.queryAll().size() +1234);
		char[] numbers = lenStr.toCharArray();
		model.addAttribute("numbers", numbers);
		model.addAttribute("ansNumbers", questionService.queryTodayAnswerdQuestion().size() +99);
		// 3 跳转页面
		return "/answer/answerIndex";
	}

	/**
	 * 跳转到问题回答页面
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "answer.do", produces = { "application/json;charset=UTF-8" })
	public String toAnswerContent(HttpServletRequest request, Model model,
			@RequestParam(value = "questionId") String questionId)
			throws Exception {
		// 1、查询问答
		List<Answer> listAnswers = answerService.queryByQuestionId(Long
				.parseLong(questionId));
		model.addAttribute("answerList", listAnswers);

		// 2、查询相关疾病的问题
		DiseaseProject diseaseProject = questionService.findById(
				Long.parseLong(questionId)).getDisease();
		HashMap<String, String> map = new HashMap<String, String>();
		if (null != diseaseProject) {
			map.put("diseaseId", String.valueOf(diseaseProject.getId()));
		}
		// 取最新的5条记录
		map.put("pageSize", "5");
		map.put("pageNo", "0");

		PaginationSupport<Question> questionList = questionService
				.queryLatest(map);
		model.addAttribute("questionList", questionList.getItems());

		Question question = questionService
				.findById(Long.parseLong(questionId));
		int oldNum = question.getNum();
		// 问题浏览数加1
		question.setNum(oldNum + 1);
		question = answerService.updateQuestion(question);
		model.addAttribute("question", question);
		
		String lenStr =  String.valueOf(questionService.queryAll().size()+1234);
		char[] numbers = lenStr.toCharArray();
		model.addAttribute("numbers", numbers);
		model.addAttribute("ansNumbers", questionService.queryTodayAnswerdQuestion().size()+99);

		// 3 跳转页面
		return "/answer/answerContent";
	}

	/**
	 * 更多列表查询，供页面ajax调用
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "queryAjax.do", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody
	String query(HttpServletRequest request) {

		// 查询疾病ID
		String diseaseId = request.getParameter("disId");

		// 查询类型
		String queryType = request.getParameter("queryType");

		// 查询分页序号
		String pageNo = request.getParameter("pageNo");

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("diseaseId", diseaseId);
		map.put("pageNo", pageNo);
		JSONArray jSONArray = new JSONArray();

		JsonConfig jsonConfig = new JsonConfig();
		//jsonConfig.setExcludes(new String[] { "answers" });
		jsonConfig.setIgnoreDefaultExcludes(false);
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);

		// 1、最新问题
		if (StringUtils.isBlank(queryType) || ("latest").equals(queryType)) {
			PaginationSupport<Question> newQuestionList = questionService
					.queryLatest(map);
			jSONArray = JSONArray.fromObject(newQuestionList, jsonConfig);
		}

		// 2、 查询最热回答
		if (StringUtils.isBlank(queryType) || ("hotest").equals(queryType)) {
			PaginationSupport<Question> hotQuestionList = questionService
					.queryHotest(map);
			jSONArray = JSONArray.fromObject(hotQuestionList, jsonConfig);
		}

		// 3 、查询待解答回答
		if (StringUtils.isBlank(queryType) || ("unAnswerd").equals(queryType)) {
			PaginationSupport<Question> unQuestionList = questionService
					.queryUnAnswerd(map);
			jSONArray = JSONArray.fromObject(unQuestionList, jsonConfig);
			// jSONArray=JSONArray.fromObject(unQuestionList.getItems());

		}
		return jSONArray.toString();

	}

	@RequestMapping(value = "addAnswer.do", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody
	String addAnswer(HttpServletRequest request) throws AjlException {
		String questionId = request.getParameter("questionId");
		String content = request.getParameter("content");
		User user = SessionUtil.getLoginUser(request);
		Answer answer = answerService.addAnswer(Long.parseLong(questionId),
				content, user, new Date());
		JSONObject json = new JSONObject();
		json.put("answer", JSON.toJSONString(answer));
		// 增加问题回答记录数
		Question question = answerService.findQuestionById(Long
				.parseLong(questionId));
		int newAnsNum = question.getAnswerNum() + 1;
		question.setAnswerNum(newAnsNum);
		question = answerService.updateQuestion(question);
		
		json.put("questionNum", question.getAnswerNum());
		if(null!=user && "1".equals(user.getType())){
			int answerNum = user.getAnswerNum();
			user.setAnswerNum(answerNum+1);
			userService.update(user);
		}

		return json.toJSONString();
	}

	@RequestMapping(value = "queryComment.do", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody
	String queryComment(HttpServletRequest request) {
		String answerId = request.getParameter("answerId");
		List<AnswerComment> list = answerService.queryCommentsByAnswer(Long
				.parseLong(answerId));
		JSONArray jSONArray = new JSONArray();
		jSONArray = JSONArray.fromObject(list);
		return jSONArray.toString();
	}

	@RequestMapping(value = "addQuestion.do", produces = { "application/json;charset=UTF-8" })
	public String toAddQuestion(HttpServletRequest request, Model model)
			throws Exception {
		// 1 查询分组
		List<DiseaseProject> diseaseList = diseaseProjectService.queryAll();
		model.addAttribute("diseaseList", diseaseList);

		// 2 随机获取9位医生
		List<User> userList = userService.queryUserByAudit("2", "1");

		if (userList.size() <= 9) {
			model.addAttribute("userList", userList);
		} else {
			List<User> lit = new ArrayList<User>();
			for (int i = 0; i < 9; i++) {
				int num = (int) (Math.random() * userList.size());
				User ust = userList.get(num);
				lit.add(ust);
				userList.remove(num);
			}

			model.addAttribute("userList", lit);
		}

		model.addAttribute("totelDoc", userList.size());

		// 3 查询所有的问题
		List<Question> lit = questionService.queryAll();
		model.addAttribute("totelQuestion", lit.size());
	
		model.addAttribute("doctorUserId", request.getParameter("doctorUserId"));

		// 4 跳转页面
		return "/answer/addQuestion";
	}

	@RequestMapping(value = "toModifyQuetion.do", produces = { "application/json;charset=UTF-8" })
	public String toModifyQuestion(HttpServletRequest request, Model model,@RequestParam(value = "id") String id)
			throws Exception {
		// 1 查询分组
		List<DiseaseProject> diseaseList = diseaseProjectService.queryAll();
		model.addAttribute("diseaseList", diseaseList);
		Question question = questionService.findById(Long.parseLong(id));

		// 2 随机获取9位医生
		List<User> userList = userService.queryUserByAudit("2", "1");

		if (userList.size() <= 9) {
			model.addAttribute("userList", userList);
		} else {
			List<User> lit = new ArrayList<User>();
			for (int i = 0; i < 9; i++) {
				int num = (int) (Math.random() * userList.size());
				User ust = userList.get(num);
				lit.add(ust);
				userList.remove(num);
			}

			model.addAttribute("userList", lit);
		}

		model.addAttribute("totelDoc", userList.size());

		// 3 查询所有的问题
		List<Question> lit = questionService.queryAll();
		model.addAttribute("totelQuestion", lit.size());
		model.addAttribute("question", question);
	
		model.addAttribute("doctorUserId", request.getParameter("doctorUserId"));

		// 4 跳转页面
		return "/answer/modifyQuestion";
	}
	
	
	@RequestMapping(value = "modifyQuestion.do", produces = { "application/json;charset=UTF-8" })
	public String modifyQuestion(HttpServletRequest request, Model model)
			throws Exception {
		String diseaseId = request.getParameter("disId");
		String title = request.getParameter("title");
		String picure = request.getParameter("picture");
		String content = request.getParameter("content");
		String id = request.getParameter("id");
		Question question = questionService.findById(Long.parseLong(id));
		if (!StringUtil.isEmpty(diseaseId)) {
			DiseaseProject diProject = diseaseProjectService.findById(Long
					.parseLong(diseaseId));
			if (null != diProject) {
				question.setDisease(diProject);
			}
		}
		// question.setTitle(title);
		// 提问者
		User user = SessionUtil.getLoginUser(request);
		question.setContent(content);
		question.setPicture(picure);
		question.setTitle(title);
		questionService.modifyQuestion(question);

		// 增加一条消息发给医生。
		Long userId = null;
		try {
			// 获取被提问医生
			String doctorUserId = request.getParameter("doctorUserId");
			userId = Long.parseLong(doctorUserId);
		} catch (Exception e) {
		}
		// 3 跳转页面
		return "redirect:/answer/index.do";
	}
	
	@RequestMapping(value = "addNewQuestion.do", produces = { "application/json;charset=UTF-8" })
	public String addQuestion(HttpServletRequest request, Model model)
			throws Exception {
		String diseaseId = request.getParameter("disId");
		String title = request.getParameter("title");
		String picure = request.getParameter("picture");
		String content = request.getParameter("content");
		Question question = new Question();
		if (!StringUtil.isEmpty(diseaseId)) {
			DiseaseProject diProject = diseaseProjectService.findById(Long
					.parseLong(diseaseId));
			if (null != diProject) {
				question.setDisease(diProject);
			}
		}
		// question.setTitle(title);
		// 提问者
		User user = SessionUtil.getLoginUser(request);
		question.setContent(content);
		question.setPicture(picure);
		question.setCrTime(new Date());
		question.setTitle(title);
		question.setUser(user);
		questionService.save(question);

		// 增加一条消息发给医生。
		Long userId = null;
		try {
			// 获取被提问医生
			String doctorUserId = request.getParameter("doctorUserId");
			userId = Long.parseLong(doctorUserId);
		} catch (Exception e) {
		}
		if (userId != null) {
			// 消息 是toUserId发送给fromUserId
			Message msg = new Message();
			msg.setFromUserId(userId);
			msg.setToUserId(user.getId());
			msg.setIsRead(0);
			msg.setType(1);
			msg.setCreateTime(new Date());
			msg.setTitle("用户" + user.getRealName() + "向您提问");
			String url = PropertyUtil.newInstans().getValue("url");
			log.info("工程地址:" + url);
			url += "answer/answer.do?questionId=" + question.getId();
			log.info("查看提问地址:" + url);
			msg.setContent("用户" + user.getRealName() + "向您提问,<a href=\"" + url
					+ "\">点击查看详情</a>");
			// 保存站内信息
			messageService.save(msg);
		}
		// 3 跳转页面
		return "redirect:/answer/index.do";
	}

	/**
	 * 添加回复
	 * 
	 * @param request
	 * @return
	 * @throws AjlException
	 */
	@RequestMapping(value = "addAnswerComment.do", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody
	String addAnswerComment(HttpServletRequest request) throws AjlException {
		String answerId = request.getParameter("answerId");
		String parentId = request.getParameter("parentId");
		String content = request.getParameter("content");
		JSONObject json = new JSONObject();
		if (StringUtil.isEmpty(parentId)) {
			parentId = "0";
		}
		AnswerComment comment = new AnswerComment();
		comment.setAnswerId(Long.parseLong(answerId));
		comment.setContent(content);
		comment.setCrTime(new Date());
		comment.setUser(SessionUtil.getLoginUser(request));
		comment.setParentId(Long.parseLong(parentId));
		AnswerComment answerComment = answerService.saveAnswerComment(comment);
		json.put("comment", JSON.toJSONString(answerComment));

		Answer answer = answerService.queryAnswerById(Long.parseLong(answerId));
		int commentNum = answer.getCommentNum();
		answer.setCommentNum(commentNum + 1);
		answer = answerService.modify(answer);
		json.put("answer", JSON.toJSONString(answer));
		return json.toJSONString();
	}

	/**
	 * 回答点赞
	 * 
	 * @param request
	 * @return
	 * @throws AjlException
	 */
	@RequestMapping(value = "addAnswerAgreeNum.do", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody
	String addAnswerAgreeNum(HttpServletRequest request,
			@RequestParam(value = "answerId") String answerId)
			throws AjlException {
		JSONObject json = new JSONObject();

		Answer answer = answerService.queryAnswerById(Long.parseLong(answerId));
		int agreeNum = answer.getAgreeNum();
		answer.setAgreeNum(agreeNum + 1);
		answer = answerService.modify(answer);
		json.put("answerNum", JSON.toJSONString(answer.getAgreeNum()));
		return json.toJSONString();
	}

	/**
	 * 删除回复
	 * 
	 * @param request
	 * @return
	 * @throws AjlException
	 */
	@RequestMapping(value = "deleteAnswerComment.do", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody
	String deleteAnswerComment(HttpServletRequest request,
			@RequestParam(value = "id") String id) {
		JSONObject json = new JSONObject();
		try {
			answerService.deleteCommentById(Long.parseLong(id));
			json.put("result", "1");
		} catch (Exception e) {
			log.error("delete comment error", e);
			json.put("result", "0");
		}
		return json.toJSONString();

	}

	/**
	 * 删除问题
	 * 
	 * @param request
	 * @return
	 * @throws AjlException
	 */
	@RequestMapping(value = "deleteQuestion.do", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody
	String deleteQuestion(HttpServletRequest request,
			@RequestParam(value = "id") String id) {
		JSONObject json = new JSONObject();
		try {
			answerService.deleteQuestionById(Long.parseLong(id));
			json.put("result", "1");
			json.put("url", "/answer/index.do");
		} catch (Exception e) {
			log.error("delete answer error", e);
			json.put("result", "0");
			json.put("errInfo", e.getMessage());
		}
		return json.toJSONString();

	}
	
	/**
	 * 删除回答
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "deleteAnswer.do", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody
	String deleteAnswer(HttpServletRequest request,
			@RequestParam(value = "id") String id) {
		JSONObject json = new JSONObject();
		try {
			answerService.deleteAnswerById(Long.parseLong(id));
			json.put("result", "1");
			json.put("url", "/answer/index.do");
		} catch (Exception e) {
			log.error("delete answer error", e);
			json.put("result", "0");
			json.put("errInfo", e.getMessage());
		}
		return json.toJSONString();
		
	}
}
