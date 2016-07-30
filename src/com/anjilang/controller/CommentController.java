package com.anjilang.controller;

import java.util.ArrayList;
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
import com.anjilang.entity.AnswerComment;
import com.anjilang.entity.Comment;
import com.anjilang.entity.ReplyComment;
import com.anjilang.entity.ReplyCommentSort;
import com.anjilang.entity.SpecCol;
import com.anjilang.entity.User;
import com.anjilang.service.AnswerService;
import com.anjilang.service.CommentService;
import com.anjilang.util.Constants;
import com.anjilang.util.SessionUtil;

@Controller
@RequestMapping("comment")
public class CommentController {
	@Autowired
	private CommentService commentService;
	@Autowired
	private AnswerService answerService;
	/**
	 * 发表评论
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "save.do", produces = { "application/json;charset=UTF-8" })
	public String save(HttpServletRequest request,  Model model) throws Exception {
		//1 获取参数
		String content=request.getParameter("content");
		String inforId=request.getParameter("inforId");
		String quoteId = request.getParameter("quoteId");
		
		
		
		Date date=new Date();
		Comment comment=new Comment();
		comment.setContent(content);
		comment.setCrTime(date);
		comment.setInforId(Long.parseLong(inforId));
		if (quoteId !=null)
		{
			comment.setQuoteId(Long.parseLong(quoteId));		
		}
		//获取发布人
		User user = (User) request.getSession().getAttribute("user");
		comment.setUserId(user.getId());
		comment.setNickname(user.getUserName());
		comment.setPic(user.getHeader());
		
		
		//2 保存
		commentService.save(comment);
		
		return "redirect:/dietican/articleContent.do?id="+Long.parseLong(inforId)+"";
	}
	
	/**
	 * 发表回复
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "addAnswer.do", produces = { "application/json;charset=UTF-8" })
	public String addAnswer(HttpServletRequest request,  Model model) throws Exception {
		//1 获取参数
		String answerId = request.getParameter("answerId");
		String parentId = request.getParameter("parentId");
		String content = request.getParameter("content");
		ReplyComment answer=new ReplyComment();
		answer.setContent(content);
		answer.setCrTime(new Date());
		if (parentId != null) {
			answer.setParentId(Long.parseLong(parentId));
		}
		answer.setInforId(Long.parseLong(answerId));
		User user = (User) request.getSession().getAttribute("user");
		if(user == null)
		{
			return "redirect:/login/login.jsp";
		}
		answer.setUserId(user.getId());
		answer.setNickname(user.getUserName());
		//2 保存
		commentService.saveAnswer(answer);
		
		return "redirect:/dietican/articleContent.do?id="+Long.parseLong(answerId)+"&parentId="+parentId+"&userId="+user.getId()+"";
	}
	
	@RequestMapping(value="list.do", produces={ "application/json;charset=UTF-8" })
	public  String list(HttpServletRequest request,  Model model)throws Exception {
			//分页查询
			int typeId=0;
			String typeIds=request.getParameter("typeId");
			if(StringUtils.isNotBlank(typeIds)){
				typeId=Integer.parseInt(typeIds);
			}
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
			PaginationSupport<Comment> comPage = commentService.queryPage(params, order, 3, pageNo);
			List<Comment> listSpec=comPage.getItems();
			// 过滤html标签
			for(int i=0;i<listSpec.size();i++){
				Comment com=listSpec.get(i);
				String content=com.getContent().replaceAll("<.*?>", "").replaceAll("&nbsp;", "").replaceAll("&mdash;", "");
				com.setContent(content);
			}
			model.addAttribute("typeId", typeId);
			model.addAttribute("pageNo", pageNo);
			model.addAttribute("pageCount", comPage.getPageCount());
			return "/dietican/showContent";
	}
		/**
		* 查询回复
		* @param request
		* @param model
		* @return
		* @throws Exception 
		*/
		@RequestMapping(value="queryRepl.do", produces = { "application/json;charset=UTF-8" })
		public @ResponseBody String queryRepl(HttpServletRequest request,  Model model)throws Exception {	
			String parentId=request.getParameter("parentId");
			System.out.println("------------>"+parentId);
			List<ReplyCommentSort> replyList=new ArrayList<ReplyCommentSort>();
			commentService.getReplyList(replyList, Long.parseLong(parentId), 0);
			JSONArray jSONArray=JSONArray.fromObject(replyList);
			System.out.println("------------>"+jSONArray.toString());
			return jSONArray.toString();
			
	}
}
