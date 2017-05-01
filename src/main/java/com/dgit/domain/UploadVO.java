package com.dgit.domain;

import java.util.Date;

public class UploadVO {
	private String fullname;
	private String uid;
	private Date regdate;
	
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	@Override
	public String toString() {
		return "UploadVO [fullname=" + fullname + ", uid=" + uid + ", regdate=" + regdate + "]";
	}
}
