package io.renren.service;


import java.util.List;
import java.util.Map;

import io.renren.entity.SysExpertEntity;

/**
 * 专家信息表
 * 
 * @author chenshun
 * @email sunlightcs@gmail.com
 * @date 2017-09-19 20:14:09
 */
public interface SysExpertService {
	
	SysExpertEntity queryObject(Long expertId);
	
	SysExpertEntity queryObjectByNameIdnum(SysExpertEntity sysExpert);
	
	List<SysExpertEntity> queryList(Map<String, Object> map);
	
	int queryTotal(Map<String, Object> map);
	
	void save(SysExpertEntity sysExpert);
	
	void update(SysExpertEntity sysExpert);
	
	void delete(Long expertId);
	
	void deleteBatch(Long[] expertIds);
}
