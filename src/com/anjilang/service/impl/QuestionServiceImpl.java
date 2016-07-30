package com.anjilang.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anjilang.controller.vo.Interlocution;
import com.anjilang.controller.vo.RegistVo;
import com.anjilang.dao.AnswerDao;
import com.anjilang.dao.DiseaseProjectDao;
import com.anjilang.dao.QuestionDao;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.Answer;
import com.anjilang.entity.ArticleInfo;
import com.anjilang.entity.DiseaseProject;
import com.anjilang.entity.Question;
import com.anjilang.service.AnswerService;
import com.anjilang.service.QuestionService;
import com.anjilang.util.AjlException;
import com.anjilang.util.DateUtil;
import com.anjilang.util.StringUtil;

/**
 * @Title: QuestionServiceImpl.java
 * @Package com.anjilang.service.impl
 * @Description: 问题service实现
 * @author linqingsong
 * @date 2015-1-1 下午10:36:59
 * @version V1.0
 */

@Service
public class QuestionServiceImpl implements QuestionService {
	private Logger log = Logger.getLogger(this.getClass());
	@Autowired
	private JdbcTemplate jdbcTemplate;
	/**
	 * 默认4条数据
	 */
	private static int DEFAULT_PAGE_SIZE = 6;
	@Autowired
	private QuestionDao questionDao;

	@Autowired
	private AnswerDao answerDao;

	@Autowired
	private DiseaseProjectDao diseaseProjectDao;

	@Autowired
	private com.anjilang.dao.UserDao userDao;

	@Override
	public void save(Question question) throws AjlException {
		try {
			log.info("QuestionServiceImpl 方法（save）保存问题信息参数:" + question);
			questionDao.save(question);
		} catch (Exception e) {
			log.error("AnswerServiceImpl 方法（queryAnswerById）获取问题信息失败", e);
			throw AjlException.createErr("5028");
		}
	}

	@Override
	public List<Question> query(Map<String, String> map) {
		String diseaseId = map.get("diseaseId");
		String answerNum = map.get("answerNum");
		// String crTime=map.get("crTime");
		String num = map.get("num");

		StringBuffer hql = new StringBuffer();
		hql.append("from Question where 1=1");
		if (StringUtils.isNotBlank(diseaseId)) {
			hql.append(" and diseaseId = " + Integer.parseInt(diseaseId) + "");
		}

		if (StringUtils.isNotBlank(answerNum)) {
			hql.append(" and answerNum = 0");
		} else if (StringUtils.isNotBlank(num)) {
			hql.append(" order by num desc");
		} else {
			hql.append(" order by id desc");
		}

		/*
		 * String pageSize=map.get("pageSize"); if(pageSize==null ||
		 * pageSize.equals("null") || pageSize.equals("")){ pageSize="5"; }
		 * String page=map.get("page"); if(page==null || page.equals("null") ||
		 * page.equals("")){ page="0"; }
		 */

		List<Question> questionList = questionDao.find(hql.toString());

		return questionList;
	}

	@Override
	public void delete(Long id) throws AjlException {
		try {
			log.info("QuestionServiceImpl 方法（delete）删除问题信息参数:id" + id);
			Question query = questionDao.get(id);
			if (query == null) {
				throw AjlException.createErr("5000");
			}
			questionDao.delete(query);
		} catch (AjlException e) {
			throw e;
		} catch (Exception e) {
			log.error("QuestionServiceImpl 方法（delete）删除问题信息失败", e);
			throw AjlException.createErr("5999");
		}
	}

	@Override
	public Question findById(Long id) throws AjlException {
		try {
			log.info("QuestionServiceImpl 方法（findById）根据ID问题信息参数:id" + id);
			return questionDao.get(id);
		} catch (Exception e) {
			log.error("QuestionServiceImpl 方法（findById）根据ID问题信息失败", e);
			throw AjlException.createErr("5999");
		}
	}

	@Override
	@Transactional
	public void modifyQuestion(Question question) throws AjlException {
		try {
			log.info("QuestionServiceImpl 方法（modifyQuestion）修改问题信息参数:"
					+ question);
			Question query = questionDao.get(question.getId());
			if (query == null) {
				throw AjlException.createErr("5000");
			}
			// question.setAnswers(query.getAnswers());
			questionDao.update(question);
		} catch (Exception e) {
			log.info("QuestionServiceImpl 方法（modifyQuestion）修改问题信息失败", e);
			throw AjlException.createErr("5999");
		}
	}

	@Override
	public List<Question> getByUserId(Long userId) throws AjlException {
		try {
			log.info("QuestionServiceImpl 方法（getByUserId）根据用户问题信息参数:userId="
					+ userId);
			StringBuffer hql = new StringBuffer();
			hql.append("from Question where 1=1");
			if (userId != null) {
				hql.append(" and userId = " + userId);
			}
			hql.append(" order by crTime desc");
			List<Question> questionList = questionDao.find(hql.toString());
			return questionList;
		} catch (Exception e) {
			log.info("QuestionServiceImpl 方法（getByUserId）根据用户问题信息失败", e);
			throw AjlException.createErr("5999");
		}
	}

	@Override
	public List<Answer> queryAnswersByQuestionId(int questionId) {
		StringBuffer hql = new StringBuffer();
		hql.append("from Answer where 1=1");
		hql.append(" and answerId = " + questionId);
		return answerDao.find(hql.toString());
	}

	@Override
	public PaginationSupport<Question> queryLatest(HashMap<String, String> map) {
		String diseaseId = map.get("diseaseId");
		String userId = map.get("userId");
		String pageSizeStr = map.get("pageSiz"
				+ "*e");
		int pageSize = DEFAULT_PAGE_SIZE;

		String orders[] = { "crTime" };
		HashMap<String, Object> params = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(diseaseId)) {
			DiseaseProject diseaseProject = diseaseProjectDao.get(Long
					.parseLong(diseaseId));
			params.put("disease", diseaseProject);
		}
		if (userId != null) {
			// params.put("userId", Long.parseLong(userId));
			params.put("user", userDao.get(new Long(userId)));
		}
		if (pageSizeStr != null && !"".equals(pageSizeStr)) {
			pageSize = Integer.parseInt(pageSizeStr);
		}
		String pageNo = map.get("pageNo");
		return questionDao.queryPage(params, orders, pageSize,
				Integer.parseInt(pageNo));
	}

	@Override
	public PaginationSupport<Question> queryHotest(HashMap<String, String> map) {
		String diseaseId = map.get("diseaseId");
		String orders[] = { "num" };
		HashMap<String, Object> params = new HashMap<String, Object>();
		if (false == StringUtil.isEmpty(diseaseId)) {
			DiseaseProject diseaseProject = diseaseProjectDao.get(Long
					.parseLong(diseaseId));
			params.put("disease", diseaseProject);
		}
		return questionDao.queryPage(params, orders, DEFAULT_PAGE_SIZE,
				Integer.parseInt(map.get("pageNo")));
	}

	@Override
	public PaginationSupport<Question> queryUnAnswerd(
			HashMap<String, String> map) {
		String diseaseId = map.get("diseaseId");
		String orders[] = { "id" };
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("answerNum", 0);
		if (StringUtils.isNotBlank(diseaseId)) {
			DiseaseProject diseaseProject = diseaseProjectDao.get(Long
					.parseLong(diseaseId));
			params.put("disease", diseaseProject);
		}
		return questionDao.queryPage(params, orders, DEFAULT_PAGE_SIZE,
				Integer.parseInt(map.get("pageNo")));
	}

	@Override
	public Long queryAnswerNum(Long userId) {
		StringBuffer hql = new StringBuffer();
		hql.append("select sum(answerNum) as answerNum from Question where userId = "
				+ userId);
		List it = questionDao.find(hql.toString());
		if (it != null && it.size() > 0) {
			return (Long) it.get(0);
		}
		return 0L;
	}

	@Override
	public List<Question> queryAll() {
		return questionDao.loadAll();
	}

	/**
	 * 查询用户的问题和回答
	 * 
	 * @param userId 用户Id
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public PaginationSupport<Interlocution> queryAnswerByQueionId(Long userId,
			Integer pageNo, Integer pageSize) {
		PaginationSupport<Interlocution> page = new PaginationSupport<Interlocution>(2);
		page.setPageSize(pageSize);
		
		List<Interlocution> listVo = new ArrayList<Interlocution>();
		Integer count = 0;
		try{
			StringBuffer sql = new StringBuffer(
					"select c.disease_name diseaseName,c.id diseaseId,a.id aid,a.answerId aanswerId,a.content acontent ,a.crTime acrTime,"
					+ "b.crTime bcrTime,b.content bcontent,b.answerNum answerNum,b.num num from t_answer a,"
					+ "t_question b,t_disease_project c where a.answerId=b.id and c.id=b.diseaseId ");
			Object[] values = {};
			if (userId != null) {
				sql.append(" and a.userId=? ");
				values = ArrayUtils.add(values, userId);
			}
			StringBuffer countSql = new StringBuffer("select count(1) from t_answer a,t_question b,t_disease_project c where a.answerId=b.id and c.id=b.diseaseId ");
			Object[] countValues = {};
			if (userId != null) {
				countSql.append(" and a.userId=? ");
				countValues = ArrayUtils.add(countValues, userId);
			}
			
			count = jdbcTemplate.queryForInt(countSql.toString(), countValues);
			sql.append("order by b.crTime limit ?,?");
			values = ArrayUtils.add(values, (pageNo - 1) * pageSize);
			values = ArrayUtils.add(values, pageSize);
			List<?> listMap = jdbcTemplate.queryForList(sql.toString(), values);
			
			for (int i = 0; i < listMap.size(); i++) {
				Map<String, Object> map = (Map<String, Object>) listMap.get(i);
				Interlocution vo = new Interlocution();
				if (null != map.get("aid".toUpperCase())) {//回答Id
					Long answerId = Long.parseLong(map.get("aid").toString());
					vo.setAnswerId(answerId);
				}
				if (null != map.get("aanswerId".toUpperCase())) {//回答所属问题ID
					Long questionId = Long.parseLong(map.get("aanswerId").toString());
					vo.setQuestionId(questionId);
				}
				if (null != map.get("acrTime".toUpperCase())) {
					String auditDate = map.get("acrTime").toString();
					if (auditDate.lastIndexOf(".") > -1) {
						auditDate = auditDate.substring(0,
								auditDate.lastIndexOf("."));
					}
					vo.setAnswerAcrTime(auditDate);
				}
				if (null != map.get("bcrTime".toUpperCase())) {//问题时间
					String questionAcrTime = map.get("bcrTime").toString();
					if (questionAcrTime.lastIndexOf(".") > -1) {
						questionAcrTime = questionAcrTime.substring(0,
								questionAcrTime.lastIndexOf("."));
					}
					vo.setQuestionAcrTime(questionAcrTime);;
				}
				if (null != map.get("acontent".toUpperCase())) {//回答内容
					vo.setAnswerContent(map.get("acontent").toString());
				}
				if (null != map.get("bcontent".toUpperCase())) {//问题内容
					vo.setQuestioncontent(map.get("bcontent").toString());
				}
				if (null != map.get("answerNum".toUpperCase())) {//问题回答数
					vo.setAnswerNum(map.get("answerNum").toString());
				}
				if (null != map.get("num".toUpperCase())) {//问题浏览数
					vo.setNum(map.get("num").toString());
				}
				if (null != map.get("diseaseName".toUpperCase())) {//问题浏览数
					vo.setDiseaseName(map.get("diseaseName").toString());
				}
				if (null != map.get("diseaseId".toUpperCase())) {//问题浏览数
					Long diseaseId = Long.parseLong(map.get("diseaseId").toString());
					vo.setDiseaseId(diseaseId);
				}
				
				listVo.add(vo);
			}
		}catch(Exception e){
			log.error("queryAnswerByQueionId 查询用户的问题和回答 失败：userId="+userId,e);
		}
		page.setItems(listVo);
		page.setTotalCount(count);
		return page;
	}

	@Override
	public List<Question> queryTodayAnswerdQuestion() {
		StringBuffer hql = new StringBuffer();
		hql.append("from Question where 1=1");
		hql.append(" and answerNum>0 ");
		List<Question> question = questionDao.find(hql.toString());
		return question;
	}
}
