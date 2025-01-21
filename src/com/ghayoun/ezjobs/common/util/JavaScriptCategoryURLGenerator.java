package com.ghayoun.ezjobs.common.util;

import java.io.Serializable;
import org.jfree.chart.*;
import org.jfree.chart.title.*;
import org.jfree.chart.plot.*;
import org.jfree.chart.axis.*;
import org.jfree.chart.renderer.category.*;
import org.jfree.chart.labels.*;
import org.jfree.chart.entity.*;
import org.jfree.data.category.*;
import org.jfree.ui.*;
import org.jfree.chart.urls.*;
import org.jfree.chart.imagemap.*;
import org.jfree.util.*;

public class JavaScriptCategoryURLGenerator
				implements CategoryURLGenerator, Cloneable, Serializable
{

    public JavaScriptCategoryURLGenerator()
    {
        prefix = "index.html";
        seriesParameterName = "series";
        categoryParameterName = "category";
    }

    public JavaScriptCategoryURLGenerator(String prefix)
    {
    	this.prefix = "index.html";
        seriesParameterName = "series";
        categoryParameterName = "category";
        if(prefix == null)
        {
            throw new IllegalArgumentException("Null 'prefix' argument.");
        } else
        {
            this.prefix = prefix;
            return;
        }
    }

    public JavaScriptCategoryURLGenerator(String prefix, String seriesParameterName, String categoryParameterName)
    {
        this.prefix = "index.html";
        this.seriesParameterName = "series";
        this.categoryParameterName = "category";
        if(prefix == null)
            throw new IllegalArgumentException("Null 'prefix' argument.");
        if(seriesParameterName == null)
            throw new IllegalArgumentException("Null 'seriesParameterName' argument.");
        if(categoryParameterName == null)
        {
            throw new IllegalArgumentException("Null 'categoryParameterName' argument.");
        } else
        {
            this.prefix = prefix;
            this.seriesParameterName = seriesParameterName;
            this.categoryParameterName = categoryParameterName;
            return;
        }
    }

    public String generateURL(CategoryDataset dataset, int series, int category)
    {
    	String url = this.prefix; 
        Comparable seriesKey = dataset.getRowKey(series); 
        Comparable categoryKey = dataset.getColumnKey(category); 

        url += "( {" + this.seriesParameterName + ": " 
            + "'" + seriesKey.toString() + "', "; 

        url += this.categoryParameterName + ": " 
            + "'" + categoryKey.toString() + "' } )"; 
        return url;
    }

    public Object clone()
        throws CloneNotSupportedException
    {
        return super.clone();
    }

    public boolean equals(Object obj)
    {
        if(obj == this)
            return true;
        if(!(obj instanceof StandardCategoryURLGenerator))
            return false;
        JavaScriptCategoryURLGenerator that = (JavaScriptCategoryURLGenerator)obj;
        if(!ObjectUtilities.equal(prefix, that.prefix))
            return false;
        if(!ObjectUtilities.equal(seriesParameterName, that.seriesParameterName))
            return false;
        return ObjectUtilities.equal(categoryParameterName, that.categoryParameterName);
    }

    public int hashCode()
    {
        int result = prefix == null ? 0 : prefix.hashCode();
        result = 29 * result + (seriesParameterName == null ? 0 : seriesParameterName.hashCode());
        result = 29 * result + (categoryParameterName == null ? 0 : categoryParameterName.hashCode());
        return result;
    }

    private static final long serialVersionUID = 0x1f9859882f022d75L;
    private String prefix;
    private String seriesParameterName;
    private String categoryParameterName;
}
