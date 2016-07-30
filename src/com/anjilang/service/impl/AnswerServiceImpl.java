package com.anjilang.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anjilang.dao.AnswerCommentDao;
import com.anjilang.dao.AnswerDao;
import com.anjilang.dao.QuestionDao;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.Answer;
import com.anjilang.entity.AnswerComment;
import com.anjilang.entity.Question;
import com.anjilang.entity.User;
import com.anjilang.service.AnswerService;
import com.anjilang.util.AjlException;

@Service
public class AnswerServiceImpl implements AnswerService{
	private Logger log = Logger.getLogger(this.getClass());
	@Autowired
	private AnswerDao answerDao;
	
	@Autowired
	private QuestionDao questionDao;
	
	@Autowired
	private AnswerCommentDao commentDao;
	
	
	
	@Override
	public void save(Answer entity) throws AjlException {
		try{
			log.info("AnswerServiceImpl 方法（save）保存问题信息参数:" + entity);
			answerDao.save(entity);
		}catch(Exception e){
			log.error("AnswerServiceImpl 方法（save）保存问题信息失败", e);
			throw AjlException.createErr("5999");
		}
	}

	@Override
	public void delect(Long id) throws AjlException {
		try{
			log.info("AnswerServiceImpl 方法（delect） 删除问题信息参数:id=" + id);
			Answer entity = answerDao.get(id);
			if(entity == null){
				throw AjlException.createErr("5000");
			}
			answerDao.delete(entity);
		}catch(Exception e){
			log.error("AnswerServiceImpl 方法（delect）", e);
			throw AjlException.createErr("5999");
		}
	}

	@Override
	public List<Answer> queryByAny(Map<String, Object> maps)
			throws AjlException {
		Object pageSizeStr = maps.get("pageSize");
		Object pageNoStr =  maps.get("pageNo");
		Object answerIdStr =  maps.get("answerId");
		
		int pageNo =1;
		int pageSize=4;
		Map<String, Object> mapquery = new HashMap<String,Object>();
		if(pageSizeStr != null && !"".equals(pageSizeStr.toString())){
			pageSize = Integer.parseInt(pageSizeStr.toString());
		}
		if(pageNoStr!= null && !"".equals(pageNoStr.toString())){
			pageNo = Integer.parseInt(pageNoStr.toString());
		}
		if(answerIdStr!= null && !"".equals(answerIdStr.toString())){
			mapquery.put("answerId",Long.parseLong(answerIdStr.toString()));
		}
		PaginationSupport<Answer> answers = answerDao.queryPage(mapquery, new String[]{"id"}, pageSize, pageNo);
		return answers.getItems();
	}

	@Override
	public Answer queryAnswerById(Long id) throws AjlException {
		try{
			log.info("AnswerServiceImpl 方法（queryAnswerById）获取问题信息参数:id=" + id);
			Answer entity = answerDao.get(id);
			if(entity == null){
				throw AjlException.createErr("5000");
			}
			return entity;
		}catch(Exception e){
			log.error("AnswerServiceImpl 方法（queryAnswerById）获取问题信息参数", e);
			throw AjlException.createErr("5999");
		}
	}

	@Override
	@Transactional
	public Answer modify(Answer answer) throws AjlException {
		try{
			log.info("AnswerServiceImpl 方法（modify）修改问题信息参数:" + answer);
			Answer entity = answerDao.get(answer.getId());
			if(entity == null){
				throw AjlException.createErr("5000");
			}
			answerDao.update(answer);
			return answerDao.get(answer.getId());
		}catch(Exception e){
			log.error("AnswerServiceImpl 方法（modify）删除问题信息失败", e);
			throw AjlException.createErr("5999");
		}
	}

	@Override
	public List<Answer> queryByQuestionId(Long questionId) throws AjlException {
		try{
			log.info("AnswerServiceImpl 方法（queryByQuestionId）根据问题获取问答信息参数: questionId=" + questionId);
			StringBuffer hql=new StringBuffer();
			hql.append("from Answer where 1=1");
			if(questionId != null){
				hql.append(" and answerId = "+ questionId);
			}
			hql.append(" order by crTime desc");
			List<Answer> answerList=answerDao.find(hql.toString());
			return answerList;
		}catch(Exception e){
			log.error("AnswerServiceImpl 方法（queryByQuestionId）根据问题获取问答问题信息失败", e);
			throw AjlException.createErr("5999");
		}
	}

	@Override
	public Answer addAnswer(Long questionId, String content, User user, Date date) {
		Answer answer = new Answer();
		answer.setUser(user);
		answer.setAnswerId(questionId);
		answer.setContent(content);
		answer.setCrTime(date);
		answer.setParentId((long)0);
		answerDao.save(answer);
		
		return answer;
	}

	@Override
	public List<AnswerComment> queryCommentsByAnswer(Long answerId) {
		StringBuffer hql=new StringBuffer();
		hql.append("from AnswerComment where 1=1");
		hql.append(" and answerId = "+ answerId);
		hql.append(" order by crTime desc");
		List<AnswerComment>list = commentDao.find(hql.toString());
		return list;
	}

	@Override
	public AnswerComment saveAnswerComment(AnswerComment entity) throws AjlException {
		try{
			log.info("AnswerServiceImpl 方法（save）保存问题信息参数:" + entity);
			commentDao.save(entity);
			return entity;
		}catch(Exception e){
			log.error("AnswerServiceImpl 方法（save）保存问题信息失败", e);
			throw AjlException.createErr("5999");
		}
	}

	@Override
	@Transactional
	public Question updateQuestion(Question quesion) {
		questionDao.update(quesion);
		return questionDao.get(quesion.getId());
	}

	@Override
	public Question findQuestionById(long id) {
		return questionDao.get(id);
	}

	@Override
	@Transactional
	public void deleteCommentById(long id) throws AjlException {
		//回答回复数减一
		AnswerComment comment =  commentDao.get(id);
		Answer answer =  this.queryAnswerById(comment.getAnswerId());
		int answerNum = answer.getCommentNum();
		answer.setCommentNum(answerNum - 1);
		
		this.modify(answer);
		//删除回复对象
		commentDao.deleteByKey(id);
		
	}

	@Override
	@Transactional
	public void deleteAnswerById(long answerId) throws Exception{
		
		try {
			//1.删除关联的回复对象
			List<AnswerComment> comments = this.queryCommentsByAnswer(answerId);
			for(AnswerComment comment :comments){
				log.info("delete cmt:" + comment);
				this.deleteCommentById(comment.getId());
			}
			
			//2.删除回答对象
			log.info("delete answer id:" + answerId);
			Answer answer = queryAnswerById(answerId);
			answerDao.delete(answer);
		} catch (Exception e) {
			throw new Exception("delete anserComment error" + e.getMessage());
		}
	
		
	}
	
	@Override
	@Transactional
	public void deleteQuestionById(long id) throws Exception {

		try {
			//1.删除问题关联的回答对象
			List<Answer>answers = this.queryByQuestionId(id);
			for(Answer answer:answers){
				log.info("answerId:" + answer);
				this.deleteAnswerById(answer.getId());
			}
			
			//2.删除问题对象
			log.info("delete question id:" + id);
			Question question = this.findQuestionById(id);
			questionDao.delete(question);
		} catch (Exception e) {
			throw new Exception("delete question error" + e.getMessage());
		}

	}
}
