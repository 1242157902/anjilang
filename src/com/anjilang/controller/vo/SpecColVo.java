package com.anjilang.controller.vo;

public class SpecColVo {
	private Long id;
	/** 姓名 */
	private String title;
	/** 描述 */
	private String content;
	/** 头像 */
	private String pic;
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
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
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
		return "SpecColVo [id=" + id + ", title=" + title + ", content="
				+ content + ", pic=" + pic + ", url=" + url + ", sort=" + sort
				+ "]";
	}
	public SpecColVo(Long id, String title, String content, String pic,
			String url, Integer sort) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
		this.pic = pic;
		this.url = url;
		this.sort = sort;
	}
	public SpecColVo(){
		
	}
	
}
