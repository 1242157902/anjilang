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
 * 资深医生
 * @author xym
 *
 */
@Entity
@Table(name = "t_senior_doctor")
public class SeniorDoctor implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	/** 姓名 */
	@Column(name = "name")
	private String name;
	/** 描述 */
	@Column(name = "description")
	private String description;
	/** 头像 */
	@Column(name = "header")
	private String header;
	/** 访问URL */
	@Column(name = "url")
	private String url;
	/** 排序越大越靠前 */
	@Column(name = "sort")
	private Integer sort;
	
	@Column(name = "create_time")
	private Date createTime;
	
	@Column(name = "update_time")
	private Date updateTime;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getHeader() {
		return header;
	}

	public void setHeader(String header) {
		this.header = header;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	@Override
	public String toString() {
		return "SeniorDoctor [id=" + id + ", name=" + name + ", description="
				+ description + ", header=" + header + ", url=" + url
				+ ", sort=" + sort + ", createTime=" + createTime
				+ ", updateTime=" + updateTime + "]";
	}

	public SeniorDoctor() {
		super();
	}
	
	public SeniorDoctor(Long id, String name, String description,
			String header, String url, int sort, Date createTime,
			Date updateTime) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.header = header;
		this.url = url;
		this.sort = sort;
		this.createTime = createTime;
		this.updateTime = updateTime;
	}
}
