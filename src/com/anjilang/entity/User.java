package com.anjilang.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

@Entity
@Table(name = "t_user")
public class User implements Serializable {
	private static final long serialVersionUID = 151210759047389781L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	/** 真实姓名 */
	@Column(name = "real_name")
	private String realName;
	/** 省份ID（城市ID） */
	@Column(name = "province")
	private Long province;
	/** 城市ID */
	@Column(name = "city")
	private Long city;
	/** 医生生日日期 */
 	@Column(name = "birthday")
	private Date birthday; 
	/** 现在工作医院 */
	@Column(name = "hospital")
	private String hospital;
	/** 职称 */
	@Column(name = "title")
	private String title;
	/** 医生擅长医治疾病项目存储格式:,1,2,3, */
	@Column(name = "project")
	private String project;
	/** 手机号码 */
	@Column(name = "phone")
	private String phone;
	/** 登录名(email) */
	@Column(name = "user_name")
	private String userName;
	/** 登录密码 */
	@Column(name = "password")
	private String password;
	/** 头像地址 */
	@Column(name = "header")
	private String header;
	
	@Column(name = "create_time")
	private Date createTime;
	
	@Column(name = "update_time")
	private Date updateTime;
	/** 证件号 营养师职业号 */
	@Column(name = "certificate_no")
	private String certificateNo;
	
	/** 性别：1-男，2-女 */
	@Column(name = "sex")
	private String sex;
	/** 1-医生，2-用户 */
	@Column(name = "type")
	private String type;
	/** 1-未审核，2-已审核 仅仅医生需要审核 */
	@Column(name = "audit")
	private String audit;
	/** 居住地 */
	@Column(name = "addr")
	private String addr;
	
	/** 回答问题数 */
	@Column(name = "answerNum")
	private int answerNum;
	/**
	 * 个人格言(签名)
	 */
	@Column(name = "signature")
	private String signature;
	
	/**
	 * 医生类型ID（医生类型表主键）
	 */
	@Column(name = "doctor_type")
	private Long doctorType;
	
	/**
	 * 学历
	 */
	@Column(name = "education")
	private String education;
	
	/**
	 * 教育经历
	 */
	@Column(name = "eduExperience")
	private String eduExperience;
	
	/**
	 * 简历
	 */
	@Column(name = "resume")
	private String resume;
	
	/**
	 * QQ开放ID
	 */
	@Column(name = "qqOpenId")
	private String qqOpenId;
	
	/**
	 * 微博用户ID
	 */
	@Column(name = "weiboUid")
	private String weiboUid;
	
	
	
	
	
	
	
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
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
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
	public String getCertificateNo() {
		return certificateNo;
	}
	public void setCertificateNo(String certificateNo) {
		this.certificateNo = certificateNo;
	}
	public String getSignature() {
		return signature;
	}
	public void setSignature(String signature) {
		this.signature = signature;
	}
	public Long getDoctorType() {
		return doctorType;
	}
	public void setDoctorType(Long doctorType) {
		this.doctorType = doctorType;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	public String getEducation() {
		return education;
	}
	
	public void setEducation(String education) {
		this.education = education;
	}
	
	public String getEduExperience() {
		return eduExperience;
	}
	
	public void setEduExperience(String eduExperience) {
		this.eduExperience = eduExperience;
	}
	
	public String getResume() {
		return resume;
	}
	
	public void setResume(String resume) {
		this.resume = resume;
	}
	
	public int getAnswerNum() {
		return answerNum;
	}
	public void setAnswerNum(int answerNum) {
		this.answerNum = answerNum;
	}
	public String getQqOpenId() {
		return qqOpenId;
	}
	public void setQqOpenId(String qqOpenId) {
		this.qqOpenId = qqOpenId;
	}
	
	public String getWeiboUid() {
		return weiboUid;
	}
	public void setWeiboUid(String weiboUid) {
		this.weiboUid = weiboUid;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", realName=" + realName + ", province="
				+ province + ", city=" + city + ", birthday=" + birthday
				+ ", hospital=" + hospital + ", title=" + title + ", project="
				+ project + ", phone=" + phone + ", userName=" + userName
				+ ", password=" + password + ", header=" + header
				+ ", createTime=" + createTime + ", updateTime=" + updateTime
				+ ", certificateNo=" + certificateNo + ", sex=" + sex
				+ ", type=" + type + ", audit=" + audit + ", signature="
				+ signature + ", doctorType=" + doctorType + "]"+ ", addr=" + addr + "]";
	}

}
