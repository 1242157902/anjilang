package com.anjilang.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**   
 * @Title: Information.java 
 * @Package com.anjilang.entity 
 * @Description: 资讯信息
 * @author linqingsong
 * @date 2015-1-1 下午1:37:52 
 * @version V1.0   
 */
@Entity
@Table(name = "t_information")
public class Information implements Serializable{
	private static final long serialVersionUID = 1L;
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
	private String crTime;
	/**
	 * 所属分组ID
	 */
	private int typeId;
	/**
	 * 浏览次数
	 */
	private int num;
	/**
	 * 作者Id
	 */
	private int authorId;
	
	
	
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
	public String getCrTime() {
		return crTime;
	}
	public void setCrTime(String crTime) {
		this.crTime = crTime;
	}
	public int getTypeId() {
		return typeId;
	}
	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getAuthorId() {
		return authorId;
	}
	public void setAuthorId(int authorId) {
		this.authorId = authorId;
	}
}
