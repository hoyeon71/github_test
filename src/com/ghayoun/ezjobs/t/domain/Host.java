package com.ghayoun.ezjobs.t.domain;

import javax.xml.bind.annotation.XmlElement;

public class Host {
	private String hostName;
	private String osType;
	private String user;
	private String directory;
	private String conntype;

	public String getHostName() {
		return hostName;
	}

	@XmlElement(name = "HostName")
	public void setHostName(String hostName) {
		this.hostName = hostName;
	}
	
	public String getOsType() {
		return osType;
	}

	@XmlElement(name = "OsType")
	public void setOsType(String osType) {
		this.osType = osType;
	}

	public String getUser() {
		return user;
	}

	@XmlElement(name = "User")
	public void setUser(String user) {
		this.user = user;
	}

	public String getDirectory() {
		return directory;
	}

	@XmlElement(name = "Directory")
	public void setDirectory(String directory) {
		this.directory = directory;
	}
	
	public String getConntype() {
		return conntype;
	}

	@XmlElement(name = "Conntype")
	public void setConntype(String conntype) {
		this.conntype = conntype;
	}

}
