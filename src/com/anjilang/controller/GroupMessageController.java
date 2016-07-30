package com.anjilang.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.anjilang.entity.GroupIdAndUserid;
import com.anjilang.entity.GroupMessage;
import com.anjilang.entity.GroupTab;
import com.anjilang.entity.GroupUser;
import com.anjilang.entity.PatientGroup;
import com.anjilang.entity.User;
import com.anjilang.service.GroupMessageService;
import com.anjilang.service.GroupTabService;
import com.anjilang.service.GroupUserService;
import com.anjilang.service.PatientGroupService;
import com.anjilang.service.UserService;
import com.anjilang.util.AjlException;
import com.anjilang.util.SessionUtil;

/**
 * @author  JYM
 * 2015-7-27 下午5:31:31
 */
@Controller
@RequestMapping("GroupMessage")
public class GroupMessageController {
	
	private Logger log = Logger.getLogger(getClass());
	
	@Autowired
	private PatientGroupService patientGroupService;
	
	@Autowired
	private GroupMessageService groupMessageService;
	
	@Autowired
	private GroupTabService groupTabService;
	
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private GroupUserService groupUserService;
	
	
	@RequestMapping(value="tosend.do",produces = { "application/json;charset=UTF-8" })
	public String tomessage(HttpServletRequest request,Long groupid,Model model) throws Exception{

		 PatientGroup patientGroup=patientGroupService.getByid(groupid);
        
	        User user=SessionUtil.getLoginUser(request);
	        model.addAttribute("patientGroup", patientGroup);
	        model.addAttribute("user", user);
	        String tabid = request.getParameter("grouptabid");
	    	
	     	List<GroupTab> tabs=groupTabService.SortTab(patientGroup.getId());
	     
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
	    	model.addAttribute("patientGroup", patientGroup);
	    	model.addAttribute("user",user);
	    	model.addAttribute("tabs", tabs);
	    	model.addAttribute("uList", uList);
	    	model.addAttribute("count",count);
	    	
			model.addAttribute("tabid", tabid);
		return "hyh/thenews";
		
	}
	
	
	@RequestMapping(value="send.do",produces={"application/json;charset=UTF-8"})
	public String sendmessage(HttpServletRequest request,Long groupid,Model model) throws Exception{
		PatientGroup patientGroup=patientGroupService.getByid(groupid);
		String content=request.getParameter("content");
		try {
			GroupMessage groupMessage=new GroupMessage();
			User user=SessionUtil.getLoginUser(request);
			groupMessage.setAdminid(user.getId());
			groupMessage.setContent(content);
			groupMessage.setPatientGroup(patientGroup);
			groupMessageService.savemessage(groupMessage);
			model.addAttribute("patientGroup", patientGroup);
		
		} catch (Exception e) {
			log.error("删除标签失败：" , e);
			model.addAttribute("message", "系统异常");
		}
		return "hyh/thenews";
	}
	
	
	@RequestMapping(value="receive.do",produces={"application/json;charset=UTF-8"})
	public String recieve(HttpServletRequest request,Model model){
		
		User user=SessionUtil.getLoginUser(request);
		GroupIdAndUserid groupIdAndUserid=new GroupIdAndUserid();
		groupIdAndUserid.setUserid(user.getId());
		List<GroupMessage>  userGroupMessages=null;
		try {
			List<GroupUser>  groupUsers=groupUserService.groupList(groupIdAndUserid);
			
		
			for (int i = 0; i < groupUsers.size(); i++) {
				PatientGroup patientGroup=new PatientGroup();
				patientGroup=patientGroupService.getByid(groupUsers.get(i).getId().getGroupid());
				List<GroupMessage> groupMessages=groupMessageService.queryByGroup(patientGroup);
				userGroupMessages.addAll(groupMessages);
			}
			model.addAttribute("groupUsers", groupUsers);
			
			
			
		} catch (AjlException e) {
			
			e.printStackTrace();
		}
		
		model.addAttribute("user", user);
		model.addAttribute("userGroupMessages", userGroupMessages);
		
		
		
		return "hyh/messagelist";
	}
	

}
