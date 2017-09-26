package io.renren.controller;


import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import io.renren.entity.SysConfigEntity;
import io.renren.entity.SysExpertEntity;
import io.renren.entity.SysRoleEntity;
import io.renren.entity.SysUserEntity;
import io.renren.service.SysConfigService;
import io.renren.service.SysExpertService;
import io.renren.service.SysRoleService;
import io.renren.service.SysUserRoleService;
import io.renren.service.SysUserService;
import io.renren.utils.ExcelParser;
import io.renren.utils.PageUtils;
import io.renren.utils.Query;
import io.renren.utils.R;
import io.renren.utils.ShiroUtils;
import io.renren.utils.Tools;




/**
 * 专家信息表
 * 
 * @author chenshun
 * @email sunlightcs@gmail.com
 * @date 2017-09-19 20:14:09
 */
@RestController
@RequestMapping("/sys/expert")
public class SysExpertController {
    private static final Logger logger = Logger.getLogger(SysExpertController.class);
	@Autowired
	private SysExpertService sysExpertService;
	@Autowired
	private SysConfigService sysConfigService;
	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private SysUserRoleService sysUserRoleService;
	@Autowired
	private SysRoleService sysRoleService;
	
	/**
	 * 列表
	 */
	@RequestMapping("/list")
	@RequiresPermissions("sys:expert:list")
	public R list(@RequestParam Map<String, Object> params){
	    logger.info("list req params=" + params);
		//查询列表数据
        Query query = new Query(params);

		List<SysExpertEntity> sysExpertList = sysExpertService.queryList(query);
		int total = sysExpertService.queryTotal(query);
		
		PageUtils pageUtil = new PageUtils(sysExpertList, total, query.getLimit(), query.getPage());
		
		return R.ok().put("page", pageUtil);
	}
	
	
	/**
	 * 信息
	 */
	@RequestMapping("/info/{expertId}")
	@RequiresPermissions("sys:expert:info")
	public R info(@PathVariable("expertId") Long expertId){
		SysExpertEntity sysExpert = sysExpertService.queryObject(expertId);
		
		return R.ok().put("sysExpert", sysExpert);
	}
	
	/**
     * 信息
     */
    @RequestMapping("/info2/{expertId}")
    public R info2(@PathVariable("expertId") Long expertId){
        SysExpertEntity sysExpert = sysExpertService.queryObject(expertId);
        
        return R.ok().put("sysExpert", sysExpert);
    }
    
    /**
     * 信息
     * @throws IOException 
     */
    @RequestMapping("/photo/{expertId}")
    public void photo(@PathVariable("expertId") Long expertId, HttpServletResponse response) throws IOException{
        response.setHeader("Pragma", "No-cache"); 
        response.setHeader("Cache-Control", "no-cache"); 
        response.setDateHeader("Expires", 0); 
        response.setContentType("image/jpeg"); 
        SysExpertEntity sysExpert = sysExpertService.queryObject(expertId);
        Map<String,Object> configQueryParam = new HashMap<String,Object>();
        configQueryParam.put("key", "expert_photo_dir");
        List<SysConfigEntity> configList = sysConfigService.queryList(configQueryParam);
        String photoDir = configList.get(0).getValue();
        File file = new File(photoDir + File.separator + expertId +".jpg");
        logger.info("file path=" + file.getAbsolutePath() +", exists=" + file.exists());
        BufferedImage img = ImageIO.read(file);
        ImageIO.write(img, "jpg", response.getOutputStream());
    }
	
	/**
	 * 保存
	 */
	@RequestMapping("/save")
	@RequiresPermissions("sys:expert:save")
	public R save(@RequestBody SysExpertEntity sysExpert){
		sysExpertService.save(sysExpert);
		
		return R.ok();
	}
	
	/**
	 * excel上传
	 * @param sysExpert
	 * @return
	 */
	@RequestMapping("/upload")
    @RequiresPermissions("sys:expert:save")
	@Transactional
    public R upload(@RequestParam MultipartFile[] file){
	    logger.info(">>>上传专家excel文件数："+ file == null ? 0 : file.length);
	    if(file != null && file.length > 0) {
	        Map<String,Object> configQueryParam = new HashMap<String,Object>();
	        configQueryParam.put("key", "expert_excel_dir");
	        List<SysConfigEntity> configList = sysConfigService.queryList(configQueryParam);
	        String excelDir = configList.get(0).getValue();
	        File dir = new File(excelDir);
	        if(!dir.exists()) {
	            dir.mkdirs();
	        }
	        for(MultipartFile f : file) {
	            String fileName = f.getOriginalFilename();
	            logger.info(">>>>文件"+ fileName +"写入磁盘,begin");
	            String savedPath = excelDir + File.separator + Tools.getTimeStamp() + fileName;
	            try {
                    f.transferTo(new File(savedPath));
                } catch (Exception e) {
                    logger.error("保存excel文件失败," + fileName,e);
                }
	            logger.info(">>>>保存文件"+ fileName +",end");
	            SysExpertEntity expertEntity = null;
	            try {
	                expertEntity = ExcelParser.expertParserXlsx(savedPath);
                } catch (InvalidFormatException e) {
                    logger.error("excel解析错误," + fileName, e);
                    return R.error("您上传的"+fileName+"文件格式不对，请您修改完毕后重新上传文件。");
                } catch (IOException e) {
                    
                }
	            if(expertEntity == null) {
	                return R.error("您上传的"+fileName+"文件数据不对，请您修改完毕后重新上传文件。");
	            }
	            sysExpertService.save(expertEntity);
	            //在user表中为专家创建用户
	            SysUserEntity user = createUserForExpert(expertEntity);
	            sysUserService.save(user);
	            //加入专家角色表  先查询角色为“专家”的角色
	            Map<String,Object> roleQueryParam = new HashMap<String,Object>();
	            roleQueryParam.put("roleName", "专家");
	            List<SysRoleEntity> roleEntities= sysRoleService.queryList(roleQueryParam);
	            List<Long> roleIdList = new ArrayList<Long>();
	            if(roleEntities != null && roleEntities.size() > 0) {
	                for(SysRoleEntity entity : roleEntities) {
	                    roleIdList.add(entity.getRoleId());
	                }
	            }
	            sysUserRoleService.saveOrUpdate(user.getUserId(), roleIdList);
	            //保存图片
	            Map<String,Object> photoConfig = new HashMap<String,Object>();
	            photoConfig.put("key", "expert_photo_dir");
	            List<SysConfigEntity> photoConfigList = sysConfigService.queryList(photoConfig);
	            String photoDir = photoConfigList.get(0).getValue();
	            try {
                    ExcelParser.expertParserXlsxPhoto(savedPath, String.valueOf(expertEntity.getExpertId()), photoDir);
                } catch (InvalidFormatException e) {
                    logger.error("excel格式错误");
                    return R.error("excel格式错误");
                } catch (IOException e) {
                    logger.error("文件读写错误");
                    return R.error("文件读写错误");
                }
	        }
	        return R.ok().put("count", file.length);
	    }
        return R.ok();
    }
	
	@RequestMapping("/save2")
    public R save2(HttpServletRequest request, MultipartFile photoPath, SysExpertEntity sysExpert){
	    String year = Tools.delNull(request.getParameter("year"));
	    String month = Tools.delNull(request.getParameter("month"));
	    String day = Tools.delNull(request.getParameter("day"));
	    sysExpert.setBirth(year + month + day);
	    logger.info(">>>>保存专家，请求参数"+sysExpert.toString()+", 图片大小=" + photoPath.getSize());
	    if(photoPath != null && photoPath.getSize() > 0) {
	        BufferedImage img = null;
	        try {
	            img = ImageIO.read(photoPath.getInputStream());
	            if(img.getWidth() > 200) {
	                return R.error("图片宽度不能大于200");
	            }
	            if(img.getHeight() > 300) {
	                return R.error("图片高度不能大于300");
	            }
	        } catch (IOException e1) {
	            logger.error("读取图片出错", e1);
	        }
	    }
	    if(StringUtils.isBlank(sysExpert.getName()) && StringUtils.isBlank(sysExpert.getIdnum())) {
	        return R.error("专家姓名和身份证号为空");
	    }
	    sysExpertService.save(sysExpert);
	    //在user表中为专家创建用户
        SysUserEntity user = createUserForExpert(sysExpert);
        sysUserService.save(user);
        //加入专家角色表  先查询角色为“专家”的角色
        Map<String,Object> roleQueryParam = new HashMap<String,Object>();
        roleQueryParam.put("roleName", "专家");
        List<SysRoleEntity> roleEntities= sysRoleService.queryList(roleQueryParam);
        List<Long> roleIdList = new ArrayList<Long>();
        if(roleEntities != null && roleEntities.size() > 0) {
            for(SysRoleEntity entity : roleEntities) {
                roleIdList.add(entity.getRoleId());
            }
        }
        sysUserRoleService.saveOrUpdate(user.getUserId(), roleIdList);
	    if(photoPath != null && photoPath.getSize()>0) {
	        String photoFileName = String.valueOf(sysExpert.getExpertId());
	        Map<String,Object> configQueryParam = new HashMap<String,Object>();
	        configQueryParam.put("key", "expert_photo_dir");
	        List<SysConfigEntity> configList = sysConfigService.queryList(configQueryParam);
	        String photoDir = configList.get(0).getValue();
	        File dir = new File(photoDir);
            if(!dir.exists()) {
                dir.mkdirs();
            }
	        File file = new File(photoDir + File.separator + photoFileName +".jpg");
	        try {
	            photoPath.transferTo(file);
	        } catch (Exception e) {
	            logger.error("保存图片失败",e);
	        }
	    }
        return R.ok("专家信息保存成功");
    }
	
	/**
	 * 修改
	 */
	@RequestMapping("/update")
	@RequiresPermissions("sys:expert:update")
	public R update(@RequestBody SysExpertEntity sysExpert){
		sysExpertService.update(sysExpert);
		
		return R.ok();
	}
	
	/**
	 * 删除
	 */
	@RequestMapping("/delete")
	@RequiresPermissions("sys:expert:delete")
	public R delete(@RequestBody Long[] expertIds){
		sysExpertService.deleteBatch(expertIds);
		
		return R.ok();
	}
	
	private SysUserEntity createUserForExpert(SysExpertEntity expert) {
	    String mobile = Tools.delNull(expert.getMobile());
        SysUserEntity user = new SysUserEntity();
        user.setUsername(mobile);
        user.setPassword(mobile.substring(mobile.length() - 4));
        user.setMobile(mobile);
        user.setStatus(1);
        user.setCreateUserId(ShiroUtils.getUserId());
        user.setExpertId(expert.getExpertId());
        user.setCreateTime(new Date());
        logger.info(">>>>专家"+expert.getExpertId()+"的user信息"+user.toString());
        return user;
	}
	
}
