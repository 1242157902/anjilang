/**
 * 
 */
package com.anjilang.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**   
 * @Title: Information.java 
 * @Package com.anjilang.entity 
 * @Description: 短消息
 * @author linqingsong
 * @date 2015-1-1 下午1:37:52 
 * @version V1.0   
 */
@Entity
@Table(name = "t_message")
public class Message implements Serializable{

	private static final long serialVersionUID = 1L;

	/**
	 * id
	 */
	private Long id;
	/**
	 * 发给某位用户
	 */
	private Long fromUserId;
	
	/**
	 * 来自某位用户
	 */
	private Long toUserId;
	
	/**
	 * 内容
	 */
	private String content;
	
	/**
	 * 是否阅读,0：未读，1：已读
	 */
	private int isRead;
	
	/**
	 * 类型，0：系统消息，1：用户消息
	 */
	private int type;
	
	/**
	 * 标题
	 */
	private String title;
	
	/**
	 * 创建时间
	 */
	private Date createTime;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
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

	public int getIsRead() {
		return isRead;
	}

	public void setIsRead(int isRead) {
		this.isRead = isRead;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Long getFromUserId() {
		return fromUserId;
	}

	public void setFromUserId(Long fromUserId) {
		this.fromUserId = fromUserId;
	}

	public Long getToUserId() {
		return toUserId;
	}

	public void setToUserId(Long toUserId) {
		this.toUserId = toUserId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Override
	public String toString() {
		return "Message [id=" + id + ", fromUserId=" + fromUserId
				+ ", toUserId=" + toUserId + ", content=" + content
				+ ", isRead=" + isRead + ", type=" + type + ", title=" + title
				+ ", createTime=" + createTime + "]";
	}
}
