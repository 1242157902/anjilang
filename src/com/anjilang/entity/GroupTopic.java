package com.anjilang.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * @author  JYM
 * 2015-7-26 下午8:02:32
 */
@Entity
@Table(name="t_group_topic")
public class GroupTopic implements Serializable{
	
	private static final long serialVersionUID = 1308409647856023459L;

	private Long id;
	
	private PatientGroup patientGroup;
	
	private  Long  tabid;
	
	private String title;
	
	private String  content;
	
	private Date createtime;
	
	private User user;
	
	private Integer rep;
	
	private Integer hit;
	
	private Integer sign;
	
	private Integer elitetopic;
	
	private Integer topictop;
	
	private Integer cancel;
	
	private String articlepic;
	
	/**   
	  *2015/8/12*/
	
	private Integer recommended;
	
	private Date rectime;
	
	

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Long getId() {
		return id;
	}

	
	public void setId(Long id) {
		this.id = id;
	}

	@ManyToOne
	@JoinColumn(name="groupid")
	public PatientGroup getPatientGroup() {
		return patientGroup;
	}

	
	public void setPatientGroup(PatientGroup patientGroup) {
		this.patientGroup = patientGroup;
	}

	@Column(name="tabid")
	public Long getTabid() {
		return tabid;
	}

	
	public void setTabid(Long tabid) {
		this.tabid = tabid;
	}

	@Column(name="title")
	public String getTitle() {
		return title;
	}

	
	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name="content")
	public String getContent() {
		return content;
	}

	
	public void setContent(String content) {
		this.content = content;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="createtime")
	public Date getCreatetime() {
		return createtime;
	}

	
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	
	@ManyToOne
	@JoinColumn(name="createrid")
	public User getUser() {
		return user;
	}


	
	public void setUser(User user) {
		this.user = user;
	}


	@Column(name="rep")
	public Integer getRep() {
		return rep;
	}

	

	public void setRep(Integer rep) {
		this.rep = rep;
	}

	@Column(name="hit")
	public Integer getHit() {
		return hit;
	}

	
	public void setHit(Integer hit) {
		this.hit = hit;
	}

	@Column(name="sign")
	public Integer getSign() {
		return sign;
	}

	
	public void setSign(Integer sign) {
		this.sign = sign;
	}

	@Column(name="elitetopic")
	public Integer getElitetopic() {
		return elitetopic;
	}

	
	public void setElitetopic(Integer elitetopic) {
		this.elitetopic = elitetopic;
	}

	@Column(name="topictop")
	public Integer getTopictop() {
		return topictop;
	}

	
	public void setTopictop(Integer topictop) {
		this.topictop = topictop;
	}

	@Column(name="cancel")
	public Integer getCancel() {
		return cancel;
	}

	
	public void setCancel(Integer cancel) {
		this.cancel = cancel;
	}
	
	
	
	


	
	
   @Column(name="recommended")
	public Integer getRecommended() {
		return recommended;
	}


	
	public void setRecommended(Integer recommended) {
		this.recommended = recommended;
	}


	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="rectime")
	public Date getRectime() {
		return rectime;
	}


	public void setRectime(Date rectime) {
		this.rectime = rectime;
	}

	
	

	@Column(name="articlepic")
	public String getArticlepic() {
		return articlepic;
	}


	public void setArticlepic(String articlepic) {
		this.articlepic = articlepic;
	}


	@Override
	public String toString() {
		return "GroupTopic [id=" + id + ", patientGroup=" + patientGroup
				+ ", tabid=" + tabid + ", title=" + title + ", content="
				+ content + ", createtime=" + createtime + ", user=" + user
				+ ", rep=" + rep + ", hit=" + hit + ", sign=" + sign
				+ ", elitetopic=" + elitetopic + ", topictop=" + topictop
				+ ", cancel=" + cancel + ", articlepic=" + articlepic
				+ ", recommended=" + recommended + ", rectime=" + rectime + "]";
	}



	
}
