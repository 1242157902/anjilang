package com.anjilang.service;

import java.util.List;
import java.util.Map;

import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.ArticleInfo;
import com.anjilang.entity.Information;
import com.anjilang.util.AjlException;

/**
 * 文章 接口
 * @author liudb
 * @see 1.0.0
 */
public interface ArticleInfoService {
	
	/**
	 * 分页查询
	 * @param params 
	 * @param order
	 * @param pageSize
	 * @param pageNo
	 * @return
	 */
	public PaginationSupport<ArticleInfo> queryPage(Map<String, Object> params,String[] order, int pageSize, int pageNo);
	
	/**
	 * 查询浏览最多的文章
	 * @return
	 * @throws AjlException
	 */
	public List<ArticleInfo> queryByHot() throws AjlException;
	
	/**
	 * 根据查询条件查询文章
	 * @param userId 发表人id
	 * @param title 文章标题
	 * @param pageNo 页码
	 * @param pageSize 
	 * @return
	 * @throws AjlException
	 */
	public List<ArticleInfo> queryArticleInfo(Long userId,String title,Integer pageNo,Integer pageSize) throws AjlException;
	
	/**
	 * 添加文章
	 * @param articleInfo
	 * @throws AjlException
	 */
	public void addArticleInfo(ArticleInfo articleInfo) throws AjlException;
	
	/**
	 * 修改文章
	 * @param articleInfo
	 * @throws AjlException
	 */
	public void modifyArticleInfo(ArticleInfo articleInfo) throws AjlException;
	
	/**
	 * 根据ID删除文章
	 * @param id 文章Id
	 * @throws AjlException
	 */
	public void delectArticleInfo(Long id) throws AjlException;
	
	/**
	 * 根据ID获取文章信息
	 * @param id 主键ID
	 * @return 文章信息
	 * @throws AjlException
	 */
	public ArticleInfo getById(Long id) throws AjlException;
	
	/**
	 * 根据条件统计记录
	 * @param userId 发布人ID
	 * @param title 文章标题
	 * @return 返回记录数
	 * @throws AjlException
	 */
	public Long countArticleInfo(Long userId,String title) throws AjlException;
	
	/**
	 * 统计总记录
	 * @return 返回总记录数
	 * @throws AjlException
	 */
	public Long countArticleInfo() throws AjlException;
	/**
	 * 根据条件统计记录
	 * @param maps
	 * @return
	 * @throws AjlException
	 */
	public Long queryCount(Map<String, String> maps)throws AjlException;
	
}
