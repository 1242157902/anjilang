package com.anjilang.entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**   
 * @Title: InformationType.java 
 * @Package com.anjilang.entity 
 * @Description: 资讯分组
 * @author linqingsong
 * @date 2014-12-28 下午10:22:43 
 * @version V1.0   
 */

@Entity
@Table(name = "t_information_type")
public class InformationType implements Serializable{

	private static final long serialVersionUID = 1L;
	
	/**
	 * 主键ID
	 */
	private Long id;
	/**
	 * 资讯分组标题
	 */
	private String title;
	/**
	 * 资讯分组图片
	 */
	private String picture;
	/**
	 * 资讯详细标题
	 */
	private String detailTitle;
	/**
	 * 资讯详细内容
	 */
	private String detailContent;
	/**
	 * url地址
	 */
	private String url;
	
	/**
	 * 排序
	 */
	public int num;
	
	/**
	 * 所有资讯
	 */
	public List<Information> infoList;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public String getDetailTitle() {
		return detailTitle;
	}
	public void setDetailTitle(String detailTitle) {
		this.detailTitle = detailTitle;
	}
	public String getDetailContent() {
		return detailContent;
	}
	public void setDetailContent(String detailContent) {
		this.detailContent = detailContent;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	
	@Transient
	public List<Information> getInfoList() {
		return infoList;
	}
	public void setInfoList(List<Information> infoList) {
		this.infoList = infoList;
	}
}