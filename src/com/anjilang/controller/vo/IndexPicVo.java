package com.anjilang.controller.vo;

import com.alibaba.fastjson.JSONObject;

public class IndexPicVo {
	private Long id;
	private String picUrl;
	private Integer type;
	private Integer sortNum;
	private Long diseaseId;
	
	/*商城新增*/
	private String nowprice;
	private String pastprice;
	private String typename;
    private String  productname;
    private String     overplus;//剩余
    
	
	

	

	
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
	/** 访问路径（网页地址） 商城和特约营养师有 */
	private String accessUrl;

	/** 特约营养师姓名 */
	private String name;

	/** 工作医院 */
	private String hospital;

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

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getSortNum() {
		return sortNum;
	}

	public void setSortNum(Integer sortNum) {
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
		return "IndexPicVo [id=" + id + ", picUrl=" + picUrl + ", type=" + type
				+ ", sortNum=" + sortNum + ", diseaseId=" + diseaseId
				+ ", accessUrl=" + accessUrl + ", name=" + name + ", hospital="
				+ hospital + "]";
	}
	/** VO字段与中文映射关系 */
	private static final JSONObject FIELD_NAME = JSONObject
			.parseObject("{\"accessUrl\":\"访问地址\",\"diseaseId\":\"项目\",\"hospital\":\"工作医院\",\"id\":\"图片主键\",\"name\":\"特约营养师姓名\",\"picUrl\":\"图片地址\",\"sortNum\":\"图片展示排序\",\"type\":\"图片类型\"}");
	/**
	 * 返回改注册VO字段与中文映射关系
	 * 
	 * @return
	 */
	public JSONObject filedNameList() {
		return FIELD_NAME;
	}
}
