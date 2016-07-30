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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * @author  JYM
 * 2015-7-30 上午11:03:56
 */
@Entity
@Table(name="t_topic_reply")
public class TopicReply  implements Serializable{
	
	private static final long serialVersionUID = 6009320883147352948L;

	private Long id;
	
	private String content;
	
	private  Integer floor;
	
	private User user;
	
	private Date reptime;
	
	private Long topicid;
	
	private Integer repcount;
	
	private TopicReply  quoteTopicReply;
	
	private TopicReply beRelyTopicReply;
	
	private Boolean  isDelete;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Long getId() {
		return id;
	}

	
	public void setId(Long id) {
		this.id = id;
	}

	@Column(name="content")
	public String getContent() {
		return content;
	}

	
	public void setContent(String content) {
		this.content = content;
	}

	@Column(name="floor")
	public Integer getFloor() {
		return floor;
	}
	
	public void setFloor(Integer floor) {
		this.floor = floor;
	}

	@ManyToOne
	@JoinColumn(name="repid")
	public User getUser() {
		return user;
	}


	public void setUser(User user) {
		this.user = user;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="reptime")
	public Date getReptime() {
		return reptime;
	}

	
	public void setReptime(Date reptime) {
		this.reptime = reptime;
	}

	@Column(name="topicid")
	public Long getTopicid() {
		return topicid;
	}

	
	public void setTopicid(Long topicid) {
		this.topicid = topicid;
	}


    @Column(name="repcount")
	public Integer getRepcount() {
		return repcount;
	}


	public void setRepcount(Integer repcount) {
		this.repcount = repcount;
	}
	

 

	@OneToOne
	@JoinColumn(name="quoteid")
	public TopicReply getQuoteTopicReply() {
		return quoteTopicReply;
	}


	public void setQuoteTopicReply(TopicReply quoteTopicReply) {
		this.quoteTopicReply = quoteTopicReply;
	}


	@OneToOne
	@JoinColumn(name="berelyid")
	public TopicReply getBeRelyTopicReply() {
		return beRelyTopicReply;
	}


	public void setBeRelyTopicReply(TopicReply beRelyTopicReply) {
		this.beRelyTopicReply = beRelyTopicReply;
	}

	@Column(name="isdelete")
	public Boolean getIsDelete() {
		return isDelete;
	}


	public void setIsDelete(Boolean isDelete) {
		this.isDelete = isDelete;
	}


	@Override
	public String toString() {
		return "TopicReply [id=" + id + ", content=" + content + ", floor="
				+ floor + ", user=" + user + ", reptime=" + reptime
				+ ", topicid=" + topicid + ", repcount=" + repcount
				+ ", quoteTopicReply=" + quoteTopicReply
				+ ", beRelyTopicReply=" + beRelyTopicReply + ", isDelete="
				+ isDelete + "]";
	}

}
