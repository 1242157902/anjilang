package com.anjilang.entity;

import java.io.Serializable;

import javax.persistence.Embeddable;

/**
 * @author  JYM
 * 2015-7-20 下午8:01:35
 */
@Embeddable
public class GroupIdAndUserid   implements Serializable{

private static final long serialVersionUID = 1L;
   private 	Long groupid; 
   private 	Long userid;


public Long getGroupid() {
	return groupid;
}


public void setGroupid(Long groupid) {
	this.groupid = groupid;
}


public Long getUserid() {
	return userid;
}


public void setUserid(Long userid) {
	this.userid = userid;
}
@Override
public int hashCode() {
	final int prime = 31;
	int result = 1;
	result = prime * result + ((groupid == null) ? 0 : groupid.hashCode());
	result = prime * result + ((userid == null) ? 0 : userid.hashCode());
	return result;
}

@Override
public boolean equals(Object obj) {
	if (this == obj)
		return true;
	if (obj == null)
		return false;
	if (getClass() != obj.getClass())
		return false;
	GroupIdAndUserid other = (GroupIdAndUserid) obj;
	if (groupid == null) {
		if (other.groupid != null)
			return false;
	} else if (!groupid.equals(other.groupid))
		return false;
	if (userid == null) {
		if (other.userid != null)
			return false;
	} else if (!userid.equals(other.userid))
		return false;
	return true;
}

	

}
