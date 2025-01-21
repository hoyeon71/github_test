package com.ghayoun.ezjobs.common.util;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public class ExcelFormat implements Serializable {
	String sheetName;
	String[] columnHeaders;
	Map<String, Object> search;
	List<Map<Integer, Object>> dataList;
	
	public String getSheetName() {
		return sheetName;
	}
	public void setSheetName(String sheetName) {
		this.sheetName = sheetName;
	}
	public String[] getColumnHeaders() {
		return columnHeaders;
	}
	public void setColumnHeaders(String[] columnHeaders) {
		this.columnHeaders = columnHeaders;
	}
	public Map<String, Object> getSearch() {
		return search;
	}
	public void setSearch(Map<String, Object> search) {
		this.search = search;
	}
	public List<Map<Integer, Object>> getDataList() {
		return dataList;
	}
	public void setDataList(List<Map<Integer, Object>> dataList) {
		this.dataList = dataList;
	}
}
