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

import com.anjilang.controller.vo.SpecColVo;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.SpecCol;
import com.anjilang.service.SpecColService;
import com.anjilang.util.Constants;

@Controller
@RequestMapping("speccol")
public class SpecColController {
	private Logger log = Logger.getLogger(getClass());
	@Autowired
	private SpecColService specColService;
	
	
	@RequestMapping(value="save.do", produces={Constants.PRODUCES})
	public String save(HttpServletRequest request, SpecColVo vo) {
		String logFlag = (String) request.getAttribute(Constants.LOGFLAG);
		if(vo == null) {
			log.info("["+log+"] seniorDoctor=null");
		}else {
			Integer sort  = (vo.getSort()==null) ? 0 : vo.getSort();
		SpecCol specCol = new SpecCol(null,vo.getTitle(), vo.getContent(), vo.getPic(), vo.getUrl(), sort, new Date(), new Date());
			specColService.save(specCol, logFlag);
		}
		return "/managers/speccol/list";
	}
	
	@RequestMapping(value="list.do", produces={Constants.PRODUCES})
	public @ResponseBody String list(HttpServletRequest request, Integer pageSize, Integer pageNo) {
		String flg = (String) request.getAttribute(Constants.LOGFLAG);
		log.info("[" + flg + "]pageNo=" + pageNo + ",pageSiz[" + pageSize + "]");
		pageSize = (pageSize!=null && pageSize > 0) ? pageSize : 100;
		pageNo = (pageNo!=null && pageNo > 0) ? pageNo : 1;
		
		try{
			PaginationSupport<SpecCol> page = specColService.queryAll(false, pageSize, pageNo);
			List<SpecCol> list = page.getItems();
			
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
			SpecCol specCol = specColService.queryById(id, logFlag);
			if(specCol!=null) {
				model.addAttribute("specCol", specCol);
				return "/managers/speccol/edit";
			}
		}
		return "/managers/speccol/list";
	}
	
	@RequestMapping(value="edit.do")
	public String edit(HttpServletRequest request, SpecColVo vo, Model model) {
		String logFlag = (String) request.getAttribute(Constants.LOGFLAG);
		log.info("[" + logFlag + "]vo[" + ((vo!=null)?vo.toString():"null") + "]");
		if(vo !=null && vo.getId() != null && vo.getId() > 0) {
			SpecCol specCol = specColService.queryById(vo.getId(), logFlag);
			if(specCol != null) {
				specCol.setTitle(vo.getTitle());
				specCol.setContent(vo.getContent());
				specCol.setPic(vo.getPic());
				specCol.setSort(vo.getSort());
				specCol.setUrl(vo.getUrl());
				specCol.setUpdateTime(new Date());
				
				specColService.update(specCol, logFlag);
			}
		}
		return "/managers/speccol/list";
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
				SpecCol specCol  = new SpecCol();
				try{
					specCol.setId(Long.parseLong(ids[i]));
				}catch(Exception e) {
					continue;
				}
				specColService.delete(specCol, logFlag);
			}
		} else {
			log.error("["+logFlag+"]ids=null");
		}
		
		return "/managers/speccol/list";
	}
}
