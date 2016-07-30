package com.anjilang.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;


/**
 * 问题回答
 * @author Eric
 *
 */
@Entity
@Table(name="t_answer")
public class Answer implements Serializable{

	
	private static final long serialVersionUID = -5634187921918330201L;
	/**
	 * id
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	/**
	 * 用户Id
	 */
	@ManyToOne
	@JoinColumn(name = "userId")
	private User user;
	/**
	 * 创建时间
	 */
	private Date crTime;
	/**
	 * 内容
	 */
	private String content;
	
	/**
	 * 所属问题ID
	 */
	private Long answerId;
	/**
	 * 所属父回答ID
	 */
	private Long parentId;
	
	/**
	 * 点赞次数
	 */
	private int agreeNum;
	
	/**
	 * 回复次数
	 */
	private int commentNum;
	
	/**
	 * 回答回复
	 */
	@OneToMany(fetch = FetchType.LAZY, targetEntity = AnswerComment.class)
	@JoinColumn(name = "answerId")
	private Set<AnswerComment> comments = new HashSet<AnswerComment>();
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "Answer [id=" + id + ", user=" + user + ", crTime=" + crTime
				+ ", content=" + content + "]";
	}

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

	public int getAgreeNum() {
		return agreeNum;
	}

	public void setAgreeNum(int agreeNum) {
		this.agreeNum = agreeNum;
	}

	public int getCommentNum() {
		return commentNum;
	}

	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
	}
}
