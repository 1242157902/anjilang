
package com.anjilang.controller;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;



import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;

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
import com.anjilang.entity.GroupUser;
import com.anjilang.entity.PatientGroup;
import com.anjilang.entity.Picture;
import com.anjilang.entity.User;
import com.anjilang.service.GroupMessageService;
import com.anjilang.service.GroupTabService;
import com.anjilang.service.GroupUserService;
import com.anjilang.service.PatientGroupService;
import com.anjilang.service.UserService;
import com.anjilang.util.Constants;
import com.anjilang.util.SessionUtil;

/**
 * @author  JYM
 * 2015-7-20 下午2:37:11
 */
@Controller
@RequestMapping("GroupUser")
public class GroupUserController {
	private Logger log = Logger.getLogger(getClass());
	
	@Autowired
	private GroupUserService groupUserService;
	
	@Autowired
	private PatientGroupService patientGroupService;
	
	@Autowired
	private  UserService userService;
	
	@Autowired
	private GroupMessageService groupMessageService;
	
	@Autowired
	private GroupTabService groupTabService;
	
	


	
	@RequestMapping(value="JoinGroup.do",produces = { "application/json;charset=UTF-8" })
	public ModelAndView  join(HttpServletRequest request,Long groupid,Model model) throws Exception{
		
		try {
			GroupUser groupUser=new GroupUser();
			  GroupIdAndUserid id=new GroupIdAndUserid();
			User user=SessionUtil.getLoginUser(request);
			id.setUserid(user.getId());
		   PatientGroup patientGroup=patientGroupService.getByid(groupid);
		    id.setGroupid(groupid);
			groupUser.setId(id);
			groupUser.setIsmember(1);
			groupUser.setJointime(new Date());
			groupUserService.JoinGroup(groupUser);
		    patientGroup.setPersoncount(patientGroup.getPersoncount()+1);
		    patientGroupService.update(patientGroup);
			model.addAttribute("message", "欢迎加入小组");

		} catch (Exception e) {
			log.error("加入小组失败：" , e);
			model.addAttribute("message", "系统异常");
		}
		 return new ModelAndView("redirect:/patientGroup/groupdetail.do?groupid="+groupid);
		
		
	}
	
	@RequestMapping(value="QuitGroup.do",produces = { "application/json;charset=UTF-8" })
	public ModelAndView quit(HttpServletRequest request,Long groupid,Model model) throws Exception{
		
		try {
			GroupUser groupUser=new GroupUser();
			GroupIdAndUserid id=new GroupIdAndUserid();
			User user=SessionUtil.getLoginUser(request);
		    id.setGroupid(groupid);
		    id.setUserid(user.getId());
		    PatientGroup  patientGroup=patientGroupService.getByid(groupid);
			groupUser=groupUserService.getById(id);
			groupUser.setAdminId(user.getId());
			groupUser.setIsmember(0);
			groupUser.setQuittime(new Date());
			groupUserService.QuitGroup(groupUser);
			patientGroup.setPersoncount(patientGroup.getPersoncount()-1);
		    patientGroupService.update(patientGroup);
			model.addAttribute("message", "成功退出小组");
		} catch (Exception e) {
			log.error("退出小组失败：" , e);
			model.addAttribute("message", "系统异常");
		}
		
		return  new ModelAndView("redirect:/patientGroup/groupdetail.do?groupid="+groupid);
	}
	
	
	
	
	
	/**
	 * 提升為管理員
	 * */
	@RequestMapping(value="promote.do",produces = { "application/json;charset=UTF-8"})
	public ModelAndView promote(HttpServletRequest request,Long groupid ) throws Exception{
		
		String userid=request.getParameter("userid");
		GroupIdAndUserid groupIdAndUserid=new GroupIdAndUserid();
		groupIdAndUserid.setGroupid(groupid);
		groupIdAndUserid.setUserid(Long.parseLong(userid));
		
		try {
			GroupUser groupUser=groupUserService.getById(groupIdAndUserid);
			groupUser.setIsmember(2);
			groupUserService.JoinGroup(groupUser);
			System.out.println(groupUser);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		return new ModelAndView("redirect:/GroupUser/remember.do?groupid="+groupid);
		
	}
	
	
	@RequestMapping(value="remember.do",produces = { "application/json;charset=UTF-8"} )
	public String rememlist(HttpServletRequest request,Long groupid,Integer pageSize,
			Integer pageNo,Model model) throws Exception{
		
		PatientGroup patientGroup=patientGroupService.getByid(groupid);
		
		 String tabid = request.getParameter("grouptabid");
	    	
	     	List<GroupTab> tabs=groupTabService.SortTab(patientGroup.getId());
		pageSize = (pageSize == null) ? 12 : pageSize;
		pageNo = (pageNo == null) ? 1 : pageNo;
		try {
			GroupIdAndUserid id=new GroupIdAndUserid();
			id.setGroupid(groupid);
			PaginationSupport<Long> groupUsers=groupUserService.queryByUserMem(id, pageSize, pageNo);
			//当前页数据
			List<Long>  userids=groupUsers.getItems();
			List<User> uList=new ArrayList<User>();
			User user=new User();
			for (Long userid : userids) {
				user=userService.queryUserById(userid);
				uList.add(user);
			}
			//总页数
			Long totalPage=groupUsers.getPageCount();
			
			//总记录数
			Long totalSize=groupUsers.getTotalCount();
			Integer count=uList.size();
			model.addAttribute("patientGroup", patientGroup);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("pageNo", pageNo);
			model.addAttribute("userids", userids);
			model.addAttribute("totalPage", totalPage);
			model.addAttribute("totalSize", totalSize);
			model.addAttribute("groupUsers", groupUsers);
			model.addAttribute("uList", uList);
			model.addAttribute("tabs", tabs);
			model.addAttribute("tabid", tabid);
			model.addAttribute("count",count);
			
			return "hyh/members";
		} catch (Exception e) {
			log.error("查询小组失败：" , e);
			model.addAttribute("message", "系统异常");
		}
		return "hyh/members";
	}
	
	

	@RequestMapping(value="finduser.do",produces = { Constants.PRODUCES })
	public  @ResponseBody  String finduser(HttpServletRequest request,Model model) throws Exception{
		try {
			String groupid = request.getParameter("groupid");
			GroupIdAndUserid id=new GroupIdAndUserid();
			id.setGroupid(Long.parseLong(groupid));
			List<GroupUser> groupUsers=groupUserService.memberList(id);
			String userString=request.getParameter("user");
			
			 StringBuilder json = new StringBuilder(); 
			 
			 json.append("[");  
			 
			for (int i = 0; i <groupUsers.size(); i++) {
				
			    User  user=userService.queryUserById(groupUsers.get(i).getId().getUserid());
			    
				if(userString.equals(user.getRealName())){
					 json.append("{");  
					 json.append("\"" + "id" + "\"" + ":" + "\"" + user.getId() + "\""); 
					 json.append(",");
					 json.append("\"" + "realName" + "\"" + ":" + "\"" + user.getRealName() + "\""); 
					 json.append(",");
					 json.append("\"" + "header" + "\"" + ":" + "\"" + user.getHeader() + "\""); 
					  json.append("}").append(",");  
				}
		   }
			json.deleteCharAt(json.lastIndexOf(","));
		     json.append("]"); 
	        
	        //System.out.println(json);
			return json.toString();
		} catch (Exception e) {
			e.printStackTrace();
		
		}
		return null;
}
	
	
	@RequestMapping(value="delect.do",produces = { Constants.PRODUCES })
    public ModelAndView delect(HttpServletRequest request,Long groupid,Model model) throws Exception{
		PatientGroup patientGroup=patientGroupService.getByid(groupid);
	
			GroupIdAndUserid ids=new GroupIdAndUserid();
			ids.setGroupid(groupid);
			User  user=SessionUtil.getLoginUser(request);
			
			//1 获取数据
			String[] userid=request.getParameterValues("userid");
			//2 删除
			if(userid!=null && userid.length>0){
				for(int i=0;i<userid.length;i++){
				    ids.setUserid(Long.parseLong(userid[i]));
				    GroupUser groupUser=groupUserService.getById(ids);
				    groupUser.setIsmember(0);
				    groupUser.setAdminId(user.getId());
				    groupUserService.QuitGroup(groupUser);
				}
			}
		
		return  new ModelAndView("redirect:/GroupUser/remember.do?groupid="+groupid);
	}
	
	
}
