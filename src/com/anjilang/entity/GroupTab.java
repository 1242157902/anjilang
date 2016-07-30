package com.anjilang.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * @author  JYM
 * 2015-7-7 下午7:09:05
 */
@Entity
@Table(name="t_group_tab")
public class GroupTab  implements Serializable{

	private static final long serialVersionUID = -5759197529642382682L;
	
	private Long id;
	
	private String tabname;
	
	private PatientGroup patientGroup;
	
	private Integer cancel;
	
	private Long userid;
	
	private Integer sortorder;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	/** 标签名称 */
	@Column(name="tab_name")
	public String getTabname() {
		return tabname;
	}

	public void setTabname(String tabname) {
		this.tabname = tabname;
	}

	/**小组id */
	@ManyToOne
	@JoinColumn(name="groupid")
	public PatientGroup getPatientGroup() {
		return patientGroup;
	}

	
	public void setPatientGroup(PatientGroup patientGroup) {
		this.patientGroup = patientGroup;
	}

	/**是否注销*/
	@Column(name="cancel")
	public Integer getCancel() {
		return cancel;
	}
	
	public void setCancel(Integer cancel) {
		this.cancel = cancel;
	}

	/**管理员id*/
	@Column(name="userid")
	public Long getUserid() {
		return userid;
	}

	public void setUserid(Long userid) {
		this.userid = userid;
	}
	
	/**排序*/
	@Column(name="sortorder")
	public Integer getSortorder() {
		return sortorder;
	}

	public void setSortorder(Integer sortorder) {
		this.sortorder = sortorder;
	}

	@Override
	public String toString() {
		return "GroupTab [id=" + id + ", tabname=" + tabname
				+ ", patientGroup=" + patientGroup + ", cancel=" + cancel
				+ ", userid=" + userid + ", sortorder=" + sortorder + "]";
	}


}
