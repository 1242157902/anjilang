package com.anjilang.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
/**
 * 城市字典表
 * @author xym
 *
 */
@Entity
@Table(name = "t_basis_city")
public class City implements Serializable {
	private static final long serialVersionUID = 5511266798100303578L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	/** 城市代码 */
	@Column(name = "city_code")
	private String cityCode;
	/** 城市名称 */
	@Column(name = "city_name")
	private String cityName;
	/** 上级城市0-省级城市(省份) */
	@Column(name = "city_parent")
	private Long cityParent;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getCityCode() {
		return cityCode;
	}
	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public Long getCityParent() {
		return cityParent;
	}
	public void setCityParent(Long cityParent) {
		this.cityParent = cityParent;
	}
	@Override
	public String toString() {
		return "City [id=" + id + ", cityCode=" + cityCode + ", cityName="
				+ cityName + ", cityParent=" + cityParent + "]";
	}
}
