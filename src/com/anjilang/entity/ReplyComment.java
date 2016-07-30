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
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.springframework.web.bind.annotation.ModelAttribute;

@Entity
@Table(name="t_comment_reply")
public class ReplyComment implements Serializable{
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	@Column(name = "content")
	private String content;
	
	@Column(name = "userId")
	private Long userId;

	@Column(name = "parentId")
	private Long parentId;
	
	@Column(name = "crTime")
	private Date crTime;
	
	@Column(name = "inforId")
	private Long inforId;
	
	@Column(name = "nickname")
	private String nickname;
	

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
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

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

	public Date getCrTime() {
		return crTime;
	}

	public void setCrTime(Date crTime) {
		this.crTime = crTime;
	}

	public Long getInforId() {
		return inforId;
	}
	

	public void setInforId(Long inforId) {
		this.inforId = inforId;
	}

	@Override
	public String toString() {
		return "ReplyComment [id=" + id + ", content=" + content + ", userId="
				+ userId + ", parentId=" + parentId + ", crTime=" + crTime
				+ ", inforId=" + inforId + ", nickname=" + nickname + "]";
	}

 

	
 
}
