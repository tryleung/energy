package io.renren.dao;


import io.renren.entity.SysExpertEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 专家信息表
 * 
 * @author chenshun
 * @email sunlightcs@gmail.com
 * @date 2017-09-19 20:14:09
 */
@Mapper
public interface SysExpertDao extends BaseDao<SysExpertEntity> {
    SysExpertEntity queryObjectByNameIdnum(SysExpertEntity sysExpert);
}
