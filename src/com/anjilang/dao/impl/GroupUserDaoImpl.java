package com.anjilang.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import com.anjilang.dao.GroupUserDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.GroupIdAndUserid;
import com.anjilang.entity.GroupUser;

/**
 * @author JYM 2015-7-20 下午2:21:41
 */
@SuppressWarnings("unchecked")
@Repository
public class GroupUserDaoImpl extends
		GenericHibernateDao<GroupUser, GroupIdAndUserid> implements
		GroupUserDao {

	// wzq
	public void mysave(GroupUser entity) {

		Session session = getSession();
		session.beginTransaction();
		session.save(entity);
		session.getTransaction().commit();
	}

	// jym
	public GroupUser myget(GroupIdAndUserid groupIdAndUserid) {
		Session session = getSession();
		return (GroupUser) session.get(GroupUser.class, groupIdAndUserid);

	}

	// jym
	public void myupdate(GroupUser entity) {
		Session session = getSession();
		session.beginTransaction();

		session.update(entity);
		session.getTransaction().commit();

	}

	// jym
	public List<GroupUser> myfind(String queryString) {
		Session session = getSession();
		return session.createQuery(queryString).list();

	}

	// jym
	public void mysaveOrUpdate(GroupUser entity) {
		Session session = getSession();
		session.beginTransaction();

		session.saveOrUpdate(entity);
		session.getTransaction().commit();
	}

	@Override
	public PaginationSupport<Long> myqueryPage(GroupIdAndUserid id,
			int pageSize, int pageNo) {

		List<Long> userids = new ArrayList<Long>();
		PaginationSupport<Long> paginationSupport=null;
		try {
			Connection connection = getSession().connection();
			String sql = "select * from t_group_user where groupid=? and ismember=1 limit  ?,?";

			PreparedStatement st = connection.prepareStatement(sql);
			st.setLong(1, id.getGroupid());

			st.setInt(2, (pageNo - 1) * pageSize);
			st.setInt(3, pageSize);

			ResultSet resultSet = st.executeQuery();

			while (resultSet.next()) {
                userids.add(resultSet.getLong("userid"));
			}

			int totalCount = getTotal(id.getGroupid());

			 paginationSupport = new PaginationSupport<Long>(
					userids, totalCount, pageSize);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return paginationSupport;
	}

	/**
	 * @return
	 */
	private int getTotal(long groupid) {

		try {
			Connection connection = getSession().connection();
			String sql = "select * from t_group_user where groupid=? and ismember=1";

			PreparedStatement st = connection.prepareStatement(sql);
			st.setLong(1, groupid);
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
