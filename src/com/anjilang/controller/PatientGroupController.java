package com.anjilang.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;


import com.alibaba.fastjson.JSONObject;
import com.anjilang.controller.base.BaseController;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.GroupIdAndUserid;
import com.anjilang.entity.GroupTab;
import com.anjilang.entity.GroupTopic;
import com.anjilang.entity.GroupUser;
import com.anjilang.entity.PatientGroup;
import com.anjilang.entity.TopicReply;
import com.anjilang.entity.User;
import com.anjilang.service.GroupTabService;
import com.anjilang.service.GroupTopicService;
import com.anjilang.service.GroupUserService;
import com.anjilang.service.PatientGroupService;
import com.anjilang.service.TopicReplyService;
import com.anjilang.service.UserService;
import com.anjilang.util.AjlException;
import com.anjilang.util.Constants;
import com.anjilang.util.DateUtil;
import com.anjilang.util.ImageUtils;
import com.anjilang.util.PropertyUtil;
import com.anjilang.util.SessionUtil;
import com.anjilang.util.StringUtil;

/**
 * @author  JYM
 * 2015-7-10 下午1:00:19
 */

@Controller
@RequestMapping("patientGroup")
public class PatientGroupController extends BaseController {
	private Logger log = Logger.getLogger(getClass());
	
	@Autowired
	private PatientGroupService patientGroupService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private GroupTabService groupTabService;
	
	@Autowired
	private GroupUserService groupUserService;
	
	@Autowired
	private GroupTopicService groupTopicService;
	
	@Autowired
	private TopicReplyService topicReplyService;
	
	
	

	private PatientGroup patientGroup;
	
	
	/**
	 * 跳转页面
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="toAdd.do")
	public String toAdd( HttpServletRequest request,Model model) throws Exception{
		//跳转页面
	return "/hyh/apply";
	}
	
	/**
	 * 用户创建小组
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="AddPatientGroup.do",produces = { "application/json;charset=UTF-8" })
	public String add(HttpServletRequest request,Model model) throws Exception{
		
		String description=request.getParameter("description");
		String groupname=request.getParameter("groupname");
		try {
			PatientGroup patientGroup=new PatientGroup();
			patientGroup.setGroupname(groupname);
			patientGroup.setCreatetime(new Date());
			patientGroup.setCancel(0);
			patientGroup.setDescription(description);
			patientGroup.setPicurl("hyh/images/lad.jpg");
			patientGroup.setBgpicUrl("hyh/images/banner.jpg");
			patientGroup.setPersoncount(1);
			patientGroup.setTopiccount(0);
			User user = SessionUtil.getLoginUser(request);
			patientGroup.setAudit("1");
		    patientGroup.setUserid(user.getId());
			patientGroupService.addPatientGroup(patientGroup);
			model.addAttribute("message", "小组创建成功");
			return  "hyh/prompt";
		} catch (Exception e) {
			log.error("创建小组失败：" , e);
			model.addAttribute("message", "系统异常");
			return "hyh/prompt";
		}
		
	}
	
	/**
	 * 查询所有小组
	 * @param request
	 * @param id
	 * @param audit
	 * @param model
	 * @return
	 */
	@RequestMapping(value="group.do",produces={Constants.PRODUCES})
	public @ResponseBody String group(HttpServletRequest request,String audit) throws  Exception{
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		log.info("[" + flg + "]audit["+audit+"]");
		try {
			if (StringUtil.isEmpty(audit)) {
				log.error("["+flg+"]审核状态为空");
			}
			List<PatientGroup> groups=patientGroupService.queryGroupByAudit(audit);
			
			
			if(groups!=null && groups.size()>0 ){
				
				JSONArray arr=JSONArray.fromObject(groups);
				return arr.toString();
				
			}
		} catch (AjlException e) {
			log.error("[" + flg + "]查询小组失败" + e.toString());
		} catch (Throwable e) {
			log.error("[" + flg + "]查询小组失败", e);
		}
	  return new JSONArray().toString();
	}
	
	
	
	/**
	 * 修改小组审核状态
	 * @param request
	 * @param id
	 * @param audit
	 * @param model
	 * @return
	 */
	@RequestMapping(value="toaudit.do",produces={Constants.PRODUCES})
	public String toaudit(HttpServletRequest request,Long id, Model model) throws Exception{
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		log.info("[" + flg + "]id["+id+"]");
		try {
			PatientGroup patientGroup=patientGroupService.getByid(id);
			model.addAttribute("patientGroup",patientGroup);
			return "/managers/audit/editgroup";
			
		} catch (AjlException e) {
			log.error("[" + flg + "]查询小组失败" + e.toString());
			
		}catch (Throwable e) {
			log.error("[" + flg + "]查询小组失败", e);
		}
		return  "/managers/audit/grouplist";
	}
	
	/**
	 * 修改小组审核状态
	 * @param request
	 * @param id
	 * @param audit
	 * @param model
	 * @return
	 */
	@RequestMapping(value="audit.do",produces={Constants.PRODUCES})
	public String audit(HttpServletRequest request,Long id,String audit,Model model) throws Exception{
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		log.info("[" + flg + "]id["+id+"]audit["+audit+"]");
		try {
			PatientGroup patientGroup=patientGroupService.getByid(id);
			if(patientGroup!=null && (",1,2,").contains(","+audit+",")){
				patientGroup.setAudit(audit);
				patientGroupService.update(patientGroup);
			}
		} catch (AjlException e) {
			log.error("[" + flg + "]查询小组失败失败" + e.toString());
		}catch (Throwable e) {
			log.error("[" + flg + "]查询小组失败", e);
		}
		return  "/managers/audit/grouplist";
	}
	
	
	
	
	/**
	 * 页面上显示小组列表
	 * @param request
	 * @param id
	 * @param audit
	 * @param model
	 * @return
	 *//*
    @RequestMapping(value="findgroup.do",produces = { Constants.PRODUCES })
	public String findGroup(HttpServletRequest request, Integer pageSize,Integer pageNo, Model model) throws Exception{
    	String flg = (String) request.getAttribute(Constants.LOGFLAG);
    	log.info("["+flg+"]pageSize["+pageSize+"]pageNo["+pageNo+"]");
    	pageSize = (pageSize == null) ? 5 : pageSize;
		pageNo = (pageNo == null) ? 1 : pageNo;
		log.info("["+flg+"]pageSize["+pageSize+"]pageNo["+pageNo+"]");
		try {
			// 分页查询已审核的小组
			PaginationSupport<PatientGroup> pageGroup=patientGroupService.queryGroupByAudit("2", pageSize, pageNo);
			// 当前页数据
			List< PatientGroup> groups=pageGroup.getItems();
			// 总页数
			Long totalPage=pageGroup.getPageCount();
			// 总记录数
			Long totalSize=pageGroup.getTotalCount();
			
			model.addAttribute("pageCount", totalPage);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("pageNo", pageNo);
			model.addAttribute("totalSize", totalSize);
			model.addAttribute("groups", groups);
		} catch (Throwable e) {
			log.error("[" + flg + "]", e);
		}
		return "/hyh/grouplist";
	}*/
    
    /**
	 * 每个小组的主页面
	 * @param request
	 * @param id
	 * @param model
	 * @return
	 */
    @RequestMapping(value="groupdetail.do",produces = { "application/json;charset=UTF-8" })
    public String todetail(HttpServletRequest request,Long groupid,Integer pageSize,Integer pageNo,Model model) throws Exception{
    	
    	
    	PatientGroup patientGroup=patientGroupService.getByid(groupid);
    	model.addAttribute("patientGroup", patientGroup);
    	
    	User user=SessionUtil.getLoginUser(request);
    	model.addAttribute("user",user);
    	
    	List<GroupTab> tabs=groupTabService.SortTab(patientGroup.getId());
    	model.addAttribute("tabs", tabs);
    	
    	
    	User gUser=userService.queryUserById(patientGroup.getUserid());
    	model.addAttribute("gUser", gUser);
    	
    
    	
    	
    	
    	
    	
    	
    	String queryType=request.getParameter("queryType");
    	String tabid = request.getParameter("grouptabid");
    	pageSize = (pageSize == null) ?20 : pageSize;
		pageNo = (pageNo == null) ? 1 : pageNo;
    	
    
     	
     	PaginationSupport<GroupTopic> allTopic=null;
     	
     	if (StringUtils.isBlank(tabid)  && StringUtils.isBlank(queryType)) {
     		allTopic=groupTopicService.queryPage(patientGroup, null, 0, pageSize, pageNo);
  	}
  	
  	if(StringUtils.isBlank(tabid)  &&  StringUtils.isNotBlank(queryType)){
  		allTopic=groupTopicService.queryRepPage(patientGroup, null, 0, pageSize, pageNo);
  	}
  	if(StringUtils.isNotBlank(tabid)  ){
  		allTopic=groupTopicService.queryPage(patientGroup, Long.parseLong(tabid), 0, pageSize, pageNo);
  	}
     	
    
     	
     	List<GroupTopic> topics=allTopic.getItems();
     	
     // 总页数
     Long totalPage=allTopic.getPageCount();
     // 总记录数
     Long totalSize=allTopic.getTotalCount();
     	GroupIdAndUserid iduid=new GroupIdAndUserid();
     	iduid.setGroupid(patientGroup.getId());
     	List<GroupUser> groupUsers=groupUserService.memberList(iduid);
     	List<User> uList=new ArrayList<User>();
		User users=new User();
		for (int i = 0; i < groupUsers.size(); i++) {
			users=userService.queryUserById(groupUsers.get(i).getId().getUserid());
			uList.add(users);
		}
		//获取委员会成员
		List<GroupUser> gUsers=groupUserService.listByUser(iduid);
		List<User> gList=new ArrayList<User>();
		for (int i = 0; i < gUsers.size(); i++) {
			gList.add(userService.queryUserById(gUsers.get(i).getId().getUserid()));
			
		}
		model.addAttribute("gList", gList);
    	
		//图文推荐文章
				List<GroupTopic>  picTopics=groupTopicService.RecomTopic(3);
				model.addAttribute("picTopics", picTopics);
				
				
		
    	
    	
    	model.addAttribute("queryType", queryType);
    	model.addAttribute("uList", uList);
    	model.addAttribute("tabid", tabid);
    	model.addAttribute("topics", topics);
    	model.addAttribute("pageSize", pageSize);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("totalSize", totalSize);
	
    	return "hyh/groupindex";
    }
    
    /**
	 * 显示管理员的管理小组tab
	 * @param request
	 * @param id
	 * @param model
	 * @return
	 */
    @RequestMapping(value="magroup.do",produces = { "application/json;charset=UTF-8" })
    public String manatab(HttpServletRequest request,Long groupid,Model model) throws Exception{
    	           
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
    		      
    		  		 return "hyh/setup";
    }
    
    
    /**
	 * 管理员修改小组信息
	 * @param request
	 * @param id
	 * @param model
	 * @return
	 */ 
    @RequestMapping(value="mogroup.do",produces = { "application/json;charset=UTF-8" })
public  ModelAndView modifygroup(HttpServletRequest request,Long groupid,String description,String groupname,Model model) throws Exception{
    	 patientGroup=patientGroupService.getByid(groupid);
	try {
		      System.out.println(patientGroup);
		      if(patientGroup!=null){
			
			 patientGroup .setGroupname(groupname);
			 patientGroup.setDescription(description);
			 patientGroupService.update(patientGroup);
			 System.out.println(patientGroup);
			 model.addAttribute("message", "修改小组成功");
		 }
		 model.addAttribute("patientGroup", patientGroup);
		
		
	} catch (Exception e) {
		log.error("修改小组失败：" , e);
		model.addAttribute("message", "系统异常");
		
	}
	return new ModelAndView("redirect:/patientGroup/magroup.do?groupid="+groupid);
		
	}
    
    
    
    
    
    /**
   	 * 管理员修改小组图片
   	 * @param request
   	 * @param id
   	 * @param model
   	 * @return
   	 */ 
    @RequestMapping(value="picture.do",produces = { "application/json;charset=UTF-8" })
    public String pic(HttpServletRequest request,Long groupid,Model model) throws Exception{
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
    		  		 return "hyh/picture";
    }
    
    /**
	 * 管理员修改小组信息
	 * @param request
	 * @param id
	 * @param model
	 * @return
	 */ 
    @RequestMapping(value="mopic.do",produces = { "application/json;charset=UTF-8" })
public  String modifypic(HttpServletRequest request,Long groupid,Model model,
		@RequestParam("file")  CommonsMultipartFile file,String path) throws Exception{
    	String flg = (String) request.getAttribute(Constants.LOGFLAG);
    	
		String uri  = "";
		
		log.info("[" + flg + "]上传图片" + path);
		
		
		String dirPath = "upload/"
				+ ((StringUtil.isEmpty(path)) ? "" : (path + "/"))
				+ DateUtil.formatDate(new Date(), "yyyy/MM/dd/");
		
		String dir = request.getRealPath("") + "/";
		dir += dirPath;
		File f = new File(dir);
		
		if (!f.exists()) { // 如果不存在则创建目录
			f.mkdirs();
		}

		int fileSize = (int) file.getSize();// 图片大小
		file.getName();//
		
		
		// TODO XXX 处理图片大小限制与图片后缀限制
				if (fileSize > 2097152)
				{
					return null;
				}
				
				JSONObject json = new JSONObject();
				// 访问图片地址
				
				String url = PropertyUtil.newInstans().getValue("url");
				try {
					String fileName = flg + ".png";
				
					ImageUtils.saveFile(file.getInputStream(), dir, fileName);
				
					uri = dirPath + fileName;
				
					// 图片相对路径用于存入数据库
					json.put("path", uri);
					json.put("url", url + dirPath + fileName);
				
					success(json);
				} catch (AjlException e) {
					log.error("[" + flg + "]保存图片失败", e);
					
					error(json, e);
				} catch (Throwable e) {
					log.error("[" + flg + "]保存图片失败", e);
					error(json, AjlException.createErr("5020"));
				}
				log.info("[" + flg + "]" + json.toJSONString());
				
    	 
     
      try {
    	  PatientGroup patientGroup=patientGroupService.getByid(groupid);
    	  System.out.println(patientGroup);
	      if(patientGroup!=null){
	    	  patientGroup.setPicurl(uri);
	    
	  		 
	  		  patientGroupService.update(patientGroup);
	  		 System.out.println(patientGroup);
	  		 model.addAttribute("message", "修改小组成功");
	      }
	      model.addAttribute("patientGroup", patientGroup);
	      model.addAttribute("headPath", url+uri);
			
		
	} catch (Exception e) {
		log.error("修改小组失败：" , e);
		model.addAttribute("message", "系统异常");
		 
	}
  	return "hyh/picture";
	}
    
    
    /**
	 * 跳转到分类页面
	 * */
	@RequestMapping(value="branch.do",produces = { "application/json;charset=UTF-8" })
	public String gtab(HttpServletRequest request,Long groupid,Model model) throws Exception{
		
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
		return "hyh/branch";
	}

	
	
	  @RequestMapping(value="mobgpic.do",produces = { "application/json;charset=UTF-8" })
	  public  String modifybgpic(HttpServletRequest request,Long groupid,Model model,
	  		@RequestParam("file")  CommonsMultipartFile file,String path) throws Exception{
	      	String flg = (String) request.getAttribute(Constants.LOGFLAG);
	      	
	  		String uri  = "";
	  		
	  		log.info("[" + flg + "]上传图片" + path);
	  		
	  		
	  		String dirPath = "upload/"
	  				+ ((StringUtil.isEmpty(path)) ? "" : (path + "/"))
	  				+ DateUtil.formatDate(new Date(), "yyyy/MM/dd/");
	  		
	  		String dir = request.getRealPath("") + "/";
	  		dir += dirPath;
	  		File f = new File(dir);
	  		
	  		if (!f.exists()) { // 如果不存在则创建目录
	  			f.mkdirs();
	  		}

	  		int fileSize = (int) file.getSize();// 图片大小
	  		file.getName();//
	  		
	  		
	  		// TODO XXX 处理图片大小限制与图片后缀限制
	  				if (fileSize > 2097152)
	  				{
	  					return null;
	  				}
	  				
	  				JSONObject json = new JSONObject();
	  				// 访问图片地址
	  				
	  				String url = PropertyUtil.newInstans().getValue("url");
	  				try {
	  					String fileName = flg + ".png";
	  				
	  					ImageUtils.saveFile(file.getInputStream(), dir, fileName);
	  				
	  					uri = dirPath + fileName;
	  				
	  					// 图片相对路径用于存入数据库
	  					json.put("path", uri);
	  					json.put("url", url + dirPath + fileName);
	  				
	  					success(json);
	  				} catch (AjlException e) {
	  					log.error("[" + flg + "]保存图片失败", e);
	  					
	  					error(json, e);
	  				} catch (Throwable e) {
	  					log.error("[" + flg + "]保存图片失败", e);
	  					error(json, AjlException.createErr("5020"));
	  				}
	  				log.info("[" + flg + "]" + json.toJSONString());
	  				
	      	 
	       
	        try {
	      	  PatientGroup patientGroup=patientGroupService.getByid(groupid);
	      	  System.out.println(patientGroup);
	  	      if(patientGroup!=null){
	  	    	  patientGroup.setBgpicUrl(uri);
	  	  		  patientGroupService.update(patientGroup);
	  	  		 System.out.println(patientGroup);
	  	  		 model.addAttribute("message", "修改小组成功");
	  	      }
	  	      model.addAttribute("patientGroup", patientGroup);
	  	      model.addAttribute("headPath", url+uri);
	  			
	  		
	  	} catch (Exception e) {
	  		log.error("修改小组失败：" , e);
	  		model.addAttribute("message", "系统异常");
	  		 
	  	}
	    	return "hyh/picture";
	  	}
	      
	     

    
    /**
     * 管理员删除小组
      */
	  
	  
	  @RequestMapping(value="delect.do",produces = { "application/json;charset=UTF-8" })
	  public ModelAndView  delect(HttpServletRequest request) throws Exception{
		  
		  String[] ids=request.getParameterValues("id");
		  
		  if(ids!=null &&ids.length>0){
			  
			  for (int i = 0; i < ids.length; i++) {
				  PatientGroup patientGroup=patientGroupService.getByid(Long.parseLong(ids[i]));
				  patientGroup.setCancel(1);
				  patientGroupService.update(patientGroup);
				  
				
			}
		  }
		  
		  
		  
		 return new ModelAndView("redirect:/patientGroup/group.do");
	  }
    
    
    
    
    
	
 
}
	
	
	



