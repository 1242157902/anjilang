package com.anjilang.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.anjilang.dao.InforDao;
import com.anjilang.dao.InforTypeDao;
import com.anjilang.dao.base.impl.PaginationSupport;
import com.anjilang.entity.Information;
import com.anjilang.service.InforService;

/**   
 * @Title: InforServiceImpl.java 
 * @Package com.anjilang.service.impl 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author linqingsong
 * @date 2015-1-1 下午1:46:33 
 * @version V1.0   
 */
@Service
public class InforServiceImpl implements InforService{
	@Autowired
	private InforTypeDao inforTypeDao;
	
	@Autowired
	private InforDao inforDao;
	
	@Override
	@Transactional
	public void save(Information information) {
		inforDao.save(information);
	}

	@Override
	public List<Information> query(int typeId) {
		Object [] values={typeId};
		String hql="from Information where typeId = ? order by id desc";
		List<Information> list=inforDao.find(hql, values);
		return list;
	}

	@Override
	@Transactional
	public void delete(Information information) {
		inforDao.delete(information);
	}

	@Override
	public Information findById(Long id) {
		return inforDao.get(id);
	}

	@Override
	public List<Information> queryHot() {
		String hql="from Information order by num DESC";
		List<Information> list=inforDao.find(hql);
		if(list.size()>6){
			List<Information> returnList=new ArrayList<Information>();
			for(int i=0;i<7;i++){
				returnList.add(list.get(i));
			}
			return returnList;
		}
		return list;
	}

	@Override
	public List<Information> queryPrev(Long id) {
		Object [] values={id};
		String hql="from Information where id < ? order by id desc";
		List<Information> list=inforDao.find(hql,values);
		if(list!=null && list.size()>0){
			return list;
		}
		return null;
	}

	@Override
	public List<Information> queryNext(Long id) {
		Object [] values={id};
		String hql="from Information where id > ? order by id asc";
		List<Information> list=inforDao.find(hql,values);
		if(list!=null && list.size()>0){
			return list;
		}
		return null;
	}

	@Override
	public PaginationSupport<Information> queryPage(Map<String, Object> params,
			String[] order, int pageSize, int pageNo) {
		return	inforDao.queryPage(params, order, pageSize, pageNo);
	}

	@Override
	public Long findBytypeId(Long id) {
		// TODO Auto-generated method stub
		return inforDao.findBytypeId(id);
	}

}
