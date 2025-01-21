package com.ghayoun.ezjobs.t.domain;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name="Accounts")
public class Accounts {
	private List<Account> accountList = new ArrayList<>();;
	
	@XmlElement(name="Account")
	public void setAccountList(List<Account> accountList) {
		this.accountList = accountList;
	}
	
	public List<Account> getAccountList() {
		return accountList;
	}
}



