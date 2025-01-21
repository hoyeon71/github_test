package com.ghayoun.ezjobs.common.util;

import javax.servlet.ServletContextEvent;

import org.springframework.web.context.ContextLoaderListener;

import com.ghayoun.ezjobs.common.util.MessageUtil;

public class CommonContextLoader extends ContextLoaderListener {

    public void contextDestroyed(ServletContextEvent sce) {
        try {
        	MessageUtil.distory(sce.getServletContext());
        } catch (Throwable t) {
            throw new RuntimeException(t);
        }
    }
    public void contextInitialized(ServletContextEvent sce) {
        try {
        	super.contextInitialized(sce);
        	MessageUtil.initialize(sce.getServletContext());
        } catch (Throwable t) {
            throw new RuntimeException(t);
        }
    }
}
