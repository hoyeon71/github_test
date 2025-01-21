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
 * <p>Java class for do_ifrerun_type complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="do_ifrerun_type">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="confirm" type="{http://www.bmc.com/ctmem/schema900}yes_no_type"/>
 *         &lt;element name="from_program_step" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="to_program_step" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="from_procedure_step" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="to_procedure_step" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "do_ifrerun_type", propOrder = {
    "confirm",
    "fromProgramStep",
    "toProgramStep",
    "fromProcedureStep",
    "toProcedureStep"
})
public class DoIfrerunType {

    @XmlElement(required = true)
    protected YesNoType confirm;
    @XmlElement(name = "from_program_step")
    protected String fromProgramStep;
    @XmlElement(name = "to_program_step")
    protected String toProgramStep;
    @XmlElement(name = "from_procedure_step")
    protected String fromProcedureStep;
    @XmlElement(name = "to_procedure_step")
    protected String toProcedureStep;

    /**
     * Gets the value of the confirm property.
     * 
     * @return
     *     possible object is
     *     {@link YesNoType }
     *     
     */
    public YesNoType getConfirm() {
        return confirm;
    }

    /**
     * Sets the value of the confirm property.
     * 
     * @param value
     *     allowed object is
     *     {@link YesNoType }
     *     
     */
    public void setConfirm(YesNoType value) {
        this.confirm = value;
    }

    /**
     * Gets the value of the fromProgramStep property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFromProgramStep() {
        return fromProgramStep;
    }

    /**
     * Sets the value of the fromProgramStep property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFromProgramStep(String value) {
        this.fromProgramStep = value;
    }

    /**
     * Gets the value of the toProgramStep property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getToProgramStep() {
        return toProgramStep;
    }

    /**
     * Sets the value of the toProgramStep property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setToProgramStep(String value) {
        this.toProgramStep = value;
    }

    /**
     * Gets the value of the fromProcedureStep property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFromProcedureStep() {
        return fromProcedureStep;
    }

    /**
     * Sets the value of the fromProcedureStep property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFromProcedureStep(String value) {
        this.fromProcedureStep = value;
    }

    /**
     * Gets the value of the toProcedureStep property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getToProcedureStep() {
        return toProcedureStep;
    }

    /**
     * Sets the value of the toProcedureStep property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setToProcedureStep(String value) {
        this.toProcedureStep = value;
    }

}
