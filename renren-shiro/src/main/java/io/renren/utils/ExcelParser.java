package io.renren.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFPictureData;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import io.renren.entity.SysExpertEntity;

public class ExcelParser {
    
    private static final Logger logger = Logger.getLogger(ExcelParser.class);

    public static final SysExpertEntity expertParserXlsx(String filePath) throws InvalidFormatException, IOException {
        logger.info(">>>>解析专家excel,filePath=" + filePath);
        SysExpertEntity result = new SysExpertEntity();
        File file = new File(filePath);

        XSSFWorkbook xssfWorkbook = new XSSFWorkbook(file);
        XSSFSheet xssfSheet = xssfWorkbook.getSheetAt(0);

        String name = xssfSheet.getRow(2).getCell(1).getStringCellValue();
        result.setName(name);
        String idnum = xssfSheet.getRow(3).getCell(1).getStringCellValue();
        result.setIdnum(idnum);
        if(StringUtils.isBlank(name) && StringUtils.isBlank(idnum)) {
            return null;
        }
        String gender = xssfSheet.getRow(2).getCell(4).getStringCellValue();
        if("男".equals(gender)) {
            gender = "1";
        } else if("女".equals(gender)) {
            gender = "0";
        }
        result.setGender(gender);
        String nation = xssfSheet.getRow(2).getCell(7).getStringCellValue();
        result.setNation(nation);
        String party = xssfSheet.getRow(2).getCell(12).getStringCellValue();
        result.setParty(party);
        XSSFCell birthCell = xssfSheet.getRow(3).getCell(12);
        String birth = "";
        if(HSSFDateUtil.isCellDateFormatted(birthCell)) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            birth = sdf.format(HSSFDateUtil.getJavaDate(birthCell.getNumericCellValue()));
        }
        result.setBirth(birth);
        String highestedu = xssfSheet.getRow(4).getCell(1).getStringCellValue();
        result.setHighestedu(highestedu);
        String graduateschool = xssfSheet.getRow(4).getCell(4).getStringCellValue();
        result.setGraduateschool(graduateschool);
        String major1 = xssfSheet.getRow(5).getCell(1).getStringCellValue();
        result.setMajor1(major1);
        String major2 = xssfSheet.getRow(5).getCell(7).getStringCellValue();
        result.setMajor2(major2);
        String unitproperty = xssfSheet.getRow(6).getCell(1).getStringCellValue();
        result.setUnitproperty(unitproperty);
        String isacademician = xssfSheet.getRow(6).getCell(13).getStringCellValue();
        result.setIsacademician(isacademician);
        String experttitle = xssfSheet.getRow(8).getCell(1).getStringCellValue();
        result.setExperttitle(experttitle);
        String expertjob = xssfSheet.getRow(8).getCell(7).getStringCellValue();
        result.setExpertjob(expertjob);
        String onduty = xssfSheet.getRow(8).getCell(13).getStringCellValue();
        if("在职".equals(onduty)) {
            onduty = "1";
        } else if("退休".equals(onduty)) {
            onduty = "0";
        }
        result.setOnduty(onduty);
        String mobile = xssfSheet.getRow(9).getCell(1).getStringCellValue();
        result.setMobile(mobile);
        String fax = xssfSheet.getRow(9).getCell(7).getStringCellValue();
        result.setFax(fax);
        String email = xssfSheet.getRow(9).getCell(13).getStringCellValue();
        result.setEmail(email);
        String address = xssfSheet.getRow(10).getCell(1).getStringCellValue() + xssfSheet.getRow(10).getCell(2).getStringCellValue();
        result.setAddress(address);
        String postcode = xssfSheet.getRow(10).getCell(13).getStringCellValue();
        result.setPostcode(postcode);
        String researchfield = xssfSheet.getRow(11).getCell(1).getStringCellValue();
        result.setResearchfield(researchfield);
        String researchdirection = xssfSheet.getRow(11).getCell(11).getStringCellValue();
        result.setResearchdirection(researchdirection);
        String language = xssfSheet.getRow(12).getCell(1).getStringCellValue();
        result.setLanguage(language);
        String proficiency = xssfSheet.getRow(12).getCell(11).getStringCellValue();
        result.setProficiency(proficiency);
        String resume = xssfSheet.getRow(13).getCell(1).getStringCellValue();
        result.setResume(resume);
        String recommendunit = xssfSheet.getRow(17).getCell(1).getStringCellValue();
        result.setRecommendunit(recommendunit);
        String workunit = xssfSheet.getRow(17).getCell(12).getStringCellValue();
        result.setWorkunit(workunit);
        String remark = xssfSheet.getRow(20).getCell(1).getStringCellValue();
        result.setRemark(remark);
        logger.info("解析专家数据结束,expert=" + result.toString());
        return result;
    }
    
    /**
     * 读取并保存专家图片
     * @param filePath
     * @return
     * @throws IOException 
     * @throws InvalidFormatException 
     */
    public static final void expertParserXlsxPhoto(String filePath,String expertId, String photoStorage) throws InvalidFormatException, IOException {
        logger.info(">>>>读取excel中的图片并保存,excelPath=" + filePath + ",expertId=" + expertId +",photoStorage=" + photoStorage);
        File file = new File(filePath);
        XSSFWorkbook xssfWorkbook = new XSSFWorkbook(file);
        List<XSSFPictureData> pictures = xssfWorkbook.getAllPictures();
        if(pictures != null && pictures.size() > 0) {
            XSSFPictureData photo = pictures.get(0);
            String ext = photo.suggestFileExtension();
            if("jpg".equals(ext)) {
                byte[] data = photo.getData();
                FileOutputStream out = new FileOutputStream(photoStorage + File.separator + expertId + ".jpg");
                out.write(data);
                out.close();
            }
        }
    }
    
    public static void main(String[] args) throws InvalidFormatException, IOException {
//        expertParserXlsx("D:/a.xlsx");
        String mobile = "15626471261";
        System.out.println("15626471261".substring(mobile.length() - 4));
    }
}
