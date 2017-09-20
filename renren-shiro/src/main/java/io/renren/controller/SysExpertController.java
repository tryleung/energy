package io.renren.controller;


import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import io.renren.entity.SysConfigEntity;
import io.renren.entity.SysExpertEntity;
import io.renren.service.SysConfigService;
import io.renren.service.SysExpertService;
import io.renren.utils.PageUtils;
import io.renren.utils.Query;
import io.renren.utils.R;




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
	
}
