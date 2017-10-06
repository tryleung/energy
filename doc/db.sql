-- 菜单
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT,
  `parent_id` bigint COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) COMMENT '菜单名称',
  `url` varchar(200) COMMENT '菜单URL',
  `perms` varchar(500) COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `type` int COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) COMMENT '菜单图标',
  `order_num` int COMMENT '排序',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单管理';

-- 系统用户  增加了一个expert_id，如果是专家用户则关联专家表的expert_id
--增加了一个login_count字段，判断是否首次登陆，导入专家信息时需同时导入sys_expert,sys_user,sys_role,sys_user_role,sys_role_menu表
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(100) COMMENT '密码',
  `email` varchar(100) COMMENT '邮箱',
  `mobile` varchar(100) COMMENT '手机号',
  `status` tinyint COMMENT '状态  0：禁用   1：正常',
  `create_user_id` bigint(20) COMMENT '创建者ID',
  `expert_id` bigint(20) default NULL COMMENT '专家信息关联ID',
  `login_count` bigint(10) default 0 COMMENT '登陆次数',
  `create_time` datetime COMMENT '创建时间',
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户';

-- 系统用户
--CREATE TABLE `sys_user` (
--  `user_id` bigint NOT NULL AUTO_INCREMENT,
--  `username` varchar(50) NOT NULL COMMENT '用户名',
--  `password` varchar(100) COMMENT '密码',
--  `email` varchar(100) COMMENT '邮箱',
--  `mobile` varchar(100) COMMENT '手机号',
--  `status` tinyint COMMENT '状态  0：禁用   1：正常',
--  `create_user_id` bigint(20) COMMENT '创建者ID',
--  `create_time` datetime COMMENT '创建时间',
--  PRIMARY KEY (`user_id`),
--  UNIQUE INDEX (`username`)
--) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户';

-- 角色
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) COMMENT '角色名称',
  `remark` varchar(100) COMMENT '备注',
  `create_user_id` bigint(20) COMMENT '创建者ID',
  `create_time` datetime COMMENT '创建时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色';

-- 用户与角色对应关系
CREATE TABLE `sys_user_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint COMMENT '用户ID',
  `role_id` bigint COMMENT '角色ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与角色对应关系';

-- 角色与菜单对应关系
CREATE TABLE `sys_role_menu` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` bigint COMMENT '角色ID',
  `menu_id` bigint COMMENT '菜单ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色与菜单对应关系';


-- 系统配置信息
CREATE TABLE `sys_config` (
	`id` bigint NOT NULL AUTO_INCREMENT,
	`key` varchar(50) COMMENT 'key',
	`value` varchar(2000) COMMENT 'value',
	`status` tinyint DEFAULT 1 COMMENT '状态   0：隐藏   1：显示',
	`remark` varchar(500) COMMENT '备注',
	PRIMARY KEY (`id`),
	UNIQUE INDEX (`key`)
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8 COMMENT='系统配置信息表';

-- 系统日志
CREATE TABLE `sys_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COMMENT '用户名',
  `operation` varchar(50) COMMENT '用户操作',
  `method` varchar(200) COMMENT '请求方法',
  `params` varchar(5000) COMMENT '请求参数',
  `ip` varchar(64) COMMENT 'IP地址',
  `create_date` datetime COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8 COMMENT='系统日志';


-- 文件上传
CREATE TABLE `sys_oss` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) COMMENT 'URL地址',
  `create_date` datetime COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8 COMMENT='文件上传';


-- 初始数据
INSERT INTO `sys_user` (`user_id`, `username`, `password`, `email`, `mobile`, `status`, `create_user_id`, `create_time`) VALUES ('1', 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'root@renren.io', '13612345678', '1', '1', '2016-11-11 11:11:11');
INSERT INTO `sys_menu` VALUES (1, 0, '系统管理', NULL, NULL, 0, 'fa fa-cog', 0);
INSERT INTO `sys_menu` VALUES (2, 1, '管理员列表', 'sys/user.html', NULL, 1, 'fa fa-user', 1);
INSERT INTO `sys_menu` VALUES (3, 1, '角色管理', 'sys/role.html', NULL, 1, 'fa fa-user-secret', 2);
INSERT INTO `sys_menu` VALUES (4, 1, '菜单管理', 'sys/menu.html', NULL, 1, 'fa fa-th-list', 3);
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('5', '1', '参数管理', 'sys/config.html', 'sys:config:list,sys:config:info,sys:config:save,sys:config:update,sys:config:delete', '1', 'fa fa-sun-o', '6');
INSERT INTO `sys_menu` VALUES (15, 2, '查看', NULL, 'sys:user:list,sys:user:info', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (16, 2, '新增', NULL, 'sys:user:save,sys:role:select', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (17, 2, '修改', NULL, 'sys:user:update,sys:role:select', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (18, 2, '删除', NULL, 'sys:user:delete', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (19, 3, '查看', NULL, 'sys:role:list,sys:role:info', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (20, 3, '新增', NULL, 'sys:role:save,sys:menu:perms', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (21, 3, '修改', NULL, 'sys:role:update,sys:menu:perms', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (22, 3, '删除', NULL, 'sys:role:delete', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (23, 4, '查看', NULL, 'sys:menu:list,sys:menu:info', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (24, 4, '新增', NULL, 'sys:menu:save,sys:menu:select', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (25, 4, '修改', NULL, 'sys:menu:update,sys:menu:select', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (26, 4, '删除', NULL, 'sys:menu:delete', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (27, 0, '专家管理', NULL, NULL, 0, 'fa fa-user', 1);
INSERT INTO `sys_menu` VALUES (28, 27, '专家列表', 'http://test', 'sys:expert:list', 1, 'fa fa-user', 0);
INSERT INTO `sys_menu` VALUES (29, 27, '专家查询', 'sys/expertQuery.html', NULL, 1, 'fa fa-user', 0);
INSERT INTO `sys_menu` VALUES (30, 0, '项目管理', NULL, NULL, 0, 'fa fa-suitcase', 2);
INSERT INTO `sys_menu` VALUES (31, 30, '项目列表', 'http://test', NULL, 1, 'fa fa-list-ul', 0);
INSERT INTO `sys_menu` VALUES (32, 30, '项目评审准备', 'http://test', NULL, 1, 'fa fa-hand-rock-o', 0);
INSERT INTO `sys_menu` VALUES (33, 0, '评审管理', NULL, NULL, 0, 'fa fa-users', 3);
INSERT INTO `sys_menu` VALUES (34, 33, '待评审', 'http://test', NULL, 1, 'fa fa-hourglass-end', 0);
INSERT INTO `sys_menu` VALUES (35, 33, '已评审', 'http://test', NULL, 1, 'fa fa-hourglass-start', 0);
INSERT INTO `sys_menu` VALUES (36, 0, '统计查询', NULL, NULL, 0, 'fa fa-percent', 4);
INSERT INTO `sys_menu` VALUES (37, 36, '项目统计', 'http://test', NULL, 1, 'fa fa-object-group', 0);
INSERT INTO `sys_menu` VALUES (38, 36, '统计页面', 'http://test', NULL, 1, 'fa fa-sitemap', 0);
INSERT INTO `sys_menu` VALUES (39, 28, '新增', NULL, 'sys:expert:save', 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (40, 28, '查看', NULL, 'sys:expert:list,sys:expert:info', 2, NULL, 0);

--创建专家角色
INSERT INTO `sys_role` VALUES (1,'专家','专家用户',1,'2017-09-26 19:23:36');
--给专家角色访问评审管理、待评审、已评审菜单权限
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (1, 1, 33);
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (2, 1, 34);
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (3, 1, 35);

--创建中国电力企业联合会专家角色
INSERT INTO `sys_role` VALUES (2,'中国电力企业联合会_专家','中国电力企业联合会_专家',1,'2017-09-26 19:23:36');
--给中国电力企业联合会专家角色访问评审管理、待评审、已评审菜单权限
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (4, 2, 33);
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (5, 2, 34);
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (6, 2, 35);

--创建中国电力企业联合会管理员角色
INSERT INTO `sys_role` VALUES (5,'中国电力企业联合会_管理员','中国电力企业联合会_管理员',1,'2017-09-26 19:23:36');
--给中国电力企业联合会管理员角色专家菜单的权限
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (13, 5, 27);
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (14, 5, 28);
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (15, 5, 39);
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (16, 5, 40);
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (17, 5, 29);
--创建中国电力企业联合会管理员用户
INSERT INTO `sys_user` VALUES (19, 'dianliqiye', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','root@email.com','15696969696',1,1,null,0,'2017-10-06 13:30:29');
--将中国电力企业联合会管理员用户加入中国电力企业联合会管理员角色
INSERT INTO `sys_user_role` VALUES(7,19,5)

--创建中国电力设备管理协会专家角色
INSERT INTO `sys_role` VALUES (3,'中国电力设备管理协会_专家','中国电力设备管理协会_专家',1,'2017-09-26 19:23:36');
--给中国电力设备管理协会专家角色访问评审管理、待评审、已评审菜单权限
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (7, 3, 33);
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (8, 3, 34);
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (9, 3, 35);

--创建中国电力设备管理协会管理员角色
INSERT INTO `sys_role` VALUES (6,'中国电力设备管理协会_管理员','中国电力设备管理协会_管理员',1,'2017-09-26 19:23:36');
--给中国电力设备管理协会管理员角色访问专家菜单的权限限
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (18, 6, 27);
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (19, 6, 28);
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (20, 6, 39);
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (21, 6, 40);
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (22, 6, 29);
--创建中国电力设备管理协会管理员用户
INSERT INTO `sys_user` VALUES (20, 'dianlishebei', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','root@email.com','15696969697',1,1,null,0,'2017-10-06 13:30:29');
--将中国电力设备管理协会管理员用户加入中国电力设备管理协会管理员角色
INSERT INTO `sys_user_role` VALUES(8,20,6)

--创建中国通用机械工业协会专家角色
INSERT INTO `sys_role` VALUES (4,'中国通用机械工业协会_专家','中国通用机械工业协会_专家',1,'2017-09-26 19:23:36');
--给中国通用机械工业协会专家角色访问评审管理、待评审、已评审菜单权限
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (10, 4, 33);
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (11, 4, 34);
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (12, 4, 35);

--创建中国通用机械工业协会管理员角色
INSERT INTO `sys_role` VALUES (7,'中国通用机械工业协会_管理员','中国通用机械工业协会_管理员',1,'2017-09-26 19:23:36');
--给中国通用机械工业协会管理员角色访问专家菜单的权限限
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (23, 7, 27);
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (24, 7, 28);
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (25, 7, 39);
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (26, 7, 40);
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES (27, 7, 29);
--创建中国通用机械工业协会管理员用户
INSERT INTO `sys_user` VALUES (21, 'tongyongjixie', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','root@email.com','15696969699',1,1,null,0,'2017-10-06 13:30:29');
--将中国通用机械工业协会管理员用户加入中国通用机械工业协会管理员角色
INSERT INTO `sys_user_role` VALUES(9,21,7)


INSERT INTO `sys_config` (`key`, `value`, `status`, `remark`) VALUES ('CLOUD_STORAGE_CONFIG_KEY', '{\"aliyunAccessKeyId\":\"\",\"aliyunAccessKeySecret\":\"\",\"aliyunBucketName\":\"\",\"aliyunDomain\":\"\",\"aliyunEndPoint\":\"\",\"aliyunPrefix\":\"\",\"qcloudBucketName\":\"\",\"qcloudDomain\":\"\",\"qcloudPrefix\":\"\",\"qcloudSecretId\":\"\",\"qcloudSecretKey\":\"\",\"qiniuAccessKey\":\"NrgMfABZxWLo5B-YYSjoE8-AZ1EISdi1Z3ubLOeZ\",\"qiniuBucketName\":\"ios-app\",\"qiniuDomain\":\"http://7xqbwh.dl1.z0.glb.clouddn.com\",\"qiniuPrefix\":\"upload\",\"qiniuSecretKey\":\"uIwJHevMRWU0VLxFvgy0tAcOdGqasdtVlJkdy6vV\",\"type\":1}', '0', '云存储配置信息');
INSERT INTO `sys_config` (`key`, `value`, `status`, `remark`) VALUES ('expert_photo_dir','D:\expert_photo_dir','1','专家照片目录');
INSERT INTO `sys_config` (`key`, `value`, `status`, `remark`) VALUES ('expert_excel_dir','D:\expert_excel_dir','1','专家信息excel文件目录');




-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- API接口相关SQL，如果不使用renren-api模块，则不用执行下面SQL -------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 用户表
CREATE TABLE `tb_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `mobile` varchar(20) NOT NULL COMMENT '手机号',
  `password` varchar(64) COMMENT '密码',
  `create_time` datetime COMMENT '创建时间',
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户';

-- 用户Token表
CREATE TABLE `tb_token` (
  `user_id` bigint NOT NULL,
  `token` varchar(100) NOT NULL COMMENT 'token',
  `expire_time` datetime COMMENT '过期时间',
  `update_time` datetime COMMENT '更新时间',
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户Token';

-- 账号：13612345678  密码：admin
INSERT INTO `tb_user` (`username`, `mobile`, `password`, `create_time`) VALUES ('mark', '13612345678', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '2017-03-23 22:37:41');

-- 专家详细信息表
CREATE TABLE `sys_expert` (
  `expert_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '专家姓名',
  `gender` char(1) NOT NULL COMMENT '性别,1男,0女',
  `nation` varchar(10) NOT NULL COMMENT '民族',
  `party` varchar(10) NOT NULL COMMENT '党派',
  `photoPath` varchar(64) COMMENT '专家照片路径',
  `idNum` varchar(20) NOT NULL COMMENT '身份证号',
  `birth` varchar(10) COMMENT '出生日期',
  `highestEdu` varchar(10) COMMENT '最高学历',
  `graduateSchool` varchar(20) COMMENT '毕业院校',
  `major1` varchar(20) COMMENT '所学专业',
  `major2` varchar(20) COMMENT '从事专业',
  `unitProperty` varchar(10) COMMENT '单位性质',
  `isAcademician` char(20) COMMENT '科学院院士，工程院院士',
  `expertTitle` varchar(10) COMMENT '技术职称',
  `expertJob` varchar(10) COMMENT '担任职务',
  `onDuty` char(1) COMMENT '在职情况,1在职，0离职',
  `mobile` varchar(20) COMMENT '移动电话',
  `fax` varchar(20) COMMENT '传真',
  `email` varchar(30) COMMENT '电子邮件',
  `address` varchar(64) COMMENT '通信地址',
  `postcode` varchar(10) COMMENT '邮政编码',
  `researchField` varchar(20) COMMENT '研究领域',
  `researchDirection` varchar(20) COMMENT '研究方向',
  `language` varchar(10) COMMENT '熟悉语种',
  `proficiency` varchar(2) COMMENT '熟练程度',
  `resume` text COMMENT '专业简历',
  `recommendUnit` varchar(30) COMMENT '推荐单位名称',
  `workUnit` varchar(30) COMMENT '工作单位名称',
  `remark` varchar(128) COMMENT '备注',
  `create_time` datetime COMMENT '创建时间',
  `create_user_id` bigint(20) COMMENT '创建者ID',
  `modify_time` datetime COMMENT '修改时间',
  `modify_user_id` bigint(20) COMMENT '修改者ID',
  PRIMARY KEY (`expert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='专家信息表';


-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 代码生成器相关SQL，如果不使用renren-gen模块，则不用执行下面SQL -------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('28', '1', '代码生成器', 'sys/generator.html', 'sys:generator:list,sys:generator:code', '1', 'fa fa-rocket', '8');






-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 定时任务相关表结构，如果不使用renren-schedule模块，则不用执行下面SQL -------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 初始化菜单数据
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('6', '1', '定时任务', 'sys/schedule.html', NULL, '1', 'fa fa-tasks', '5');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('7', '6', '查看', NULL, 'sys:schedule:list,sys:schedule:info', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('8', '6', '新增', NULL, 'sys:schedule:save', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('9', '6', '修改', NULL, 'sys:schedule:update', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('10', '6', '删除', NULL, 'sys:schedule:delete', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('11', '6', '暂停', NULL, 'sys:schedule:pause', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('12', '6', '恢复', NULL, 'sys:schedule:resume', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('13', '6', '立即执行', NULL, 'sys:schedule:run', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('14', '6', '日志列表', NULL, 'sys:schedule:log', '2', NULL, '0');

-- 定时任务
CREATE TABLE `schedule_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `bean_name` varchar(200) DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(100) DEFAULT NULL COMMENT '方法名',
  `params` varchar(2000) DEFAULT NULL COMMENT '参数',
  `cron_expression` varchar(100) DEFAULT NULL COMMENT 'cron表达式',
  `status` tinyint(4) DEFAULT NULL COMMENT '任务状态',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='定时任务';

-- 定时任务日志
CREATE TABLE `schedule_job_log` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志id',
  `job_id` bigint(20) NOT NULL COMMENT '任务id',
  `bean_name` varchar(200) DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(100) DEFAULT NULL COMMENT '方法名',
  `params` varchar(2000) DEFAULT NULL COMMENT '参数',
  `status` tinyint(4) NOT NULL COMMENT '任务状态    0：成功    1：失败',
  `error` varchar(2000) DEFAULT NULL COMMENT '失败信息',
  `times` int(11) NOT NULL COMMENT '耗时(单位：毫秒)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`log_id`),
  KEY `job_id` (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='定时任务日志';



INSERT INTO `schedule_job` (`bean_name`, `method_name`, `params`, `cron_expression`, `status`, `remark`, `create_time`) VALUES ('testTask', 'test', 'renren', '0 0/30 * * * ?', '0', '有参数测试', '2016-12-01 23:16:46');
INSERT INTO `schedule_job` (`bean_name`, `method_name`, `params`, `cron_expression`, `status`, `remark`, `create_time`) VALUES ('testTask', 'test2', NULL, '0 0/30 * * * ?', '1', '无参数测试', '2016-12-03 14:55:56');


--  quartz自带表结构
CREATE TABLE QRTZ_JOB_DETAILS(
SCHED_NAME VARCHAR(120) NOT NULL,
JOB_NAME VARCHAR(200) NOT NULL,
JOB_GROUP VARCHAR(200) NOT NULL,
DESCRIPTION VARCHAR(250) NULL,
JOB_CLASS_NAME VARCHAR(250) NOT NULL,
IS_DURABLE VARCHAR(1) NOT NULL,
IS_NONCONCURRENT VARCHAR(1) NOT NULL,
IS_UPDATE_DATA VARCHAR(1) NOT NULL,
REQUESTS_RECOVERY VARCHAR(1) NOT NULL,
JOB_DATA BLOB NULL,
PRIMARY KEY (SCHED_NAME,JOB_NAME,JOB_GROUP))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_TRIGGERS (
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
JOB_NAME VARCHAR(200) NOT NULL,
JOB_GROUP VARCHAR(200) NOT NULL,
DESCRIPTION VARCHAR(250) NULL,
NEXT_FIRE_TIME BIGINT(13) NULL,
PREV_FIRE_TIME BIGINT(13) NULL,
PRIORITY INTEGER NULL,
TRIGGER_STATE VARCHAR(16) NOT NULL,
TRIGGER_TYPE VARCHAR(8) NOT NULL,
START_TIME BIGINT(13) NOT NULL,
END_TIME BIGINT(13) NULL,
CALENDAR_NAME VARCHAR(200) NULL,
MISFIRE_INSTR SMALLINT(2) NULL,
JOB_DATA BLOB NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
REFERENCES QRTZ_JOB_DETAILS(SCHED_NAME,JOB_NAME,JOB_GROUP))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_SIMPLE_TRIGGERS (
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
REPEAT_COUNT BIGINT(7) NOT NULL,
REPEAT_INTERVAL BIGINT(12) NOT NULL,
TIMES_TRIGGERED BIGINT(10) NOT NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_CRON_TRIGGERS (
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
CRON_EXPRESSION VARCHAR(120) NOT NULL,
TIME_ZONE_ID VARCHAR(80),
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_SIMPROP_TRIGGERS
  (          
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    STR_PROP_1 VARCHAR(512) NULL,
    STR_PROP_2 VARCHAR(512) NULL,
    STR_PROP_3 VARCHAR(512) NULL,
    INT_PROP_1 INT NULL,
    INT_PROP_2 INT NULL,
    LONG_PROP_1 BIGINT NULL,
    LONG_PROP_2 BIGINT NULL,
    DEC_PROP_1 NUMERIC(13,4) NULL,
    DEC_PROP_2 NUMERIC(13,4) NULL,
    BOOL_PROP_1 VARCHAR(1) NULL,
    BOOL_PROP_2 VARCHAR(1) NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP) 
    REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_BLOB_TRIGGERS (
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
BLOB_DATA BLOB NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
INDEX (SCHED_NAME,TRIGGER_NAME, TRIGGER_GROUP),
FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_CALENDARS (
SCHED_NAME VARCHAR(120) NOT NULL,
CALENDAR_NAME VARCHAR(200) NOT NULL,
CALENDAR BLOB NOT NULL,
PRIMARY KEY (SCHED_NAME,CALENDAR_NAME))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS (
SCHED_NAME VARCHAR(120) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
PRIMARY KEY (SCHED_NAME,TRIGGER_GROUP))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_FIRED_TRIGGERS (
SCHED_NAME VARCHAR(120) NOT NULL,
ENTRY_ID VARCHAR(95) NOT NULL,
TRIGGER_NAME VARCHAR(200) NOT NULL,
TRIGGER_GROUP VARCHAR(200) NOT NULL,
INSTANCE_NAME VARCHAR(200) NOT NULL,
FIRED_TIME BIGINT(13) NOT NULL,
SCHED_TIME BIGINT(13) NOT NULL,
PRIORITY INTEGER NOT NULL,
STATE VARCHAR(16) NOT NULL,
JOB_NAME VARCHAR(200) NULL,
JOB_GROUP VARCHAR(200) NULL,
IS_NONCONCURRENT VARCHAR(1) NULL,
REQUESTS_RECOVERY VARCHAR(1) NULL,
PRIMARY KEY (SCHED_NAME,ENTRY_ID))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_SCHEDULER_STATE (
SCHED_NAME VARCHAR(120) NOT NULL,
INSTANCE_NAME VARCHAR(200) NOT NULL,
LAST_CHECKIN_TIME BIGINT(13) NOT NULL,
CHECKIN_INTERVAL BIGINT(13) NOT NULL,
PRIMARY KEY (SCHED_NAME,INSTANCE_NAME))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_LOCKS (
SCHED_NAME VARCHAR(120) NOT NULL,
LOCK_NAME VARCHAR(40) NOT NULL,
PRIMARY KEY (SCHED_NAME,LOCK_NAME))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE INDEX IDX_QRTZ_J_REQ_RECOVERY ON QRTZ_JOB_DETAILS(SCHED_NAME,REQUESTS_RECOVERY);
CREATE INDEX IDX_QRTZ_J_GRP ON QRTZ_JOB_DETAILS(SCHED_NAME,JOB_GROUP);

CREATE INDEX IDX_QRTZ_T_J ON QRTZ_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_JG ON QRTZ_TRIGGERS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_C ON QRTZ_TRIGGERS(SCHED_NAME,CALENDAR_NAME);
CREATE INDEX IDX_QRTZ_T_G ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);
CREATE INDEX IDX_QRTZ_T_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_N_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_N_G_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_NEXT_FIRE_TIME ON QRTZ_TRIGGERS(SCHED_NAME,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_ST ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_STATE,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_MISFIRE ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE_GRP ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_GROUP,TRIGGER_STATE);

CREATE INDEX IDX_QRTZ_FT_TRIG_INST_NAME ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME);
CREATE INDEX IDX_QRTZ_FT_INST_JOB_REQ_RCVRY ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME,REQUESTS_RECOVERY);
CREATE INDEX IDX_QRTZ_FT_J_G ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_FT_JG ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_FT_T_G ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);
CREATE INDEX IDX_QRTZ_FT_TG ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);
