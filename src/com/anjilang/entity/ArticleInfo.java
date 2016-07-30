package com.anjilang.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 文章发表实体
 * 
 * @author liudb
 * @see 1.0.0
 */
@Entity
@Table(name = "t_articleinfo")
public class ArticleInfo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7936184893798933305L;

	/**
	 * id
	 */
	private Long id;

	/**
	 * 标题
	 */
	private String title;
	/**
	 * 内容
	 */
	private String content;

	/**
	 * 创建时间
	 */
	private Date createDate;

	/**
	 * 修改时间
	 */
	private Date modifyDate;

	/**
	 * 文章发表人Id
	 */
	private Long userId;
	
	/**
	 * 浏览次数
	 */
	private int num;

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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}
	

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "ArticleInfo [id=" + id + ", title=" + title + ", content="
				+ content + ", createDate=" + createDate + ", modifyDate="
				+ modifyDate + ", user=" + userId + ", num=" + num + "]";
	}

}
