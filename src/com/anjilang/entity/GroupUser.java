package com.anjilang.entity;
import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * @author  JYM
 * 2015-7-20 下午12:33:19
 */
@Entity
@Table(name="t_group_user")
public class GroupUser implements Serializable{
	
	private static final long serialVersionUID = -5046037600850360221L;

	@EmbeddedId
	 private  GroupIdAndUserid id;
	
	
	/**
	 * @return the id
	 */
	public GroupIdAndUserid getId() {
		return id;
	}


	/**
	 * @param id the id to set
	 */
	public void setId(GroupIdAndUserid id) {
		this.id = id;
	}


	@Column(name="ismember")
	private Integer ismember;
	
	@Column(name="adminid")
	private Long adminId;
	
	
	private Date jointime;
	
	private Date quittime;
	
	

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="jointime")
	public Date getJointime() {
		return jointime;
	}


	public void setJointime(Date jointime) {
		this.jointime = jointime;
	}

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="quittime")
	public Date getQuittime() {
		return quittime;
	}


	public void setQuittime(Date quittime) {
		this.quittime = quittime;
	}


	public Integer getIsmember() {
		return ismember;
	}

	
	public void setIsmember(Integer ismember) {
		this.ismember = ismember;
	}

	
	public Long getAdminId() {
		return adminId;
	}

	
	public void setAdminId(Long adminId) {
		this.adminId = adminId;
	}


	@Override
	public String toString() {
		return "GroupUser [id=" + id + ", ismember=" + ismember + ", adminId="
				+ adminId + ", jointime=" + jointime + ", quittime=" + quittime
				+ "]";
	}


	


}
