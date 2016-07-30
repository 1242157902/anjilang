package com.anjilang.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 书籍
 * @author Jane
 *
 */
@Entity
@Table(name="t_book")
public class Book implements Serializable{
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	@Column(name = "bookname")
	private String bookname;
	/** 内容 */
	@Column(name = "authorId")
	private Long authorId;
	/** 图片 */
	@Column(name = "pic")
	private String pic;
	
	@Column(name = "authorname")
	private String authorname;
	
	@Column(name = "content")
	private String content;
	
	@Column(name = "authorurl")
	private String authorURL;
	
	@Column(name = "bookurl")
	private String bookURL;

	/**
	 * @return the id
	 */
	public Long getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * @return the bookname
	 */
	public String getBookname() {
		return bookname;
	}

	/**
	 * @param bookname the bookname to set
	 */
	public void setBookname(String bookname) {
		this.bookname = bookname;
	}

	/**
	 * @return the authorId
	 */
	public Long getAuthorId() {
		return authorId;
	}

	/**
	 * @param authorId the authorId to set
	 */
	public void setAuthorId(Long authorId) {
		this.authorId = authorId;
	}

	/**
	 * @return the pic
	 */
	public String getPic() {
		return pic;
	}

	/**
	 * @param pic the pic to set
	 */
	public void setPic(String pic) {
		this.pic = pic;
	}

	/**
	 * @return the authorname
	 */
	public String getAuthorname() {
		return authorname;
	}

	/**
	 * @param authorname the authorname to set
	 */
	public void setAuthorname(String authorname) {
		this.authorname = authorname;
	}

	/**
	 * @return the content
	 */
	public String getContent() {
		return content;
	}

	/**
	 * @param content the content to set
	 */
	public void setContent(String content) {
		this.content = content;
	}

	/**
	 * @return the authorURL
	 */
	public String getAuthorURL() {
		return authorURL;
	}

	/**
	 * @param authorURL the authorURL to set
	 */
	public void setAuthorURL(String authorURL) {
		this.authorURL = authorURL;
	}

	/**
	 * @return the bookURL
	 */
	public String getBookURL() {
		return bookURL;
	}

	/**
	 * @param bookURL the bookURL to set
	 */
	public void setBookURL(String bookURL) {
		this.bookURL = bookURL;
	}

	/**
	 * @return the serialversionuid
	 */
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Book [id=" + id + ", bookname=" + bookname + ", authorId="
				+ authorId + ", pic=" + pic + ", authorname=" + authorname
				+ ", content=" + content + ", authorURL=" + authorURL
				+ ", bookURL=" + bookURL + "]";
	}
	
	
	
}
