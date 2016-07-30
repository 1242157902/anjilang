package com.anjilang.service;

import com.anjilang.entity.RegistCode;
import com.anjilang.util.AjlException;

/**
 * 激活注册码服务
 * @author xym
 *
 */
public interface RegistCodeService {
	/**
	 * 保存注册Code
	 * @throws AjlException
	 */
	public void save(RegistCode registCode) throws AjlException;
	
	/**
	 * 查询最后的激活验证码
	 * @return
	 * @throws AjlException
	 */
	public RegistCode queryRegistCode(String email, String uuid) throws AjlException; 

}
