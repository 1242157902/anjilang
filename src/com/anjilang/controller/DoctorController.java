package com.anjilang.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.City;
import com.anjilang.entity.DiseaseProject;
import com.anjilang.entity.DoctorType;
import com.anjilang.entity.Message;
import com.anjilang.entity.User;
import com.anjilang.service.CityService;
import com.anjilang.service.DiseaseProjectService;
import com.anjilang.service.DoctorTypeService;
import com.anjilang.service.MessageService;
import com.anjilang.service.UserService;
import com.anjilang.util.AjlException;
import com.anjilang.util.Constants;
import com.anjilang.util.StringUtil;
import com.anjilang.util.Validator;

/**
 * 找医生
 * 
 * @author xym
 * 
 */
@Controller
@RequestMapping("doctor")
public class DoctorController {
	private Logger log = Logger.getLogger(this.getClass());

	@Autowired
	private CityService cityService;

	@Autowired
	private DiseaseProjectService diseaseProjectService;

	@Autowired
	private UserService userService;

	@Autowired
	private MessageService messageService;
	
	@Autowired
	private DoctorTypeService doctorTypeService;

	@RequestMapping(value = "finddoctor.do", produces = { Constants.PRODUCES })
	public String findDoctor(HttpServletRequest request, Long provinceId, Long projectId, Integer pageSize,
			Integer pageNo, Model model) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		log.info("["+flg+"]provinceId["+provinceId+"]projectId["+projectId+"]pageSize["+pageSize+"]pageNo["+pageNo+"]");
		pageSize = (pageSize == null) ? 5 : pageSize;
		pageNo = (pageNo == null) ? 1 : pageNo;
		log.info("["+flg+"]provinceId["+provinceId+"]projectId["+projectId+"]pageSize["+pageSize+"]pageNo["+pageNo+"]");
		try {
			// 查询所有的省份列表
			List<City> pList = cityService.queryCityByParentId(0l);
			// 查询疾病项目列表
			List<DiseaseProject> dlist = diseaseProjectService.queryAll();
			// 分页查询已审核的医生
			PaginationSupport<User> pageUser = userService.queryUserByAudit(
					"2", "1", pageSize, pageNo, provinceId, projectId);
			// 当前页数据
			List<User> userList = pageUser.getItems();
			// 擅长项目
			List<String> projectList = new ArrayList<String>();
			// 解答数量
			List<Integer> answerList = new ArrayList<Integer>();
			// 被点赞数量
			List<Integer> agreeList = new ArrayList<Integer>();
			List<DoctorType> doctorTypeList = new ArrayList<DoctorType>();
			for(User u : userList ) {
				String project = u.getProject();
				List<Long> pidList = dealProject(project, flg);
				if(pidList==null || pidList.size()<1) {
					projectList.add("");
				} else {
					String pStr = "";
					for(Long id : pidList) {
						DiseaseProject dp = diseaseProjectService.findById(id);
						if(dp!=null && StringUtil.isNotEmpty(dp.getDiseaseName())) {
							pStr += dp.getDiseaseName() + "、";
						}
					}
					projectList.add(pStr);
				}
				answerList.add(userService.getTotelAnswerNum(u.getId()));
				agreeList.add(userService.getTotelAgreeNum(u.getId()));
				
				if(u.getDoctorType()!=null) {
					DoctorType dt = doctorTypeService.queryById(u.getDoctorType());
					doctorTypeList.add(dt);
				}else {
					doctorTypeList.add(null);
				}
			}
			// 总页数
			long totalPage = pageUser.getPageCount();
			// 每页展示记录数
			// pageUser.getPageSize();
			// 总记录数
			long totalSize = pageUser.getTotalCount();

			model.addAttribute("pList", pList);
			model.addAttribute("dlist", dlist);
			model.addAttribute("uList", userList);
			model.addAttribute("projectList", projectList);
			model.addAttribute("pageCount", totalPage);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("pageNo", pageNo);
			model.addAttribute("totalSize", totalSize);
			
			model.addAttribute("answerList", answerList);
			model.addAttribute("agreeList", agreeList);
			model.addAttribute("provinceId", provinceId);
			model.addAttribute("projectId", projectId);
			
			model.addAttribute("doctorTypeList", doctorTypeList);

		} catch (AjlException e) {
			log.error("[" + flg + "]", e);
		} catch (Throwable e) {
			log.error("[" + flg + "]", e);
		}
		return "/doctor/finddoctor";
	}
	
	/**
	 * 处理
	 * @param project
	 * @param flg
	 * @return
	 */
	private List<Long> dealProject(String project, String flg) {
		List<Long> pidList = new ArrayList<Long>();
		try {
			// 去掉的第一个逗号和最后一个逗号
			project = project.substring(1,project.length()-1);
			String[] pArr = project.split(",");
			
			for(String p : pArr) {
				try{
					pidList.add(Long.parseLong(p));
				}catch(Exception e){} 
			}
		} catch(Exception e) {
			log.error("["+flg+"]解析project失败", e);
		}
		return pidList;
	}
	
	/**
	 * 发送消息
	 * 
	 * @param request
	 * @param message
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "sendmessage.do", produces = { Constants.PRODUCES })
	public String sendMessage(HttpServletRequest request, Message message,
			Model model) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		try {
			log.info("[" + flg + "]"
					+ ((message == null) ? null : message.toString()));
			Validator.validator(request.getRequestURI(), message);
			message.setIsRead(0);
			message.setType(1);
			message.setCreateTime(new Date());
			log.info("[" + flg + "]保存" + message.toString());
			messageService.save(message);
			log.info("[" + flg + "]保存成功" + message.toString());
		} catch (AjlException e) {
			log.error("[" + flg + "]", e);
		} catch (Throwable e) {
			log.error("[" + flg + "]", e);
		}
		return "/doctor/finddoctor";
	}
}
