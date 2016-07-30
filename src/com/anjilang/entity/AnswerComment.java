package com.anjilang.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * 问题回答的回复实体类
 * @author eric
 *
 */
@Entity
@Table(name="t_answer_comment")
public class AnswerComment implements Serializable{

	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	/**
	 * 回复内容
	 */
	@Column(name = "content")
	private String content;
	
	
	/**
	 * 用户Id
	 */
	@ManyToOne
	@JoinColumn(name = "userId")
	private User user;
	
	/**
	 * 回答ID
	 */
	@Column(name = "answerId")
	private Long answerId;
	
	/**
	 * 回答父ID
	 */
	@Column(name = "parentId")
	private Long parentId;
	
	
	/**
	 * 创建时间
	 */
	private Date crTime;

	public Long getAnswerId() {
		return answerId;
	}

	public void setAnswerId(Long answerId) {
		this.answerId = answerId;
	}

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getCrTime() {
		return crTime;
	}

	public void setCrTime(Date crTime) {
		this.crTime = crTime;
	}


}
