package com.anjilang.controller;

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

import com.anjilang.entity.GroupTab;
import com.anjilang.entity.PatientGroup;
import com.anjilang.entity.User;
import com.anjilang.service.GroupTabService;
import com.anjilang.service.PatientGroupService;
import com.anjilang.service.UserService;
import com.anjilang.util.Constants;



/**
 * @author  JYM
 * 2015-7-13 下午8:51:41
 */
@Controller
@RequestMapping("GroupTab")
public class GroupTabController {
	
	private Logger log = Logger.getLogger(getClass());
	
	@Autowired
	private GroupTabService groupTabService;
	
	@Autowired
	private PatientGroupService patientGroupService;
	
	@Autowired
	private UserService userService;
	
	
	private GroupTab groupTab;
	
	
	
	
	
	
	/**
	 * 小组管理者添加分类
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="AddTab.do",produces = { "application/json;charset=UTF-8" })
	public ModelAndView addTab(HttpServletRequest request,Long groupid,Model model) throws Exception{
		PatientGroup patientGroup=patientGroupService.getByid(groupid);
		model.addAttribute("patientGroup", patientGroup);
		String tabname=request.getParameter("tabname");
		Integer  sortorder=Integer.parseInt(request.getParameter("sortorder"));
		try {
			GroupTab groupTab=new GroupTab();
			groupTab.setTabname(tabname);
			groupTab.setSortorder(sortorder);
			User user=(User) request.getSession().getAttribute("user");
			groupTab.setUserid(user.getId());
			groupTab.setPatientGroup(patientGroup);
			groupTab.setCancel(0);
			groupTabService.UaddGroupTab(groupTab);
			//return new ModelAndView("redirect:/patientGroup/branch.do?groupid="+groupid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/patientGroup/branch.do?groupid="+groupid);
	}
	
	@RequestMapping(value="cancel.do",produces = { "application/json;charset=UTF-8" })
	public ModelAndView  delectTab(HttpServletRequest request,Long groupid,Long id,Model model) throws Exception{
		PatientGroup patientGroup=patientGroupService.getByid(groupid);
		model.addAttribute("patientGroup", patientGroup);
		
		groupTab=groupTabService.getById(id);
		try {
			
			groupTab.setCancel(1);
			groupTabService.edit(groupTab);
			System.out.println(groupTab);
			model.addAttribute("groupTab", groupTab);
			model.addAttribute("message", "删除标签成功");
		} catch (Exception e) {
			log.error("删除标签失败：" , e);
			model.addAttribute("message", "系统异常");
		}
		return new ModelAndView("redirect:/patientGroup/branch.do?groupid="+groupid );
	}
	
	@RequestMapping(value="edit.do",produces = { "application/json;charset=UTF-8" })
	public ModelAndView  edit(HttpServletRequest request,Long groupid,Model model) throws Exception{
		String grouptabid=request.getParameter("grouptabid");
		String tabname=request.getParameter("tabname");
		
		String sortorder=request.getParameter("sortorder");
		model.addAttribute("grouptabid", grouptabid);
		
		groupTab=groupTabService.getById(Long.parseLong(grouptabid));
		
		PatientGroup patientGroup=patientGroupService.getByid(groupid);
		model.addAttribute("patientGroup", patientGroup);
		try {
			groupTab.setTabname(tabname);
			groupTab.setSortorder(Integer.parseInt(sortorder));
			groupTabService.edit(groupTab);
			model.addAttribute("message", "修改标签成功");
			model.addAttribute("groupTab", groupTab);
			
		} catch (Exception e) {
			log.error("修改标签失败：" , e);
			model.addAttribute("message", "系统异常");
		}
		
		return new ModelAndView("redirect:/patientGroup/branch.do?groupid="+groupid );
	}
	

	@RequestMapping(value="sort.do",produces={Constants.PRODUCES})
	public @ResponseBody String query(HttpServletRequest request,Long groupid) throws Exception{
		try {
			if(groupid==null){
				log.error("["+groupid+"]不存在小组");
			}
			List<GroupTab> list=groupTabService.SortTab(groupid);
			if(list!=null &&list.size()>0){
				JSONArray jsonArray=JSONArray.fromObject(list);
				return jsonArray.toString();
			}
		
		} catch (Exception e) {
			log.error("[" + groupid + "]查询小组标签失败" + e.toString());
		}
		return new JSONArray().toString();
		
	
	}
	
	
	
	
	
	

}
