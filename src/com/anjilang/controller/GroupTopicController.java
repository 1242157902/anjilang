package com.anjilang.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.GroupIdAndUserid;
import com.anjilang.entity.GroupTab;
import com.anjilang.entity.GroupTopic;
import com.anjilang.entity.GroupUser;
import com.anjilang.entity.PatientGroup;
import com.anjilang.entity.TopicRecom;
import com.anjilang.entity.TopicReply;
import com.anjilang.entity.User;
import com.anjilang.service.GroupTabService;
import com.anjilang.service.GroupTopicService;
import com.anjilang.service.GroupUserService;
import com.anjilang.service.PatientGroupService;
import com.anjilang.service.TopicRecomService;
import com.anjilang.service.TopicReplyService;
import com.anjilang.service.UserService;
import com.anjilang.util.AjlException;
import com.anjilang.util.Constants;
import com.anjilang.util.SessionUtil;
import com.sun.org.apache.bcel.internal.generic.NEW;

/**
 * @author  JYM
 * 2015-7-26 下午8:49:50
 */
@Controller
@RequestMapping("GroupTopic")
public class GroupTopicController {
	
	private Logger log = Logger.getLogger(getClass());
	
	@Autowired
	private GroupTopicService groupTopicService;
	
	@Autowired
	private PatientGroupService  patientGroupService;
	
	@Autowired
	private GroupTabService groupTabService;
	
	@Autowired
	private GroupUserService groupUserService;
	
	@Autowired
	private TopicReplyService topicReplyService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private TopicRecomService topicRecomService;
	

	
	/**
	 * 跳转页面
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="topublish.do",produces = { "application/json;charset=UTF-8" })
	public String topublish(HttpServletRequest request,Long groupid,Model model) throws Exception{
		
		PatientGroup patientGroup=patientGroupService.getByid(groupid);
		User user=SessionUtil.getLoginUser(request);
		GroupIdAndUserid groupIdAndUserid=new GroupIdAndUserid();
		groupIdAndUserid.setGroupid(groupid);
		List<GroupUser> groupUser=groupUserService.memberList(groupIdAndUserid);
		List<User> users=new ArrayList<User>();
		for (GroupUser groupUser2 : groupUser) {
			users.add(userService.queryUserById(groupUser2.getId().getUserid()));
			
		}
		
		List<GroupTab> tabs=groupTabService.SortTab(groupid);
		model.addAttribute("tabs", tabs);
		model.addAttribute("patientGroup", patientGroup);
		model.addAttribute("user", user);
		model.addAttribute("users", users);
		return "hyh/release";
	}
	
	
	
	
	
	
	
	/**
	 * 用户发表文章
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="publish.do",produces = { "application/json;charset=UTF-8" })
	public ModelAndView   publish(HttpServletRequest request,Long groupid,Model model) throws Exception{
		
		PatientGroup patientGroup=patientGroupService.getByid(groupid);
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		String tabid=request.getParameter("tabid");
		try {
			GroupTopic groupTopic=new GroupTopic();
			User user=SessionUtil.getLoginUser(request);
				groupTopic.setTitle(title);
				
			   String toppicurl=StringUtils.substringBetween(content,"anjilang/", ".png")+".png";
				groupTopic.setArticlepic(toppicurl);
				groupTopic.setContent(content);
				groupTopic.setPatientGroup(patientGroup);
				groupTopic.setCancel(0);
				groupTopic.setHit(0);
				groupTopic.setTopictop(0);
				groupTopic.setRep(0);
				groupTopic.setCreatetime(new  Date());
				groupTopic.setUser(user);
				if(tabid==null){
					groupTopic.setTabid(null);
				}else{
				   groupTopic.setTabid(Long.parseLong(tabid));
				}
				groupTopicService.publish(groupTopic);
				patientGroup.setTopiccount(patientGroup.getTopiccount()+1);
				patientGroupService.update(patientGroup);
				System.out.println(groupTopic);
				
		
			model.addAttribute("message", "发表文章成功");
			
			
			
		} catch (Exception e) {
			log.error("发表文章失败：" , e);
			model.addAttribute("message", "系统异常");
			
		}
		
		return new ModelAndView("redirect:/patientGroup/groupdetail.do?groupid="+groupid);
		
	}
	
	@RequestMapping(value="topiclist.do",produces={Constants.PRODUCES})
	public  @ResponseBody String  toshow(HttpServletRequest request,Long groupid) throws Exception{
		try {
			if(groupid==null){
				log.error("["+groupid+"]不存在小组");
			}
			List<GroupTopic> topics=groupTopicService.tolist(groupid);
			if(topics!=null &&topics.size()>0){
				JSONArray jsonArray=JSONArray.fromObject(topics);
				return jsonArray.toString();
			}
			
		} catch (Exception e) {
			log.error("[" + groupid + "]查询列表失败" + e.toString());
		}
		return  new JSONArray().toString();
	}
	
	
	@RequestMapping(value="getUserId",produces={Constants.PRODUCES})
	public @ResponseBody String  getUserId(Long id)throws Exception{
		User user =null;
		try{
			if (id == null) 
			{
				log.error("["+id+"]不存在该用户");
				return null;
			}else{
				user = userService.queryUserById(id);
				 StringBuilder sb = new StringBuilder();
				 sb.append("{");
				 sb.append("\"" + "id" + "\"" + ":" + "\"" + user.getId() + "\""); 
				 sb.append(",");
				 sb.append("\"" + "realName" + "\"" + ":" + "\"" + user.getRealName() + "\""); 
				 sb.append("}");
				 //System.out.println(sb.toString());
				 return  sb.toString();
			}		
		}catch(Exception e){
			log.error("[" + id + "]查询用户失败" + e.toString());
		}
		return null;
	}
	
	/**
	 * 文章详情
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="detail.do",produces = { "application/json;charset=UTF-8" })
	public String detail(HttpServletRequest request,Long id, Integer pageSize,Integer pageNo,Long groupid, Model model) throws Exception{
		//获取页面参数
		
		String createrid=request.getParameter("createrid");
		String userId=request.getParameter("userId");
		PatientGroup patientGroup=patientGroupService.getByid(groupid);
		GroupTopic groupTopic=groupTopicService.getById(id);
		List<GroupTab> tabs=groupTabService.SortTab(groupid);
	
		pageSize = (pageSize == null) ?5 : pageSize;
		pageNo = (pageNo == null) ? 1 : pageNo;
		PaginationSupport<TopicReply> topicReplys=null;
		//获取回复
		if(StringUtils.isBlank(createrid)){
			topicReplys=topicReplyService.queryByTopicid(id, pageSize, pageNo,null);
		}
		if (StringUtils.isNotBlank(createrid)) {
			 topicReplys=topicReplyService.queryByTopicid(id, pageSize, pageNo,userService.queryUserById(Long.parseLong(createrid)));
				
		}
			// 当前页数据
			List< TopicReply> replys=topicReplys.getItems();
		     // 总页数
			Long totalPage=topicReplys.getPageCount();
		   // 总记录数
		   Long totalSize=topicReplys.getTotalCount();
		   
		   GroupIdAndUserid idAndUserid=new GroupIdAndUserid();
		   idAndUserid.setGroupid(groupid);
		   List<GroupUser> groupUsers=groupUserService.memberList(idAndUserid);
		   //获取所有的小组成员
		   List<User> users=new ArrayList<User>();
		
		   for (int i = 0; i < groupUsers.size(); i++) {
			   users.add(userService.queryUserById(groupUsers.get(i).getId().getUserid()));
		}
		   
		   //文章浏览量+1 有问题需要修改
		   User userSession = (User) request.getSession().getAttribute("user");
		   if(userSession==null || !userSession.getId().toString().equals(userId)){
			   groupTopic.setHit(groupTopic.getHit()+1);
			   groupTopicService.publish(groupTopic);
			   
		   }
		   //文章发表人加入的小组
		   GroupIdAndUserid groupIdAndUserid=new GroupIdAndUserid();
		   groupIdAndUserid.setUserid(groupTopic.getUser().getId());
		   List<GroupUser> groups=groupUserService.groupList(groupIdAndUserid);
		   List<PatientGroup> patientGroups=new ArrayList<PatientGroup>();
		   for (int i = 0; i <groups.size(); i++) {
			   patientGroups.add(patientGroupService.getByid(groups.get(i).getId().getGroupid()));
			
		}
		   model.addAttribute("patientGroups", patientGroups);
			
		   //获取所有的推荐列表
		   List<TopicRecom> recoms=topicRecomService.queryAll();
		   for (int i = 0; i < recoms.size(); i++) {
			   System.out.println(recoms.get(i));
			
		}
		   model.addAttribute("recoms", recoms);
		   
		   
		 //图文推荐文章
			List<GroupTopic>  picTopics=groupTopicService.RecomTopic(3);
			model.addAttribute("picTopics", picTopics);
			
			 //推荐文章
			List<GroupTopic>  artTopics=groupTopicService.RecomTopic(3);
			model.addAttribute("artTopics", artTopics);
			
		  User user=SessionUtil.getLoginUser(request);
		  model.addAttribute("user", user);
			
		model.addAttribute("createrid", createrid) ; 
		model.addAttribute("userSession", userSession) ;  
		model.addAttribute("users", users);
		model.addAttribute("pageCount", totalPage);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("totalSize", totalSize);
		model.addAttribute("replys", replys);
		model.addAttribute("patientGroup", patientGroup);	
		model.addAttribute("groupTopic", groupTopic);
		model.addAttribute("tabs",tabs);
		return "hyh/content";
	
	}
	
	
	/** 
	 * 推荐文章
	 * **/
	@RequestMapping(value="recommend.do",produces = { "application/json;charset=UTF-8" })
	public ModelAndView recom(HttpServletRequest request, Long id,Long groupid) throws Exception{
		
		 GroupTopic groupTopic=groupTopicService.getById(id);
		 String recommend=request.getParameter("recommend");
		 
		 groupTopic.setRecommended(Integer.parseInt(recommend));
		 groupTopic.setRectime(new Date());
		 groupTopicService.publish(groupTopic);
		 
		  return new ModelAndView("redirect:/GroupTopic/detail.do?id="+id+"&groupid="+groupid);
	}
	
	
	@RequestMapping(value="ding.do",produces = { "application/json;charset=UTF-8" })
	public ModelAndView ding(HttpServletRequest request,Long id,Long groupid) throws Exception{
		
	      GroupTopic groupTopic=groupTopicService.getById(id);

	      String userId=request.getParameter("userId");
		//文章浏览量+1 有问题需要修改
		   User userSession = (User) request.getSession().getAttribute("user");
		   if(userSession==null || !userSession.getId().toString().equals(userId)){
			   groupTopic.setTopictop(groupTopic.getTopictop()+1);
			   groupTopicService.publish(groupTopic);
		   }
			   
		   return new ModelAndView("redirect:/GroupTopic/detail.do?id="+id+"&groupid="+groupid);
		
		
	}
	
	
	/**
	 * 所有文章的页面
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "Artical.do", produces = { "application/json;charset=UTF-8" })
	public  String  toIndex(HttpServletRequest request, Integer pageSize,Integer pageNo,Long groupid,Model model) throws Exception{
	
		
		String tabid = request.getParameter("grouptabid");
		
		PatientGroup patientGroup=patientGroupService.getByid(groupid);
		List<GroupTab> tabs=groupTabService.SortTab(groupid);
		pageSize = (pageSize == null) ?10 : pageSize;
		pageNo = (pageNo == null) ? 1 : pageNo;
	    model.addAttribute("pageSize",pageSize );
		model.addAttribute("pageNo",pageNo );
		model.addAttribute("tabs", tabs);
		model.addAttribute("patientGroup", patientGroup);
		
		PaginationSupport<GroupTopic> newTopiclist=null;
		
		//查询最新的文章
	if (StringUtils.isBlank(tabid)) {
          newTopiclist=groupTopicService.queryPage(patientGroup, null, 0, pageSize, pageNo);
	}
	
	if(StringUtils.isNotBlank(tabid)){
		 newTopiclist=groupTopicService.queryPage(patientGroup, Long.parseLong(tabid), 0, pageSize, pageNo);
	}

	//获取当前页
    List<GroupTopic> newTopics=newTopiclist.getItems();
    //总页数
    Long totalPage=newTopiclist.getPageCount();
    //总记录数
    Long totalCount=newTopiclist.getTotalCount();
    GroupIdAndUserid iduid=new GroupIdAndUserid();
 	iduid.setGroupid(patientGroup.getId());
 	List<GroupUser> groupUsers=groupUserService.memberList(iduid);
 	List<User> uList=new ArrayList<User>();
	User users=new User();
	for (int i = 0; i < groupUsers.size(); i++) {
		users=userService.queryUserById(groupUsers.get(i).getId().getUserid());
		uList.add(users);
	}
	Integer count=uList.size();
	model.addAttribute("count",count);
    model.addAttribute("newTopics", newTopics);
	model.addAttribute("totalPage",totalPage);
	model.addAttribute("totalCount",totalCount);
	
	
	model.addAttribute("tabid", tabid);
	return "hyh/post";
					
}
		

	
	
	
	
	/**
	 * 删除文章
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="delect.do" ,produces = { Constants.PRODUCES })
	public  ModelAndView delect(HttpServletRequest request,Long groupid,Model model) throws Exception{
		PatientGroup patientGroup=patientGroupService.getByid(groupid);

		//1 获取数据
		String[] topicid=request.getParameterValues("topicid");
		//2 删除
		if(topicid!=null && topicid.length>0){
			for(int i=0;i<topicid.length;i++){
				GroupTopic groupTopic=groupTopicService.getById(Long.parseLong(topicid[i]));
				groupTopic.setCancel(1);
				groupTopicService.publish(groupTopic);
				
			}
		}
		return new ModelAndView("redirect:/GroupTopic/Artical.do?groupid="+groupid);
	}
	
	
	
	

}
