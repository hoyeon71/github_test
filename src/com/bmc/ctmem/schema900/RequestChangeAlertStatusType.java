//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.4-2 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2017.02.10 at 03:50:52 PM KST 
//


package com.bmc.ctmem.schema900;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for request_change_alert_status_type complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="request_change_alert_status_type">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="user_token" type="{http://www.bmc.com/ctmem/schema900}user_token_type"/>
 *         &lt;element name="alert_id" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="status" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "request_change_alert_status_type", propOrder = {
    "userToken",
    "alertId",
    "status"
})

@XmlRootElement(name = "request_change_alert_status", namespace = "http://www.bmc.com/ctmem/schema900")
public class RequestChangeAlertStatusType {

    @XmlElement(name = "user_token", required = true)
    protected String userToken;
    @XmlElement(name = "alert_id", required = true)
    protected String alertId;
    @XmlElement(required = true)
    protected String status;

    /**
     * Gets the value of the userToken property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUserToken() {
        return userToken;
    }

    /**
     * Sets the value of the userToken property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUserToken(String value) {
        this.userToken = value;
    }

    /**
     * Gets the value of the alertId property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAlertId() {
        return alertId;
    }

    /**
     * Sets the value of the alertId property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAlertId(String value) {
        this.alertId = value;
    }

    /**
     * Gets the value of the status property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getStatus() {
        return status;
    }

    /**
     * Sets the value of the status property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setStatus(String value) {
        this.status = value;
    }

}
