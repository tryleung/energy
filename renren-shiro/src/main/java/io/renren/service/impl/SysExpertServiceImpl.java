package io.renren.service.impl;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import io.renren.dao.SysExpertDao;
import io.renren.entity.SysExpertEntity;
import io.renren.service.SysExpertService;



@Service("sysExpertService")
public class SysExpertServiceImpl implements SysExpertService {
	@Autowired
	private SysExpertDao sysExpertDao;
	
	@Override
	public SysExpertEntity queryObject(Long expertId){
		return sysExpertDao.queryObject(expertId);
	}
	
	@Override
	public List<SysExpertEntity> queryList(Map<String, Object> map){
		return sysExpertDao.queryList(map);
	}
	
	@Override
	public int queryTotal(Map<String, Object> map){
		return sysExpertDao.queryTotal(map);
	}
	
	@Override
	public void save(SysExpertEntity sysExpert){
		sysExpertDao.save(sysExpert);
	}
	
	@Override
	public void update(SysExpertEntity sysExpert){
		sysExpertDao.update(sysExpert);
	}
	
	@Override
	public void delete(Long expertId){
		sysExpertDao.delete(expertId);
	}
	
	@Override
	public void deleteBatch(Long[] expertIds){
		sysExpertDao.deleteBatch(expertIds);
	}

    @Override
    public SysExpertEntity queryObjectByNameIdnum(SysExpertEntity sysExpert) {
        return sysExpertDao.queryObjectByNameIdnum(sysExpert);
    }
	
}
