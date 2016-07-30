package com.anjilang.controller.vo;

import java.io.Serializable;

/**
 * 问答 AnswerAndQuestion
 * 
 * @author 
 * 
 */
public class Interlocution implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -3515137162083804136L;
	
	/**
	 * 问题回答ID
	 */
	private Long answerId;
	/**
	 * 问题ID
	 */
	private Long questionId;

	/**
	 * 问题回答内容
	 */
	private String answerContent;

	/**
	 * 问题内容
	 */
	private String questioncontent;

	/**
	 * 问题回答数
	 */
	private String answerNum;

	/**
	 * 问题浏览数
	 */
	private String num;

	/**
	 * 问题回答时间
	 */
	private String answerAcrTime;

	/**
	 * 问题提问时间
	 */
	private String questionAcrTime;

	/**
	 * 所属疾病名称
	 */
	private String diseaseName;
	
	/**
	 * 所属疾病Id
	 */
	private Long diseaseId;
	
	public Long getAnswerId() {
		return answerId;
	}

	public void setAnswerId(Long answerId) {
		this.answerId = answerId;
	}

	public Long getQuestionId() {
		return questionId;
	}

	public void setQuestionId(Long questionId) {
		this.questionId = questionId;
	}

	public String getAnswerContent() {
		return answerContent;
	}

	public void setAnswerContent(String answerContent) {
		this.answerContent = answerContent;
	}

	public String getQuestioncontent() {
		return questioncontent;
	}

	public void setQuestioncontent(String questioncontent) {
		this.questioncontent = questioncontent;
	}

	public String getAnswerNum() {
		return answerNum;
	}

	public void setAnswerNum(String answerNum) {
		this.answerNum = answerNum;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getAnswerAcrTime() {
		return answerAcrTime;
	}

	public void setAnswerAcrTime(String answerAcrTime) {
		this.answerAcrTime = answerAcrTime;
	}

	public String getQuestionAcrTime() {
		return questionAcrTime;
	}

	public void setQuestionAcrTime(String questionAcrTime) {
		this.questionAcrTime = questionAcrTime;
	}
	
	public String getDiseaseName() {
		return diseaseName;
	}

	public void setDiseaseName(String diseaseName) {
		this.diseaseName = diseaseName;
	}

	public Long getDiseaseId() {
		return diseaseId;
	}

	public void setDiseaseId(Long diseaseId) {
		this.diseaseId = diseaseId;
	}

	@Override
	public String toString() {
		return "Interlocution [answerId=" + answerId + ", questionId="
				+ questionId + ", answerContent=" + answerContent
				+ ", questioncontent=" + questioncontent + ", answerNum="
				+ answerNum + ", num=" + num + ", answerAcrTime="
				+ answerAcrTime + ", questionAcrTime=" + questionAcrTime
				+ ", diseaseName=" + diseaseName + ", diseaseId=" + diseaseId
				+ "]";
	}

}
