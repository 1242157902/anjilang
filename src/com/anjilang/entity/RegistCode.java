package com.anjilang.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
/**
 * 激活验证码
 * @author xym
 *
 */
@Entity
@Table(name = "t_regist_code")
public class RegistCode implements Serializable {
	private static final long serialVersionUID = -4485263614979276114L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	/** 激活用户email */
	@Column(name = "email")
	private String email;
	/** 激活验证码 */
	@Column(name="state")
	private String state;
	
	/** 激活验证码 0-未使用,1-已使用*/
	@Column(name="uuid")
	private String uuid;
	
	@Column(name="create_time")
	private Date createTime;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTiem(Date createTime) {
		this.createTime = createTime;
	}

	@Override
	public String toString() {
		return "RegistCode [id=" + id + ", email=" + email + ", state=" + state
				+ ", uuid=" + uuid + ", createTiem=" + createTime + "]";
	}
}
