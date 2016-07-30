/**  
 * @Title: FrindLink.java
 * @Package com.anjilang.entity
 * @Description: TODO
 * @author linqingsong
 * @date 2015年2月5日
 */
package com.anjilang.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * ClassName: FrindLink 
 * @Description: 友情链接
 * @author linqingsong
 * @date 2015年2月5日
 */
@Entity
@Table(name = "t_friendLink")
public class FriendLink implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private Long id;
	/** 标题 */
	private String title;
	/** 链接 */
	private String url;
	
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
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
}
