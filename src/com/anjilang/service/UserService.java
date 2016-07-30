package com.anjilang.service;
/**
 * @author xym
 */
import java.util.List;

import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.User;
import com.anjilang.util.AjlException;

public interface UserService {

	public void save(User user) throws AjlException;

	public List<User> queryUserByUserName(String userName)
			throws AjlException;
	public List<User> queryUserByPhone(String phone)
			throws AjlException;

	public User queryUserById(Long id) throws AjlException;
	


	public void update(User user)throws AjlException;
	
	/**
	 * 
	 * @param audit 1-未审核2-已审核 null-缺省改查询条件
	 * @param type 1-医生2-普通用户
	 * @return AjlException
	 */
	public List<User> queryUserByAudit(String audit, String type) throws AjlException;
	
	/**
	 * 
	 * @param audit 1-未审核2-已审核 null-缺省改查询条件
	 * @param type 1-医生2-普通用户
	 * @param pageSize 默认最小5
	 * @param pageNo 默认最小1
	 * @param provinceId省份id
	 * @param projectId疾病项目id
	 * @return PaginationSupport<User>
	 */
	public PaginationSupport<User> queryUserByAudit(String audit, String type, int pageSize,
			int pageNo, Long provinceId, Long projectId);
	
	/**
	 * 获取当前用户回答总次数
	 * @param userId
	 * @return
	 */
	public int getTotelAnswerNum(long userId);
	
	/**
	 * 获取当前用户所有回答被赞次数
	 * @param userId
	 * @return
	 */
	public int getTotelAgreeNum(long userId);
	
	
	/**
	 * 获取最多回答问题的用户
	 * @return
	 */
	public PaginationSupport<User> queryTopAnswerUser(int pageSize,int pageNo);
	
	/**
	 * 根据ID删除用户
	 * @param ids
	 */
	public void delete(String[] ids);
	
	/**
	 * 通过QQid查询
	 * @param qqId
	 */
	public User queryByQQId(String qqId);
	
	/**
	 * @param 通过微博用户ID查询
	 * @return
	 */
	public User queryByWeiBoUid(String uid);
}
