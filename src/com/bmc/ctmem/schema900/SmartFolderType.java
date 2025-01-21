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
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for smart_folder_type complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="smart_folder_type">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;group ref="{http://www.bmc.com/ctmem/schema900}general_folder_attributes_type"/>
 *         &lt;element name="folder_attributes" type="{http://www.bmc.com/ctmem/schema900}smart_folder_attributes_type"/>
 *         &lt;element name="sub_folders" type="{http://www.bmc.com/ctmem/schema900}sub_folders_type" minOccurs="0"/>
 *         &lt;element name="jobs" type="{http://www.bmc.com/ctmem/schema900}def_jobs_type" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "smart_folder_type", propOrder = {
    "controlM",
    "folderName",
    "folderLibrary",
    "orderMethod",
    "folderAttributes",
    "subFolders",
    "jobs"
})
public class SmartFolderType {

    @XmlElement(name = "control_m", required = true)
    protected String controlM;
    @XmlElement(name = "folder_name", required = true)
    protected String folderName;
    @XmlElement(name = "folder_library")
    protected String folderLibrary;
    @XmlElement(name = "order_method")
    protected String orderMethod;
    @XmlElement(name = "folder_attributes", required = true)
    protected SmartFolderAttributesType folderAttributes;
    @XmlElement(name = "sub_folders")
    protected SubFoldersType subFolders;
    protected DefJobsType jobs;

    /**
     * Gets the value of the controlM property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getControlM() {
        return controlM;
    }

    /**
     * Sets the value of the controlM property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setControlM(String value) {
        this.controlM = value;
    }

    /**
     * Gets the value of the folderName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFolderName() {
        return folderName;
    }

    /**
     * Sets the value of the folderName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFolderName(String value) {
        this.folderName = value;
    }

    /**
     * Gets the value of the folderLibrary property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFolderLibrary() {
        return folderLibrary;
    }

    /**
     * Sets the value of the folderLibrary property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFolderLibrary(String value) {
        this.folderLibrary = value;
    }

    /**
     * Gets the value of the orderMethod property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOrderMethod() {
        return orderMethod;
    }

    /**
     * Sets the value of the orderMethod property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOrderMethod(String value) {
        this.orderMethod = value;
    }

    /**
     * Gets the value of the folderAttributes property.
     * 
     * @return
     *     possible object is
     *     {@link SmartFolderAttributesType }
     *     
     */
    public SmartFolderAttributesType getFolderAttributes() {
        return folderAttributes;
    }

    /**
     * Sets the value of the folderAttributes property.
     * 
     * @param value
     *     allowed object is
     *     {@link SmartFolderAttributesType }
     *     
     */
    public void setFolderAttributes(SmartFolderAttributesType value) {
        this.folderAttributes = value;
    }

    /**
     * Gets the value of the subFolders property.
     * 
     * @return
     *     possible object is
     *     {@link SubFoldersType }
     *     
     */
    public SubFoldersType getSubFolders() {
        return subFolders;
    }

    /**
     * Sets the value of the subFolders property.
     * 
     * @param value
     *     allowed object is
     *     {@link SubFoldersType }
     *     
     */
    public void setSubFolders(SubFoldersType value) {
        this.subFolders = value;
    }

    /**
     * Gets the value of the jobs property.
     * 
     * @return
     *     possible object is
     *     {@link DefJobsType }
     *     
     */
    public DefJobsType getJobs() {
        return jobs;
    }

    /**
     * Sets the value of the jobs property.
     * 
     * @param value
     *     allowed object is
     *     {@link DefJobsType }
     *     
     */
    public void setJobs(DefJobsType value) {
        this.jobs = value;
    }

}
