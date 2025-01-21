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
 * <p>Java class for request_def_delete_jobs_type complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="request_def_delete_jobs_type">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="user_token" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="folder" type="{http://www.bmc.com/ctmem/schema900}any_folder_type"/>
 *         &lt;element name="delete_jobs_criterion" type="{http://www.bmc.com/ctmem/schema900}criterion_type"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "request_def_delete_jobs_type", propOrder = {
    "userToken",
    "folder",
    "deleteJobsCriterion"
})

@XmlRootElement(name = "request_def_delete_jobs", namespace = "http://www.bmc.com/ctmem/schema900")
public class RequestDefDeleteJobsType {

    @XmlElement(name = "user_token", required = true)
    protected String userToken;
    @XmlElement(required = true)
    protected AnyFolderType folder;
    @XmlElement(name = "delete_jobs_criterion", required = true)
    protected CriterionType deleteJobsCriterion;

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
     * Gets the value of the folder property.
     * 
     * @return
     *     possible object is
     *     {@link AnyFolderType }
     *     
     */
    public AnyFolderType getFolder() {
        return folder;
    }

    /**
     * Sets the value of the folder property.
     * 
     * @param value
     *     allowed object is
     *     {@link AnyFolderType }
     *     
     */
    public void setFolder(AnyFolderType value) {
        this.folder = value;
    }

    /**
     * Gets the value of the deleteJobsCriterion property.
     * 
     * @return
     *     possible object is
     *     {@link CriterionType }
     *     
     */
    public CriterionType getDeleteJobsCriterion() {
        return deleteJobsCriterion;
    }

    /**
     * Sets the value of the deleteJobsCriterion property.
     * 
     * @param value
     *     allowed object is
     *     {@link CriterionType }
     *     
     */
    public void setDeleteJobsCriterion(CriterionType value) {
        this.deleteJobsCriterion = value;
    }

}
