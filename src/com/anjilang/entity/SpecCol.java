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
 * 专栏在首页展示数据
 * @author xym
 *
 */
@Entity
@Table(name = "t_spec_col")
public class SpecCol implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	/** 专栏标题 */
	@Column(name = "title")
	private String title;
	/** 专栏内容 */
	@Column(name = "content")
	private String content;
	/** 专栏首页展示图片 */
	@Column(name = "pic")
	private String pic;
	
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
	
	/** 作者 */
	@Column(name = "author")
	private String author;

	
	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

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

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
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

	public SpecCol() {
		super();
	}
	
	public SpecCol(Long id, String title, String content, String pic,
			String url, Integer sort, Date createTime, Date updateTime) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
		this.pic = pic;
		this.url = url;
		this.sort = sort;
		this.createTime = createTime;
		this.updateTime = updateTime;
	}

	@Override
	public String toString() {
		return "SpecCol [id=" + id + ", title=" + title + ", content="
				+ content + ", pic=" + pic + ", url=" + url + ", sort=" + sort
				+ ", createTime=" + createTime + ", updateTime=" + updateTime
				+ "]";
	}
	
}
