package com.anjilang.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.anjilang.entity.Answer;
import com.anjilang.entity.AnswerComment;
import com.anjilang.entity.Question;
import com.anjilang.entity.User;
import com.anjilang.util.AjlException;

/**   
 * @Title: AnswerService.java 
 * @Package com.anjilang.service 
 * @Description: 问答service
 * @author liudebing
 * @date 2015-1-6 下午21:36:36 
 * @version V1.0   
 */
public interface AnswerService {
	/**
	 * 新增问答
	 * @param answer
	 * @throws AjlException
	 */
	public void save(Answer answer) throws AjlException;
	/**
	 * 删除问答
	 * @param id
	 * @throws AjlException
	 */
	public void delect(Long id)throws AjlException;
	/**
	 * 根据查询条件查询问答
	 * @param maps
	 * @return
	 * @throws AjlException
	 */
	public List<Answer> queryByAny(Map<String,Object> maps)
			throws AjlException;
	/**
	 * 根据Id获得问答
	 * @param id
	 * @return
	 * @throws AjlException
	 */
	public Answer queryAnswerById(Long id) throws AjlException;
	
	/**
	 * 问答修改
	 * @param answer
	 * @return 
	 * @throws AjlException
	 */
	public Answer modify(Answer answer)throws AjlException;
	
	/**
	 * 根据问题id获得问答
	 * @param listAnswer
	 * @throws AjlException
	 */
	public List<Answer> queryByQuestionId(Long questionId)throws AjlException;
	
	/**
	 * 添加问题答案
	 * @param questionId
	 * @param content
	 * @param user TODO
	 * @param date TODO
	 * @return
	 */
	public Answer addAnswer(Long questionId, String content,
			User user, Date date);
	
	/**
	 * 获取回复集合
	 * @param answerId
	 * @return
	 */
	public List<AnswerComment> queryCommentsByAnswer(Long answerId);
	
	/**
	 * 添加回复
	 * @param entity
	 * @return TODO
	 * @throws AjlException
	 */
	AnswerComment saveAnswerComment(AnswerComment entity) throws AjlException;
	
	/**
	 * 更新问题
	 * @return
	 */
	public Question updateQuestion(Question quesion);
	Question findQuestionById(long parseLong);
	/**
	 * 删除回复
	 * @param parseLong
	 * @throws AjlException 
	 */
	public void deleteCommentById(long id) throws AjlException;
	
	/**
	 * 删除问题
	 * @param parseLong
	 * @throws Exception 
	 */
	public void deleteQuestionById(long id) throws Exception;
	
	/**
	 * 删除回答
	 * @param answer id
	 * @throws Exception 
	 */
	void deleteAnswerById(long answerId) throws Exception;
	
}
