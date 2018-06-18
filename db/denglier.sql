/*
Navicat MySQL Data Transfer

Source Server         : 140.143.158.35
Source Server Version : 50722
Source Host           : 140.143.158.35:3306
Source Database       : denglier

Target Server Type    : MYSQL
Target Server Version : 50722
File Encoding         : 65001

Date: 2018-06-18 22:29:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for denglier_article
-- ----------------------------
DROP TABLE IF EXISTS `denglier_article`;
CREATE TABLE `denglier_article` (
  `article_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '文章',
  `title` varchar(300) NOT NULL DEFAULT '' COMMENT '文章标题',
  `account_id` bigint(20) NOT NULL COMMENT '文章作者编号',
  `content` text COMMENT '文章内容',
  `article_type_id` bigint(20) DEFAULT NULL COMMENT '文章类型编号',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_id`),
  KEY `fk_article_type_id` (`article_type_id`),
  CONSTRAINT `fk_article_type_id` FOREIGN KEY (`article_type_id`) REFERENCES `denglier_article_type` (`article_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of denglier_article
-- ----------------------------

-- ----------------------------
-- Table structure for denglier_article_comment
-- ----------------------------
DROP TABLE IF EXISTS `denglier_article_comment`;
CREATE TABLE `denglier_article_comment` (
  `article_comment_id` bigint(20) NOT NULL COMMENT '文章评论',
  PRIMARY KEY (`article_comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of denglier_article_comment
-- ----------------------------

-- ----------------------------
-- Table structure for denglier_article_type
-- ----------------------------
DROP TABLE IF EXISTS `denglier_article_type`;
CREATE TABLE `denglier_article_type` (
  `article_type_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '文章类型编号',
  `type_name` varchar(100) DEFAULT '' COMMENT '类型名称',
  `enable` tinyint(1) DEFAULT '1' COMMENT '是否启用（1启用，0禁用）',
  `content` varchar(300) DEFAULT '' COMMENT '类型详细描述',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of denglier_article_type
-- ----------------------------

-- ----------------------------
-- Table structure for denglier_base_account
-- ----------------------------
DROP TABLE IF EXISTS `denglier_base_account`;
CREATE TABLE `denglier_base_account` (
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
-- Records of denglier_base_account
-- ----------------------------
INSERT INTO `denglier_base_account` VALUES ('1', 'ly6635', '202cb962ac59075b964b07152d234b70', '13920263513', '1', '2018-06-08 14:34:29', '2018-06-15 02:40:16');
INSERT INTO `denglier_base_account` VALUES ('2', 'dfc', '250cf8b51c773f3f8dc8b4be867a9a02', '13920240000', '1', '2018-06-08 16:47:07', '2018-06-15 02:40:56');

-- ----------------------------
-- Table structure for denglier_base_account_link_role
-- ----------------------------
DROP TABLE IF EXISTS `denglier_base_account_link_role`;
CREATE TABLE `denglier_base_account_link_role` (
  `account_id` bigint(20) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`account_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of denglier_base_account_link_role
-- ----------------------------
INSERT INTO `denglier_base_account_link_role` VALUES ('1', '1');
INSERT INTO `denglier_base_account_link_role` VALUES ('2', '1');

-- ----------------------------
-- Table structure for denglier_base_resource
-- ----------------------------
DROP TABLE IF EXISTS `denglier_base_resource`;
CREATE TABLE `denglier_base_resource` (
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
  CONSTRAINT `fk_resource_parent_id` FOREIGN KEY (`resource_parent_id`) REFERENCES `denglier_base_resource` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of denglier_base_resource
-- ----------------------------
INSERT INTO `denglier_base_resource` VALUES ('R01', 'userManager', '用户管理', null, null, '1', '1', '', '2018-06-08 14:21:45', '2018-06-08 14:26:32');
INSERT INTO `denglier_base_resource` VALUES ('R0101', 'selectUserInfo', '查询用户信息', '/user/select', 'R01', '0', '1', '', '2018-06-08 14:27:24', '2018-06-08 14:28:29');
INSERT INTO `denglier_base_resource` VALUES ('R0102', 'updateUserInfo', '更新用户信息', '/user/update', 'R01', '0', '1', '', '2018-06-08 14:28:49', '2018-06-08 14:28:58');
INSERT INTO `denglier_base_resource` VALUES ('R0103', 'addUserInfo', '新增用户信息', '/user/add', 'R01', '0', '1', '', '2018-06-08 14:29:32', null);
INSERT INTO `denglier_base_resource` VALUES ('R0104', 'removeUserInfo', '删除用户信息', '/user/delete', 'R01', '0', '1', '', '2018-06-08 14:30:15', null);

-- ----------------------------
-- Table structure for denglier_base_resource_link_role
-- ----------------------------
DROP TABLE IF EXISTS `denglier_base_resource_link_role`;
CREATE TABLE `denglier_base_resource_link_role` (
  `role_id` int(11) NOT NULL,
  `resource_id` varchar(100) NOT NULL,
  PRIMARY KEY (`resource_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of denglier_base_resource_link_role
-- ----------------------------
INSERT INTO `denglier_base_resource_link_role` VALUES ('1', 'R01');
INSERT INTO `denglier_base_resource_link_role` VALUES ('1', 'R0101');
INSERT INTO `denglier_base_resource_link_role` VALUES ('1', 'R0102');
INSERT INTO `denglier_base_resource_link_role` VALUES ('1', 'R0103');
INSERT INTO `denglier_base_resource_link_role` VALUES ('1', 'R0104');

-- ----------------------------
-- Table structure for denglier_base_role
-- ----------------------------
DROP TABLE IF EXISTS `denglier_base_role`;
CREATE TABLE `denglier_base_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色编号',
  `role_name` varchar(100) DEFAULT '' COMMENT '角色名称',
  `enable` tinyint(1) DEFAULT '1' COMMENT '是否启用，1启用，0禁用',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of denglier_base_role
-- ----------------------------
INSERT INTO `denglier_base_role` VALUES ('1', 'admin', '1', '', '2018-06-08 14:35:47', null);

-- ----------------------------
-- Table structure for denglier_base_system_config
-- ----------------------------
DROP TABLE IF EXISTS `denglier_base_system_config`;
CREATE TABLE `denglier_base_system_config` (
  `config_key` varchar(100) NOT NULL COMMENT '系统配置key',
  `config_value` varchar(100) DEFAULT NULL COMMENT '配置值',
  `config_desc` varchar(200) DEFAULT '' COMMENT '配置说明',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '数据修改时间',
  PRIMARY KEY (`config_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of denglier_base_system_config
-- ----------------------------
INSERT INTO `denglier_base_system_config` VALUES ('token_valid_minute', '30', 'token有效时间', '2018-06-15 04:35:29');

-- ----------------------------
-- Table structure for denglier_base_token_log
-- ----------------------------
DROP TABLE IF EXISTS `denglier_base_token_log`;
CREATE TABLE `denglier_base_token_log` (
  `token` varchar(100) NOT NULL,
  `user_name` varchar(100) NOT NULL COMMENT '用户名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'token创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `visit_num` int(11) DEFAULT '0' COMMENT '访问次数',
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of denglier_base_token_log
-- ----------------------------
INSERT INTO `denglier_base_token_log` VALUES ('07459ef894dbc3c33e6d41c2deb9873c', 'ly6635', '2018-06-15 04:10:23', null, '0');
INSERT INTO `denglier_base_token_log` VALUES ('0be9e9ef99132d784c8ac2316cb95acb', 'ly6635', '2018-06-18 19:05:54', '2018-06-18 19:05:54', '0');
INSERT INTO `denglier_base_token_log` VALUES ('0c980055e334c54bed4a7456ed021da7', 'ly6635', '2018-06-18 11:55:38', '2018-06-18 11:55:38', '0');
INSERT INTO `denglier_base_token_log` VALUES ('0ff081797eb45258dfb7428e53bc36fa', 'ly6635', '2018-06-18 11:55:38', '2018-06-18 11:55:38', '0');
INSERT INTO `denglier_base_token_log` VALUES ('1137c41705830968a364e70a0eaa6030', 'ly6635', '2018-06-18 12:43:01', '2018-06-18 12:43:01', '0');
INSERT INTO `denglier_base_token_log` VALUES ('189b7e37b90cde7b8d388c4d90bafc0a', 'ly6635', '2018-06-18 12:45:04', '2018-06-18 12:45:04', '0');
INSERT INTO `denglier_base_token_log` VALUES ('191f2b36e2d828047d8b9f3974b274b9', 'ly6635', '2018-06-18 12:41:14', '2018-06-18 12:41:14', '0');
INSERT INTO `denglier_base_token_log` VALUES ('28f63b4442a82f734b25eedd956a24bb', 'ly6635', '2018-06-18 18:53:45', '2018-06-18 18:53:45', '0');
INSERT INTO `denglier_base_token_log` VALUES ('2a490f20b428835f7b56926a0e3aee86', 'ly6635', '2018-06-18 12:45:23', '2018-06-18 12:45:23', '0');
INSERT INTO `denglier_base_token_log` VALUES ('2e583431edc05bed98fdda2e6289c2c6', 'ly6635', '2018-06-18 12:45:22', '2018-06-18 12:45:22', '0');
INSERT INTO `denglier_base_token_log` VALUES ('300ba389f637e405096ffa019d228dc1', 'ly6635', '2018-06-18 12:40:47', '2018-06-18 12:40:47', '0');
INSERT INTO `denglier_base_token_log` VALUES ('31509a6a811ff2b1c0414a9c074cfe21', 'ly6635', '2018-06-18 12:45:06', '2018-06-18 12:45:06', '0');
INSERT INTO `denglier_base_token_log` VALUES ('3d2d4c85bcc9d44cf5e83821613bc8a1', 'ly6635', '2018-06-18 19:04:57', '2018-06-18 19:04:57', '0');
INSERT INTO `denglier_base_token_log` VALUES ('3d9aa89246f84d4ceb8e90e2fee19d5a', 'ly6635', '2018-06-18 11:53:53', '2018-06-18 11:53:53', '0');
INSERT INTO `denglier_base_token_log` VALUES ('4420c7cab6e1089d782d03d3422e8f63', 'ly6635', '2018-06-18 12:00:51', '2018-06-18 12:00:51', '0');
INSERT INTO `denglier_base_token_log` VALUES ('45d99c9bfacca475cf23e90d4d5cfd07', 'ly6635', '2018-06-15 05:17:29', '2018-06-15 01:18:04', '2');
INSERT INTO `denglier_base_token_log` VALUES ('4680dbbd4a520cc44b0e4b16c8572e8e', 'ly6635', '2018-06-15 04:18:24', '2018-06-15 04:08:34', '1');
INSERT INTO `denglier_base_token_log` VALUES ('4a2d11d8ae5845dc7a9273e49a01a995', 'ly6635', '2018-06-18 12:42:27', '2018-06-18 12:42:27', '0');
INSERT INTO `denglier_base_token_log` VALUES ('4d30aa92f6e4a8b63fb1d8ea30789ed4', 'ly6635', '2018-06-18 12:45:05', '2018-06-18 12:45:05', '0');
INSERT INTO `denglier_base_token_log` VALUES ('57dd78b3bba71b0facfeb8639e3ae594', 'ly6635', '2018-06-18 11:55:27', '2018-06-18 11:55:27', '0');
INSERT INTO `denglier_base_token_log` VALUES ('5cd0279d2dabcd428b5d58d564c32170', 'ly6635', '2018-06-18 19:31:43', '2018-06-18 19:31:43', '0');
INSERT INTO `denglier_base_token_log` VALUES ('6223330d2824f08561552504abac2ec9', 'ly6635', '2018-06-18 12:45:22', '2018-06-18 12:45:22', '0');
INSERT INTO `denglier_base_token_log` VALUES ('62fda5e406ee718c1bc33c75801bddbf', 'ly6635', '2018-06-18 12:00:51', '2018-06-18 12:00:51', '0');
INSERT INTO `denglier_base_token_log` VALUES ('6b7678d36875c53cc38b293163a80524', 'ly6635', '2018-06-15 19:00:30', '2018-06-15 19:00:37', '1');
INSERT INTO `denglier_base_token_log` VALUES ('77efe31596764b4a28a0a5b0dcf90de2', 'ly6635', '2018-06-18 12:45:05', '2018-06-18 12:45:05', '0');
INSERT INTO `denglier_base_token_log` VALUES ('7fc914e60ce705e966cf9b1b69b2bb6d', 'ly6635', '2018-06-18 18:53:53', '2018-06-18 18:53:53', '0');
INSERT INTO `denglier_base_token_log` VALUES ('81896827be8b57379b6eb3fbc216e576', 'ly6635', '2018-06-18 12:00:51', '2018-06-18 12:00:51', '0');
INSERT INTO `denglier_base_token_log` VALUES ('82736aac00ee85470d3a41317cfa59de', 'ly6635', '2018-06-18 12:00:51', '2018-06-18 12:00:51', '0');
INSERT INTO `denglier_base_token_log` VALUES ('87b14eb17c72884f43344e8331c2a66c', 'ly6635', '2018-06-18 12:45:22', '2018-06-18 12:45:22', '0');
INSERT INTO `denglier_base_token_log` VALUES ('8a2952430df04d61f977fb5336e671d0', 'ly6635', '2018-06-18 19:31:41', '2018-06-18 19:31:41', '0');
INSERT INTO `denglier_base_token_log` VALUES ('8bf552d555df66d85116d64fdb61fa4a', 'ly6635', '2018-06-18 12:02:23', '2018-06-18 12:12:28', '3');
INSERT INTO `denglier_base_token_log` VALUES ('8df889a804efc8488c78a7f9f16ed109', 'ly6635', '2018-06-18 12:44:48', '2018-06-18 12:44:48', '0');
INSERT INTO `denglier_base_token_log` VALUES ('8f46e8d7eb12bf7cc25608405d575948', 'ly6635', '2018-06-18 11:55:37', '2018-06-18 11:55:37', '0');
INSERT INTO `denglier_base_token_log` VALUES ('92cf8fae279b2c84f4dc3f19c6f40abb', 'ly6635', '2018-06-18 12:45:06', '2018-06-18 12:45:06', '0');
INSERT INTO `denglier_base_token_log` VALUES ('9845b84f38f034c3e9569f0c94aed1e0', 'ly6635', '2018-06-18 19:31:42', '2018-06-18 19:31:42', '0');
INSERT INTO `denglier_base_token_log` VALUES ('9851e667043820ecf3534170343d676b', 'ly6635', '2018-06-18 18:57:14', '2018-06-18 18:57:14', '0');
INSERT INTO `denglier_base_token_log` VALUES ('9ab69a1a4e216251845b5c25e9398f9b', 'ly6635', '2018-06-18 12:45:03', '2018-06-18 12:45:03', '0');
INSERT INTO `denglier_base_token_log` VALUES ('9b36aeb607064d7cd16c318250768971', 'ly6635', '2018-06-18 12:40:03', '2018-06-18 12:40:03', '0');
INSERT INTO `denglier_base_token_log` VALUES ('9e9aeb72395dc51d5d72c8e0ae59b78b', 'ly6635', '2018-06-18 19:31:42', '2018-06-18 19:31:42', '0');
INSERT INTO `denglier_base_token_log` VALUES ('a2d12a6adcdeb58afcf578cb453eaa61', 'ly6635', '2018-06-18 12:45:04', '2018-06-18 12:45:04', '0');
INSERT INTO `denglier_base_token_log` VALUES ('ae24154a948311c4007b3dab01220140', 'ly6635', '2018-06-18 18:51:25', '2018-06-18 18:51:25', '0');
INSERT INTO `denglier_base_token_log` VALUES ('b26efbd316c202186a081fb5ad2e742c', 'ly6635', '2018-06-18 12:45:05', '2018-06-18 12:45:05', '0');
INSERT INTO `denglier_base_token_log` VALUES ('b43f4463a2e040161ba610271dd57a67', 'ly6635', '2018-06-18 11:55:38', '2018-06-18 11:55:38', '0');
INSERT INTO `denglier_base_token_log` VALUES ('b9459c6e153303ee944ab7b0ab568acd', 'ly6635', '2018-06-18 12:11:15', '2018-06-18 12:11:15', '0');
INSERT INTO `denglier_base_token_log` VALUES ('b9de7fbc9bf06f6cb9730fe84f753f35', 'ly6635', '2018-06-18 12:00:46', '2018-06-18 12:00:46', '0');
INSERT INTO `denglier_base_token_log` VALUES ('bfb349079a361ccf4c611454e915713a', 'ly6635', '2018-06-18 12:00:51', '2018-06-18 12:00:51', '0');
INSERT INTO `denglier_base_token_log` VALUES ('c2f67912385c4bba6f9f1ca1ec1acdcf', 'ly6635', '2018-06-18 19:17:23', '2018-06-18 19:17:23', '0');
INSERT INTO `denglier_base_token_log` VALUES ('c68da09e84d105a011ece9911c377324', 'ly6635', '2018-06-18 11:55:37', '2018-06-18 11:55:37', '0');
INSERT INTO `denglier_base_token_log` VALUES ('ca3b4ff2b21ff6cc9e0934f20f969eea', 'ly6635', '2018-06-18 12:45:05', '2018-06-18 12:45:05', '0');
INSERT INTO `denglier_base_token_log` VALUES ('cbcb20c80f864e1e82d9395a40dbc4a8', 'ly6635', '2018-06-18 11:55:36', '2018-06-18 11:55:36', '0');
INSERT INTO `denglier_base_token_log` VALUES ('cc75018a255ead4e1f8a5cf846df6106', 'ly6635', '2018-06-18 11:39:46', '2018-06-18 11:40:38', '2');
INSERT INTO `denglier_base_token_log` VALUES ('d69acb8361330cc00d37a50aa055cc68', 'ly6635', '2018-06-18 19:03:16', '2018-06-18 19:03:16', '0');
INSERT INTO `denglier_base_token_log` VALUES ('dc87f1357d8f73e2ffc2a7bbf4be3c93', 'ly6635', '2018-06-18 11:39:28', '2018-06-18 11:39:32', '1');
INSERT INTO `denglier_base_token_log` VALUES ('dd5820f13f240ae02c42dcaa2caac6d1', 'ly6635', '2018-06-18 18:53:55', '2018-06-18 18:53:55', '0');
INSERT INTO `denglier_base_token_log` VALUES ('e016c6d41ca2423a1bd65e4ab4052718', 'ly6635', '2018-06-18 12:48:12', '2018-06-18 13:03:58', '8');
INSERT INTO `denglier_base_token_log` VALUES ('e177b821f77df4eff1078b3ed5fccc46', 'ly6635', '2018-06-18 12:00:50', '2018-06-18 12:00:50', '0');
INSERT INTO `denglier_base_token_log` VALUES ('e3d2e8a1c551fb722e91845d0f87fd60', 'ly6635', '2018-06-18 12:45:05', '2018-06-18 12:45:05', '0');
INSERT INTO `denglier_base_token_log` VALUES ('e59d4e88e734a70160a3ff47c1fd9596', 'ly6635', '2018-06-18 12:45:22', '2018-06-18 12:45:22', '0');
INSERT INTO `denglier_base_token_log` VALUES ('f6e0a0648dba6629026f6cfb0855f8a0', 'ly6635', '2018-06-15 05:03:01', '2018-06-15 05:03:01', '0');
INSERT INTO `denglier_base_token_log` VALUES ('f90f0fafbdef7636be212f9e7de37318', 'ly6635', '2018-06-18 12:41:40', '2018-06-18 12:41:40', '0');
INSERT INTO `denglier_base_token_log` VALUES ('fd4dd81f27f74a096e3861d790b24399', 'ly6635', '2018-06-18 11:31:07', '2018-06-18 11:31:07', '0');

-- ----------------------------
-- Table structure for denglier_base_unauth_resource
-- ----------------------------
DROP TABLE IF EXISTS `denglier_base_unauth_resource`;
CREATE TABLE `denglier_base_unauth_resource` (
  `id` varchar(30) NOT NULL COMMENT '非权限资源',
  `unauth_name` varchar(100) DEFAULT NULL COMMENT '非权限资源说明',
  `url` varchar(300) DEFAULT NULL COMMENT '请求路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of denglier_base_unauth_resource
-- ----------------------------
INSERT INTO `denglier_base_unauth_resource` VALUES ('un001', '登录', '/login');
INSERT INTO `denglier_base_unauth_resource` VALUES ('un002', '登出', '/logout');

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `caId` varchar(36) NOT NULL COMMENT 'ca Id',
  `account` varchar(50) DEFAULT NULL COMMENT '用户名',
  `name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `instituteNumber` varchar(1000) DEFAULT NULL COMMENT '机构编码',
  PRIMARY KEY (`caId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('0a8d60726cf44eb3af5557461a319949', ' 0800061711 ', ' 刘朝曦 ', '2018-03-13 18:47:34', 'WTB220104002');
INSERT INTO `user_info` VALUES ('1c896b4c8701497d960bfdeb2fb36011', ' 0800062263 ', ' 李贺 ', '2018-03-13 18:47:34', 'WTB220104002');
INSERT INTO `user_info` VALUES ('1d05ca856afd11e88e70b06ebf5f3b92', 'xiaolin', '2222', '2018-06-08 17:19:36', 'h12w3sdf');
INSERT INTO `user_info` VALUES ('2d067f9056f744b3b8150fe78eb9000c', ' 0800062000 ', ' 徐尧 ', '2018-03-13 18:47:34', 'WTB220104002');
INSERT INTO `user_info` VALUES ('690ac5e9b625432f952f76c846a0941f', ' 0800061767 ', ' 谭淋升 ', '2018-03-13 18:47:34', 'WTB220104002');
INSERT INTO `user_info` VALUES ('752ba6afaf4f4a07ba4683dd512a00af', ' 0800062325 ', ' 单雪 ', '2018-03-13 18:47:34', 'WTB220104002');
INSERT INTO `user_info` VALUES ('7d77eb05a4e14c119a23fba77d088a0b', '', '牛平平', '2018-03-13 18:47:34', 'WTB430102001');
INSERT INTO `user_info` VALUES ('8951c1f523cb4c26adbf34f34bce90e6', ' 0800062321 ', ' 綦俊 ', '2018-03-13 18:47:34', 'WTB220104002');
INSERT INTO `user_info` VALUES ('a020c1604a2a4621b49903a57841c238', ' 0800061580 ', ' 宋嘉懿 ', '2018-03-13 18:47:34', 'WTB220104002');
INSERT INTO `user_info` VALUES ('c33702772a7e4639b396ade68d8df9be', ' 0800062426 ', ' 李智 ', '2018-03-13 18:47:34', 'WTB220104002');
INSERT INTO `user_info` VALUES ('f91a819eff904ca9b4d804bb21444927', ' 0800360795 ', ' 黄东旭 ', '2018-03-13 18:47:34', 'WTB220104002');
