package com.anjilang.controller.vo;


public class SeniorDoctorVo {
	private Long id;
	/** 姓名 */
	private String name;
	/** 描述 */
	private String description;
	/** 头像 */
	private String header;
	/** 访问URL */
	private String url;
	/** 排序越大越靠前 */
	private Integer sort;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getHeader() {
		return header;
	}
	public void setHeader(String header) {
		this.header = header;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	@Override
	public String toString() {
		return "SeniorDoctorVo [id=" + id + ", name=" + name + ", description="
				+ description + ", header=" + header + ", url=" + url
				+ ", sort=" + sort + "]";
	}
//	private Date createTime;
//	private Date updateTime;
}
