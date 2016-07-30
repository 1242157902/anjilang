package com.anjilang.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.anjilang.dao.ArticleInfoDao;
import com.anjilang.dao.UserDao;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.ArticleInfo;
import com.anjilang.entity.Information;
import com.anjilang.entity.Question;
import com.anjilang.service.ArticleInfoService;
import com.anjilang.util.AjlException;

/**
 * 文章业务
 * 
 * @author liudb
 * @see 1.0.0
 */
@Service
public class ArticleInfoServiceImpl implements ArticleInfoService {
	private Logger log = Logger.getLogger(this.getClass());
	@Autowired
	private ArticleInfoDao articleInfoDao;
	@Autowired
	private UserDao userDao;

	@Override
	public PaginationSupport<ArticleInfo> queryPage(Map<String, Object> params,
			String[] order, int pageSize, int pageNo) {
		return articleInfoDao.queryPage(params, order, pageSize, pageNo);
	}

	@Override
	public List<ArticleInfo> queryByHot() throws AjlException {
		String hql = "from ArticleInfo order by num";
		return articleInfoDao.find(hql);
	}

	@Override
	public List<ArticleInfo> queryArticleInfo(Long userId, String title,
			Integer pageNo, Integer pageSize) throws AjlException {
		String orders[] = { "id" };
		HashMap<String, Object> params = new HashMap<String, Object>();
		if (userId != null) {
			params.put("userId", userId/* userDao.get(new Long(userId)) */);
		}
		if (userId != null && !"".equals(title)) {
			params.put("title", title);
		}
		PaginationSupport<ArticleInfo> questions = articleInfoDao.queryPage(
				params, orders, pageSize, pageNo);
		return questions.getItems();
	}

	@Override
	public Long countArticleInfo(Long userId, String title) throws AjlException {
		// 查询结果
		List<Criterion> any = new ArrayList<Criterion>();

		if (userId != null) {
			any.add(Restrictions.eq("userId", userId));
		}
		if (title != null && !"".equals(title.toString())) {
			any.add(Restrictions.like("title",
					com.anjilang.util.StringUtil.join("%", title.trim(), "%")));
		}
		return articleInfoDao.countByAny(ArticleInfo.class,
				any.toArray(new Criterion[any.size()]));
	}

	@Override
	public Long countArticleInfo() throws AjlException {
		return articleInfoDao.countByAny(ArticleInfo.class, null);
	}

	@Override
	public void addArticleInfo(ArticleInfo articleInfo) throws AjlException {
		articleInfoDao.save(articleInfo);
	}

	@Override
	public void modifyArticleInfo(ArticleInfo articleInfo) throws AjlException {
		try {
			String hql = "update ArticleInfo set title=?,content=?,modifyDate=?,num=? where id=?";
			Object[] values = {articleInfo.getTitle(),articleInfo.getContent(),articleInfo.getCreateDate(),articleInfo.getNum(),articleInfo.getId()}; 
			int intUpdate = articleInfoDao.bulkUpdate(hql,values);
			if(intUpdate<1){
				log.error("修改文章失败，" + articleInfo.toString());
				throw AjlException.createErr("5005");
			}
		} catch (Exception e) {
			log.error("修改文章失败，" + articleInfo.toString(), e);
			throw AjlException.createErr("5005");
		}
	}

	@Override
	public void delectArticleInfo(Long id) throws AjlException {
		try {
			ArticleInfo entity = articleInfoDao.get(id);
			if (entity == null) {
				log.error("删除文章失败，要删除的文章id=" + id);
				throw AjlException.createErr("5005");
			}
			String hql = "delete from ArticleInfo where id=" + id;
			articleInfoDao.bulkUpdate(hql);
		} catch (AjlException e) {
			throw e;
		} catch (Exception e) {
			log.error("删除文章失败，id=" + id, e);
			throw AjlException.createErr("5005");
		}
	}

	@Override
	public ArticleInfo getById(Long id) throws AjlException {
		try {
			ArticleInfo entity = articleInfoDao.get(id);
			if (entity == null) {
				log.error("获取文章信息失败，文章id=" + id);
				throw AjlException.createErr("5005");
			}
			return entity;
		} catch (AjlException e) {
			throw e;
		} catch (Exception e) {
			log.error("删除文章失败，id=" + id, e);
			throw AjlException.createErr("5005");
		}
	}

	@Override
	public Long queryCount(Map<String, String> maps) throws AjlException {
		return articleInfoDao.queryCount(maps);
	}

}
