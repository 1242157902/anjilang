package com.anjilang.controller;

import java.util.Arrays;
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

import com.anjilang.controller.vo.SeniorDoctorVo;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.SeniorDoctor;
import com.anjilang.service.SeniorDoctorService;
import com.anjilang.util.Constants;

@Controller
@RequestMapping("seniordoctor")
public class SeniorDoctorController {
	private Logger log = Logger.getLogger(getClass());
	@Autowired
	private SeniorDoctorService seniorDoctorService;
	
	@RequestMapping(value="save.do", produces={Constants.PRODUCES})
	public String save(HttpServletRequest request, SeniorDoctorVo vo) {
		String logFlag = (String) request.getAttribute(Constants.LOGFLAG);
		if(vo == null) {
			log.info("["+log+"] seniorDoctor=null");
		}else {
			Integer sort  = (vo.getSort()==null) ? 0 : vo.getSort();
			SeniorDoctor seniorDoctor = new SeniorDoctor(null, vo.getName(), vo.getDescription(), vo.getHeader(), vo.getUrl(), sort, new Date(), new Date());
			seniorDoctorService.save(seniorDoctor, logFlag);
		}
		return "/managers/seniordoctor/list";
	}
	
	@RequestMapping(value="list.do", produces={Constants.PRODUCES})
	public @ResponseBody String list(HttpServletRequest request, Integer pageSize, Integer pageNo) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		log.info("[" + flg + "]pageNo=" + pageNo + ",pageSiz[" + pageSize + "]");
		pageSize = (pageSize!=null && pageSize > 0) ? pageSize : 100;
		pageNo = (pageNo!=null && pageNo > 0) ? pageNo : 1;
		
		try{
			PaginationSupport<SeniorDoctor> page = seniorDoctorService.queryAll(false, pageSize, pageNo);
			List<SeniorDoctor> list = page.getItems();
			
			JSONArray jSONArray=JSONArray.fromObject(list);
			return jSONArray.toString();
		} catch (Throwable e) {
			log.info("[" + flg + "]", e);
	//		error(model, AjlException.createErr("5027"));
		}
		
		return new JSONArray().toString();
	}
	
	@RequestMapping(value="toedit.do")
	public String toEdit(HttpServletRequest request, Long id, Model model) {
		String logFlag = (String) request.getAttribute(Constants.LOGFLAG);
		log.info("[" + logFlag + "]id=" + id + "]");
		if(id != null && id > 0) {
			SeniorDoctor seniorDoctor = seniorDoctorService.queryById(id, logFlag);
			if(seniorDoctor!=null) {
				model.addAttribute("seniorDoctor", seniorDoctor);
				return "/managers/seniordoctor/edit";
			}
		}
		return "/managers/seniordoctor/list";
	}
	
	@RequestMapping(value="edit.do")
	public String edit(HttpServletRequest request, SeniorDoctorVo vo, Model model) {
		String logFlag = (String) request.getAttribute(Constants.LOGFLAG);
		log.info("[" + logFlag + "]vo[" + ((vo!=null)?vo.toString():"null") + "]");
		if(vo !=null && vo.getId() != null && vo.getId() > 0) {
			SeniorDoctor seniorDoctor = seniorDoctorService.queryById(vo.getId(), logFlag);
			if(seniorDoctor != null) {
				seniorDoctor.setName(vo.getName());
				seniorDoctor.setDescription(vo.getDescription());
				seniorDoctor.setHeader(vo.getHeader());
				seniorDoctor.setSort(vo.getSort());
				seniorDoctor.setUrl(vo.getUrl());
				seniorDoctor.setUpdateTime(new Date());
				
				seniorDoctorService.update(seniorDoctor, logFlag);
			}
		}
		return "/managers/seniordoctor/list";
	}
	
	@RequestMapping(value = "del.do", produces = { Constants.PRODUCES })
	public String deletepic(HttpServletRequest request) {
		String logFlag = (String) request.getAttribute(Constants.LOGFLAG);
		//1 获取数据
		String[] ids = request.getParameterValues("id");
		//2 删除
		if(ids!=null && ids.length>0){
			log.error("["+logFlag+"]ids["+Arrays.toString(ids)+"]");
			for(int i=0;i<ids.length;i++){
				SeniorDoctor seniorDoctor  = new SeniorDoctor();
				try{
					seniorDoctor.setId(Long.parseLong(ids[i]));
				}catch(Exception e) {
					continue;
				}
				seniorDoctorService.delete(seniorDoctor, logFlag);
			}
		} else {
			log.error("["+logFlag+"]ids=null");
		}
		
		return "/managers/seniordoctor/list";
	}
}
