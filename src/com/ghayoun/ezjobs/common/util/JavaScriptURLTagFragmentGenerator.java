package com.ghayoun.ezjobs.common.util;

import org.jfree.chart.imagemap.*;

// Referenced classes of package org.jfree.chart.imagemap:
//            URLTagFragmentGenerator

public class JavaScriptURLTagFragmentGenerator
    implements URLTagFragmentGenerator
{

    public JavaScriptURLTagFragmentGenerator()
    {
    }

    public String generateURLFragment(String onclickText)
    {
    	return " href=\"#\" onclick=\"" + onclickText + "; return false\""; 
   }
}
