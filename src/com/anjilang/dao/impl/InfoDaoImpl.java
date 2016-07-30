package com.anjilang.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.stereotype.Repository;

import com.anjilang.dao.InforDao;
import com.anjilang.dao.base.impl.GenericHibernateDao;
import com.anjilang.entity.Information;

/**   
 * @Title: InfoDaoImpl.java 
 * @Package com.anjilang.dao.impl 
 * @Description: 咨询dao实现
 * @author linqingsong
 * @date 2015-1-1 下午1:44:10 
 * @version V1.0   
 */
@Repository
public class InfoDaoImpl extends GenericHibernateDao<Information, Long> implements InforDao{

	@Override
	public Long findBytypeId(Long id) {
		
	   try {
		Connection  connection=getSession().connection();
		   
		   String  sql="select * from t_information where typeId="+id+" order by num desc limit 1";
			
		   PreparedStatement statement= connection.prepareStatement(sql);
		   ResultSet resultSet=statement.executeQuery();
		   
		   if (resultSet.next()) {
			
			return resultSet.getLong("id");
		  }
		   
	} catch (Exception e) {
		
		e.printStackTrace();
	} 
		
	   return null;
	}

}
