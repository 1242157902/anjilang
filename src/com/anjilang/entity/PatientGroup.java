package com.anjilang.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.sun.org.apache.bcel.internal.generic.NEW;

/**
 * @author  JYM
 * 2015-7-7 下午4:45:00
 */

@Entity
@Table(name="t_patient_group")
public class PatientGroup implements Serializable{
	private static final long serialVersionUID = 6081437137234929672L;
	
	private Long id;
	
	private String groupname;
	
	private Date createtime;
	
	private String picurl;
	
	private Long userid ;
	
	private Integer cancel;
	
	private String description;
	
	private String bgpicUrl;
	
	private Long adminid;
	
	private String audit;
	
	private Integer personcount;
	
	private Integer topiccount;
	
	 
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Long getId() {
		return id;
	}

	
	public void setId(Long id) {
		this.id = id;
	}

	/** 小组名称 */
	@Column(name="group_name")
	public String getGroupname() {
		return groupname;
	}

	
	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}

	/** 创建时间 */
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="create_time")
	public Date getCreatetime() {
		return createtime;
	}

	
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	/**头像图片地址*/
	@Column(name="picurl")
	public String getPicurl() {
		return picurl;
	}

	
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}

	

	/**创建者id*/
	@Column(name="userid")
	public Long getUserid() {
		return userid;
	}

	
	public void setUserid(Long userid) {
		this.userid = userid;
	}
	
	/**是否注销*/
	@Column(name="cancel")
	public Integer getCancel() {
		return cancel;
	}

	
	public void setCancel(Integer cancel) {
		this.cancel = cancel;
	}

	/**小组描述*/
	@Column(name="description")
	public String getDescription() {
		return description;
	}

	
	public void setDescription(String description) {
		this.description = description;
	}

	/**背景图片地址*/
	@Column(name="bgpicUrl")
	public String getBgpicUrl() {
		return bgpicUrl;
	}

	
	public void setBgpicUrl(String bgpicUrl) {
		this.bgpicUrl = bgpicUrl;
	}

	/**管理员id*/
	@Column(name="adminid")
	public Long getAdminid() {
		return adminid;
	}

	
	public void setAdminid(Long adminid) {
		this.adminid = adminid;
	}


	/** 审核*/
	@Column(name="audit")
	public String getAudit() {
		return audit;
	}


	public void setAudit(String audit) {
		this.audit = audit;
	}

	

	
	//小组人数
	@Column(name="personcount")
	public Integer getPersoncount() {
		return personcount;
	}


	
	public void setPersoncount(Integer personcount) {
		this.personcount = personcount;
	}
	
	
	


	@Column(name="topiccount")
	public Integer getTopiccount() {
		return topiccount;
	}


	
	public void setTopiccount(Integer topiccount) {
		this.topiccount = topiccount;
	}


	
	@Override
	public String toString() {
		return "PatientGroup [id=" + id + ", groupname=" + groupname
				+ ", createtime=" + createtime + ", picurl=" + picurl
				+ ", userid=" + userid + ", cancel=" + cancel
				+ ", description=" + description + ", bgpicUrl=" + bgpicUrl
				+ ", adminid=" + adminid + ", audit=" + audit
				+ ", personcount=" + personcount + ", topiccount=" + topiccount
				+ "]";
	}


}
