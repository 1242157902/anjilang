package com.anjilang.service;

import java.util.List;

import com.anjilang.entity.GroupMessage;
import com.anjilang.entity.PatientGroup;
import com.anjilang.util.AjlException;

/**
 * @author  JYM
 * 2015-7-27 下午5:23:55
 */
public interface GroupMessageService {
	
	public void  savemessage(GroupMessage groupMessage) throws AjlException;
	
	
	
	public List<GroupMessage>  queryByGroup(PatientGroup patientGroup) throws AjlException;

}
