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
 * <p>Java class for request_poll_type complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="request_poll_type">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="user_token" type="{http://www.bmc.com/ctmem/schema900}user_token_type"/>
 *         &lt;element name="response_token" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "request_poll_type", propOrder = {
    "userToken",
    "responseToken"
})

@XmlRootElement(name = "request_poll", namespace = "http://www.bmc.com/ctmem/schema900")
public class RequestPollType {

    @XmlElement(name = "user_token", required = true)
    protected String userToken;
    @XmlElement(name = "response_token", required = true)
    protected String responseToken;

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
     * Gets the value of the responseToken property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getResponseToken() {
        return responseToken;
    }

    /**
     * Sets the value of the responseToken property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setResponseToken(String value) {
        this.responseToken = value;
    }

}
