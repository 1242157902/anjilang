package com.anjilang.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author  JYM
 * 2015-8-12 下午4:38:40
 */
@Entity
@Table(name="t_topic_recom")
public class TopicRecom  implements Serializable{

	
	private static final long serialVersionUID = -2476779340065529329L;
	
	
	private Integer id;
	
	private String rectype;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Integer getId() {
		return id;
	}

	
	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name="rectype")
	public String getRectype() {
		return rectype;
	}

	public void setRectype(String rectype) {
		this.rectype = rectype;
	}


	@Override
	public String toString() {
		return "TopicRecom [id=" + id + ", rectype=" + rectype + "]";
	}
	
	
	

}
