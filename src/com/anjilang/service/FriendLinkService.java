/**  
 * @Title: FriendLinkService.java
 * @Package com.anjilang.service
 * @Description: TODO
 * @author linqingsong
 * @date 2015年2月5日
 */
package com.anjilang.service;

import java.util.List;

import com.anjilang.entity.FriendLink;

/**
 * ClassName: FriendLinkService 
 * @Description: TODO
 * @author linqingsong
 * @date 2015年2月5日
 */
public interface FriendLinkService {
	/**
	 * 保存友情链接
	 * @param friendLink
	 */
	public void save(FriendLink friendLink);
	
	/**
	 * 查询
	 * @return
	 */
	public List<FriendLink> query();
	
	/**
	 * 修改
	 * @param friendLink
	 */
	public void modify(FriendLink friendLink);
	
	/**
	 * 删除
	 * @param friendLink
	 */
	public void delete(FriendLink friendLink);
	
	/**
	 * 通过ID查询
	 * @param id
	 * @return
	 */
	public FriendLink findById(Long id);
}
