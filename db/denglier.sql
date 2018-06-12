/*
Navicat MySQL Data Transfer

Source Server         : 140.143.158.35
Source Server Version : 50722
Source Host           : 140.143.158.35:3306
Source Database       : denglier

Target Server Type    : MYSQL
Target Server Version : 50722
File Encoding         : 65001

Date: 2018-06-12 14:46:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `account_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) DEFAULT '' COMMENT '用户姓名',
  `pwd` varchar(100) DEFAULT '' COMMENT '密码',
  `phone` varchar(20) DEFAULT '' COMMENT '手机号',
  `enable` tinyint(1) DEFAULT '1' COMMENT '是否启用，1启用，0禁用',
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES ('1', 'ly6635', '123', '13920263513', '1', '2018-06-08 14:34:29', null);
INSERT INTO `account` VALUES ('2', 'dfc', '456', '13920240000', '1', '2018-06-08 16:47:07', null);

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
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
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
