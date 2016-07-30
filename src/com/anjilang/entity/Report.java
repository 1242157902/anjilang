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
@Entity
@Table(name="t_report")
public class Report  implements Serializable{
	
	private Long id;
	
	private String reason;
	
	private TopicReply topicReply;
	
	private String reasonDetail ;
	
	private Date reportDate;
	
	private String content;
	
	private String formtable;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	@Column(name="reason")
	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	@OneToOne
	@JoinColumn(name="repid")
	public TopicReply getTopicReply() {
		return topicReply;
	}

	public void setTopicReply(TopicReply topicReply) {
		this.topicReply = topicReply;
	}
	
	@Column(name="reasondetail")
	public String getReasonDetail() {
		return reasonDetail;
	}

	public void setReasonDetail(String reasonDetail) {
		this.reasonDetail = reasonDetail;
	}
	
	@Column(name="reporttime")
	public Date getReportDate() {
		return reportDate;
	}
	
	public void setReportDate(Date reportDate) {
		this.reportDate = reportDate;
	}
	
	@Column(name="content")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column(name="fromtable")
	public String getFormtable() {
		return formtable;
	}

	public void setFormtable(String formtable) {
		this.formtable = formtable;
	}

	@Override
	public String toString() {
		return "Report [id=" + id + ", reason=" + reason + ", topicReply="
				+ topicReply + ", reasonDetail=" + reasonDetail
				+ ", reportDate=" + reportDate + ", content=" + content
				+ ", formtable=" + formtable + "]";
	}
	
}
