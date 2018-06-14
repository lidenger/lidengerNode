/*
Navicat MySQL Data Transfer

Source Server         : 140.143.158.35
Source Server Version : 50722
Source Host           : 140.143.158.35:3306
Source Database       : denglier

Target Server Type    : MYSQL
Target Server Version : 50722
File Encoding         : 65001

Date: 2018-06-15 05:19:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `account_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) DEFAULT '' COMMENT '用户名',
  `pwd` varchar(100) DEFAULT '' COMMENT '密码',
  `phone` varchar(20) DEFAULT '' COMMENT '手机号',
  `enable` tinyint(1) DEFAULT '1' COMMENT '是否启用，1启用，0禁用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `un_account_user_name` (`user_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES ('1', 'ly6635', '202cb962ac59075b964b07152d234b70', '13920263513', '1', '2018-06-08 14:34:29', '2018-06-15 02:40:16');
INSERT INTO `account` VALUES ('2', 'dfc', '250cf8b51c773f3f8dc8b4be867a9a02', '13920240000', '1', '2018-06-08 16:47:07', '2018-06-15 02:40:56');

-- ----------------------------
-- Table structure for account_link_role
-- ----------------------------
DROP TABLE IF EXISTS `account_link_role`;
CREATE TABLE `account_link_role` (
  `account_id` bigint(20) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`account_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account_link_role
-- ----------------------------
INSERT INTO `account_link_role` VALUES ('1', '1');
INSERT INTO `account_link_role` VALUES ('2', '1');

-- ----------------------------
-- Table structure for resource
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource` (
  `resource_id` varchar(100) NOT NULL,
  `resource_key` varchar(100) DEFAULT '' COMMENT '资源key,标识该资源',
  `resource_name` varchar(100) DEFAULT NULL COMMENT '资源名称',
  `resource_url` varchar(300) DEFAULT NULL COMMENT '资源请求路径',
  `resource_parent_id` varchar(100) DEFAULT NULL COMMENT '父级资源编号',
  `is_menu` tinyint(1) DEFAULT '0' COMMENT '是否为菜单项',
  `enable` tinyint(1) DEFAULT '1' COMMENT '是否启用，0禁用，1启用',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`resource_id`),
  KEY `fk_resource_parent_id` (`resource_parent_id`),
  CONSTRAINT `fk_resource_parent_id` FOREIGN KEY (`resource_parent_id`) REFERENCES `resource` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of resource
-- ----------------------------
INSERT INTO `resource` VALUES ('R01', 'userManager', '用户管理', null, null, '1', '1', '', '2018-06-08 14:21:45', '2018-06-08 14:26:32');
INSERT INTO `resource` VALUES ('R0101', 'selectUserInfo', '查询用户信息', '/user/select', 'R01', '0', '1', '', '2018-06-08 14:27:24', '2018-06-08 14:28:29');
INSERT INTO `resource` VALUES ('R0102', 'updateUserInfo', '更新用户信息', '/user/update', 'R01', '0', '1', '', '2018-06-08 14:28:49', '2018-06-08 14:28:58');
INSERT INTO `resource` VALUES ('R0103', 'addUserInfo', '新增用户信息', '/user/add', 'R01', '0', '1', '', '2018-06-08 14:29:32', null);
INSERT INTO `resource` VALUES ('R0104', 'removeUserInfo', '删除用户信息', '/user/delete', 'R01', '0', '1', '', '2018-06-08 14:30:15', null);

-- ----------------------------
-- Table structure for resource_link_role
-- ----------------------------
DROP TABLE IF EXISTS `resource_link_role`;
CREATE TABLE `resource_link_role` (
  `role_id` int(11) NOT NULL,
  `resource_id` varchar(100) NOT NULL,
  PRIMARY KEY (`resource_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of resource_link_role
-- ----------------------------
INSERT INTO `resource_link_role` VALUES ('1', 'R01');
INSERT INTO `resource_link_role` VALUES ('1', 'R0101');
INSERT INTO `resource_link_role` VALUES ('1', 'R0102');
INSERT INTO `resource_link_role` VALUES ('1', 'R0103');
INSERT INTO `resource_link_role` VALUES ('1', 'R0104');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色编号',
  `role_name` varchar(100) DEFAULT '' COMMENT '角色名称',
  `enable` tinyint(1) DEFAULT '1' COMMENT '是否启用，1启用，0禁用',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'admin', '1', '', '2018-06-08 14:35:47', null);

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config` (
  `config_key` varchar(100) NOT NULL COMMENT '系统配置key',
  `config_value` varchar(100) DEFAULT NULL COMMENT '配置值',
  `config_desc` varchar(200) DEFAULT '' COMMENT '配置说明',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '数据修改时间',
  PRIMARY KEY (`config_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config` VALUES ('token_valid_minute', '30', 'token有效时间', '2018-06-15 04:35:29');

-- ----------------------------
-- Table structure for token_log
-- ----------------------------
DROP TABLE IF EXISTS `token_log`;
CREATE TABLE `token_log` (
  `token` varchar(100) NOT NULL,
  `user_name` varchar(100) NOT NULL COMMENT '用户名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'token创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `visit_num` int(11) DEFAULT '0' COMMENT '访问次数',
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of token_log
-- ----------------------------
INSERT INTO `token_log` VALUES ('07459ef894dbc3c33e6d41c2deb9873c', 'ly6635', '2018-06-15 04:10:23', null, '0');
INSERT INTO `token_log` VALUES ('45d99c9bfacca475cf23e90d4d5cfd07', 'ly6635', '2018-06-15 05:17:29', '2018-06-15 01:18:04', '2');
INSERT INTO `token_log` VALUES ('4680dbbd4a520cc44b0e4b16c8572e8e', 'ly6635', '2018-06-15 04:18:24', '2018-06-15 04:08:34', '1');
INSERT INTO `token_log` VALUES ('f6e0a0648dba6629026f6cfb0855f8a0', 'ly6635', '2018-06-15 05:03:01', '2018-06-15 05:03:01', '0');

-- ----------------------------
-- Table structure for unauth_resource
-- ----------------------------
DROP TABLE IF EXISTS `unauth_resource`;
CREATE TABLE `unauth_resource` (
  `id` varchar(30) NOT NULL COMMENT '非权限资源',
  `unauth_name` varchar(100) DEFAULT NULL COMMENT '非权限资源说明',
  `url` varchar(300) DEFAULT NULL COMMENT '请求路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of unauth_resource
-- ----------------------------
INSERT INTO `unauth_resource` VALUES ('un001', '登录', '/login');
INSERT INTO `unauth_resource` VALUES ('un002', '登出', '/logout');

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `caId` varchar(36) NOT NULL COMMENT 'ca Id',
  `account` varchar(50) DEFAULT NULL COMMENT '用户名',
  `name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `instituteNumber` varchar(1000) DEFAULT NULL COMMENT '机构编码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('7d77eb05a4e14c119a23fba77d088a0b', '', '牛平平', '2018-03-13 18:47:34', 'WTB430102001');
INSERT INTO `user_info` VALUES ('a020c1604a2a4621b49903a57841c238', ' 0800061580 ', ' 宋嘉懿 ', '2018-03-13 18:47:34', 'WTB220104002');
INSERT INTO `user_info` VALUES ('0a8d60726cf44eb3af5557461a319949', ' 0800061711 ', ' 刘朝曦 ', '2018-03-13 18:47:34', 'WTB220104002');
INSERT INTO `user_info` VALUES ('690ac5e9b625432f952f76c846a0941f', ' 0800061767 ', ' 谭淋升 ', '2018-03-13 18:47:34', 'WTB220104002');
INSERT INTO `user_info` VALUES ('2d067f9056f744b3b8150fe78eb9000c', ' 0800062000 ', ' 徐尧 ', '2018-03-13 18:47:34', 'WTB220104002');
INSERT INTO `user_info` VALUES ('1c896b4c8701497d960bfdeb2fb36011', ' 0800062263 ', ' 李贺 ', '2018-03-13 18:47:34', 'WTB220104002');
INSERT INTO `user_info` VALUES ('8951c1f523cb4c26adbf34f34bce90e6', ' 0800062321 ', ' 綦俊 ', '2018-03-13 18:47:34', 'WTB220104002');
INSERT INTO `user_info` VALUES ('752ba6afaf4f4a07ba4683dd512a00af', ' 0800062325 ', ' 单雪 ', '2018-03-13 18:47:34', 'WTB220104002');
INSERT INTO `user_info` VALUES ('c33702772a7e4639b396ade68d8df9be', ' 0800062426 ', ' 李智 ', '2018-03-13 18:47:34', 'WTB220104002');
INSERT INTO `user_info` VALUES ('f91a819eff904ca9b4d804bb21444927', ' 0800360795 ', ' 黄东旭 ', '2018-03-13 18:47:34', 'WTB220104002');
INSERT INTO `user_info` VALUES ('1d05ca856afd11e88e70b06ebf5f3b92', 'xiaolin', '2222', '2018-06-08 17:19:36', 'h12w3sdf');
