package com.anjilang.service;

import java.util.List;

import com.anjilang.entity.Report;
import com.anjilang.util.AjlException;

public interface ReportService {
	
	/**
	 * 添加举报
	 * @param 
	 * @throws AjlException
	 */
	public void addReport(Report report) throws AjlException;
	
	/**
	 * 
	 * @return:       List<Report> 
	 * @return
	 * @throws AjlException
	 * <p>Description: 举报列表查询<p>
	 * @date:          2015年8月20日上午11:34:16
	 * @author         ysl
	 */
	public List<Report> queryAjax()throws AjlException;
	
	/**
	 * 
	 * @return:       Report 
	 * @return
	 * @throws AjlException
	 * <p>Description: 根据举报对象来获取该条举报<p>
	 * @date:          2015年8月20日下午1:21:16
	 * @author         ysl
	 */
	public Report getReportByRepid(Long repid)throws AjlException;
	
	/**
	 * 
	 * @return:       void 
	 * @param report
	 * @throws AjlException
	 * <p>Description:删除report <p>
	 * @date:          2015年8月20日下午2:04:26
	 * @author         ysl
	 */
	public void delete(Report report) throws AjlException;
	
	/**
	 * 
	 * @return:       Report 
	 * @param id
	 * @return
	 * @throws Exception
	 * <p>Description: 根据主键查询实体<p>
	 * @date:          2015年8月20日下午2:15:42
	 * @author         ysl
	 */
	public Report load(Long id) throws Exception ;
}
