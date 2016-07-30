package com.anjilang.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anjilang.dao.InforTypeDao;
import com.anjilang.entity.Information;
import com.anjilang.entity.InformationType;
import com.anjilang.service.InforService;
import com.anjilang.service.InforTypeService;

/**   
 * @Title: ServiceInfromationTypeImpl.java 
 * @Package com.anjilang.service.impl 
 * @Description: 咨询分组manger实现
 * @author linqingsong
 * @date 2014-12-28 下午10:48:09 
 * @version V1.0   
 */

@Service
public class InforTypeServiceImpl implements InforTypeService{
	@Autowired
	private InforTypeDao inforTypeDao;
	@Autowired
	private InforService inforService;
	
	@Override
	@Transactional
	public void save(InformationType informationType) {
		inforTypeDao.saveOrUpdate(informationType);
	}

	@Override
	public List<InformationType> query() {
		String hql="from InformationType";
		List<InformationType> list=inforTypeDao.find(hql);
		return list;
	}

	@Override
	@Transactional
	public void delete(InformationType informationType) {
		inforTypeDao.delete(informationType);
	}

	@Override
	public InformationType findById(Long id) {
		return inforTypeDao.get(id);
	}

	@Override
	public List<InformationType> queryIndex() {
		String hql="from InformationType where num!=0 order by num";
		List<InformationType> list=inforTypeDao.find(hql);
		List<InformationType> newList=new ArrayList<InformationType>();
		int num=3;
		if(list.size()<3){
			num=list.size();
		}
		for(int i=0;i<num;i++){
			InformationType informationType=list.get(i);
			List<Information> infoList=inforService.query(informationType.getId().intValue());
			List<Information> newInfoList=new ArrayList<Information>();
			
			int count=5;
			if(infoList.size()<5){
				count=infoList.size();
			}
			
			for(int z=0;z<count;z++){
				newInfoList.add(infoList.get(z));
			}
			informationType.setInfoList(newInfoList);

			newList.add(informationType);
		}
		return newList;
	}
	
	
}
