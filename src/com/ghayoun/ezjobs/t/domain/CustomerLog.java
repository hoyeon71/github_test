package com.ghayoun.ezjobs.t.domain;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

@XmlRootElement(name = "CustomerLog")
public class CustomerLog {
    private List<CustomerLogEntry> customerLogEntries;

    @XmlElement(name = "CustomerLogEntry")
    public List<CustomerLogEntry> getCustomerLogEntries() {
        return customerLogEntries;
    }

    public void setCustomerLogEntries(List<CustomerLogEntry> customerLogEntries) {
        this.customerLogEntries = customerLogEntries;
    }
}


