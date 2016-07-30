package com.anjilang.dao;

import java.util.Map;

import com.anjilang.dao.base.GenericDao;
import com.anjilang.entity.ArticleInfo;
import com.anjilang.util.AjlException;

public interface ArticleInfoDao extends GenericDao<ArticleInfo, Long>  {

	public Long queryCount(Map<String, String> maps) throws AjlException;
}
