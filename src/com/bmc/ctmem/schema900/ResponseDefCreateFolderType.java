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
 * <p>Java class for response_def_create_folder_type complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="response_def_create_folder_type">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;group ref="{http://www.bmc.com/ctmem/schema900}general_folder_attributes_type"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "response_def_create_folder_type", propOrder = {
    "controlM",
    "folderName",
    "folderLibrary",
    "orderMethod"
})

@XmlRootElement(name = "response_def_create_folder", namespace = "http://www.bmc.com/ctmem/schema900")
public class ResponseDefCreateFolderType {

    @XmlElement(name = "control_m", required = true)
    protected String controlM;
    @XmlElement(name = "folder_name", required = true)
    protected String folderName;
    @XmlElement(name = "folder_library")
    protected String folderLibrary;
    @XmlElement(name = "order_method")
    protected String orderMethod;

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

}
