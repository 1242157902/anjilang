package com.anjilang.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.GroupTopic;
import com.anjilang.entity.TopicReply;
import com.anjilang.entity.User;
import com.anjilang.service.GroupTopicService;
import com.anjilang.service.GroupUserService;
import com.anjilang.service.TopicReplyService;
import com.anjilang.service.UserService;
import com.anjilang.util.Constants;
import com.anjilang.util.SessionUtil;

/**
 * @author  JYM
 * 2015-7-30 下午8:12:46
 */
@Controller
@RequestMapping("TopicReply")
public class TopicReplyController {
	
	private Logger log = Logger.getLogger(getClass());
	
	@Autowired
	private GroupTopicService groupTopicService;
	
	@Autowired
	private TopicReplyService topicReplyService;
	
	
	
	
	
	
	
	@RequestMapping(value="addReply.do",produces = { "application/json;charset=UTF-8" })
	public ModelAndView addReply(HttpServletRequest request,Long topicid,Long groupid,Long berelyid ,Long quoteid,Model model) throws Exception{
		
		String content=request.getParameter("content");
		GroupTopic groupTopic=groupTopicService.getById(topicid);
		   Integer count=topicReplyService.count(groupTopic.getId());
		try {
			TopicReply topicReply=new TopicReply();
			User user=SessionUtil.getLoginUser(request);
			topicReply.setUser(user);
			topicReply.setTopicid(groupTopic.getId());
			topicReply.setContent(content);
			topicReply.setReptime(new Date());
			count++;
			topicReply.setFloor(count);
			if(topicid != null)
			{
				TopicReply beRelyTopicRely =  topicReplyService.getTopicReply(topicid);
				topicReply.setBeRelyTopicReply(beRelyTopicRely);
			}
			if(quoteid != null )
			{
				TopicReply quoteTopicRely =  topicReplyService.getTopicReply(quoteid);
				topicReply.setQuoteTopicReply(quoteTopicRely);
			}
			groupTopic.setRep(groupTopic.getRep()+1);
			topicReplyService.addReply(topicReply);
			groupTopicService.publish(groupTopic);
			System.out.println(topicReply);
			
		} catch (Exception e) {
			log.error("回复帖子失败：" , e);
			model.addAttribute("message", "系统异常");
		}
		
		return new ModelAndView("redirect:/GroupTopic/detail.do?id="+topicid+"&groupid="+groupid );
	}
	
	
	
}
