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

import com.anjilang.entity.Comment;
import com.anjilang.entity.Report;
import com.anjilang.entity.TopicReply;
import com.anjilang.service.CommentService;
import com.anjilang.service.ReportService;
import com.anjilang.service.TopicReplyService;
import com.anjilang.util.AjlException;

/**
 * 
 * <p>Title：        ReportController<p>
 * <p>Description:举报controller  <p>
 * @date:           2015年8月19日下午9:49:21
 * @author:         ysl
 * @version         1.0
 */
@Controller
@RequestMapping("report")
public class ReportController {
	
	private Logger log = Logger.getLogger(getClass());
	
	@Autowired
	private ReportService reportService;
	
	@Autowired
	private TopicReplyService topicReplyService;
	
	@Autowired
	private CommentService commentService;
	
	@RequestMapping(value="addReport")
	public void addReport(Long repid,String reason,String reasondetail)throws Exception{
		Report report = new Report();
		report.setReason(reason);
		report.setReasonDetail(reasondetail);
		report.setReportDate(new Date());
		report.setFormtable("reply");
		TopicReply topicReply = topicReplyService.getTopicReply(repid);
		report.setTopicReply(topicReply);
		if (topicReply !=null) {
			report.setContent(topicReply.getContent());
		}
		reportService.addReport(report);
		//System.out.println(reason);
	}
	
	
	/**
	 *  举报内容列表查询
	 * @param request
	 * @param model
	 * @return  String
	 * @throws AjlException 
	 * @throws Exception
	 */
	@RequestMapping(value = "queryAjax.do", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody
	String query(HttpServletRequest request) throws AjlException {
		List<Report> list=reportService.queryAjax();
		JSONArray jSONArray=JSONArray.fromObject(list);
		return jSONArray.toString();
	}
	
	
	/**
	 * 举报内容删除
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "delete.do", produces = { "application/json;charset=UTF-8" })
	public String delete(HttpServletRequest request,  Model model) throws Exception {
		//1 获取数据
		String[] ids=request.getParameterValues("id");
		System.out.println(ids[0]);
		//2 删除
		if(ids!=null && ids.length>0){
			for(int i=0;i<ids.length;i++){
				Report report = reportService.load(Long.parseLong(ids[i]));
				
				if (report.getFormtable().equals("reply")) {
					if (report!=null) {
						TopicReply topicReply = report.getTopicReply();
						if (topicReply != null) {
							/*topicReplyService.deleteTopicReply(topicReply.getId());*/
							Boolean b = topicReply.getIsDelete();
							if(!b)
							{
								topicReply.setIsDelete(true);
							}
							topicReplyService.updateTopicReply(topicReply);
							reportService.delete(report);
						}
					}
				}else{
					Long id = report.getTopicReply().getId();
					Comment comment = commentService.getComment(id);
					Boolean b = comment.getIsDelete();
					if (!b) {
						comment.setIsDelete(true);
					}
					commentService.updateComment(comment);
					reportService.delete(report);
				}
			}
		}	
		
		//3 跳转页面
		return "/managers/report/reportlist";
	}
	
}
