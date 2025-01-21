package com.ghayoun.ezjobs.common.util;

import java.io.*;
import java.util.*;

public class DefaultServiceException extends Exception
{
	private Map rMap = null;
	
	public DefaultServiceException(Map map){
		rMap = map;
	}
	
	public Map getResultMap(){
		return rMap;
	}
	
}