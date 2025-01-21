package com.ghayoun.ezjobs.t.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlElement;

public class Account implements Comparable<Account> {
	private String accountName;
	private Host host1;
	private Host host2;

//	private List<Host> hostList1 = new ArrayList<>();
//	private List<Host> hostList2 = new ArrayList<>();

	public String getAccountName() {
		return accountName;
	}

	@XmlElement(name = "AccountName")
	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public Host getHost1() {
		return host1;
	}
	@XmlElement(name = "Host1")
	public void setHost1(Host host1) {
		this.host1 = host1;
	}

	public Host getHost2() {
		return host2;
	}
	@XmlElement(name = "Host2")
	public void setHost2(Host host2) {
		this.host2 = host2;
	}

	@Override
	public int compareTo(Account o) {
		String value1 = this.accountName;
		String value2 = o.accountName;
		if(value1.compareTo(value2) > 0) {
			return 1;
		} else if(value1.compareTo(value2) < 0) {
			return -1;
		} else {
			return 0;
		}
	}
	

	
//	@XmlElement(name = "Host1")
//	public void setHostList1(List<Host> hostList1) {
//		this.hostList1 = hostList1;
//	}
//
//	public List<Host> getHostList1() {
//		return hostList1;
//	}
//
//	@XmlElement(name = "Host2")
//	public void setHostList2(List<Host> hostList2) {
//		this.hostList2 = hostList2;
//	}
//
//	public List<Host> getHostList2() {
//		return hostList2;
//	}

}

