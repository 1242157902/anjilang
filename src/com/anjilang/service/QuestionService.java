package com.anjilang.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.anjilang.controller.vo.Interlocution;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.Answer;
import com.anjilang.entity.Question;
import com.anjilang.util.AjlException;

/**   
 * @Title: QuestionService.java 
 * @Package com.anjilang.service 
 * @Description: 问题service
 * @author linqingsong
 * @date 2015-1-1 下午10:36:36 
 * @version V1.0   
 */
public interface QuestionService {
	/**
	 * 保存资讯分组
	 * @param informationType
	 */
	public void save(Question question) throws AjlException;
	
	/**
	 * 查询列表
	 * @return
	 */
	public List<Question> query(Map<String,String>map);
	
	/**
	 * 删除对象
	 * @param informationType
	 */
	public void delete(Long id) throws AjlException; 
	
	/**
	 * 通过id查询对象
	 * @param id
	 * @return
	 */
	public Question findById(Long id) throws AjlException;

	/**
	 * 通过问题id查询所有的回答对象
	 * @param questionId
	 * @return
	 */
	public List<Answer> queryAnswersByQuestionId(int questionId);
	
	/**
	 * 修改问题
	 * @param question
	 * @throws AjlException
	 */
	public void modifyQuestion(Question question) throws AjlException;
	
	/**
	 * 通过用户Id获取问题
	 * @param userId
	 * @return
	 */
	public List<Question> getByUserId(Long userId) throws AjlException;

	/**
	 * 获取最新的问题
	 * @param map
	 * @return
	 */
	public PaginationSupport<Question> queryLatest(HashMap<String, String> map);

	/**
	 * 获取最多浏览问题
	 * @param map
	 * @return
	 */
	public PaginationSupport<Question> queryHotest(HashMap<String, String> map);

	/**
	 * 获取未回答问题
	 * @param map
	 * @return
	 */
	public PaginationSupport<Question> queryUnAnswerd(HashMap<String, String> map);
	
	/**
	 * 统计User的总回答数
	 * @param userId 
	 * @return
	 */
	public Long queryAnswerNum(Long userId);
	
	/**
	 * 查询所有的问题
	 * @return
	 */
	public List<Question> queryAll();
	
	/**
	 * JDBC查询用户的问题和回答
	 * @param userId  用户ID
	 * @param pageNo 页码
	 * @param pageSize 分页条数
	 * @return
	 * @throws AjlException
	 */
	public PaginationSupport<Interlocution> queryAnswerByQueionId(Long userId,
			Integer pageNo, Integer pageSize) throws AjlException;
	
	/**
	 * 查询今天回答的问题
	 * @return
	 */
	List<Question>queryTodayAnswerdQuestion();
	
}
