/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50614
Source Host           : localhost:3306
Source Database       : czs

Target Server Type    : MYSQL
Target Server Version : 50614
File Encoding         : 65001

Date: 2014-05-15 17:10:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bill
-- ----------------------------
DROP TABLE IF EXISTS `bill`;
CREATE TABLE `bill` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `business_id` varchar(255) DEFAULT NULL,
  `consumer_id` varchar(255) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL COMMENT '结账类型,0:个人;1:集体',
  `consume_code` varchar(500) DEFAULT NULL,
  `scene_id` bigint(20) DEFAULT NULL,
  `status` smallint(6) DEFAULT '0' COMMENT '0:未结算;1:已结算;2忽略',
  `sett_date_time` datetime DEFAULT NULL COMMENT '结算日期',
  `sett_handler` varchar(255) DEFAULT NULL COMMENT '结算者',
  `bill_handler` varchar(255) DEFAULT NULL COMMENT '结账登记者',
  `is_delete` smallint(6) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bill
-- ----------------------------

-- ----------------------------
-- Table structure for business
-- ----------------------------
DROP TABLE IF EXISTS `business`;
CREATE TABLE `business` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `open_id` varchar(255) DEFAULT NULL,
  `is_deleted` smallint(6) DEFAULT NULL,
  `name` varchar(500) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `introduce` varchar(1000) DEFAULT NULL,
  `phone_number` varchar(50) DEFAULT NULL,
  `qrcode_limit` bigint(255) DEFAULT NULL,
  `dynamic_code` varchar(255) DEFAULT NULL COMMENT '商家动态登录码',
  `is_mail_verify` smallint(6) DEFAULT '0' COMMENT '是否已经邮箱验证;0:没有验证,1:已经验证',
  `is_phone_verify` smallint(6) DEFAULT '0' COMMENT '是否已经手机验证;0:没有验证,1:已经验证',
  `password` varchar(255) DEFAULT NULL,
  `status` smallint(6) DEFAULT '0' COMMENT '0:申请中;1:审核通过',
  `date_time` datetime DEFAULT NULL,
  `audit_handler` varchar(255) DEFAULT NULL COMMENT '审核者',
  `audit_date_time` datetime DEFAULT NULL,
  `days` bigint(20) DEFAULT NULL COMMENT '使用天数',
  `login_times` bigint(20) DEFAULT NULL,
  `life_value` bigint(20) DEFAULT '0' COMMENT '生命值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of business
-- ----------------------------
INSERT INTO `business` VALUES ('17', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '0', '天下一绝', '上海 浦东新区 庭安路825号', 'xiweicheng@yeah.net', '美食天堂，欢迎光临！', '18721764335', '100', '124390', '1', '0', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '1', '2014-05-15 16:40:14', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-05-15 16:49:08', '3650', null, '0');

-- ----------------------------
-- Table structure for business_consumer
-- ----------------------------
DROP TABLE IF EXISTS `business_consumer`;
CREATE TABLE `business_consumer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `business_id` varchar(255) DEFAULT NULL COMMENT '商家openid',
  `consumer_id` varchar(255) DEFAULT NULL COMMENT '食客openid',
  `consume_times` bigint(20) DEFAULT NULL COMMENT '食客在改商家消费次数',
  `last_consume_time` datetime DEFAULT NULL COMMENT '食客在该商家最后消费时间',
  `scene_id` bigint(20) DEFAULT NULL,
  `consume_code` varchar(500) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL COMMENT '消费状态->1:消费进行中;0:消费结束;2:禁止消费;3:个人结账申请中,4:集体结账申请中,5:进入中',
  `handler` varchar(255) DEFAULT NULL,
  `handle_date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of business_consumer
-- ----------------------------

-- ----------------------------
-- Table structure for business_consumer_record
-- ----------------------------
DROP TABLE IF EXISTS `business_consumer_record`;
CREATE TABLE `business_consumer_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `business_id` varchar(255) DEFAULT NULL COMMENT '商家openid',
  `consumer_id` varchar(255) DEFAULT NULL COMMENT '食客openid',
  `consume_time` datetime DEFAULT NULL COMMENT '食客在该商家最后消费时间',
  `scene_id` bigint(20) DEFAULT NULL,
  `consume_code` varchar(500) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL COMMENT '消费状态->1:消费进行中;0:消费结束;2:禁止消费;3:个人结账申请中,4:集体结账申请中,5:进入中',
  `is_delete` smallint(6) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of business_consumer_record
-- ----------------------------

-- ----------------------------
-- Table structure for business_role
-- ----------------------------
DROP TABLE IF EXISTS `business_role`;
CREATE TABLE `business_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `business_id` varchar(255) DEFAULT NULL,
  `open_id` varchar(255) DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL COMMENT '0:待定,1:店主,2:后厨,3:服务员:4:前台',
  `is_delete` smallint(6) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of business_role
-- ----------------------------

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(500) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `is_deleted` smallint(6) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '台桌', 'TZ', '0', 'qrcode');
INSERT INTO `category` VALUES ('2', '角色', 'JS', '0', 'qrcode');
INSERT INTO `category` VALUES ('3', '结账', 'JZ', '1', 'qrcode');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `openId` varchar(255) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `is_delete` smallint(6) DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL,
  `p_id` bigint(20) DEFAULT NULL,
  `handler` varchar(255) DEFAULT NULL,
  `handle_date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment
-- ----------------------------

-- ----------------------------
-- Table structure for czs_user
-- ----------------------------
DROP TABLE IF EXISTS `czs_user`;
CREATE TABLE `czs_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `dynamic_code` varchar(255) DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `is_delete` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of czs_user
-- ----------------------------
INSERT INTO `czs_user` VALUES ('2', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', 'xiweicheng', 'xiweicheng@yeah.net', '18721764335', '上海 浦东新区', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', null, '0', '0', '0');

-- ----------------------------
-- Table structure for favorites
-- ----------------------------
DROP TABLE IF EXISTS `favorites`;
CREATE TABLE `favorites` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `open_id` varchar(255) DEFAULT NULL,
  `ref_id` varchar(255) DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL COMMENT '收藏类型;0:商家收藏,1:菜单收藏',
  `date_time` datetime DEFAULT NULL,
  `is_delete` smallint(6) DEFAULT NULL,
  `limit_code` varchar(255) DEFAULT NULL COMMENT '限制码,一天只能赞一次. 20140409',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of favorites
-- ----------------------------

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date_time` datetime DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `is_delete` smallint(6) DEFAULT NULL,
  `object_id` varchar(255) DEFAULT NULL,
  `detail` varchar(2000) DEFAULT NULL,
  `handler` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log
-- ----------------------------

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(500) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `privilege` decimal(10,2) DEFAULT '0.00',
  `taste_id` bigint(20) DEFAULT NULL,
  `introduce` varchar(2000) DEFAULT NULL,
  `resource_id` bigint(20) DEFAULT NULL,
  `is_delete` smallint(6) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `order_times` bigint(20) DEFAULT '0',
  `tags` varchar(255) DEFAULT NULL COMMENT '菜单标签说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('20', '蓝莓山药', '36', '12.00', '0.00', '24', '', '71', '0', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:37:06', '14', null);
INSERT INTO `menu` VALUES ('21', '长寿菜', '36', '9.00', '0.00', '30', '长寿菜，又名叶用甘薯，俗称白薯叶、番薯叶、地瓜叶，是甘薯的叶、叶柄和芽梢部，学名Ipomoea atatas (L. ) Lam. ，为旋花科(Convolvulaceae)牵牛花属草本匍匐性蔓生植物。在热带为多年生。原产于热带美洲。现广泛栽培于全世界热带和亚热带地区。我国南北各地都有栽培，以收获地下块根为主，叶蔓作饲料，民间也有采食叶作为粗菜。近年发现，薯叶中含丰富的营养物质，是维生素历、矿物质钾、钙之来源，而且其病虫害甚少，很少使用农药，比其他叶菜类较抗暴风雨，生长迅速，为良好的夏季叶菜。它在人们追求享受自然的风味中获得重视，在台湾省它作为一种优良的深绿色蔬菜发展很快。', '85', '0', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:42:09', '12', null);
INSERT INTO `menu` VALUES ('22', '外婆烤肉', '38', '29.00', '0.00', '31', '能说的只能是赞了……', '86', '0', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:45:07', '1', null);
INSERT INTO `menu` VALUES ('23', '大烤茄子', '38', '10.00', '0.00', '30', '', '75', '0', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:47:21', '2', null);
INSERT INTO `menu` VALUES ('24', '外婆黑米糕', '40', '15.00', '0.00', '24', '', '79', '0', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:48:02', '1', null);
INSERT INTO `menu` VALUES ('25', '绿茶饼', '40', '12.00', '0.00', '24', '', '76', '0', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:48:51', '3', null);
INSERT INTO `menu` VALUES ('26', '双皮奶', '45', '10.00', '0.00', '24', '', '74', '0', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:50:14', '4', null);
INSERT INTO `menu` VALUES ('27', '花生绵绵冰', '45', '18.00', '0.00', '24', '', '72', '0', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:51:24', '8', null);
INSERT INTO `menu` VALUES ('28', '想吃土豆', '37', '10.00', '0.00', '29', '', '82', '0', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:52:24', '6', null);
INSERT INTO `menu` VALUES ('29', '石锅牛蛙', '37', '42.00', '0.00', '26', '', '73', '0', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:53:20', '5', null);
INSERT INTO `menu` VALUES ('30', '糖醋里脊', '37', '18.00', '0.00', '30', '', '77', '0', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:54:06', '11', null);
INSERT INTO `menu` VALUES ('31', '茶树菇爆鲜鱿', '37', '25.00', '0.00', '30', '', '83', '0', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:54:55', '4', null);
INSERT INTO `menu` VALUES ('32', '蒜蓉粉丝虾', '37', '35.00', '0.00', '30', '', '80', '0', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:55:37', '7', null);
INSERT INTO `menu` VALUES ('33', '有机花菜', '41', '16.00', '0.00', '30', '', '87', '0', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:56:23', '5', null);
INSERT INTO `menu` VALUES ('34', '鸡毛菜烩蘑菇', '41', '12.00', '0.00', '30', '', '78', '0', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:57:33', '3', null);
INSERT INTO `menu` VALUES ('35', '冰桔茶', '44', '8.00', '0.00', '23', '', '84', '0', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:58:20', '5', null);
INSERT INTO `menu` VALUES ('36', '玉米汁', '44', '15.00', '0.00', '24', '', '81', '0', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:59:05', '5', null);
INSERT INTO `menu` VALUES ('37', '妈咪宝贝', '46', '99.00', '0.00', '32', '美味可口！', '89', '0', 'okPUDt6_6iTJLf-XZhLPhzZHbtL8', '2014-04-23 22:03:49', '0', null);
INSERT INTO `menu` VALUES ('38', '妈妈咪呀', '47', '998.00', '0.00', '33', '无言以表！', '88', '0', 'okPUDt6_6iTJLf-XZhLPhzZHbtL8', '2014-04-23 22:06:28', '0', null);

-- ----------------------------
-- Table structure for menu_bill
-- ----------------------------
DROP TABLE IF EXISTS `menu_bill`;
CREATE TABLE `menu_bill` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `menu_id` bigint(20) DEFAULT NULL,
  `consumer_id` varchar(255) DEFAULT NULL COMMENT '顾客openid',
  `consume_code` varchar(500) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL COMMENT '0:待定;1:确定;2:退订;3:已处理',
  `scene_id` bigint(20) DEFAULT NULL COMMENT '区分是哪桌',
  `copies` bigint(20) DEFAULT NULL COMMENT '份数',
  `accepter_id` varchar(255) DEFAULT NULL COMMENT '订单接受者',
  `memo` varchar(500) DEFAULT NULL COMMENT '点餐备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=344 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu_bill
-- ----------------------------

-- ----------------------------
-- Table structure for menu_category
-- ----------------------------
DROP TABLE IF EXISTS `menu_category`;
CREATE TABLE `menu_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `is_delete` smallint(6) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu_category
-- ----------------------------
INSERT INTO `menu_category` VALUES ('36', '冷菜', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '0', '2014-04-19 18:49:44');
INSERT INTO `menu_category` VALUES ('37', '热菜', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '0', '2014-04-19 18:49:50');
INSERT INTO `menu_category` VALUES ('38', '烧烤', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '0', '2014-04-19 18:49:59');
INSERT INTO `menu_category` VALUES ('39', '汤羹', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '0', '2014-04-19 18:50:06');
INSERT INTO `menu_category` VALUES ('40', '点心', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '0', '2014-04-19 18:50:15');
INSERT INTO `menu_category` VALUES ('41', '蔬菜', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '0', '2014-04-19 18:50:21');
INSERT INTO `menu_category` VALUES ('42', '酒水', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '0', '2014-04-19 18:50:26');
INSERT INTO `menu_category` VALUES ('43', '果汁', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '0', '2014-04-19 18:50:32');
INSERT INTO `menu_category` VALUES ('44', '饮料', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '0', '2014-04-19 18:50:43');
INSERT INTO `menu_category` VALUES ('45', '甜品', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '0', '2014-04-19 23:50:05');
INSERT INTO `menu_category` VALUES ('46', '特色', 'okPUDt6_6iTJLf-XZhLPhzZHbtL8', '0', '2014-04-23 22:02:54');
INSERT INTO `menu_category` VALUES ('47', '招牌', 'okPUDt6_6iTJLf-XZhLPhzZHbtL8', '0', '2014-04-23 22:06:22');

-- ----------------------------
-- Table structure for menu_taste
-- ----------------------------
DROP TABLE IF EXISTS `menu_taste`;
CREATE TABLE `menu_taste` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `is_delete` smallint(6) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu_taste
-- ----------------------------
INSERT INTO `menu_taste` VALUES ('23', '酸', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '0', '2014-04-19 23:33:50');
INSERT INTO `menu_taste` VALUES ('24', '甜', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '0', '2014-04-19 23:33:58');
INSERT INTO `menu_taste` VALUES ('25', '苦', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '0', '2014-04-19 23:34:04');
INSERT INTO `menu_taste` VALUES ('26', '辣', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '0', '2014-04-19 23:34:09');
INSERT INTO `menu_taste` VALUES ('27', '涩', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '0', '2014-04-19 23:34:14');
INSERT INTO `menu_taste` VALUES ('28', '麻', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '0', '2014-04-19 23:34:23');
INSERT INTO `menu_taste` VALUES ('29', '腻', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '0', '2014-04-19 23:34:28');
INSERT INTO `menu_taste` VALUES ('30', '鲜', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '0', '2014-04-19 23:41:32');
INSERT INTO `menu_taste` VALUES ('31', '爽', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '0', '2014-04-19 23:44:47');
INSERT INTO `menu_taste` VALUES ('32', '鲜嫩', 'okPUDt6_6iTJLf-XZhLPhzZHbtL8', '0', '2014-04-23 22:03:22');
INSERT INTO `menu_taste` VALUES ('33', '可口', 'okPUDt6_6iTJLf-XZhLPhzZHbtL8', '0', '2014-04-23 22:06:26');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_user_name` varchar(255) DEFAULT NULL,
  `create_time` bigint(20) DEFAULT NULL,
  `msg_type` varchar(255) DEFAULT NULL,
  `content` longtext,
  `msg_id` bigint(20) DEFAULT NULL,
  `pic_url` varchar(500) DEFAULT NULL,
  `media_id` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `thumb_media_id` varchar(255) DEFAULT NULL,
  `location_x` decimal(10,6) DEFAULT NULL,
  `location_y` decimal(10,6) DEFAULT NULL,
  `scale` decimal(10,6) DEFAULT NULL,
  `label` varchar(1000) DEFAULT NULL,
  `title` varchar(500) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `event_key` varchar(500) DEFAULT NULL,
  `latitude` decimal(10,6) DEFAULT NULL,
  `longitude` decimal(10,6) DEFAULT NULL,
  `precision_` decimal(10,6) DEFAULT NULL,
  `ticket` varchar(500) DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `to_open_id` varchar(255) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `status` smallint(6) DEFAULT '0',
  `is_delete` smallint(6) DEFAULT '0',
  `scene_id` bigint(20) DEFAULT NULL,
  `recognition` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1524 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('1516', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '1400143275', 'event', null, null, null, null, null, null, '0.000000', '0.000000', '0.000000', null, null, null, null, 'business_evt_key_1', '0.000000', '0.000000', '0.000000', null, 'CLICK', null, '2014-05-15 16:40:14', '0', null, null, null);
INSERT INTO `message` VALUES ('1517', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '1400143298', 'event', null, null, null, null, null, null, '0.000000', '0.000000', '0.000000', null, null, null, null, 'business_evt_key_1', '0.000000', '0.000000', '0.000000', null, 'CLICK', null, '2014-05-15 16:40:15', '0', null, null, null);
INSERT INTO `message` VALUES ('1518', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '1400143439', 'event', null, null, null, null, null, null, '0.000000', '0.000000', '0.000000', null, null, null, null, 'http://www.canzs.cn/czs/login.do', '0.000000', '0.000000', '0.000000', null, 'VIEW', null, '2014-05-15 16:42:38', '0', null, null, null);
INSERT INTO `message` VALUES ('1519', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '1400143509', 'event', null, null, null, null, null, null, '0.000000', '0.000000', '0.000000', null, null, null, null, '', '0.000000', '0.000000', '0.000000', null, 'unsubscribe', null, '2014-05-15 16:43:47', '0', null, null, null);
INSERT INTO `message` VALUES ('1520', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '1400143518', 'event', null, null, null, null, null, null, '0.000000', '0.000000', '0.000000', null, null, null, null, '', '0.000000', '0.000000', '0.000000', null, 'subscribe', null, '2014-05-15 16:43:54', '0', null, null, null);
INSERT INTO `message` VALUES ('1521', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '1400143800', 'event', null, null, null, null, null, null, '0.000000', '0.000000', '0.000000', null, null, null, null, 'http://www.canzs.cn/czs/login.do', '0.000000', '0.000000', '0.000000', null, 'VIEW', null, '2014-05-15 16:48:41', '0', null, null, null);
INSERT INTO `message` VALUES ('1522', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '1400144634', 'event', null, null, null, null, null, null, '0.000000', '0.000000', '0.000000', null, null, null, null, 'business_evt_key_1', '0.000000', '0.000000', '0.000000', null, 'CLICK', null, '2014-05-15 17:02:30', '0', null, null, null);
INSERT INTO `message` VALUES ('1523', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '1400144753', 'event', null, null, null, null, null, null, '0.000000', '0.000000', '0.000000', null, null, null, null, 'business_evt_key_2', '0.000000', '0.000000', '0.000000', null, 'CLICK', null, '2014-05-15 17:04:29', '0', null, null, null);

-- ----------------------------
-- Table structure for qrcode
-- ----------------------------
DROP TABLE IF EXISTS `qrcode`;
CREATE TABLE `qrcode` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `open_id` varchar(255) DEFAULT NULL,
  `scene_id` bigint(20) DEFAULT NULL,
  `use_limit` bigint(20) DEFAULT NULL,
  `use_times` bigint(20) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `ticket` varchar(1000) DEFAULT NULL,
  `url` varchar(1000) DEFAULT NULL COMMENT '二维码在微信服务器的url.',
  `file_path` varchar(1000) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL COMMENT 'QR_LIMIT_SCENE(永久) 或者 QR_SCENE(临时)',
  `my_url` varchar(1000) DEFAULT NULL COMMENT '二维码在自己服务器的url.',
  `description` varchar(1000) DEFAULT NULL COMMENT '二维码描述',
  `date_time` datetime DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `is_delete` smallint(6) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrcode
-- ----------------------------

-- ----------------------------
-- Table structure for request
-- ----------------------------
DROP TABLE IF EXISTS `request`;
CREATE TABLE `request` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) DEFAULT NULL,
  `consumer_id` varchar(255) DEFAULT NULL,
  `business_id` varchar(255) DEFAULT NULL,
  `consume_code` varchar(500) DEFAULT NULL,
  `scene_id` bigint(20) DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `is_delete` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=301 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of request
-- ----------------------------

-- ----------------------------
-- Table structure for resources
-- ----------------------------
DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) DEFAULT NULL,
  `path` varchar(1000) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL COMMENT '资源的类型 图片 音乐...',
  `owner` varchar(255) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `is_delete` smallint(6) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of resources
-- ----------------------------
INSERT INTO `resources` VALUES ('71', '蓝莓山药', 'resources/images/menu/', '3b3adf23-9361-4dfc-a540-61b789d3fcf7.jpg', 'image', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:06:42', '0');
INSERT INTO `resources` VALUES ('72', '花生绵绵冰', 'resources/images/menu/', '09046712-47c7-46d7-862a-fb3cddba3ffc.jpg', 'image', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:06:42', '0');
INSERT INTO `resources` VALUES ('73', '石锅牛蛙', 'resources/images/menu/', 'd1c59445-4db2-468a-aaf0-1fc7fbf5267c.jpg', 'image', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:06:42', '0');
INSERT INTO `resources` VALUES ('74', '双皮奶.jpg', 'resources/images/menu/', '2f82ccf1-e886-4600-a116-589ff02af5e4.jpg', 'image', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:06:42', '0');
INSERT INTO `resources` VALUES ('75', '烤茄子.jpg', 'resources/images/menu/', 'c1b17b42-c205-496b-a1c7-4e68b920a579.jpg', 'image', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:06:42', '0');
INSERT INTO `resources` VALUES ('76', '绿茶饼', 'resources/images/menu/', 'd22e064f-c17b-4cd5-a9fa-6c0e81910748.jpg', 'image', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:06:42', '0');
INSERT INTO `resources` VALUES ('77', '糖醋里脊.jpg', 'resources/images/menu/', '385b7dc5-f331-4cd3-9a14-f25e071d485e.jpg', 'image', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:06:43', '0');
INSERT INTO `resources` VALUES ('78', '鸡毛菜烩蘑菇.jpg', 'resources/images/menu/', 'dfdd62c1-79a3-426c-9b34-6cc1e4ce3f38.jpg', 'image', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:06:42', '0');
INSERT INTO `resources` VALUES ('79', '外婆黑米糕.jpg', 'resources/images/menu/', '85c59bb9-84c2-4958-a605-4d92cf3a0e9f.jpg', 'image', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:06:43', '0');
INSERT INTO `resources` VALUES ('80', '蒜蓉粉丝虾.jpg', 'resources/images/menu/', 'f1b82d53-2ac7-436d-ac4b-0794cf731941.jpg', 'image', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:06:43', '0');
INSERT INTO `resources` VALUES ('81', '玉米汁.jpg', 'resources/images/menu/', 'b26d802a-3404-413d-8b9a-7ef6d2f12942.jpg', 'image', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:06:43', '0');
INSERT INTO `resources` VALUES ('82', '想吃土豆.jpg', 'resources/images/menu/', 'b68bbfc9-d127-4e5c-9091-c8d915d41e37.jpg', 'image', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:06:43', '0');
INSERT INTO `resources` VALUES ('83', '茶树菇爆鲜鱿', 'resources/images/menu/', 'f9fc5f3b-979a-4a4a-8ce8-ba9c98fa8be0.jpg', 'image', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:06:43', '0');
INSERT INTO `resources` VALUES ('84', '冰桔茶.jpg', 'resources/images/menu/', 'fbaf6dd8-41d6-4628-a506-1987bc082212.jpg', 'image', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:06:43', '0');
INSERT INTO `resources` VALUES ('85', '长寿菜.jpg', 'resources/images/menu/', '216c57fd-2482-4e18-a6eb-8ff7e0e7280d.jpg', 'image', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:06:43', '0');
INSERT INTO `resources` VALUES ('86', '外婆烤肉.jpg', 'resources/images/menu/', '33e27d0c-377d-4b92-b318-5742a980ad7a.jpg', 'image', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:06:43', '0');
INSERT INTO `resources` VALUES ('87', '有机花菜', 'resources/images/menu/', 'f01c0b2c-9569-4fe1-805c-de43a133b67e.jpg', 'image', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '2014-04-19 23:06:43', '0');
INSERT INTO `resources` VALUES ('88', '秀色可餐', 'resources/images/menu/', 'ce1b3bb5-98db-4ef6-8091-5715217cf6aa.jpg', 'image', 'okPUDt6_6iTJLf-XZhLPhzZHbtL8', '2014-04-23 22:00:52', '0');
INSERT INTO `resources` VALUES ('89', '妈咪宝贝', 'resources/images/menu/', 'ab5fbcf4-6976-4584-83ca-46262f33af29.jpg', 'image', 'okPUDt6_6iTJLf-XZhLPhzZHbtL8', '2014-04-23 22:01:26', '0');

-- ----------------------------
-- Table structure for service
-- ----------------------------
DROP TABLE IF EXISTS `service`;
CREATE TABLE `service` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `consumer_id` varchar(255) DEFAULT NULL,
  `business_id` varchar(255) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL COMMENT '服务类型',
  `status` smallint(6) DEFAULT NULL COMMENT '状态,1:呼叫中,0:已接受',
  `is_delete` smallint(6) DEFAULT '0',
  `handler` varchar(255) DEFAULT NULL COMMENT '处理者',
  `appraise` smallint(6) DEFAULT NULL COMMENT '服务评价',
  `scene_id` bigint(20) DEFAULT NULL,
  `handle_date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of service
-- ----------------------------

-- ----------------------------
-- Table structure for subscriber
-- ----------------------------
DROP TABLE IF EXISTS `subscriber`;
CREATE TABLE `subscriber` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `sex` smallint(6) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  `headimgurl` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of subscriber
-- ----------------------------
INSERT INTO `subscriber` VALUES ('22', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '席维成', '1', '浦东新区', '中国', '上海', 'zh_CN', 'http://wx.qlogo.cn/mmopen/DiaiaOiaOW4BbdPzGfvcMXKBIluKNgJhMX5sFk0fELyiavE636NlqcKxdzUHfXWVvKwsOkBoAX66qgMrWSKybA3Kthl4swmpIEoY/0');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT NULL COMMENT '微信用户的openid',
  `create_time` bigint(20) DEFAULT NULL COMMENT '用户关注时间',
  `is_deleted` smallint(6) DEFAULT NULL COMMENT '用户是否关注状态;1:未关注,0:关注',
  `times` int(11) NOT NULL COMMENT '用户关注&取消关注的次数累积',
  `latitude` decimal(10,6) DEFAULT NULL,
  `longitude` decimal(10,6) DEFAULT NULL,
  `precision_` decimal(10,6) DEFAULT NULL,
  `consume_code` varchar(500) DEFAULT NULL COMMENT '食客消费码',
  `status` smallint(6) DEFAULT '0' COMMENT '用户状态',
  PRIMARY KEY (`id`),
  KEY `user_name` (`user_name`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('20', 'okPUDtzjrogWsWdsI_Fz39VNbgBc', '1400143518', '0', '1', null, null, null, null, null);

-- ----------------------------
-- Function structure for queryChildrenComment
-- ----------------------------
DROP FUNCTION IF EXISTS `queryChildrenComment`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `queryChildrenComment`(`id` bigint) RETURNS varchar(4000) CHARSET utf8
BEGIN
	#Routine body goes here...
	DECLARE sTemp VARCHAR(4000);
	DECLARE sTempChd VARCHAR(4000);

	SET sTemp = '$';
	SET sTempChd = cast(id as char);

	WHILE sTempChd is not NULL DO
		SET sTemp = CONCAT(sTemp,',',sTempChd);
		SELECT group_concat(`comment`.id) INTO sTempChd FROM `comment` where FIND_IN_SET(p_id,sTempChd) > 0;
	END WHILE;
	RETURN sTemp;
END
;;
DELIMITER ;