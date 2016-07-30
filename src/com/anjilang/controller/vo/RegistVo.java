package com.anjilang.controller.vo;

import java.util.Date;

import com.alibaba.fastjson.JSONObject;

/**
 * 注册接口需要参数
 * 
 * @author xym
 * 
 */
public class RegistVo {
	private Long id;
	/** 真实姓名 */
	private String realName;
	/** 省份ID（城市ID） */
	private Long province;
	/** 城市ID */
	private Long city;
	/** 医生生日日期 */
	private String birStr;
	/** 现在工作医院 */
	private String hospital;
	/** 职称 */
	private String title;
	/** 医生擅长医治疾病项目存储格式:,1,2,3, */
	private String project;
	/** 手机号码 */
	private String phone;
	/** 登录名(email) */
	private String userName;
	//** 登录密码 *//*
	private String password;

	private String password2;

	/** 头像地址 */
	private String header;
	private Date createTime;
	private Date updateTime;
	private String sex;
	/** 1-医生，2-用户 */
	private String type;
	/** 1-未审核，2-已审核 仅仅医生需要审核 */
	private String audit;

	/** 证件号 营养师职业号 */
	private String certificateNo;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public Long getProvince() {
		return province;
	}

	public void setProvince(Long province) {
		this.province = province;
	}

	public Long getCity() {
		return city;
	}

	public void setCity(Long city) {
		this.city = city;
	}

	public String getBirStr() {
		return birStr;
	}

	public void setBirStr(String birStr) {
		this.birStr = birStr;
	}

	public String getHospital() {
		return hospital;
	}

	public void setHospital(String hospital) {
		this.hospital = hospital;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getProject() {
		return project;
	}

	public void setProject(String project) {
		this.project = project;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getHeader() {
		return header;
	}

	public void setHeader(String header) {
		this.header = header;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getAudit() {
		return audit;
	}

	public void setAudit(String audit) {
		this.audit = audit;
	}

	public String getPassword2() {
		return password2;
	}

	public void setPassword2(String password2) {
		this.password2 = password2;
	}

	public String getCertificateNo() {
		return certificateNo;
	}

	public void setCertificateNo(String certificateNo) {
		this.certificateNo = certificateNo;
	}

 

 



	/** 注册VO字段与中文映射关系 */
	private static final JSONObject FIELD_NAME = JSONObject
			.parseObject("{\"audit\":\"审核状态\",\"birStr\":\"生日\",\"certificateNo\":\"营养师职业号\",\"city\":\"城市\",\"createTime\":\"创建时间\",\"header\":\"头像\",\"hospital\":\"工作医院\",\"id\":\"用户编号\",\"password\":\"密码\",\"password2\":\"确认密码\",\"phone\":\"手机\",\"project\":\"擅长项目\",\"province\":\"省份\",\"realName\":\"真实姓名\",\"sex\":\"性别\",\"title\":\"职称\",\"type\":\"用户类型\",\"updateTime\":\"更新时间\",\"userName\":\"用户名(邮箱)\"}");

	/**
	 * 返回改注册VO字段与中文映射关系
	 * 
	 * @return
	 */
	public JSONObject filedNameList() {
		return FIELD_NAME;
	}
}
