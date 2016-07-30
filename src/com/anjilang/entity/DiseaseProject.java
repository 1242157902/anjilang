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
 * 疾病项目
 * 
 * @author xym
 * 
 */
@Entity
@Table(name = "t_disease_project")
public class DiseaseProject implements Serializable {
	private static final long serialVersionUID = 5511266798100303578L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	/** 疾病名称 */
	@Column(name = "disease_name")
	private String diseaseName;
	/** 创建时间 */
	@Column(name = "create_time")
	private Date createTime;
	/** 更新时间 */
	@Column(name = "update_time")
	private Date updateTime;
	/**图片地址*/
	@Column(name = "picUrl")
	private String picUrl;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDiseaseName() {
		return diseaseName;
	}

	public void setDiseaseName(String diseaseName) {
		this.diseaseName = diseaseName;
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
	
	public String getPicUrl() {
		return picUrl;
	}

	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}

	@Override
	public String toString() {
		return "DiseaseProject [id=" + id + ", diseaseName=" + diseaseName
				+ ", createTime=" + createTime + ", updateTime=" + updateTime
				+ "]";
	}

}
