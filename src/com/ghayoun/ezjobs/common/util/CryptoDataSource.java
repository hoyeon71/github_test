package com.ghayoun.ezjobs.common.util;

import org.apache.commons.dbcp.BasicDataSource;

import java.sql.SQLException;

public class CryptoDataSource extends BasicDataSource {
 
    @Override
    public void setPassword(String password) {
    	try {
			super.setPassword(SeedUtil.decodeStr(password));
    		//super.setPassword(password);
		} catch (Exception e) {
			e.printStackTrace();
		} 
    }

	@Override
	public <T> T unwrap(Class<T> iface) throws SQLException {
		return null;
	}

	@Override
	public boolean isWrapperFor(Class<?> iface) throws SQLException {
		return false;
	}
}



