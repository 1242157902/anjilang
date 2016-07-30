package com.anjilang.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * @Title: UserCaller.java
 * @Package com.anjilang.entity
 * @Description: 问题
 * @author linqingsong
 * @date 2015-1-1 下午10:30:04
 * @version V1.0
 */
@Entity
@Table(name = "t_usercaller")
public class UserCaller implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3308985730750669332L;
	/**
	 * id
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	/**
	 * 访客用户
	 */
	@ManyToOne
	@JoinColumn(name = "userId")
	private User user;
	/**
	 * 创建时间
	 */
	private Date crTime;
	/**
	 * 被访客用户Id
	 */
	private Long callerUserId;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getCrTime() {
		return crTime;
	}

	public void setCrTime(Date crTime) {
		this.crTime = crTime;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Long getCallerUserId() {
		return callerUserId;
	}

	public void setCallerUserId(Long callerUserId) {
		this.callerUserId = callerUserId;
	}

	@Override
	public String toString() {
		return "UserCaller [id=" + id + ", user=" + user + ", crTime=" + crTime
				+ ", callerUserId=" + callerUserId + "]";
	}

}
