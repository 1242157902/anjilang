package com.anjilang.service;

import java.util.List;

import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.PatientGroup;
import com.anjilang.util.AjlException;

/**
 * 患友会小组 接口
 * @author  JYM
 * 2015-7-8 下午4:34:19
 */
public interface PatientGroupService {
	
	/**
	 * 用户添加小组
	 * @param patientGroup
	 * @throws AjlException
	 */
	public  void addPatientGroup(PatientGroup patientGroup) throws AjlException;
	
	/**
	 * 根据id获取到小组信息
	 * @param id
	 * @throws AjlException
	 */
	public PatientGroup getByid(Long id) throws AjlException;
	
	
	
	
	/**
	 * 小组管理者
	 * 修改小组的信息
	 * @param patientGroup
	 * @throws AjlException
	 */
    public void  update(PatientGroup patientGroup) throws AjlException;
    
    
    

   
    /**
	 * 管理员审核小组
	 * @param audit 1-未审核2-已审核 null-缺省改查询条件
	 * @return AjlException
	 */
    public List<PatientGroup> queryGroupByAudit(String audit) throws AjlException;
    
    /**
	 * 
	 * @param audit 1-未审核2-已审核 null-缺省改查询条件
	 * @param pageSize 默认最小5
	 * @param pageNo 默认最小1
	 * @return PaginationSupport<PatientGroup>
	 */
    
    public PaginationSupport<PatientGroup> queryGroupByAudit(String audit, int pageSize,
			int pageNo);
    
    
    /**
	 * 最活跃小组列表
	 */
    public List<PatientGroup>  queryByCount() throws AjlException;
    

}
