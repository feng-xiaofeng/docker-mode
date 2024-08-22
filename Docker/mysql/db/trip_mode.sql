/*
 Navicat MySQL Data Transfer

 Source Server         : 39.101.75.20
 Source Server Type    : MySQL
 Source Server Version : 80034
 Source Host           : localhost:3306
 Source Schema         : shangchen

 Target Server Type    : MySQL
 Target Server Version : 80034
 File Encoding         : 65001

 Date: 06/01/2024 00:10:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for access
-- ----------------------------
DROP TABLE IF EXISTS `access`;
CREATE TABLE `access`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `module_name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `action_name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `type` bigint NULL DEFAULT NULL,
  `url` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `module_id` bigint NULL DEFAULT NULL,
  `sort` bigint NULL DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `status` bigint NULL DEFAULT NULL,
  `add_time` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_access_access_item`(`module_id`) USING BTREE,
  CONSTRAINT `fk_access_access_item` FOREIGN KEY (`module_id`) REFERENCES `access` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of access
-- ----------------------------
INSERT INTO `access` VALUES (0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `access` VALUES (6, '管理员管理', '', 1, '', 0, 100, '', 1, 0);
INSERT INTO `access` VALUES (7, '管理员管理', '管理员列表', 2, 'manager', 6, 100, '', 1, 0);
INSERT INTO `access` VALUES (8, '管理员管理', '增加管理员', 2, 'manager/add', 6, 100, '', 1, 0);
INSERT INTO `access` VALUES (9, '管理员管理', '执行增加', 3, 'manager/doAdd', 6, 100, '', 1, 0);
INSERT INTO `access` VALUES (10, '管理员管理', '修改', 3, 'manager/edit', 6, 100, '', 1, 0);
INSERT INTO `access` VALUES (11, '管理员管理', '执行修改', 3, 'manager/doEdit', 6, 100, '', 1, 0);
INSERT INTO `access` VALUES (12, '管理员管理', '删除', 3, 'manager/delete', 6, 100, '', 1, 0);
INSERT INTO `access` VALUES (13, '权限管理', '', 1, '', 0, 100, '', 1, 0);
INSERT INTO `access` VALUES (14, '权限管理', '增加权限', 2, 'access/add', 13, 100, '', 1, 0);
INSERT INTO `access` VALUES (15, '权限管理', '权限列表', 2, 'access', 13, 100, '', 1, 0);
INSERT INTO `access` VALUES (16, '权限管理', '执行增加', 3, 'access/doAdd', 13, 100, '', 1, 0);
INSERT INTO `access` VALUES (17, '权限管理', '修改', 3, 'access/edit', 13, 100, '', 1, 0);
INSERT INTO `access` VALUES (18, '权限管理', '执行修改', 3, 'access/doEdit', 13, 100, '', 1, 0);
INSERT INTO `access` VALUES (19, '权限管理', '删除', 3, 'access/delete', 13, 100, '', 1, 0);
INSERT INTO `access` VALUES (20, '角色管理', '', 1, '', 0, 100, '', 1, 0);
INSERT INTO `access` VALUES (21, '角色管理', '角色列表', 2, 'role', 20, 100, '', 1, 0);
INSERT INTO `access` VALUES (22, '角色管理', '增加角色', 2, 'role/add', 20, 100, '', 1, 0);
INSERT INTO `access` VALUES (23, '角色管理', '执行增加', 3, 'role/doAdd', 20, 100, '', 1, 0);
INSERT INTO `access` VALUES (24, '角色管理', '修改角色', 3, 'role/edit', 20, 100, '', 1, 0);
INSERT INTO `access` VALUES (25, '角色管理', '执行修改', 3, 'role/doEdit', 20, 100, '', 1, 0);
INSERT INTO `access` VALUES (26, '角色管理', '删除', 3, 'role/delete', 20, 100, '', 1, 0);
INSERT INTO `access` VALUES (27, '角色管理', '授权', 3, 'role/auth', 20, 100, '', 1, 0);
INSERT INTO `access` VALUES (28, '角色管理', '执行授权', 3, 'role/doAuth', 20, 100, '', 1, 0);
INSERT INTO `access` VALUES (29, '商品管理', '', 1, '', 0, 100, '', 1, 0);
INSERT INTO `access` VALUES (45, '商品管理', '商品', 2, 'goods', 29, 100, '', 1, 0);
INSERT INTO `access` VALUES (50, '商品管理', '删除', 3, 'goods/delete', 29, 100, '', 1, 0);
INSERT INTO `access` VALUES (51, '导航管理', '', 1, '', 0, 100, '', 1, 0);
INSERT INTO `access` VALUES (52, '学校管理', '', 1, '', 0, 100, '', 1, 0);
INSERT INTO `access` VALUES (53, '导航管理', '顶部导航', 2, 'goodsType', 51, 100, '', 1, 0);
INSERT INTO `access` VALUES (54, '学校管理', '学校列表', 2, 'school', 52, 100, '', 1, 0);
INSERT INTO `access` VALUES (55, '用户管理', '', 1, '', 0, 100, '', 1, 0);
INSERT INTO `access` VALUES (56, '用户管理', '用户列表', 2, 'user', 55, 100, '', 1, 0);

-- ----------------------------
-- Table structure for aql_messages
-- ----------------------------
DROP TABLE IF EXISTS `aql_messages`;
CREATE TABLE `aql_messages`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `speaker` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `user_id_to` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `information_time` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `user_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 225 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aql_messages
-- ----------------------------
INSERT INTO `aql_messages` VALUES (127, 'pm', 'customer', '65', '456456', '1693033006', '70');
INSERT INTO `aql_messages` VALUES (128, 'pm', 'customer', '65', '4444', '1693033053', '70');
INSERT INTO `aql_messages` VALUES (129, 'pm', 'customer', '65', '111111', '1693033253', '70');
INSERT INTO `aql_messages` VALUES (130, 'pm', 'customer', '65', '12345678790', '1693033292', '70');
INSERT INTO `aql_messages` VALUES (131, 'pm', 'customer', '65', '325345', '1693033726', '70');
INSERT INTO `aql_messages` VALUES (132, 'pm', 'customer', '65', '4444', '1693033729', '70');
INSERT INTO `aql_messages` VALUES (133, 'pm', 'customer', '65', '3333', '1693035105', '70');
INSERT INTO `aql_messages` VALUES (134, 'pm', 'customer', '65', '999', '1693035143', '70');
INSERT INTO `aql_messages` VALUES (135, 'pm', 'customer', '65', '444', '1693035173', '70');
INSERT INTO `aql_messages` VALUES (136, 'pm', 'customer', '65', '6534564', '1693035178', '70');
INSERT INTO `aql_messages` VALUES (137, 'pm', 'customer', '65', '777', '1693035332', '70');
INSERT INTO `aql_messages` VALUES (138, 'pm', 'customer', '65', '444', '1693035389', '70');
INSERT INTO `aql_messages` VALUES (139, 'pm', 'customer', '65', '444', '1693035399', '70');
INSERT INTO `aql_messages` VALUES (140, 'pm', 'customer', '65', '555', '1693035478', '70');
INSERT INTO `aql_messages` VALUES (141, 'pm', 'customer', '65', '666', '1693035488', '70');
INSERT INTO `aql_messages` VALUES (142, 'pm', 'customer', '65', '777', '1693035577', '70');
INSERT INTO `aql_messages` VALUES (143, 'pm', 'customer', '65', '8888', '1693035594', '70');
INSERT INTO `aql_messages` VALUES (144, 'pm', 'customer', '65', '66666', '1693035639', '70');
INSERT INTO `aql_messages` VALUES (145, 'pm', 'customer', '65', '555', '1693035713', '70');
INSERT INTO `aql_messages` VALUES (146, 'pm', 'customer', '65', '3333', '1693035724', '70');
INSERT INTO `aql_messages` VALUES (147, 'pm', 'customer', '65', '1111', '1693035728', '70');
INSERT INTO `aql_messages` VALUES (148, 'pm', 'customer', '65', '333333333', '1693035831', '70');
INSERT INTO `aql_messages` VALUES (149, 'pm', 'customer', '65', '1', '1693035881', '70');
INSERT INTO `aql_messages` VALUES (150, 'pm', 'customer', '65', '3', '1693036025', '70');
INSERT INTO `aql_messages` VALUES (151, 'pm', 'customer', '65', '2', '1693036032', '70');
INSERT INTO `aql_messages` VALUES (152, 'pm', 'customer', '65', '3', '1693036065', '70');
INSERT INTO `aql_messages` VALUES (153, 'pm', 'customer', '65', '45', '1693036096', '70');
INSERT INTO `aql_messages` VALUES (154, 'pm', 'customer', '65', '11', '1693036155', '70');
INSERT INTO `aql_messages` VALUES (155, 'pm', 'customer', '65', '4', '1693036253', '70');
INSERT INTO `aql_messages` VALUES (156, 'pm', 'customer', '65', '3', '1693036311', '70');
INSERT INTO `aql_messages` VALUES (157, 'pm', 'customer', '65', '5656', '1693037557', '70');
INSERT INTO `aql_messages` VALUES (158, 'pm', 'customer', '65', '44', '1693037808', '70');
INSERT INTO `aql_messages` VALUES (159, 'pm', 'customer', '65', '4444', '1693037815', '70');
INSERT INTO `aql_messages` VALUES (160, 'pm', 'customer', '65', '3', '1693037898', '70');
INSERT INTO `aql_messages` VALUES (161, 'pm', 'customer', '65', '5', '1693037924', '70');
INSERT INTO `aql_messages` VALUES (162, 'pm', 'customer', '65', '5', '1693038292', '70');
INSERT INTO `aql_messages` VALUES (163, 'pm', 'customer', '65', '345', '1693038297', '70');
INSERT INTO `aql_messages` VALUES (164, 'pm', 'customer', '65', '77', '1693038373', '70');
INSERT INTO `aql_messages` VALUES (165, 'pm', 'customer', '65', '77777777777777777777', '1693038377', '70');
INSERT INTO `aql_messages` VALUES (166, 'pm', 'customer', '65', '444', '1693038849', '70');
INSERT INTO `aql_messages` VALUES (167, 'pm', 'customer', '65', '尼玛', '1693038864', '70');
INSERT INTO `aql_messages` VALUES (168, 'pm', 'customer', '65', '555', '1693039190', '70');
INSERT INTO `aql_messages` VALUES (169, 'pm', 'customer', '65', '555', '1693039209', '70');
INSERT INTO `aql_messages` VALUES (170, 'pm', 'customer', '65', '6666', '1693039211', '70');
INSERT INTO `aql_messages` VALUES (171, 'pm', 'customer', '65', '55555', '1693039368', '70');
INSERT INTO `aql_messages` VALUES (172, 'pm', 'customer', '65', '67567567', '1693039370', '70');
INSERT INTO `aql_messages` VALUES (173, 'pm', 'customer', '65', '5553545345', '1693039738', '70');
INSERT INTO `aql_messages` VALUES (174, 'pm', 'customer', '65', '34534534', '1693039739', '70');
INSERT INTO `aql_messages` VALUES (218, 'pm', 'customer', '70', '😅😅😅😅', '1695092456', '71');
INSERT INTO `aql_messages` VALUES (219, 'pm', 'customer', '70', '的人根本', '1695092471', '71');
INSERT INTO `aql_messages` VALUES (220, 'pm', 'customer', '70', '亲亲亲亲', '1696231880', '71');
INSERT INTO `aql_messages` VALUES (221, 'pm', 'customer', '70', '鱼火锅', '1696231884', '71');
INSERT INTO `aql_messages` VALUES (222, 'pm', 'customer', '66', '😍😍😍', '1696607517', '71');
INSERT INTO `aql_messages` VALUES (223, 'pm', 'customer', '66', '亲亲😚😚😚', '1696607568', '71');
INSERT INTO `aql_messages` VALUES (224, 'pm', 'customer', '70', '过于', '1697185175', '71');

-- ----------------------------
-- Table structure for dstr_schools
-- ----------------------------
DROP TABLE IF EXISTS `dstr_schools`;
CREATE TABLE `dstr_schools`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `provincial_name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `city_name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `school_name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `type` bigint NULL DEFAULT NULL,
  `module_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_dstr_schools_city_item`(`module_id`) USING BTREE,
  CONSTRAINT `fk_dstr_schools_city_item` FOREIGN KEY (`module_id`) REFERENCES `dstr_schools` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_dstr_schools_provincial_item` FOREIGN KEY (`module_id`) REFERENCES `dstr_schools` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dstr_schools
-- ----------------------------

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `price` double NULL DEFAULT NULL,
  `goods_number` bigint NULL DEFAULT NULL,
  `goods_details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `sort` bigint NULL DEFAULT NULL,
  `click_count` bigint NULL DEFAULT NULL,
  `is_delete` bigint NULL DEFAULT NULL,
  `add_time` bigint NULL DEFAULT NULL,
  `status` bigint NULL DEFAULT NULL,
  `module_id` bigint NULL DEFAULT NULL,
  `checked` bigint NULL DEFAULT NULL,
  `first_image` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `goods_sate` bigint NULL DEFAULT NULL,
  `user_id` bigint NULL DEFAULT NULL,
  `school_id` bigint NULL DEFAULT NULL,
  `goods_type_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_goods_user`(`user_id`) USING BTREE,
  CONSTRAINT `fk_goods_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 129 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (84, '大夫嘎', 34, 0, '', 0, 0, 0, 1691893539, 0, 0, 1, 'static/upload/20230813/10d13jb7d5d79dh.jpg', 0, 65, 9, 13);
INSERT INTO `goods` VALUES (85, '太容易', 53, 0, '', 0, 0, 0, 1691893553, 0, 0, 1, 'static/upload/20230813/10d13jbi8chj0eb.jpg', 0, 65, 9, 13);
INSERT INTO `goods` VALUES (86, '得分割', 54, 0, '', 0, 0, 0, 1691893589, 0, 0, 1, 'static/upload/20230813/10d13jd635a28h1.jpg', 0, 63, 9, 13);
INSERT INTO `goods` VALUES (87, '对方是个', 12, 0, '', 0, 0, 0, 1691893602, 0, 0, 1, 'static/upload/20230813/10d13jdh41j4g19.jpg', 0, 63, 9, 13);
INSERT INTO `goods` VALUES (88, '框架', 123, 0, '', 0, 0, 0, 1691893617, 0, 0, 1, 'static/upload/20230813/10d13je8hf5h2fe.jpg', 0, 63, 9, 13);
INSERT INTO `goods` VALUES (89, '的风格', 35, 0, '', 0, 0, 0, 1691893662, 0, 0, 1, 'static/upload/20230813/10d13jg3de9f767.jpg', 0, 64, 9, 13);
INSERT INTO `goods` VALUES (90, '接口', 23, 0, '', 0, 0, 0, 1691893681, 0, 0, 1, 'static/upload/20230813/10d13jgi907cd5g.jpg', 0, 64, 9, 13);
INSERT INTO `goods` VALUES (91, '刚好今天有', 45, 0, '', 0, 0, 0, 1691893760, 0, 0, 1, 'static/upload/20230813/10d13jjjgcf33e7.jpg', 0, 67, 9, 13);
INSERT INTO `goods` VALUES (92, '风格和', 45, 0, '', 0, 0, 0, 1691893775, 0, 0, 1, 'static/upload/20230813/10d1400bc8a2caj.jpg', 0, 67, 9, 13);
INSERT INTO `goods` VALUES (93, '枯竭和', 45, 0, '', 0, 0, 0, 1691893884, 0, 0, 1, 'static/upload/20230813/10d1404gfea0ebh.jpg', 0, 68, 9, 13);
INSERT INTO `goods` VALUES (94, '人太少', 45, 0, '', 0, 0, 0, 1691893898, 0, 0, 1, 'static/upload/20230813/10d14057jd19ge8.jpg', 0, 68, 9, 13);
INSERT INTO `goods` VALUES (95, '的法国时尚', 536, 0, '', 0, 0, 0, 1691893916, 0, 0, 1, 'static/upload/20230813/10d14062b1f69d3.jpg', 0, 68, 9, 13);
INSERT INTO `goods` VALUES (96, '韩国好好吃', 25.5, 0, '感觉八v', 0, 0, 0, 1691942764, 0, 0, 1, 'static/upload/20230814/10d18fe4b162ifd.jpg', 0, 62, 9, 13);
INSERT INTO `goods` VALUES (97, '冰淇淋', 520, 0, '小吴的冰淇淋', 0, 0, 0, 1692015520, 0, 0, 1, 'static/upload/20230814/10d1fhg4ic28eg9.jpg', 0, 66, 9, 13);
INSERT INTO `goods` VALUES (98, '绵绵冰', 520, 0, '小吴的绵绵冰', 0, 0, 0, 1692015576, 0, 0, 1, 'static/upload/20230814/10d1fhi97bhg96g.jpg', 0, 66, 9, 13);
INSERT INTO `goods` VALUES (99, 'ghbfgh', 34534, 0, '', 0, 0, 0, 1692516711, 0, 0, 1, 'static/upload/20230820/10d44ge0d5f1737.jpg', 0, 70, 9, 13);
INSERT INTO `goods` VALUES (100, 'dfgsdr', 535, 0, '', 0, 0, 0, 1692516733, 0, 0, 1, 'static/upload/20230820/10d44gehje27gd9.jpg', 0, 70, 9, 13);
INSERT INTO `goods` VALUES (101, '4534', 34534, 0, '', 0, 0, 0, 1692516748, 0, 0, 1, 'static/upload/20230820/10d44gf976f8gh5.jpg', 0, 70, 9, 13);
INSERT INTO `goods` VALUES (102, 'fghfg', 43535, 0, '', 0, 0, 0, 1692516762, 0, 0, 1, 'static/upload/20230820/10d44gg0j9gf2h8.jpg', 0, 70, 9, 13);
INSERT INTO `goods` VALUES (103, '45345', 34534, 0, '', 0, 0, 0, 1692516774, 0, 0, 1, 'static/upload/20230820/10d44gga342ee50.jpg', 0, 70, 9, 13);
INSERT INTO `goods` VALUES (104, 'fyuh', 78, 0, '', 0, 0, 0, 1692516787, 0, 0, 1, 'static/upload/20230820/10d44gh0643cc01.jpg', 0, 70, 9, 13);
INSERT INTO `goods` VALUES (105, 'tfh', 56, 0, '', 0, 0, 0, 1692516798, 0, 0, 1, 'static/upload/20230820/10d44gh88d1fffd.jpg', 0, 70, 9, 13);
INSERT INTO `goods` VALUES (106, '45645', 54645, 0, '', 0, 0, 0, 1692516811, 0, 0, 1, 'static/upload/20230820/10d44ghidbh2h35.jpg', 0, 70, 9, 13);
INSERT INTO `goods` VALUES (107, '345345', 44, 0, '', 0, 0, 0, 1692672807, 0, 0, 1, 'static/upload/20230822/10d501bae37gbgf.jpg', 0, 70, 9, 13);
INSERT INTO `goods` VALUES (108, '苏还打不打', 22, 0, '', 0, 0, 0, 1693041954, 0, 0, 1, 'static/upload/20230826/10d6g2b6a4582he.jpg', 0, 70, 9, 7);
INSERT INTO `goods` VALUES (109, '想小吴', 520, 0, '想小吴', 0, 0, 0, 1693054713, 0, 0, 3, 'static/upload/20230826/10d6h79eeahie87.jpg', 0, 66, 9, 13);
INSERT INTO `goods` VALUES (110, 'Z洞庭湖', 435, 0, '的风格和岁的法国，地方官大使馆。。。。', 0, 0, 0, 1693056801, 0, 0, 2, 'static/upload/20230826/10d6hbb5gchfa1j.jpg', 0, 71, 9, 9);
INSERT INTO `goods` VALUES (111, '地方上班撒旦发射点地方上班', 44444, 0, '的风格山豆根士大夫给的豆腐干岁的法国是大哥富商大贾士大夫敢死队风格', 0, 0, 1, 1693279447, 0, 0, 2, 'static/upload/20230829/10d7j688a163eeh.jpg', 0, 71, 9, 13);
INSERT INTO `goods` VALUES (112, '螺蛳粉', 888, 0, '小吴版螺蛳粉', 0, 0, 0, 1693407131, 0, 0, 1, 'static/upload/20230830/10d8bfg1524f5ag.jpg', 0, 66, 9, 13);
INSERT INTO `goods` VALUES (113, '小吴', 520, 0, '小冯的手', 0, 0, 0, 1693407222, 0, 0, 1, 'static/upload/20230830/10d8bfjcb9j9beh.jpg', 0, 66, 9, 13);
INSERT INTO `goods` VALUES (114, '🥰🥰🥰', 45.2, 0, '😍😍😍😍😍😍😍😍😍😍😍😍😍😍好活动活动还是😅😅😅😅😅', 0, 0, 0, 1693408312, 0, 0, 3, 'static/upload/20230830/10d8bi239729jb2.jpg', 0, 70, 9, 13);
INSERT INTO `goods` VALUES (115, '😘😘😘😘', 99999, 0, '😇😇😇😇', 0, 0, 0, 1693408385, 0, 0, 1, 'static/upload/20230830/10d8bi5123i1hb1.jpg', 0, 70, 9, 13);
INSERT INTO `goods` VALUES (116, '🤩🤩🤩', 99999, 0, '😝😝😝😝😝😝😝😝', 0, 0, 0, 1693408440, 0, 0, 1, 'static/upload/20230830/10d8bi73jjcj5fi.jpg', 0, 70, 9, 13);
INSERT INTO `goods` VALUES (117, '🤫🤫🤫', 45.5, 0, '哈哈女王啊好吧', 0, 0, 0, 1693408479, 0, 0, 1, 'static/upload/20230830/10d8bi8e40fdbed.jpg', 0, 70, 9, 13);
INSERT INTO `goods` VALUES (118, '🤗🤗🤗', 99999, 0, '🤭😏😶🤑🤭🤤🤤😒😴🤤🤤', 0, 0, 0, 1693409746, 0, 0, 3, 'static/upload/20230830/10d8c0i4e0b3d33.jpg', 0, 70, 9, 13);
INSERT INTO `goods` VALUES (119, '😎😎😎', 520, 0, '🤩🤩🤩', 0, 0, 0, 1693466844, 0, 0, 1, 'static/upload/20230831/10d8hc8bghf9602.jpg', 0, 70, 9, 13);
INSERT INTO `goods` VALUES (120, '😉😉😉', 520, 0, '觉得不得不说这就是你说不定不到你', 0, 0, 0, 1693466931, 0, 0, 1, 'static/upload/20230831/10d8hcbjj19d193.jpg', 0, 70, 9, 13);
INSERT INTO `goods` VALUES (121, '😆😆😆', 520, 0, '就不会句', 0, 0, 0, 1693467004, 0, 0, 1, 'static/upload/20230831/10d8hceh7527hc4.jpg', 0, 70, 5, 13);
INSERT INTO `goods` VALUES (122, '😄😄😄', 22, 0, '关于VV', 0, 0, 0, 1693467932, 0, 0, 1, 'static/upload/20230831/10d8heb20dc2349.jpg', 0, 70, 5, 13);
INSERT INTO `goods` VALUES (123, '😍😍😍', 258, 0, '', 0, 0, 0, 1693467952, 0, 0, 1, 'static/upload/20230831/10d8hebhc9d4c48.jpg', 0, 70, 5, 13);
INSERT INTO `goods` VALUES (124, '🤔🤔🤔', 2589, 0, '', 0, 0, 0, 1693467984, 0, 0, 1, 'static/upload/20230831/10d8hed30a963g0.jpg', 0, 70, 5, 13);
INSERT INTO `goods` VALUES (125, '😅😅😅', 254, 0, '', 0, 0, 0, 1693468011, 0, 0, 1, 'static/upload/20230831/10d8hee3a2hgge1.jpg', 0, 70, 5, 13);
INSERT INTO `goods` VALUES (126, '44', 33, 0, '', 0, 0, 0, 1695824425, 0, 0, 1, 'static/upload/20230927/10e07h1cdi67aj5.jpg', 0, 71, 9, 13);
INSERT INTO `goods` VALUES (127, '哈哈哈', 225, 0, '哈哈VV', 0, 0, 0, 1697185154, 0, 0, 1, 'static/upload/20231013/10e70ef1aa8bih0.jpg', 0, 71, 9, 13);
INSERT INTO `goods` VALUES (128, '古巴', 25.5, 0, '哈哈八v', 0, 0, 0, 1699411333, 0, 0, 1, 'static/upload/20231108/10ehi2f46gd232a.jpg', 0, 71, 9, 13);

-- ----------------------------
-- Table structure for goods_image
-- ----------------------------
DROP TABLE IF EXISTS `goods_image`;
CREATE TABLE `goods_image`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `goods_id` bigint NULL DEFAULT NULL,
  `img_url` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `add_time` bigint NULL DEFAULT NULL,
  `status` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 216 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_image
-- ----------------------------
INSERT INTO `goods_image` VALUES (150, 84, 'static/upload/20230813/10d13jb7d5d79dh.jpg', 1691893539, 1);
INSERT INTO `goods_image` VALUES (151, 84, 'static/upload/20230813/10d13jb7fe47cf8.jpg', 1691893539, 1);
INSERT INTO `goods_image` VALUES (152, 85, 'static/upload/20230813/10d13jbi8chj0eb.jpg', 1691893553, 1);
INSERT INTO `goods_image` VALUES (153, 85, 'static/upload/20230813/10d13jbibj332c2.jpg', 1691893553, 1);
INSERT INTO `goods_image` VALUES (154, 86, 'static/upload/20230813/10d13jd635a28h1.jpg', 1691893589, 1);
INSERT INTO `goods_image` VALUES (155, 86, 'static/upload/20230813/10d13jd6f1ej493.jpg', 1691893589, 1);
INSERT INTO `goods_image` VALUES (156, 87, 'static/upload/20230813/10d13jdh41j4g19.jpg', 1691893602, 1);
INSERT INTO `goods_image` VALUES (157, 87, 'static/upload/20230813/10d13jdh0j0gef7.jpg', 1691893602, 1);
INSERT INTO `goods_image` VALUES (158, 88, 'static/upload/20230813/10d13je8hf5h2fe.jpg', 1691893617, 1);
INSERT INTO `goods_image` VALUES (159, 88, 'static/upload/20230813/10d13je8b5fbiag.jpg', 1691893617, 1);
INSERT INTO `goods_image` VALUES (160, 89, 'static/upload/20230813/10d13jg3de9f767.jpg', 1691893662, 1);
INSERT INTO `goods_image` VALUES (161, 89, 'static/upload/20230813/10d13jg3gfcd98j.jpg', 1691893662, 1);
INSERT INTO `goods_image` VALUES (162, 90, 'static/upload/20230813/10d13jgi907cd5g.jpg', 1691893681, 1);
INSERT INTO `goods_image` VALUES (163, 90, 'static/upload/20230813/10d13jgi8jf58g8.jpg', 1691893681, 1);
INSERT INTO `goods_image` VALUES (164, 91, 'static/upload/20230813/10d13jjjgcf33e7.jpg', 1691893760, 1);
INSERT INTO `goods_image` VALUES (165, 91, 'static/upload/20230813/10d1400011i3h6j.jpg', 1691893760, 1);
INSERT INTO `goods_image` VALUES (166, 92, 'static/upload/20230813/10d1400bc8a2caj.jpg', 1691893775, 1);
INSERT INTO `goods_image` VALUES (167, 92, 'static/upload/20230813/10d1400bdge3ej9.jpg', 1691893775, 1);
INSERT INTO `goods_image` VALUES (168, 93, 'static/upload/20230813/10d1404gfea0ebh.jpg', 1691893884, 1);
INSERT INTO `goods_image` VALUES (169, 93, 'static/upload/20230813/10d1404gi61bb71.jpg', 1691893884, 1);
INSERT INTO `goods_image` VALUES (170, 94, 'static/upload/20230813/10d14057jd19ge8.jpg', 1691893898, 1);
INSERT INTO `goods_image` VALUES (171, 94, 'static/upload/20230813/10d140584aafehd.jpg', 1691893898, 1);
INSERT INTO `goods_image` VALUES (172, 95, 'static/upload/20230813/10d14062b1f69d3.jpg', 1691893916, 1);
INSERT INTO `goods_image` VALUES (173, 95, 'static/upload/20230813/10d1406241383c4.jpg', 1691893916, 1);
INSERT INTO `goods_image` VALUES (174, 96, 'static/upload/20230814/10d18fe4b162ifd.jpg', 1691942764, 1);
INSERT INTO `goods_image` VALUES (175, 96, 'static/upload/20230814/10d18fe4d3dhddb.jpg', 1691942764, 1);
INSERT INTO `goods_image` VALUES (176, 97, 'static/upload/20230814/10d1fhg4ic28eg9.jpg', 1692015520, 1);
INSERT INTO `goods_image` VALUES (177, 97, 'static/upload/20230814/10d1fhg4j9eig83.jpg', 1692015520, 1);
INSERT INTO `goods_image` VALUES (178, 98, 'static/upload/20230814/10d1fhi97bhg96g.jpg', 1692015576, 1);
INSERT INTO `goods_image` VALUES (179, 98, 'static/upload/20230814/10d1fhi97c2144d.jpg', 1692015576, 1);
INSERT INTO `goods_image` VALUES (180, 99, 'static/upload/20230820/10d44ge0d5f1737.jpg', 1692516711, 1);
INSERT INTO `goods_image` VALUES (181, 100, 'static/upload/20230820/10d44gehje27gd9.jpg', 1692516733, 1);
INSERT INTO `goods_image` VALUES (182, 101, 'static/upload/20230820/10d44gf976f8gh5.jpg', 1692516748, 1);
INSERT INTO `goods_image` VALUES (183, 102, 'static/upload/20230820/10d44gg0j9gf2h8.jpg', 1692516762, 1);
INSERT INTO `goods_image` VALUES (184, 103, 'static/upload/20230820/10d44gga342ee50.jpg', 1692516774, 1);
INSERT INTO `goods_image` VALUES (185, 104, 'static/upload/20230820/10d44gh0643cc01.jpg', 1692516787, 1);
INSERT INTO `goods_image` VALUES (186, 105, 'static/upload/20230820/10d44gh88d1fffd.jpg', 1692516798, 1);
INSERT INTO `goods_image` VALUES (187, 106, 'static/upload/20230820/10d44ghidbh2h35.jpg', 1692516811, 1);
INSERT INTO `goods_image` VALUES (188, 107, 'static/upload/20230822/10d501bae37gbgf.jpg', 1692672807, 1);
INSERT INTO `goods_image` VALUES (189, 108, 'static/upload/20230826/10d6g2b6a4582he.jpg', 1693041954, 1);
INSERT INTO `goods_image` VALUES (190, 109, 'static/upload/20230826/10d6h79eeahie87.jpg', 1693054713, 1);
INSERT INTO `goods_image` VALUES (191, 110, 'static/upload/20230826/10d6hbb5gchfa1j.jpg', 1693056801, 1);
INSERT INTO `goods_image` VALUES (192, 110, 'static/upload/20230826/10d6hbb67fc956b.jpg', 1693056801, 1);
INSERT INTO `goods_image` VALUES (193, 110, 'static/upload/20230826/10d6hbb5cad1c63.jpg', 1693056801, 1);
INSERT INTO `goods_image` VALUES (194, 111, 'static/upload/20230829/10d7j688a163eeh.jpg', 1693279448, 1);
INSERT INTO `goods_image` VALUES (195, 112, 'static/upload/20230830/10d8bfg1524f5ag.jpg', 1693407131, 1);
INSERT INTO `goods_image` VALUES (196, 113, 'static/upload/20230830/10d8bfjcb9j9beh.jpg', 1693407222, 1);
INSERT INTO `goods_image` VALUES (197, 114, 'static/upload/20230830/10d8bi239729jb2.jpg', 1693408312, 1);
INSERT INTO `goods_image` VALUES (198, 114, 'static/upload/20230830/10d8bi23b6g6709.jpg', 1693408312, 1);
INSERT INTO `goods_image` VALUES (199, 114, 'static/upload/20230830/10d8bi23e848jh4.jpg', 1693408312, 1);
INSERT INTO `goods_image` VALUES (200, 114, 'static/upload/20230830/10d8bi23hc88bh8.jpg', 1693408312, 1);
INSERT INTO `goods_image` VALUES (201, 114, 'static/upload/20230830/10d8bi2427jiiec.jpg', 1693408312, 1);
INSERT INTO `goods_image` VALUES (202, 115, 'static/upload/20230830/10d8bi5123i1hb1.jpg', 1693408385, 1);
INSERT INTO `goods_image` VALUES (203, 116, 'static/upload/20230830/10d8bi73jjcj5fi.jpg', 1693408440, 1);
INSERT INTO `goods_image` VALUES (204, 117, 'static/upload/20230830/10d8bi8e40fdbed.jpg', 1693408479, 1);
INSERT INTO `goods_image` VALUES (205, 118, 'static/upload/20230830/10d8c0i4e0b3d33.jpg', 1693409746, 1);
INSERT INTO `goods_image` VALUES (206, 119, 'static/upload/20230831/10d8hc8bghf9602.jpg', 1693466844, 1);
INSERT INTO `goods_image` VALUES (207, 120, 'static/upload/20230831/10d8hcbjj19d193.jpg', 1693466931, 1);
INSERT INTO `goods_image` VALUES (208, 121, 'static/upload/20230831/10d8hceh7527hc4.jpg', 1693467004, 1);
INSERT INTO `goods_image` VALUES (209, 122, 'static/upload/20230831/10d8heb20dc2349.jpg', 1693467932, 1);
INSERT INTO `goods_image` VALUES (210, 123, 'static/upload/20230831/10d8hebhc9d4c48.jpg', 1693467952, 1);
INSERT INTO `goods_image` VALUES (211, 124, 'static/upload/20230831/10d8hed30a963g0.jpg', 1693467984, 1);
INSERT INTO `goods_image` VALUES (212, 125, 'static/upload/20230831/10d8hee3a2hgge1.jpg', 1693468011, 1);
INSERT INTO `goods_image` VALUES (213, 126, 'static/upload/20230927/10e07h1cdi67aj5.jpg', 1695824426, 1);
INSERT INTO `goods_image` VALUES (214, 127, 'static/upload/20231013/10e70ef1aa8bih0.jpg', 1697185154, 1);
INSERT INTO `goods_image` VALUES (215, 128, 'static/upload/20231108/10ehi2f46gd232a.jpg', 1699411333, 1);

-- ----------------------------
-- Table structure for goods_type
-- ----------------------------
DROP TABLE IF EXISTS `goods_type`;
CREATE TABLE `goods_type`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `module_name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `type_name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `type` bigint NULL DEFAULT NULL,
  `module_id` bigint NULL DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `sort` bigint NULL DEFAULT NULL,
  `status` bigint NULL DEFAULT NULL,
  `add_time` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_goods_type_goods_type_item`(`module_id`) USING BTREE,
  CONSTRAINT `fk_goods_type_goods_type_item` FOREIGN KEY (`module_id`) REFERENCES `goods_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_type
-- ----------------------------
INSERT INTO `goods_type` VALUES (0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goods_type` VALUES (2, '发现', '', 1, 0, '', 1, 1, 1669343003);
INSERT INTO `goods_type` VALUES (3, '发现', '推荐', 2, 2, '', 11, 1, 1669344783);
INSERT INTO `goods_type` VALUES (7, '发现', '电动车', 2, 2, '', 100, 1, 1669362438);
INSERT INTO `goods_type` VALUES (8, '发现', '领快递', 2, 2, '', 100, 1, 1669362466);
INSERT INTO `goods_type` VALUES (9, '发现', '手机', 2, 2, '', 100, 1, 1669365580);
INSERT INTO `goods_type` VALUES (12, '发现', '上述的方法', 2, 2, '山豆根山豆', 100, 1, 1673583696);
INSERT INTO `goods_type` VALUES (13, '发现', '其他', 2, 2, '对方的', 1000, 1, 1673583744);
INSERT INTO `goods_type` VALUES (16, '发现', '烦烦烦', 2, 2, '', 100, 1, 1673884189);
INSERT INTO `goods_type` VALUES (17, '发现', '她她她', 2, 2, '', 100, 1, 1673884325);
INSERT INTO `goods_type` VALUES (22, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `password` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `mobile` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `email` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `status` bigint NULL DEFAULT NULL,
  `role_id` bigint NULL DEFAULT NULL,
  `add_time` bigint NULL DEFAULT NULL,
  `is_super` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_manager_role`(`role_id`) USING BTREE,
  CONSTRAINT `fk_manager_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager` VALUES (1, '2580', '4adbd696700e8ece23ff78182203a310', '18276028407', '2096368341@qq.com', 1, 1, 1669263425, 0);

-- ----------------------------
-- Table structure for my_putaway_goods
-- ----------------------------
DROP TABLE IF EXISTS `my_putaway_goods`;
CREATE TABLE `my_putaway_goods`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NULL DEFAULT NULL,
  `goods_id` bigint NULL DEFAULT NULL,
  `add_time` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of my_putaway_goods
-- ----------------------------

-- ----------------------------
-- Table structure for nav
-- ----------------------------
DROP TABLE IF EXISTS `nav`;
CREATE TABLE `nav`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `sort` bigint NULL DEFAULT NULL,
  `status` bigint NULL DEFAULT NULL,
  `add_time` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of nav
-- ----------------------------

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_number` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `user_id` bigint NULL DEFAULT NULL,
  `seller_id` bigint NULL DEFAULT NULL,
  `price` double NULL DEFAULT NULL,
  `goods_name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `school_name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `goods_image` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `payment_method` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `shipping_address` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `checked` bigint NULL DEFAULT NULL,
  `remark` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `add_time` bigint NULL DEFAULT NULL,
  `goods_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_order_user`(`seller_id`) USING BTREE,
  CONSTRAINT `fk_order_user` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (1, '202310101053244622', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906404, 114);
INSERT INTO `order` VALUES (2, '202310101053262651', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906406, 114);
INSERT INTO `order` VALUES (3, '202310101053275854', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906407, 114);
INSERT INTO `order` VALUES (4, '202310101053275240', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906407, 114);
INSERT INTO `order` VALUES (5, '202310101053273619', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906407, 114);
INSERT INTO `order` VALUES (6, '202310101053289773', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906408, 114);
INSERT INTO `order` VALUES (7, '202310101053281580', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906408, 114);
INSERT INTO `order` VALUES (8, '202310101053289374', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906408, 114);
INSERT INTO `order` VALUES (9, '202310101053286783', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906408, 114);
INSERT INTO `order` VALUES (10, '202310101053280738', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906408, 114);
INSERT INTO `order` VALUES (11, '202310101053298061', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906409, 114);
INSERT INTO `order` VALUES (12, '202310101053294508', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906409, 114);
INSERT INTO `order` VALUES (13, '202310101053293471', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906409, 114);
INSERT INTO `order` VALUES (14, '202310101053293067', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906409, 114);
INSERT INTO `order` VALUES (15, '202310101053291215', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906409, 114);
INSERT INTO `order` VALUES (16, '202310101053306967', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906410, 114);
INSERT INTO `order` VALUES (17, '202310101053302095', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906410, 114);
INSERT INTO `order` VALUES (18, '202310101053300833', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906410, 114);
INSERT INTO `order` VALUES (19, '202310101053305319', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906410, 114);
INSERT INTO `order` VALUES (20, '202310101053350632', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906415, 114);
INSERT INTO `order` VALUES (21, '202310101053356845', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906415, 114);
INSERT INTO `order` VALUES (22, '202310101053355087', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906415, 114);
INSERT INTO `order` VALUES (23, '202310101053427783', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906422, 114);
INSERT INTO `order` VALUES (24, '202310101053422718', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906422, 114);
INSERT INTO `order` VALUES (25, '202310101053427770', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906422, 114);
INSERT INTO `order` VALUES (26, '202310101053434752', 71, 70, 45.2, '🥰🥰🥰', '3', 'static/upload/20230830/10d8bi239729jb2.jpg', '', '', 1, '', 1696906423, 114);
INSERT INTO `order` VALUES (27, '202310131617442837', 71, 70, 99999, '🤗🤗🤗', '3', 'static/upload/20230830/10d8c0i4e0b3d33.jpg', '', '', 1, '', 1697185064, 118);
INSERT INTO `order` VALUES (28, '202310131617447349', 71, 70, 99999, '🤗🤗🤗', '3', 'static/upload/20230830/10d8c0i4e0b3d33.jpg', '', '', 1, '', 1697185064, 118);
INSERT INTO `order` VALUES (29, '202310131617457174', 71, 70, 99999, '🤗🤗🤗', '3', 'static/upload/20230830/10d8c0i4e0b3d33.jpg', '', '', 1, '', 1697185065, 118);
INSERT INTO `order` VALUES (30, '202310131617452804', 71, 70, 99999, '🤗🤗🤗', '3', 'static/upload/20230830/10d8c0i4e0b3d33.jpg', '', '', 1, '', 1697185065, 118);
INSERT INTO `order` VALUES (31, '202310131617457994', 71, 70, 99999, '🤗🤗🤗', '3', 'static/upload/20230830/10d8c0i4e0b3d33.jpg', '', '', 1, '', 1697185065, 118);
INSERT INTO `order` VALUES (32, '202310131618058722', 71, 66, 520, '想小吴', '3', 'static/upload/20230826/10d6h79eeahie87.jpg', '', '', 1, '', 1697185085, 109);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `status` bigint NULL DEFAULT NULL,
  `add_time` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '超级管理员', '', 1, 1669263283);

-- ----------------------------
-- Table structure for role_access
-- ----------------------------
DROP TABLE IF EXISTS `role_access`;
CREATE TABLE `role_access`  (
  `access_id` bigint NULL DEFAULT NULL,
  `role_id` bigint NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_access
-- ----------------------------
INSERT INTO `role_access` VALUES (6, 1);
INSERT INTO `role_access` VALUES (7, 1);
INSERT INTO `role_access` VALUES (8, 1);
INSERT INTO `role_access` VALUES (9, 1);
INSERT INTO `role_access` VALUES (10, 1);
INSERT INTO `role_access` VALUES (11, 1);
INSERT INTO `role_access` VALUES (12, 1);
INSERT INTO `role_access` VALUES (13, 1);
INSERT INTO `role_access` VALUES (14, 1);
INSERT INTO `role_access` VALUES (15, 1);
INSERT INTO `role_access` VALUES (16, 1);
INSERT INTO `role_access` VALUES (17, 1);
INSERT INTO `role_access` VALUES (18, 1);
INSERT INTO `role_access` VALUES (19, 1);
INSERT INTO `role_access` VALUES (20, 1);
INSERT INTO `role_access` VALUES (21, 1);
INSERT INTO `role_access` VALUES (22, 1);
INSERT INTO `role_access` VALUES (23, 1);
INSERT INTO `role_access` VALUES (24, 1);
INSERT INTO `role_access` VALUES (25, 1);
INSERT INTO `role_access` VALUES (26, 1);
INSERT INTO `role_access` VALUES (27, 1);
INSERT INTO `role_access` VALUES (28, 1);

-- ----------------------------
-- Table structure for schools
-- ----------------------------
DROP TABLE IF EXISTS `schools`;
CREATE TABLE `schools`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `school_name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `sort` bigint NULL DEFAULT NULL,
  `status` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of schools
-- ----------------------------
INSERT INTO `schools` VALUES (2, '广西城市职业大学', NULL, 1);
INSERT INTO `schools` VALUES (3, '广西自然资源职业技术学院', NULL, 1);
INSERT INTO `schools` VALUES (4, '广西农业工程职业技术学院', NULL, 1);
INSERT INTO `schools` VALUES (5, '崇左幼儿师范高等专科学校', NULL, 1);
INSERT INTO `schools` VALUES (6, '广西理工职业技术学院', NULL, 1);
INSERT INTO `schools` VALUES (7, '广西科技职业学院', NULL, 1);
INSERT INTO `schools` VALUES (8, '广西中远职业学院', NULL, 1);
INSERT INTO `schools` VALUES (9, '广西民族师范学院', NULL, 1);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `school_id` bigint NULL DEFAULT NULL,
  `school_name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `signature` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `user_phone` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `goods_release` bigint NULL DEFAULT NULL,
  `goods_collect` bigint NULL DEFAULT NULL,
  `avatar_url` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `add_time` bigint NULL DEFAULT NULL,
  `status` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (62, '对对对', 9, '广西民族师范学院', '9db6b2b8598a4579e7126322a5eb21659d571f87', '', 0, 0, 'static/avatar_upload/20230811/10d078497b8jfd2.jpg', 1691723543, 1);
INSERT INTO `users` VALUES (63, '嘎嘎嘎', 9, '广西民族师范学院', '1667b1e5f0af720fd39c1e1cc7b030d707a5293a', '', 0, 0, 'static/avatar_upload/20230811/10d0782chj4g7d4.jpg', 1691723750, NULL);
INSERT INTO `users` VALUES (64, '哈哈哈', 9, '广西民族师范学院', 'cab0c87f317f5c174764e8a533a22297997aa37a', '', 0, 0, 'static/avatar_upload/20230814/10d1g3g6505j9e7.jpg', 1691723763, NULL);
INSERT INTO `users` VALUES (65, '嘻嘻嘻', 9, '广西民族师范学院', 'f0a5e5b0129d24200a6643d699cdd8d67caedf6a', '', 0, 0, 'static/avatar_upload/20230814/10d1g3h69d09914.jpg', 1691745202, NULL);
INSERT INTO `users` VALUES (66, '小吴', 9, '广西民族师范学院', '3389b65f4a36f70103539da20dc60cd427c43e7b', '', 0, 0, 'static/avatar_upload/20230811/10d0b8a2i150aa3.jpg', 1691764929, NULL);
INSERT INTO `users` VALUES (67, '委托人', 9, '广西民族师范学院', 'aad6b5c16c015c214945d06c14caead55f518564', '', 0, 0, 'static/avatar_upload/20230814/10d1g3dii9hg6ea.jpg', 1691893689, NULL);
INSERT INTO `users` VALUES (68, '爱爱', 9, '广西民族师范学院', '4aeda412b5868065e4684f676a0a79fcbb9133f3', '', 0, 0, 'static/avatar_upload/20230813/10d14031e37jea3.jpg', 1691893791, NULL);
INSERT INTO `users` VALUES (69, '微信用户', 0, '', '57ed7a597308d55d67930dfba4ce844a8818173a', '', 0, 0, 'https://thirdwx.qlogo.cn/mmopen/vi_32/POgEwh4mIHO4nibH0KlMECNjjGxQUq24ZEaGT4poC6icRiccVGKSyXwibcPq4BWmiaIGuG1icwxaQX6grC9VemZoJ8rg/132', 1692344928, NULL);
INSERT INTO `users` VALUES (70, '天涯海角', 9, '广西民族师范学院', 'f7d2b9a420a7d83c31724e2e912e8930757fae78', '', 0, 0, 'static/avatar_upload/20230818/10d3815jf9id06e.jpg', 1692344937, NULL);
INSERT INTO `users` VALUES (71, '哈哈哈哈', 9, '0', '7dd22fd334787d6f5c0d1ff9ee2313f3a110b17f', '', 0, 0, 'static/avatar_upload/20230912/10de0ea4a5b5c3e.jpg', 1693056721, 0);

SET FOREIGN_KEY_CHECKS = 1;
