package com.anjilang.dao.base.impl;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.math.BigInteger;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.apache.commons.beanutils.PropertyUtils;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.LockMode;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.ResultTransformer;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.anjilang.dao.base.GenericDao;

public class GenericHibernateDao<T extends Serializable, PK extends Serializable>
		extends HibernateDaoSupport implements GenericDao<T, PK> {
	@Resource
	public void setSessionFactoryOverride(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}

	// 实体类类型(由构造方法自动赋值)
	private Class<T> entityClass;

	// 构造方法，根据实例类自动获取实体类类型
	public GenericHibernateDao() {
		this.entityClass = null;
		Class c = getClass();
		Type t = c.getGenericSuperclass();
		if (t instanceof ParameterizedType) {
			Type[] p = ((ParameterizedType) t).getActualTypeArguments();
			this.entityClass = (Class<T>) p[0];
		}
	}

	// -------------------- 基本检索、增加、修改、删除操作 --------------------

	// 根据主键获取实体。如果没有相应的实体，返回 null。
	public T get(PK id) {
		return (T) getHibernateTemplate().get(entityClass, id);
	}

	// 根据主键获取实体并加锁。如果没有相应的实体，返回 null。
	public T getWithLock(PK id, LockMode lock) {
		T t = (T) getHibernateTemplate().get(entityClass, id, lock);
		if (t != null) {
			this.flush(); // 立即刷新，否则锁不会生效。
		}
		return t;
	}

	// 根据主键获取实体。如果没有相应的实体，抛出异常。
	public T load(PK id) {
		return (T) getHibernateTemplate().load(entityClass, id);
	}

	// 根据主键获取实体并加锁。如果没有相应的实体，抛出异常。
	public T loadWithLock(PK id, LockMode lock) {
		T t = (T) getHibernateTemplate().load(entityClass, id, lock);

		if (t != null) {
			this.flush(); // 立即刷新，否则锁不会生效。
		}
		return t;
	}

	// 获取全部实体。
	public List<T> loadAll() {
		return (List<T>) getHibernateTemplate().loadAll(entityClass);
	}

	// loadAllWithLock() ?

	// 更新实体
	public void update(T entity) {
		getHibernateTemplate().update(entity);
	}

	// 更新实体并加锁
	public void updateWithLock(T entity, LockMode lock) {
		getHibernateTemplate().update(entity, lock);
		this.flush(); // 立即刷新，否则锁不会生效。
	}

	// 存储实体到数据库
	public void save(T entity) {
		
		Session session=getSession();
		
		session.save(entity);
		session.flush();
		
	}

	// saveWithLock()？

	// 增加或更新实体
	public void saveOrUpdate(T entity) {
		getHibernateTemplate().saveOrUpdate(entity);
	}

	// 增加或更新集合中的全部实体
	public void saveOrUpdateAll(Collection<T> entities) {
		getHibernateTemplate().saveOrUpdateAll(entities);
	}

	// 删除指定的实体
	public void delete(T entity) {
		getHibernateTemplate().delete(entity);
	}

	// 加锁并删除指定的实体
	public void deleteWithLock(T entity, LockMode lock) {
		getHibernateTemplate().delete(entity, lock);
		this.flush(); // 立即刷新，否则锁不会生效。
	}

	// 根据主键删除指定实体
	public void deleteByKey(PK id) {
		this.delete(this.load(id));
	}

	// 根据主键加锁并删除指定的实体
	public void deleteByKeyWithLock(PK id, LockMode lock) {
		this.deleteWithLock(this.load(id), lock);
	}

	// 删除集合中的全部实体
	public void deleteAll(Collection<T> entities) {
		getHibernateTemplate().deleteAll(entities);
	}

	// -------------------- HSQL ----------------------------------------------

	// 使用HSQL语句直接增加、更新、删除实体
	public int bulkUpdate(String queryString) {
		return getHibernateTemplate().bulkUpdate(queryString);
	}

	// 使用带参数的HSQL语句增加、更新、删除实体
	public int bulkUpdate(String queryString, Object[] values) {
		return getHibernateTemplate().bulkUpdate(queryString, values);
	}

	// 使用HSQL语句检索数据
	public List find(String queryString) {
		return getHibernateTemplate().find(queryString);
	}

	// 使用带参数的HSQL语句检索数据
	public List find(String queryString, Object[] values) {
		return getHibernateTemplate().find(queryString, values);
	}

	// 使用带命名的参数的HSQL语句检索数据
	public List findByNamedParam(String queryString, String[] paramNames,
			Object[] values) {
		return getHibernateTemplate().findByNamedParam(queryString, paramNames,
				values);
	}

	// 使用命名的HSQL语句检索数据
	public List findByNamedQuery(String queryName) {
		return getHibernateTemplate().findByNamedQuery(queryName);
	}

	// 使用带参数的命名HSQL语句检索数据
	public List findByNamedQuery(String queryName, Object[] values) {
		return getHibernateTemplate().findByNamedQuery(queryName, values);
	}

	// 使用带命名参数的命名HSQL语句检索数据
	public List findByNamedQueryAndNamedParam(String queryName,
			String[] paramNames, Object[] values) {
		return getHibernateTemplate().findByNamedQueryAndNamedParam(queryName,
				paramNames, values);
	}

	// 使用HSQL语句检索数据，返回 Iterator
	public Iterator iterate(String queryString) {
		return getHibernateTemplate().iterate(queryString);
	}

	// 使用带参数HSQL语句检索数据，返回 Iterator
	public Iterator iterate(String queryString, Object[] values) {
		return getHibernateTemplate().iterate(queryString, values);
	}

	// 关闭检索返回的 Iterator
	public void closeIterator(Iterator it) {
		getHibernateTemplate().closeIterator(it);
	}

	// -------------------------------- Criteria ------------------------------

	// 创建与会话无关的检索标准
	public DetachedCriteria createDetachedCriteria() {
		return DetachedCriteria.forClass(this.entityClass);
	}

	// 创建与会话绑定的检索标准
	public Criteria createCriteria() {
		return this.createDetachedCriteria().getExecutableCriteria(
				this.getSession());
	}

	// 检索满足标准的数据
	public List findByCriteria(DetachedCriteria criteria) {
		return getHibernateTemplate().findByCriteria(criteria);
	}

	// 检索满足标准的数据，返回指定范围的记录
	public List findByCriteria(DetachedCriteria criteria, int firstResult,
			int maxResults) {
		return getHibernateTemplate().findByCriteria(criteria, firstResult,
				maxResults);
	}

	// 使用指定的实体及属性检索（满足除主键外属性＝实体值）数据
	public List<T> findEqualByEntity(T entity, String[] propertyNames) {
		Criteria criteria = this.createCriteria();
		Example exam = Example.create(entity);
		exam.excludeZeroes();
		String[] defPropertys = getSessionFactory().getClassMetadata(
				entityClass).getPropertyNames();
		for (String defProperty : defPropertys) {
			int ii = 0;
			for (ii = 0; ii < propertyNames.length; ++ii) {
				if (defProperty.equals(propertyNames[ii])) {
					criteria.addOrder(Order.asc(defProperty));
					break;
				}
			}
			if (ii == propertyNames.length) {
				exam.excludeProperty(defProperty);
			}
		}
		criteria.add(exam);
		return (List<T>) criteria.list();
	}

	// 使用指定的实体及属性检索（满足属性 like 串实体值）数据
	public List<T> findLikeByEntity(T entity, String[] propertyNames) {
		Criteria criteria = this.createCriteria();
		for (String property : propertyNames) {
			try {
				Object value = PropertyUtils.getProperty(entity, property);
				if (value instanceof String) {
					criteria.add(Restrictions.like(property, (String) value,
							MatchMode.ANYWHERE));
					criteria.addOrder(Order.asc(property));
				} else {
					criteria.add(Restrictions.eq(property, value));
					criteria.addOrder(Order.asc(property));
				}
			} catch (Exception ex) {
				// 忽略无效的检索参考数据。
			}
		}
		return (List<T>) criteria.list();
	}

	// 使用指定的检索标准获取满足标准的记录数
	private Long getRowCount(DetachedCriteria criteria) {
		criteria.setProjection(Projections.rowCount());
		List list = findByCriteria(criteria);
		return (Long) list.get(0);
	}

	// 使用指定的检索标准检索数据，返回指定统计值(max,min,avg,sum)
	public Object getStatValue(DetachedCriteria criteria, String propertyName,
			String StatName) {
		if (StatName.toLowerCase().equals("max"))
			criteria.setProjection(Projections.max(propertyName));
		else if (StatName.toLowerCase().equals("min"))
			criteria.setProjection(Projections.min(propertyName));
		else if (StatName.toLowerCase().equals("avg"))
			criteria.setProjection(Projections.avg(propertyName));
		else if (StatName.toLowerCase().equals("sum"))
			criteria.setProjection(Projections.sum(propertyName));
		else
			return null;
		List list = this.findByCriteria(criteria, 0, 1);
		return list.get(0);
	}

	// -------------------------------- Others --------------------------------

	// 加锁指定的实体
	public void lock(T entity, LockMode lock) {
		getHibernateTemplate().lock(entity, lock);
	}

	// 强制初始化指定的实体
	public void initialize(Object proxy) {
		getHibernateTemplate().initialize(proxy);
	}

	// 强制立即更新缓冲数据到数据库（否则仅在事务提交时才更新）
	public void flush() {
		getHibernateTemplate().flush();
	}

	// 获取SEQUENCE的下一个值 (oracle)
	public Long getNextValueFromSEQ(final String seq_name) {
		Long nextValue = this.getHibernateTemplate().execute(
				new HibernateCallback<Long>() {
					public Long doInHibernate(Session session)
							throws HibernateException, SQLException {
						// SQLQuery query = session.createSQLQuery("select " +
						// seq_name + ".NEXTVAL from dual");
						// 修改为mysql实现
						SQLQuery query = session
								.createSQLQuery("select next_val(?)");
						query.setString(0, seq_name);
						List<?> list = query.list();
						return ((BigInteger) list.get(0)).longValue();
					}
				});
		return nextValue;
	}

	/**
	 * 构建查询相等条件
	 * 
	 * @param hql
	 * @param values
	 * @param params
	 */
	private void eqs(StringBuffer hql, List<Object> values,
			Map<String, Object> params) {
		if (params != null) {
			int k = 0;
			final String AND = " AND ";
			final String EQ = " = ";
			final String QUESTION_MARK = " ? ";

			for (Entry<String, Object> entry : params.entrySet()) {
				String key = entry.getKey();
				Object val = entry.getValue();
				if (val != null) {
					hql.append((((k == 0)) ? (" T WHERE ") : (AND)));
					hql.append(" T.");
					hql.append(key);
					hql.append(EQ);
					hql.append(QUESTION_MARK);

					values.add(val);
					k++;
				}
			}
		}
	}

	private void eqs(DetachedCriteria criteria, Map<String, Object> params) {
		if (criteria == null) {
			return;
		}
		if (params != null) {
			for (Entry<String, Object> entry : params.entrySet()) {
				String key = entry.getKey();
				Object val = entry.getValue();

				if (val != null) {
					criteria.add(Restrictions.eq(key, val));
				}
			}
		}
	}

	private void likes(DetachedCriteria criteria, Map<String, Object> paramsLike) {
		if (criteria == null) {
			return;
		}
		if (paramsLike != null) {
			for (Entry<String, Object> entry : paramsLike.entrySet()) {
				String key = entry.getKey();
				Object val = entry.getValue();

				if (val != null) {
					criteria.add(Restrictions.like(key, val));
				}
			}
		}
	}

	private void notEqs(DetachedCriteria criteria,
			Map<String, Object> paramsNotEqs) {
		if (criteria == null) {
			return;
		}
		if (paramsNotEqs != null) {
			for (Entry<String, Object> entry : paramsNotEqs.entrySet()) {
				String key = entry.getKey();
				Object val = entry.getValue();

				if (val != null) {
					criteria.add(Restrictions.ne(key, val));
				}
			}
		}
	}

	private void orderDesc(DetachedCriteria criteria, String[] order) {
		if (criteria == null) {
			return;
		}
		if (order != null) {
			for (String o : order) {
				criteria.addOrder(Order.desc(o));
				
			}
		}
	}

	private void orderDesc(DetachedCriteria criteria, String[] order,
			boolean isDesc) {
		if (criteria == null) {
			return;
		}
		if (order != null) {
			for (String o : order) {
				if (isDesc) {
					criteria.addOrder(Order.desc(o));
				} else {
					criteria.addOrder(Order.asc(o));
				}

			}
		}
	}

	/**
	 * 查询
	 * 
	 * @param clazz
	 *            - 查询实体class
	 * @param params
	 *            - 查询条件
	 * @return
	 */
	public List<?> queryEQ(Map<String, Object> params) {
		// entityClass
		StringBuffer hql = new StringBuffer(" FROM "
				+ entityClass.getSimpleName() + " ");
		List<Object> values = new ArrayList<Object>();

		eqs(hql, values, params);
		return find(hql.toString(), values.toArray());
	}

	/**
	 * 查询
	 * 
	 * @param clazz
	 *            - 查询实体class
	 * @param params
	 *            - 查询条件
	 * @return
	 */
	public List<?> queryEQ(Map<String, Object> params, String[] order) {
		// entityClass
		StringBuffer hql = new StringBuffer(" FROM "
				+ entityClass.getSimpleName() + " ");
		List<Object> values = new ArrayList<Object>();

		// eqs(hql, values, params);
		// return find(hql.toString(), values.toArray());

		DetachedCriteria criteriaQuery = createDetachedCriteria();
		eqs(criteriaQuery, params);
		orderDesc(criteriaQuery, order);
		@SuppressWarnings("unchecked")
		List<T> list = findByCriteria(criteriaQuery);

		return list;
	}

	/**
	 * 分页查询接口
	 * 
	 * @param params
	 * @param order
	 * @param pageSize
	 * @param pageNo
	 * @return
	 */
	public PaginationSupport<T> queryPage(Map<String, Object> params,
			String[] order, int pageSize, int pageNo) {
		DetachedCriteria criteriaCount = createDetachedCriteria();
		eqs(criteriaCount, params);
		Long totalCount = getRowCount(criteriaCount);

		DetachedCriteria criteriaQuery = createDetachedCriteria();
		eqs(criteriaQuery, params);
		orderDesc(criteriaQuery, order);
		

		int startIndex = (pageNo - 1) * pageSize;
		@SuppressWarnings("unchecked")
		List<T> list = findByCriteria(criteriaQuery, startIndex, pageSize);

		PaginationSupport<T> page = new PaginationSupport<T>(list, totalCount,
				pageSize);
		return page;
	}

	/**
	 * 分页查询接口
	 * 
	 * @param params
	 *            -可选
	 * @param paramsLikes
	 *            -%a%全模糊匹配查询-可选
	 * @param order
	 *            -可选
	 * @param pageSize
	 * @param pageNo
	 * @return
	 */
	public PaginationSupport<T> queryPage(Map<String, Object> params,
			Map<String, Object> paramsLikes, String[] order, int pageSize,
			int pageNo) {
		DetachedCriteria criteriaCount = createDetachedCriteria();
		eqs(criteriaCount, params);
		likes(criteriaCount, paramsLikes);
		Long totalCount = getRowCount(criteriaCount);

		DetachedCriteria criteriaQuery = createDetachedCriteria();
		eqs(criteriaQuery, params);
		likes(criteriaQuery, paramsLikes);
		orderDesc(criteriaQuery, order);

		int startIndex = (pageNo - 1) * pageSize;
		@SuppressWarnings("unchecked")
		List<T> list = findByCriteria(criteriaQuery, startIndex, pageSize);

		PaginationSupport<T> page = new PaginationSupport<T>(list, totalCount,
				pageSize);
		return page;
	}

	/**
	 * 分页查询接口
	 * 
	 * @param params
	 *            -可选
	 * @param paramsNotEqs
	 *            -不等于-可选
	 * @param paramsLikes
	 *            -%a%全模糊匹配查询-可选
	 * @param order
	 *            -可选
	 * @param pageSize
	 * @param pageNo
	 * @param isDesc
	 *            -true表示所有字段都按降序,否则所有排序字段都安装升序
	 * @return
	 */
	public PaginationSupport<T> queryPage(Map<String, Object> params,
			Map<String, Object> paramsNotEqs, Map<String, Object> paramsLikes,
			String[] order, int pageSize, int pageNo, boolean isDesc) {
		DetachedCriteria criteriaCount = createDetachedCriteria();
		eqs(criteriaCount, params);
		likes(criteriaCount, paramsLikes);
		notEqs(criteriaCount, paramsNotEqs);
		Long totalCount = getRowCount(criteriaCount);

		DetachedCriteria criteriaQuery = createDetachedCriteria();
		eqs(criteriaQuery, params);
		likes(criteriaQuery, paramsLikes);
		notEqs(criteriaQuery, paramsNotEqs);
		orderDesc(criteriaQuery, order, isDesc);

		int startIndex = (pageNo - 1) * pageSize;
		@SuppressWarnings("unchecked")
		List<T> list = findByCriteria(criteriaQuery, startIndex, pageSize);

		PaginationSupport<T> page = new PaginationSupport<T>(list, totalCount,
				pageSize);
		return page;
	}

	public <T> List<T> findByAny(Class<?> clazz, int firstResult,
			int maxResults, Object... any) {
		DetachedCriteria criteria = getDetachedCriteria(clazz, any);
		return findByCriteria(criteria, firstResult, maxResults);
	}

	/**
	 * 万能列表分页查询
	 */
	@Override
	public <T> List<T> findByAny(Class<?> clazz, Object... any) {
		DetachedCriteria criteria = getDetachedCriteria(clazz, any);
		return findByCriteria(criteria);
	}

	/* ***************内部调用***************** */
	private DetachedCriteria getDetachedCriteria(Class<?> clazz, Object... any) {
		DetachedCriteria criteria = DetachedCriteria.forClass(clazz);
		ProjectionList projList = null;
		ResultTransformer rt = null;
		for (Object obj : any) {
			if (obj instanceof Criterion) {
				criteria.add((Criterion) obj);
			} else if (obj instanceof Order) {
				criteria.addOrder((Order) obj);
			} else if (obj instanceof Projection) {
				if (projList == null)
					projList = Projections.projectionList();
				projList.add((Projection) obj);
			} else if (obj instanceof ResultTransformer) {
				rt = (ResultTransformer) obj;
			} else {
				// 查询条件类型未知，不处理
			}
		}
		if (projList != null)
			criteria.setProjection(projList);
		if (rt != null)
			criteria.setResultTransformer(rt); // 必须放在criteria.setProjection后，否则无效
		return criteria;
	}

	/**
	 * 万能统计
	 */
	@Override
	public Long countByAny(Class<?> clazz, Criterion... criterions) {
		DetachedCriteria criteria = DetachedCriteria.forClass(clazz);
		for (Criterion criterion : criterions) {
			criteria.add(criterion);
		}
		return countByCriteria(criteria);
	}

	/**
	 * Criteria统计.
	 * <ul>
	 * <li>不支持group by（因为setProjection只能调一次）</li>
	 * <li>不限于某个实体，可查询任何对象</li>
	 * </ul>
	 */
	public Long countByCriteria(DetachedCriteria dc) {
		// dc.setProjection(Projections.rowCount());
		dc.setProjection(Projections.rowCount());
		Criteria c = dc.getExecutableCriteria(getSession());
		return (Long) c.uniqueResult();
	}

	// wzq
	@Override
	public void mysave(T entity) {
		Session session = getSession();
		session.beginTransaction();

		session.save(entity);
		session.getTransaction().commit();

	}
	//jym
	//// 根据主键获取实体。如果没有相应的实体，返回 null。
	public T myget(PK id) {
		Session session = getSession();
		return (T) session.get(entityClass, id);
	}

	//jym
	@Override
	public void myupdate(T entity) {
		Session session = getSession();
		session.beginTransaction();

		session.update(entity);
		session.getTransaction().commit();
		
	}

	//jym
	@SuppressWarnings("unchecked")
	@Override
	public List<T> myfind(String queryString) {
		Session session = getSession();
		return  session.createQuery(queryString).list();
		
	
	}

	//jym
	@Override
	public void mysaveOrUpdate(T entity) {
		Session session = getSession();
		session.beginTransaction();

		session.saveOrUpdate(entity);
		session.getTransaction().commit();
		
	}



	

}
