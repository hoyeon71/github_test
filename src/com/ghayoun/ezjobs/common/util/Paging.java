/***************************************************
 * @Version     : 
 * @Author      : 
 * @Create Data : 
 ****************************************************/
package com.ghayoun.ezjobs.common.util;

import java.io.*;
import java.util.*;

public class Paging implements Serializable{

	private int totalRowSize 	= 0;
	private int totalPageSize 	= 0;
	private int pageSize 		= 0;
	private int rowSize 		= 0;
	private int skipRowSize 	= 0; //((currentPage-1)*rowSize)+1 , for mssql
	private int currentPage 	= 0;
	private int prePage 		= 0;
	private int nextPage 		= 0;
	private int firstPage 		= 0;
	private int lastPage 		= 0;
	private int viewStartPage 	= 0;
	private int viewEndPage 	= 0;
	private int startRowNum 	= 0;
	private int endRowNum 		= 0;
	
	public Paging(int totalRowSize,int rowSize,int pageSize,String paramCurrentPage){
		this.setTotalRowSize(totalRowSize);
		this.setRowSize(rowSize);
		this.setPageSize(pageSize);
		
		if( paramCurrentPage != null && !paramCurrentPage.equals("") ){
			this.setCurrentPage( Integer.parseInt(paramCurrentPage) );
		}else{
			this.setCurrentPage(1);
		}
		
		this.setTotalPageSize(this.getTotalRowSize()/this.getRowSize());
		
		this.setSkipRowSize( ((this.getCurrentPage()-1)*this.getRowSize())+1 );
		this.setFirstPage(1);
		this.setLastPage(this.getTotalPageSize());
		this.setViewStartPage( ((this.getCurrentPage()/this.getPageSize())*this.getPageSize())+1 );
		this.setViewEndPage(this.getViewStartPage()+this.getPageSize()-1);
		
		this.setPrePage(this.getViewStartPage()-1);
		this.setNextPage(this.getViewEndPage()+1);
		
		this.setStartRowNum(this.getSkipRowSize());
		this.setEndRowNum(this.getStartRowNum()+this.getRowSize()-1);
		if( this.getEndRowNum()>this.getTotalRowSize() ) this.setEndRowNum(this.getTotalRowSize());
		
		this.setEndRowNum(endRowNum);
	}
	
	public int getTotalRowSize() {
		return totalRowSize;
	}
	public void setTotalRowSize(int totalRowSize) {
		this.totalRowSize = totalRowSize;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getRowSize() {
		return rowSize;
	}
	public void setRowSize(int rowSize) {
		this.rowSize = rowSize;
	}
	public int getSkipRowSize() {
		return skipRowSize;
	}
	public void setSkipRowSize(int skipRowSize) {
		this.skipRowSize = skipRowSize;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getPrePage() {
		return prePage;
	}
	public void setPrePage(int prePage) {
		this.prePage = prePage;
		if(prePage==0) this.prePage=1;
	}
	public int getNextPage() {
		return nextPage;
	}
	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
		if(nextPage>this.getLastPage()) this.nextPage = this.getLastPage();
	}
	public int getFirstPage() {
		return firstPage;
	}
	public void setFirstPage(int firstPage) {
		this.firstPage = firstPage;
	}
	public int getLastPage() {
		return lastPage;
	}
	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public int getTotalPageSize() {
		return totalPageSize;
	}
	public void setTotalPageSize(int totalPageSize) {
		this.totalPageSize = totalPageSize;
		if(this.getTotalRowSize() > (totalPageSize*this.getRowSize()) ) this.totalPageSize++;
	}

	public int getViewStartPage() {
		return viewStartPage;
	}

	public void setViewStartPage(int viewStartPage) {
		this.viewStartPage = viewStartPage;
		if( this.getCurrentPage()%this.getPageSize() == 0 ) this.viewStartPage -= this.getPageSize();
	}

	public int getViewEndPage() {
		return viewEndPage;
	}

	public void setViewEndPage(int viewEndPage) {
		this.viewEndPage = viewEndPage;
		if(viewEndPage>this.getTotalPageSize()) this.viewEndPage=this.getTotalPageSize();
	}

	public int getStartRowNum() {
		return startRowNum;
	}

	public void setStartRowNum(int startRowNum) {
		this.startRowNum = startRowNum;
	}

	public int getEndRowNum() {
		return endRowNum;
	}

	public void setEndRowNum(int endRowNum) {
		this.endRowNum = endRowNum;
	}
}
