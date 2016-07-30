package com.anjilang.service.impl;



import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.anjilang.dao.GroupMessageDao;
import com.anjilang.entity.GroupMessage;
import com.anjilang.entity.PatientGroup;
import com.anjilang.service.GroupMessageService;
import com.anjilang.util.AjlException;

/**
 * @author  JYM
 * 2015-7-27 下午5:26:24
 */
@Service
public class GroupMessageServiceImpl  implements GroupMessageService{
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private  GroupMessageDao groupMessageDao;

	
	@Override
	public void savemessage(GroupMessage groupMessage) throws AjlException {
		groupMessageDao.save(groupMessage);		
		
	}


	
	@Override
	public List<GroupMessage> queryByGroup(PatientGroup patientGroup)
			throws AjlException {
		try {
			log.info("查询标签groupid["+patientGroup.getId()+"]");
			String hql = "FROM  GroupMessage  WHERE 1=1";
			if(patientGroup!=null){
				hql += " AND groupid = '" + patientGroup.getId() + "'";
			}
			hql += "AND cancel = "+0+"ORDER BY id";
			return groupMessageDao.find(hql);
		} catch (Exception e) {
			log.error("根据小组查标签失败["+patientGroup.getId()+"]", e);
			throw AjlException.createErr("5000");
		}
	}

}
