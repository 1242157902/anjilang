package com.anjilang.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * @author  JYM
 * 2015-7-26 下午7:54:23
 */
@Entity
@Table(name="t_group_message")
public class GroupMessage implements Serializable{
	
	private static final long serialVersionUID = 6847903395198437772L;

	private Long id;
	
	private PatientGroup patientGroup;
	
	private String content;
	
	private Long adminid;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Long getId() {
		return id;
	}

	
	public void setId(Long id) {
		this.id = id;
	}

	@ManyToOne
	@JoinColumn(name="groupid")
	public PatientGroup getPatientGroup() {
		return patientGroup;
	}

	public void setPatientGroup(PatientGroup patientGroup) {
		this.patientGroup = patientGroup;
	}

	@Column(name="content")
	public String getContent() {
		return content;
	}

	
	public void setContent(String content) {
		this.content = content;
	}

	@Column(name="adminid")
	public Long getAdminid() {
		return adminid;
	}

	
	public void setAdminid(Long adminid) {
		this.adminid = adminid;
	}


	
	@Override
	public String toString() {
		return "GroupMessage [id=" + id + ", patientGroup=" + patientGroup
				+ ", content=" + content + ", adminid=" + adminid + "]";
	}
	
	
	

}
