
package com.anjilang.dao.base;

import java.io.Serializable;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.LockMode;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;

import com.anjilang.dao.base.impl.PaginationSupport;

/** 
 * @ClassName: GenericDao 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author liuwei
 * @date 2014-6-18 下午2:21:49 
 *  
 */
public interface GenericDao<T extends Serializable, PK extends Serializable> {
	// -------------------- 基本检索、增加、修改、删除操作 --------------------

	/**
	 *  根据主键获取实体。如果没有相应的实体，返回 null。
	 * @param id
	 * @return
	 */
	public T get(PK id);
	
	/**
	 *  根据主键获取实体。如果没有相应的实体，返回 null。
	 * @param id
	 * @return
	 */
	 
	

	/**
	 *  根据主键获取实体并加锁。如果没有相应的实体，返回 null。
	 * @param id
	 * @param lock
	 * @return
	 */
	public T getWithLock(PK id, LockMode lock);

	/**
	 *  根据主键获取实体。如果没有相应的实体，抛出异常。
	 * @param id
	 * @return
	 */
	public T load(PK id);

	/**
	 *  根据主键获取实体并加锁。如果没有相应的实体，抛出异常。
	 * @param id
	 * @param lock
	 * @return
	 */
	public T loadWithLock(PK id, LockMode lock);

	/**
	 *  获取全部实体。
	 * @return
	 */
	public List<T> loadAll();

	/**
	 *  更新实体
	 * @param entity
	 */
	public void update(T entity);

	/**
	 *  更新实体并加锁
	 * @param entity
	 * @param lock
	 */
	public void updateWithLock(T entity, LockMode lock);

	/**
	 *  存储实体到数据库
	 * @param entity
	 */
	public void save(T entity);
	public void mysave(T entity);
	public T myget(PK id);
	public void myupdate(T entity);
	public List<T>  myfind(String queryString);
	public void mysaveOrUpdate(T entity);
	/**
	 *  增加或更新实体
	 * @param entity
	 */
	public void saveOrUpdate(T entity);

	/**
	 *  增加或更新集合中的全部实体
	 * @param entities
	 */
	public void saveOrUpdateAll(Collection<T> entities);

	/**
	 *  删除指定的实体
	 * @param entity
	 */
	public void delete(T entity);

	/**
	 *  加锁并删除指定的实体
	 * @param entity
	 * @param lock
	 */
	public void deleteWithLock(T entity, LockMode lock);

	/**
	 *  根据主键删除指定实体
	 * @param id
	 */
	public void deleteByKey(PK id);

	/**
	 *  根据主键加锁并删除指定的实体
	 * @param id
	 * @param lock
	 */
	public void deleteByKeyWithLock(PK id, LockMode lock);

	/**
	 *  删除集合中的全部实体
	 * @param entities
	 */
	public void deleteAll(Collection<T> entities);

	// -------------------- HSQL ----------------------------------------------

	/**
	 *  使用HSQL语句直接增加、更新、删除实体
	 * @param queryString
	 * @return
	 */
	public int bulkUpdate(String queryString);

	/**
	 *  使用带参数的HSQL语句增加、更新、删除实体
	 * @param queryString
	 * @param values
	 * @return
	 */
	public int bulkUpdate(String queryString, Object[] values);

	/**
	 *  使用HSQL语句检索数据
	 * @param queryString
	 * @return
	 */
	public List<T> find(String queryString);

	/**
	 *  使用带参数的HSQL语句检索数据
	 * @param queryString
	 * @param values
	 * @return
	 */
	public List find(String queryString, Object[] values);

	/**
	 *  使用带命名的参数的HSQL语句检索数据
	 * @param queryString
	 * @param paramNames
	 * @param values
	 * @return
	 */
	public List<T> findByNamedParam(String queryString, String[] paramNames, Object[] values);

	/**
	 *  使用命名的HSQL语句检索数据
	 * @param queryName
	 * @return
	 */
	public List<T> findByNamedQuery(String queryName);

	/**
	 *  使用带参数的命名HSQL语句检索数据
	 * @param queryName
	 * @param values
	 * @return
	 */
	public List<T> findByNamedQuery(String queryName, Object[] values);

	/**
	 *  使用带命名参数的命名HSQL语句检索数据
	 * @param queryName
	 * @param paramNames
	 * @param values
	 * @return
	 */
	public List<T> findByNamedQueryAndNamedParam(String queryName, String[] paramNames, Object[] values);

	/**
	 *  使用HSQL语句检索数据，返回 Iterator
	 * @param queryString
	 * @return
	 */
	public Iterator<T> iterate(String queryString);

	/**
	 *  使用带参数HSQL语句检索数据，返回 Iterator
	 * @param queryString
	 * @param values
	 * @return
	 */
	public Iterator<T> iterate(String queryString, Object[] values);

	/**
	 *  关闭检索返回的 Iterator
	 * @param it
	 */
	public void closeIterator(Iterator<T> it);

	// -------------------------------- Criteria ------------------------------

	/**
	 *  创建与会话无关的检索标准对象
	 * @return
	 */
	public DetachedCriteria createDetachedCriteria();

	/**
	 *  创建与会话绑定的检索标准对象
	 * @return
	 */
	public Criteria createCriteria();

	/**
	 *  使用指定的检索标准检索数据
	 * @param criteria
	 * @return
	 */
	public List<T> findByCriteria(DetachedCriteria criteria);

	/**
	 *  使用指定的检索标准检索数据，返回部分记录
	 * @param criteria
	 * @param firstResult
	 * @param maxResults
	 * @return
	 */
	public List<T> findByCriteria(DetachedCriteria criteria, int firstResult, int maxResults);

	/**
	 *  使用指定的实体及属性检索（满足除主键外属性＝实体值）数据
	 * @param entity
	 * @param propertyNames
	 * @return
	 */
	public List<T> findEqualByEntity(T entity, String[] propertyNames);

	/**
	 *  使用指定的实体及属性(非主键)检索（满足属性 like 串实体值）数据
	 * @param entity
	 * @param propertyNames
	 * @return
	 */
	public List<T> findLikeByEntity(T entity, String[] propertyNames);


	/**
	 *  使用指定的检索标准检索数据，返回指定统计值
	 * @param criteria
	 * @param propertyName
	 * @param StatName
	 * @return
	 */
	public Object getStatValue(DetachedCriteria criteria, String propertyName, String StatName);

	// -------------------------------- Others --------------------------------

	/**
	 *  加锁指定的实体
	 * @param entity
	 * @param lockMode
	 */
	public void lock(T entity, LockMode lockMode);

	/**
	 *  强制初始化指定的实体
	 * @param proxy
	 */
	public void initialize(Object proxy);

	/**
	 *  强制立即更新缓冲数据到数据库（否则仅在事务提交时才更新）
	 */
	public void flush();
	
	/**
	 * 获取SEQUENCE的下一个值 (oracle)
	 * @param seq_name
	 * @return
	 */
	public Long getNextValueFromSEQ(final String seq_name);
	
	/** 
	 * 万能列表查询.
	 * <p>根据Criterion、Order、Projection构造查询条件，根据ResultTransformer封装查询结果</p>
	 * <ul>
	 * <li>Criterion：支持<b>where</b>，创建如Restrictions.eq(?,?)、Example.create(?)</li>
	 * <li>Order：支持<b>order by</b>，创建如Order.desc(?)</li>
	 * <li>Projection：支持<b>group by</b>、<b>统计</b>、<b>去重复</b>，创建如Projections.count(?)</li>
	 * <li>ResultTransformer：支持<b>定义结果封装类型</b>，创建如Transformers.TO_LIST</li>
	 * </ul>
	 */
	public <T> List<T> findByAny(Class<?> clazz, Object... any);
	
	public <T> List<T> findByAny(Class<?> clazz, int firstResult, int maxResults, Object... any);
	
	/** 
	 * 万能统计.
	 * <p>根据Criterion构造查询条件；支持<b>where</b>，不支持group by；创建如Restrictions.eq(?,?)、Example.create(?)</p>
	 */
	public Long countByAny(Class<?> clazz, Criterion... criterions);
	
	/**
	 * 分页查询接口
	 * 
	 * @param params-key-value
	 * @param order-参与排序的字段 DESC排序
	 * @param pageSize
	 * @param pageNo
	 * @return
	 */
	public PaginationSupport<T> queryPage(Map<String, Object> params, String[] order, int pageSize, int pageNo);
	
	/**
	 * 分页查询接口
	 * 
	 * @param params-可选
	 * @param paramsLikes-%a%全模糊匹配查询-可选
	 * @param order-可选
	 * @param pageSize
	 * @param pageNo
	 * @return
	 */
	public PaginationSupport<T> queryPage(Map<String, Object> params, Map<String, Object> paramsLikes, String[] order, int pageSize, int pageNo);
	
	/**
	 * 分页查询接口
	 * 
	 * @param params-可选
	 * @param paramsNotEqs-不等于-可选 
	 * @param paramsLikes-%a%全模糊匹配查询-可选
	 * @param order-可选
	 * @param pageSize
	 * @param pageNo
	 * @param isDesc-true表示所有字段都按降序,否则所有排序字段都安装升序
	 * @return
	 */
	public PaginationSupport<T> queryPage(Map<String, Object> params, Map<String, Object> paramsNotEqs, Map<String, Object> paramsLikes, String[] order, int pageSize, int pageNo, boolean isDesc);
}
