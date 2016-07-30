package com.anjilang.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**   
 * @Title: Picture.java 
 * @Package com.anjilang.entity 
 * @Description: 图片
 * @author linqingsong
 * @date 2015-1-3 下午4:10:30 
 * @version V1.0   
 */
@Entity
@Table(name = "t_picture")
public class Picture implements Serializable {

	private static final long serialVersionUID = 1L;

	/**
	 * id
	 */
	private Long id;
	/**
	 * 图片地址
	 */
	private String picUrl;
	/**
	 * 类型
	 */
	private int type;
	/**
	 * 排序
	 */
	private int sortNum;
	
	/** 疾病项目 */
	private Long diseaseId;
	
	/** 访问路径（网页地址） 商城和特约营养师有  */
	private String accessUrl;
	
	/** 特约营养师姓名 */
	private String name;
	
	/** 工作医院 */
	private String hospital;
	
	
	
	/*商城新增*/
	private String nowprice;
	private String pastprice;
	private String typename;
    private String  productname;
    private String  overplus;
	/**
	 * @return the overplus
	 */
	public String getOverplus() {
		return overplus;
	}
	/**
	 * @param overplus the overplus to set
	 */
	public void setOverplus(String overplus) {
		this.overplus = overplus;
	}
	/**
	 * @return the nowprice
	 */
	public String getNowprice() {
		return nowprice;
	}
	/**
	 * @param nowprice the nowprice to set
	 */
	public void setNowprice(String nowprice) {
		this.nowprice = nowprice;
	}
	/**
	 * @return the pastprice
	 */
	public String getPastprice() {
		return pastprice;
	}
	/**
	 * @param pastprice the pastprice to set
	 */
	public void setPastprice(String pastprice) {
		this.pastprice = pastprice;
	}
	/**
	 * @return the typename
	 */
	public String getTypename() {
		return typename;
	}
	/**
	 * @param typename the typename to set
	 */
	public void setTypename(String typename) {
		this.typename = typename;
	}
	/**
	 * @return the productname
	 */
	public String getProductname() {
		return productname;
	}
	/**
	 * @param productname the productname to set
	 */
	public void setProductname(String productname) {
		this.productname = productname;
	}
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getPicUrl() {
		return picUrl;
	}
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getSortNum() {
		return sortNum;
	}
	public void setSortNum(int sortNum) {
		this.sortNum = sortNum;
	}
	public Long getDiseaseId() {
		return diseaseId;
	}
	public void setDiseaseId(Long diseaseId) {
		this.diseaseId = diseaseId;
	}
	public String getAccessUrl() {
		return accessUrl;
	}
	public void setAccessUrl(String accessUrl) {
		this.accessUrl = accessUrl;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getHospital() {
		return hospital;
	}
	public void setHospital(String hospital) {
		this.hospital = hospital;
	}
	@Override
	public String toString() {
		return "Picture [id=" + id + ", picUrl=" + picUrl + ", type=" + type
				+ ", sortNum=" + sortNum + ", diseaseId=" + diseaseId
				+ ", accessUrl=" + accessUrl + ", name=" + name + ", hospital="
				+ hospital + "]";
	}
}
