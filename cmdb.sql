/*
 Navicat Premium Data Transfer

 Source Server         : 10.100.9.101
 Source Server Type    : MySQL
 Source Server Version : 50646
 Source Host           : 10.100.9.101:3306
 Source Schema         : cmdb

 Target Server Type    : MySQL
 Target Server Version : 50646
 File Encoding         : 65001

 Date: 14/04/2023 16:13:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auth_group
-- ----------------------------
INSERT INTO `auth_group` VALUES (1, 'manager');

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 81 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` VALUES (14, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` VALUES (15, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` VALUES (16, 'Can view user', 4, 'view_user');
INSERT INTO `auth_permission` VALUES (17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` VALUES (24, 'Can view session', 6, 'view_session');
INSERT INTO `auth_permission` VALUES (25, 'Can add department', 7, 'add_department');
INSERT INTO `auth_permission` VALUES (26, 'Can change department', 7, 'change_department');
INSERT INTO `auth_permission` VALUES (27, 'Can delete department', 7, 'delete_department');
INSERT INTO `auth_permission` VALUES (28, 'Can view department', 7, 'view_department');
INSERT INTO `auth_permission` VALUES (29, 'Can add idc', 8, 'add_idc');
INSERT INTO `auth_permission` VALUES (30, 'Can change idc', 8, 'change_idc');
INSERT INTO `auth_permission` VALUES (31, 'Can delete idc', 8, 'delete_idc');
INSERT INTO `auth_permission` VALUES (32, 'Can view idc', 8, 'view_idc');
INSERT INTO `auth_permission` VALUES (33, 'Can add server', 9, 'add_server');
INSERT INTO `auth_permission` VALUES (34, 'Can change server', 9, 'change_server');
INSERT INTO `auth_permission` VALUES (35, 'Can delete server', 9, 'delete_server');
INSERT INTO `auth_permission` VALUES (36, 'Can view server', 9, 'view_server');
INSERT INTO `auth_permission` VALUES (37, 'Can add virtual server list', 10, 'add_virtualserverlist');
INSERT INTO `auth_permission` VALUES (38, 'Can change virtual server list', 10, 'change_virtualserverlist');
INSERT INTO `auth_permission` VALUES (39, 'Can delete virtual server list', 10, 'delete_virtualserverlist');
INSERT INTO `auth_permission` VALUES (40, 'Can view virtual server list', 10, 'view_virtualserverlist');
INSERT INTO `auth_permission` VALUES (41, 'Can add server network', 11, 'add_servernetwork');
INSERT INTO `auth_permission` VALUES (42, 'Can change server network', 11, 'change_servernetwork');
INSERT INTO `auth_permission` VALUES (43, 'Can delete server network', 11, 'delete_servernetwork');
INSERT INTO `auth_permission` VALUES (44, 'Can view server network', 11, 'view_servernetwork');
INSERT INTO `auth_permission` VALUES (45, 'Can add host store', 12, 'add_hoststore');
INSERT INTO `auth_permission` VALUES (46, 'Can change host store', 12, 'change_hoststore');
INSERT INTO `auth_permission` VALUES (47, 'Can delete host store', 12, 'delete_hoststore');
INSERT INTO `auth_permission` VALUES (48, 'Can view host store', 12, 'view_hoststore');
INSERT INTO `auth_permission` VALUES (49, 'Can add handle log', 13, 'add_handlelog');
INSERT INTO `auth_permission` VALUES (50, 'Can change handle log', 13, 'change_handlelog');
INSERT INTO `auth_permission` VALUES (51, 'Can delete handle log', 13, 'delete_handlelog');
INSERT INTO `auth_permission` VALUES (52, 'Can view handle log', 13, 'view_handlelog');
INSERT INTO `auth_permission` VALUES (53, 'Can add disk', 14, 'add_disk');
INSERT INTO `auth_permission` VALUES (54, 'Can change disk', 14, 'change_disk');
INSERT INTO `auth_permission` VALUES (55, 'Can delete disk', 14, 'delete_disk');
INSERT INTO `auth_permission` VALUES (56, 'Can view disk', 14, 'view_disk');
INSERT INTO `auth_permission` VALUES (57, 'Can add mount', 15, 'add_mount');
INSERT INTO `auth_permission` VALUES (58, 'Can change mount', 15, 'change_mount');
INSERT INTO `auth_permission` VALUES (59, 'Can delete mount', 15, 'delete_mount');
INSERT INTO `auth_permission` VALUES (60, 'Can view mount', 15, 'view_mount');
INSERT INTO `auth_permission` VALUES (61, 'Can add user', 16, 'add_user');
INSERT INTO `auth_permission` VALUES (62, 'Can change user', 16, 'change_user');
INSERT INTO `auth_permission` VALUES (63, 'Can delete user', 16, 'delete_user');
INSERT INTO `auth_permission` VALUES (64, 'Can view user', 16, 'view_user');
INSERT INTO `auth_permission` VALUES (65, 'Can add group', 17, 'add_group');
INSERT INTO `auth_permission` VALUES (66, 'Can change group', 17, 'change_group');
INSERT INTO `auth_permission` VALUES (67, 'Can delete group', 17, 'delete_group');
INSERT INTO `auth_permission` VALUES (68, 'Can view group', 17, 'view_group');
INSERT INTO `auth_permission` VALUES (69, 'Can add menu', 18, 'add_menu');
INSERT INTO `auth_permission` VALUES (70, 'Can change menu', 18, 'change_menu');
INSERT INTO `auth_permission` VALUES (71, 'Can delete menu', 18, 'delete_menu');
INSERT INTO `auth_permission` VALUES (72, 'Can view menu', 18, 'view_menu');
INSERT INTO `auth_permission` VALUES (73, 'Can add permission', 19, 'add_permission');
INSERT INTO `auth_permission` VALUES (74, 'Can change permission', 19, 'change_permission');
INSERT INTO `auth_permission` VALUES (75, 'Can delete permission', 19, 'delete_permission');
INSERT INTO `auth_permission` VALUES (76, 'Can view permission', 19, 'view_permission');
INSERT INTO `auth_permission` VALUES (77, 'Can add role', 20, 'add_role');
INSERT INTO `auth_permission` VALUES (78, 'Can change role', 20, 'change_role');
INSERT INTO `auth_permission` VALUES (79, 'Can delete role', 20, 'delete_role');
INSERT INTO `auth_permission` VALUES (80, 'Can view role', 20, 'view_role');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES (1, 'pbkdf2_sha256$216000$sEeTFBGd2xXN$1YkGLpkTK3UCtgusewbBTvDuf9V05I+AP3ibtRj0Rqg=', '2023-04-14 13:16:44.023486', 1, 'admin', '', '', 'admin@qq.com', 1, 1, '2023-04-14 13:06:13.070445');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for cmdbapi_department
-- ----------------------------
DROP TABLE IF EXISTS `cmdbapi_department`;
CREATE TABLE `cmdbapi_department`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cmdbapi_department
-- ----------------------------
INSERT INTO `cmdbapi_department` VALUES (1, '运维部');

-- ----------------------------
-- Table structure for cmdbapi_disk
-- ----------------------------
DROP TABLE IF EXISTS `cmdbapi_disk`;
CREATE TABLE `cmdbapi_disk`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `slot` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `model` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `capacity` double NULL DEFAULT NULL,
  `pd_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `desc` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `server_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cmdbapi_disk_server_id_f3f34750_fk_cmdbapi_server_id`(`server_id`) USING BTREE,
  CONSTRAINT `cmdbapi_disk_server_id_f3f34750_fk_cmdbapi_server_id` FOREIGN KEY (`server_id`) REFERENCES `cmdbapi_server` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cmdbapi_disk
-- ----------------------------

-- ----------------------------
-- Table structure for cmdbapi_handlelog
-- ----------------------------
DROP TABLE IF EXISTS `cmdbapi_handlelog`;
CREATE TABLE `cmdbapi_handlelog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `create_at` datetime(6) NOT NULL,
  `servers_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cmdbapi_handlelog_servers_id_5ed63bc4_fk_cmdbapi_server_id`(`servers_id`) USING BTREE,
  CONSTRAINT `cmdbapi_handlelog_servers_id_5ed63bc4_fk_cmdbapi_server_id` FOREIGN KEY (`servers_id`) REFERENCES `cmdbapi_server` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cmdbapi_handlelog
-- ----------------------------

-- ----------------------------
-- Table structure for cmdbapi_hoststore
-- ----------------------------
DROP TABLE IF EXISTS `cmdbapi_hoststore`;
CREATE TABLE `cmdbapi_hoststore`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `store_size` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `store_free` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `store_used_percent` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `desc` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `host_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cmdbapi_hoststore_host_id_e899f147_fk_cmdbapi_server_id`(`host_id`) USING BTREE,
  CONSTRAINT `cmdbapi_hoststore_host_id_e899f147_fk_cmdbapi_server_id` FOREIGN KEY (`host_id`) REFERENCES `cmdbapi_server` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cmdbapi_hoststore
-- ----------------------------

-- ----------------------------
-- Table structure for cmdbapi_idc
-- ----------------------------
DROP TABLE IF EXISTS `cmdbapi_idc`;
CREATE TABLE `cmdbapi_idc`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `address` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `desc` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `floor` int(11) NULL DEFAULT NULL,
  `region` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cmdbapi_idc
-- ----------------------------
INSERT INTO `cmdbapi_idc` VALUES (1, '天津', '天津机房', '天津机房', 3, '华北');
INSERT INTO `cmdbapi_idc` VALUES (2, '枣庄机房', '枣庄', '枣庄机房', 4, '华东');

-- ----------------------------
-- Table structure for cmdbapi_mount
-- ----------------------------
DROP TABLE IF EXISTS `cmdbapi_mount`;
CREATE TABLE `cmdbapi_mount`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `disk_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `disk_size` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `server_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cmdbapi_mount_server_id_2dc84d39_fk_cmdbapi_server_id`(`server_id`) USING BTREE,
  CONSTRAINT `cmdbapi_mount_server_id_2dc84d39_fk_cmdbapi_server_id` FOREIGN KEY (`server_id`) REFERENCES `cmdbapi_server` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cmdbapi_mount
-- ----------------------------
INSERT INTO `cmdbapi_mount` VALUES (1, '/', '100', 1);

-- ----------------------------
-- Table structure for cmdbapi_server
-- ----------------------------
DROP TABLE IF EXISTS `cmdbapi_server`;
CREATE TABLE `cmdbapi_server`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `hostname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `cpu` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `cpu_model` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `memory` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `system` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `kernelrelease` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `manufacturer` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `productname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `serialnumber` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `server_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `desc` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `department_id` int(11) NOT NULL,
  `idc_id` int(11) NULL DEFAULT NULL,
  `create_at` datetime(6) NULL DEFAULT NULL,
  `update_at` datetime(6) NULL DEFAULT NULL,
  `is_virtual` tinyint(1) NOT NULL,
  `uuid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cmdbapi_server_department_id_6d288f8d_fk_cmdbapi_department_id`(`department_id`) USING BTREE,
  INDEX `cmdbapi_server_idc_id_df445f14_fk_cmdbapi_idc_id`(`idc_id`) USING BTREE,
  CONSTRAINT `cmdbapi_server_department_id_6d288f8d_fk_cmdbapi_department_id` FOREIGN KEY (`department_id`) REFERENCES `cmdbapi_department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cmdbapi_server_idc_id_df445f14_fk_cmdbapi_idc_id` FOREIGN KEY (`idc_id`) REFERENCES `cmdbapi_idc` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cmdbapi_server
-- ----------------------------
INSERT INTO `cmdbapi_server` VALUES (1, 'server1', 'server1', '32', 'Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz', '65536', 'ubuntu', '5.15.0-46-generic', 'Dell Inc.', 'PowerEdge R720', 'J1TZ252', 'on', '1', '服务器1', 1, 1, '2023-04-14 13:48:15.000000', '2023-04-14 16:09:53.953094', 0, '4c4c4544-0031-5410-805a-cac04f323532');
INSERT INTO `cmdbapi_server` VALUES (2, 'server2', 'server2', '32', 'Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz', '65536', 'ubuntu', '5.15.0-46-generic', 'Dell Inc.', 'PowerEdge R720', 'J1TZ253', 'on', '1', '服务器2', 1, 1, '2023-04-14 13:57:37.000000', '2023-04-14 13:57:37.000000', 0, '4c4c4544-0031-5410-805a-cac04f323545');
INSERT INTO `cmdbapi_server` VALUES (3, 'server3', 'server3', '32', 'Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz', '65536', 'ubuntu', '5.15.0-46-generic', 'Dell Inc.', 'PowerEdge R720', 'J1TZ253', 'on', '1', '服务器3', 1, 1, '2023-04-14 13:57:57.000000', '2023-04-14 13:57:57.000000', 0, '4c4c4544-0031-5410-805a-cac04f323567');
INSERT INTO `cmdbapi_server` VALUES (4, 'server4', 'server4', '32', 'Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz', '65536', 'ubuntu', '5.15.0-46-generic', 'Dell Inc.', 'PowerEdge R720', 'J1TZ253', 'on', '1', '服务器4', 1, 1, '2023-04-14 14:41:57.000000', '2023-04-14 14:41:57.000000', 0, '4c4c4544-0031-5410-805a-cac04f323568');
INSERT INTO `cmdbapi_server` VALUES (5, 'server5', 'server5', '32', 'Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz', '65536', 'ubuntu', '5.15.0-46-generic', 'Dell Inc.', 'PowerEdge R720', 'J1TZ253', 'on', '1', '服务器5', 1, 2, '2023-04-14 14:41:57.000000', '2023-04-14 14:41:57.000000', 0, '4c4c4544-0031-5410-805a-cac04f323569');
INSERT INTO `cmdbapi_server` VALUES (6, 'server5', 'server5', '32', 'Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz', '65536', 'ubuntu', '5.15.0-46-generic', 'Dell Inc.', 'PowerEdge R720', 'J1TZ253', 'on', '1', '服务器6', 1, 2, '2023-04-14 14:41:57.000000', '2023-04-14 14:41:57.000000', 0, '4c4c4544-0031-5410-805a-cac04f323100');
INSERT INTO `cmdbapi_server` VALUES (7, 'server6', 'server6', '32', 'Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz', '65536', 'ubuntu', '5.15.0-46-generic', 'Dell Inc.', 'PowerEdge R720', 'J1TZ253', 'on', '1', '服务器7', 1, 2, '2023-04-14 14:41:57.000000', '2023-04-14 14:41:57.000000', 0, '4c4c4544-0031-5410-805a-cac04f323101');
INSERT INTO `cmdbapi_server` VALUES (8, 'server7', 'server7', '32', 'Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz', '65536', 'ubuntu', '5.15.0-46-generic', 'Dell Inc.', 'PowerEdge R720', 'J1TZ253', 'on', '1', '服务器8', 1, 2, '2023-04-14 14:41:57.000000', '2023-04-14 14:41:57.000000', 0, '4c4c4544-0031-5410-805a-cac04f323102');
INSERT INTO `cmdbapi_server` VALUES (9, 'server8', 'server8', '32', 'Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz', '65536', 'ubuntu', '5.15.0-46-generic', 'Dell Inc.', 'PowerEdge R720', 'J1TZ253', 'on', '1', '服务器9', 1, 1, '2023-04-14 14:41:57.000000', '2023-04-14 14:41:57.000000', 0, '4c4c4544-0031-5410-805a-cac04f323103');
INSERT INTO `cmdbapi_server` VALUES (10, 'server9', 'server9', '32', 'Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz', '65536', 'ubuntu', '5.15.0-46-generic', 'Dell Inc.', 'PowerEdge R720', 'J1TZ253', 'on', '1', '服务器10', 1, 1, '2023-04-14 14:41:57.000000', '2023-04-14 14:41:57.000000', 0, '4c4c4544-0031-5410-805a-cac04f323104');
INSERT INTO `cmdbapi_server` VALUES (11, 'server10', 'server10', '32', 'Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz', '65536', 'ubuntu', '5.15.0-46-generic', 'Dell Inc.', 'PowerEdge R720', 'J1TZ253', 'on', '1', '服务器11', 1, 2, '2023-04-14 14:41:57.000000', '2023-04-14 14:41:57.000000', 0, '4c4c4544-0031-5410-805a-cac04f323105');
INSERT INTO `cmdbapi_server` VALUES (12, 'server11', 'server11', '32', 'Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz', '65536', 'ubuntu', '5.15.0-46-generic', 'Dell Inc.', 'PowerEdge R720', 'J1TZ253', 'on', '1', '服务器12', 1, 1, '2023-04-14 14:41:57.000000', '2023-04-14 14:41:57.000000', 0, '4c4c4544-0031-5410-805a-cac04f323106');
INSERT INTO `cmdbapi_server` VALUES (13, 'server12', 'server12', '32', 'Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz', '65536', 'ubuntu', '5.15.0-46-generic', 'Dell Inc.', 'PowerEdge R720', 'J1TZ253', 'on', '1', '服务器13', 1, 1, '2023-04-14 14:41:57.000000', '2023-04-14 14:41:57.000000', 0, '4c4c4544-0031-5410-805a-cac04f323107');
INSERT INTO `cmdbapi_server` VALUES (14, 'server13', 'server13', '32', 'Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz', '65536', 'ubuntu', '5.15.0-46-generic', 'Dell Inc.', 'PowerEdge R720', 'J1TZ253', 'on', '1', '服务器14', 1, 2, '2023-04-14 14:41:57.000000', '2023-04-14 14:41:57.000000', 0, '4c4c4544-0031-5410-805a-cac04f323108');
INSERT INTO `cmdbapi_server` VALUES (15, 'server14', 'server14', '32', 'Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz', '65536', 'ubuntu', '5.15.0-46-generic', 'Dell Inc.', 'PowerEdge R720', 'J1TZ253', 'on', '1', '服务器15', 1, 1, '2023-04-14 14:41:57.000000', '2023-04-14 14:41:57.000000', 0, '4c4c4544-0031-5410-805a-cac04f323109');
INSERT INTO `cmdbapi_server` VALUES (16, 'server15', 'server15', '32', 'Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz', '65536', 'ubuntu', '5.15.0-46-generic', 'Dell Inc.', 'PowerEdge R720', 'J1TZ253', 'on', '1', '服务器16', 1, 1, '2023-04-14 14:41:57.000000', '2023-04-14 14:41:57.000000', 0, '4c4c4544-0031-5410-805a-cac04f323112');
INSERT INTO `cmdbapi_server` VALUES (17, 'server16', 'server16', '32', 'Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz', '65536', 'ubuntu', '5.15.0-46-generic', 'Dell Inc.', 'PowerEdge R720', 'J1TZ253', 'on', '1', '服务器17', 1, 1, '2023-04-14 14:41:57.000000', '2023-04-14 14:41:57.000000', 0, '4c4c4544-0031-5410-805a-cac04f323114');

-- ----------------------------
-- Table structure for cmdbapi_servernetwork
-- ----------------------------
DROP TABLE IF EXISTS `cmdbapi_servernetwork`;
CREATE TABLE `cmdbapi_servernetwork`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `interface` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ipaddress` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `hwaddr` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `netmask` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `state` tinyint(1) NOT NULL,
  `desc` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `server_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cmdbapi_servernetwork_server_id_32d1dce0_fk_cmdbapi_server_id`(`server_id`) USING BTREE,
  CONSTRAINT `cmdbapi_servernetwork_server_id_32d1dce0_fk_cmdbapi_server_id` FOREIGN KEY (`server_id`) REFERENCES `cmdbapi_server` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cmdbapi_servernetwork
-- ----------------------------
INSERT INTO `cmdbapi_servernetwork` VALUES (1, 'eth0', '192.168.100.100', '02:42:40:5e:51:ed', '255.255.255.0', 1, '网卡1', 1);
INSERT INTO `cmdbapi_servernetwork` VALUES (2, 'eth0', '192.168.100.101', '6a:ab:b6:c0:4b:cd', '255.255.255.0', 1, '网卡1', 2);
INSERT INTO `cmdbapi_servernetwork` VALUES (3, 'eth0', '192.168.100.103', '6a:ab:b6:c0:4b:33', '255.255.255.0', 1, '网卡2', 3);
INSERT INTO `cmdbapi_servernetwork` VALUES (4, 'eth0', '192.168.100.104', '6a:ab:b6:c0:4b:33', '255.255.255.0', 1, '网卡2', 4);
INSERT INTO `cmdbapi_servernetwork` VALUES (5, 'eth0', '192.168.100.105', '6a:ab:b6:c0:4b:34', '255.255.255.0', 1, '网卡2', 5);
INSERT INTO `cmdbapi_servernetwork` VALUES (6, 'eth0', '192.168.100.106', '6a:ab:b6:c0:4b:35', '255.255.255.0', 1, '网卡2', 6);
INSERT INTO `cmdbapi_servernetwork` VALUES (7, 'eth0', '192.168.100.107', '6a:ab:b6:c0:4b:36', '255.255.255.0', 1, '网卡2', 7);
INSERT INTO `cmdbapi_servernetwork` VALUES (8, 'eth0', '192.168.100.108', '6a:ab:b6:c0:4b:37', '255.255.255.0', 1, '网卡2', 8);
INSERT INTO `cmdbapi_servernetwork` VALUES (9, 'eth0', '192.168.100.109', '6a:ab:b6:c0:4b:38', '255.255.255.0', 1, '网卡2', 9);
INSERT INTO `cmdbapi_servernetwork` VALUES (10, 'eth0', '192.168.100.110', '6a:ab:b6:c0:4b:39', '255.255.255.0', 1, '网卡2', 10);
INSERT INTO `cmdbapi_servernetwork` VALUES (11, 'eth0', '192.168.100.111', '6a:ab:b6:c0:4b:55', '255.255.255.0', 1, '网卡2', 11);
INSERT INTO `cmdbapi_servernetwork` VALUES (12, 'eth0', '192.168.100.112', '6a:ab:b6:c0:4b:56', '255.255.255.0', 1, '网卡2', 12);
INSERT INTO `cmdbapi_servernetwork` VALUES (13, 'eth0', '192.168.100.113', '6a:ab:b6:c0:4b:57', '255.255.255.0', 1, '网卡2', 13);
INSERT INTO `cmdbapi_servernetwork` VALUES (14, 'eth0', '192.168.100.114', '6a:ab:b6:c0:4b:58', '255.255.255.0', 1, '网卡2', 14);
INSERT INTO `cmdbapi_servernetwork` VALUES (15, 'eth0', '192.168.100.115', '6a:ab:b6:c0:4b:59', '255.255.255.0', 1, '网卡2', 15);
INSERT INTO `cmdbapi_servernetwork` VALUES (16, 'eth0', '192.168.100.116', '6a:ab:b6:c0:4b:66', '255.255.255.0', 1, '网卡2', 16);
INSERT INTO `cmdbapi_servernetwork` VALUES (17, 'eth0', '192.168.100.117', '6a:ab:b6:c0:4b:67', '255.255.255.0', 1, '网卡2', 17);

-- ----------------------------
-- Table structure for cmdbapi_virtualserverlist
-- ----------------------------
DROP TABLE IF EXISTS `cmdbapi_virtualserverlist`;
CREATE TABLE `cmdbapi_virtualserverlist`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `power_state` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `vm_state` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `boot_time` datetime(6) NULL DEFAULT NULL,
  `resourcePool` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `folder` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `desc` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `host_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cmdbapi_virtualserverlist_host_id_c985be03_fk_cmdbapi_server_id`(`host_id`) USING BTREE,
  CONSTRAINT `cmdbapi_virtualserverlist_host_id_c985be03_fk_cmdbapi_server_id` FOREIGN KEY (`host_id`) REFERENCES `cmdbapi_server` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cmdbapi_virtualserverlist
-- ----------------------------

-- ----------------------------
-- Table structure for cmdbweb_group
-- ----------------------------
DROP TABLE IF EXISTS `cmdbweb_group`;
CREATE TABLE `cmdbweb_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cmdbweb_group
-- ----------------------------
INSERT INTO `cmdbweb_group` VALUES (1, 'manager');

-- ----------------------------
-- Table structure for cmdbweb_user
-- ----------------------------
DROP TABLE IF EXISTS `cmdbweb_user`;
CREATE TABLE `cmdbweb_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `group_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cmdbweb_user_group_id_b6c9cf7e_fk_cmdbweb_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `cmdbweb_user_group_id_b6c9cf7e_fk_cmdbweb_group_id` FOREIGN KEY (`group_id`) REFERENCES `cmdbweb_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cmdbweb_user
-- ----------------------------
INSERT INTO `cmdbweb_user` VALUES (1, 'admin', '123456', 'admin@163.com', '13611111111', 'avatars/20230414/20230414-131957.jpg', 1);
INSERT INTO `cmdbweb_user` VALUES (2, 'test1', '123456', 'test1@qq.com', '13622222222', 'avatars/default.jpg', 1);

-- ----------------------------
-- Table structure for cmdbweb_user_roles
-- ----------------------------
DROP TABLE IF EXISTS `cmdbweb_user_roles`;
CREATE TABLE `cmdbweb_user_roles`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `cmdbweb_user_roles_user_id_role_id_12a1dcee_uniq`(`user_id`, `role_id`) USING BTREE,
  INDEX `cmdbweb_user_roles_role_id_c1f22236_fk_rbac_role_id`(`role_id`) USING BTREE,
  CONSTRAINT `cmdbweb_user_roles_role_id_c1f22236_fk_rbac_role_id` FOREIGN KEY (`role_id`) REFERENCES `rbac_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cmdbweb_user_roles_user_id_a9113628_fk_cmdbweb_user_id` FOREIGN KEY (`user_id`) REFERENCES `cmdbweb_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cmdbweb_user_roles
-- ----------------------------
INSERT INTO `cmdbweb_user_roles` VALUES (1, 1, 1);

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (1, '2023-04-14 13:18:18.836379', '1', '查看服务器列表', 1, '[{\"added\": {}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (2, '2023-04-14 13:18:24.195341', '1', 'manager', 1, '[{\"added\": {}}]', 20, 1);
INSERT INTO `django_admin_log` VALUES (3, '2023-04-14 13:21:56.929413', '1', 'admin', 1, '[{\"added\": {}}]', 16, 1);
INSERT INTO `django_admin_log` VALUES (4, '2023-04-14 13:28:21.766615', '1', '主机列表', 1, '[{\"added\": {}}]', 18, 1);
INSERT INTO `django_admin_log` VALUES (5, '2023-04-14 13:28:33.873232', '1', '查看服务器列表', 2, '[{\"changed\": {\"fields\": [\"\\u6240\\u5c5e\\u83dc\\u5355\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (6, '2023-04-14 13:29:24.473325', '1', '服务器', 2, '[{\"changed\": {\"fields\": [\"\\u6807\\u9898\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (7, '2023-04-14 13:33:35.489813', '2', '用户中心', 1, '[{\"added\": {}}]', 18, 1);
INSERT INTO `django_admin_log` VALUES (8, '2023-04-14 13:35:14.622284', '2', '虚拟机', 1, '[{\"added\": {}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (9, '2023-04-14 13:36:19.083764', '1', 'manager', 2, '[{\"changed\": {\"fields\": [\"\\u62e5\\u6709\\u7684\\u6240\\u6709\\u6743\\u9650\"]}}]', 20, 1);
INSERT INTO `django_admin_log` VALUES (10, '2023-04-14 13:36:53.612460', '3', '权限管理', 1, '[{\"added\": {}}]', 18, 1);
INSERT INTO `django_admin_log` VALUES (11, '2023-04-14 13:37:50.849859', '3', '权限列表', 1, '[{\"added\": {}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (12, '2023-04-14 13:38:00.857342', '1', 'manager', 2, '[{\"changed\": {\"fields\": [\"\\u62e5\\u6709\\u7684\\u6240\\u6709\\u6743\\u9650\"]}}]', 20, 1);
INSERT INTO `django_admin_log` VALUES (13, '2023-04-14 13:39:57.902058', '4', '用户管理', 1, '[{\"added\": {}}]', 18, 1);
INSERT INTO `django_admin_log` VALUES (14, '2023-04-14 13:40:33.680247', '4', '用户列表', 1, '[{\"added\": {}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (15, '2023-04-14 13:40:41.082317', '1', 'manager', 2, '[{\"changed\": {\"fields\": [\"\\u62e5\\u6709\\u7684\\u6240\\u6709\\u6743\\u9650\"]}}]', 20, 1);
INSERT INTO `django_admin_log` VALUES (16, '2023-04-14 13:41:47.892796', '3', '权限列表', 2, '[{\"changed\": {\"fields\": [\"\\u542b\\u6b63\\u5219\\u7684URL\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (17, '2023-04-14 13:42:00.120853', '4', '用户列表', 2, '[{\"changed\": {\"fields\": [\"\\u542b\\u6b63\\u5219\\u7684URL\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (18, '2023-04-14 13:53:48.475815', '5', '添加用户', 1, '[{\"added\": {}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (19, '2023-04-14 13:54:11.114302', '1', 'manager', 2, '[{\"changed\": {\"fields\": [\"\\u62e5\\u6709\\u7684\\u6240\\u6709\\u6743\\u9650\"]}}]', 20, 1);
INSERT INTO `django_admin_log` VALUES (20, '2023-04-14 13:54:44.538011', '5', '添加用户', 2, '[{\"changed\": {\"fields\": [\"\\u6240\\u5c5e\\u83dc\\u5355\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (21, '2023-04-14 13:55:49.697277', '5', '添加用户', 2, '[{\"changed\": {\"fields\": [\"\\u542b\\u6b63\\u5219\\u7684URL\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (22, '2023-04-14 14:02:29.811957', '6', '查看服务器详情', 1, '[{\"added\": {}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (23, '2023-04-14 14:02:35.919577', '1', 'manager', 2, '[{\"changed\": {\"fields\": [\"\\u62e5\\u6709\\u7684\\u6240\\u6709\\u6743\\u9650\"]}}]', 20, 1);
INSERT INTO `django_admin_log` VALUES (24, '2023-04-14 14:08:22.262284', '6', '查看服务器详情', 2, '[{\"changed\": {\"fields\": [\"\\u542b\\u6b63\\u5219\\u7684URL\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (25, '2023-04-14 14:09:22.652337', '1', '服务器', 2, '[{\"changed\": {\"fields\": [\"URL\\u522b\\u540d\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (26, '2023-04-14 14:09:28.330952', '2', '虚拟机', 2, '[{\"changed\": {\"fields\": [\"URL\\u522b\\u540d\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (27, '2023-04-14 14:09:42.472733', '3', '权限列表', 2, '[{\"changed\": {\"fields\": [\"URL\\u522b\\u540d\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (28, '2023-04-14 14:09:51.790702', '4', '用户列表', 2, '[{\"changed\": {\"fields\": [\"URL\\u522b\\u540d\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (29, '2023-04-14 14:10:07.154498', '5', '添加用户', 2, '[{\"changed\": {\"fields\": [\"URL\\u522b\\u540d\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (30, '2023-04-14 14:10:14.840761', '6', '查看服务器详情', 2, '[{\"changed\": {\"fields\": [\"URL\\u522b\\u540d\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (31, '2023-04-14 14:12:16.521869', '6', '查看服务器详情', 2, '[{\"changed\": {\"fields\": [\"\\u5173\\u8054\\u7684\\u6743\\u9650\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (32, '2023-04-14 14:12:52.654511', '6', '查看服务器详情', 2, '[{\"changed\": {\"fields\": [\"\\u6240\\u5c5e\\u83dc\\u5355\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (33, '2023-04-14 14:13:30.902974', '6', '查看服务器详情', 2, '[{\"changed\": {\"fields\": [\"\\u542b\\u6b63\\u5219\\u7684URL\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (34, '2023-04-14 14:14:01.903259', '6', '查看服务器详情', 2, '[{\"changed\": {\"fields\": [\"\\u6240\\u5c5e\\u83dc\\u5355\", \"\\u5173\\u8054\\u7684\\u6743\\u9650\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (35, '2023-04-14 14:15:02.194551', '6', '查看服务器详情', 2, '[{\"changed\": {\"fields\": [\"URL\\u522b\\u540d\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (36, '2023-04-14 14:25:09.360738', '6', '查看服务器详情', 2, '[{\"changed\": {\"fields\": [\"URL\\u522b\\u540d\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (37, '2023-04-14 15:50:36.195278', '6', '查看服务器详情', 2, '[{\"changed\": {\"fields\": [\"\\u542b\\u6b63\\u5219\\u7684URL\", \"URL\\u522b\\u540d\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (38, '2023-04-14 15:55:10.540894', '1', 'manager', 2, '[]', 20, 1);
INSERT INTO `django_admin_log` VALUES (39, '2023-04-14 16:05:42.282873', '6', '查看服务器详情', 2, '[{\"changed\": {\"fields\": [\"URL\\u522b\\u540d\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (40, '2023-04-14 16:06:08.930355', '6', '服务器详情', 2, '[{\"changed\": {\"fields\": [\"\\u6807\\u9898\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (41, '2023-04-14 16:06:17.326269', '5', '添加用户', 2, '[{\"changed\": {\"fields\": [\"URL\\u522b\\u540d\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (42, '2023-04-14 16:06:22.366908', '4', '用户列表', 2, '[{\"changed\": {\"fields\": [\"URL\\u522b\\u540d\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (43, '2023-04-14 16:06:31.549640', '1', '服务器', 2, '[{\"changed\": {\"fields\": [\"URL\\u522b\\u540d\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (44, '2023-04-14 16:06:35.667919', '2', '虚拟机', 2, '[{\"changed\": {\"fields\": [\"URL\\u522b\\u540d\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (45, '2023-04-14 16:06:40.053170', '3', '权限列表', 2, '[{\"changed\": {\"fields\": [\"URL\\u522b\\u540d\"]}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (46, '2023-04-14 16:09:11.433179', '7', '编辑服务器', 1, '[{\"added\": {}}]', 19, 1);
INSERT INTO `django_admin_log` VALUES (47, '2023-04-14 16:09:17.846177', '1', 'manager', 2, '[{\"changed\": {\"fields\": [\"\\u62e5\\u6709\\u7684\\u6240\\u6709\\u6743\\u9650\"]}}]', 20, 1);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (7, 'cmdbapi', 'department');
INSERT INTO `django_content_type` VALUES (14, 'cmdbapi', 'disk');
INSERT INTO `django_content_type` VALUES (13, 'cmdbapi', 'handlelog');
INSERT INTO `django_content_type` VALUES (12, 'cmdbapi', 'hoststore');
INSERT INTO `django_content_type` VALUES (8, 'cmdbapi', 'idc');
INSERT INTO `django_content_type` VALUES (15, 'cmdbapi', 'mount');
INSERT INTO `django_content_type` VALUES (9, 'cmdbapi', 'server');
INSERT INTO `django_content_type` VALUES (11, 'cmdbapi', 'servernetwork');
INSERT INTO `django_content_type` VALUES (10, 'cmdbapi', 'virtualserverlist');
INSERT INTO `django_content_type` VALUES (17, 'cmdbweb', 'group');
INSERT INTO `django_content_type` VALUES (16, 'cmdbweb', 'user');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (18, 'rbac', 'menu');
INSERT INTO `django_content_type` VALUES (19, 'rbac', 'permission');
INSERT INTO `django_content_type` VALUES (20, 'rbac', 'role');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2023-04-14 12:53:29.818814');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2023-04-14 12:53:29.935087');
INSERT INTO `django_migrations` VALUES (3, 'admin', '0001_initial', '2023-04-14 12:53:30.343236');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2023-04-14 12:53:30.406668');
INSERT INTO `django_migrations` VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2023-04-14 12:53:30.422666');
INSERT INTO `django_migrations` VALUES (6, 'contenttypes', '0002_remove_content_type_name', '2023-04-14 12:53:30.486797');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0002_alter_permission_name_max_length', '2023-04-14 12:53:30.524588');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0003_alter_user_email_max_length', '2023-04-14 12:53:30.560703');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0004_alter_user_username_opts', '2023-04-14 12:53:30.576601');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0005_alter_user_last_login_null', '2023-04-14 12:53:30.608982');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0006_require_contenttypes_0002', '2023-04-14 12:53:30.612433');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0007_alter_validators_add_error_messages', '2023-04-14 12:53:30.627663');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0008_alter_user_username_max_length', '2023-04-14 12:53:30.662181');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0009_alter_user_last_name_max_length', '2023-04-14 12:53:30.697484');
INSERT INTO `django_migrations` VALUES (15, 'auth', '0010_alter_group_name_max_length', '2023-04-14 12:53:30.733635');
INSERT INTO `django_migrations` VALUES (16, 'auth', '0011_update_proxy_permissions', '2023-04-14 12:53:30.749618');
INSERT INTO `django_migrations` VALUES (17, 'auth', '0012_alter_user_first_name_max_length', '2023-04-14 12:53:30.778219');
INSERT INTO `django_migrations` VALUES (18, 'cmdbapi', '0001_initial', '2023-04-14 12:53:30.869349');
INSERT INTO `django_migrations` VALUES (19, 'cmdbapi', '0002_auto_20200813_1359', '2023-04-14 12:53:31.131016');
INSERT INTO `django_migrations` VALUES (20, 'cmdbapi', '0003_auto_20200813_1541', '2023-04-14 12:53:31.178489');
INSERT INTO `django_migrations` VALUES (21, 'cmdbapi', '0004_auto_20200813_1628', '2023-04-14 12:53:31.239265');
INSERT INTO `django_migrations` VALUES (22, 'cmdbapi', '0005_auto_20200818_2057', '2023-04-14 12:53:31.340966');
INSERT INTO `django_migrations` VALUES (23, 'cmdbapi', '0006_auto_20200818_2110', '2023-04-14 12:53:31.424300');
INSERT INTO `django_migrations` VALUES (24, 'cmdbapi', '0007_server_is_virtual', '2023-04-14 12:53:31.473414');
INSERT INTO `django_migrations` VALUES (25, 'cmdbapi', '0008_auto_20200825_1222', '2023-04-14 12:53:31.511920');
INSERT INTO `django_migrations` VALUES (26, 'cmdbapi', '0009_auto_20200916_1543', '2023-04-14 12:53:31.565300');
INSERT INTO `django_migrations` VALUES (27, 'cmdbapi', '0010_auto_20200916_1712', '2023-04-14 12:53:31.607930');
INSERT INTO `django_migrations` VALUES (28, 'cmdbapi', '0011_server_uuid', '2023-04-14 12:53:31.639234');
INSERT INTO `django_migrations` VALUES (29, 'rbac', '0001_initial', '2023-04-14 12:53:31.700583');
INSERT INTO `django_migrations` VALUES (30, 'rbac', '0002_permission_method', '2023-04-14 12:53:31.794398');
INSERT INTO `django_migrations` VALUES (31, 'rbac', '0003_auto_20200827_1050', '2023-04-14 12:53:31.811284');
INSERT INTO `django_migrations` VALUES (32, 'cmdbweb', '0001_initial', '2023-04-14 12:53:31.827750');
INSERT INTO `django_migrations` VALUES (33, 'cmdbweb', '0002_auto_20200827_1421', '2023-04-14 12:53:31.868564');
INSERT INTO `django_migrations` VALUES (34, 'cmdbweb', '0003_auto_20200916_1713', '2023-04-14 12:53:31.950004');
INSERT INTO `django_migrations` VALUES (35, 'cmdbweb', '0004_auto_20200916_1715', '2023-04-14 12:53:32.077413');
INSERT INTO `django_migrations` VALUES (36, 'cmdbweb', '0005_auto_20230414_1159', '2023-04-14 12:53:32.087320');
INSERT INTO `django_migrations` VALUES (37, 'rbac', '0004_auto_20200827_1435', '2023-04-14 12:53:32.138008');
INSERT INTO `django_migrations` VALUES (38, 'sessions', '0001_initial', '2023-04-14 12:53:32.156793');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of django_session
-- ----------------------------

-- ----------------------------
-- Table structure for rbac_menu
-- ----------------------------
DROP TABLE IF EXISTS `rbac_menu`;
CREATE TABLE `rbac_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `icon` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of rbac_menu
-- ----------------------------
INSERT INTO `rbac_menu` VALUES (1, '主机列表', 'server');
INSERT INTO `rbac_menu` VALUES (2, '用户中心', '1');
INSERT INTO `rbac_menu` VALUES (3, '权限管理', '123');
INSERT INTO `rbac_menu` VALUES (4, '用户管理', '111');

-- ----------------------------
-- Table structure for rbac_permission
-- ----------------------------
DROP TABLE IF EXISTS `rbac_permission`;
CREATE TABLE `rbac_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `menu_id` int(11) NULL DEFAULT NULL,
  `pid_id` int(11) NULL DEFAULT NULL,
  `action` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `rbac_permission_menu_id_3dcc68be_fk_rbac_menu_id`(`menu_id`) USING BTREE,
  INDEX `rbac_permission_pid_id_6939354d_fk_rbac_permission_id`(`pid_id`) USING BTREE,
  CONSTRAINT `rbac_permission_menu_id_3dcc68be_fk_rbac_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `rbac_menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `rbac_permission_pid_id_6939354d_fk_rbac_permission_id` FOREIGN KEY (`pid_id`) REFERENCES `rbac_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of rbac_permission
-- ----------------------------
INSERT INTO `rbac_permission` VALUES (1, '服务器', '/server/', 'server', 1, NULL, 'GET');
INSERT INTO `rbac_permission` VALUES (2, '虚拟机', '/vm/', 'vm', 1, NULL, 'GET');
INSERT INTO `rbac_permission` VALUES (3, '权限列表', '/rbac/permissions/', 'rbac-permissions', 3, NULL, 'GET');
INSERT INTO `rbac_permission` VALUES (4, '用户列表', '/rbac/user/', 'rbac-user', 2, NULL, 'GET');
INSERT INTO `rbac_permission` VALUES (5, '添加用户', '/rbac/user/', 'rbac-user', NULL, NULL, 'POST');
INSERT INTO `rbac_permission` VALUES (6, '服务器详情', '/detail/\\d+/', 'cmdbweb:detail', NULL, NULL, 'GET');
INSERT INTO `rbac_permission` VALUES (7, '编辑服务器', '/server/', 'cmdbweb:server', NULL, NULL, 'PUT');

-- ----------------------------
-- Table structure for rbac_role
-- ----------------------------
DROP TABLE IF EXISTS `rbac_role`;
CREATE TABLE `rbac_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of rbac_role
-- ----------------------------
INSERT INTO `rbac_role` VALUES (1, 'manager');

-- ----------------------------
-- Table structure for rbac_role_permissions
-- ----------------------------
DROP TABLE IF EXISTS `rbac_role_permissions`;
CREATE TABLE `rbac_role_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `rbac_role_permissions_role_id_permission_id_d01303da_uniq`(`role_id`, `permission_id`) USING BTREE,
  INDEX `rbac_role_permission_permission_id_f5e1e866_fk_rbac_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `rbac_role_permission_permission_id_f5e1e866_fk_rbac_perm` FOREIGN KEY (`permission_id`) REFERENCES `rbac_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `rbac_role_permissions_role_id_d10416cb_fk_rbac_role_id` FOREIGN KEY (`role_id`) REFERENCES `rbac_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of rbac_role_permissions
-- ----------------------------
INSERT INTO `rbac_role_permissions` VALUES (1, 1, 1);
INSERT INTO `rbac_role_permissions` VALUES (2, 1, 2);
INSERT INTO `rbac_role_permissions` VALUES (3, 1, 3);
INSERT INTO `rbac_role_permissions` VALUES (4, 1, 4);
INSERT INTO `rbac_role_permissions` VALUES (5, 1, 5);
INSERT INTO `rbac_role_permissions` VALUES (6, 1, 6);
INSERT INTO `rbac_role_permissions` VALUES (7, 1, 7);

SET FOREIGN_KEY_CHECKS = 1;
