package com.ghayoun.ezjobs.common.util;

import java.util.Locale;
import javax.servlet.ServletContext;
import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.MessageSource;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class MessageUtil
{
	private static MessageUtil message = new MessageUtil();
	protected static WebApplicationContext webApplicationContext;
	private static ApplicationContext applicationContext;
	private MessageSource messageSource;

	protected MessageUtil()
    {
    }

    public MessageSource getMessageSource()
    {
        return messageSource;
    }

    public void setMessageSource(MessageSource megsrc)
    {
        messageSource = megsrc;
    }

    protected static void initialize(ServletContext sctx)
        throws Exception
    {
        webApplicationContext = WebApplicationContextUtils.getWebApplicationContext(sctx);
        message.setMessageSource((MessageSource)webApplicationContext.getBean("messageSource"));
    }

    public static final void distory(ServletContext servletcontext)
        throws Exception
    {
    }

    public static final Object getBean(String beanName)
    {
        if(webApplicationContext == null)
        {
            if(applicationContext != null)
                return applicationContext.getBean(beanName);
            else
                return null;
        } else
        {
            return webApplicationContext.getBean(beanName);
        }
    }

    public static final String getMessage(String code, Object args[], Locale locale)
    {
        return message.getMessageSource().getMessage(code, args, locale);
    }

    public static final String getMessage(String code, Object args[], String defaultMessage, Locale locale)
    {
        return message.getMessageSource().getMessage(code, args, defaultMessage, locale);
    }

    public static final WebApplicationContext getWebApplicationContext()
    {
        return webApplicationContext;
    }

    public static final void setWebApplicationContext(WebApplicationContext webApplicationContext)
    {
        webApplicationContext = webApplicationContext;
    }

    public static final ApplicationContext getApplicationContext()
    {
        return applicationContext;
    }

    public static final void setApplicationContext(ApplicationContext applicationContext)
    {
        applicationContext = applicationContext;
    }

    public static final String getRealPath(String resource)
    {
        return webApplicationContext.getServletContext().getRealPath(resource);
    }

    public static final MessageUtil getInstance()
    {
        return message;
    }


}
