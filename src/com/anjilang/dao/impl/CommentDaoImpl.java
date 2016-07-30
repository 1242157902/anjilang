package com.anjilang.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;


import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.LockMode;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Repository;

import com.anjilang.dao.CommentDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.Comment;
import com.anjilang.service.CommentService;
import com.anjilang.service.impl.CommentServiceImpl;

@Repository
public class CommentDaoImpl extends GenericHibernateDao<Comment,Long> implements CommentDao {

	@Override
	public PaginationSupport<Comment> queryCommentByInforId(long id,
			Integer pageSize, Integer pageNo) {
		PaginationSupport<Comment> paginationSupport=null;
		List<Comment> list=new ArrayList<Comment>();
		Comment com=null;
		try {
			Connection connection = getSession().connection();
			String sql = "select * from t_comment where inforId=? limit  ?,?";

			PreparedStatement st = connection.prepareStatement(sql);
			st.setLong(1, id);

			st.setInt(2, (pageNo - 1) * pageSize);
			st.setInt(3, pageSize);

			ResultSet resultSet = st.executeQuery();

			while (resultSet.next()) {
				com=new Comment();
				com.setContent(resultSet.getString("content"));
				com.setCrTime(resultSet.getDate("crTime"));
				com.setNickname(resultSet.getString("nickname"));
				com.setPic(resultSet.getString("pic"));
				list.add(com);
			}
			int totalCount=getTotal(id);
			paginationSupport = new PaginationSupport(list, totalCount, pageSize);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return paginationSupport;
	}
	/**
	 * @return
	 */
	private int getTotal(long id) {
		try {
			Connection connection = getSession().connection();
			String sql = "select * from t_comment where inforId=?";

			PreparedStatement st = connection.prepareStatement(sql);
			st.setLong(1, id);
			ResultSet resultSet = st.executeQuery();

			int count = 0;
			while (resultSet.next()) {

				count = count + 1;

			}
			return count;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	
	}


}
