package com.anjilang.entity;

import java.io.Serializable;
import java.util.Date;

public class ReplyCommentSort implements Serializable{
	private Long id;
	private String content;
	private String crTime;
	private String nickname;
	

	private int level;
	public int getLevel() {
		return level;
	}
	
	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public void setLevel(int level) {
		this.level = level;
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
	public String getCrTime() {
		return crTime;
	}
	public void setCrTime(String crTime) {
		this.crTime = crTime;
	}

 
	
	
}

