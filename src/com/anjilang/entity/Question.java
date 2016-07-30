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
 * @Title: Question.java
 * @Package com.anjilang.entity
 * @Description: 问题
 * @author linqingsong
 * @date 2015-1-1 下午10:30:04
 * @version V1.0
 */

@Entity
@Table(name = "t_question")
public class Question implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2488634547597777511L;
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
	 * 浏览数据
	 */
	private int num;
	/**
	 * 来自地区
	 */
	private String addr;
	/**
	 * 标题
	 */
	private String title;
	/**
	 * 内容
	 */
	private String content;
	
	/**
	 * 问题相关图片
	 */
	private String picture;
	/**
	 * 所属疾病ID
	 */
	@ManyToOne
	@JoinColumn(name = "diseaseId")
	private DiseaseProject disease;

	/**
	 * 问题回答
	 */
	@OneToMany(fetch = FetchType.LAZY, targetEntity = Answer.class)
	@JoinColumn(name = "answerId")
	private Set<Answer> answers = new HashSet<Answer>();

	/**
	 * 问题回答数
	 */
	private int answerNum;

	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getCrTime() {
		return crTime;
	}

	public void setCrTime(Date crTime) {
		this.crTime = crTime;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
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

	public int getAnswerNum() {
		return answerNum;
	}

	public void setAnswerNum(int answerNum) {
		this.answerNum = answerNum;
	}
	
	public DiseaseProject getDisease() {
		return disease;
	}

	public void setDisease(DiseaseProject disease) {
		this.disease = disease;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Set<Answer> getAnswers() {
		return answers;
	}

	public void setAnswers(Set<Answer> answers) {
		this.answers = answers;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

}
