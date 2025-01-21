package com.ghayoun.ezjobs.common.util;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;
import org.springframework.beans.factory.config.PropertyResourceConfigurer;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

public class BaseController extends MultiActionController {
	protected final Logger logger = Logger.getLogger(getClass());

	protected PropertyPlaceholderConfigurer props  = null;
	protected PropertyResourceConfigurer propss = null;

	public BaseController() {
		super();
	}

}
