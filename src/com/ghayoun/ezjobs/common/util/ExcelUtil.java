package com.ghayoun.ezjobs.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


public class ExcelUtil {
	
	public ArrayList getExcelRead(String directory, String fileName) {
		
		ArrayList al = new ArrayList();
		
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(directory + File.separator + fileName);
			if(!fileName.contains(".xlsx")) {
				POIFSFileSystem fs = new POIFSFileSystem(fis);
				HSSFWorkbook wb = new HSSFWorkbook(fs);
				HSSFSheet sheet = wb.getSheetAt(0); //시트 가져오기
				
				int rows = sheet.getPhysicalNumberOfRows(); //행 개수 가져오기
				
				for(int i=0; i<rows; i++) {
					HSSFRow row = sheet.getRow(i); //row 가져오기
					if(row!=null) {
						//int cells = row.getPhysicalNumberOfCells(); //cell 개수 가져오기
						//short firstCell = row.getFirstCellNum();
						short lastCell = row.getLastCellNum();
						String[] array = new String[lastCell];
						for(short j=0; j<lastCell; j++) {
							HSSFCell cell = row.getCell(j); // cell 가져오기
							
							String value = "";
							if(cell != null) {
								switch(cell.getCellType()) {
									case HSSFCell.CELL_TYPE_FORMULA:
										value = cell.getCellFormula();
										break;
									case HSSFCell.CELL_TYPE_NUMERIC:
										value = String.valueOf((int)cell.getNumericCellValue());
										break;
									case HSSFCell.CELL_TYPE_STRING:
										value = cell.getStringCellValue();
										break;
									case HSSFCell.CELL_TYPE_BOOLEAN:
										value = String.valueOf(cell.getBooleanCellValue());
										break;
									case HSSFCell.CELL_TYPE_BLANK:
										value = "";
										break;
									case HSSFCell.CELL_TYPE_ERROR:
										value = String.valueOf(cell.getErrorCellValue());
										break;
									default:
								}
							}
							array[j] = value.trim();
						}
						al.add(array);
					}
				}
			} else {
				XSSFWorkbook wb = new XSSFWorkbook(fis);
				XSSFSheet sheet = wb.getSheetAt(0); //시트 가져오기
				
				int rows = sheet.getPhysicalNumberOfRows(); //행 개수 가져오기
				
				for(int i=0; i<rows; i++) {
					XSSFRow row = sheet.getRow(i); //row 가져오기
					if(row!=null) {
						//int cells = row.getPhysicalNumberOfCells(); //cell 개수 가져오기
						//short firstCell = row.getFirstCellNum();
						short lastCell = row.getLastCellNum();
						String[] array = new String[lastCell];
						for(short j=0; j<lastCell; j++) {
							XSSFCell cell = row.getCell(j); // cell 가져오기
							
							String value = "";
							if(cell != null) {
								switch(cell.getCellType()) {
									case XSSFCell.CELL_TYPE_FORMULA:
										value = cell.getCellFormula();
										break;
									case XSSFCell.CELL_TYPE_NUMERIC:
										value = String.valueOf((int)cell.getNumericCellValue());
										break;
									case XSSFCell.CELL_TYPE_STRING:
										value = cell.getStringCellValue();
										break;
									case XSSFCell.CELL_TYPE_BOOLEAN:
										value = String.valueOf(cell.getBooleanCellValue());
										break;
									case XSSFCell.CELL_TYPE_BLANK:
										value = "";
										break;
									case XSSFCell.CELL_TYPE_ERROR:
										value = String.valueOf(cell.getErrorCellValue());
										break;
									default:
								}
							}
							array[j] = value.trim();
						}
						al.add(array);
					}
				}
			}
			
			//int sheetNum = wb.getNumberOfSheets(); //시트개수 가져오기
			
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if( null != fis ){ try{ fis.close();fis=null;}catch(Exception e){} };
		}
		
		return al;
	}
	
	/**
	 * 엑셀다운로드 기능<br>
	 * 시트 데이터(sheetInfoList-dataList)는 엑셀에 출력될 내용만 담아야함.
	 * @param res
	 * @param fileName 파일명
	 * @param sheetInfoList 출력할정보목록()
	 * @throws IOException
	 */
	@SuppressWarnings("unchecked")
	public static void downloadExcel(HttpServletResponse res, String fileName, List<ExcelFormat> sheetInfoList) throws IOException {
		HSSFWorkbook workbook = new HSSFWorkbook();
		
		int sheetSize = sheetInfoList.size();
		if (sheetSize < 1) {
			System.out.println("출력할 엑셀 정보 없음.");
			return;
		}
		
		Sheet sheet = null;
		for (int i = 0; i < sheetSize; i++) {
			ExcelFormat sheetInfo = sheetInfoList.get(i);
			//시트 정보
			String sheetName = CommonUtil.isNull(sheetInfo.getSheetName(), fileName);
			Map<String, Object> search = (Map<String, Object>) sheetInfo.getSearch();
			String[] header = (String[]) sheetInfo.getColumnHeaders();;
			List<Map<Integer, Object>> dataList = (List<Map<Integer, Object>>) sheetInfo.getDataList();
			
			//새 시트 생성
			sheet = workbook.createSheet(sheetName);
			
			int lastColIndex = header.length-1; //열 갯수
			//시트명 생성
			if (!sheetName.equals("")) setSheetName(sheet, sheetName, lastColIndex);
			//검색조건 생성
			if (search != null) setSearch(sheet, search, lastColIndex);
			//컬럼헤더 생성
			if (header.length > 0) setColumnHeader(sheet, header);
			//데이터 생성
			if (dataList.size() > 0 ) setData(sheet, dataList);
			
			//width 자동설정
			autoSizeColumn(sheet, lastColIndex);
		}
		
		res.setCharacterEncoding("UTF-8");
		res.setContentType("application/vnd.ms-xls; charset=UTF-8");
		res.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(fileName+".xls", "UTF-8") + ";");
		
		ServletOutputStream out = res.getOutputStream();
		workbook.write(out);
		out.flush();
		out.close();
	}
	
	@SuppressWarnings("deprecation")
	private static void setSheetName(Sheet sheet, String sheetName, int lastColIndex) {
		HSSFCellStyle style = (HSSFCellStyle) sheet.getWorkbook().createCellStyle();
		style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setWrapText(true);
		
		Row titleRow = sheet.createRow(0);
		for (int i = 0; i < lastColIndex + 1; i++) { //FIXME - 셀병합시 스타일이 원하는대로 적용되지 않음. 추후 방법 발견시 수정 요망.
			String value = "";
			if (i == 0)
				value = sheetName;
			setCellValue(titleRow, i, value, style);
		}
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, lastColIndex));
	}
	
	@SuppressWarnings("deprecation")
	private static void setSearch(Sheet sheet, Map<String, Object> search, int lastColIndex) {
		HSSFCellStyle style = (HSSFCellStyle) sheet.getWorkbook().createCellStyle();
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		style.setWrapText(true);
		HSSFCellStyle styleG = (HSSFCellStyle) sheet.getWorkbook().createCellStyle();
		styleG.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		styleG.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		styleG.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		styleG.setBorderTop(HSSFCellStyle.BORDER_THIN);
		styleG.setBorderRight(HSSFCellStyle.BORDER_THIN);
		styleG.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		styleG.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		styleG.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		styleG.setWrapText(true);
		
		int rowIndex = sheet.getLastRowNum() + 1;
		Row searchRow = null;
		for (String key : search.keySet()) {
			int colIndex = 0;
			searchRow = sheet.createRow(rowIndex);
			setCellValue(searchRow, colIndex++, key, styleG);
			setCellValue(searchRow, colIndex++, CommonUtil.isNull(search.get(key), "전체"), style);
			while (colIndex < lastColIndex + 1) { //FIXME - 셀병합시 스타일이 원하는대로 적용되지 않음. 추후 방법 발견시 수정 요망.
				setCellValue(searchRow, colIndex++, "", style);
			}
			
			sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex, 1, lastColIndex));
			rowIndex++;
		}
		sheet.createRow(rowIndex); //공백 한줄
	}
	
	private static void setColumnHeader(Sheet sheet, String[] header) {
		HSSFCellStyle style = (HSSFCellStyle) sheet.getWorkbook().createCellStyle();
		style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setWrapText(true);
		
		Row headerRow = sheet.createRow(sheet.getLastRowNum()+1);
		for (int i = 0; i < header.length; i++) {
			setCellValue(headerRow, i, header[i], style);
		}
	}
	
	private static void setData(Sheet sheet, List<Map<Integer, Object>> dataList) {
		HSSFCellStyle style = (HSSFCellStyle) sheet.getWorkbook().createCellStyle();
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setWrapText(true);
		
		int rowIndex = sheet.getLastRowNum()+1;
		int lastColIndex = dataList.get(0).size(); //열 갯수는 데이터에 관계없이 동일
		Row cellRow = null;
		for (int i = 0; i < dataList.size(); i++) {
			cellRow = sheet.createRow(rowIndex); //개행

			Map<Integer, Object> data = dataList.get(i);
			String value = "";
			for (int j = 0; j < lastColIndex + 1; j++) {
				if (j == 0) { //첫번째 컬럼은 행번호
					value = i+1+"";
				} else {
					value = (String) data.get(j-1);
				}
				
				setCellValue(cellRow, j, value, style);
			}
			rowIndex++;
		}
	}
	
	private static void setCellValue(Row row, int col, String value, HSSFCellStyle style) {
		Sheet sheet = row.getSheet();
		
		Cell cell = row.createCell(col);
		cell.setCellValue(value);
		cell.setCellStyle(style);
	}
	
	private static void autoSizeColumn(Sheet sheet, int lastColIndex) {
		for (int col = 0; col < lastColIndex + 1; col++) {
			sheet.autoSizeColumn(col);
			sheet.setColumnWidth(col, Math.min(255*256, sheet.getColumnWidth(col)+512)); // setColumnWidth의 설정값이 255*256(최대값)을 넘어가면 오류가 발생됨
		}
	}
}
