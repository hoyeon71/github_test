//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.4-2 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2017.02.10 at 03:50:52 PM KST 
//


package com.bmc.ctmem.schema900;

import javax.xml.bind.annotation.XmlEnum;
import javax.xml.bind.annotation.XmlEnumValue;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for sac4job_option_type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p>
 * <pre>
 * &lt;simpleType name="sac4job_option_type">
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *     &lt;enumeration value="blank"/>
 *     &lt;enumeration value="next"/>
 *     &lt;enumeration value="previous"/>
 *   &lt;/restriction>
 * &lt;/simpleType>
 * </pre>
 * 
 */
@XmlType(name = "sac4job_option_type")
@XmlEnum
public enum Sac4JobOptionType {

    @XmlEnumValue("blank")
    BLANK("blank"),
    @XmlEnumValue("next")
    NEXT("next"),
    @XmlEnumValue("previous")
    PREVIOUS("previous");
    private final String value;

    Sac4JobOptionType(String v) {
        value = v;
    }

    public String value() {
        return value;
    }

    public static Sac4JobOptionType fromValue(String v) {
        for (Sac4JobOptionType c: Sac4JobOptionType.values()) {
            if (c.value.equals(v)) {
                return c;
            }
        }
        throw new IllegalArgumentException(v);
    }

}
