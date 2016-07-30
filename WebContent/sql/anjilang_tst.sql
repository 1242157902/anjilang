/*
Navicat MySQL Data Transfer

Source Server         : 10.5.113.254
Source Server Version : 50623
Source Host           : 10.5.113.254:3306
Source Database       : anjilang_tst

Target Server Type    : MYSQL
Target Server Version : 50623
File Encoding         : 65001

Date: 2015-10-31 21:47:17
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `comment`
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `commentId` int(11) NOT NULL AUTO_INCREMENT,
  `commTime` datetime DEFAULT NULL,
  `hide` bit(1) DEFAULT NULL,
  `td` datetime DEFAULT NULL,
  `userComment` varchar(2048) DEFAULT NULL,
  `userHome` varchar(255) DEFAULT NULL,
  `userIp` varchar(255) DEFAULT NULL,
  `userMail` varchar(255) DEFAULT NULL,
  `userName` varchar(255) DEFAULT NULL,
  `logId` int(11) DEFAULT NULL,
  `postId` varchar(100) DEFAULT NULL COMMENT '多说评论使用',
  PRIMARY KEY (`commentId`),
  UNIQUE KEY `postId` (`postId`),
  KEY `logId` (`logId`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`logId`) REFERENCES `log` (`logId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment
-- ----------------------------

-- ----------------------------
-- Table structure for `link`
-- ----------------------------
DROP TABLE IF EXISTS `link`;
CREATE TABLE `link` (
  `linkId` int(11) NOT NULL AUTO_INCREMENT,
  `alt` varchar(255) DEFAULT NULL,
  `linkName` varchar(255) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `status` bit(1) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`linkId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of link
-- ----------------------------

-- ----------------------------
-- Table structure for `log`
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `logId` int(11) NOT NULL AUTO_INCREMENT,
  `alias` varchar(255) DEFAULT NULL,
  `canComment` bit(1) DEFAULT b'1',
  `click` int(11) DEFAULT '0',
  `content` longtext,
  `mdContent` longtext,
  `digest` text,
  `keywords` varchar(255) DEFAULT NULL,
  `recommended` bit(1) DEFAULT b'0',
  `releaseTime` datetime DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `typeId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `hot` bit(1) DEFAULT NULL,
  `rubbish` bit(1) DEFAULT NULL,
  `private` bit(1) DEFAULT NULL,
  PRIMARY KEY (`logId`),
  KEY `typeId` (`typeId`),
  KEY `userId` (`userId`),
  CONSTRAINT `log_ibfk_1` FOREIGN KEY (`typeId`) REFERENCES `type` (`typeId`),
  CONSTRAINT `log_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log
-- ----------------------------

-- ----------------------------
-- Table structure for `lognav`
-- ----------------------------
DROP TABLE IF EXISTS `lognav`;
CREATE TABLE `lognav` (
  `navId` int(11) NOT NULL AUTO_INCREMENT,
  `navName` varchar(255) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`navId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lognav
-- ----------------------------

-- ----------------------------
-- Table structure for `plugin`
-- ----------------------------
DROP TABLE IF EXISTS `plugin`;
CREATE TABLE `plugin` (
  `pluginId` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `isSystem` bit(1) DEFAULT NULL,
  `pTitle` varchar(255) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `pluginName` varchar(255) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  PRIMARY KEY (`pluginId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of plugin
-- ----------------------------

-- ----------------------------
-- Table structure for `tablename`
-- ----------------------------
DROP TABLE IF EXISTS `tablename`;
CREATE TABLE `tablename` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `PROJECT_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tablename
-- ----------------------------

-- ----------------------------
-- Table structure for `tag`
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `tagId` int(11) NOT NULL AUTO_INCREMENT,
  `count` int(11) NOT NULL DEFAULT '0',
  `text` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`tagId`),
  UNIQUE KEY `text` (`text`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tag
-- ----------------------------

-- ----------------------------
-- Table structure for `type`
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type` (
  `typeId` int(11) NOT NULL AUTO_INCREMENT,
  `alias` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `typeName` varchar(255) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  PRIMARY KEY (`typeId`),
  KEY `pid` (`pid`),
  CONSTRAINT `type_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `type` (`typeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of type
-- ----------------------------

-- ----------------------------
-- Table structure for `t_answer`
-- ----------------------------
DROP TABLE IF EXISTS `t_answer`;
CREATE TABLE `t_answer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户Id',
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  `crTime` datetime DEFAULT NULL COMMENT '创建时间',
  `answerId` bigint(20) DEFAULT '0' COMMENT '所属问题ID',
  `userId` bigint(20) DEFAULT NULL COMMENT '所属用户ID',
  `parentId` bigint(20) NOT NULL DEFAULT '0' COMMENT '所属父回答ID，0则代表当前问题的第一次回答',
  `agreeNum` int(11) NOT NULL DEFAULT '0' COMMENT '点赞次数',
  `question` tinyblob,
  `user` tinyblob,
  `commentNum` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FKABCA3FBEC99AD303` (`answerId`),
  KEY `FK_answer_user` (`userId`),
  CONSTRAINT `FK_answer_question` FOREIGN KEY (`answerId`) REFERENCES `t_question` (`id`),
  CONSTRAINT `FK_answer_user` FOREIGN KEY (`userId`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_answer
-- ----------------------------
INSERT INTO `t_answer` VALUES ('57', '可以吃黑鱼的。慢性肾病人出现慢性肾衰后如果需要控制蛋白的摄入量，则要按照体重、肾功能情况确定每日蛋白质摄入量，黑鱼肉是优质蛋白，不超过每日摄入量是没有问题的。蛋白质每日摄入量为0.3~0.5g/kg体重，具体要根据您的化验单指标来确定，您可以进一步详细描述下您的病情，以便给您更精准的知道，谢谢！', '2015-02-08 15:54:15', '97', '59', '0', '0', null, null, '0');
INSERT INTO `t_answer` VALUES ('58', '代糖主要是营养性甜味剂代替了白砂糖，甜味剂本身也含有能量，但是在代谢中不需胰岛素参与，因此可以少量用于产生甜味，带来良好的口味，但在享受口感的同时注意不能多吃，仍需要考虑其能量影响血糖。', '2015-02-13 17:16:51', '117', '65', '0', '0', null, null, '0');
INSERT INTO `t_answer` VALUES ('59', '有的，有各种食物增粘稠剂，您可以在医师指导下选用。', '2015-02-13 17:27:46', '118', '64', '0', '0', null, null, '0');
INSERT INTO `t_answer` VALUES ('60', '', '2015-04-06 16:39:08', '97', '38', '0', '0', null, null, '0');
INSERT INTO `t_answer` VALUES ('61', '', '2015-04-06 16:42:33', '97', '38', '0', '0', null, null, '0');
INSERT INTO `t_answer` VALUES ('62', '', '2015-04-06 16:48:42', '97', '60', '0', '0', null, null, '0');
INSERT INTO `t_answer` VALUES ('63', '', '2015-04-06 16:49:43', '97', '60', '0', '0', null, null, '0');
INSERT INTO `t_answer` VALUES ('64', '<p>121212121</p>\n', '2015-04-06 16:50:14', '97', '60', '0', '0', null, null, '0');
INSERT INTO `t_answer` VALUES ('65', '<p>TTTTTTTTTTTTTTTTTTTTTT</p>\n', '2015-04-06 17:19:03', '97', '53', '0', '0', null, null, '0');

-- ----------------------------
-- Table structure for `t_answer_comment`
-- ----------------------------
DROP TABLE IF EXISTS `t_answer_comment`;
CREATE TABLE `t_answer_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `parentId` bigint(20) DEFAULT '0',
  `userId` bigint(20) NOT NULL DEFAULT '0',
  `crTime` date NOT NULL,
  `answerId` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_coment_answer` (`answerId`),
  KEY `FK_comment_user` (`userId`),
  CONSTRAINT `FK_coment_answer` FOREIGN KEY (`answerId`) REFERENCES `t_answer` (`id`),
  CONSTRAINT `FK_comment_user` FOREIGN KEY (`userId`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_answer_comment
-- ----------------------------

-- ----------------------------
-- Table structure for `t_articleinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_articleinfo`;
CREATE TABLE `t_articleinfo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` text COMMENT '文章内容',
  `createDate` datetime DEFAULT NULL COMMENT '发表日期',
  `modifyDate` datetime DEFAULT NULL COMMENT '修改日期',
  `num` int(11) NOT NULL COMMENT '浏览次数',
  `title` varchar(255) DEFAULT NULL COMMENT '文章标题',
  `userId` bigint(20) DEFAULT NULL COMMENT '文章发表人',
  PRIMARY KEY (`id`),
  KEY `FK693E06EA7B90E1B5` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_articleinfo
-- ----------------------------
INSERT INTO `t_articleinfo` VALUES ('1', '但是滴是滴', '2015-01-11 20:31:47', '2015-01-11 20:31:47', '1', '弱弱', '3');
INSERT INTO `t_articleinfo` VALUES ('2', '<p>杜甫风v大神大神带</p>\r\n', '2015-01-11 20:31:47', '2015-01-11 20:31:47', '2', '代付', '3');
INSERT INTO `t_articleinfo` VALUES ('3', '<p>是滴是滴</p>\r\n', '2015-01-11 20:31:47', '2015-01-11 20:31:47', '4', '2323方式等所发生的', '3');
INSERT INTO `t_articleinfo` VALUES ('4', '<p>各顾各</p>\r\n', '2015-01-11 20:31:47', '2015-01-11 20:31:47', '3', '撒旦法撒旦', '3');
INSERT INTO `t_articleinfo` VALUES ('5', '<p>这是一个测试的文章，你不要激动，请慢慢的往下看完，你就 会知道我在说什么了大神大神</p>\r\n', '2015-01-17 20:31:47', '2015-01-17 20:31:47', '90', '顶呱呱', '3');
INSERT INTO `t_articleinfo` VALUES ('10', '<blockquote>\r\n<ul>\r\n	<li>dasdasdasddsaddasdas</li>\r\n	<li>dasdasd</li>\r\n	<li>\r\n	<h2 style=\"font-style: italic;\">dasd dsadasdas的撒旦</h2>\r\n	</li>\r\n</ul>\r\n</blockquote>\r\n', '2015-01-18 15:19:42', '2015-01-18 15:19:42', '0', '阿大声道', '3');
INSERT INTO `t_articleinfo` VALUES ('11', '<p>dsadasdasd</p>\r\n', '2015-01-19 21:36:46', '2015-01-19 21:36:46', '32', 'cece ', '21');
INSERT INTO `t_articleinfo` VALUES ('25', '<p>werqrqwerweqr</p>\r\n', '2015-07-22 16:19:12', null, '0', 'safdsafdf', '3');
INSERT INTO `t_articleinfo` VALUES ('26', '<p>sdfaewfre</p>\r\n', '2015-07-23 21:59:00', null, '0', 'wer', '3');
INSERT INTO `t_articleinfo` VALUES ('27', '<p>wqrewqrw</p>\r\n', '2015-07-23 21:59:30', null, '0', 'rqrere', '3');
INSERT INTO `t_articleinfo` VALUES ('28', '<p>fafda</p>\r\n', '2015-07-23 22:03:09', null, '0', 'safdsa', '3');
INSERT INTO `t_articleinfo` VALUES ('29', '<p>fsdafdsaf</p>\r\n', '2015-07-23 22:03:42', null, '0', 'werfa', '3');
INSERT INTO `t_articleinfo` VALUES ('30', '<p>wqrfewqr</p>\r\n', '2015-07-23 22:04:10', null, '0', 'afwe', '3');

-- ----------------------------
-- Table structure for `t_author`
-- ----------------------------
DROP TABLE IF EXISTS `t_author`;
CREATE TABLE `t_author` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '作者Id',
  `name` varchar(50) DEFAULT NULL COMMENT '作者姓名',
  `profile` varchar(300) DEFAULT NULL COMMENT '作者简介',
  `pic` varchar(300) DEFAULT NULL COMMENT '头像',
  `url` varchar(500) DEFAULT NULL COMMENT '路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_author
-- ----------------------------
INSERT INTO `t_author` VALUES ('1', '洛艺嘉', '出版《同居的男人》等3部小说后，突然放弃美好的生活，开始世界游 ', 'images/mittee1.jpg', 'http://localhost:8888/anjilang/personPage/toPersonData.do?id=53');
INSERT INTO `t_author` VALUES ('2', '绿巨人', '出版《同居的男人》等3部小说后，突然放弃美好的生活，开始世界游 ', 'images/mittee1.jpg', 'http://localhost:8888/anjilang/personPage/toPersonData.do?id=52');
INSERT INTO `t_author` VALUES ('3', '齐天大圣', '出版《同居的男人》等3部小说后，突然放弃美好的生活，开始世界游 ', 'images/mittee1.jpg', 'http://localhost:8888/anjilang/personPage/toPersonData.do?id=56');
INSERT INTO `t_author` VALUES ('4', '钟馗', '出版《同居的男人》等3部小说后，突然放弃美好的生活，开始世界游 ', 'images/mittee1.jpg', 'http://localhost:8888/anjilang/personPage/toPersonData.do?id=45');
INSERT INTO `t_author` VALUES ('5', '女娲', '是一个造人的神', 'images/mittee1.jpg', 'http://localhost:8888/anjilang/personPage/toPersonData.do?id=3');
INSERT INTO `t_author` VALUES ('6', '陈云海', '出版《同居的男人》等3部小说后，突然放弃美好的生活，开始世界游 ', 'images/mittee1.jpg', 'http://localhost:8888/anjilang/personPage/toPersonData.do?id=40');

-- ----------------------------
-- Table structure for `t_basis_city`
-- ----------------------------
DROP TABLE IF EXISTS `t_basis_city`;
CREATE TABLE `t_basis_city` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `city_code` varchar(255) DEFAULT NULL,
  `city_name` varchar(255) DEFAULT NULL,
  `city_parent` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3510 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_basis_city
-- ----------------------------
INSERT INTO `t_basis_city` VALUES ('1', '110000', '北京市', '0');
INSERT INTO `t_basis_city` VALUES ('3', '110101', '东城区', '1');
INSERT INTO `t_basis_city` VALUES ('4', '110102', '西城区', '1');
INSERT INTO `t_basis_city` VALUES ('5', '110105', '朝阳区', '1');
INSERT INTO `t_basis_city` VALUES ('6', '110106', '丰台区', '1');
INSERT INTO `t_basis_city` VALUES ('7', '110107', '石景山区', '1');
INSERT INTO `t_basis_city` VALUES ('8', '110108', '海淀区', '1');
INSERT INTO `t_basis_city` VALUES ('9', '110109', '门头沟区', '1');
INSERT INTO `t_basis_city` VALUES ('10', '110111', '房山区', '1');
INSERT INTO `t_basis_city` VALUES ('11', '110112', '通州区', '1');
INSERT INTO `t_basis_city` VALUES ('12', '110113', '顺义区', '1');
INSERT INTO `t_basis_city` VALUES ('13', '110114', '昌平区', '1');
INSERT INTO `t_basis_city` VALUES ('14', '110115', '大兴区', '1');
INSERT INTO `t_basis_city` VALUES ('15', '110116', '怀柔区', '1');
INSERT INTO `t_basis_city` VALUES ('16', '110117', '平谷区', '1');
INSERT INTO `t_basis_city` VALUES ('18', '110228', '密云县', '1');
INSERT INTO `t_basis_city` VALUES ('19', '110229', '延庆县', '1');
INSERT INTO `t_basis_city` VALUES ('20', '120000', '天津市', '0');
INSERT INTO `t_basis_city` VALUES ('22', '120101', '和平区', '20');
INSERT INTO `t_basis_city` VALUES ('23', '120102', '河东区', '20');
INSERT INTO `t_basis_city` VALUES ('24', '120103', '河西区', '20');
INSERT INTO `t_basis_city` VALUES ('25', '120104', '南开区', '20');
INSERT INTO `t_basis_city` VALUES ('26', '120105', '河北区', '20');
INSERT INTO `t_basis_city` VALUES ('27', '120106', '红桥区', '20');
INSERT INTO `t_basis_city` VALUES ('28', '120110', '东丽区', '20');
INSERT INTO `t_basis_city` VALUES ('29', '120111', '西青区', '20');
INSERT INTO `t_basis_city` VALUES ('30', '120112', '津南区', '20');
INSERT INTO `t_basis_city` VALUES ('31', '120113', '北辰区', '20');
INSERT INTO `t_basis_city` VALUES ('32', '120114', '武清区', '20');
INSERT INTO `t_basis_city` VALUES ('33', '120115', '宝坻区', '20');
INSERT INTO `t_basis_city` VALUES ('34', '120116', '滨海新区', '20');
INSERT INTO `t_basis_city` VALUES ('36', '120221', '宁河县', '20');
INSERT INTO `t_basis_city` VALUES ('37', '120223', '静海县', '20');
INSERT INTO `t_basis_city` VALUES ('38', '120225', '蓟县', '20');
INSERT INTO `t_basis_city` VALUES ('39', '130000', '河北省', '0');
INSERT INTO `t_basis_city` VALUES ('40', '130100', '石家庄市', '39');
INSERT INTO `t_basis_city` VALUES ('65', '130200', '唐山市', '39');
INSERT INTO `t_basis_city` VALUES ('81', '130300', '秦皇岛市', '39');
INSERT INTO `t_basis_city` VALUES ('90', '130400', '邯郸市', '39');
INSERT INTO `t_basis_city` VALUES ('111', '130500', '邢台市', '39');
INSERT INTO `t_basis_city` VALUES ('132', '130600', '保定市', '39');
INSERT INTO `t_basis_city` VALUES ('159', '130700', '张家口市', '39');
INSERT INTO `t_basis_city` VALUES ('178', '130800', '承德市', '39');
INSERT INTO `t_basis_city` VALUES ('191', '130900', '沧州市', '39');
INSERT INTO `t_basis_city` VALUES ('209', '131000', '廊坊市', '39');
INSERT INTO `t_basis_city` VALUES ('221', '131100', '衡水市', '39');
INSERT INTO `t_basis_city` VALUES ('234', '140000', '山西省', '0');
INSERT INTO `t_basis_city` VALUES ('235', '140100', '太原市', '234');
INSERT INTO `t_basis_city` VALUES ('247', '140200', '大同市', '234');
INSERT INTO `t_basis_city` VALUES ('260', '140300', '阳泉市', '234');
INSERT INTO `t_basis_city` VALUES ('267', '140400', '长治市', '234');
INSERT INTO `t_basis_city` VALUES ('282', '140500', '晋城市', '234');
INSERT INTO `t_basis_city` VALUES ('290', '140600', '朔州市', '234');
INSERT INTO `t_basis_city` VALUES ('298', '140700', '晋中市', '234');
INSERT INTO `t_basis_city` VALUES ('311', '140800', '运城市', '234');
INSERT INTO `t_basis_city` VALUES ('326', '140900', '忻州市', '234');
INSERT INTO `t_basis_city` VALUES ('342', '141000', '临汾市', '234');
INSERT INTO `t_basis_city` VALUES ('361', '141100', '吕梁市', '234');
INSERT INTO `t_basis_city` VALUES ('376', '150000', '内蒙古自治区', '0');
INSERT INTO `t_basis_city` VALUES ('377', '150100', '呼和浩特市', '376');
INSERT INTO `t_basis_city` VALUES ('388', '150200', '包头市', '376');
INSERT INTO `t_basis_city` VALUES ('399', '150300', '乌海市', '376');
INSERT INTO `t_basis_city` VALUES ('404', '150400', '赤峰市', '376');
INSERT INTO `t_basis_city` VALUES ('418', '150500', '通辽市', '376');
INSERT INTO `t_basis_city` VALUES ('428', '150600', '鄂尔多斯市', '376');
INSERT INTO `t_basis_city` VALUES ('438', '150700', '呼伦贝尔市', '376');
INSERT INTO `t_basis_city` VALUES ('453', '150800', '巴彦淖尔市', '376');
INSERT INTO `t_basis_city` VALUES ('462', '150900', '乌兰察布市', '376');
INSERT INTO `t_basis_city` VALUES ('475', '152200', '兴安盟', '376');
INSERT INTO `t_basis_city` VALUES ('482', '152500', '锡林郭勒盟', '376');
INSERT INTO `t_basis_city` VALUES ('495', '152900', '阿拉善盟', '376');
INSERT INTO `t_basis_city` VALUES ('499', '210000', '辽宁省', '0');
INSERT INTO `t_basis_city` VALUES ('500', '210100', '沈阳市', '499');
INSERT INTO `t_basis_city` VALUES ('515', '210200', '大连市', '499');
INSERT INTO `t_basis_city` VALUES ('527', '210300', '鞍山市', '499');
INSERT INTO `t_basis_city` VALUES ('536', '210400', '抚顺市', '499');
INSERT INTO `t_basis_city` VALUES ('545', '210500', '本溪市', '499');
INSERT INTO `t_basis_city` VALUES ('553', '210600', '丹东市', '499');
INSERT INTO `t_basis_city` VALUES ('561', '210700', '锦州市', '499');
INSERT INTO `t_basis_city` VALUES ('570', '210800', '营口市', '499');
INSERT INTO `t_basis_city` VALUES ('578', '210900', '阜新市', '499');
INSERT INTO `t_basis_city` VALUES ('587', '211000', '辽阳市', '499');
INSERT INTO `t_basis_city` VALUES ('596', '211100', '盘锦市', '499');
INSERT INTO `t_basis_city` VALUES ('602', '211200', '铁岭市', '499');
INSERT INTO `t_basis_city` VALUES ('611', '211300', '朝阳市', '499');
INSERT INTO `t_basis_city` VALUES ('620', '211400', '葫芦岛市', '499');
INSERT INTO `t_basis_city` VALUES ('628', '220000', '吉林省', '0');
INSERT INTO `t_basis_city` VALUES ('629', '220100', '长春市', '628');
INSERT INTO `t_basis_city` VALUES ('641', '220200', '吉林市', '628');
INSERT INTO `t_basis_city` VALUES ('652', '220300', '四平市', '628');
INSERT INTO `t_basis_city` VALUES ('660', '220400', '辽源市', '628');
INSERT INTO `t_basis_city` VALUES ('666', '220500', '通化市', '628');
INSERT INTO `t_basis_city` VALUES ('675', '220600', '白山市', '628');
INSERT INTO `t_basis_city` VALUES ('683', '220700', '松原市', '628');
INSERT INTO `t_basis_city` VALUES ('690', '220800', '白城市', '628');
INSERT INTO `t_basis_city` VALUES ('697', '222400', '延边朝鲜族自治州', '628');
INSERT INTO `t_basis_city` VALUES ('706', '230000', '黑龙江省', '0');
INSERT INTO `t_basis_city` VALUES ('707', '230100', '哈尔滨市', '706');
INSERT INTO `t_basis_city` VALUES ('727', '230200', '齐齐哈尔市', '706');
INSERT INTO `t_basis_city` VALUES ('745', '230300', '鸡西市', '706');
INSERT INTO `t_basis_city` VALUES ('756', '230400', '鹤岗市', '706');
INSERT INTO `t_basis_city` VALUES ('766', '230500', '双鸭山市', '706');
INSERT INTO `t_basis_city` VALUES ('776', '230600', '大庆市', '706');
INSERT INTO `t_basis_city` VALUES ('787', '230700', '伊春市', '706');
INSERT INTO `t_basis_city` VALUES ('806', '230800', '佳木斯市', '706');
INSERT INTO `t_basis_city` VALUES ('818', '230900', '七台河市', '706');
INSERT INTO `t_basis_city` VALUES ('824', '231000', '牡丹江市', '706');
INSERT INTO `t_basis_city` VALUES ('836', '231100', '黑河市', '706');
INSERT INTO `t_basis_city` VALUES ('844', '231200', '绥化市', '706');
INSERT INTO `t_basis_city` VALUES ('856', '232700', '大兴安岭地区', '706');
INSERT INTO `t_basis_city` VALUES ('860', '310000', '上海市', '0');
INSERT INTO `t_basis_city` VALUES ('862', '310101', '黄浦区', '860');
INSERT INTO `t_basis_city` VALUES ('863', '310104', '徐汇区', '860');
INSERT INTO `t_basis_city` VALUES ('864', '310105', '长宁区', '860');
INSERT INTO `t_basis_city` VALUES ('865', '310106', '静安区', '860');
INSERT INTO `t_basis_city` VALUES ('866', '310107', '普陀区', '860');
INSERT INTO `t_basis_city` VALUES ('867', '310108', '闸北区', '860');
INSERT INTO `t_basis_city` VALUES ('868', '310109', '虹口区', '860');
INSERT INTO `t_basis_city` VALUES ('869', '310110', '杨浦区', '860');
INSERT INTO `t_basis_city` VALUES ('870', '310112', '闵行区', '860');
INSERT INTO `t_basis_city` VALUES ('871', '310113', '宝山区', '860');
INSERT INTO `t_basis_city` VALUES ('872', '310114', '嘉定区', '860');
INSERT INTO `t_basis_city` VALUES ('873', '310115', '浦东新区', '860');
INSERT INTO `t_basis_city` VALUES ('874', '310116', '金山区', '860');
INSERT INTO `t_basis_city` VALUES ('875', '310117', '松江区', '860');
INSERT INTO `t_basis_city` VALUES ('876', '310118', '青浦区', '860');
INSERT INTO `t_basis_city` VALUES ('877', '310120', '奉贤区', '860');
INSERT INTO `t_basis_city` VALUES ('879', '310230', '崇明县', '860');
INSERT INTO `t_basis_city` VALUES ('880', '320000', '江苏省', '0');
INSERT INTO `t_basis_city` VALUES ('881', '320100', '南京市', '880');
INSERT INTO `t_basis_city` VALUES ('896', '320200', '无锡市', '880');
INSERT INTO `t_basis_city` VALUES ('906', '320300', '徐州市', '880');
INSERT INTO `t_basis_city` VALUES ('918', '320400', '常州市', '880');
INSERT INTO `t_basis_city` VALUES ('927', '320500', '苏州市', '880');
INSERT INTO `t_basis_city` VALUES ('939', '320600', '南通市', '880');
INSERT INTO `t_basis_city` VALUES ('949', '320700', '连云港市', '880');
INSERT INTO `t_basis_city` VALUES ('958', '320800', '淮安市', '880');
INSERT INTO `t_basis_city` VALUES ('968', '320900', '盐城市', '880');
INSERT INTO `t_basis_city` VALUES ('979', '321000', '扬州市', '880');
INSERT INTO `t_basis_city` VALUES ('987', '321100', '镇江市', '880');
INSERT INTO `t_basis_city` VALUES ('995', '321200', '泰州市', '880');
INSERT INTO `t_basis_city` VALUES ('1003', '321300', '宿迁市', '880');
INSERT INTO `t_basis_city` VALUES ('1010', '330000', '浙江省', '0');
INSERT INTO `t_basis_city` VALUES ('1011', '330100', '杭州市', '1010');
INSERT INTO `t_basis_city` VALUES ('1026', '330200', '宁波市', '1010');
INSERT INTO `t_basis_city` VALUES ('1039', '330300', '温州市', '1010');
INSERT INTO `t_basis_city` VALUES ('1052', '330400', '嘉兴市', '1010');
INSERT INTO `t_basis_city` VALUES ('1061', '330500', '湖州市', '1010');
INSERT INTO `t_basis_city` VALUES ('1068', '330600', '绍兴市', '1010');
INSERT INTO `t_basis_city` VALUES ('1076', '330700', '金华市', '1010');
INSERT INTO `t_basis_city` VALUES ('1087', '330800', '衢州市', '1010');
INSERT INTO `t_basis_city` VALUES ('1095', '330900', '舟山市', '1010');
INSERT INTO `t_basis_city` VALUES ('1101', '331000', '台州市', '1010');
INSERT INTO `t_basis_city` VALUES ('1112', '331100', '丽水市', '1010');
INSERT INTO `t_basis_city` VALUES ('1123', '340000', '安徽省', '0');
INSERT INTO `t_basis_city` VALUES ('1124', '340100', '合肥市', '1123');
INSERT INTO `t_basis_city` VALUES ('1135', '340200', '芜湖市', '1123');
INSERT INTO `t_basis_city` VALUES ('1145', '340300', '蚌埠市', '1123');
INSERT INTO `t_basis_city` VALUES ('1154', '340400', '淮南市', '1123');
INSERT INTO `t_basis_city` VALUES ('1162', '340500', '马鞍山市', '1123');
INSERT INTO `t_basis_city` VALUES ('1170', '340600', '淮北市', '1123');
INSERT INTO `t_basis_city` VALUES ('1176', '340700', '铜陵市', '1123');
INSERT INTO `t_basis_city` VALUES ('1182', '340800', '安庆市', '1123');
INSERT INTO `t_basis_city` VALUES ('1195', '341000', '黄山市', '1123');
INSERT INTO `t_basis_city` VALUES ('1204', '341100', '滁州市', '1123');
INSERT INTO `t_basis_city` VALUES ('1214', '341200', '阜阳市', '1123');
INSERT INTO `t_basis_city` VALUES ('1224', '341300', '宿州市', '1123');
INSERT INTO `t_basis_city` VALUES ('1231', '341500', '六安市', '1123');
INSERT INTO `t_basis_city` VALUES ('1240', '341600', '亳州市', '1123');
INSERT INTO `t_basis_city` VALUES ('1246', '341700', '池州市', '1123');
INSERT INTO `t_basis_city` VALUES ('1252', '341800', '宣城市', '1123');
INSERT INTO `t_basis_city` VALUES ('1261', '350000', '福建省', '0');
INSERT INTO `t_basis_city` VALUES ('1262', '350100', '福州市', '1261');
INSERT INTO `t_basis_city` VALUES ('1277', '350200', '厦门市', '1261');
INSERT INTO `t_basis_city` VALUES ('1285', '350300', '莆田市', '1261');
INSERT INTO `t_basis_city` VALUES ('1292', '350400', '三明市', '1261');
INSERT INTO `t_basis_city` VALUES ('1306', '350500', '泉州市', '1261');
INSERT INTO `t_basis_city` VALUES ('1320', '350600', '漳州市', '1261');
INSERT INTO `t_basis_city` VALUES ('1333', '350700', '南平市', '1261');
INSERT INTO `t_basis_city` VALUES ('1345', '350800', '龙岩市', '1261');
INSERT INTO `t_basis_city` VALUES ('1354', '350900', '宁德市', '1261');
INSERT INTO `t_basis_city` VALUES ('1365', '360000', '江西省', '0');
INSERT INTO `t_basis_city` VALUES ('1366', '360100', '南昌市', '1365');
INSERT INTO `t_basis_city` VALUES ('1377', '360200', '景德镇市', '1365');
INSERT INTO `t_basis_city` VALUES ('1383', '360300', '萍乡市', '1365');
INSERT INTO `t_basis_city` VALUES ('1390', '360400', '九江市', '1365');
INSERT INTO `t_basis_city` VALUES ('1404', '360500', '新余市', '1365');
INSERT INTO `t_basis_city` VALUES ('1408', '360600', '鹰潭市', '1365');
INSERT INTO `t_basis_city` VALUES ('1413', '360700', '赣州市', '1365');
INSERT INTO `t_basis_city` VALUES ('1433', '360800', '吉安市', '1365');
INSERT INTO `t_basis_city` VALUES ('1448', '360900', '宜春市', '1365');
INSERT INTO `t_basis_city` VALUES ('1460', '361000', '抚州市', '1365');
INSERT INTO `t_basis_city` VALUES ('1473', '361100', '上饶市', '1365');
INSERT INTO `t_basis_city` VALUES ('1487', '370000', '山东省', '0');
INSERT INTO `t_basis_city` VALUES ('1488', '370100', '济南市', '1487');
INSERT INTO `t_basis_city` VALUES ('1500', '370200', '青岛市', '1487');
INSERT INTO `t_basis_city` VALUES ('1514', '370300', '淄博市', '1487');
INSERT INTO `t_basis_city` VALUES ('1524', '370400', '枣庄市', '1487');
INSERT INTO `t_basis_city` VALUES ('1532', '370500', '东营市', '1487');
INSERT INTO `t_basis_city` VALUES ('1539', '370600', '烟台市', '1487');
INSERT INTO `t_basis_city` VALUES ('1553', '370700', '潍坊市', '1487');
INSERT INTO `t_basis_city` VALUES ('1567', '370800', '济宁市', '1487');
INSERT INTO `t_basis_city` VALUES ('1581', '370900', '泰安市', '1487');
INSERT INTO `t_basis_city` VALUES ('1589', '371000', '威海市', '1487');
INSERT INTO `t_basis_city` VALUES ('1595', '371100', '日照市', '1487');
INSERT INTO `t_basis_city` VALUES ('1601', '371200', '莱芜市', '1487');
INSERT INTO `t_basis_city` VALUES ('1605', '371300', '临沂市', '1487');
INSERT INTO `t_basis_city` VALUES ('1619', '371400', '德州市', '1487');
INSERT INTO `t_basis_city` VALUES ('1632', '371500', '聊城市', '1487');
INSERT INTO `t_basis_city` VALUES ('1642', '371600', '滨州市', '1487');
INSERT INTO `t_basis_city` VALUES ('1651', '371700', '菏泽市', '1487');
INSERT INTO `t_basis_city` VALUES ('1662', '410000', '河南省', '0');
INSERT INTO `t_basis_city` VALUES ('1663', '410100', '郑州市', '1662');
INSERT INTO `t_basis_city` VALUES ('1677', '410200', '开封市', '1662');
INSERT INTO `t_basis_city` VALUES ('1689', '410300', '洛阳市', '1662');
INSERT INTO `t_basis_city` VALUES ('1706', '410400', '平顶山市', '1662');
INSERT INTO `t_basis_city` VALUES ('1718', '410500', '安阳市', '1662');
INSERT INTO `t_basis_city` VALUES ('1729', '410600', '鹤壁市', '1662');
INSERT INTO `t_basis_city` VALUES ('1736', '410700', '新乡市', '1662');
INSERT INTO `t_basis_city` VALUES ('1750', '410800', '焦作市', '1662');
INSERT INTO `t_basis_city` VALUES ('1762', '410900', '濮阳市', '1662');
INSERT INTO `t_basis_city` VALUES ('1770', '411000', '许昌市', '1662');
INSERT INTO `t_basis_city` VALUES ('1778', '411100', '漯河市', '1662');
INSERT INTO `t_basis_city` VALUES ('1785', '411200', '三门峡市', '1662');
INSERT INTO `t_basis_city` VALUES ('1793', '411300', '南阳市', '1662');
INSERT INTO `t_basis_city` VALUES ('1808', '411400', '商丘市', '1662');
INSERT INTO `t_basis_city` VALUES ('1819', '411500', '信阳市', '1662');
INSERT INTO `t_basis_city` VALUES ('1831', '411600', '周口市', '1662');
INSERT INTO `t_basis_city` VALUES ('1843', '411700', '驻马店市', '1662');
INSERT INTO `t_basis_city` VALUES ('1856', '419001', '济源市', '1662');
INSERT INTO `t_basis_city` VALUES ('1857', '420000', '湖北省', '0');
INSERT INTO `t_basis_city` VALUES ('1858', '420100', '武汉市', '1857');
INSERT INTO `t_basis_city` VALUES ('1873', '420200', '黄石市', '1857');
INSERT INTO `t_basis_city` VALUES ('1881', '420300', '十堰市', '1857');
INSERT INTO `t_basis_city` VALUES ('1891', '420500', '宜昌市', '1857');
INSERT INTO `t_basis_city` VALUES ('1906', '420600', '襄阳市', '1857');
INSERT INTO `t_basis_city` VALUES ('1917', '420700', '鄂州市', '1857');
INSERT INTO `t_basis_city` VALUES ('1922', '420800', '荆门市', '1857');
INSERT INTO `t_basis_city` VALUES ('1929', '420900', '孝感市', '1857');
INSERT INTO `t_basis_city` VALUES ('1938', '421000', '荆州市', '1857');
INSERT INTO `t_basis_city` VALUES ('1948', '421100', '黄冈市', '1857');
INSERT INTO `t_basis_city` VALUES ('1960', '421200', '咸宁市', '1857');
INSERT INTO `t_basis_city` VALUES ('1968', '421300', '随州市', '1857');
INSERT INTO `t_basis_city` VALUES ('1972', '422800', '恩施土家族苗族自治州', '1857');
INSERT INTO `t_basis_city` VALUES ('1981', '429000', '省直辖县级行政单位', '1857');
INSERT INTO `t_basis_city` VALUES ('1982', '429004', '仙桃市', '1857');
INSERT INTO `t_basis_city` VALUES ('1983', '429005', '潜江市', '1857');
INSERT INTO `t_basis_city` VALUES ('1984', '429006', '天门市', '1857');
INSERT INTO `t_basis_city` VALUES ('1985', '429021', '神农架林区', '1857');
INSERT INTO `t_basis_city` VALUES ('1986', '430000', '湖南省', '0');
INSERT INTO `t_basis_city` VALUES ('1987', '430100', '长沙市', '1986');
INSERT INTO `t_basis_city` VALUES ('1998', '430200', '株洲市', '1986');
INSERT INTO `t_basis_city` VALUES ('2009', '430300', '湘潭市', '1986');
INSERT INTO `t_basis_city` VALUES ('2016', '430400', '衡阳市', '1986');
INSERT INTO `t_basis_city` VALUES ('2030', '430500', '邵阳市', '1986');
INSERT INTO `t_basis_city` VALUES ('2044', '430600', '岳阳市', '1986');
INSERT INTO `t_basis_city` VALUES ('2055', '430700', '常德市', '1986');
INSERT INTO `t_basis_city` VALUES ('2066', '430800', '张家界市', '1986');
INSERT INTO `t_basis_city` VALUES ('2072', '430900', '益阳市', '1986');
INSERT INTO `t_basis_city` VALUES ('2080', '431000', '郴州市', '1986');
INSERT INTO `t_basis_city` VALUES ('2093', '431100', '永州市', '1986');
INSERT INTO `t_basis_city` VALUES ('2106', '431200', '怀化市', '1986');
INSERT INTO `t_basis_city` VALUES ('2120', '431300', '娄底市', '1986');
INSERT INTO `t_basis_city` VALUES ('2127', '433100', '湘西土家族苗族自治州', '1986');
INSERT INTO `t_basis_city` VALUES ('2136', '440000', '广东省', '0');
INSERT INTO `t_basis_city` VALUES ('2137', '440100', '广州市', '2136');
INSERT INTO `t_basis_city` VALUES ('2151', '440200', '韶关市', '2136');
INSERT INTO `t_basis_city` VALUES ('2163', '440300', '深圳市', '2136');
INSERT INTO `t_basis_city` VALUES ('2171', '440400', '珠海市', '2163');
INSERT INTO `t_basis_city` VALUES ('2176', '440500', '汕头市', '2136');
INSERT INTO `t_basis_city` VALUES ('2185', '440600', '佛山市', '2136');
INSERT INTO `t_basis_city` VALUES ('2192', '440700', '江门市', '2136');
INSERT INTO `t_basis_city` VALUES ('2201', '440800', '湛江市', '2136');
INSERT INTO `t_basis_city` VALUES ('2212', '440900', '茂名市', '2136');
INSERT INTO `t_basis_city` VALUES ('2220', '441200', '肇庆市', '2136');
INSERT INTO `t_basis_city` VALUES ('2230', '441300', '惠州市', '2136');
INSERT INTO `t_basis_city` VALUES ('2237', '441400', '梅州市', '2136');
INSERT INTO `t_basis_city` VALUES ('2247', '441500', '汕尾市', '2136');
INSERT INTO `t_basis_city` VALUES ('2253', '441600', '河源市', '2136');
INSERT INTO `t_basis_city` VALUES ('2261', '441700', '阳江市', '2136');
INSERT INTO `t_basis_city` VALUES ('2267', '441800', '清远市', '2136');
INSERT INTO `t_basis_city` VALUES ('2277', '441900', '东莞市', '2136');
INSERT INTO `t_basis_city` VALUES ('2278', '442000', '中山市', '2136');
INSERT INTO `t_basis_city` VALUES ('2279', '445100', '潮州市', '2136');
INSERT INTO `t_basis_city` VALUES ('2284', '445200', '揭阳市', '2136');
INSERT INTO `t_basis_city` VALUES ('2291', '445300', '云浮市', '2136');
INSERT INTO `t_basis_city` VALUES ('2298', '450000', '广西壮族自治区', '0');
INSERT INTO `t_basis_city` VALUES ('2299', '450100', '南宁市', '2298');
INSERT INTO `t_basis_city` VALUES ('2313', '450200', '柳州市', '2298');
INSERT INTO `t_basis_city` VALUES ('2325', '450300', '桂林市', '2298');
INSERT INTO `t_basis_city` VALUES ('2344', '450400', '梧州市', '2298');
INSERT INTO `t_basis_city` VALUES ('2353', '450500', '北海市', '2298');
INSERT INTO `t_basis_city` VALUES ('2359', '450600', '防城港市', '2298');
INSERT INTO `t_basis_city` VALUES ('2365', '450700', '钦州市', '2298');
INSERT INTO `t_basis_city` VALUES ('2371', '450800', '贵港市', '2298');
INSERT INTO `t_basis_city` VALUES ('2378', '450900', '玉林市', '2298');
INSERT INTO `t_basis_city` VALUES ('2386', '451000', '百色市', '2298');
INSERT INTO `t_basis_city` VALUES ('2388', '451002', '右江区', '2386');
INSERT INTO `t_basis_city` VALUES ('2400', '451100', '贺州市', '2298');
INSERT INTO `t_basis_city` VALUES ('2406', '451200', '河池市', '2298');
INSERT INTO `t_basis_city` VALUES ('2419', '451300', '来宾市', '2298');
INSERT INTO `t_basis_city` VALUES ('2427', '451400', '崇左市', '2298');
INSERT INTO `t_basis_city` VALUES ('2436', '460000', '海南省', '0');
INSERT INTO `t_basis_city` VALUES ('2437', '460100', '海口市', '2436');
INSERT INTO `t_basis_city` VALUES ('2443', '460200', '三亚市', '2436');
INSERT INTO `t_basis_city` VALUES ('2445', '460300', '三沙市', '2436');
INSERT INTO `t_basis_city` VALUES ('2450', '469001', '五指山市', '2436');
INSERT INTO `t_basis_city` VALUES ('2451', '469002', '琼海市', '2436');
INSERT INTO `t_basis_city` VALUES ('2452', '469003', '儋州市', '2436');
INSERT INTO `t_basis_city` VALUES ('2453', '469005', '文昌市', '2436');
INSERT INTO `t_basis_city` VALUES ('2454', '469006', '万宁市', '2436');
INSERT INTO `t_basis_city` VALUES ('2455', '469007', '东方市', '2436');
INSERT INTO `t_basis_city` VALUES ('2456', '469021', '定安县', '2436');
INSERT INTO `t_basis_city` VALUES ('2457', '469022', '屯昌县', '2436');
INSERT INTO `t_basis_city` VALUES ('2458', '469023', '澄迈县', '2436');
INSERT INTO `t_basis_city` VALUES ('2459', '469024', '临高县', '2436');
INSERT INTO `t_basis_city` VALUES ('2460', '469025', '白沙黎族自治县', '2436');
INSERT INTO `t_basis_city` VALUES ('2461', '469026', '昌江黎族自治县', '2436');
INSERT INTO `t_basis_city` VALUES ('2462', '469027', '乐东黎族自治县', '2436');
INSERT INTO `t_basis_city` VALUES ('2463', '469028', '陵水黎族自治县', '2436');
INSERT INTO `t_basis_city` VALUES ('2464', '469029', '保亭黎族苗族自治县', '2436');
INSERT INTO `t_basis_city` VALUES ('2465', '469030', '琼中黎族苗族自治县', '2436');
INSERT INTO `t_basis_city` VALUES ('2466', '500000', '重庆市', '0');
INSERT INTO `t_basis_city` VALUES ('2468', '500101', '万州区', '2466');
INSERT INTO `t_basis_city` VALUES ('2469', '500102', '涪陵区', '2466');
INSERT INTO `t_basis_city` VALUES ('2470', '500103', '渝中区', '2466');
INSERT INTO `t_basis_city` VALUES ('2471', '500104', '大渡口区', '2466');
INSERT INTO `t_basis_city` VALUES ('2472', '500105', '江北区', '2466');
INSERT INTO `t_basis_city` VALUES ('2473', '500106', '沙坪坝区', '2466');
INSERT INTO `t_basis_city` VALUES ('2474', '500107', '九龙坡区', '2466');
INSERT INTO `t_basis_city` VALUES ('2475', '500108', '南岸区', '2466');
INSERT INTO `t_basis_city` VALUES ('2476', '500109', '北碚区', '2466');
INSERT INTO `t_basis_city` VALUES ('2477', '500110', '綦江区', '2466');
INSERT INTO `t_basis_city` VALUES ('2478', '500111', '大足区', '2466');
INSERT INTO `t_basis_city` VALUES ('2479', '500112', '渝北区', '2466');
INSERT INTO `t_basis_city` VALUES ('2480', '500113', '巴南区', '2466');
INSERT INTO `t_basis_city` VALUES ('2481', '500114', '黔江区', '2466');
INSERT INTO `t_basis_city` VALUES ('2482', '500115', '长寿区', '2466');
INSERT INTO `t_basis_city` VALUES ('2483', '500116', '江津区', '2466');
INSERT INTO `t_basis_city` VALUES ('2484', '500117', '合川区', '2466');
INSERT INTO `t_basis_city` VALUES ('2485', '500118', '永川区', '2466');
INSERT INTO `t_basis_city` VALUES ('2486', '500119', '南川区', '2466');
INSERT INTO `t_basis_city` VALUES ('2488', '500223', '潼南县', '2466');
INSERT INTO `t_basis_city` VALUES ('2489', '500224', '铜梁县', '2466');
INSERT INTO `t_basis_city` VALUES ('2490', '500226', '荣昌县', '2466');
INSERT INTO `t_basis_city` VALUES ('2491', '500227', '璧山县', '2466');
INSERT INTO `t_basis_city` VALUES ('2492', '500228', '梁平县', '2466');
INSERT INTO `t_basis_city` VALUES ('2493', '500229', '城口县', '2466');
INSERT INTO `t_basis_city` VALUES ('2494', '500230', '丰都县', '2466');
INSERT INTO `t_basis_city` VALUES ('2495', '500231', '垫江县', '2466');
INSERT INTO `t_basis_city` VALUES ('2496', '500232', '武隆县', '2466');
INSERT INTO `t_basis_city` VALUES ('2497', '500233', '忠县', '2466');
INSERT INTO `t_basis_city` VALUES ('2498', '500234', '开县', '2466');
INSERT INTO `t_basis_city` VALUES ('2499', '500235', '云阳县', '2466');
INSERT INTO `t_basis_city` VALUES ('2500', '500236', '奉节县', '2466');
INSERT INTO `t_basis_city` VALUES ('2501', '500237', '巫山县', '2466');
INSERT INTO `t_basis_city` VALUES ('2502', '500238', '巫溪县', '2466');
INSERT INTO `t_basis_city` VALUES ('2503', '500240', '石柱土家族自治县', '2466');
INSERT INTO `t_basis_city` VALUES ('2504', '500241', '秀山土家族苗族自治县', '2466');
INSERT INTO `t_basis_city` VALUES ('2505', '500242', '酉阳土家族苗族自治县', '2466');
INSERT INTO `t_basis_city` VALUES ('2506', '500243', '彭水苗族土家族自治县', '2466');
INSERT INTO `t_basis_city` VALUES ('2507', '510000', '四川省', '0');
INSERT INTO `t_basis_city` VALUES ('2508', '510100', '成都市', '2507');
INSERT INTO `t_basis_city` VALUES ('2529', '510300', '自贡市', '2507');
INSERT INTO `t_basis_city` VALUES ('2537', '510400', '攀枝花市', '2507');
INSERT INTO `t_basis_city` VALUES ('2544', '510500', '泸州市', '2507');
INSERT INTO `t_basis_city` VALUES ('2553', '510600', '德阳市', '2507');
INSERT INTO `t_basis_city` VALUES ('2561', '510700', '绵阳市', '2507');
INSERT INTO `t_basis_city` VALUES ('2572', '510800', '广元市', '2507');
INSERT INTO `t_basis_city` VALUES ('2581', '510900', '遂宁市', '2507');
INSERT INTO `t_basis_city` VALUES ('2588', '511000', '内江市', '2507');
INSERT INTO `t_basis_city` VALUES ('2595', '511100', '乐山市', '2507');
INSERT INTO `t_basis_city` VALUES ('2608', '511300', '南充市', '2507');
INSERT INTO `t_basis_city` VALUES ('2619', '511400', '眉山市', '2507');
INSERT INTO `t_basis_city` VALUES ('2627', '511500', '宜宾市', '2507');
INSERT INTO `t_basis_city` VALUES ('2639', '511600', '广安市', '2507');
INSERT INTO `t_basis_city` VALUES ('2646', '511700', '达州市', '2507');
INSERT INTO `t_basis_city` VALUES ('2655', '511800', '雅安市', '2507');
INSERT INTO `t_basis_city` VALUES ('2665', '511900', '巴中市', '2507');
INSERT INTO `t_basis_city` VALUES ('2671', '512000', '资阳市', '2507');
INSERT INTO `t_basis_city` VALUES ('2677', '513200', '阿坝藏族羌族自治州', '2507');
INSERT INTO `t_basis_city` VALUES ('2691', '513300', '甘孜藏族自治州', '2507');
INSERT INTO `t_basis_city` VALUES ('2710', '513400', '凉山彝族自治州', '2507');
INSERT INTO `t_basis_city` VALUES ('2728', '520000', '贵州省', '0');
INSERT INTO `t_basis_city` VALUES ('2729', '520100', '贵阳市', '2728');
INSERT INTO `t_basis_city` VALUES ('2741', '520200', '六盘水市', '2728');
INSERT INTO `t_basis_city` VALUES ('2746', '520300', '遵义市', '2728');
INSERT INTO `t_basis_city` VALUES ('2762', '520400', '安顺市', '2728');
INSERT INTO `t_basis_city` VALUES ('2770', '520500', '毕节市', '2728');
INSERT INTO `t_basis_city` VALUES ('2779', '520600', '铜仁市', '2728');
INSERT INTO `t_basis_city` VALUES ('2790', '522300', '黔西南布依族苗族自治州', '2728');
INSERT INTO `t_basis_city` VALUES ('2799', '522600', '黔东南苗族侗族自治州', '2728');
INSERT INTO `t_basis_city` VALUES ('2816', '522700', '黔南布依族苗族自治州', '2728');
INSERT INTO `t_basis_city` VALUES ('2829', '530000', '云南省', '0');
INSERT INTO `t_basis_city` VALUES ('2830', '530100', '昆明市', '2829');
INSERT INTO `t_basis_city` VALUES ('2846', '530300', '曲靖市', '2829');
INSERT INTO `t_basis_city` VALUES ('2857', '530400', '玉溪市', '2829');
INSERT INTO `t_basis_city` VALUES ('2867', '530500', '保山市', '2829');
INSERT INTO `t_basis_city` VALUES ('2874', '530600', '昭通市', '2829');
INSERT INTO `t_basis_city` VALUES ('2887', '530700', '丽江市', '2829');
INSERT INTO `t_basis_city` VALUES ('2894', '530800', '普洱市', '2829');
INSERT INTO `t_basis_city` VALUES ('2906', '530900', '临沧市', '2829');
INSERT INTO `t_basis_city` VALUES ('2916', '532300', '楚雄彝族自治州', '2829');
INSERT INTO `t_basis_city` VALUES ('2927', '532500', '红河哈尼族彝族自治州', '2829');
INSERT INTO `t_basis_city` VALUES ('2941', '532600', '文山壮族苗族自治州', '2829');
INSERT INTO `t_basis_city` VALUES ('2950', '532800', '西双版纳傣族自治州', '2829');
INSERT INTO `t_basis_city` VALUES ('2954', '532900', '大理白族自治州', '2829');
INSERT INTO `t_basis_city` VALUES ('2967', '533100', '德宏傣族景颇族自治州', '2829');
INSERT INTO `t_basis_city` VALUES ('2973', '533300', '怒江傈僳族自治州', '2829');
INSERT INTO `t_basis_city` VALUES ('2978', '533400', '迪庆藏族自治州', '2829');
INSERT INTO `t_basis_city` VALUES ('2982', '540000', '西藏自治区', '0');
INSERT INTO `t_basis_city` VALUES ('2983', '540100', '拉萨市', '2982');
INSERT INTO `t_basis_city` VALUES ('2993', '542100', '昌都地区', '2982');
INSERT INTO `t_basis_city` VALUES ('3005', '542200', '山南地区', '2982');
INSERT INTO `t_basis_city` VALUES ('3018', '542300', '日喀则地区', '2982');
INSERT INTO `t_basis_city` VALUES ('3037', '542400', '那曲地区', '2982');
INSERT INTO `t_basis_city` VALUES ('3048', '542500', '阿里地区', '2982');
INSERT INTO `t_basis_city` VALUES ('3056', '542600', '林芝地区', '2982');
INSERT INTO `t_basis_city` VALUES ('3064', '610000', '陕西省', '0');
INSERT INTO `t_basis_city` VALUES ('3065', '610100', '西安市', '3064');
INSERT INTO `t_basis_city` VALUES ('3080', '610200', '铜川市', '3064');
INSERT INTO `t_basis_city` VALUES ('3086', '610300', '宝鸡市', '3064');
INSERT INTO `t_basis_city` VALUES ('3100', '610400', '咸阳市', '3064');
INSERT INTO `t_basis_city` VALUES ('3116', '610500', '渭南市', '3064');
INSERT INTO `t_basis_city` VALUES ('3129', '610600', '延安市', '3064');
INSERT INTO `t_basis_city` VALUES ('3144', '610700', '汉中市', '3064');
INSERT INTO `t_basis_city` VALUES ('3157', '610800', '榆林市', '3064');
INSERT INTO `t_basis_city` VALUES ('3171', '610900', '安康市', '3064');
INSERT INTO `t_basis_city` VALUES ('3183', '611000', '商洛市', '3064');
INSERT INTO `t_basis_city` VALUES ('3192', '620000', '甘肃省', '0');
INSERT INTO `t_basis_city` VALUES ('3193', '620100', '兰州市', '3192');
INSERT INTO `t_basis_city` VALUES ('3203', '620200', '嘉峪关市', '3192');
INSERT INTO `t_basis_city` VALUES ('3205', '620300', '金昌市', '3203');
INSERT INTO `t_basis_city` VALUES ('3209', '620400', '白银市', '3192');
INSERT INTO `t_basis_city` VALUES ('3216', '620500', '天水市', '3192');
INSERT INTO `t_basis_city` VALUES ('3225', '620600', '武威市', '3192');
INSERT INTO `t_basis_city` VALUES ('3231', '620700', '张掖市', '3192');
INSERT INTO `t_basis_city` VALUES ('3239', '620800', '平凉市', '3192');
INSERT INTO `t_basis_city` VALUES ('3248', '620900', '酒泉市', '3192');
INSERT INTO `t_basis_city` VALUES ('3257', '621000', '庆阳市', '3192');
INSERT INTO `t_basis_city` VALUES ('3259', '621002', '西峰区', '3257');
INSERT INTO `t_basis_city` VALUES ('3267', '621100', '定西市', '3192');
INSERT INTO `t_basis_city` VALUES ('3276', '621200', '陇南市', '3192');
INSERT INTO `t_basis_city` VALUES ('3287', '622900', '临夏回族自治州', '3192');
INSERT INTO `t_basis_city` VALUES ('3296', '623000', '甘南藏族自治州', '3192');
INSERT INTO `t_basis_city` VALUES ('3305', '630000', '青海省', '0');
INSERT INTO `t_basis_city` VALUES ('3306', '630100', '西宁市', '3305');
INSERT INTO `t_basis_city` VALUES ('3315', '632100', '海东地区', '3305');
INSERT INTO `t_basis_city` VALUES ('3322', '632200', '海北藏族自治州', '3305');
INSERT INTO `t_basis_city` VALUES ('3327', '632300', '黄南藏族自治州', '3305');
INSERT INTO `t_basis_city` VALUES ('3332', '632500', '海南藏族自治州', '3305');
INSERT INTO `t_basis_city` VALUES ('3338', '632600', '果洛藏族自治州', '3305');
INSERT INTO `t_basis_city` VALUES ('3345', '632700', '玉树藏族自治州', '3305');
INSERT INTO `t_basis_city` VALUES ('3352', '632800', '海西蒙古族藏族自治州', '3305');
INSERT INTO `t_basis_city` VALUES ('3358', '640000', '宁夏回族自治区', '0');
INSERT INTO `t_basis_city` VALUES ('3359', '640100', '银川市', '3358');
INSERT INTO `t_basis_city` VALUES ('3367', '640200', '石嘴山市', '3358');
INSERT INTO `t_basis_city` VALUES ('3372', '640300', '吴忠市', '3358');
INSERT INTO `t_basis_city` VALUES ('3379', '640400', '固原市', '3358');
INSERT INTO `t_basis_city` VALUES ('3386', '640500', '中卫市', '3358');
INSERT INTO `t_basis_city` VALUES ('3391', '650000', '新疆维吾尔自治区', '0');
INSERT INTO `t_basis_city` VALUES ('3392', '650100', '乌鲁木齐市', '3391');
INSERT INTO `t_basis_city` VALUES ('3402', '650200', '克拉玛依市', '3391');
INSERT INTO `t_basis_city` VALUES ('3408', '652100', '吐鲁番地区', '3391');
INSERT INTO `t_basis_city` VALUES ('3412', '652200', '哈密地区', '3391');
INSERT INTO `t_basis_city` VALUES ('3416', '652300', '昌吉回族自治州', '3391');
INSERT INTO `t_basis_city` VALUES ('3424', '652700', '博尔塔拉蒙古自治州', '3391');
INSERT INTO `t_basis_city` VALUES ('3428', '652800', '巴音郭楞蒙古自治州', '3391');
INSERT INTO `t_basis_city` VALUES ('3438', '652900', '阿克苏地区', '3391');
INSERT INTO `t_basis_city` VALUES ('3448', '653000', '克孜勒苏柯尔克孜自治州', '3391');
INSERT INTO `t_basis_city` VALUES ('3453', '653100', '喀什地区', '3391');
INSERT INTO `t_basis_city` VALUES ('3466', '653200', '和田地区', '3391');
INSERT INTO `t_basis_city` VALUES ('3475', '654000', '伊犁哈萨克自治州', '3391');
INSERT INTO `t_basis_city` VALUES ('3476', '654002', '伊宁市', '3391');
INSERT INTO `t_basis_city` VALUES ('3477', '654003', '奎屯市', '3391');
INSERT INTO `t_basis_city` VALUES ('3486', '654200', '塔城地区', '3391');
INSERT INTO `t_basis_city` VALUES ('3494', '654300', '阿勒泰地区', '3391');
INSERT INTO `t_basis_city` VALUES ('3503', '659001', '石河子市', '3391');
INSERT INTO `t_basis_city` VALUES ('3504', '659002', '阿拉尔市', '3391');
INSERT INTO `t_basis_city` VALUES ('3505', '659003', '图木舒克市', '3391');
INSERT INTO `t_basis_city` VALUES ('3506', '659004', '五家渠市', '3391');
INSERT INTO `t_basis_city` VALUES ('3507', '710000', '台湾省', '0');
INSERT INTO `t_basis_city` VALUES ('3508', '810000', '香港特别行政区', '0');
INSERT INTO `t_basis_city` VALUES ('3509', '820000', '澳门特别行政区', '0');

-- ----------------------------
-- Table structure for `t_book`
-- ----------------------------
DROP TABLE IF EXISTS `t_book`;
CREATE TABLE `t_book` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '书Id',
  `bookname` varchar(50) DEFAULT NULL COMMENT '书名',
  `authorId` bigint(20) DEFAULT NULL COMMENT '作者Id',
  `authorname` varchar(50) DEFAULT NULL COMMENT '作者',
  `content` varchar(300) DEFAULT NULL COMMENT '书简介',
  `pic` varchar(300) DEFAULT NULL COMMENT '图片',
  `bookurl` varchar(500) DEFAULT NULL COMMENT '书访问地址',
  `authorurl` varchar(500) DEFAULT NULL COMMENT '作者访问地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_book
-- ----------------------------
INSERT INTO `t_book` VALUES ('1', '肾病居家饮', '1', '洛艺嘉', '本书编者来自全国中医肾病重点专科---广东省中医院肾病科，他们具有丰富的临床的现了中医药在肾脏病治疗预防方面的特色及优势。', 'images/mittee1.jpg', 'http://localhost:8888/anjilang/dietican/articleContent.do?id=43', null);
INSERT INTO `t_book` VALUES ('2', '肾病居家饮食', '2', '绿巨人', '本书编者来自全国中医肾病重点专科---广东省中医院肾病科，他们具有丰富的临床的现了中医药在肾脏病治疗预防方面的特色及优势。', 'images/mittee1.jpg', 'http://localhost:8888/anjilang/dietican/articleContent.do?id=43', null);
INSERT INTO `t_book` VALUES ('3', '肾病居家饮食与调养', '3', '金刚', '本书编者来自全国中医肾病重点专科---广东省中医院肾病科，他们具有丰富的临床的现了中医药在肾脏病治疗预防方面的特色及优势。', 'images/mittee1.jpg', 'http://localhost:8888/anjilang/dietican/articleContent.do?id=43', null);

-- ----------------------------
-- Table structure for `t_comment`
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `content` varchar(300) DEFAULT NULL COMMENT '内容',
  `userId` bigint(11) DEFAULT NULL COMMENT '用户ID',
  `crTime` datetime DEFAULT NULL COMMENT '创建时间',
  `inforId` bigint(20) DEFAULT NULL COMMENT '评论的内容Id',
  `pic` varchar(300) DEFAULT NULL COMMENT '头像',
  `nickname` varchar(200) DEFAULT NULL COMMENT '用户昵称',
  `quoteId` bigint(20) DEFAULT NULL COMMENT '引用他人的评论',
  `isDelete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '指该内容是否被管理员删除\r\n0：否\r\n1：是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES ('1', '该食物是否含有不利于健康的有害因素。<br/>实际上，绝对安全无害的食物几乎是不存在的（也许只有母乳算一个），<br/>日常食物总是或多或少地含有一些不利于健康的因素。', '34', '2015-07-13 09:13:26', '43', 'images/comment1.jpg', 'freycea(重庆)', null, '0');
INSERT INTO `t_comment` VALUES ('2', '速七结局保罗和赛迪尔开着车相识一笑最终开往不同的两条岔路时', '38', '2015-07-15 09:15:39', '43', 'images/comment1.jpg', '张三(北京)', null, '0');
INSERT INTO `t_comment` VALUES ('3', '口感也是一个重要的因素，吃好吃可口的食物是人的正当权利。<br/>不过“好吃”是最缺少客观标准的，所谓众口难调是也，<br/>你觉得好吃的别人未必觉得好。', '52', '2015-07-12 09:15:51', '43', 'images/comment1.jpg', '李四(上海)', null, '0');
INSERT INTO `t_comment` VALUES ('4', '该食物的营养素含量或营养价值如何，尤其是与其他同类食物比较时，<br/>该食物所含营养素是否够丰富，是在平均水平之上，<br/>还是平均水平之下？', '54', '2015-07-07 09:16:18', '42', 'images/comment1.jpg', 'freycea(重庆)', null, '0');
INSERT INTO `t_comment` VALUES ('5', '该食物的营养素含量或营养价值如何，尤其是与其他同类食物比较时，<br/>该食物所含营养素是否够丰富，是在平均水平之上，<br/>还是平均水平之下？', '24', '2015-07-21 11:32:11', '43', 'images/comment1.jpg', 'freycea(重庆)', null, '0');
INSERT INTO `t_comment` VALUES ('6', '该食物的营养素含量或营养价值如何，尤其是与其他同类食物比较时，<br/>该食物所含营养素是否够丰富，是在平均水平之上，<br/>还是平均水平之下？', '54', '2015-07-22 11:32:15', '43', 'images/comment1.jpg', 'freycea(重庆)', null, '0');
INSERT INTO `t_comment` VALUES ('7', '口感也是一个重要的因素，吃好吃可口的食物是人的正当权利。不过“好吃”是最缺少客观标准的，所谓众口难调是也，你觉得好吃的别人未必觉得好。', '38', '2015-07-23 11:32:18', '42', 'images/comment1.jpg', '李四(上海)', null, '0');
INSERT INTO `t_comment` VALUES ('8', '该食物是否含有不利于健康的有害因素。实际上，绝对安全无害的食物几乎是不存在的（也许只有母乳算一个），日常食物总是或多或少地含有一些不利于健康的因素。', '34', '2015-07-23 11:32:20', '42', 'images/comment1.jpg', '张三(北京)', null, '0');
INSERT INTO `t_comment` VALUES ('9', '速七结局保罗和赛迪尔开着车相识一笑最终开往不同的两条岔路时', '34', '2015-07-13 11:32:23', '43', 'images/comment1.jpg', '张三(北京)', null, '0');
INSERT INTO `t_comment` VALUES ('40', '', '22', '2015-07-29 20:37:35', '27', 'image/defaultHead.png', '3184845147@qq.com', null, '0');
INSERT INTO `t_comment` VALUES ('41', '顶顶顶顶发嗯e', '22', '2015-07-29 20:37:48', '27', 'image/defaultHead.png', '3184845147@qq.com', null, '0');
INSERT INTO `t_comment` VALUES ('56', '顶顶顶顶发嗯e\n                ', '7', '2015-08-21 15:49:12', '27', 'upload/2015/08/03/e8f1b420-50c9-47b4-8a99-284ecfdd7e9f.png', 'ycycoo@qq.com', '41', '0');
INSERT INTO `t_comment` VALUES ('57', '该食物是否含有不利于健康的有害因素。实际上，绝对安全无害的食物几乎是不存在的（也许只有母乳算一个），日常食物总是或多或少地含有一些不利于健康的因素。', '7', '2015-08-21 16:28:09', '42', 'upload/2015/08/03/e8f1b420-50c9-47b4-8a99-284ecfdd7e9f.png', 'ycycoo@qq.com', '8', '1');

-- ----------------------------
-- Table structure for `t_comment_reply`
-- ----------------------------
DROP TABLE IF EXISTS `t_comment_reply`;
CREATE TABLE `t_comment_reply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` text,
  `parentId` bigint(20) DEFAULT NULL,
  `crTime` date DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `inforId` bigint(20) DEFAULT NULL,
  `nickname` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_comment_reply
-- ----------------------------
INSERT INTO `t_comment_reply` VALUES ('22', '睡都发送到发送到', '9', '2015-07-29', '22', '43', '3184845147@qq.com');
INSERT INTO `t_comment_reply` VALUES ('23', '撒范德萨啊', '9', '2015-07-29', '22', '43', '3184845147@qq.com');
INSERT INTO `t_comment_reply` VALUES ('24', '', '9', '2015-07-29', '22', '43', '3184845147@qq.com');
INSERT INTO `t_comment_reply` VALUES ('25', '顶', '41', '2015-07-29', '22', '27', '3184845147@qq.com');
INSERT INTO `t_comment_reply` VALUES ('26', '顶', '40', '2015-07-30', '7', '27', 'ycycoo@qq.com');
INSERT INTO `t_comment_reply` VALUES ('27', 'uuuu', '40', '2015-08-21', '7', '27', 'ycycoo@qq.com');
INSERT INTO `t_comment_reply` VALUES ('28', 'hhhhhhhhh', '41', '2015-08-21', '7', '27', 'ycycoo@qq.com');

-- ----------------------------
-- Table structure for `t_disease_project`
-- ----------------------------
DROP TABLE IF EXISTS `t_disease_project`;
CREATE TABLE `t_disease_project` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `disease_name` varchar(255) DEFAULT NULL COMMENT '疾病名称',
  `update_time` datetime DEFAULT NULL COMMENT '更新日期',
  `picUrl` varchar(200) DEFAULT NULL COMMENT '图片地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_disease_project
-- ----------------------------
INSERT INTO `t_disease_project` VALUES ('1', '2015-01-01 20:54:06', '肾病', '2015-01-01 20:54:03', 'upload/disease/2015/01/30/693dc560-49d9-4687-a1db-dea30da2c71c.png');
INSERT INTO `t_disease_project` VALUES ('4', '2015-01-01 21:17:26', '糖尿病', '2015-01-01 21:17:22', 'upload/disease/2015/01/30/d1a20056-40cd-46b3-981b-2692e2810385.png');
INSERT INTO `t_disease_project` VALUES ('5', '2015-01-01 21:18:40', '老年病', '2015-01-01 21:18:37', 'upload/disease/2015/01/30/05c74d20-c64b-450d-9175-10ca9e829ad4.png');

-- ----------------------------
-- Table structure for `t_doctor_type`
-- ----------------------------
DROP TABLE IF EXISTS `t_doctor_type`;
CREATE TABLE `t_doctor_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '医生类型名称（如xxx营养师）',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_doctor_type
-- ----------------------------
INSERT INTO `t_doctor_type` VALUES ('1', '临床营养师', '2015-01-10 16:34:34');
INSERT INTO `t_doctor_type` VALUES ('2', '公共营养师', '2015-01-12 00:40:09');

-- ----------------------------
-- Table structure for `t_friendlink`
-- ----------------------------
DROP TABLE IF EXISTS `t_friendlink`;
CREATE TABLE `t_friendlink` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(100) NOT NULL COMMENT '标题',
  `url` varchar(100) NOT NULL COMMENT 'url地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_friendlink
-- ----------------------------
INSERT INTO `t_friendlink` VALUES ('3', '苏州恒润达', 'http://www.hrdimp.com/');
INSERT INTO `t_friendlink` VALUES ('4', 'Healthy Food株式会社', 'http://www.healthy-food.co.jp/');
INSERT INTO `t_friendlink` VALUES ('5', '百度', 'www.baidu.com');

-- ----------------------------
-- Table structure for `t_group_message`
-- ----------------------------
DROP TABLE IF EXISTS `t_group_message`;
CREATE TABLE `t_group_message` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '小组id',
  `groupid` int(10) DEFAULT NULL COMMENT '用户id',
  `content` varchar(255) DEFAULT NULL COMMENT '信息内容',
  `adminid` int(10) DEFAULT NULL COMMENT '管理员id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_group_message
-- ----------------------------
INSERT INTO `t_group_message` VALUES ('1', '18', '<p>群发消息</p>\r\n', '7');
INSERT INTO `t_group_message` VALUES ('2', '18', '<p>群发消息</p>\r\n', '7');
INSERT INTO `t_group_message` VALUES ('3', '18', '<p>再向所有人发送消息</p>\r\n', '7');
INSERT INTO `t_group_message` VALUES ('4', '18', '<p>群发一条消息</p>\r\n', '7');

-- ----------------------------
-- Table structure for `t_group_tab`
-- ----------------------------
DROP TABLE IF EXISTS `t_group_tab`;
CREATE TABLE `t_group_tab` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'tabid',
  `tab_name` varchar(10) DEFAULT NULL COMMENT 'tab名称',
  `groupid` int(10) DEFAULT NULL COMMENT '小组id',
  `cancel` tinyint(1) DEFAULT NULL COMMENT '是否注销',
  `userid` int(10) DEFAULT NULL COMMENT '管理员id',
  `sortorder` tinyint(2) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_group_tab
-- ----------------------------
INSERT INTO `t_group_tab` VALUES ('1', '最新资讯', '18', '0', '7', '1');
INSERT INTO `t_group_tab` VALUES ('2', '有问有答', '18', '0', '7', '2');
INSERT INTO `t_group_tab` VALUES ('3', '最新资讯', '20', '0', '3', '1');
INSERT INTO `t_group_tab` VALUES ('4', '热门话题', '18', '1', '7', '3');
INSERT INTO `t_group_tab` VALUES ('5', '有问有答', '18', '1', '7', '2');
INSERT INTO `t_group_tab` VALUES ('6', '热门话题', '18', '1', '7', '3');
INSERT INTO `t_group_tab` VALUES ('7', '最新资讯', '23', '0', '7', '2');
INSERT INTO `t_group_tab` VALUES ('8', '热门话题', '23', '0', '7', '1');
INSERT INTO `t_group_tab` VALUES ('9', '热门话题', '23', '1', '7', '1');
INSERT INTO `t_group_tab` VALUES ('10', '和呵呵呵呵', '23', '1', '7', '3');

-- ----------------------------
-- Table structure for `t_group_topic`
-- ----------------------------
DROP TABLE IF EXISTS `t_group_topic`;
CREATE TABLE `t_group_topic` (
  `articlepic` varchar(255) DEFAULT NULL,
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '帖子id',
  `title` varchar(50) DEFAULT NULL COMMENT '主题标题',
  `cancel` tinyint(1) DEFAULT NULL COMMENT '是否删除',
  `groupid` int(10) DEFAULT NULL COMMENT '小组id',
  `tabid` int(10) DEFAULT NULL COMMENT 'tabid',
  `content` text COMMENT '内容',
  `rep` int(5) DEFAULT NULL COMMENT '回复的次数',
  `hit` int(5) DEFAULT '0' COMMENT '点击的次数',
  `createtime` timestamp NULL DEFAULT NULL COMMENT '发布时间',
  `createrid` int(10) DEFAULT NULL COMMENT '发布者',
  `sign` tinyint(4) DEFAULT NULL COMMENT '推荐话题',
  `elitetopic` tinyint(4) DEFAULT NULL COMMENT '精华帖',
  `topictop` int(5) DEFAULT NULL COMMENT '置顶',
  `recommended` int(10) DEFAULT NULL COMMENT '推荐id',
  `rectime` timestamp NULL DEFAULT NULL COMMENT '推荐时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_group_topic
-- ----------------------------
INSERT INTO `t_group_topic` VALUES (null, '1', '为什么啊', '0', '18', null, '<p>为什么就是不行啊</p>\r\n', null, '175', '2015-07-29 10:23:23', '7', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '2', '再发一条', '0', '18', null, '<p>再试试吧</p>\r\n', null, '14', '2015-07-30 10:31:43', '7', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '3', '改完用户之后的测试', '0', '18', '1', '<p>希望能够成功吧</p>\r\n', null, '0', '2015-07-30 20:01:07', '7', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '4', '先试试', '0', '18', '2', '<p>看看能不能获取到值</p>\r\n', null, '1', '2015-08-01 17:50:44', '7', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '5', '再试一次', '0', '18', '2', '<p>希望还能成功</p>\r\n', null, '0', '2015-08-01 17:56:34', '7', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '6', '修改页面后测试', '0', '18', '1', '<p>修改页面后的测试</p>\r\n', null, '0', '2015-08-01 18:29:11', '3', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '7', '不是成员发布一次', '0', '18', '1', '<p>刚才忘记测试了</p>\r\n', null, '0', '2015-08-01 18:33:15', '63', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '8', '刚才为什么能成功啊', '0', '18', '1', '<p>很奇怪啊</p>\r\n', null, '0', '2015-08-01 18:43:59', '63', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '9', '再试一次', '0', '18', '1', '<p>很奇怪啊</p>\r\n', null, '0', '2015-08-01 18:49:38', '63', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '10', '太奇怪了', '0', '18', '1', '<p>试试</p>\r\n', null, '0', '2015-08-01 18:51:26', '63', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '11', '任天堂', '0', '18', '1', '<p>对他的头</p>\r\n', null, '0', '2015-08-01 18:52:55', '63', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '12', '人的肉体', '0', '18', '1', '<p>热</p>\r\n', null, '2', '2015-08-01 18:54:05', '63', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '13', 'rger', '1', '18', '1', '<p>etefd</p>\r\n', null, '0', '2015-08-01 18:55:19', '63', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '14', 'xiexie', '1', '18', '1', '<p>jsflkp</p>\r\n', null, '28', '2015-08-02 13:26:32', '63', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '15', '发布新闻', '0', '23', null, '<p>就是测试用的</p>\r\n', null, '0', '2015-08-04 10:55:31', '7', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '16', '发布文章', '0', '23', '7', '<p>不是会员进行测试</p>\r\n', null, '0', '2015-08-04 10:56:23', '10', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '17', '发布文章', '0', '23', '7', '<p>就是测试用的</p>\r\n', null, '0', '2015-08-04 10:59:07', '10', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '18', '发布文章', '0', '23', '7', '<p>就是测试用的</p>\r\n', null, '0', '2015-08-04 11:02:49', '10', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '19', '发布文章', '0', '23', '7', '<p>发布文章</p>\r\n', null, '0', '2015-08-04 11:15:24', '7', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '20', '发布文章', '0', '23', '7', '<p>发布文章</p>\r\n', null, '0', '2015-08-04 11:16:04', '10', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '21', '发布文章', '0', '23', '7', '<p>发布文章</p>\r\n', null, '0', '2015-08-04 11:19:36', '10', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '22', '发布文章', '0', '23', '7', '<p>发布文章</p>\r\n', null, '0', '2015-08-04 11:20:44', '10', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '23', '发布文章', '0', '23', '7', '<p>发布文章</p>\r\n', null, '0', '2015-08-04 11:21:02', '10', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '24', '发布文章', '0', '23', '8', '<p>发布文章</p>\r\n', null, '0', '2015-08-04 11:21:24', '10', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '25', '发布文章', '0', '23', '8', '<p>发布文章</p>\r\n', null, '0', '2015-08-04 11:35:18', '7', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '26', '发布文章', '0', '23', '8', '<p>发布文章</p>\r\n', null, '0', '2015-08-04 11:35:51', '10', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '27', '发布文章', '0', '23', '8', '<p>发布文章</p>\r\n', null, '13', '2015-08-04 11:39:15', '10', null, null, '0', '3', '2015-08-13 19:42:54');
INSERT INTO `t_group_topic` VALUES (null, '28', '发布新闻', '0', '23', '8', '<p>发布新闻</p>\r\n', null, '0', '2015-08-04 11:40:44', '10', null, null, '0', '3', '2015-08-13 19:42:52');
INSERT INTO `t_group_topic` VALUES (null, '29', '发布文章', '0', '23', '8', '<p>发布文章</p>\r\n', null, '0', '2015-08-04 11:45:28', '10', null, null, '0', '3', '2015-08-13 19:42:50');
INSERT INTO `t_group_topic` VALUES (null, '30', '发布文章', '0', '20', '3', '<p>发布文章</p>\r\n', null, '0', '2015-08-04 11:46:19', '10', null, null, '0', '3', '2015-08-13 19:42:47');
INSERT INTO `t_group_topic` VALUES (null, '31', '发布文章', '0', '23', '8', '<p>发布文章</p>\r\n', null, '1', '2015-08-04 11:48:00', '7', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '32', '发布文章', '0', '23', '8', '<p>发布文章</p>\r\n', null, '12', '2015-08-04 11:49:01', '10', null, null, '6', null, null);
INSERT INTO `t_group_topic` VALUES (null, '33', '针对肾病患者日常饮食的注意事项，作为一名患者，我是这样安排的！', '0', '23', '8', '<p>尽管放消息说有速8，但一大部分观众已经兴趣了然，没有了Paul Walker，整个Furious团队已经不再完整，至少在我心中，从<br />\r\n2001年的第一部到今年为止的Furious 7，已经算划上了一个无论在现实中还是在银幕中的句号。<br />\r\n作为尤其关注电影中地点的考据患者，这种系列商业大片，基本上都有各国旅游风光宣传片的作用，除了强迫症作祟，喜欢数出<br />\r\n现了多少辆车，剧组炸毁了多少辆车，就是特别喜欢历数取景地了，简直乐趣无穷。</p>\r\n\r\n<p><img src=\"images/plain_sf.jpg\" style=\"height:337px; margin:10px 0px 16px; width:787px\" /></p>\r\n\r\n<p>上映时间：2001年</p>\r\n\r\n<p>取景点：16个</p>\r\n\r\n<p>主要城市：洛杉矶</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>除了空军基地和位于加州的摄影棚这种游客基本上进不去的地方，以下这些地点你或许会感兴趣，当你路过的时候，一幕幕的<br />\r\n追车戏码从脑海浮现的感觉应该很带感。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>【洛杉矶回声公园 Echo Park】<br />\r\n这个还真是一个很多旅行攻略都不会费力推荐的地方，Toretto Market &amp; Misc的取景地，《速度与激情》第6部又重回这里取<br />\r\n过景，去年奥斯卡失利但实际上绝对有资格入围的影片《夜行者》（Nightcrawler）也在这里拍摄过。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>加州太平洋海岸公路 Pacific Coast Highway】<br />\r\n车作为第二主角的电影，怎能不出现一条绝美的公路呢！！！速1中的名场面（哈哈哈）&mdash;&mdash;与法拉利赛车的戏就是在这儿拍<br />\r\n的，话说速度与激情系列一直以来有点看不上欧洲车的节奏。</p>\r\n', '26', '260', '2015-08-04 16:24:18', '3', null, null, '3', '2', '2015-08-13 15:21:11');
INSERT INTO `t_group_topic` VALUES (null, '34', '请在这里输入标题', '0', '23', '7', '', '0', '0', '2015-08-06 15:30:35', '3', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '35', '请在这里输入标题', '0', '23', '7', '', '0', '13', '2015-08-06 15:31:46', '3', null, null, '8', '4', '2015-08-17 17:46:21');
INSERT INTO `t_group_topic` VALUES (null, '36', 'tttt', '0', '23', '7', '', '0', '0', '2015-08-06 15:32:37', '3', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES (null, '38', '抗肿瘤药物分类', '0', '23', '8', '<p><img alt=\"\" src=\"http://localhost:8080/anjilang/upload/ckeditor/2015/08/06/b04bacc9-8ef1-402d-a016-6cc9782a9df4.png\" style=\"height:169px; width:312px\" /></p>\r\n\r\n<p>传统的分类是根据抗肿瘤药物的来源及其药物的作用机制进行分类，分为烷化剂、抗代谢类、抗肿瘤抗生素、植物类、杂类、激素平衡类药物等六大类。根据抗肿瘤药物对细胞增殖周期中DNA合成前期（G1期）、DNA合成期 (S期)、 DNA合成后期 (G2期)、有丝分裂期 (M期)各时相的作用靶点不同，又分为细胞周期特异性药物和细胞周期非特异性药物二大类。<br />\r\n1.细胞周期特异性药物，作用特点只限于细胞增殖周期的某一个时相，在一定的时间内发挥其杀伤作用。使用时宜缓慢或持续静脉注射、肌肉注射、口服等会发挥更大作用。主要包括抗代谢类及植物类药物，如作用于G1期的药物门冬酰胺酶等。作用于S期的药物氟脲嘧啶、甲氨喋呤等。作用于G2期的药物平阳霉素、亚硝脲类等。作用于M期的药物长春碱类、紫杉类、喜树碱类等。<br />\r\n2.细胞周期非特异性药物，无选择的直接作用于细胞增殖周期的各个时相，作用较强，可迅速杀伤肿瘤细胞，其剂量与疗效呈正相关，以一次静脉注射为宜。此类药物包括烷化剂、铂类及抗肿瘤抗生素类等，如氮芥、环磷酰胺、美法仑、顺铂、卡铂、奥沙利铂、多柔比星、放线菌素-D、卡氮芥等。开封市中心医院肿瘤科高欣</p>\r\n\r\n<p>随着对抗肿瘤药物研究的深入，进一步认识了药物在分子水平的作用机制，目前将临床药物进行如下分类：</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>一、细胞毒类药：</strong></p>\r\n\r\n<p>1.作用于DNA化学结构的药物：（1）烷化剂 如氮芥(HN2)、 环磷酰胺(CTX) 等。可使细胞中的亲核集团发生烷化反应，致DNA在复制中发生核碱基错误配对，引起密码解释错乱。同时双功能基的烷化剂常与DNA双链上各一鸟嘌呤结合，形成交叉联结，防碍DNA复制，也可使染色体断裂。DNA结构功能的破坏可导致细胞的分裂、增殖停止或死亡。但也有少数受损细胞的DNA经修复而活下来，造成耐药的出现。（2）铂类化合物 如顺氯氨铂(DDP) 、奥沙利铂(OXA) 等。可与DNA结合，进而破坏其结构与功能。（3）蒽环类药物 如多柔比星(ADM)、 吡柔比星（THP）等。可嵌入DNA碱基对之间，干扰转录过程，阻止mRNA的形成。（4）破坏DNA的抗生素　如丝裂霉素（MMC）、 博来霉素(BLM) 等。可使DNA单链断裂，阻止DNA的合成。<br />\r\n2.作用于核酸转录的抗生素药物&nbsp; 如放线菌素-D(ACD) 、阿柔比星(ACLA) 等。由微生物所产生的非特异性抗肿瘤药，可对细胞周期各时相产生杀灭作用。<br />\r\n3.影响核酸生物合成的抗代谢药物，为细胞周期特异性药，分别在不同环节阻止DNA合成，抑制细胞的分裂与增殖。根据其干扰的生化过程不同分为(1) 二氢叶酸还原酶抑制剂如甲氨蝶呤（MTX）。(2) 胸苷酸合成酶抑制剂如氟脲嘧啶(5-FU) 。(3) 核苷酸还原酶抑制剂如羟基脲(HU)。(4)DNA多聚酶抑制剂如阿糖胞苷（Ara-C）。(5) 嘌呤核苷酸互变抑制剂如巯嘌呤(6-MP)。<br />\r\n4.影响蛋白质合成，干扰有丝分裂的植物类药 (1)长春新碱(VCR) 、紫杉醇(TAX) 等。影响微管蛋白装配，干扰有丝分裂中纺锤体的形成，使增殖细胞停止在分裂中期。(2) 高三尖杉酯碱，干扰核蛋白体功能，阻止蛋白质合成。(3) 门冬酰胺酶，可降解血液中的门冬酰胺酶，使细胞缺乏此氨基酸，影响氨基酸供应，阻止蛋白质合成。<br />\r\n5.拓扑异构酶抑制药物 包括拓扑异构酶I抑制剂如伊立替康(CPT-11)和拓扑异构酶II抑制剂如依托泊苷(VP-16) 。可直接抑制拓扑异构酶，阻止DNA的复制和RNA的合成。<br />\r\n6.其他细胞毒类药物如维甲酸、硼替佐米等。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>二、影响内分泌平衡的药物。</strong></p>\r\n\r\n<p>起源于激素依赖性组织的肿瘤如乳腺癌、前列腺癌、子宫内膜癌、甲状腺癌等，仍然部分的保留了对激素的依赖性和受体。这些肿瘤可以通过激素的治疗，或对内分泌腺的切除而使肿瘤缩小。临床上所采用的内分泌治疗，可以直接或间接的通过垂体的反馈作用，改变机体的激素平衡和肿瘤发生、发展的内环境，以达到抑制肿瘤的作用。这类内分泌药物如雌激素、孕激素及其拮抗剂等。在乳腺癌临床常用的他莫昔芬是一种雌激素调变剂，是通过竞争肿瘤细胞表面的受体，干扰雌激素对乳腺癌的刺激而达到治疗作用。肾上腺皮质激素是通过影响脂肪酸的代谢，而致淋巴细胞降解，以达到对急性淋巴细胞白血病及恶性淋巴瘤的治疗作用。</p>\r\n\r\n<p>1.性激素类药物 包括雄激素药物如甲睾酮等；雌激素药物如已烯雌酚等。<br />\r\n2.性激素调变剂 包括抗雌激素药物如他莫昔芬(TAM)、托瑞米芬等；抗雄激素药物如氟他特米、比卡鲁胺等。<br />\r\n3.芳香化酶抑制剂 如来曲唑、依西美坦等。<br />\r\n4.孕酮类药物 如甲孕酮、甲地孕酮。<br />\r\n5.促性腺激素释放素类药物 如戈舍瑞林、 曲普瑞林等。<br />\r\n6.肾上腺皮质激素类药物 如泼尼松、地塞米松等。<br />\r\n7.其他激素类药物 如甲状腺素等。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>三、生物反应调节剂</strong></p>\r\n\r\n<p>是一类具有广泛生物学活性和抗肿瘤活性的生物抗肿瘤药物。此类药对机体的免疫功能有增强、调节作用，其作用机制是通过增强机体免疫发挥抗肿瘤作用。</p>\r\n\r\n<p>1.细胞免疫增强剂 如白细胞介素-2、胸腺肽等。<br />\r\n2.巨噬细胞增强剂 如干扰素、腺病毒P53等。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>四、分子靶向药物</strong></p>\r\n\r\n<p>分子靶向治疗药物中，一类为用基因工程技术所产生的单克隆抗体。通过对受体的高选择性、亲和性和抗体依赖性的细胞毒作用，来杀灭肿瘤细胞，或抑制肿瘤细胞的增殖。另一类为作用于转导通路的药物。通过阻断或抑制细胞内信号转导通路的小分子化合物。</p>\r\n\r\n<p>1.单克隆抗体药物 如曲妥珠单抗、利妥昔单抗、西妥昔单抗、贝伐单抗等。<br />\r\n2.作用于转导的抑制药物 如吉非替尼、索拉非尼、厄洛替尼、拉帕替尼等。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>五、中药制剂</strong></p>\r\n\r\n<p>参一胶囊、复方斑蝥胶囊、复方苦参注射液、亚砷酸、贞芪扶正颗粒等。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>六、辅助治疗药物</strong></p>\r\n\r\n<p>1.升血药物 如重组人粒细胞集落刺激因子、促红细胞生成素、白介素―11等。2.镇痛药<br />\r\n物 如吲哚美辛、曲马多、吗啡等。<br />\r\n3.抗呕吐药物 如多潘立酮、格拉司琼、托烷司琼等。<br />\r\n4.抑制骨破坏药物 如帕米膦酸二钠、唑来膦酸等。</p>\r\n', '6', '290', '2015-08-06 17:15:51', '3', null, null, '1', '1', '2015-08-12 20:01:34');
INSERT INTO `t_group_topic` VALUES (null, '40', '再试一次', '0', '23', '8', '<p><img alt=\"\" src=\"http://localhost:8080/anjilang/upload/ckeditor/2015/08/13/d8180870-7ffa-41bd-a14b-c4e872197563.png\" style=\"height:150px; width:148px\" />发发得分方式对非法萨芬的</p>\r\n', '0', '0', '2015-08-13 16:29:22', '7', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES ('upload/ckeditor/2015/08/13/04f7c6e0-7ff9-43a8-aa84-ff760bb69475.png', '44', '抗肿瘤药物分类', '0', '23', '8', '<p><img alt=\"\" src=\"http://localhost:8080/anjilang/upload/ckeditor/2015/08/13/04f7c6e0-7ff9-43a8-aa84-ff760bb69475.png\" style=\"height:48px; width:48px\" /><img alt=\"\" src=\"http://localhost:8080/anjilang/upload/ckeditor/2015/08/13/c1103005-9662-4fac-8899-b56c958822c0.png\" style=\"height:150px; width:148px\" />方水水水水水水水水水水水水水水水水</p>\r\n', '0', '1', '2015-08-13 16:37:55', '7', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES ('upload/ckeditor/2015/08/13/7fecaf4a-ce32-4e1c-804d-63627fc7bca3.png', '47', 'wzq测试', '0', '23', '8', '<p>发放的方式的芬芳<img alt=\"\" src=\"http://localhost:8080/anjilang/upload/ckeditor/2015/08/13/7fecaf4a-ce32-4e1c-804d-63627fc7bca3.png\" style=\"height:150px; width:148px\" /><img alt=\"\" src=\"http://localhost:8080/anjilang/upload/ckeditor/2015/08/13/74d87b38-503c-4149-a377-8f47e2ed5217.png\" style=\"height:48px; width:48px\" /></p>\r\n', '0', '3', '2015-08-13 16:39:11', '7', null, null, '0', '1', '2015-08-13 19:39:02');
INSERT INTO `t_group_topic` VALUES ('upload/ckeditor/2015/08/13/887c844c-0d05-4e60-b780-a3b62e45b5ff.png', '48', '再试试', '0', '23', '8', '<p>发生的反复反复<img alt=\"\" src=\"http://localhost:8080/anjilang/upload/ckeditor/2015/08/13/887c844c-0d05-4e60-b780-a3b62e45b5ff.png\" style=\"height:48px; width:48px\" /></p>\r\n', '0', '1', '2015-08-13 16:47:12', '7', null, null, '0', '1', '2015-08-13 19:39:06');
INSERT INTO `t_group_topic` VALUES ('null.png', '49', '抗肿瘤药物分类', '0', '23', '8', '<p>发送到辅导费</p>\r\n', '0', '13', '2015-08-13 16:47:42', '7', null, null, '0', '1', '2015-08-13 19:39:09');
INSERT INTO `t_group_topic` VALUES ('null.png', '50', '夏季在空调屋子里吃火锅 留神一氧化碳中毒', '0', '23', '8', '<div>\r\n<p><em>火锅和烧烤都是人们喜欢的饮食，在炎热的夏季里，食客们常常关起门吹着空调，就着凉气吃烧烤涮火锅。可是，在相对封闭的环境里，使用的木炭如果燃烧不充分，容易引发一氧化碳中毒。近日，记者携带专业仪器对此进行了相关检测，结果不容乐观。</em></p>\r\n</div>\r\n\r\n<div>\r\n<div>\r\n<p><a href=\"http://health.msn.com.cn/tjwz2/1819826_2.shtml\" target=\"_self\"><img src=\"http://stimgcn4.s-msn.com/msnportal/health/2015/08/12/3ed5c386-6ef0-4958-a4f0-d4114a6d4802.jpg\" /></a></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>回顾 吃完火锅身体不适</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>　　今年6月30日晚上，北京市民任先生一行四人在一家火锅店吃火锅，当晚8点，任先生开始出现头晕恶心等症状，从洗手间回来后坐在座位上瘫靠在墙上，&ldquo;意识逐渐丧失&rdquo;。随后，另外三人相继出现同样头晕症状并趴在桌子上。事发后，四人被急救车送往医院抢救，据检查结果显示，患者吃火锅出现头痛、头晕、恶心，屋内生有炭火，屋内人员有类似症状。经检查，患者神志清楚，精神差，初步诊断为一氧化碳中毒，四名患者进行高压氧治疗。事后了解，四人在火锅店里用餐时间有4个小时。</p>\r\n\r\n<p><a href=\"http://health.msn.com.cn/tjwz2/1819826_2.shtml\" target=\"_self\"><img src=\"http://stimgcn3.s-msn.com/msnportal/health/2015/08/12/61ce2fc9-f6e8-4c10-896a-ce0b0526417b.jpg\" /></a></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>实验 一氧化碳浓度吓人</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>　　在位于东单附近的一家木炭火锅店里，记者在一个包间里点了一份烧炭的铜炉火锅。当烧好的铜锅被端到餐桌上后，记者将包间空调和排风扇打开，并关闭门窗，分时段对餐桌附近的一氧化碳浓度进行测量。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>　　在测量过程中，仪器不时发出警报声。记者注意到，在吃火锅的一个小时的时间里，位于相对封闭空间里的一氧化碳浓度在不断升高。记者将探测仪器放在火锅顶部，仪器数值一度高达820ppm。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>　　随后，记者打开门窗对屋内进行通风处理。半个小时后，一氧化碳的浓度由原先的300多ppm慢慢下降到240ppm。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>　　在位于北三环附近的一家韩式烧烤店里，记者也对炭炉附近进行了一氧化碳浓度测试，在一个多小时的时间里，仪器的数据一直显示为0。</p>\r\n\r\n<p><a href=\"http://health.msn.com.cn/tjwz2/1819826_2.shtml\" target=\"_self\"><img src=\"http://stimgcn2.s-msn.com/msnportal/health/2015/08/12/f16a5d10-1e92-448e-87db-41b4523c64a4.jpg\" /></a></p>\r\n</div>\r\n</div>\r\n', '0', '2', '2015-08-13 19:54:58', '3', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES ('null.png', '51', '深圳交警发布闯红灯星座排行 天秤最爱闯红灯', '0', '23', '8', '<div>\r\n<p><em>深圳交警对闯红灯被查人群的星座进行了分析，天秤座、处女座、天蝎座携手违法排名前三名，超过2次以上闯红灯被查的人群中，处女座最多。</em></p>\r\n</div>\r\n\r\n<div>\r\n<div>\r\n<p><a href=\"http://health.msn.com.cn/tjwz/1820035_2.shtml\" target=\"_self\"><img src=\"http://stimgcn2.s-msn.com/msnportal/health/2015/08/13/475aad43-aa87-4606-925c-b34d0dd9471a.jpg\" /></a></p>\r\n\r\n<p>深圳交警从8月3日开始对行人、非机动车违法行为开展千警百组整治，特别对行人冲红灯开展&ldquo;绿马甲&rdquo;行动。行动一周共查处9511宗违法行为人。</p>\r\n\r\n<p>交警在对这些人群进行大数据分析后，发现男性普遍比女性更爱闯红灯，18至50岁的人群是闯红灯的绝对主力。有趣的是，深圳交警竟然还对闯红灯被查人群的星座进行了分析，天秤座、处女座、天蝎座携手违法排名前三名，超过2次以上闯红灯被查的人群中，处女座最多。</p>\r\n</div>\r\n</div>\r\n', '0', '1', '2015-08-13 19:55:41', '3', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES ('null.png', '52', '家住几楼寿命更长 扬灰层的传言竟是假的', '0', '23', '8', '<p>　</p>\r\n\r\n<div>\r\n<p><em>城市高层住宅与居住者健康和寿命的关系，是困扰很多人的一个热点问题。人们传说的&ldquo;接地气&rdquo;更多是心理需要，另外9-11层是扬灰层的说法并无科学依据。</em></p>\r\n</div>\r\n\r\n<div>\r\n<div>\r\n<p><a href=\"http://health.msn.com.cn/tjwz2/1819090_2.shtml\" target=\"_self\"><img src=\"http://stimgcn2.s-msn.com/msnportal/health/2015/08/10/4b8d90d0-29ba-4da3-a6e8-0ddc3266def0.jpg\" /></a></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>城市高层住宅与居住者健康和寿命的关系，是困扰很多人的一个热点问题。中国有一个传统的观念，住高层住宅不太容易&ldquo;接地气&rdquo;，身体会产生不适。不过，近期瑞士伯尔尼大学的研究人员公布的一项研究表明，住得较高的人不仅健康状况好，而且寿命更长。</p>\r\n\r\n<p><a href=\"http://health.msn.com.cn/tjwz2/1819090_2.shtml\" target=\"_self\"><img src=\"http://stimgcn2.s-msn.com/msnportal/health/2015/08/10/00b24605-ff9f-4f49-bebd-ed8623153e2f.jpg\" /></a></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>瑞士伯尔尼大学的雷多斯洛、潘克扎克等人对瑞士150万人的调查发现，住在8楼以上的人提早死亡的几率要比住在低层的人低22%，其中，死于肺部疾病的几率低40%，死于严重心脏病的几率低35%。居住在较低层住宅的人死亡原因，大多与肺部和心脏疾病相关。</p>\r\n\r\n<p>研究者认为，和住在低层的人比较起来，住在高层住宅的人更可能徒步上下楼梯，因而锻炼身体的机会多一些，由此远离了心脏疾病。据有关专家研究： &ldquo;爬楼梯一级可延长生命4秒。&rdquo;爬楼梯是一种不花钱而有效的健身运动，以一般速度登楼，每10分钟要消耗220大卡热量，比散步效果好4倍；居住在低层住 宅的人可能受到空气污染和交通噪音的影响更多，对健康和寿命不利。高层还弥补了低层住宅容易潮湿、视野狭窄的缺陷。</p>\r\n\r\n<p><a href=\"http://health.msn.com.cn/tjwz2/1819090_2.shtml\" target=\"_self\"><img src=\"http://stimgcn1.s-msn.com/msnportal/health/2015/08/10/e58708e3-9092-435b-b66a-e6a14cba565a.jpg\" /></a></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&ldquo;高层建筑曾经令人讨厌。它可能会让人们孤立于社会环境外，引发不健康的习惯，甚至会增加犯罪率，但近年来这种情况有巨大变化。因为，现在的高 层建筑跟上世纪六七十年代不同，当年这种楼房的品质不高、设计也不太合理，如今高层住宅越来越舒适，很多还都是位于黄金地段的高楼大厦。&rdquo;研究人员评论道。</p>\r\n</div>\r\n</div>\r\n', '0', '0', '2015-08-13 19:57:35', '3', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES ('null.png', '53', '有这些特点的人不易患癌', '0', '23', '8', '<div>\r\n<p><em>个子矮、少白头、中年脱发、爱过敏，这些让人沮丧的先天因素也在健康方面带给你一些益处，比如，你可能更长寿、更聪明或者更不易得癌症。</em></p>\r\n</div>\r\n\r\n<div>\r\n<div>\r\n<p><a href=\"http://health.msn.com.cn/tjwz2/1819488_2.shtml\" target=\"_self\"><img src=\"http://stimgcn4.s-msn.com/msnportal/health/2015/08/11/b3870c31-1f06-4a17-abc0-525ecacf5b63.jpg\" /></a></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>个子矮的人不易患癌</p>\r\n\r\n<p>做一个&ldquo;高富帅&rdquo;是很多男生的梦想，即使不能高、富、帅俱全，做一枚&ldquo;高高在上&rdquo;的屌丝也是不错的选择。相反地，&ldquo;矮穷挫&rdquo;男则备受众人嫌弃，相亲节目上个子矮的男嘉宾最后大多不能牵手成功。矮个男生真的处处不如高个吗？近日美国一项研究显示，矮个男人更长寿而且不易得癌症，那些身高在1.5748米以下的男生最长寿。</p>\r\n\r\n<p>据美国《医药日报》报道，一项新研究发现，个头越矮，寿命越长。此外，矮个人群血液胰岛素水平相对更低，罹患癌症危险也更小。</p>\r\n\r\n<p>一项发表于2012年的研究支持了这一观点，研究人员追踪了500名生活在意大利撒丁岛的出生于1866-1915年之间的男性，发现个子矮的男性比个子高的同伴寿命长2年。</p>\r\n\r\n<p><a href=\"http://health.msn.com.cn/tjwz2/1819488_2.shtml\" target=\"_self\"><img src=\"http://stimgcn3.s-msn.com/msnportal/health/2015/08/11/8b61e355-7b9f-430e-ae72-eb4c50c62905.jpg\" /></a></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>在这项研究中，8000名男性被分成两组&mdash;&mdash;身高在1.5748米以上的和身高在1.5748米及以下的，被调查者都是出生在1900-1919年的日本裔的美国男性。数据显示，被调查者中有大概1200名男性寿命超过90岁，甚至100岁，有将近250人还在世。</p>\r\n\r\n<p>&ldquo;身高在1.5748米以下的男性寿命最长。身高在1.524米到1.8288米之间的男性，个子越高，寿命越短&rdquo;，参与研究的夏威夷大学的Bradley Willcox教授说，&ldquo;这个结果虽然不具有绝对性，但是却为我们提供了身高与寿命之间关系的证据，这个研究第一次表明，个子大小与FOXO3基因有关&rdquo;。</p>\r\n\r\n<p>在动物世界中，也存在类似的现象。小老鼠、小马、小猴一般活的更久，较小的亚洲象也总是比更大的非洲象更长寿。</p>\r\n\r\n<p><a href=\"http://health.msn.com.cn/tjwz2/1819488_2.shtml\" target=\"_self\"><img src=\"http://stimgcn3.s-msn.com/msnportal/health/2015/08/11/8d285837-4519-4886-8d17-6bb3b3f38ce1.jpg\" /></a></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>秃顶男人患癌几率低</p>\r\n\r\n<p>秃顶是年纪偏大的男性普遍会出现的美容问题,也是一个男性们普遍关注的美容问题。无奈的是秃顶常常是由常染色体显性基因a控制,多在男性中表现。</p>\r\n\r\n<p>现在，秃顶男人心理应该平衡了，经过大量的实验已证明，除疾病引起的脱发外，秃顶男人具有很多生理优越性。</p>\r\n</div>\r\n</div>\r\n', '0', '0', '2015-08-13 19:58:20', '3', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES ('null.png', '54', '\"暑假乞丐\"现身北京地铁 儿童带着作业来乞讨', '0', '23', '8', '<div>\r\n<p><em>暑期以来，北京地铁突然出现众多&ldquo;候鸟式&rdquo;乞丐，行乞时间固定为暑假期间，7月来京，9月前离京，通常为外地年轻女性和孩子行乞。记者调查发现，这些&ldquo;暑假乞丐&rdquo;多数来自甘肃岷县，基本都是父母带着正在上学的孩子乞讨，孩子开学前即返回老家。</em></p>\r\n</div>\r\n\r\n<div>\r\n<div>\r\n<p><a href=\"http://health.msn.com.cn/tjwz2/1819790_2.shtml\" target=\"_self\"><img src=\"http://stimgcn4.s-msn.com/msnportal/health/2015/08/12/752f8965-5742-4f23-9de5-0b3dd53e34b0.jpg\" /></a></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>北京地铁里的&ldquo;暑假乞丐&rdquo;</p>\r\n\r\n<p>多数来自甘肃岷县 带孩子乞讨怕耽误学业开学即离京</p>\r\n\r\n<p>暑期以来，北京地铁突然出现众多&ldquo;候鸟式&rdquo;乞丐，行乞时间固定为暑假期间，7月来京，9月前离京，通常为外地年轻女性和孩子行乞。记者调查发现，这些&ldquo;暑假乞丐&rdquo;多数来自甘肃岷县，基本都是父母带着正在上学的孩子乞讨，孩子开学前即返回老家。</p>\r\n\r\n<p>&ldquo;自7月以来共处罚乞讨卖艺行为40余起，劝离250余起，乞讨卖艺人员中大多数都来自甘肃岷县。&rdquo;据轨道交通执法大队相关负责人介绍，从实际查处的情况看，这些乞讨人员相对集中在几个地区，在京暂住地也相对集中。从地区来看，主要集中在甘肃岷县和河南民权县，这两个地方大致占据乞讨者半壁江山，而且现在暑假带娃乞讨的现象明显增多。</p>\r\n\r\n<p>这是第三个暑假来京乞讨</p>\r\n\r\n<p>王霞(化名)，来自甘肃岷县小寨镇白塔村，7月10日带着女儿柳英(化名)和儿子柳杰(化名)来到北京，这是他们第三年来京乞讨。</p>\r\n\r\n<p>7月30日早上10点，柳英在10号线惠新西街南口站上车，她打开腰间挂着的外放音响，带着弟弟从车头走向车尾。柳英手里攥着一小叠一元人民币，不断地向两侧的人鞠躬，弟弟柳杰时不时跪下，希望好心的人能慷慨解囊。</p>\r\n\r\n<p>姐姐柳英今年14岁，刚念完初一，身上的校服印着岷县第三中学的校徽。弟弟柳杰今年10岁，刚上完三年级，褐色裤子的膝盖处有着一圈泥土印。地铁开到惠新西街南口站后，姐弟俩下车，快速走到对面往回坐。</p>\r\n\r\n<p>从惠新西街南口到海淀黄庄，姐弟俩刚好能从车头一路乞讨到车尾，这也是他们的固定路线。每天他们七八点出门，十点左右到十号线，下午四五点回家。一天下来，他们能要到五十六元，最好的时候七八十元，少的时候只有二三十元。</p>\r\n\r\n<p>三年来，每年7月放暑假以后，姐弟俩就会从甘肃老家来北京乞讨。暑假即将结束时，他们会按期回老家的学校上学。</p>\r\n\r\n<p>今年柳英的裤兜里多了一样东西：老年人专用的手机。这部手机价格便宜，功能非常简单，但它却是柳英在乞讨时与妈妈联系的纽带：一旦发现有警察，她会立刻躲在人少的地方，给妈妈打电话，通风报信。</p>\r\n\r\n<p>&ldquo;现在我们都学会了&lsquo;变通&rsquo;。&rdquo;妈妈王霞说。现在，都是大一点的孩子自己乞讨或者大孩子带着小孩子来乞讨，妈妈们则在事先和孩子们约好了的中转的地方等着。妈妈和孩子们手里都有手机，这样出事了也方便联系。由于孩子们都未成年，即使被抓到了也会很快放出来。</p>\r\n\r\n<p>去年，柳英被警察带进了派出所，被教育过一遍后就给放了。尽管当时在派出所里很害怕，但是现在提起这些事情，柳英却轻描淡写，&ldquo;我打电话给妈妈，不到两分钟就放我们走了&rdquo;。而她的母亲王霞说：&ldquo;登记下身份证和户口本就没事了，也没有罚款。&rdquo;</p>\r\n\r\n<p><a href=\"http://health.msn.com.cn/tjwz2/1819790_2.shtml\" target=\"_self\"><img src=\"http://stimgcn1.s-msn.com/msnportal/health/2015/08/12/f25dc67d-0c8e-42eb-8de6-670633ceabf3.jpg\" /></a></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>行乞第三天被抓</p>\r\n\r\n<p>跟柳英柳杰比起来，同样来自岷县的杨娴(化名)就没有这么幸运，带着女儿乞讨的第三天，她就被抓了。</p>\r\n\r\n<p>7月22日，杨娴和丈夫张成亮(化名)带着一儿一女来京乞讨，来北京之前，夫妻俩听不少同乡说带孩子来北京能讨到钱，&ldquo;原本打算攒下来四五百元钱，给两个孩子攒个学费，没想到&hellip;&hellip;&rdquo;说到这里杨娴停住了。</p>\r\n\r\n<p>来北京乞讨的第三天，也就是7月25日下午4点左右，当杨娴带着7岁的女儿在地铁10号线乞讨的时候，遇到了民警。在警察抓她的过程中，杨娴不停地说：&ldquo;放开我，你们把我放开&rdquo;，女儿张晓娟(化名)当时哭了，杨娴自己也很害怕，她说这样的事自己&ldquo;从来没有遇到过，从来没有&hellip;&hellip;&rdquo;杨娴和女儿被带上了警车，开往派出所。</p>\r\n\r\n<p>随后，警察电话通知了她的丈夫张成亮，让他领女儿回去。下午5点多，当张成亮带着5岁的儿子赶到那里，听到警察说要拘留妻子，他回忆称当时有些激动。直到民警告诉张成亮，拘留是因为在地铁里带着孩子乞讨已经触犯了法律，他才领着哭闹的孩子们回了家。</p>\r\n\r\n<p>8月4日上午，杨娴回到了在昌平区平西府租住的房子，同时，带回了一张证明书：《解除拘留证明书》。这张&ldquo;证明书&rdquo;上写着，拘留原因是&ldquo;因胁迫、诱骗、利用他人乞讨&rdquo;。</p>\r\n\r\n<p>妻子被拘留之后，张成亮也不敢带孩子去地铁上乞讨了。最近，他都是早上七八点钟带着两个小孩儿出门，拉着孩子们在街口到天通苑方向的马路上乞讨，十一点多回来，&ldquo;一天大概能讨到二三十元钱，刚好够生活&rdquo;。杨娴被拘留后，女儿晓娟好几天都闷闷的，不怎么说话。</p>\r\n\r\n<p>躲不开的乞丐江湖</p>\r\n\r\n<p>孩子成为地铁乞讨者对付执法者的&ldquo;工具&rdquo;，但是在这个地铁&ldquo;丐帮&rdquo;里，无论孩子还母亲，却不得不遵循着&ldquo;弱肉强食&rdquo;的规矩&mdash;&mdash;她们躲得了警察，却躲不了江湖。</p>\r\n\r\n<p>在10号线海淀黄庄站下车后，柳英姐弟碰到了小伙伴王成(化名)，柳杰的同班同学。新的一趟车到来后，王成很快跳上去，姐弟俩则要等下一趟。这是他们之间的默契，尽量不上同一辆车。</p>\r\n\r\n<p>&ldquo;这是那些残疾的叔叔教我们的，&rdquo;柳英解释，&ldquo;但现在人太多，队都排不上。如果抢着上车，排在前面其他村的人就会打我。&rdquo;有一次，她一整天才上了两趟车。</p>\r\n\r\n<p>姐弟俩知道如果去5号线会挣得多一些，但是她们却不敢去。&ldquo;那里有一个恶霸，看见我们就会抡着棍子打我们。&rdquo;柳英说。</p>\r\n\r\n<p>柳英的说法被另一个地铁行乞者孙梅(化名)证实了。孙梅是一位90后的乞讨妈妈，她带着孩子在5号线乞讨。&ldquo;我不认字，以前也没坐过地铁。&rdquo;孙梅说自己开始就在5号线上看到了一个姓李的人在行乞，从而知道了在5号线能要到钱，也知道了如何才能要到钱。</p>\r\n\r\n<p>其实，孙梅属于&ldquo;偷师&rdquo;，她要钱的时候一直躲着那位&ldquo;姓李的人&rdquo;。&ldquo;我们看到他就跑，他今天又打了两个女的&rdquo;。孙梅把他称之为&ldquo;小霸王&rdquo;或者&ldquo;恶霸&rdquo;，&ldquo;他坏得很，本来出来就是求别人帮助，有一次他扇了一个老头好几个耳光，那个老头得有八十多岁了，这是太没良心。&rdquo;</p>\r\n\r\n<p><a href=\"http://health.msn.com.cn/tjwz2/1819790_2.shtml\" target=\"_self\"><img src=\"http://stimgcn1.s-msn.com/msnportal/health/2015/08/12/a26b7348-4d8c-4322-b00f-a4f91be16681.jpg\" /></a></p>\r\n\r\n<p><a href=\"http://health.msn.com.cn/tjwz2/1819790_2.shtml\" target=\"_self\">点击进入下一页</a></p>\r\n\r\n<p>北京跟想象的不一样</p>\r\n\r\n<p>出于同乡的口口相传和指引，这些岷县人大部分都会在昌平区平西府附近租住，同村的会住在一栋楼里，例如柳英家、杨娴家和另外四户同村人家就是楼上楼下的邻居。</p>\r\n\r\n<p>他们往往一家人挤在六七平方米的单间里。这些单间只配了一张木板床和一个旧衣柜，每月的租金300元。房东杨女士说他们说好了只住一个月，一个月以后搬家走人。</p>\r\n\r\n<p>张成亮和杨娴也没有打算在北京长住，只是希望暑假一个月能够攒下来两个孩子四五百元钱的学费。张成亮家去年种植当归、党参等药材的收入一共7000元，但只够一家人的生活开支。而盖新房欠下的4万元亏空，目前还没有着落。</p>\r\n\r\n<p>27岁的张成亮说两年前，甘肃岷县发生了6.2级地震，他家的房子在地震中倒塌，重盖的房子花了六七万元。除了政府给的那部分钱以外，张成亮说，&ldquo;剩下的4万多都是借的高利贷，三分利的。&rdquo;</p>\r\n\r\n<p>其实，这些年张成亮为了生计在内蒙古和山西都打过工，从维修工到煤矿工，但每次时间不过一两个月。&ldquo;在内蒙古那边干了一个月就回来了，修水渠、铺水泥板，一个月一千多，但累得腰疼得厉害&rdquo;，他说，在山西，他下矿井做了两个月的煤矿工人，但由于害怕跟姑父一样得&ldquo;尘肺病&rdquo;，所以在姑姑的劝说下也就回来了。</p>\r\n\r\n<p>&ldquo;老家那边来过的人都说这边能讨到钱&rdquo;，张成亮说，&ldquo;我们就过来讨点孩子的学费，开学了再回去。&rdquo;谈到以后的打算，杨娴希望丈夫能在外面尽快找到工作，她就带着孩子在老家种田，两个人供孩子们读书。当问到以后是否还会带孩子们来北京乞讨，杨娴说再也不来了，&ldquo;我害怕，我从来没去过那里&hellip;&hellip;&rdquo;说完她长叹了一口气。</p>\r\n\r\n<p>而对于三次来北京的柳英来说，明年，她同样不想再来北京乞讨了。这并不是因为她觉得自己和妈妈因为生计而要饭有什么不对的地方，只是因为自己不想再读书，要在家照顾弟弟。&ldquo;我自己不想读了，我会在家照顾弟弟，妈妈可能会出去打工。&rdquo;她的理想是成为一位服装设计师，弟弟柳杰则想成为一名航天员。</p>\r\n\r\n<p>对于这段在北京的生活，柳英不会忘记的除了人们对他们鄙夷的眼光，还有的就是天安门城楼。</p>\r\n\r\n<p>&ldquo;我自己悄悄地去看过天安门，那边人多，我没敢带弟弟去。&rdquo;柳英说，她也只看过了天安门，她说以后想带着弟弟和妈妈一起爬长城，去动物园看长颈鹿和大熊猫。</p>\r\n</div>\r\n</div>\r\n', '0', '4', '2015-08-13 19:59:11', '3', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES ('null.png', '55', '夏天喝4款菊花茶可有效降血压', '0', '23', '8', '<p><img alt=\"夏天喝4款菊花茶可有效降血压\" src=\"http://stimgcn4.s-msn.com/msnportal/health/2015/08/13/e50dad82-56be-406e-9c6a-6396f81594bf.jpg\" /></p>\r\n\r\n<p>　　夏天喝菊花茶可以帮助我们有效控制血压升高。不过，需要特别提醒的是菊花茶可以和其他茶类配合饮用，这样会有更好的效果的哦。今天，就来为大家介绍一下降血压的4款菊花茶都是怎样的吧。</p>\r\n\r\n<p>　　<strong>4款菊花茶可有效降血压</strong></p>\r\n\r\n<p>　　菊槐茶：菊花、槐花各10克。同放入杯中，用沸水冲泡，加盖，闷10分钟即可饮用。一般可冲泡3~5次，当天饮完。此茶可平肝降压，软化血管。主治各种高血压病，对老年人高血压伴有动脉粥样硬化者尤为适宜。</p>\r\n\r\n<p>　　菊杞茶：菊花10克，枸杞子30克。将枸杞子加3~5杯水煮沸10分钟，然后放入菊花再煮2~3分钟，过滤取汁，装入保温瓶，分3~4次1日饮完。菊杞茶含丰富的维生素A，可预防和治疗各种眼病，还可防治高血压、冠心病，最适宜于老年人饮用。</p>\r\n\r\n<p>　　菊楂茶：菊花15克，生山楂20克。水煎或沸水冲泡10分钟即可饮用。常饮菊楂茶，不仅扩张冠状动脉，舒张血管，降低血压，同时也降血脂。适用于冠心病、高血压、高血脂、心功能不全等。</p>\r\n\r\n<p>　　菊红茶：菊花10克，红花5克，丹参5克。将上3味放入有盖杯中，用沸水冲泡，代茶频频饮用。一般可冲泡3~5次，当天饮完。菊红茶能降低冠脉阻力、改善心肌微循环，坚持服用可降低冠心病、心绞痛的发作次数，减轻发作程度。</p>\r\n\r\n<p>　　<strong>那么，要如何挑选菊花茶呢?</strong></p>\r\n\r\n<p>　　<strong>菊花茶的选购方法</strong></p>\r\n\r\n<p>　　看。贡菊的干品略带黄色，凡是很白的菊花多半是用硫磺熏过的，看上去显得漂亮，实际上却是次品。</p>\r\n\r\n<p>　　闻。买前要闻闻菊花是否有酸味，如果有，则是被硫磺熏过的;没熏过的菊花只有淡淡的清香。</p>\r\n\r\n<p>　　菊花容易发霉、长虫，市场上的菊花质量参差不齐，不懂门道的人会选择花朵白且大朵的菊花，其实又小又丑且颜色泛黄的菊花反而是上选。此外，选菊花最好选花萼偏绿的菊花，这表明刚开的时候就摘下来了。买时先用手摸一摸，松软的、顺滑的菊花质量比较好。</p>\r\n\r\n<p>　　正确的喝菊花茶可以在这个夏天有效帮你降血压哦。</p>\r\n', '0', '4', '2015-08-13 20:00:29', '3', null, null, '0', '1', '2015-08-13 20:02:25');
INSERT INTO `t_group_topic` VALUES ('null.png', '56', '初秋时节吃藕有7大好处', '0', '23', '8', '<p><img alt=\"初秋时节吃藕有7大好处\" src=\"http://stimgcn2.s-msn.com/msnportal/health/2015/08/13/392eb955-b15d-41f1-9df2-02e407f0bd33.jpg\" /></p>\r\n\r\n<p>　　在夏末秋初的此时，我们在日常的饮食中可以开始吃藕来养生保健。那么，在初秋的时候吃藕有什么好处呢？同时，藕发黑后究竟还能不能继续食用呢？今天，就来为大家介绍一下关于藕的基本常识吧。</p>\r\n\r\n<p>　　<strong>初秋吃藕的7大好处</strong></p>\r\n\r\n<p>　　降糖降脂益肠道。藕富含膳食纤维，热量却不高，因而能控制体重，有助降低血糖和胆固醇水平，促进肠蠕动，预防便秘及痔疮。鲜藕生姜汁还可治疗肠道炎症。</p>\r\n\r\n<p>　　抗衰防癌补维C。藕的含糖量不算很高，但含有较高的维生素C，对于肝病、便秘、糖尿病等患者都十分有益。藕还富含多酚类物质，可以提高免疫力，缓解衰老进程，预防癌症。</p>\r\n\r\n<p>　　止痛减压护心脏。藕中富含B群维生素（特别是维生素B6）。补充B族维生素有益减少烦躁，缓解头痛和减轻压力，进而改善心情，降低心脏病危险。</p>\r\n\r\n<p>　　补血益神助消化。鲜藕含有丰富的铜、铁、钾、锌、镁和锰等微量元素。在块茎类食物中，莲藕含铁量较高，因此缺铁性贫血者最适宜吃藕。藕中的多种微量元素有益红细胞的产生，保持肌肉和神经正常工作。另外，这些营养素还有助分泌消化酶，改善消化。</p>\r\n\r\n<p>　　稳定心率降血压。藕中钠钾比为1∶5，钠少钾多有益调节血压和心率，有益心脏及全身健康。</p>\r\n\r\n<p>　　补充维K防出血。藕中含有丰富的维生素K，具有止血作用。鲜藕榨汁喝下，有助防止出血。</p>\r\n\r\n<p>　　祛痰镇咳防哮喘。鲜藕汁也可用来治疗咳嗽、哮喘和肺炎等呼吸系统疾病。热莲藕茶具有镇咳祛痰的功效。</p>\r\n\r\n<p>　　那么，怎样防止藕发黑呢？</p>\r\n\r\n<p>　　<strong>防止藕发黑的小窍门</strong></p>\r\n\r\n<p>　　实际上，想让莲藕保持洁白本质并不困难。在100℃的沸水中汆烫70秒就可以让所有的多酚氧化酶失去作用，也就叫停了多酚向醌的转变过程。不过，这种方法恐怕只适用于排骨炖莲藕这样需要软糯口感的菜肴。如果按此方法来做凉拌藕片，黑是不黑了，但也失去了爽脆的口感。</p>\r\n\r\n<p>　　不用着急，除了高温处理，适当添加酸性物质也能绑住多酚氧化酶的手脚。在制作凉拌藕片时，马上在烫制过的藕片中加入醋，能很大程度地避免多酚氧化酶的催化作用，使莲藕保持洁白的色泽。实际上，一些即食包装的藕片中就添加了柠檬酸等抑制多酚氧化酶活性的物质。</p>\r\n\r\n<p>　　那些买回来的鲜藕，短时间内吃不完，又怎么保持洁白呢？这也不难，虽然多酚氧化酶有很强的催化作用，但是需要有氧气的参与，莲藕中的酚类物质才能氧化成醌，所以隔绝氧气也是一个方法。把莲藕泡在水里就能延缓莲藕变黑的过程。</p>\r\n\r\n<p>　　最后，再来教你挑选藕的小技巧。</p>\r\n\r\n<p>　　<strong>选购藕的小技巧</strong></p>\r\n\r\n<p>　　藕节粗且短。藕节数目不会影响品质，选购时要挑较粗短的藕节，成熟度足，口感较佳。</p>\r\n\r\n<p>　　藕节间距长。藕节与藕节之间的间距愈长，表示莲藕的成熟度愈高，口感较松软。</p>\r\n\r\n<p>　　外形要饱满。莲藕要外形饱满，不要选择外型凹凸不完整的莲藕。</p>\r\n\r\n<p>　　带有湿泥土。没有湿泥的莲藕通常已经过处理，不耐保存，有湿泥的莲藕较好保存，可置於阴凉处约1周。</p>\r\n\r\n<p>　　初秋吃藕好处多，快来试试看吧。</p>\r\n', '0', '4', '2015-08-13 20:01:09', '3', null, null, '0', '1', '2015-08-13 20:02:14');
INSERT INTO `t_group_topic` VALUES ('null.png', '57', '补血最快的5种食物', '0', '23', '8', '<div>\r\n<div>\r\n<div>\r\n<p><img alt=\"补血最快的5种食物\" src=\"http://stimgcn3.s-msn.com/msnportal/health/2015/08/13/54a0a619-4d09-40a6-a64d-ca42158c3625.jpg\" /></p>\r\n\r\n<p>　　现如今社会大多数人都会有贫血这个说严重不严重的毛病，而其中以女性朋友居多。一个人如果贫血的话，就会变得面色苍白，黯淡无光。所以，补血对爱美的女性朋友来说是不可缺少的。那么你知道吃什么补血最快吗?</p>\r\n\r\n<p>　　补血吃6种食物</p>\r\n\r\n<p>　　<strong>1、胡萝卜</strong></p>\r\n\r\n<p>　　含有很高的维生素B、维生素C，还含有胡萝卜素，而胡萝卜素对补血极其有帮助。</p>\r\n\r\n<p>　　<strong>2、龙眼肉</strong></p>\r\n\r\n<p>　　含有丰富的铁质，还含有维生素A、维生素B和葡萄糖、蔗糖等，可以补血，还可以治疗健忘、心悸、神经衰弱和失眠症。龙眼汤、龙眼胶、龙眼酒等等都是很好的补血食物。</p>\r\n\r\n<p>　　<strong>3、鸡蛋</strong></p>\r\n\r\n<p>　　取鸡蛋2个，将蛋黄打散，水煮开先加盐少许，入蛋黄煮熟，每日饮服2次，这可以补铁，适用于缺铁性贫血。</p>\r\n\r\n<p>　　<strong>4、萝卜干</strong></p>\r\n\r\n<p>　　含的维生素B极为丰富，铁质含量很高，含量是除了金针菜之外超过一切食物，对补血有很大的帮助。</p>\r\n\r\n<p>　　<strong>5、黑豆</strong></p>\r\n\r\n<p>　　可以让人头发变黑，也可以生血。建议用黑豆煮乌骨鸡或用黑豆核桃炖猪腰。</p>\r\n\r\n<p>　　贫血吃什么：2款补血食谱</p>\r\n\r\n<p>　　<strong>1、萝卜炖牛肉</strong></p>\r\n\r\n<p>　　材料：白萝卜450克，牛肉(瘦)100克，料酒10克，大葱15克，姜15克，酱油10克，盐4克，味精2克，八角3克，花生油40克。</p>\r\n\r\n<p>　　做法：首先，将萝卜、牛肉分别洗净，均切成2厘米见方的块，分别入沸水中略焯，捞出。接着，锅内加油烧热，放大葱段、姜块、八角炸香，加入鲜汤、料 酒、牛肉块，炖到直至熟烂。然后，再放入萝卜块，烧开，撇去浮沫，直至萝卜块熟烂，加入精盐、酱油、味精，拣出葱、姜、八角不要。再撇去浮抹，出锅盛入汤 碗内就可以了。</p>\r\n\r\n<p>　　<strong>2、清炖排骨</strong></p>\r\n\r\n<p>　　材料：猪排骨(大排)300克、盐3克，小白菜50克、花生油20克，味精2克，黄酒3克，大葱4克，姜3克。</p>\r\n\r\n<p>　　做法：首先，将排骨洗净，剁成四厘米长，三厘米宽的段，下沸水锅焯烫后捞出，冲洗干净。接着，将小白菜洗净，去根部，一切两段，而葱切段;姜切块， 用刀轻轻拍松。然后，在锅上火烧热，加少许底油，用葱段，姜块炝锅，烹绍酒，下排骨，添汤。用旺火烧沸，撇净浮沫，倒入陶器，转小火慢炖至接近成熟。最 后，下小白菜放精盐、味精调口，再炖至排骨酥烂脱骨就可以了。</p>\r\n\r\n<p>　　以上就是我们为大家推荐的补血最快的6种食物以及两款食疗方，希望能够帮到大家。健康的身体是一切幸福生活的前提，所以我们要好好的照顾好我们的身体，养成一个良好的生活习惯。而在食用养生食物的时候也要注意它是否适用于自己的情况。祝愿大家身体健康!</p>\r\n</div>\r\n</div>\r\n</div>\r\n\r\n<div>&nbsp;</div>\r\n', '0', '4', '2015-08-13 20:01:52', '3', null, null, '0', '1', '2015-08-13 20:02:02');
INSERT INTO `t_group_topic` VALUES ('upload/ckeditor/2015/08/13/d64c0ccb-0848-4319-bd71-d2c30b63eea7.png', '58', '补血最快的5种食物', '0', '23', '8', '<p><img alt=\"\" src=\"http://localhost:8080/anjilang/upload/ckeditor/2015/08/13/d64c0ccb-0848-4319-bd71-d2c30b63eea7.png\" style=\"height:374px; width:500px\" /></p>\r\n\r\n<p>现如今社会大多数人都会有贫血这个说严重不严重的毛病，而其中以女性朋友居多。一个人如果贫血的话，就会变得面色苍白，黯淡无光。所以，补血对爱美的女性朋友来说是不可缺少的。那么你知道吃什么补血最快吗?</p>\r\n\r\n<p>　　补血吃6种食物</p>\r\n\r\n<p>　　<strong>1、胡萝卜</strong></p>\r\n\r\n<p>　　含有很高的维生素B、维生素C，还含有胡萝卜素，而胡萝卜素对补血极其有帮助。</p>\r\n\r\n<p>　　<strong>2、龙眼肉</strong></p>\r\n\r\n<p>　　含有丰富的铁质，还含有维生素A、维生素B和葡萄糖、蔗糖等，可以补血，还可以治疗健忘、心悸、神经衰弱和失眠症。龙眼汤、龙眼胶、龙眼酒等等都是很好的补血食物。</p>\r\n\r\n<p>　　<strong>3、鸡蛋</strong></p>\r\n\r\n<p>　　取鸡蛋2个，将蛋黄打散，水煮开先加盐少许，入蛋黄煮熟，每日饮服2次，这可以补铁，适用于缺铁性贫血。</p>\r\n\r\n<p>　　<strong>4、萝卜干</strong></p>\r\n\r\n<p>　　含的维生素B极为丰富，铁质含量很高，含量是除了金针菜之外超过一切食物，对补血有很大的帮助。</p>\r\n\r\n<p>　　<strong>5、黑豆</strong></p>\r\n\r\n<p>　　可以让人头发变黑，也可以生血。建议用黑豆煮乌骨鸡或用黑豆核桃炖猪腰。</p>\r\n\r\n<p>　　贫血吃什么：2款补血食谱</p>\r\n\r\n<p>　　<strong>1、萝卜炖牛肉</strong></p>\r\n\r\n<p>　　材料：白萝卜450克，牛肉(瘦)100克，料酒10克，大葱15克，姜15克，酱油10克，盐4克，味精2克，八角3克，花生油40克。</p>\r\n\r\n<p>　　做法：首先，将萝卜、牛肉分别洗净，均切成2厘米见方的块，分别入沸水中略焯，捞出。接着，锅内加油烧热，放大葱段、姜块、八角炸香，加入鲜汤、料 酒、牛肉块，炖到直至熟烂。然后，再放入萝卜块，烧开，撇去浮沫，直至萝卜块熟烂，加入精盐、酱油、味精，拣出葱、姜、八角不要。再撇去浮抹，出锅盛入汤 碗内就可以了。</p>\r\n\r\n<p>　　<strong>2、清炖排骨</strong></p>\r\n\r\n<p>　　材料：猪排骨(大排)300克、盐3克，小白菜50克、花生油20克，味精2克，黄酒3克，大葱4克，姜3克。</p>\r\n\r\n<p>　　做法：首先，将排骨洗净，剁成四厘米长，三厘米宽的段，下沸水锅焯烫后捞出，冲洗干净。接着，将小白菜洗净，去根部，一切两段，而葱切段;姜切块， 用刀轻轻拍松。然后，在锅上火烧热，加少许底油，用葱段，姜块炝锅，烹绍酒，下排骨，添汤。用旺火烧沸，撇净浮沫，倒入陶器，转小火慢炖至接近成熟。最 后，下小白菜放精盐、味精调口，再炖至排骨酥烂脱骨就可以了。</p>\r\n\r\n<p>　　以上就是我们为大家推荐的补血最快的6种食物以及两款食疗方，希望能够帮到大家。健康的身体是一切幸福生活的前提，所以我们要好好的照顾好我们的身体，养成一个良好的生活习惯。而在食用养生食物的时候也要注意它是否适用于自己的情况。祝愿大家身体健康!</p>\r\n', '0', '5', '2015-08-13 20:08:45', '3', null, null, '0', '1', '2015-08-13 20:22:23');
INSERT INTO `t_group_topic` VALUES ('upload/ckeditor/2015/08/13/237998a5-1215-4d0c-aea4-4d7e12186424.png', '59', '隔夜西瓜究竟还能不能吃？', '0', '23', '8', '<p><img alt=\"\" src=\"http://localhost:8080/anjilang/upload/ckeditor/2015/08/13/237998a5-1215-4d0c-aea4-4d7e12186424.png\" style=\"height:360px; width:500px\" /></p>\r\n\r\n<p>对于许多市民而言，西瓜是 炎炎夏日必备的解暑水果。在西瓜吃不完时，很多家庭的做法都是放冰箱，第二天接着吃。但是，近日一篇题为&ldquo;隔夜西瓜放倒一家三口，实验证明隔夜西瓜细菌数 量数以亿计算&rdquo;的报道，引起不少市民恐慌。对此，专家表示，该实验缺乏与冷藏保存的比较，而检测中出现的&ldquo;数以亿计&rdquo;的细菌，与&ldquo;隔夜&rdquo;的关系并不确定。</p>\r\n\r\n<p>　　<strong>隔夜西瓜放倒一家三口？</strong></p>\r\n\r\n<p>　　近日，一则&ldquo;隔夜西瓜放倒一家三口，实验证明隔夜西瓜细菌数量以亿计算&rdquo;的新闻在微博、微信等社交网络上广泛流传。</p>\r\n\r\n<p>　　该报道称，有一家三口吃了冰箱冷藏的覆着保鲜膜的隔夜西瓜后，全都拉肚子进了医院。随后，该报记者将切开的半个西瓜封上保鲜膜，放在常温下12个小时后，送到一家医院进行检测。检测中，工作人员分别在西瓜切面的表层、表层下4厘米处、表层下8厘米处取样，每处取样1克，捣碎后放入培养基中。</p>\r\n\r\n<p>　　12小时后，三个样品的培养基中均分布着密密麻麻的菌群，实验人员表示细菌数量难以数清，需要以亿为单位来计算。最后，该报道得出隔夜西瓜细菌数以亿计的结论，并呼吁大家扔掉隔夜西瓜。</p>\r\n\r\n<p>　　&ldquo;隔夜西瓜细菌数以亿计&rdquo;的消息随即在网络上不胫而走，并一度被众人视为能证实&ldquo;隔夜西瓜不能吃&rdquo;的有力证据。</p>\r\n\r\n<p>　　随后数天，一篇名为&ldquo;女子吃隔夜西瓜差点丢命&rdquo;的报道再次引发网友关注。该报道称，保鲜膜包西瓜，就是在养殖细菌。随着有关&ldquo;隔夜西瓜&rdquo;的报道在网络上 热传，相关辟谣文章也随即成为热点。不少网友表示，虽然对于报道中所提到的隔夜西瓜细菌&ldquo;上亿&rdquo;数据不太相信，但以后还是少吃隔夜西瓜为妙。</p>\r\n\r\n<p>　　<strong>专家：冷藏隔夜瓜问题不大</strong></p>\r\n\r\n<p>　　事实果真如此吗？中国农业大学食品科学与营养工程学院副教授何计国在接受媒体采访时表示，隔夜西瓜细菌数量以亿计算这个实验看似很有说服力，却犯了一个很重要的错误，缺少与冷藏保存的比较。</p>\r\n\r\n<p>　　何计国解释称，因为实验中西瓜存放的条件和平常家庭里的不一样。我们通常的做法是把吃不完的西瓜放进冰箱，并且有保鲜膜、保险饭盒 等遮盖，低温环境可以抑制微生物生长，而表面遮盖又可以防止二次污染。但送去做实验的西瓜是在常温下存放一夜，夏天温度高，西瓜在这种环境下很容易滋生细 菌。</p>\r\n\r\n<p>　　广东药学院附属第一医院临床营养科主任赵泳谊也指出，实验的偶然性太大，检测中出现的&ldquo;数以亿计&rdquo;的细菌，还可能来自空气、刀具甚至保鲜膜，与&ldquo;隔夜&rdquo;的关系并不确定；最后，这些细菌是不是致病菌，也有待进一步鉴定。</p>\r\n\r\n<p>　　不过，赵泳谊提醒市民，虽然冰箱冷藏的隔夜西瓜问题不大，但冷藏时间最好别超过48小时，因为储存时间越长，被细菌感染的可能性就越大。至于夏日如何存储热带水果，相关营养专家则表示，木瓜的适宜保存温度在7℃左右；荔枝在7℃至10℃的条件下可以保存一周，放进冰箱则可保存一个月左右；剥开的菠萝蜜用保鲜膜封好后放进冰箱，也可阻止水分蒸发，但最好不超过3天。</p>\r\n', '0', '3', '2015-08-13 20:11:17', '3', null, null, '0', null, null);
INSERT INTO `t_group_topic` VALUES ('upload/ckeditor/2015/08/13/0eb9cd72-78f7-4648-8304-5e2d0655518a.png', '60', '让米饭营养口味俱佳的技巧', '0', '23', '8', '<p><img alt=\"\" src=\"http://localhost:8080/anjilang/upload/ckeditor/2015/08/13/0eb9cd72-78f7-4648-8304-5e2d0655518a.png\" style=\"height:207px; width:335px\" /></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>　酷夏时节，天气闷热潮湿，很多人都出现了身体不适等症状。很多人都会出面对饭菜没有胃口。其实你可以在做米饭上下点功夫哦，快来看看我给大家介绍的几个法宝哦。</p>\r\n\r\n<p>　　法 宝一：凉水轻搓。淘米时不要用流水或热水淘洗。大米里含有多种营养物质，容易溶于水，如果淘米时间过长、次数过多并且使劲搓洗米，会让大米表层营养丢失。 此外，有些人为了煮出口感软糯的米，煮饭前会长时间浸泡。如果米泡发时间过长，其中的营养成分就会大量损失。实验证明，在常温下将米浸泡1小时后再蒸煮， 米饭中的碳水化合物水解率会增加，加速糊化，进入人体后升高血糖的速度更快，不利于健康。</p>\r\n\r\n<p>　　法宝二：米水比例适当。蒸米饭时水少了太硬，水 多了过软。实验证明，水越少，升血糖速度越慢，但口感欠佳。陈米和新米用水量也有区别，新米、水比例为1:1.5时，陈米、水比例为1:1.8时，能让大 米淀粉达到充分糊化，口感最好。但需要注意的是，米饭里如果加了高粱、小米、绿豆、玉米糁等粗粮，要适当多放些水，因为粗粮比细粮&ldquo;吃水&rdquo;。</p>\r\n\r\n<p>　　法宝三：蒸前加醋。在蒸米饭时，按1.5千克大米加2～3毫升醋的比例放些食醋，可使米饭易于存放和防馊，做出的米饭香味更浓。</p>\r\n\r\n<p>　　法宝四：茶水蒸饭。用茶水蒸米饭，可使米饭色、香、营养俱佳，并有去腻、洁口、化食的好处。具体做法：先将茶叶1～3克，用200~300克开水浸泡4～9分钟，滤去茶渣，将茶水和米倒入锅中，使茶水高出米约3厘米，煮熟即可食用。</p>\r\n\r\n<p>　　法 宝五：蒸前加油。蒸米饭时添加一小勺稻米油，会让煮熟的米饭晶莹松软、口感更佳。特别会让陈米的口感和米油感更好。经过现代精加工，米皮和米胚被除 去，64%的营养白白流失。稻米油是从米皮和米胚当中提取的，极大地保存了稻米油中的营养成分(如谷维素、植物甾醇和维生素E等)。研究人员做了大量实验 发现，谷维素可以安神助眠，有助于在酷夏时节，让人补充精力，安然入睡。</p>\r\n\r\n<p>　　以上介绍的五个法宝，都是让你的米饭更加有味道的小窍门哦。在你胃口不好的时候，大家可以试试看哦。</p>\r\n', '0', '26', '2015-08-13 20:12:15', '3', null, null, '0', '1', '2015-08-13 20:22:36');
INSERT INTO `t_group_topic` VALUES ('upload/ckeditor/2015/08/13/8f6df231-a51d-422e-b65d-9e64e4d97f9f.png', '61', '如何健康食用冰淇淋', '0', '23', '8', '<p>夏天天气炎热，美味的冰淇淋让很多人都完全把持不住，但是又担心热量摄入太高会发胖，欲尝又止，很是矛盾。冰淇淋到底怎么吃才健康？吃的时候有哪些禁忌？现在就让小编一次全告诉你吧！<img alt=\"\" src=\"http://localhost:8080/anjilang/upload/ckeditor/2015/08/13/8f6df231-a51d-422e-b65d-9e64e4d97f9f.png\" style=\"height:318px; width:500px\" /></p>\r\n', '0', '7', '2015-08-13 20:13:57', '3', null, null, '0', '3', '2015-08-13 20:21:29');
INSERT INTO `t_group_topic` VALUES ('upload/ckeditor/2015/08/13/2fc34c43-4526-4eeb-a470-5039dc73af45.png', '62', '营养课堂：降低胆固醇的十种办法', '0', '23', '8', '<p>令人担忧的事实是,很多我们喜欢的食物都含有最不利于身体健康的脂肪&mdash;&mdash;饱和脂肪。这种脂肪主要来自动物，会转化为胆固醇，阻塞动脉，导致心脏病。<img alt=\"\" src=\"http://localhost:8080/anjilang/upload/ckeditor/2015/08/13/2fc34c43-4526-4eeb-a470-5039dc73af45.png\" style=\"height:491px; width:600px\" /></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>以下是十种降低胆固醇的办法：</p>\r\n\r\n<p>　　1.少摄入饱和脂肪</p>\r\n\r\n<p>　　饱和脂肪会增加血液中的胆固醇。而羊排、牛排、猪肉和家禽中含有大部分的饱和脂肪。即使是瘦肉也包含了大量&mdash;&mdash;尤其是集中饲养的动物。你可以挑除所有可见的脂肪，但是要想整体降低脂肪含量，就要选择有机肉类和家禽。这些饱和脂肪你看不到并不意味着不存在，几乎所有的肉类产品有非常高的饱和脂肪，比如香肠、馅饼、苏格兰鸡蛋、肉馅饼、汉堡等。猪油、烤油、黄油和奶酪也含有大量饱和脂肪。不要忘记,奶制品是钙的主要来源。当心椰子和棕榈油, 它们饱和脂肪高，且广泛用于食品加工。当然，还有,丹麦糕点,羊角面包和许多其他面包店产品也都富含饱和脂肪。</p>\r\n\r\n<p>　　2.多吃单一不饱和脂肪</p>\r\n\r\n<p>　　橄榄、核桃、油菜籽油和牛油果中含有单一不饱和脂肪。这些脂肪减少低密度脂蛋白胆固醇水平，不会影响高密度脂蛋白的数量。</p>\r\n\r\n<p>　　3. 适当食用多不饱和脂肪</p>\r\n', '2', '12', '2015-08-13 20:15:43', '3', null, null, '0', '3', '2015-08-13 20:21:15');
INSERT INTO `t_group_topic` VALUES ('upload/ckeditor/2015/08/13/f0d999be-dbb8-45db-87a1-e6cdab53fdb9.png', '63', '营养课堂：这几种蔬菜可增强你的免疫力', '0', '23', '8', '<p>在饮食中添加能提高免疫力的蔬菜是最重要的生活方式之一。食用蔬菜能够对你的健康带来好处，减少患慢性疾病的风险，如心脏病和某些癌症。</p>\r\n\r\n<p>　　蔬菜不仅让你身体健康，还能保持良好的状态。当你从蔬菜中获得充足的营养,你的头发,皮肤,眼睛都显示出健康的迹象。</p>\r\n\r\n<p>　　不要再犹豫了，在你的盘子里添加(至少两个)以下的蔬菜吧:</p>\r\n\r\n<p><br />\r\n<img alt=\"\" src=\"http://localhost:8080/anjilang/upload/ckeditor/2015/08/13/f0d999be-dbb8-45db-87a1-e6cdab53fdb9.png\" style=\"height:491px; width:600px\" /></p>\r\n', '0', '19', '2015-08-13 20:17:13', '3', null, null, '0', '3', '2015-08-13 20:21:06');
INSERT INTO `t_group_topic` VALUES ('upload/ckeditor/2015/08/13/54027201-cc3d-4fbb-9f66-5bb3131e2f63.png', '64', '营养课堂：用橄榄油烹饪真的危险吗?', '0', '23', '8', '<p>你可能已经听说过，橄榄油作为调料有益健康，但用于煎或烤这样的高温烹饪来说，就有害了。也许你也听说，橄榄油遇到高温，就会生成危险的有毒物质，因为这样的实例也有不少。</p>\r\n\r\n<p>　　那么，你猜怎么着：用橄榄油烹饪其实是完全安全的。在纽约市西奈山贝斯以色列的临床营养学主任和注册营养师丽贝卡&middot;布莱克说：&ldquo;现在并没有证据表明, 用橄榄油进行高温烹饪是不健康的。&rdquo;</p>\r\n\r\n<p>　　无独有偶，最近的一些研究也发现，相较于向日葵、玉米和大豆等植物油而言，橄榄油更加耐热。的确，所有植物油一旦加热，就会分解，失去口味，损失营养，还可能会生成有害物质。但是橄榄油具有抗氧化剂，可以抵抗这些热量带来的变化。<img alt=\"\" src=\"http://localhost:8080/anjilang/upload/ckeditor/2015/08/13/54027201-cc3d-4fbb-9f66-5bb3131e2f63.png\" style=\"height:491px; width:600px\" /></p>\r\n', '0', '11', '2015-08-13 20:18:16', '3', null, null, '0', '1', '2015-08-13 20:20:54');
INSERT INTO `t_group_topic` VALUES ('upload/ckeditor/2015/08/13/c7253398-3091-4864-a161-6ef760bb12df.png', '65', '营养课堂：长寿食物集锦', '0', '23', '8', '<p>节食能减少摄入的热量被证明能降低胆固醇和糖尿病风险,甚至研究表明，节食还能延长人类和动物的寿命。最新发表在《细胞》杂志上的研究,表明以上这些即使不节食也可以实现。而秘密就是:低蛋白、高碳水化合物的饮食。</p>\r\n\r\n<p>　　悉尼大学的教授斯蒂芬&middot;辛普森说&ldquo;以低蛋白、高碳水化合物的为饮食的老鼠，其摄入的热量降低了40%。研究人员认为，这种饮食习惯更加健康、实用。<img alt=\"\" src=\"http://localhost:8080/anjilang/upload/ckeditor/2015/08/13/c7253398-3091-4864-a161-6ef760bb12df.png\" style=\"height:343px; width:500px\" /></p>\r\n', '1', '17', '2015-08-13 20:19:16', '3', null, null, '0', '4', '2015-08-13 20:22:55');
INSERT INTO `t_group_topic` VALUES ('upload/ckeditor/2015/08/13/2b2e7445-3f9d-4f27-8b8c-7a174604cb08.png', '66', '营养课堂：长寿食物集锦', '0', '23', '8', '<p>节食能减少摄入的热量被证明能降低胆固醇和糖尿病风险,甚至研究表明，节食还能延长人类和动物的寿命。最新发表在《细胞》杂志上的研究,表明以上这些即使不节食也可以实现。而秘密就是:低蛋白、高碳水化合物的饮食。</p>\r\n\r\n<p>　　悉尼大学的教授斯蒂芬&middot;辛普森说&ldquo;以低蛋白、高碳水化合物的为饮食的老鼠，其摄入的热量降低了40%。研究人员认为，这种饮食习惯更加健康、实用。</p>\r\n\r\n<p>　　好消息是,整天以碳水化合物为食的动物的新陈代谢明显高于节食的动物。如果该研究的结果放到人类身上，则意味着人类可以享用高蛋白质含量和碳水化合物的食物。以下是能帮助减肥的碳水化合物食物。<img alt=\"\" src=\"http://localhost:8080/anjilang/upload/ckeditor/2015/08/13/2b2e7445-3f9d-4f27-8b8c-7a174604cb08.png\" style=\"height:491px; width:600px\" /></p>\r\n', '4', '497', '2015-08-13 20:20:09', '3', null, null, '2', '4', '2015-08-13 20:22:46');

-- ----------------------------
-- Table structure for `t_group_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_group_user`;
CREATE TABLE `t_group_user` (
  `groupid` int(10) NOT NULL COMMENT '小组id',
  `userid` int(10) NOT NULL COMMENT '用户id',
  `ismember` tinyint(1) DEFAULT '0' COMMENT '0-退出1-加入2-提升管理员',
  `adminid` int(10) DEFAULT NULL COMMENT '管理员id',
  `jointime` timestamp NULL DEFAULT NULL COMMENT '加入时间',
  `quittime` timestamp NULL DEFAULT NULL COMMENT '退出时间',
  PRIMARY KEY (`groupid`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_group_user
-- ----------------------------
INSERT INTO `t_group_user` VALUES ('12', '7', '1', null, null, null);
INSERT INTO `t_group_user` VALUES ('12', '10', '1', null, null, null);
INSERT INTO `t_group_user` VALUES ('12', '19', '1', null, null, null);
INSERT INTO `t_group_user` VALUES ('14', '7', '1', null, null, null);
INSERT INTO `t_group_user` VALUES ('15', '3', '1', null, null, null);
INSERT INTO `t_group_user` VALUES ('15', '19', '1', null, null, null);
INSERT INTO `t_group_user` VALUES ('18', '3', '0', '7', null, null);
INSERT INTO `t_group_user` VALUES ('18', '4', '1', null, null, null);
INSERT INTO `t_group_user` VALUES ('23', '3', '2', null, '2015-08-11 15:35:11', null);
INSERT INTO `t_group_user` VALUES ('23', '8', '0', '7', null, null);
INSERT INTO `t_group_user` VALUES ('23', '10', '1', null, null, null);
INSERT INTO `t_group_user` VALUES ('23', '19', '1', null, null, null);
INSERT INTO `t_group_user` VALUES ('23', '20', '2', null, null, null);
INSERT INTO `t_group_user` VALUES ('23', '21', '2', null, null, null);
INSERT INTO `t_group_user` VALUES ('23', '22', '2', null, null, null);
INSERT INTO `t_group_user` VALUES ('23', '23', '1', null, null, null);
INSERT INTO `t_group_user` VALUES ('23', '24', '1', null, null, null);
INSERT INTO `t_group_user` VALUES ('23', '25', '1', '7', null, null);
INSERT INTO `t_group_user` VALUES ('23', '26', '2', null, null, null);
INSERT INTO `t_group_user` VALUES ('23', '27', '1', null, null, null);
INSERT INTO `t_group_user` VALUES ('23', '28', '1', null, null, null);
INSERT INTO `t_group_user` VALUES ('23', '29', '1', null, null, null);
INSERT INTO `t_group_user` VALUES ('23', '30', '1', null, null, null);
INSERT INTO `t_group_user` VALUES ('23', '63', '1', null, '2015-08-10 15:13:16', null);
INSERT INTO `t_group_user` VALUES ('23', '83', '1', null, '2015-08-20 10:10:09', null);

-- ----------------------------
-- Table structure for `t_information`
-- ----------------------------
DROP TABLE IF EXISTS `t_information`;
CREATE TABLE `t_information` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` text,
  `crTime` varchar(255) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_information
-- ----------------------------
INSERT INTO `t_information` VALUES ('26', '<p>&nbsp;卫生部长陈竺提出，未来医生必须会开两张处方：一张是针对病情开具的药方；另一张是膳食营养处方。未来的医生必须具备营养学的知识，针对慢性病，特别要发挥营养治疗的作用。将来，让我们的健康取决于每一天均衡的营养，营养保健食品是时代的需求，也是必然的产物。营养治疗将是解决慢性疾病的关键！<br />\r\n<br />\r\n一、慢性病的发展<br />\r\n<br />\r\n如今，慢性病以井喷态势发展，感冒、咳嗽都不算病，只要一病就是危重疾病，甚至是绝症。尤其，以肥胖、癌症、高血糖、高血压、高血脂等为首的非传染性慢性疾病，快速在中国蔓延。除意外事故外，慢性病致死占总死亡率的80%以上。<br />\r\n<br />\r\n2010年，我国糖尿病患者高达9400万；每年有300万人死于心脑血管疾病；每年癌症的发病人数约为200万，死于癌症的人数超过140万；全国血脂异常患者已达1.6亿人，超过1.25亿的肥胖症患者，3.5亿人超重和肥胖人群，1.6亿人患高血压。目前，中国正进入慢性病的高发期，也是慢性病的重灾区，未来10年约有8000万中国人将死于慢性疾病。<br />\r\n<br />\r\n二、慢性病的特点<br />\r\n<br />\r\n冰冻三尺非一日之寒，其实，慢性病的潜伏期非常长，如果我们稍加注意一下身体发出的信号，就能够做到早发现、早预防、早理疗。因为慢性病的特点是可防、可控、不可根治。一旦得了慢性病，则不可根治，且终生携带，其并发症、死亡率、致死率极高，治愈率极低。<br />\r\n<br />\r\n2010年，我国平均每人输液8瓶，远远高于国际2.5-3.3瓶的水平。我国因慢性病一次住院要花掉城镇居民人均年收入50%以上，是农村居民人均年收入的1.5倍，仅慢性病的医疗费用的增长，已超过国民经济和居民收入增长的速度。即便如此，也不能控制疾病高发的趋势。<br />\r\n<br />\r\n三、预防重于治疗<br />\r\n<br />\r\n西医对待疾病，在于对症状的控制，例如：得了高血压用降压药，得了高血糖用降糖药，这样是绝对根治不了疾病的；中医对待疾病，在于调理疾病；而营养的目的是修复细胞，将疾病扼杀在萌芽中。<br />\r\n<br />\r\n据统计，中国亚健康人群已突破10亿，而且，数字还在不断扩大。亚健康就是疾病的潜伏阶段，往往正是因为亚健康得不到应有的重视，再加上，中国人向来习惯，将攒下来的钱，留给生命最后三个月抢救使用。假如将医疗投入的80%提前10年用于营养保健，相信每个人可以健康地多活十年。<br />\r\n<br />\r\n中国老龄社会的到来，逐年加大的医疗投入，换来的只是&ldquo;带病增寿&rdquo;，并不是真正意义上的健康长寿。我国心脑血管专家洪昭光教授在接受记者采访时表示，&ldquo;如果一个人能活80岁，却有30年躺在病床上，简直就是受罪。在保健方面1元钱的投入，可以节省8.59元的医疗费，同时，节省100元的急救费。&rdquo;<br />\r\n<br />\r\n四、发挥膳食营养治疗的作用<br />\r\n<br />\r\n自古即有&ldquo;医食同根、药食同源&rdquo;之说，但营养是把&ldquo;双刃剑&rdquo;，多则增加代谢负担，少则影响健康，因此，营养供给和营养治疗贵在合理、平衡。未来，每一天均衡的营养决定着我们的健康，营养膳食是时代的需求，也是必然的产物。<br />\r\n<br />\r\n如果把健康比作一条河，那么，得了疾病就如同这条河流的水被污染了。治疗医学的办法是在下游打捞垃圾；营养保健的作用是在上游控制污染源头。治病是&ldquo;亡羊补牢&rdquo;，通过膳食营养来养生保健是&ldquo;未雨绸缪&rdquo;。你说哪个成本更高？效果更好呢？&nbsp;</p>\r\n', '2015-01-20 01:17:30', '78', '且“吃”且预防,营养膳食预防慢性病', '8', '1');
INSERT INTO `t_information` VALUES ('27', '<p><strong>解放军301部队总医院正式启动亚健康门诊，功能性保健食品登录三甲医院，医生开方手册全部采用营养保健产品。</strong>医院实施亚健康病人、重病患者辅助治疗及病后康复治疗等项目。医院已经把增强机体免疫力，防治治病，提高人体健康素质纳入到保健治疗规划中。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>在国家十二五规划首次将营养与保健产业列为重点发展产业后，解放军301部队总医院亚健康门诊的启动预示着我国医疗理念的一次大变革。&ldquo;营养治病&rdquo;已时代来临，并将逐步融入世界医疗大格局。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>营养治病，对我国人来说还是一个比较陌生的概念。几乎所有的人都可能认为疾病只有用药物去理疗，营养怎么可能被用来治病呢？其实，真正能让身体康复的绝对不是药物，因为药物的成分不是细胞修复所需要的成分。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>一、营养是生命的源泉</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>那让我们来看这样一个事实：如果一个健康的人7&mdash;10天不吃任何食物，不喝水，你说会发生什么事情？人用来维持生命的主要东西除了空气和水以外就是食物，也就是食物里面的营养给予了人的生命。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>营养是生命的源泉，从人的胚胎形成的一瞬间到人的生命结束，营养无时无刻不滋养着人的生命，这就是&ldquo;营养与生命&rdquo;。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>二、药物控制疾病</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>看看我们身边那些身患疾病的人：高血压、心脑血管疾病、糖尿病、痛风、乙肝、脂肪肝、甲亢、关节炎、胃炎、严重失眠、癌症等，面对这一大堆常见慢性病，通过药物可以将疾病治愈？其实药物顶多就是将慢性病症控制在一定范围内，能做到这一点已经算不错了。药物不能成为构成细胞的物质，也就无法帮助修补受损的组织，药物只能起到控制疾病的作用。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>三、营养修复细胞</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>所有人身上的细胞在经过六个月左右的时间，大部分细胞组织都会被更新90%，产生新的组织。胃细胞7天更新一次；皮肤细胞28天左右更新一次；肝脏细胞在180天更换一次；红血球细胞120天更新一次；在一年左右的时间，身体98%的细胞都会被重新更新一遍。只要营养充足，受损的器官通过细胞的不断&ldquo;新陈代谢&rdquo;和&ldquo;自我修复&rdquo;，经过一段时间，受损的组织和器官就会被&ldquo;软性置换&rdquo;，产生出&ldquo;新&rdquo;的组织与器官。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>营养是人的生命三大体系&ldquo;新生细胞体系、滋养细胞体系和修复细胞体系&rdquo;的原材料。当人体任何部位受损需要修复，如果修复的&ldquo;材料&rdquo;不足，也就是营养素有所欠缺，那么修复工作就会受阻，就会将伤害留给我们。如：</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>新生细胞不好，会加速器官衰老、萎缩、功能下降。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>滋养细胞不好，轻则容易疲劳，重则会导致人体的免疫能力下降，虚弱宜病。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>修复细胞不好，受损的细胞得不到及时修复，经过一段时间的积累，就会在某一个器官或组织上产生病变，直接危害人体的健康和生命。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>四、营养是一切健康因素的物质基础</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>食物的质量决定了营养的质量，营养的质量决定了细胞的质量，细胞的质量决定了器官的质量，器官的质量决定了人的生命和健康的质量。营养是一切健康因素的物质基础。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>营养治疗，通过一系列治疗性膳食，定向性补充身体的各种所需元素，充足与均衡的给予营养素，让人的生命三大体系处于最佳状态，排除体内毒素、调理五大系统、提高人体自身免疫力，解除形成疾病的因素，重获健康。</p>\r\n', '2015-01-20 02:18:55', '787', '“营养治病”抢先看！', '8', '2');
INSERT INTO `t_information` VALUES ('28', '<p>每一天我们都被新式超级节食法以及新的瘦身风尚轮番轰炸，一些食品据说能帮助我们减重，还有一些则是热量极高。然而减肥仍是极其难以达成的一件事。每年都有千百万人尝试瘦身，并以失败告终。到底怎样才有效呢？我们要遵循科学规律，BBC告诉我们关于减肥应该知道的十件事情。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>1.</strong><strong>不要跳过正常三餐</strong></p>\r\n\r\n<p>当我们饿得时候，胃会变小，大脑会潜意识的发出寻找吃的东西的信号。特别是这种情况下大脑会对高脂肪，高热量的食物作出强烈的反应。这种信号是本能的，基本上不是靠意志力能对抗的。因此不要错过正常三餐，否则可能会吃掉更多食物哦。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>2.</strong><strong>用小碗，吃的少</strong></p>\r\n\r\n<p>实验表明，只要面前有吃的，人就会倾向于继续吃（用看电影时爆米花桶的大小做的实验）。因此很多时候我们已经吃饱了，但是因为面前的碗碟里面还有食物，我们就会继续吃。用小号碗碟可以一定程度的杜绝这种情况。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>3.</strong><strong>调整自己的饮食结构</strong></p>\r\n\r\n<p>这个就是老生常谈的热量问题。每天吃东西的时候尽量选择低热量的食物组合。普通人一天消耗2000千焦热量，每天摄入的多就堆积脂肪，每天摄入的比这个少就消耗脂肪。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>4.</strong><strong>不要想着去怪自己的新陈代谢</strong></p>\r\n\r\n<p>基本上每个人新陈代谢都差不多，胖了说明吃的比需要的多。而且，一般情况下，我们只能记得我们每天摄取的50%的热量。很多时候我们没有意识到我们吃了什么有热量的东西（比如喝了甜饮料、吃了一块曲奇等等）。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>5.</strong><strong>多吃高蛋白质的食物</strong></p>\r\n\r\n<p>蛋白质含量高的食物，比如肉、蛋等，会延长人的饱胀感。因此就饿得慢，不会再还没到点吃饭就到处搜刮零食。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>6.</strong><strong>流食能延长饱胀感</strong></p>\r\n\r\n<p>实验是同样的鸡肉土豆米饭和水，一组人干吃，另一组人把上述材料在搅拌机打成糊状去吃，结果吃流食的那组人饿得慢。因为吃固体食物水会直接流过胃，然后胃里东西就少了。而流食中的水分不会直接流过胃，因此造成胃更有饱胀感。因此，多喝汤，多吃流食，延长食物消化时间。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>7.</strong><strong>选择越多，吃得越多</strong></p>\r\n\r\n<p>可以吃的东西越多，大脑就容易发出吃更多的信号。比如食堂只有土豆丝盖浇饭的时候也许我们会吃得很少。但是如果食堂是自助形式有很多种菜可以选，那我们可能会拿更多的食物来吃。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>8.</strong><strong>低脂肪奶制品能让你排出更多额外脂肪</strong></p>\r\n\r\n<p>低脂肪奶制品在胃里会和同时摄入的食物中的脂肪结合，而这种合成物不能被消化，因此会直接经过消化系统排出体外。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>9.</strong><strong>运动后身体会持续消耗脂肪</strong></p>\r\n\r\n<p>我们运动锻炼的时候身体消耗的脂肪比我们想象的要少，因为这时身体主要消耗的是碳水化合物。但是运动后由于消耗了大量碳水化合物，在我们说话、呼吸、睡觉的时候，身体仍在默默燃烧脂肪。因此运动的好处大大的！</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>10.</strong><strong>改变生活习惯</strong></p>\r\n\r\n<p>改变生活习惯，少坐车多走路，少坐着多站着，能动着就别停下来，这样一天下来也能消耗很多热量。</p>\r\n\r\n<p>&nbsp;</p>\r\n', '2015-01-20 02:23:37', '99', 'BBC告诉你，关于减肥你应该知道的十件事', '8', '3');
INSERT INTO `t_information` VALUES ('29', '<p>生活中，很多人相信&ldquo;眼见为实&rdquo;。然而，这一原则在营养领域却不一定适用。你所看到的，甚至你所感受到的未必是事实真相。本期，我帮大家总结一下那些最易迷惑人的营养误区。</p>\r\n\r\n<p>　　</p>\r\n\r\n<p><strong>瘦肉里不含脂肪</strong></p>\r\n\r\n<p>很多人因为担心肥胖或高血脂而放弃&ldquo;肥肉&rdquo;选择&ldquo;瘦肉&rdquo;，在他们眼中，瘦肉不含脂肪，可以毫无顾忌地大快朵颐。事实上，餐桌上的脂肪可以分为显性脂肪和隐性脂肪。而瘦肉中所含的脂肪，属于隐性脂肪。瘦肉中脂肪含量有极大的差异，一般在0.4%~30%之间变动。这是因为，动物肌肉中的脂肪含量因动物品种、部位、年龄的不同有很大差异。比如，根据《中国食物成分表》，纯瘦猪肉的脂肪含量为6.2%。</p>\r\n\r\n<p>　　</p>\r\n\r\n<p><strong>有&ldquo;筋&rdquo;的菜才有膳食纤维</strong></p>\r\n\r\n<p>说到富含膳食纤维的食物，人们往往首先会想到芹菜茎、白菜帮子，这些富含菜筋、口感比较粗糙的食物。其实，每个植物细胞都有细胞壁，而细胞壁的主要成分就是纤维素、半纤维素和果胶，它们都属于膳食纤维。蔬菜筋并非蔬菜中纤维的唯一来源，而没有筋的食物很可能纤维含量更高。比如说，红薯和毛豆中不含筋，但它们的膳食纤维含量远高于有筋的大白菜。</p>\r\n\r\n<p>　　</p>\r\n\r\n<p><strong>没有咸味的食品不含盐</strong></p>\r\n\r\n<p>很多人认为，少吃盐就是少吃有咸味的食物。然而，盐的成分是氯化钠，除此之外，钠还有各种化合形式。有许多食品吃起来不咸，其实却加了不少钠或盐，如白面包、蛋糕、饼干、果冻等。腌肉、香肠、咸鱼等加工食品含盐更多。因此，购买加工食品时要注意看标签，尽量选择钠含量低的。</p>\r\n\r\n<p>　　</p>\r\n\r\n<p><strong>不甜的水果含糖量少</strong></p>\r\n\r\n<p>提到&ldquo;糖&rdquo;，人们往往将其与&ldquo;甜&rdquo;挂钩。然而，判断水果里&ldquo;糖&rdquo;有多少，光靠口感是不靠谱的。因为甜度不但与含糖量高低有关，还与糖的种类（例如果糖比蔗糖甜）、酸味有关。有些吃起来不甜的水果，比如火龙果和猕猴桃，口感偏酸，但数据显示，每100克火龙果中含有碳水化合物13.3克，每100克猕猴桃中含有碳水化合物14.5克。按碳水化合物总量计算，这两种水果都算得上真正的&ldquo;高糖&rdquo;食物。此外，含糖量较高的水果还包括苹果、杏、无花果、橙子、柚子、荔枝、柿子、桂圆、香蕉、杨梅等。</p>\r\n\r\n<p>　　</p>\r\n\r\n<p><strong>奶白色的汤更有营养</strong></p>\r\n\r\n<p>不少人认为，白色就是蛋白质，因此奶白色的汤是最有营养的，而事实却并非如此。奶白色只是脂肪微滴均匀地分布在水中，形成的一种乳化现象。一般来说，脂肪含量越高，汤汁越容易熬煮成奶白色。而是否能煮成奶汤，和汤的营养价值是没有多大关系的。</p>\r\n\r\n<p>　　</p>\r\n\r\n<p><strong>食物掉色，肯定是被染色了</strong></p>\r\n\r\n<p>洗黑米或桑葚时水变黑，是不是因为被染色了呢？其实，食物掉色是种很常见的现象，它主要由食物中色素溶解引起的。黑米、紫米、黑花生、黑玉米、黑大豆、桑葚、紫薯、紫甘蓝、蓝莓等食物中均含有丰富的水溶性色素&mdash;&mdash;花青素。因此，这些紫黑色食物遇水掉色，并不一定说明是被染色，很可能是其天然的颜色。</p>\r\n', '2015-01-20 02:25:11', '88', '不甜的水果含糖真的少吗？', '8', '4');
INSERT INTO `t_information` VALUES ('30', '<p><strong>一、高能量膳食</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>1、适用对象，各种因素导致机体能量消耗增加的人，如体重不足、结核病、甲状腺功能亢进、癌症及严重烧伤和创伤的病人，还包括运动员、重体力劳动者等。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>2、配置原则，尽可能增加主食及菜量；除正餐外，可加两次点心。膳食应有足量的碳水化合物、蛋白质，适量的脂肪，同时也需要相应增加矿物质和维生素的供给，尤其是与能量代谢密切相关的维生素B1、B2和烟酸。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>二、低能量膳食</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>1、适用对象，需减轻体重的病人，或为了控制病情减少机体代谢的负担，如单纯性肥胖病、肥胖型糖尿病患者。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>2、配置原则。供给足够的必需营养素的同时是当地逐步减少能量供给，目的在于分解体内过多的脂肪。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>三、高蛋白膳食</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>1、适用对象，营养不良、手术前后、贫血、癌症及烧伤病人等。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>2、配置原则，采用富有动物性蛋白质的食物；可在正餐中加一个全荤菜；碳水化合物宜适当增加，以保证蛋白质的充分利用；高蛋白膳食会增加尿钙的排出，长期摄入此类食物，易出现负钙平衡，因此应增加钙的供给量。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>四、低蛋白膳食</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>1、适用对象，急性肾炎尿毒症及肝功能衰竭者。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>2、配置原则，在蛋白质定量范围内尽量选用优质蛋白；供给充足的蔬菜和水果；尽量降低杂豆的摄入量以减少植物性蛋白的来源。</p>\r\n\r\n<p>。</p>\r\n\r\n<p><strong>五、少盐膳食</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>1、适用对象，适用于心、肾浮肿，肝硬化腹水，高血压等。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>2、配置原则，每日食盐量不超过2~3g；禁用一切用盐腌制的食物，如咸蛋、腊肠、酱菜等；为调剂口味，可用糖醋烹饪。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>六、低脂膳食</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>1、适用对象，用于胆囊、胆道、肝、胰腺疾病及腹泻病人。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>2、配置原则，禁用油炸食品、肥肉、猪油及含脂肪多的点心；烹饪可用蒸、煮、炖等。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>七、少渣膳食</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>1、适用对象，腹泻、肠炎、咽喉部及消化道手术，伤寒、痢疾及溃疡病恢复期等病人，肝硬化患者，如有食管粘膜、下肢静脉曲张和胃底静脉曲张淤血，应防止由于食物粗糙、坚硬而诱发出血。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>2、配置原则，食物需质地柔软，少渣，便于咀嚼和吞咽，尽量少用富含膳食纤维的食物；富含脂肪的食物不宜选用过多；这种膳食不宜长期食用，适当加用果汁、番茄汁等已补充维生素C；禁用刺激性强的调味品。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>八、高纤维膳食</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>1、适用对象，无蠕动能力的便秘，或误食异物需刺激肠道蠕动，使异物排出；对冠心病、高脂血症、高胆固醇血症、糖尿病等病人均提倡用高膳食纤维。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>2、配置原则，采用纤维多的食物，如芹菜、黄豆牙、薯类、水果、粗粮；清早饮水，可刺激肠道蠕动；蜂蜜、果酱、豆类等产气食物能刺激肠道蠕动。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>九、低胆固醇膳食</strong></p>\r\n\r\n<p>1、适用对象，高胆固醇血症、高脂蛋白血症、高血压、动脉粥样硬化、冠心病等。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>2、配置原则，每日胆固醇限制在300mg一下；牛奶、鸡蛋、瘦肉等可少量选用，对含胆固醇高的食物如动物内脏、蛋黄、鱼籽等尽量少用；不用肥肉和动物油。</p>\r\n', '2015-01-20 02:26:14', '98', '治疗膳食配置，您了解多少？', '8', '5');
INSERT INTO `t_information` VALUES ('31', '<h1><strong>冬</strong>日里怎样吃出暖意？这是很多人都在讨论的饮食话题。大部分人的答案无非两个类型：吃高热量的食物就能暖身！或者是，吃传统所说的&ldquo;温热食物&rdquo;就能暖身！这两个说法，哪个更正确呢？</h1>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>答案是，吃高热量的食品，不等于就能让身上暖起来。吃猪油，吃蛋糕，吃曲奇，吃油炸食品&hellip;&hellip;这些对于提高抗寒能力基本上没什么帮助。而吃传统认为&ldquo;温热&rdquo;的食物，相对而言更有效一些，不过也不一定是长久之计，而且要看身体状态和食物搭配是否合适。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>先来解释第一个问题，为什么高热量不等于高温暖？</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>为了解释方便，我们要把人体看成一个供暖工厂。这个工厂的燃料就是食物当中含热量的成分，比如脂肪、淀粉和糖；工厂的燃烧锅炉，就是人体细胞中的线粒体；工厂的产品，就是大量放出来的能量，包括让身体温暖的热量，还有能推动我们的血液循环、细胞更新、组织修复、工作学习等各种事情所需的化学能量。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>吃大量的高热量食品，实际上就是给这个工厂送来很多燃料。问题是，这些燃料堆积如山，也不一定能够顺利、高效地燃烧，让锅炉充分放出热量。假如人体细胞当中的&ldquo;锅炉&rdquo;太少，或者进料的管道出了问题，或者是工厂指挥系统干脆下达指令，要求降低供热总量，那么，就算有足够的燃料，产出的热量还是不能满足需要。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>那么，谁是锅炉呢？刚才说了，就是细胞中的线粒体。肌肉细胞中线粒体多得密密麻麻，所以一个人身上的肌肉越多，越充实发达，细胞中的线粒体总量就越大。而脂肪比例越大，线粒体总量就越少，因为脂肪细胞中含有大量油脂，线粒体却少得可怜。这样一说就能明白，肌肉多的人产热能力强，而脂肪比例高的人产热能力差。运动后能发热，正是因为肌肉中的&ldquo;锅炉&rdquo;们加大力度工作的缘故。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>这就可以解释，为什么运动员们不怕冷，练健美的人冬天也穿得很单薄；而很多胖人虽然有厚厚的脂肪层来保温，仍然不比其他人更抗冻。这是因为，冰块就算是盖一层大棉袄，仍然是冰块。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>那些又缺脂肪，肌肉又少，皮包骨头的瘦人，自然就是最不抗冷的人了。他们所要做的事情，并不是喝甜饮料吃大肥肉，而是在补充富含蛋白质食物和主食的同时，切实做些增肌运动。好好健身，充实肌肉，增加自己的&ldquo;锅炉&rdquo;数量，才能壮起来，也暖起来。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>如果人体中的&ldquo;锅炉&rdquo;太少，需要的燃料自然也就比较少。一旦多来点燃料，很容易堆积成患，也就是说，很容易因为消耗不掉，转变成身体上的脂肪，造成肥胖。所以，肌肉不发达的人更容易胖，而肌肉充实发达的人，多吃也不会胖，因为吃进去的食物会高效地消耗掉，一方面变成身体的力量，让人精神抖擞；一方面支持体表的散热，让人身体温暖，而并不会变成脂肪堆积成灾。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>好了，下面就来说说那些传统所谓&ldquo;温热&rdquo;的食物。它们是怎样让人感觉到温暖的呢？</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>所谓热性或温性的食物，是古代传下来的说法，在某种意义上，就是使人们身体感觉更温暖的食品。古人的说法一点都不抽象，是极端具象、容易理解的。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>虽然没有足够的研究证据，但可以根据现有的知识来推断它们的作用。比如说，某些食物有利于促进消化吸收，消化吸收好了，同样的食物就能得到更多的微量元素和维生素，从而间接促进新陈代谢。也就是说，它们让供暖工厂的设备得到良好的维护和润滑，运输高效，管线畅通，这样供暖效率就会提高。比如说，消化不良的人容易发生贫血缺锌问题，而贫血缺锌都会造成人体怕冷。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>也有的食物成分能帮助保障促进生物氧化的激素水平，就是领导给供暖工厂发布指令，要求保证产能，自然供暖工作也会受到重视而加大力度。比如说，缺乏碘的时候，人体甲状腺激素水平过低，就容易体温偏低，身体怕冷。也有动物实验证明，钙不足的时候，脂肪合成会增加，产热能力下降，也会妨碍抗寒能力。所以，吃一些钙含量高的乳制品也可能对暖身有所帮助。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>有些食物虽然本身不生热，但能帮助补充血红蛋白，或者改善血液循环，也能帮助暖身。这是因为没有足够的氧气，锅炉就不能熊熊燃烧，而氧气是靠血液来输送的，体表散热也靠血液来传递温度。比如辣椒等香辛料，能让氧气和葡萄糖的运输速度加快，体表散热的速度加快，也能让身体暂时感觉温暖，等等。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>人体生理学知识告诉我们，血液循环的阻力，既与血管的直径相关，也与血液的粘度相关。天气变冷、保暖不足、体表温度下降时，血管受冷收缩，同时血液的粘度也因温度降低而上升，于是血液循环阻力加大。为什么冬天冠心病、中风等心脑血管疾病高发，与此也有密切关系。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>人们都知道，热敷会让局部血液循环改善。反之，血液循环很差的部位，温度就会下降。比如女孩子冬天容易脚冷，是因为脚是距离心脏最远的部位，肢端部位一旦温度下降，血液循环的速度更容易慢下来。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>所以，天冷的时候吃些&ldquo;温热&rdquo;食物，的确是比较有利于抗寒的事情。比如说，吃加了香辛料的食品，辣椒、花椒、大茴香、葱、姜、蒜之类，或多或少地有促进消化液分泌和促进血液循环的双重效果，所以身体散热会有所增加。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>又比如说，牛肉、羊肉、鹿肉等富含蛋白质，而蛋白质本身具有很高的&ldquo;食物热效应&rdquo;（也叫食物的特殊动力作用），也就是说，它们的进食后会促进体表散热，这种散热所消耗的能量高达蛋白质所含能量的30%之多。人们吃涮羊肉会浑身冒汗，如果只吃涮白菜、涮面条，是不可能达到同样的温暖效果的。其实，有些减肥食谱要求人们增大鱼肉蛋的比例，减少主食和油脂，在某种程度上也是为了利用这种&ldquo;浪费能量&rdquo;的效应。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>扯远点说，古诗中用&ldquo;朱门酒肉臭&rdquo;来对照&ldquo;路有冻死骨&rdquo;，其实是有科学道理的&mdash;&mdash;肉类让人发热，酒类刺激血液循环加快，人更会发热，自然就不觉得冷了。顿顿有酒有肉的，哪里还能冻死呢。当然，喝酒是不能作为长时间抗寒措施的，因为一旦酒精的热劲过去，人会感觉到更冷。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>同时，红肉类还富含铁、锌、铜、锰等微量元素，它们缺乏时会造成贫血，而贫血会让人怕冷。一些传统认为能帮助人们预防贫血的食品，比如桂圆、枣、芝麻、红糖，其中的微量元素含量在同类食品中都是比较高的。山楂、柠檬等含有丰富的有机酸，有利于微量元素的吸收；各种发酵食品中的微量元素更容易被人体利用。这么想想，它们被归类为有利抵抗寒冷的&ldquo;温&rdquo;食物，也还算有点道理。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>冬天三餐食物烹调之后，很快就会变凉。对于一些体弱怕冷的人来说，冰凉的食物会降低胃中消化酶的活性，因为血液循环减慢，可能影响胃的蠕动。消化吸收不良，得到的能量和营养素就会减少，自然是不利于抗寒的。冷却的淀粉类食物会发生老化回生，消化速度降低；冷却的动物脂肪容易凝固，不易被乳化，消化吸收速度也会减慢。因此，吃热乎乎的食物有利于抗寒，主要还是因为有利于消化吸收的缘故，并不是因为升高食物温度的那点能量。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>所以，身体怕冷的人在保持膳食营养平衡的前提下，可以多吃一些传统认为冬天能够帮助暖身的食物。同时还要改善自己的消化吸收能力，充分利用食物中的微量元素成分。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>不过一定要记得，健康食物永远因人而异。如果本身就喜凉怕热，就不要多吃它们了，否则倒容易因为能量制造过剩，炎症反应升高，超过身体控制，产生一些俗话说&ldquo;上火&rdquo;之类的症状。如果吃了某些食物之后有不舒服的感觉，也一定要调整食物品种，否则就会伤害身体。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>同时不要忘记，肌肉细胞特别善于产热。经常运动起来，让自己的肌肉强大起来，形成抗寒的体质，才是最好最可靠最长效的暖身措施！</p>\r\n', '2015-01-20 02:28:31', '67', '高热量食物能给你带来温暖吗？', '8', '6');
INSERT INTO `t_information` VALUES ('32', '<p>冷风瑟瑟，转眼又到了感冒的高发季。但得了感冒该治，还是像有些人说的那样扛着，直到它自然痊愈？众说纷纭的观点也让人难辨真假。感冒到底是怎么回事、感冒后应该怎么办？综合美国最新研究，为您揭示了这一系列问题的答案。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>感冒的三个真相</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><img src=\"http://mmbiz.qpic.cn/mmbiz/qGZEXL0EiclFFFYK7bDgjRdxGJykicM9wkAjIJexFXZp60P6Hf1LA41hcuYVOkx9J7OKHuFOm9HkC6w3g8DxZGyQ/640?tp=webp\" style=\"height:auto !important; margin:0px; width:auto !important\" /></p>\r\n\r\n<p><strong>美国威斯康星大学医学与公共卫生学院2010年10月发布的一份《感冒白皮书》，为我们揭露了有关感冒的三个&ldquo;一&rdquo;真相。</strong></p>\r\n\r\n<p><strong>第一个&ldquo;一&rdquo;：</strong>感冒是一种由病毒引起的上呼吸道感染&ldquo;综合征&rdquo;，有超过100种以上的病毒可能诱发感冒；</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>第二个&ldquo;一&rdquo;：</strong>一般来说，感冒的症状会持续一星期，不论服药与否；</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>第三个&ldquo;一&rdquo;：</strong>感冒的起点，应该是出现症状的一天前，此时病毒已经在你的体内驻扎。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>更确切地说，感冒病毒会在体内潜伏18&mdash;48个小时，然后突然爆发。最早出现的症状主要包括咽喉肿痛、打喷嚏、鼻塞流涕、身体疲倦。在英文中，由于&ldquo;感冒&rdquo;和&ldquo;寒冷&rdquo;为同一词，很多人都觉得感冒是&ldquo;冻出来的&rdquo;。&ldquo;事实并非如此。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>不管你是衣服穿得太少、光脚走在地上还是头发没吹干就出门，这些都不会导致你感冒&mdash;&mdash;但是会导致抵抗力下降，让病毒们有机可乘。&rdquo;美国注册护理师菲利斯&middot;布朗说，相比之下，干燥更容易带来感冒，因为身体黏膜的抗病毒能力会因为缺水而下降。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>感冒攻击每个人的次数也不一样。根据美国疾病预防控制中心的统计，儿童每年会感冒8&mdash;10次，上学的孩子会达到12次之多，这不是因为他们抵抗力差，而是因为孩子们关系更亲密，病毒传播的几率大。相比来说，&ldquo;冷漠&rdquo;的成人们每年得感冒2&mdash;4次，女性多于男性，30岁左右的女性最易中招，因为她们是照顾孩子的主力军。年过60以后，感冒次数会减少，平均每年1次。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>乱吃药不如休息好</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>《感冒白皮书》同时指出，很多人并不知道，感冒其实没得治。有些人会服用抗生素，其实抗生素根本不能消灭病毒，胡乱吃药可能会加重病情。感冒药的主要功效是缓解症状，让你感觉好受点、休息好点，但并不能缩短病程。那么，究竟哪些事情是感冒后必须做的？美国&ldquo;健康播报网&rdquo;认为，以下9件事必不可少。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>第一步：找一张床。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><img src=\"http://mmbiz.qpic.cn/mmbiz/qGZEXL0EiclFFFYK7bDgjRdxGJykicM9wkX0R02pctA0NHyWXqUUkkOr0ruLPcODicBrOjC9iaaIb06H4mZbVEPHiaA/640?tp=webp\" style=\"height:auto !important; margin:0px; width:auto !important\" /></p>\r\n\r\n<p>感冒后，最好给自己找张舒服点的床躺下来。不要想着去上班，也不要强忍着出去聚会、玩乐或者运动。睡觉就是&ldquo;最好的感冒药&rdquo;，每天一定要保证8小时睡眠。如果可以的话，最好请假在家休息1&mdash;2天，这样可以少将疾病传染给他人。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>第二步：补点维生素C。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><img src=\"http://mmbiz.qpic.cn/mmbiz/qGZEXL0EiclFFFYK7bDgjRdxGJykicM9wkg3UmR3NRoicz6WxxaTFYZylh9URGFlMvfbuXZWzmFSv0vH6uM1ujvTA/640?tp=webp\" style=\"height:auto !important; margin:0px; width:auto !important\" /></p>\r\n\r\n<p>不管是服用维生素C补充剂，还是吃点富含维C的水果，比如枣、橙子、猕猴桃、橘子、柚子等，都能起到缓解感冒症状的作用。一般来说，酸味重的水果维C含量都不少。喝橙汁在补维C的同时，还能消除口腔中的不适感。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>第三步：吃块黑巧克力。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>它不仅能补充抗氧化剂，英国伦敦大学的研究还显示，其中所含的可可碱有止咳功效。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>第四步：打开加湿器。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><img src=\"http://mmbiz.qpic.cn/mmbiz/qGZEXL0EiclFFFYK7bDgjRdxGJykicM9wkwWPicOzRvRFUgB0HbqeepsxYrkE8L58lG6w18fBUJwAY4Uz5WKMd8CQ/640?tp=webp\" style=\"height:auto !important; margin:0px; width:auto !important\" /></p>\r\n\r\n<p>秋冬季节干燥的空气会让呼吸道感到不适，在床边或沙发边放置加湿器，可以让你呼吸更顺畅。使用前，最好彻底清洗一下，以免病毒通过其散播。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>第五步：吃流质食物。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><img src=\"http://mmbiz.qpic.cn/mmbiz/qGZEXL0EiclFFFYK7bDgjRdxGJykicM9wkaBMqa5tXtQOKudlGnFfhOWWgxMsTyCxus3v8ZtH9kmXWa50fk3yWuA/640?tp=webp\" style=\"height:auto !important; margin:0px; width:auto !important\" /></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>热汤和热粥都是不错的选择。几百年来都流传着鸡汤治感冒的说法，英国学者发现这是有道理的，因为鸡汤中的某些成分可以减少咳嗽，而且热汤和热粥的蒸汽也有助于缓解鼻塞。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>第六步：换个大水杯。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><img src=\"http://mmbiz.qpic.cn/mmbiz/qGZEXL0EiclFFFYK7bDgjRdxGJykicM9wkPToOQL5wlGYBocF4No9eOJEic5ylgszhboAm6eAW4qJMGVbDSMKOZkw/640?tp=webp\" style=\"height:auto !important; margin:0px; width:auto !important\" /></p>\r\n\r\n<p>保证每天喝2000毫升水，其中有一部分最好是电解质饮料。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>第七步：远离乳制品。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><img src=\"http://mmbiz.qpic.cn/mmbiz/qGZEXL0EiclFFFYK7bDgjRdxGJykicM9wk29YBO5qk1dwT3rXsJNFNMHzfiahpAZMZkOTVvnUjaAcSHdgugicrjuqw/640?tp=webp\" style=\"height:auto !important; margin:0px; width:auto !important\" /></p>\r\n\r\n<p>奶酪等较难消化的奶制品，感冒时最好别吃，但是可以适当喝些牛奶。如果胃口不好，可以喝些酸奶。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>第八步：服用非处方药。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>布洛芬、扑热息痛或止咳糖浆等非处方药都能减轻感冒的症状。虽然这些药不能抗病毒，但能让你感觉好受些。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>第九步：耐心等它过去。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><img src=\"http://mmbiz.qpic.cn/mmbiz/qGZEXL0EiclFFFYK7bDgjRdxGJykicM9wkBUnWGHW1ctAYws854ibmGupnblJTH7kX0sehONVbNcJrc1ZGvHaJ4UQ/640?tp=webp\" style=\"height:auto !important; margin:0px; width:auto !important\" /></p>\r\n\r\n<p>你的病需要7天左右才会自行消失。但如果症状一直持续或急剧恶化，最好去医院请医生诊断。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>对付感冒三件宝</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>感冒虽然不是大病，但持续不断的症状却让很多人坐立难安。对此，《感冒白皮书》针对喉痛、咳嗽、鼻塞三大症状，给出了缓解的小窍门。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>喉痛：</strong>淡盐水。将7.5克盐溶解在250毫升温水中，缓慢漱口可以缓解咽喉肿痛，每隔6&mdash;8小时漱口一次。不要使用刺激性的漱口水，它们可能会加剧呼吸道干燥。吞咽较硬的食物，最好慢些，以免划伤咽部。如果声音沙哑，就避免在嘈杂的环境中说话或大声叫喊。还可以准备一些含片或喷雾，症状较重时使用。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>咳嗽：</strong>止咳糖浆。咳嗽是身体清除外源性物质的一种手段，但剧烈的咳嗽会影响睡眠或导致胸痛。最好的办法是，在咳嗽剧烈的时候喝点止咳糖浆。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>鼻涕：</strong>热蒸汽。擤鼻涕的时候最好使用软纸巾，这样可以防止鼻子被蹭破。擤鼻涕切忌太用力，程度的标准是以耳朵听不到嗡嗡声为宜，以免对耳膜造成损害。如果鼻涕难以擤出，可以&ldquo;闻闻&rdquo;热蒸汽或薄荷油，或使用滴鼻液。</p>\r\n', '2015-01-20 02:30:36', '87', '感冒后最该做的9件事情！', '8', '1');
INSERT INTO `t_information` VALUES ('33', '<blockquote>\r\n<p><strong>因为可以吃到新鲜的蔬菜水果、丰富的鸡鸭鱼肉，越来越多人觉得，主食只是用来填饱肚子的，吃不吃都可以。然而，这种行为背后却有着巨大的健康隐患。只吃菜不吃饭，小心给身体惹来癌症和疾病。</strong></p>\r\n</blockquote>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><img src=\"http://mmbiz.qpic.cn/mmbiz/pSs2lXNUlE2Rg7icCvvqBiaAnVjv5EJvtibjGskzib6gxC9p0f0pat7C6GicNV8pN8RylGNydhiaVKPJww2L85atRTcQ/0?tp=webp\" style=\"border-style:none; border-width:0px; height:auto !important; margin:0px; width:500px !important\" /></p>\r\n\r\n<p><strong>大肠癌</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>不吃米饭，而空腹大量进食鱼、肉等高蛋白质食物，不但浪费蛋白质，还增加了身体内的废物产生。<br />\r\n<br />\r\n因为蛋白质分解之后，会产生大量含氮废物，不但增加了肝脏和肾脏的负担，还促进大肠中的腐败菌增殖，影响肠道微生态平衡，增加罹患大肠癌的风险。而脂肪摄入过多，也容易造成结肠癌高发。</strong><br />\r\n<strong>　</strong></p>\r\n\r\n<p><strong>大脑退化</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>主食吃得少，碳水化合物摄入远远不够满足人体需要，会导致体内重要物质的匮乏，如：葡萄糖减少就会导致大脑思维活动受影响。<br />\r\n<br />\r\n据研究，大脑每天需要约130克淀粉主食提供能量，若不足，可产生精神不振、注意力不集中、思维迟钝、焦虑不安等，严重影响大脑思维。</strong><br />\r\n&nbsp;</p>\r\n\r\n<p><strong>心血管病</strong></p>\r\n\r\n<p><strong>　</strong></p>\r\n\r\n<p><strong>由于许多蔬菜是用过多的烹调油炒成的，有的菜就像泡在油里，容易让油脂摄入增多。<br />\r\n<br />\r\n同时，增加蛋白质和脂肪丰富的禽畜鱼类的进食，也会导致体内脂肪囤积过多，不但会引起肥胖，高脂血症、高血压、冠心病也会接踵而至。</strong></p>\r\n\r\n<p>　</p>\r\n\r\n<p><strong>糖尿病</strong></p>\r\n\r\n<p>　</p>\r\n\r\n<p>一<strong>些糖尿病患者或担心自己得糖尿病的人，会有意少吃米面，以为这就少摄入了糖分。<br />\r\n<br />\r\n如果病人主食摄入量太少，处于半饥饿状态，容易出现反应性高血糖，引起低血糖抗病能力下降。长此下去，患者身体消瘦，脂肪异生，易得高脂血症等各种并发症，给治疗带来困难。</strong><br />\r\n&nbsp;</p>\r\n\r\n<p><strong>脂肪肝</strong></p>\r\n\r\n<p><strong>　</strong></p>\r\n\r\n<p><strong>喝酒吃菜不吃饭尤易损肝伤胆。即使尽量少吃或不吃含饱和脂肪酸的动物性脂肪，改吃含不饱和脂肪酸的植物油，这在抗动脉粥样硬化方面自然有益，但酒席上控制不了油和菜的摄入量。<br />\r\n<br />\r\n日久就会加重体内脂质过氧化、损伤肝细胞，还可能诱发胆石症；饮酒会加重这种损害，引发或加重脂肪肝。</strong><br />\r\n&nbsp;</p>\r\n\r\n<p><strong>体毒堆积</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>只吃饭不吃菜，碳水化合物摄入不足，身体所需要的碳水化合物也就不足。而碳水化合物具有解毒功能，一旦缺乏，血液中有毒废物不能及时排除，就会造成肤色黯淡、脸色难看。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n', '2015-01-20 02:31:48', '767', '主食吃少易患6种病', '8', '2');
INSERT INTO `t_information` VALUES ('34', '<p><strong>膳食纤维定义的变迁</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>1、依据化学结构定义：植物的结构成分和无能量储存的多聚糖，且不能被人类消化酶水解。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>2、根据其水溶性分为不溶性膳食纤维和可溶性膳食纤维。后者包括果胶、豆胶、藻胶、树胶等，在豆类、水果、海带等食品中较多，减慢糖的吸收，使餐后血糖和胰岛素的水平降低，并具有降低胆固醇的作用。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>3、美国谷物化学家学会定义的膳食纤维是指：植物可食部的一部分，在人类小肠中不能消化吸收，但在结肠内可部分或全部酵解，包括：多聚糖、寡聚糖、木质素、抗性淀粉，及其他植物性成分。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>4、欧洲食品安全局（EFSA，2007）对膳食纤维的定义是：包括所有非消化性碳水化合物，如非淀粉多糖（NSP）、抗性淀粉、抗性低聚糖（由三个或以上单糖链接而成的多糖）以及其它与膳食纤维多糖，尤其是木质素相关的非消化性微量组分。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>5、2008年营养与食品法典委员会特殊膳食（CCNFSDU）对膳食纤维给出了最新定义：即膳食纤维是指含10个或以上单体单位的碳水化合物聚合体，在人类的小肠不被内源性酶水解。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>添加膳食纤维改善即刻血糖及长期血糖控制</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>1、随机对照研究显示，添加膳食纤维可延长糖尿病患者的胃排空时间，延缓葡萄糖的消化与吸收，可改善餐后即刻血糖代谢和长期糖尿病控制。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>2、改善1型糖尿病患者的血糖控制，减少高血糖的发生频率，1型糖尿病孕妇每天的胰岛素使用量减低。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>3、队列研究结果显示，谷物膳食纤维与2型糖尿病的发生降低相关。</p>\r\n\r\n<p><img src=\"http://mmbiz.qpic.cn/mmbiz/B9p211Oonk5ukxuJMO5bWDFt8YWIyw1JVGZLibiauYbkZ2kdLQd90G0shs4UialjxibRalTxLQtsiaRNsLHKMPgpcPg/640?tp=webp\" style=\"height:auto !important; margin:0px; width:auto !important\" /></p>\r\n\r\n<p><strong>膳食纤维推荐意见</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>B级：鼓励糖尿病患者多摄入各种富含膳食纤维的食物，但目前没有证据支持糖尿病患者膳食纤维推荐摄入量应当高于普通人群。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>A级：膳食纤维有助于糖尿病患者长期血糖控制。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>D级：抗性淀粉的长期有效性和安全性尚待考证</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>美国防癌协会推荐标准： 每人每天膳食纤维日摄入量为：30~40g</p>\r\n\r\n<p>欧盟食品科学委员会推荐标准： 每人每天膳食纤维日摄入量为：30g</p>\r\n', '2015-01-20 02:34:21', '343424', '膳食纤维在营养治疗中的作用', '8', '3');
INSERT INTO `t_information` VALUES ('35', '<p><img src=\"http://mmbiz.qpic.cn/mmbiz/fTSPArOWRMM7MQ2zH8Mum61yPicOQCJBmyc81ichPKVH8RuTc1OS7EaoK9DP21iaMdkdAm5U8uiajbVakf5oBlesrA/0?tp=webp\" style=\"height:auto !important; margin:18px 0px -6px; width:698px\" /></p>\r\n\r\n<p>你知道吗?其实长寿健康的秘密是隐藏在吃饭里的。看看你平时的生活习惯再来对照下面这 20 个健康地饮食习惯，看看自己还需要改进的地方在哪里 ? 下面是为大家介绍的 20 个吃饭秘密，快来看看吧 ! 专家指出，这 20 条中若能达到 12 条，就算得上达标 ；若在 5 条以下，需引起注意，及时纠正。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>1、吃饭时挺直腰背。</strong></p>\r\n\r\n<p><br />\r\n人们吃饭时身体处于放松状态，很容易含胸驼背。殊不知，这会使食道和胃部受压，影响消化。此外，在矮桌前吃饭、坐在沙发上以及蹲着吃饭，都会造成腹部受压，影响消化道的血液循环，久而久之可引发胃病、影响心肺功能。正确的进餐姿势是：挺直腰背，让胃部不受任何压迫。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>2. 特别饿时喝点粥。</strong></p>\r\n\r\n<p><br />\r\n人在极度饥饿时食欲特别强，看到什么都想吃。其实，此刻胃肠消化功能已经受损，如果大吃大喝很容易造成食滞。特别饿时，应少量进一些半流食，如粥、面或米线，然后再慢慢恢复正常饮食。尤其注意，特别饿时别进食牛奶、豆浆、酸奶和白薯，可能引起消化问题。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>3. 两餐间隔 4 &mdash; 6 小时。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>两餐间隔太长或太短都会对人体造成影响，太长会引起高度饥饿感，影响劳动和工作效率 ; 间隔时间太短，消化器官得不到适当的休息，影响食欲和消化。一般混合食物在胃里停留的时间大约是 4 &mdash; 5 小时，因此，两餐间隔 4 &mdash; 6 小时比较合适。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>4. 先吃爱吃的食物。</strong></p>\r\n\r\n<p><br />\r\n桌上的菜，肯定有你偏爱的和不喜欢的，此时该先吃哪个 ? 专家提示，先吃自己喜爱的食物，这会让你在情绪上获得满足。愉快的心情能较快地产生饱胀感，避免吃得太多。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>5. 饭后别马上用脑。</strong></p>\r\n\r\n<p><br />\r\n饭后，体内的血液会集中流向消化器官，大脑相对缺血。此时用脑会引起精神紧张、记忆力下降等问题，还可能增加心脑血管疾病的发生几率。因此，一定要在饭后休息半小时以上再进入工作状态。听听音乐、散散步都是不错的选择。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>6. 吃饭时不谈扫兴的事。</strong></p>\r\n\r\n<p><br />\r\n俗话说 &quot; 食不言，寝不语 &quot;。吃饭时说话会使咀嚼食物的次数减少、唾液分泌减少，从而影响消化功能。美国一项最新研究则指出，就餐时谈讨论复杂或令人扫兴的问题，会影响人的食欲和消化，可以谈论一些简单愉快的话题。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>7. 早饭吃热的。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>清晨，人体内的神经及血管都还处于收缩状态，此时如果吃冰冷的食品，可能使消化系统发生痉挛。中医认为，早餐应该吃热食，保护胃气。建议早餐选择热稀饭、热麦片、热豆浆等，再配上包子、面包等干主食。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>8. 饭后半小时再喝茶。</strong></p>\r\n\r\n<p><br />\r\n饭后不宜立即饮茶，否则会冲淡胃液，影响食物消化。同时，茶中的单宁酸和食物中的蛋白质混合后会产生不易消化的凝固物质，给胃增加负担。饭后半小时再喝茶，能促进消化吸收，起到杀菌消毒和护齿的作用。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>9. 晚上别吃冷饮。</strong></p>\r\n\r\n<p><br />\r\n晚上 7 点后，人体体液代谢下降，此时吃凉的食物，尤其是冷饮，不易消除疲劳还会影响睡眠。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>10. 饭后甜点要少吃。</strong></p>\r\n\r\n<p><br />\r\n　　正餐已获得了足够的糖分，如果再吃甜点，人体会吸收多余的葡萄糖、淀粉。吃过油腻的东西后尤其不要吃甜点。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>11. 多吃深色蔬菜。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>深色蔬菜是指深绿色、红色、紫红色的蔬菜。中国营养学会推荐，每天应该吃一斤蔬菜，其中深色蔬菜应占到一半以上，其维生素 C 含量比浅色的高一倍。举例来说，深紫色茄子与浅绿色茄子，紫色洋葱与白色洋葱，紫甘蓝与卷心菜，紫薯与红薯、白薯，前者的营养价值都显著高于后者。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>12. 动、植物油混着吃。</strong></p>\r\n\r\n<p><br />\r\n光吃植物油会促使体内过氧化物增加，加快人衰老，还会影响人体对维生素的吸收，增加乳腺癌、结肠癌发病率。而动物油含有对心血管有益的多烯酸、脂蛋白等。专家提醒，用 1 份动物油、2 份植物油制成混合油，可以取长补短。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>13. 吃饭环境要安静。</strong></p>\r\n\r\n<p><br />\r\n英国曼彻斯特大学研究显示，随着噪声增大，受试者感受食物甜味和咸味的敏感度降低。研究还表明，嘈杂的就餐环境会使人的味觉变迟钝。专家建议吃饭时不要选择环境嘈杂的餐馆，有轻柔音乐做背景可以让人吃得更香。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>14. 别一个人吃饭。</strong><br />\r\n&nbsp;</p>\r\n\r\n<p>单独进餐容易产生不良情绪，而且饮食单调，会造成营养失衡。和同事、家人一起吃饭，心情舒畅，胃液的分泌也相对旺盛，可使食物尽快地消化和吸收。此外多人一起吃饭，食品种类也多，每种吃一点容易达到营养平衡。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>15. 骨头汤加点醋。</strong></p>\r\n\r\n<p>　　人体对钙的吸收利用受到多种因素制约。含钙丰富的食品有牛奶、鸡蛋、骨汤、鱼虾、黄豆等。胃肠道的酸度不足会影响钙的吸收。因此，烹调食物时适当放些醋，可使食物中的钙转化成容易被吸收的醋酸钙。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>16. 每天吃一次纤维食品。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>人体摄取了多余的脂肪和蛋白质，与大肠杆菌作用，会变成有害的腐败物。纤维质可把它们包围并排泄掉。因此，每天最好吃一点粗纤维食物，如燕麦、糙米、薏米、红薯、玉米等。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>17. 多嚼硬的食物。</strong></p>\r\n\r\n<p><br />\r\n根据年龄不同，可适当补充一些硬的食物，如水果、甘蔗、生黄瓜等。这是因为较硬的食物要费劲去嚼，当咀嚼的次数增多或频率加快时，大脑的血流量明显增多，活化了大脑皮层，起到防止大脑老化和预防老年痴呆症的作用。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>18. 细嚼慢咽。</p>\r\n\r\n<p><br />\r\n细嚼慢咽有助于消化，专家建议，每吃一口饭就放下筷子，集中注意力在嘴巴的咀嚼上，每一口都要细细地咀嚼 30 次以上。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>19. 少吃盐。</strong></p>\r\n\r\n<p><br />\r\n新版美国饮食指南建议，每人每日所摄入的食盐量应减少至 2300 毫克 ( 约一茶匙 ) 以内。而那些年龄超过 51 岁以及患有高血压和糖尿病等慢性疾病的人，每日所摄入食盐量应减少至 1500 毫克以内。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>20. 调味品别滥用。</strong></p>\r\n\r\n<p><br />\r\n美国食品药物管理局 ( FDA ) 的研究显示，桂皮、小茴香等天然调味品中都或多或少含有黄樟素，它可引起肝癌。多吃不仅会口干、咽喉痛、精神不振，还容易导致胃酸分泌过多和胃胀气。因此，在烹制食物时不要过度使用。</p>\r\n\r\n<p>　　</p>\r\n\r\n<p>世界卫生组织规定，个人的健康和寿命 15% 决定于遗传，10% 决定于社会因素，8% 决定于医疗条件，7% 决定于气候影响，60% 决定于自己。吃饭一定要是：早上吃好，中午吃饱，晚上吃少。现在的人相反了，早上马虎，中午对付，晚上大吃大喝，这就是百病之根。早上这顿饭，等于吃补药，是最重要的一顿饭，一定要吃营养早餐。</p>\r\n', '2015-01-20 02:35:03', '67', '20 个吃饭的习惯，让你健康又长寿！', '8', '4');
INSERT INTO `t_information` VALUES ('41', '<p>&nbsp; &nbsp; &nbsp; &nbsp; 糖尿病肾病是糖尿病最主要的微血管并发症之一，是目前引起终末期肾病（end-stage renal disease，ESRD）的首要原因。不久前，中华医学会糖尿病学分会微血管并发症学组组织国内的内分泌和肾内科领域专家共同制定《糖尿病肾病防治专家共识（2014年版）》（以下简称&ldquo;共识&rdquo;），共识由复旦大学附属华山医院内分泌科胡仁明等专家起草编写，针对糖尿病肾病的诊治进行了详尽论述，共识发表在近期的《中华糖尿病杂志上》。<br />\r\n<br />\r\n　　国外研究资料显示，20年以上病程的糖尿病肾病患者发展为ESRD的发生率为40.8/1000人年，需要进行透析或移植等肾脏替代治疗。我国糖尿病肾病的患病率亦呈快速增长趋势，2009至2012年我国2型糖尿病患者的糖尿病肾病患病率在社区患者中为30%~50%，在住院患者中为40%左右。糖尿病肾病起病隐匿，一旦进入大量蛋白尿期后，进展至ESRD的速度大约为其他肾脏病变的14倍，因此早期诊断、预防与延缓糖尿病肾病的发生发展对提高糖尿病患者存活率，改善其生活质量具有重要意义。本共识为规范糖尿病肾病的诊断和治疗提供了依据。<br />\r\n<br />\r\n　　<strong>以下为共识概要：<br />\r\n<br />\r\n　　一、糖尿病肾病的定义与诊断</strong><br />\r\n<br />\r\n　 　糖尿病肾病是由糖尿病引起的肾脏损伤，以往用DN（diabetic nephropathy）表示，2007年美国肾脏病基金会（NKF）制定了肾脏病生存质量指导指南，简称NKF/KDOQI。该指南建议用DKD（diabetic kidneydisease）取代DN。2014年美国糖尿病协会（ADA）与NKF达成共识，认为DKD是指由糖尿病引起的慢性肾病，主要包括肾小球滤过率（GFR）低于60ml/min/1.73 m2或尿白蛋白/肌酐比值（ACR）高于30 mg/g持续超过3个月。糖尿病性肾小球肾病（diabeticglomerulopathy）专指经肾脏活检证实的由糖尿病引起的肾小球病变。<br />\r\n<br />\r\n　　<strong>（一）糖尿病肾病临床诊断依据</strong><br />\r\n<br />\r\n　　1．尿白蛋白：微量白蛋白尿是糖尿病肾病早期的临床表现，也是诊断糖尿病肾病的主要依据。<br />\r\n<br />\r\n　　2．糖尿病视网膜病变：糖尿病视网膜病变常早于糖尿病肾病发生，大部分糖尿病肾病患者患有糖尿病视网膜病变，但在透析的糖尿病肾病患者中，糖尿病视网膜病变的发病率反而减少，糖尿病视网膜病变被NKF/KDOQI指南作为2型糖尿病患者糖尿病肾病的诊断依据之一。<br />\r\n<br />\r\n　　<strong>（二）糖尿病肾病的筛查和肾功能评价</strong><br />\r\n<br />\r\n　　肾功能改变是糖尿病肾病的重要表现，反映肾功能的主要指标是GFR，根据GFR和其他肾脏损伤证据可进行慢性肾病（CKD）的分期（表2）。<br />\r\n<br />\r\n　　<strong>（三）糖尿病肾病临床诊断标准</strong><br />\r\n<br />\r\n　　我国目前仍无统一的糖尿病肾病诊断标准，本共识推荐采用表3诊断标准，符合任何一项者可考虑为糖尿病肾脏病变（适用于1型及2型糖尿病）。<br />\r\n<br />\r\n　　诊断时，出现以下情况之一的应考虑其CKD是由其他原因引起的：<br />\r\n<br />\r\n　　1．无糖尿病视网膜病变；<br />\r\n<br />\r\n　　2．GFR较低或迅速下降；<br />\r\n<br />\r\n　　3．蛋白尿急剧增多或有肾病综合征；<br />\r\n<br />\r\n　　4．顽固性高血压；<br />\r\n<br />\r\n　　5．尿沉渣活动表现；<br />\r\n<br />\r\n　　6．其他系统性疾病的症状或体征；<br />\r\n<br />\r\n　　7．血管紧张素转换酶抑制剂（ACEI）或血管紧张素Ⅱ受体拮抗剂（ARB）类药物开始治疗后2～3个月内肾小球滤过率下降超过30%。<br />\r\n<br />\r\n　　<strong>（四）糖尿病肾病的临床分期和病理分级</strong><br />\r\n<br />\r\n　　1987年Mogensen建议，根据糖尿病肾病的病理生理特点和演变过程，将1型糖尿病患者的糖尿病肾病分为5期。<br />\r\n<br />\r\n　　<strong>二、糖尿病肾病的防治</strong><br />\r\n<br />\r\n　　糖尿病肾病的防治分为三个阶段。<br />\r\n<br />\r\n　　第一阶段为糖尿病肾病的预防，对重点人群进行糖尿病筛查，发现糖耐量受损或空腹血糖受损的患者，采取改变生活方式、控制血糖等措施，预防糖尿病及糖尿病肾病的发生。<br />\r\n<br />\r\n　　第二阶段为糖尿病肾病早期治疗，出现微量白蛋白尿的糖尿病患者，予以糖尿病肾病治疗，减少或延缓大量蛋白尿的发生。<br />\r\n<br />\r\n　　第三阶段为预防或延缓肾功能不全的发生或进展，治疗并发症，出现肾功能不全者考虑肾脏替代治疗。糖尿病肾病的治疗以控制血糖、控制血压、减少尿蛋白为主，还包括生活方式干预、纠正脂质代谢紊乱、治疗肾功能不全的并发症、透析治疗等。<br />\r\n<br />\r\n　　<strong>（一）生活方式指导</strong><br />\r\n<br />\r\n　　改变生活方式包括饮食治疗、运动、戒酒、戒烟、控制体重，有利于减缓糖尿病肾病进展，保护肾功能。<br />\r\n<br />\r\n　　1．医学营养治疗<br />\r\n<br />\r\n　　2．运动<br />\r\n<br />\r\n　　3．戒烟<br />\r\n<br />\r\n　　<strong>（二）控制血糖</strong><br />\r\n<br />\r\n　　DCCT及其后续的糖尿病干预和并发症流行病学研究（EDIC）、英国2型糖尿病前瞻性研究（UKPDS）及美国退伍军人合作研究（VAC）分别验证了在1型糖尿病和2型糖尿病患者中，严格控制血糖可减少糖尿病肾病的发生或延缓其病程进展。<br />\r\n<br />\r\n　 　1．血糖控制目标：糖尿病肾病患者的血糖控制应遵循个体化原则。血糖控制目标：糖化血红蛋白（HbA1c）不超过7％。对中老年患者，HbAlc控制目标适当放宽至不超过7%～9%。由于CKD患者的红细胞寿命缩短，HbA1c可能被低估。在CKD 4~5期的患者中，用果糖胺或糖化血清白蛋白反映血糖控制水平更可靠。<br />\r\n<br />\r\n　　2．抗高血糖药物的选择：包括双胍类、磺脲类、格列奈类、噻唑烷二酮类、&alpha;-糖苷酶抑制剂、二肽基肽酶Ⅳ（DPP-4）抑制剂、胰高血糖素样肽1（GLP-1）类似物及胰岛素。某些在肾脏代谢或排泄的药物，在糖尿病肾病尤其是肾功能不全的患者中，经肾排泄减少或其活性代谢产物的清除减少，可引起低血糖等不良反应，这些药物在GFR低于60 ml/min/1.73 m2时需酌情减量或停药（图1）。<br />\r\n<br />\r\n　　<strong>（三）控制血压</strong><br />\r\n<br />\r\n　　血压升高不仅是加速糖尿病 肾病进展的重要因素，也是决定患者心血管病预后的主要风险因素。在2型糖尿病肾病患者中，血压对肾功能的影响更加突出，收缩压超过140 mmHg（1mmHg=0.133 kPa）的患者，其肾功能下降速度为每年13.5%，而收缩压&lt;140mmHg者每年肾功能下降的速度是1%。UKPDS研究显示，在处于糖尿病早期的糖尿病患者中采用强化的血压控制，不但可以显著减少糖尿病大血管病变发生的风险，还显著减少了微血管病变发生的风险。大量临床观察也证实，严格控制高血压能明显减少糖尿病肾病患者尿蛋白水平，延缓肾功能损害的进展。强化血压控制还可使心血管病终点事件的风险下降20%~30%。<br />\r\n<br />\r\n　　<strong>（四）纠正脂质代谢紊乱</strong><br />\r\n<br />\r\n　 　高脂血症不仅直接参与糖尿病胰岛素抵抗和心血管并发症的发生，低密度脂蛋白胆固醇（LDL-C）还可以通过作用于肾小球系膜细胞上的LDL受体，导致系 膜细胞和足细胞的损伤，加重蛋白尿和肾小球及肾小管间质纤维化的进展。糖尿病患者出现肾病综合征和肾功能不全，又会进一步加重高脂血症。因此积极纠正糖尿病肾病患者体内脂代谢紊乱，亦对糖尿病肾病具有重要意义。<br />\r\n<br />\r\n　　<strong>（五）肾脏替代治疗</strong><br />\r\n<br />\r\n　　GFR低于15 ml/min/1.73m2的糖尿病肾病患者在条件允许的情况下可选择肾脏替代治疗，包括血液透析、腹膜透析和肾脏移植等。<br />\r\n<br />\r\n　　<strong>（六）其他治疗药物应用、研制及展望</strong><br />\r\n<br />\r\n　　1．微循环扩张剂<br />\r\n<br />\r\n　　2．探索中药和中西医结合治疗糖尿病肾病<br />\r\n<br />\r\n　　3．开发针对糖尿病肾病发病机制的药物</p>\r\n', '2015-01-26 02:28:51', '123', '为你解读：糖尿病肾病防治专家共识！', '8', '5');
INSERT INTO `t_information` VALUES ('42', '<p><img src=\"http://mmbiz.qpic.cn/mmbiz/fTSPArOWRMMrj5GWVmzEatzqn6TnHKt6jxy99DaZSJicicClavvhLBwUtgUGchdKP7WnMiciaAS42VDN7lficzUtsdQ/0?tp=webp\" style=\"height:auto !important; margin:18px 0px -6px; width:698px\" /></p>\r\n\r\n<p>血糖指数(GI)，是指含有等量碳水化合物的不同食物可以使血糖不同程度升高的数值（其量化标准是根据50克碳水化合物与50克葡萄糖相比，血糖在2小时内增加的数量）。例如，一个香蕉和一个苹果，若二者含有等量碳水化合物，食用后，香蕉可以使血糖升高的更多；煮熟的番茄比煮熟的胡萝卜更能升血糖。因此，有人就将血糖指数作为一个突入点，甚至用血糖指数来标签生产的食物，并由此达到推销的目的。那么，血糖指数究竟可不可靠？</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>目前尚无明确定论，特别是对于那些已经实行多谷物、多蔬菜、多水果的健康饮食的人群来说，是不是有必要考虑血糖指数，更需进一步推敲。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>之前曾有临床试验报道称，低血糖指数的碳水化合物及纤维素饮食对胰岛素敏感性和心血管疾病风险均有影响，还可以减轻体重，并将其用作糖尿病的治疗手段之一。</p>\r\n\r\n<p>　</p>\r\n\r\n<p>而一篇12月17日发表在《美国医学会杂志》上的文献显示，低血糖指数的碳水化合物并不能增加胰岛素敏感性或降低患心血管疾病的风险。以Frank MSacks（哈佛大学公共卫生学院，医学博士）为主的研究小组利用相同的饮食方法，设计随机临床试验，旨在研究膳食总碳水化合物血糖指数对心血管疾病和糖尿病的发生风险的关系。试验由163名超重（BMIs&ge;25kg/㎡）成人参与，他们都不患有糖尿病，并且收缩压控制在120-159mmHg之间，均给予四次完整饮食，包括正餐，零食以及含有卡路里的饮料，每次5周，要求每名参与者至少完成两次饮食研究。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>如此一共设置了四个试验组，分别为（1）高血糖指数（65%），高碳水化合物饮食（58%能量），（2）低血糖指数（40%），高碳水化合物饮食，（3）高血糖指数，低碳水化合物饮食（40%能量），（4）低血糖指数，低碳水化合物饮食。（这些指数都基于健康饮食标准同时防止高血压发生&ldquo;DASH&rdquo;）。历时两年又八个多月的时间，完成5个主要的指标统计：分别为胰岛素敏感度（即口服糖耐量实验中胰岛素和血糖水平曲线下面积）、低密度脂蛋白（LDL）、高密度脂蛋白（HDL）、甘油三脂（TG）的水平以及收缩压。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>试验结果发现在高碳水化合物饮食组中，低血糖指数组（2）较高血糖指数组（1）胰岛素敏感度从8.9降低至7.1个单位，LDL从139mg/dl升至147mg/dl，对HDL、TG和血压并没有影响；在低碳水化合物饮食组，低血糖指数组（4）较高血糖指数组（3）除了甘油三酯从91mg/dl降到86mg/dl，其余指标都没有影响。在主要的食物比较中，低血糖指数、低碳水化合物饮食与高血糖指数、高碳水化合物饮食组相比，除了甘油三酯从111mg/dl降至86mg/dl，对胰岛素敏感度、收缩压、LDL、HDL都没有影响。</p>\r\n\r\n<p>　</p>\r\n\r\n<p>研究人员因此得出结论：在此次随机临床试验中，含有低血糖指数的碳水化合物和含有高血糖指数的碳水化合物饮食比较，并不能增加胰岛素的敏感度、血脂水平和收缩压。特别是防止高血压饮食，这种本来已经比较健康的饮食前提下，用血糖指数来选择特定的食物，或许并不能降低患心血管风险和提高胰岛素敏感度。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>然而，RobertH Eckel博士（丹佛科罗拉多大学，内分泌代谢疾病和糖尿病专家）评论说：&ldquo;血糖指数很有可能与糖尿病患者仍然相关&rdquo;，&ldquo;食物含有相同的碳水化合物但他们升高血糖的能力却大不相同。这对于糖尿病患者控制血糖来说是非常重要的。&rdquo;他还强调&ldquo;除非是糖尿病患者，不然对于一般人而言一味追求低血糖指数不如强调整体的饮食模式。巧合的是，如果该饮食有益心脏健康，血糖指数会相对较低。&rdquo;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>由此可见，对应糖尿病患者选择低GI的食物的重要性，日常饮食增加膳食纤维的摄取可以有效降低食物本身GI值，可帮助您有效控制餐后血糖，平稳胰岛素。</p>\r\n', '2015-01-21 04:48:44', '234', '血糖指数GI，你了解多少?', '8', '6');
INSERT INTO `t_information` VALUES ('43', '<p><img src=\"http://mmbiz.qpic.cn/mmbiz/fTSPArOWRMP6ibfNeXvdXH3Ys5ysSo130TkausAaicAVKVA73gicxD0tKRSftql4ibNsQaVeVCBN2uWpxSQsfEickhw/0?tp=webp\" style=\"height:auto !important; margin:18px 0px -6px; width:698px\" /></p>\r\n\r\n<p>&ldquo;&nbsp;谁该看&nbsp;营养门诊&nbsp;&rdquo;</p>\r\n\r\n<p>1</p>\r\n\r\n<p>强烈推荐</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>强烈推荐</strong><br />\r\n妊娠期、糖尿病、消化道疾病、肥胖、慢性肾病。<br />\r\n<br />\r\n<strong>一般推荐</strong><br />\r\n肿瘤、高血压、高血脂、高尿酸等代谢综合征患者，乳母、老年人。<br />\r\n<br />\r\n其实一般人都可以来转转<br />\r\n&nbsp;</p>\r\n\r\n<p>2</p>\r\n\r\n<p>你能得到什么？</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>相比于其他专科</strong><br />\r\n营养门诊交流时间长，沟通更加充分营养医师会根据患者个体情况调整饮食方案，如果有需要还可能提供肠内营养制剂方案。除了身高体重、腰围、上臂围测量外，常见的有测量皮下脂肪的皮褶厚度计，体脂仪。很多医院还有人体成分分析仪、甚至是测量基础代谢的代谢车等等，可以帮助测定一天所需热量、体内脂肪、肌肉含量等等。但是由于国内往往没有相应的收费标准，免费做又收不回成本，所以开设这些项目的医院并不是很多。另外一方面就是血液生化检查了，血红蛋白、白蛋白、微量元素等等，一般在较为顶尖的医院才有开展。<br />\r\n<br />\r\n<strong>与看书、看电视的区别</strong><br />\r\n我接触过太多不靠谱的信息，也经常在网上和电视上做科普宣传，我认为如果观众有批判精神，不断求证、能够分辨事实和观点的区别，有选择性地接受信息，那么&ldquo;最好的医生是自己&rdquo;这句话并没有错。但事实与此相反，媒体为了影响力自然要选择一些吸引眼球的观点，往往导致传播出的信息不全面，容易让普通老百姓听风就是雨，反而忽略了均衡饮食和膳食结构的重要性.具体来说，主动来营养门诊的很多都是受教育程度较高的年轻女性，其中有不少人听了很多健康饮食的说法，具体食物都特别&ldquo;健康&rdquo;，但肉吃得很少、食物种类也很单一，结果几乎全都有贫血的症状，反倒营养不良了.而营养师则可以全面系统、细致地发现你饮食中的问题，给出建议和长期的指导。<br />\r\n&nbsp;</p>\r\n\r\n<p>3</p>\r\n\r\n<p>做什么准备？</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>上好大夫网等地方查询附近医院营养门诊情况，尽量提前预约。<br />\r\n提前三天做一个饮食记录，包括进食种类、量、地点，方便营养师进行分析。<br />\r\n带上最近一年的体检报告、检查单以及病历，梳理一下自己的不适症状以及疑惑。<br />\r\n&nbsp;</p>\r\n\r\n<p>4</p>\r\n\r\n<p>如何判断服务质量？</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>首先得声明的一件事是，完整的营养干预不是一次就能搞定的，首诊以及多次随诊都很有必要，另外像首诊如果配合膳食史调查起码需要30分钟以上的时间，而这也就意味着按照这个时间一个下午的门诊最多看6个患者，而实际上热门一点的营养门诊半天门诊量都在10个以上，时间有限很多内容只好长话短说了，很多流程也只好省略了，因此仅靠一次有限的门诊很难完整判断出一位营养师的专业水准。<br />\r\n<br />\r\n具体患者可以通过这么几个角度来判断：①膳食史询问是否详细，对于职业、生活方式是否关注 ②病历填写是否认真，饮食处方是否实用和详细（包括诊断、目标、注意事项） ③听闻你个人信息后营养师的反应是否有条理 ④对于营养之外疾病或特殊生理期的情况是否了解，能做出简明扼要的说明 ⑤可否对效果做出一定程度上的预估，同时态度诚恳，承认营养的局限以及需患者自身积极的配合。 ⑥自己不断学习，从网上了解一些资料，与营养师交流。</p>\r\n', '2015-01-21 04:50:06', '355', '专家为你解读，你是否需要看营养门诊？', '8', '6');
INSERT INTO `t_information` VALUES ('44', '<p>胶原蛋白是动物体内含量最丰富的蛋白质，占人体皮肤蛋白质的71.2%，但每年约以1%的速度递减。人的皮肤老化失去青春光彩，就是因为随着年龄增长胶原蛋白的结构发生变化和流失导致。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>皮肤中一旦缺乏胶原蛋白，胶原纤维就会发生交联固化，使细胞间粘多糖减少，皮肤便会失去弹性并变薄老化，同时可导致真皮的纤维断裂，脂肪萎缩，汗腺及皮脂腺分泌减少，使皮肤出现色斑、皱纹等一系列老化现象。从外补充胶原可介导或加强细胞与胶原的作用，引起细胞形态及生理和生化发生显著改变，达到美容效果。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><img src=\"http://mmbiz.qpic.cn/mmbiz/fTSPArOWRMNBiceBMExUAVddLt8PL8OcRmHf4tMWPJhUE88aIAJuLy8jx0gicmccZ5Biajx16ALC5PwaG0Lx1GLsQ/640?tp=webp\" style=\"height:auto !important; margin:0px; width:auto !important\" /></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>胶原蛋白的化学组成、结构赋予了它是美容的基础。它具有美白、保湿、防皱、修复、营养、减肥等美容美体作用。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>美白</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>人类皮肤的颜色是由黑色素的含量与分布决定的。黑色素主要是醌型聚合物，胶原多肽中含有酪氨酸残基，由于化学结构的相似性，化妆品中添加的胶原多肽的酪氨酸残基与皮肤中的酪氨酸竞争与酪氨酸酶的活性中心结合，从而抑制酪氨酸酶催化酪氨酸转化为多巴醌，阻止皮肤中黑色素的形成，达到美白作用。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>保湿</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>胶原蛋白和构成皮肤角质层的物质结构相近，能很快渗透进皮肤表皮层，与角质层的水结合，形成一种网状结构，锁住水分被皮肤吸收，起到天然保湿因子的作用，使皮肤丰满。人体皮肤衰老时，胶原蛋白含量明显减少，而且胶原蛋白不断老化，老化的胶原纤维如同蔬菜中的植物纤维变得干粗僵硬，丧失功能。因此随着年龄的增长，皮肤角质层中水分出现不足，皮肤不断老化、干燥，从而失去柔软、弹性、润滑感，皱纹增多。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>天然保湿因子是保持皮肤水分的重要物质，其主要成份是甘氨酸、羟丁氨酸、丙氨酸、天门冬氨酸、丝氨酸等游离的氨基酸。而胶原蛋白、胶原多肽产品中甘氨酸、丙氨酸、天门冬氨酸、丝氨酸的含量丰富，从而达到保湿和调理的效果。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>防皱</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>真皮层胶原蛋白含量的减少是皱纹出现的主要原因，胶原蛋白与皮肤角质层结构的相似性决定了它与皮肤有着良好的相容性，良好的亲和力和渗透性，能渗透入皮肤表皮层，被皮肤充分吸收，起到天然保湿因子的作用，填充在皮肤基质之间，并在皮肤表面形成一层极薄的膜层，增加皮肤张力，使皮肤丰满，皱纹舒展，赋予肌肤弹性。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>修复</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>胶原蛋白具有良好的生物学特性，可为表皮细胞的迁移、增殖铺垫支架，并提供良好的营养，促进皮肤及神经增长，有利于上皮细胞的增生修复，从而促进创面的愈合，可用于小型皮肤缺损修复及组织缺损修复（人体皮肤中的弹性蛋白与胶原蛋白的比例是4:7）。同时也可用于消除皮肤疤痕，使疤痕软化，并能逐渐被组织吸收而消退，减轻或消除皮肤皱纹。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>皮肤对胶原蛋白有很好的吸收作用，当通过外源补充胶原蛋白几周后，体内成纤细胞、脂肪细胞及毛细血管将向补充的胶原蛋白内移动，组合成自身的胶原蛋白，从而形成正常的结缔组织，使受损老化的皮肤得到填充和修复，达到延缓皮肤衰老的目的。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>营养</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>胶原蛋白、胶原多肽可以给予皮肤层所必需的养分，增强皮肤中的胶原蛋白活性，保持角质层水分以及纤维结构的完整性，改善皮肤细胞生存环境和促进皮肤组织的新陈代谢，增加微循环，达到滋润皮肤、延缓衰老、美容、消皱、养发的目的。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>口服胶原蛋白后，在胃肠道被水解吸收，作为人体生物合成胶原蛋白的原料。同时，水解胶原蛋白能使分解和代谢脂肪的过程增加延长，帮助分解更多的脂肪达到减肥目的；另外，局部注射胶原蛋白，能够改善脸部老化皱纹问题。</p>\r\n', '2015-01-21 04:52:53', '452', '胶原蛋白与美容的那些事儿', '8', '1');
INSERT INTO `t_information` VALUES ('45', '<p>&nbsp; &nbsp; &nbsp; &nbsp; 2015年1月20日，安吉朗膳食商城火热上线了，全部产品均日本原装进口，主要针对肾病、糖尿病及老年病特殊人群提供安全、美味、健康的治疗膳食。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 安吉朗致力于打造国内首个治疗膳食领域的产品供应平台，与日本健康食品公司(healthyfood)紧密合作，针对肾病、糖尿病及老年病三个领域引进了数百种日本原装的治疗膳食产品。同时，安吉朗在日本治疗膳食标准的基础上，与国内营养科学顶级专家一道共同制定出符合国人饮食健康标准及口感的膳食准则。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 目前，安吉朗膳食商城中所有产品开始接受预定，如果您有这方面的膳食需求，欢迎登录安吉朗商城或拨打订购热线400-010-1166。</p>\r\n', '2015-02-01 04:28:18', '45', '安吉朗膳食商城上线，产品全面预售中', '1', '2');
INSERT INTO `t_information` VALUES ('46', '', '2015-01-21 06:46:07', '6456', '安吉朗出访日本健康食品有限公司', '1', '3');
INSERT INTO `t_information` VALUES ('47', '<p>&nbsp; &nbsp; &nbsp; &nbsp; 2014年11月16日，2014年秋冬季公共营养师招聘会北京专场在金融大街投资广场举行，安吉朗作为受邀企业参加了此次招聘会。本次招聘会旨在为优秀公共营养师提供自我展现平台，给企业更大选择空间，实现营养师与企业的完美对接。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 随着人们健康意识的逐渐提高，对膳食健康的重视程度逐渐加大，因此社会上对公共营养师的需求愈发强烈。本次招聘会吸引到来自全国的二百多名优秀公共营养师到场。招聘会上，首先由优秀营养师的演讲竞选与推荐开始，在之后的双选定向交流中，安吉朗得到了最为广泛的关注，众多营养师对于安吉朗打造国内首家营养健康领域医患交流平台的发展模式表示认同与肯定，有多名营养师与安吉朗达成初步的合作协议。最后招聘会在所有企业和营养师的合影后圆满结束。</p>\r\n', '2015-01-22 09:25:57', '665', '安吉朗参加2014公共营养师招聘会北京专场', '1', '4');
INSERT INTO `t_information` VALUES ('48', '<p>&nbsp; &nbsp; &nbsp; &nbsp; 2014年11月18日，安吉朗第一期产品培训会在北京总部召开，公司合作伙伴日本健康食品有限公司、苏州恒润达进出口有限公司代表出席，并为安吉朗全体员工进行为期一天的治疗膳食产品知识培训。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 培训会上，日本健康食品有限公司的青柳武士先生首先为大家介绍了治疗膳食在日本的重要性，并结合日本肾病、老年病及糖尿病的临床数据阐述治疗膳食的相关知识。同时结合国内的慢性病和治疗膳食的现状，进一步介绍了适合国人食用的治疗膳食，最后分享了日本健康食品有限公司在日本各地区的市场策略及运营经验。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 现场员工与青柳武士先生积极互动，及时解决各种疑惑。现场膳食试吃活动更是从视觉、嗅觉、味觉上深入了解了各类治疗膳食的性状及感官品质。参会人员收获颇丰，对产品的认识和理解有了很大的提升，通过培训，进一步明确了治疗膳食发展的重点和方向，拓宽了业务知识，提升了专业水平，保证了各地区员工准确地把治疗膳食带给每一位需要的患者，最大限度延缓患者的病情进展，最大程度改善患者的生活品质。</p>\r\n', '2015-01-22 01:56:46', '53', '安吉朗第一期产品培训会在北京召开', '1', '5');
INSERT INTO `t_information` VALUES ('49', '<p>&nbsp; &nbsp; &nbsp; &nbsp; 2014年12月6日，2014北京医学会临床营养专业学术年会在北京协和医院教学楼二层多功能厅召开，来自京津冀地区的数百位临床营养专家与学者参会。本次会议旨在大力推广和介绍临床营养在临床医疗中的新进展，规范临床路径，分享新型的医用食品及新型的监测手段，以期进一步提高北京地区临床营养人员的学术和专业水平，同时集中京津冀三地优势构建临床营养学科建设平台。安吉朗受邀参加了本次会议，在会场布设展台，展出的多种治疗膳食产品受到与会专家的极大关注。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 安吉朗治疗膳食产品主要针对肾病、老年人、糖尿病人等特殊人群，基于日本的先进科技与生产工艺，提供美味、安全、健康的营养膳食，特别是肾病治疗膳食，极大地提高了慢性病人的饮食生活质量，填补了低蛋白食品在国内的销售空白。安吉朗产品均产自日本，在日本当地已有多年临床实践经验，吸引到的众多与会营养师到台前咨询交流，同时肾内科、内分泌科技儿科的与会专家也安吉朗治疗膳食产品兴趣浓厚。</p>\r\n', '2015-01-22 09:21:51', '543', '安吉朗参加2014北京医学会临床营养专业年会', '1', '6');
INSERT INTO `t_information` VALUES ('50', '<p><img src=\"http://mmbiz.qpic.cn/mmbiz/fTSPArOWRMP6ibfNeXvdXH3Ys5ysSo130TkausAaicAVKVA73gicxD0tKRSftql4ibNsQaVeVCBN2uWpxSQsfEickhw/0?tp=webp\" style=\"height:auto !important; margin:18px 0px -6px; width:698px\" /></p>\r\n\r\n<p>&ldquo;&nbsp;谁该看&nbsp;营养门诊 &rdquo;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>1、强烈推荐<br />\r\n妊娠期、糖尿病、消化道疾病、肥胖、慢性肾病。<br />\r\n<br />\r\n一般推荐<br />\r\n肿瘤、高血压、高血脂、高尿酸等代谢综合征患者，乳母、老年人。<br />\r\n<br />\r\n其实一般人都可以来转转</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>2、你能得到什么？</p>\r\n\r\n<p>相比于其他专科<br />\r\n营养门诊交流时间长，沟通更加充分营养医师会根据患者个体情况调整饮食方案，如果有需要还可能提供肠内营养制剂方案。除了身高体重、腰围、上臂围测量外，常见的有测量皮下脂肪的皮褶厚度计，体脂仪。很多医院还有人体成分分析仪、甚至是测量基础代谢的代谢车等等，可以帮助测定一天所需热量、体内脂肪、肌肉含量等等。但是由于国内往往没有相应的收费标准，免费做又收不回成本，所以开设这些项目的医院并不是很多。另外一方面就是血液生化检查了，血红蛋白、白蛋白、微量元素等等，一般在较为顶尖的医院才有开展。<br />\r\n<br />\r\n与看书、看电视的区别<br />\r\n我接触过太多不靠谱的信息，也经常在网上和电视上做科普宣传，我认为如果观众有批判精神，不断求证、能够分辨事实和观点的区别，有选择性地接受信息，那么&ldquo;最好的医生是自己&rdquo;这句话并没有错。但事实与此相反，媒体为了影响力自然要选择一些吸引眼球的观点，往往导致传播出的信息不全面，容易让普通老百姓听风就是雨，反而忽略了均衡饮食和膳食结构的重要性.具体来说，主动来营养门诊的很多都是受教育程度较高的年轻女性，其中有不少人听了很多健康饮食的说法，具体食物都特别&ldquo;健康&rdquo;，但肉吃得很少、食物种类也很单一，结果几乎全都有贫血的症状，反倒营养不良了.而营养师则可以全面系统、细致地发现你饮食中的问题，给出建议和长期的指导。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>3、做什么准备？</p>\r\n\r\n<p>上好大夫网等地方查询附近医院营养门诊情况，尽量提前预约。<br />\r\n提前三天做一个饮食记录，包括进食种类、量、地点，方便营养师进行分析。<br />\r\n带上最近一年的体检报告、检查单以及病历，梳理一下自己的不适症状以及疑惑。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>4、如何判断服务质量？</p>\r\n\r\n<p>首先得声明的一件事是，完整的营养干预不是一次就能搞定的，首诊以及多次随诊都很有必要，另外像首诊如果配合膳食史调查起码需要30分钟以上的时间，而这也就意味着按照这个时间一个下午的门诊最多看6个患者，而实际上热门一点的营养门诊半天门诊量都在10个以上，时间有限很多内容只好长话短说了，很多流程也只好省略了，因此仅靠一次有限的门诊很难完整判断出一位营养师的专业水准。<br />\r\n<br />\r\n具体患者可以通过这么几个角度来判断：①膳食史询问是否详细，对于职业、生活方式是否关注 ②病历填写是否认真，饮食处方是否实用和详细（包括诊断、目标、注意事项） ③听闻你个人信息后营养师的反应是否有条理 ④对于营养之外疾病或特殊生理期的情况是否了解，能做出简明扼要的说明 ⑤可否对效果做出一定程度上的预估，同时态度诚恳，承认营养的局限以及需患者自身积极的配合。 ⑥自己不断学习，从网上了解一些资料，与营养师交流。</p>\r\n', '2015-01-22 09:10:50', '34', '专家为你解读，你是否需要看营养门诊？', '8', '1');
INSERT INTO `t_information` VALUES ('51', '<p>&nbsp; &nbsp; &nbsp; &nbsp; 2015年1月23-25日，中国医师协会营养医师专业委员会2014年年会在北京鑫海锦江大酒店国际会议厅举行，本次会议总结了近几年学科建设的经验与成功模式，探讨临床营养学科管理规范、人才规范化培养，同时探讨标准化临床营养学科建设方案，并传递国际国内最新前沿学术知识。安吉朗出席本次会议，会上展出日本原装进口治疗膳食，因品种多，覆盖广、口感优而引起现场专家的广泛关注。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 在会上，众多讲者与大家分享了各自的临床营养的实践心得。其中，广东省红十字会医院谭荣韶教授的报告《慢性肾病低蛋白营养治疗实践》引发现场嘉宾的浓厚兴趣。谭教授首先肯定了低蛋白食品在慢性肾病营养治疗方面的重要性，指出尽早开展低蛋白饮食对慢性肾病的保护作用更加有效。另外，谭教授从自身多年临床经验出发，指出低蛋白饮食有效、依从性和安全性并不低，关键在于在实践中如何去落实，可以从患者教育、定期指标检测及加强医患交流等方面加强低蛋白饮食在肾病人群营养治疗中的作用。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 低蛋白食品是安吉朗的旗舰类产品，种类覆盖主食、方便食品、零食、饮品及能量补充剂等多个类别，能够满足各类慢性肾病人群的不同需求，如真理米（低蛋白米），日本原装进口产品，每100g米中蛋白含量0.2g，是目前全球销量最好，科技含量最高，食用口感最好的低蛋白米。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>现在安吉朗全部治疗膳食产品接受预订，</p>\r\n\r\n<p>预订方式：</p>\r\n\r\n<p><a href=\"http://www.angelaround.com/shop/\">官方商城</a></p>\r\n\r\n<p>热线：400-010-1166</p>\r\n', '2015-01-27 11:01:20', '22', '安吉朗参加中国医师协会营养医师专业委员会2014年年会', '1', '2');
INSERT INTO `t_information` VALUES ('52', '<p>导语：这里有专家，这里有知识，这里有贴心的指导和细致的关怀。这里是安吉朗为您精心打造的高端平台专访。</p>\r\n\r\n<p>安吉朗网络平台的各位朋友，大家好！</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 应广大平台用户和各方朋友对营养健康知识和权威指导的急切渴望，安吉朗特为大家精心策划推出一系列的权威专家采访节目，让膳食营养界专家与您零距离接触，为您答疑解惑。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 今天做客我们专访平台的是有着多年临床经验的北京空军总医院营养科主治医师景洪江教授。首先非常感谢景教授在百忙之中抽出时间接受安吉朗的专访。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：景教授，那么随着近些年来不健康隐患的不断增加，健康意识真的是越来越深入人心了。我们都知道饮食均衡，营养全面才是健康的基础，那么在我们的日常生活中，如何才能达到这样的健康状态呢？有哪些需要注意的地方？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 景教授：要达到饮食均衡、营养全面首先要了解每天应该摄入的食物种类：第一类为主食即五谷杂粮类，包括各种米、面、杂豆制品及薯类，第二类是蔬菜和水果，第三类是肉鱼蛋奶豆类优质高蛋白食物，第四类是烹调用调味品油和盐；其次要知道每类食物应该食用的平均数量，如主食全天一般在5～8两左右，最少也不应少于3两，可根据体力活动、体重、生理及饥饿等情况进行适当调整，蔬菜每天6两～1斤，水果4～8两，鸡蛋每天半个～1个，奶类200～400ml，鱼虾瘦肉类3～4两，大豆25g，植物油25g，食盐5g；再次要注意食物之间的搭配和食用时间，如食物应多样化，每日三餐均应有主食，主食适当粗细粮搭配，副食要荤素搭配，绿叶与根茎、瓜茄类及各种颜色蔬菜经常变换或搭配食用，鸡蛋可在早餐食用，奶类可在早餐或餐间、睡前食用；最后要注意烹调和加工制作方法，尽量减少油煎炸、烧烤、腌制等容易破坏营养成分、产生有害或致癌物的烹调方法，蔬菜做到先洗后切、急火快炒、开汤下菜、尽量生食等减少营养流失和破坏的做法。除此之外，还要注意以下几点：⑴少量多次地足量饮水，每日不少于6杯（每杯200ml）；⑵坚持每天适量运动，保持健康体重；⑶禁止吸烟，如饮酒，应限量；⑷注意生活规律，保证充足睡眠。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：听了景教授全面而清晰的讲解，大家是不是受益匪浅？这里建议大家结合自身日常饮食习惯与景教授所讲的内容做下对比，看看有哪里需要改正的，让我们离健康更近一步。其实说到健康饮食就不可避免地会涉及到现代人外出就餐的问题。现在大多数人（尤其是年轻人）因为工作繁忙、应酬多等缘故，很多时候在外或快餐解决，随之而来的是肥胖、脂肪肝、血脂异常等等的健康问题，对于这样的一个群体，应该如何去调整饮食结构，即使有不可推脱的饭局又该如何去保证营养均衡？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 景教授：对于这样的人群，在饮食结构上应该低盐低脂高蛋白，蛋白质食物以豆制品及鱼虾等低脂肉类为主，适当增加素食比例，饮食要清淡，主食要限量；在不可推脱的饭局上要放慢进食速度，小口吃菜，尽量增加咀嚼时间，在进食顺序上可先喝些汤、粥，再吃素菜，控制肉类及主食摄入量，还要注意食物多样化。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：怎么样各位应酬多的青年朋友，从现在开始要引起注意啦。说完青壮年的问题我们来替老年人请教些问题。我们知道人老后身体的各项机能就会下降，尤其是老人的牙齿问题，对于很多食物无法很好的食用与消化吸收，因此对于老人该如何调整营养，保证营养摄入足够？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 景教授：对于老年人，在食物的烹调和制作加工方面，可多用炖、熬、蒸、煮等方法，食物要烧烂做软；富含纤维的绿叶蔬菜适当切碎一些，瘦肉类可搅成肉泥后汆成丸子或蒸肉羹；主食可采用软米饭或发糕、面条、稠粥、小面片、小馄饨、发面馒头等容易咀嚼的食物，鸡蛋可做成蒸蛋羹；可采用适当加餐、增加进餐次数的方式来保证营养摄入。如果进食量仍少或明显消瘦，建议适当采用营养配方粉类加餐以补充部分营养。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：那么对于一些术后的老人，在进食上存在很大的困难，但此时若不能很好的进食会加重养不良，影响康复，对于这种情况有没有较好的营养给予方式？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 景教授：对于术后进食困难的老年人较好的营养给予方式是口服各种特殊医学用途配方食品（FSMP），如全安素、佳膳纤维、速愈素、安吉朗治疗膳食等，根据进食和营养状况可适当用来加餐或代餐。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：还有一些老人中风后遗留下来饮水呛咳，吞咽困难的症状，现在市场上有一类增粘稠产品，可以使液体粘稠化，解决老年人吞咽困难的问题，此类产品是否可用？有没有更有效的方法解决老年人吞咽困难的问题？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 景教授：增稠剂类产品可以解决这些老年人饮水呛咳的问题，但不能从根本上解决老年人吞严重的咽困难的问题。目前临床上对于吞咽障碍尤其是饮水呛咳的老年人一般多采用鼻饲管或胃造口的方法，可以很好地解决营养问题，但长期带管必然会影响生活质量。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：是的，尤其是患有基础性疾病或留有相关后遗症的老人，他们的营养健康等各方面确实需要我们格外关注。所谓老有所需嘛。那么困扰老人的另一个问题就是便秘，很多老人都有或轻或重的便秘问题，严重的甚至威胁生命，目前是否有行之有效的方法解决这</strong><strong>一问题？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 景教授：对于老年人的便秘，以下措施可能会有一些帮助：⑴采用适宜的烹调方法尽量保证每日蔬菜的摄入量；⑵保证每日水果摄入量；⑶适当增加薯类、杂豆等粗粮食物；⑷如身体条件允许要保证一定的活动量；⑸保证每日足够的饮水量；⑹早上空腹可用凉开水冲服适量蜂蜜；⑺每天服用益生菌酸奶或养乐多饮料；⑻服用水溶性膳食纤维粉剂每日1～3次；⑼益生菌与益生元制剂结合服用；⑽结合乳果糖口服液、芦荟胶囊、芪蓉润肠口服液等促进排便药物。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：我们注意到</strong><strong>刚刚景教授提到了膳食纤维。它可以帮助人体肠道蠕动，是人体重要的营养素之一，那么哪些食物中膳食纤维含量多？膳食纤维是否也能一定程度上解决便秘的问题？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 景教授：富含膳食纤维的食物包括芹菜、韭菜等各种绿叶蔬菜、魔芋、藕、豆类、菌藻类、水果、粗杂粮等。如果是与食用这些食物偏少相关的便秘，那么适当增加这些食物的摄入就可能会在一定程度上解决便秘的问题；另外目前市场上已有多种水溶性膳食纤维粉制剂，在防治便秘方面也有很好的效果。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：好的，非常感谢景教授今天的亲临指导。各位朋友以上就是本次专访的所有内容，再次感谢景教授。安吉朗祝您身体健康，工作顺利！</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n', '2015-02-02 12:14:00', '0', '专访北京空军总医院营养科主治医师景洪江------安吉朗“营养与健康”专家访谈（第一期）', '4', '3');
INSERT INTO `t_information` VALUES ('53', '<p>安吉朗网络平台的各位朋友，大家好！</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 应广大平台用户和各方朋友对营养健康知识和权威指导的急切渴望，安吉朗特为大家精心策划推出一系列的权威专家采访节目，让膳食营养界专家与您零距离接触，为您答疑解惑。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 今天做客我们专访平台与大家交流沟通的是从事肾病临床工作多年的武汉同济医院肾病内科主任姚颖教授。首先非常感谢姚颖教授在百忙之中接受安吉朗的专访。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 安吉朗：姚教授您好，非常感谢您在百忙中接受安吉朗的专访，安吉朗致力于特殊医用膳食产品的研发及销售，努力在互联网打造一个基于营养科学与膳食健康的医患交流平台，您作为实践于营养健康领域优秀的专家学者，希望在与您的沟通交谈中，使广大治疗膳食需求人群在营养饮食方面能有比较深入的了解与认识，建立一个正确的健康生活观。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：姚教授，我们注意到一个非常可怕的数字，中国肾病患者总数为</strong><strong>1.2</strong><strong>亿，约占</strong><strong>10%</strong><strong>的人口规模，这似乎跟我们日常的对肾病的认知不太相符，但又是一个实在的冷冰冰的事实，你怎么看待这个问题你？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 姚教授：2012年在&ldquo;柳叶刀&rdquo;上发表的由北大第一医院肾内科王海燕教授牵头的中国慢性肾脏病流行病学调查结果显示，我国成年人群中慢性肾脏病的患病率高达10.8%，这提示慢性肾脏病在我国已成为最常见的慢性非传染性疾病之一，但其知晓率仅为12.5%，与慢性肾脏病的高发病率极不平行。因为慢性肾脏病起病隐匿，症状不典型，可能有的一些症状如头昏、头痛、腰酸、眼睑水肿、夜尿增多等往往被忽略，所以慢性肾脏病常被称为&ldquo;隐匿的杀手&rdquo;，因此我们要加强对慢性肾脏病认识和防治知识的普及，早知、早防、早治。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：姚教授用精准的数字做了详细而清晰的解答，想必中国肾病现状也是惊到了您。那么日常生活中会有哪一部分人群是肾病易感人群吗？有哪些方法使我们远离肾病，又有哪些方法能够在早期发现肾病的发生？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 姚教授：肾病的易感人群主要包括：糖尿病患者、高血压病患者、代谢性疾病（如肥胖、高血脂、高尿酸等）、肾脏病家族史（如多囊肾等）、65岁以上的老年人、长期使用肾毒性药物（如非甾体类消炎药、含有马兜铃酸或其他成分不明的中药等）、慢性泌尿系感染、尿路梗阻反复发作、独肾、病毒性肝炎患者、过度吸烟、饮酒、自身免疫性疾病、长期高蛋白、高脂饮食等。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 远离肾病的方法：首要是保持健康的生活方式和饮食习惯，如低盐、低脂饮食，远离烟熏烧烤等&ldquo;垃圾&rdquo;食品、同时要控制体重、其次要控制血糖和血压水平、慎用引起肾脏损害的药物、纠正高尿酸血症等。当然了解肾病的基本知识、定期筛查有助于远离肾脏病。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 早期发现肾病的方法：首先关注一些早期信号：如疲劳、乏力、眼睑颜面浮肿，尤以晨起明显、尿中泡沫增多、尿色异常、尿频、尿急、夜尿增多、不明原因的腰痛、血压增高（特别是年轻人）；其二要定期健康检查，包括尿常规、肾功能和肾脏超声检查等。其三要对高危人群定期筛查。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：我们知道肾功能发生异常，一般来说在饮食上的干预手段是减少蛋白的摄入量，在我们日常的饮食中，哪些食物的蛋白质含量比较高，肾病人群应该少吃，哪些食物的蛋白含量低，可以多吃？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 姚教授：日常饮食中肉类、坚果类、豆类、蛋类、水产和奶制品等蛋白质含量比较高；其次是谷类、菌类、鲜豆、某些蔬菜（如白菜、西兰花等）；蛋白质含量低的主要是水果、蔬菜（如丝瓜、西葫芦等）。值得一提的是减少蛋白的摄入量，是提倡优质低蛋白饮食，也就是说在限制蛋白质总量的前提下，必须有50%-60%的蛋白质来自优质蛋白质，如奶类、蛋、鱼、禽、肉和大豆及大豆类食品。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：那么您提到了优质蛋白和非优质蛋白的问题。因为我们日常的很多食物中都含有蛋白，如要控制蛋白的摄入，我们应该进行怎样的取舍，才更有利于我们的健康，又能够提升生活的质量？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 姚教授：在保证足够能量的前提下，强调优质低蛋白饮食, 因为单纯强调低蛋白饮食，很容易导致患者出现蛋白质-能量消耗（PEW），导致营养不良。优质蛋白是指那些容易被人体消化、吸收，吸收后利用率高、含必需氨基酸丰富的食物，如动物性食物和大豆及大豆制品，优质蛋白应占总蛋白的50%-60%；同时建议患者采用低蛋白淀粉作为主食，如低蛋白大米、低蛋白面粉、麦淀粉、玉米淀粉、藕粉、粉皮等。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：有的患者反应，为了减少蛋白的摄入，严格控制进食量，吃的很少，但去医院检查发现，相关的指标（血肌酐、尿素氮）反而上升了，很奇怪，如何解释此类现象？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 姚教授：有些患者为了所谓的低蛋白饮食，而严格控制进食量，吃得很少，这样摄入的能量肯定不足，容易导致负氮平衡，反而出现尿素氮等指标的上升。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：提到肾病患者饮食的问题，我想到之前有听专家介绍，肾病人群的主食选择很重要，怎样理解这个说法？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 姚教授：的确如此。俗话说&ldquo;民以食为天&rdquo;，中国人的饮食习惯就是强调一天要有三餐饭，这样对于肾病人群主食的选择就显得尤为重要。又要保证能量、又要强调优质低蛋白饮食、又要让患者觉得自己是吃饱了，没饿着。我们知道，谷薯类属于非优质蛋白质，50g谷薯类蛋白质的含量是4g，那一天主食如按300g计算，蛋白质就是24g，往往超标，所以对于肾病患者，特别是已有肾功能不全的患者，建议采用低蛋白淀粉作为主食。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：姚教授刚刚提到了低蛋白淀粉这个词。对于现在市面上的低蛋白食品，您觉得是否能在肾病人群的膳食治疗中发挥重要作用？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 姚教授：现在市面上的低蛋白食品很多，如果能正确使用，肯定能在肾病人群的膳食治疗中发挥重要作用。但值得关注的是，低蛋白食品优化了摄入蛋白结构，改善了蛋白质代谢，是延缓慢性肾病进展、提高患者生活质量的一个有效措施，但机体是一个整体，作为慢性肾病的营养干预，必须全面改善蛋白质、脂肪和糖代谢，才能实现慢性肾脏病患者的综合营养管理，从而延缓肾脏病进程。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：说完饮食问题后，我来替平台上的一位用户向姚教授请教一个问题。这位用户听说肾病患者忌劳累，因此有些肾病患者整日卧床，不敢下地活动，这是正确的做法吗？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 姚教授：肯定不对。忌劳累不等于整日卧床，除非是患者在急性肾炎有肉眼血尿、高血压和肾功能损害时，建议卧床休息；否则长期卧床，容易导致血栓形成、肺部感染、肥胖、高血糖、高血脂不宜控制等。&nbsp;</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：听了姚教授以上的讲解，我们更加体会到肾病是个非常复杂的有着庞大体系的疾病。相对其他疾病而言，在个人对疾病的处理方法上，可能会存在一定的误区和盲点，在姚教授这么多年的临床实践中，有没有特别想跟大家分享的心得体会？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 姚教授：从事肾脏病工作已经23年了，的确有很多心得体会愿和大家分享，简单概括，有以下几点：</p>\r\n\r\n<p>其实肾脏病是可防可治的，关键是在日常生活中养成健康的生活习惯，定期体检，不要忽略乏力、腰痛、颜面及眼睑浮肿、尿中泡沫增多、尿色加深、夜尿增多等蛛丝马迹，早期发现，早期治疗；</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 得了肾脏病也不要一下子就觉得天要塌下来了，好像马上要透析了，应该尽快到肾病专科医生那就诊，及时治疗；</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 肾脏病的防治强调三级预防：一级预防是通过饮食和生活方式的调整预防慢性肾脏病的发生；二级预防是通过饮食和生活方式的调整，延缓肾脏病进展和肾功能的恶化, 预防CKD的并发症发生；三级预防是要及时检出其营养不良并给予适当的干预措施，减少因营养不良导致的死亡；</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 营养治疗，特别是膳食治疗在慢性肾脏病的一体化治疗中起着举足轻重的作用，贯穿肾脏病治疗的全过程；</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 在膳食治疗中，最为重要的是优质低蛋白饮食，而真正实现低蛋白饮食的重要手段是采用低蛋白淀粉，包括低蛋白米等作为主食，同时要注意a-酮酸的补充；</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 医务工作者一定要有耐心、爱心对患者及家属进行相关营养知识的宣教，如教会病人如何在家中做到优质低蛋白饮食，告诉她们低蛋白不是指就不能吃蛋白含量较高的优质蛋白；告诉病人低盐不等于无盐等，让病人及家属也参与其中，从营养治疗做到营养管理；</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 肾脏病的营养治疗应该做到个体化的治疗；</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 作为慢性肾病的营养干预，必须全面改善蛋白质、脂肪和糖代谢，才能实现慢性肾脏病患者的综合营养管理，从而延缓肾脏病进程。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：感谢姚教授分享了自己从事肾病临床工作二十余年积累的宝贵经验，可谓真的是字字珠玑，价值连城！希望广大肾病人群能够看到学到用到。也希望姚教授今后能再次做客我们的平台，为大家带来知识增强信心。好了以上是本次专访的所有内容，再次感谢姚教授。安吉朗祝您身体健康，工作顺利！</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n', '2015-02-02 12:14:27', '33', '专访武汉同济医院肾病内科主任姚颖 ------安吉朗“营养与健康”专家访谈（第一期）', '4', '4');
INSERT INTO `t_information` VALUES ('54', '<p>安吉朗网络平台的各位朋友，大家好！</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 应广大平台用户和各方朋友对营养健康知识和权威指导的急切渴望，安吉朗特为大家精心策划推出一系列的权威专家采访节目，让膳食营养界专家与您零距离接触，为您答疑解惑。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 今天做客我们专访平台的是在临床营养界有极为丰富经验的北京医院营养科主任孙明晓教授。那么也是十分感谢孙教授在出诊后挤出时间接受安吉朗的这次专访。感谢您的到来，让活跃在我们安吉朗医患交流平台上的各位能有机会直面专家，使广大治疗膳食需求人群在营养饮食方面能有比较深入的了解与认识，建立一个正确的健康生活观。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：我们知道孙教授在北京医院每周都有门诊，那么前来挂号咨询的患者一般哪种情况居多，近些年都有哪些明显的变化趋势吗</strong><strong>?</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 孙教授：最多的是寻求糖尿病饮食治疗以及肥胖者进行减重治疗的，其次为老年人消瘦希望改善体质的，近来妊娠糖尿病患者也有所增多。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：那么您刚才提到了肥胖问题。确实肥胖给人们带来诸多困扰，爱美之心人皆有之，更何况有些肥胖已经是一种疾病症状。一般来说针对肥胖的治疗方式主要包括哪些，您最推崇的方式是哪个</strong><strong>?</strong><strong>另外还需要哪些方面的配合？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 孙教授：针对肥胖的治疗方式主要有饮食、运动、药物和手术治疗。我认为所有的减重患者都应在个性化评价下进行饮食和运动干预，药物和手术治疗需要根据患者的病情程度全面权衡后决定实施。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：孙教授，如您所说现在肥胖的就诊人群越来越多了，不知肥胖和糖尿病的发生发展有哪些关联，体胖者是糖尿病易患人群吗</strong><strong>?</strong><strong>这种说法有科学依据吗？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 孙教授：肥胖者与2型糖尿病的发生发展几乎可以说有必然的联系。只要肥胖到一定程度，通常会产生不同程度的糖代谢障碍，该观点已经得到广泛的证实。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：我们经常听说糖尿病患者群中</strong><strong>2</strong><strong>型糖尿病居多，</strong><strong>1</strong><strong>型和</strong><strong>2</strong><strong>型糖尿病的区别在哪里？在生活中我们应该从哪些方面着手，能够使我们远离糖尿病？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 孙教授：2型糖尿病在我国占糖尿病总人数的90%以上。从病理生理上看，1型糖尿病主要为胰岛b细胞受到免疫攻击后发生胰岛素分泌绝对缺乏，使得机体不能利用葡萄糖。1型糖尿病目前没有好的预防手段；2型糖尿病为b细胞分泌缺陷和胰岛素功能障碍（胰岛素抵抗）共同作用导致血糖升高。生活中保持理想的体重可以预防胰岛素抵抗的发生，在一定程度上能降低糖尿病发生风险。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：那么如果有糖尿病家族史，是不是更应该注意糖尿病的防范，糖尿病初期会有哪些症状应该引起我们的注意？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 孙教授：是的。遗传是糖尿病发生的重要机制，有家族史的个体应格外注意生活方式，控制体重的异常增长，以延缓糖尿病的发生时间。糖尿病（2型）初期往往没有典型的症状，轻度的疲乏、口干是常见的临床表现。最好的办法是每年进行查体，有家族史的个体体重增长超过理想范围可行糖耐量试验明确诊断。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：听了孙教授的讲解，想必大家对以上问题都有了更深的了解，那么糖尿病患者在饮食上应该注意哪些方面呢，有人说喝蜂蜜易得糖尿病，这是真的吗？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 孙教授：糖尿病患者主要应根据营养状况和体力活动水平制定总能量的摄入，在此框架下给予均衡饮食。喝蜂蜜并不会导致糖尿病，总能量一定的前提下，糖尿病患者也可适量摄入蜂蜜。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：我们说糖尿病人不能吃砂糖，那现在市面上销售的木糖醇、麦芽糖醇等代替砂糖的食品，糖尿病人可以吃吗？对吃的量有哪些限制呢？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 孙教授：木糖醇和麦芽糖醇等甜味添加剂，甚至包括蔗糖本身都可以用于糖尿病患者，关键是量的选择，更重要的是这些添加剂的使用、口感的改善可能导致进食量的增多，对血糖影响更大，需要特别注意。限制原则同饮食控制原则，见第6问。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：说到限制原则，很多人认为糖尿病应该少吃，可是糖尿病病人一天摄取多少热量能量合适？在不超过总能量摄入量前提下少吃多餐，是不是一个科学的血糖控制方法？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 孙教授：首先，糖尿病并不需要一味少吃，吃多少要个性化设定，比如超重且轻体力活动水平患者总能量建议25kcal/kg(理想体重)/天。具体原则同上。此外，老年人与非老年人也应有所不同。少吃多餐并不适用于所有患者，还要根据患者的具体血糖水平和治疗方案综合考虑。此法比较适合妊娠糖尿病，糖尿病以餐后升高为主和/或伴有餐前低血糖风险者。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：好的，因为时间关系我们今天的专访就先到这里了。十分感谢孙教授的悉心讲解，您辛苦了！各位朋友以上就是本次专访的所有内容，再次感谢孙教授。安吉朗祝您身体健康，工作顺利！</strong></p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n', '2015-02-02 12:17:28', '44', '专访北京医院营养科主任孙明晓------安吉朗“营养与健康”专家访谈（第一期）', '4', '5');
INSERT INTO `t_information` VALUES ('55', '<p>&nbsp;</p>\r\n\r\n<p>安吉朗网络平台的各位朋友，大家好！</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 应广大平台用户和各方朋友对营养健康知识和权威指导的急切渴望，安吉朗特为大家精心策划推出一系列的权威专家采访节目，让膳食营养界专家与您零距离接触，为您答疑解惑。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 今天做客我们专访平台的是在临床营养界有极为丰富经验的北京协和医院营养科主任陈伟教授。首先非常感谢陈伟教授在百忙之中接受安吉朗的专访。感谢您的到来，让活跃在我们安吉朗医患交流平台上的各位能有机会直面专家，使广大治疗膳食需求人群在营养饮食方面能有比较深入的了解与认识，建立一个正确的健康生活观。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：据我们了解，陈教授除日常工作外，近年来从事了大众健康的宣传教育工作，也曾多次借助媒体平台与患者进行近距离的交流，您觉得现在大众对于营养健康的认识是一个怎样的水平，有没有一些普遍的认知误区？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 陈教授：目前国内大众对于健康的关注程度正逐年倍增，同时由于中国自古以来&ldquo;药食同源&rdquo;理念的深入人心，多数中国大众非常关注营养与健康的关系，并且非常愿意为获得健康买单。但是由于整体人群科学素养偏低，同时国家性质管理相对滞后，使得很多患者通过电视媒体获得知识，而产生偏听偏信，甚至上当受骗的情况。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：就您刚刚提到的情况在这要提醒大家，关注营养健康的同时更要学会辨别真假。我们知道现在老百姓的日子越来越好，可是伴随而至的疾病也多了起来，例如似乎现在很多人都&ldquo;三高&rdquo;症状，而且有年轻化的趋势，您觉得年轻人应该如何避免这种情况的发生？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 陈教授：慢性疾病的年轻化的确是中国的一大困难现状，要想避免这样的情况，需要掌握几项内容，（1）全社会宣传健康知识，提高健康意识；（2）宣传健康饮食知识，建立良好的生活方式，包括合理饮食、积极运动、戒烟限酒、心理平衡；（3）加强监测，从年轻开始加强监测，早防早治。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：说道慢性病就一个我们不得不提的慢性疾病&mdash;&mdash;糖尿病。据我们所知，目前糖尿病人群是一个比较庞大的问诊患者人群，那么糖尿病患者应该如何正确看待这种疾病</strong><strong>?</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 陈教授：中国近一亿的糖尿病患者，95%都属于代谢性疾病，其中多半属于超重或肥胖人群，因此，通过控制糖尿病病情发展，可以同时减轻胰岛素抵抗带来的整体危害。从营养健康着手，将体重达标作为主要营养干预目标，最终全面改善健康。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：刚刚陈教授也提到了控制糖尿病病情发展的重要性，我们知道，糖尿病的危害还有一部分在于其引发的并发症，目前针对糖尿病有没有比较可靠有效的干预方法？</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp;陈教授：目前全球各国共识的糖尿病干预均为综合干预方法，以营养治疗、运动治疗、心理及教育疗法、病情监测以及必要的药物治疗都是糖尿病可靠的控制方法。其中营养治疗已经越来越多得被广大医务人员认可，并且在中国已经出版糖尿病医学营养治疗指南，提供技术支持。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：就如您所提到的糖尿病多半由于超重或肥胖引起，因此，有些糖尿病病人很认真，为了不让血糖升高，每天严格控制能量的摄取，那么糖尿病患者每天摄入多少能量算是在一个比较科学合理的范围？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 陈教授：一般来说，成人糖尿病患者能量摄入范围以达到或维持理想体重为标准，同时希望血糖控制达标，就能维持在科学合理范围。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：陈教授，据了解很多人得了糖尿病，含淀粉的主食的不敢多吃，这种做法是对的吗？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 陈教授：糖尿病患者仍应保持充足的碳水化合物的摄入，含淀粉的主食相比精制糖来说，并不会造成血糖过多升高。含淀粉的主食多是复合碳水化合物，添加膳食纤维或者降低血糖指数能够有效改善血糖控制，都是可以选用的。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：说到这又一个问题要陈教授您解惑。很糖尿病患者不太敢吃水果，有时实在想吃水果，会吃那些口感不太甜的种类，比如火龙果，猕猴桃等等，您觉得这类水果会更适合糖尿病人食用吗？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 陈教授：不一定，本身糖尿病患者是可以并且应该将水果作为日常选择，选择水果不以口感为准，而应该以含糖量和血糖指数为准。火龙果、猕猴桃虽然口感不甜，但是含糖量并不低，在选择时仍应以含有的具体碳水化合物为准。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：陈教授，现在市面上很多无糖产品，成分像是木糖醇和麦芽糖醇，此类产品对于糖尿病人群可以食用嘛？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 陈教授：木糖醇和麦芽糖醇都属于营养性甜味剂，本身也含有能量，但是在代谢中不需胰岛素参与，因此可以少量用于产生甜味，带来良好的口味，而如果是做成甜味剂的主食，则仍需要考虑其能量影响血糖。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：</strong> <strong>爱美之心人皆有之，尤其是广大的女性朋友，那么对于想瘦身塑形的女性朋友，陈教授您有什么建议？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 陈教授：适当限制能量，减少纯糖食物和高脂食物的摄入，增加体育锻炼才能真正控制好体型。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：好的，因为时间关系我们今天的专访就先到这里了。十分感谢陈教授的悉心讲解，您辛苦了！各位朋友以上就是本次专访的所有内容，再次感谢陈教授。安吉朗祝您身体健康，工作顺利！</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n', '2015-02-02 12:17:41', '66', '专访北京协和医院营养科主任陈伟 ------安吉朗“营养与健康”专家访谈（第一期）', '4', '6');
INSERT INTO `t_information` VALUES ('56', '<p>安吉朗网络平台的各位朋友，大家好！</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 应广大平台用户和各方朋友对营养健康知识和权威指导的急切渴望，安吉朗特为大家精心策划推出一系列的权威专家采访节目，让膳食营养界专家与您零距离接触，为您答疑解惑。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 今天做客我们专访平台的是北京煤炭总医院营养科仝慧君教授，仝教授对营养健康方面有多年的实践经验，首先非常感谢仝教授在百忙之中抽出时间接受安吉朗的专访。感谢您的到来，让活跃在我们安吉朗医患交流平台上的各位能有机会直面专家，使广大治疗膳食需求人群在营养饮食方面能有比较深入的了解与认识，建立一个正确的健康生活观。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：</strong><strong>如今，不论是牛奶、猪肉、鸡蛋，还是瓜果蔬菜，几乎都出现过食品安全问题，而我们的生活又离不开它们，如何做到饮食卫生呢？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 仝教授：沙门氏菌主要污染以肉类食物为主，蛋类、奶类也容易受到污染，但沙门氏菌有不耐热的特性，高温达100度便可杀死。根据这一特性肉类加工时，块不宜切得过大，炖煮做到大火烧开10分钟后小火慢炖，中心温度不低于70度，就能达到饮食卫生、安全的标准。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 袋装牛奶在加热时，应倒入其他容器中用微波炉高温短时加热，也可放入奶锅中段时煮沸加热，不可将牛奶袋放入热水或微波炉内直接加热。在保质期内也可打开即食，但要注意奶袋外部的清洁，如发现有絮状物不可食用。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 蛋类最好的食用方法是煮蛋，煮到以蛋黄凝固为宜，还可蒸蛋羹、炒菜或做汤。买回后把蛋外皮用冷水洗净放冰箱冷藏。瓜果蔬菜的饮食卫生，在处理上比以前多了一个泡的环节即：整棵洗净，自来水没过菜品泡20分钟，切菜入锅，可去除部分农药、化肥。绿叶菜建议当天买当天吃，不隔夜。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：谢谢仝教授全面而细致的讲解，大家都受益匪浅吧。仝教授，我们日常的饮食离不开牛奶、鱼、肉、蛋，请您介绍一下它们对于我们健康的重要性吧。</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 仝教授：鱼、肉、蛋、奶都属于优质动物蛋白质。畜肉泛指我们平时所说的红肉如：猪、牛、羊等。也是居民目前餐桌上重要的动物性食物。除了为人体提供优质蛋白质和必需脂肪酸外，还可提供血红素铁和促进铁吸收的半胱氨酸，适量食用可改善或预防缺铁性贫血。鱼肉的特点是高蛋白、低脂肪、纤维短，好消化易吸收。鱼肉中的脂肪属于高度不饱和脂肪酸，是人体必需的脂肪酸，对人体有很重要的生理功能，但人体又不能合成，只能从鱼类或其他水产品中摄取。蛋类是自然界中最优良的蛋白质，从一个受精鸡蛋能孵化成一只小鸡，就足以说明鸡蛋的营养十分完美，含有丰富的蛋白质、脂肪、卵黄素、卵磷脂、钙、钾、磷、镁等人体所需的矿物质。卵磷质是人脑中神经递质乙酰胆碱的重要来源，能有增强记忆、延缓脑细胞衰老的辅助作用。牛奶中含有人体生长发育所需的全部氨基酸，消化率高达98%，老少皆宜。最突出的特点是含有人体所需的钙、磷、钾、镁，配比合理，钙容易被人体吸收 也是目前补钙的最好食物来源。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 但再好的食物也不是多多益善，要根据本人的具体身体状况酌情食入。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：仝教授的回答又让我们涨了不少知识。那么，</strong><strong>您对于无公害食品，绿色食品和有机食品如何看待？目前市场上销售的绿色食品、有机食品营养价值会比普通食品高吗？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 仝教授：无公害是市场准入条件，也是最基本的条件。只要农药残留、重金属、有害微生物等卫生指标达到国家标准就可以选用。进入有规模的超市和大型农贸市场的基本符合要求。绿色食品只不过对农药的使用上限制的更严格一些。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 有机食品不允许使用农药、化肥、激素，百姓为了食品的安全不惜花同类食物近十倍的价格购买有机食品。但对有机食品国家是否有监督、检查、追朔、管理等相关的措施，我不太了解。但从食品来讲不是最贵的就是最好的从营养角度来看同样品种，营养成分出入不是很大。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：仝教授，想必您也注意到近来民众对花青素很是关注，市场上也出现了各种富含花青素的食品和饮料，那么花青素对人体的好处主要是哪些呢？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 仝教授：花青素最主要的作用：它是强抗氧化剂。以前知道的维生素E、维生素C抗氧化，但花青素抗氧化的作用大大超过维生素E、维生素C十几倍、几十倍。可有效清除自由基对人体的损伤，有一句话&ldquo;自由基是百病之源&rdquo;，对人体的损伤无处不在，所以花青素间接起到了保护血管、增强血管弹性、改善循环系统功能等作用。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：仝教授，</strong><strong>最近在互联网上宣传以土豆代替部分主食的观点很是火热，您怎么看待这个问题？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 仝教授：土豆在我国广泛种植，内蒙、西北、山西、陕西、张家口等地区土豆含沙高、口感绵，也都有用土豆代替部分主食的悠久历史。如：山西某地区的&ldquo;炒拨烂子&rdquo;就是把土都擦成丝后，拌少量白面蒸熟后，用少许油加洋葱、胡萝卜、柿椒炒食。营养均衡、低盐少油，可做为主食。我觉得，用土豆代替部分主食是必要的回归，咱们国家曾有过&ldquo;瓜菜代&rdquo;的历史阶段，那时是粮食不够。现在是生活好了、物质供应极大丰富，但慢性生活方式疾病高发。同土豆代替部分主食其实对每一个人都有需要。口感脆的可以用于菜肴，口感面的完全可替代一餐或部分主食。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 土豆的营养成分齐全，除了含有蛋白质、脂肪、碳水化和物外，还含有丰富的钾、维生素C、丰富的粗纤维、多种维生素、微量元素。土豆的热量低，淀粉中有部分抗性淀粉，能起到延缓餐后血糖升高的作用丰富的钾可起到舒张血管、保护心脏、调节钾钠平衡的作用。粗纤维有促进肠道蠕动，加速胆固醇在肠道代谢，有预防和改善便秘的作用。对于糖尿病、肥胖、血脂异常、高血压、心脑血管等慢病病人，用土豆代替部分主食应该是不错的选择。蒸、煮、烤、做成土豆泥小饼、土豆小米饭等均可。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：看来土豆是一种不错的食材，对于想保持身材的女性人士也可放心食用。谈到养生，大家首先想到的是清淡饮食，可</strong><strong>我们知道大多数四川人喜辣，与养生人士所推崇的清淡饮食背道而驰，那么辣椒对人体健康有着怎样的影响呢？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 仝教授：&ldquo;一方水土养一方人&rdquo;四川地处盆地，尤其冬季寒冷潮湿。辣椒有散寒除湿的功效，所以四川喜辣。和山西人喜酸是一个道理，是生理的需求。但川菜中的麻辣香锅、毛血旺等菜肴过于油腻厚味对健康反而不利。某一地区的特殊菜品，也并不适合不分地区、不分季节全民推广。辣椒的种类繁多、辣的等级也不同，鲜辣椒中的尖椒维生素C的含量可具各类蔬菜之首，并含有纤维素、辣椒素、B族维生素、叶酸、胡萝卜素等。干辣椒在晒干丢失水分的同时，也丢失了绝大部分水溶性维生素。干辣椒入菜的香气主要来自于油炸。辣椒可以刺激食欲、鲜辣椒是维生素C的好的来源、可刺激肠道、增加肠蠕动，预防便秘。但要适量并注意烹调方法，如&ldquo;虎皮尖椒&rdquo;是很好的菜肴，用很少的油煎辣椒到两面黄色，烹上少量醋、少量酱油、少许白糖即可。加醋的目的是使维生素C更稳定、不流失，少许糖中和了辣味。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 辣椒虽好，不是适合每一个人，对胃肠粘膜、口腔等有一定刺激，过多吃辣椒，可能会出现胃肠道炎症、口腔溃疡，咽喉炎等。因此有胃溃疡、食道炎、痔疮等患者都不能多吃。阴虚火旺，经常便秘、长痤疮的人也要慎吃。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：仝教授，一直有一个困惑：</strong><strong>从小听说</strong><strong>&ldquo;</strong><strong>饭后百步走，活到九十九</strong><strong>&rdquo;</strong><strong>。可是最近在养生节目中，有专家介绍饭后不建议走动，要躺下休息，这样才能有利于消化吸收，对于这个问题，您怎么看？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 仝教授：我有不同的看法：饭后适当活动有助于胃肠活动，助于消化、利于营养吸收。饭后百步走，不一定是指饭后马上就走，也不是一定走100步。只是流传下来的古人养生之道。和生命在于运动是一个道理。饭后不可马上做较剧烈的运动，更不能躺下不动。理论上不动使更多的血液到胃肠帮助消化，但静止不动胃肠蠕动减慢，同样影响消化吸收。最好应该饭后做15-20分钟后，散步20-30分钟再休息。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：看来合理的生活方式是营养健康的基础。说到这，要为广大女性朋友请教您一个问题，我们知道很多女性都出现过脸色发黄的现象，从生活方式和营养学的角度看，脸色发黄该如何调整饮食结构呢？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 仝教授：正常健康女性的面色是白里透红，但现在很少见这种自然的肤色。面色发黄的原因很多，如：睡眠不足、包括失眠、工作压力大、心理负担重、气血不足、缺铁或缺铁性贫血、过度节食减肥、纯素食等等。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 从生活习惯上，要养成早睡不熬夜的习惯。&ldquo;好觉胜过十剂补药&rdquo;、&ldquo;睡美人&rdquo;，最还晚11点之前进入深睡眠状态。保证&ldquo;子觉&rdquo;的高质量，这两个小时的睡眠十分重要。女性建议适当吃红肉：猪、牛、羊，补充血红素铁，也可用大枣、龙眼肉、花生、黑木耳做成羹，放入冰箱，每天两勺做为加餐，或西洋参加两个大枣掰开泡水代茶饮。因个体差异不同，可先试。尽量不吃寒凉食物，不喝冷饮，避免伤及脾胃。保持好的心情，适当做户外运动，适当晒太阳。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：仝教授的讲解大家都听明白了吧，回家就可以试试了。仝教授，随着生活水平的提高很多人在营养和饮食的多样化上下了很多功夫，日常家庭烹调时候会格外注意少油少盐等等，但是有些菜肴一旦少油少盐就失去了特有的味道，那么我们要如何做才能既吃到美味又得到健康呢？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; 仝教授：少油少盐不仅是在限油盐量上下功夫，还要在菜品原料选择、挑料选择、烹饪方法等方面全方位注意，才能做到既美味又健康，如冬瓜含钠量1.5mg/100g、丝瓜2mg/100g、小白菜132mg/100g、西芹313mg/100g，不同食材，纳含量相差100-200倍，瓤冬瓜、丝瓜烩鸡片、汆鱼丸黄瓜片都是低盐少油的菜品。从营养角度，每天最好一餐中有一道绿叶菜，但绿叶菜钠含量高怎么办？可以水焯，因为钠是水溶性的，焯过之后，部分钠就溶解在水中从而减少钠的摄入，如油麦菜、芹菜、茼蒿、芥兰等都可以焯后再炒或拌。</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; 安吉朗：好的，因为时间关系我们今天的专访就先到这里了。本次访谈我们就诸多关于日常饮食的热点向仝教授做了请教，十分感谢仝教授全面而清晰的讲解，大家是不是受益匪浅？这里建议大家结合自身日常饮食习惯与仝教授所讲的内容做下对比，看有没有需要改正的，让我们离健康更近一步。各位朋友以上就是本次专访的所有内容，再次感谢仝教授，您辛苦了！安吉朗祝您身体健康，工作顺利！</strong></p>\r\n', '2015-02-02 12:17:54', '55', '专访北京煤炭总医院主任仝惠君 ------安吉朗“营养与健康”专家访谈（第一期）', '4', '1');
INSERT INTO `t_information` VALUES ('57', '<p><img alt=\"\" src=\"http://www.angelaround.com/upload/ckeditor/2015/02/12/8dcd1751-0d5e-4825-baa7-9fa3c5bac65c.png\" style=\"height:432px; width:378px\" /></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;黑田社长</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>食事療法を必要としているにも関わらず、その食品の入手方法が十分に存在しない中国市場において、北京安吉朗健康管理有限公司のサイト開設はビジネスを超え、中国国民にとって非常に素晴らしいことです。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>本サイトで取り扱っている食品は、全て日本からの輸入品です。そして、日本における病院・施設、自宅での食事療法において長年に亘り使用され、医学的な成果を出しているものばかりです。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>さらには、日本で製造されていますので安心・安全と言った品質面、食事療法で最も重要なポイントとなる栄養成分値の保証は完璧です。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>この機会にぜひ、健康で安心した食事療法と食べる喜びを実感してください。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>さて、弊社は</strong><strong>2014</strong><strong>年</strong><strong>3</strong><strong>月</strong><strong>25</strong><strong>日</strong><strong>に中国に蘇州和喜福食品有限公司を設立しました。日本における弊社の歩みは一九五九年から始まります。それ以来、一貫して病院や老人ホーム、病院を退院して自宅で食事療法を必要とする方へ、医療・介護のサポートをする食品を提供し続けて参りました。卸としては</strong><strong>4000</strong><strong>の病院・施設へ、通販企業としては毎月</strong><strong>24000</strong><strong>人の在宅患者へ</strong><strong>3000</strong><strong>種類の商品の中から患者さんにあった食品を提供しています。患者さんの食事療法に適した食品のために自社でも開発を行い、今では</strong><strong>300</strong><strong>種類のプライベートブランド商品も持っています。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>日本は世界でも稀にみる超高齢化社会に直面しています。そこに世界に先駆けて高齢化が進んだマーケットがあり、日本人特有の真面目で細部にまで考えた医療・介護サービスが存在します。弊社はその分野における食品マーケットで長年にわたりナンバー１．のシェアを持ち、現在に至っております。そして、卸・通販・メーカーとしての総合的な情報を持ち、常に他社に先んじた展開を行ってきました。その情報は、現在、日本の農林水産省における介護食促進プロジェクトにおいても活用をされています。</strong></p>\r\n\r\n<p><strong>&nbsp;&nbsp;&nbsp;</strong></p>\r\n\r\n<p><strong>中国における活動としては、</strong><strong>2010</strong><strong>年</strong><strong>に遡ります。先天性の難病患者が成長するにあたり、なくてはならない低たんぱく食品の提供から始まり、数々の医療・介護機関との情報交流をして参りました。そして、日本で培った食事における医療・介護ノウハウが中国においても必要であるという結論の基、中国における会社設立に至りました。その過程において中国国営企業</strong><strong>蘇州恒潤達進出口有限責任公司</strong><strong>・</strong><strong>北京安吉朗健康管理有限公司との信頼関係を築き、共に歩んでおります。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>日本は数千年の歴史の中で中国からたくさんのことを学んで参りました。今、その一つのお返しとして、日本で培われたノウハウや情報、安心・安全な食品を、中国の人々とその生活のために提供したいと思っております。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>私たちヘルシーフードグループが</strong><strong>恒潤達、</strong><strong>安吉朗</strong><strong>と共に、今後の中国における食事療法の新しい扉を大きく開けていく事にぜひご期待下さい。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </strong></p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ヘルシーフード株式会社</strong></p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;代表取締役</strong></p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;蘇州和喜福食品有限公司</strong></p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;董事长</strong></p>\r\n\r\n<div><strong><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</strong></strong></div>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<p>------------------------------------------------------译文---------------------------------------------------</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>热烈祝贺北京安吉朗健康管理有限公司的电子商务平台正式上线运营。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>在日本，饮食疗法对于特殊人群有着重要意义，然而这些治疗膳食却一直无法在中国市场流通。安吉朗电商平台的设立，对于需要治疗膳食的中国人民来说是件极其有益的事！</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>安吉朗电商平台销售的食品，全部为日本进口治疗膳食。在日本，人们在医院、养老院、家中坚持使用这些食品进行饮食治疗，其成果都经过了日本临床医学的验证。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>此外，所有食品均在日本生产，在安全、品质、疗效和营养成分上都力争做到尽善尽美。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>希望大家可以借助安吉朗的电商平台，感受到治疗膳食和饮食疗法带来的健康与喜悦。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>另外介绍下弊司的情况，我司日本总部是由1959年成立的。一直专注于医院、养老院的饮食疗法，并为出院之后需要在家中持续进行食物疗法的个人，提供医疗辅助食品。在批发方面，为4000多家医院、老人院提供销售服务。网络销售方面，每月为两万四千多在家疗养的不同的患者提供3000多种类的商品。为了提供适合患者饮食疗法的商品，我司同时也在自主进行商品开发，目前的话，有300多种自主品牌商品。并于2014年3月25日 在中国正式成</strong><strong>立了苏州和喜福食品有限公司。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>日本是世界上罕见的超老龄化社会，拥有世界领先地位的老龄化产品市场，日本人专注于提供细致周全的医疗护理服务。目前，我司占有日本第一的市场份额，拥有作为批发、线上销售商、供应商的综合信息，开发新的市场领域。目前在日本的农林水产省的护理辅助食品促进项目上得到灵活应用。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>在中国的事业展开上，从2010年开始，已经为先天性苯丙酮尿症儿童免费长期提供低蛋白食品，为与更多医疗、护理机构在治疗、护理方面深度开展专业学术交流，之后设立了新公司。在此期间，有幸结识了中国国有企业苏州恒润达进出口有限责任公司和北京安吉朗健康管理有限公司，彼此信任，并决心共同在中国发展事业。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>日本从拥有着数千年历史的中国学到了很多的知识，现在我们希望用日本在饮食治疗方面的先进技术、信息，安心、安全的食品提供给更多需要帮助的人。</strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>期待同安吉朗和恒润达一起在中国开拓新的治疗膳食领域，日益发展、蒸蒸日上！</strong></p>\r\n\r\n<div>&nbsp;</div>\r\n\r\n<div>\r\n<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</strong></p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ヘルシーフード株式会社</strong></p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;代表取締役</strong></p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;蘇州和喜福食品有限公司</strong></p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;董事长</strong></p>\r\n\r\n<div><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</strong></div>\r\n</div>\r\n\r\n<div>&nbsp;</div>\r\n', '2015-02-12 06:19:47', '44', '日本ヘルシーフード株式会社黑田社长祝贺安吉朗膳食商城上线', '1', '1');
INSERT INTO `t_information` VALUES ('58', '<p>安吉朗网络平台的各位朋友，大家好！</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 应广大平台用户和各方朋友对营养健康知识和权威指导的急切渴望，安吉朗特为大家精心策划推出一系列的权威专家采访节目，让膳食营养界专家与您零距离接触，为您答疑解惑。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 今天做客我们专访平台与大家交流沟通的是从事营养工作多年的中国医学科学院整形外科医院营养科主任高玉霞教授。首先非常感谢高教授在百忙之中接受安吉朗的专访。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; 安吉朗：据我们所知，高教授从事临床营养专业</strong><strong>20</strong><strong>多年，尤其擅长将饮食与美容进行有效结合，为患者提供科学的营养膳食指导，那么能先介绍一下美容与饮食的关系吗？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 高教授：人们对美容的追求始终如一。从三国貂禅的&ldquo;一笑倾城&rdquo;到唐代杨贵妃的&ldquo;回眸一笑百媚生&rdquo;, 无不揭示人们对美的渴望。美的食物，美的人都会给人以美好的感觉。现在不但女人们爱美，男人们也开始注意自己的容貌，各种男女士护肤产品竟相摆在货柜上，面部除皱术更是一种风靡国内外美容外科手术，手术效果明显，术后确实可使你年轻靓丽。但是手术及护肤产品不是一劳永逸的，由于工作、生活等方面的压力以及一些不良的饮食习惯使我们一天天的变老，人不能青春永驻，但科学合理的一日三餐，是可以帮助我们延缓衰老的。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 就像鱼要吃东西才可以长大，而离开了水再漂亮的鱼也活不了。人们常说&ldquo;美丽女人是吃出来的。&rdquo;，说明饮食对我们的年轻态有重要的影响，这就是通俗的饮食和美容的关系。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 一个健康的人才有可能是美的。健康来源于合理的营养、均衡的饮食。有了营养和健康，才能呈现美丽的外表，拥有良好的生命状态。营养维护你的健康，让你拥有美的气质。营养能帮助相貌平平的人提升美丽的气质和魅力，帮助天生丽质、活力四射的人呈现出更加迷人的气质。营养能让你把握住你的美丽资本。营养和健康是美容的内在基础，特别是对于女性而言，健康是美丽的基石，更是外在美丽的源泉。一个人如果营养素充足并且均衡，全身的细胞得到充足的养分，进行正常的生理代谢，各个组织，器官和系统都能发挥它们正常的生理机能，人看上去会精力充沛，浑身透出一种活力，那么看上去就很美 。举个例子，皮肤是美的关键，主要表现在它的光泽和弹性。影响皮肤的因素除了阳光、湿度、污染等因素外，营养是很重要的内在因素。如果一个人营养不良，她的皮肤就会黯然无光。造就优雅的气质，由内及外，源于合理均衡饮食造就的迷人的身材、健康光洁的肌肤以及充沛的精力。而散发出来的美的气息，才是永葆青春的关键所在。美是吃出来的。不重视营养的人可以说不会美丽，相信越来越多的人们会意识到均衡营养的重要性，懂得更多的营养知识，吃出健康，吃出美丽，吃出美好的新生活。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; 安吉朗：高教授生动形象的为我们诠释了什么是美，如何从饮食营养上由内及外的美。说到这，不得不提爱美是女人的天性，几乎每个女人都希望自己再瘦一点，减肥的方法有很多，市场有各种减肥产品，您对这些产品如何看待？</strong>&nbsp;&nbsp;</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 高教授：爱美之心人皆有之。生活中越来越多的人受到肥胖的困扰，尤其是女孩子，稍微觉得有一点点胖就嚷着要减肥，甚至苗条的人为了追去骨感美也减肥，减肥已逐渐形成一种风气。然而，应运而生的众多减肥产品和五花八门的减肥方法让人眼花缭乱、无所适从，甚至将人们带入减肥误区。不仅浪费钱财，更损害了健康。不少人认为减肥速度越快,减肥效果越好。因此减肥跟着广告走，广告宣传什么方法，就跟着尝试什么方法，如减肥茶、减肥药、电动脂肪运动机、减肥霜、减肥腰带、减肥足贴等等。不惜以身试&ldquo;法&rdquo;, 尝试各种减肥产品，并且频繁地更换，结果体重可能还是减不下来，倒是减掉了减肥者口袋里的钱。也有的减肥产品能让你快速减肥，可减去的并不都是脂肪，同时也减去了身体内的水分、蛋白质和肌肉，影响身体的正常功能。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 有研究证实，减肥越快，反弹越快。世界卫生组织提出的减肥速度为每周0.5-1kg,过快将损害健康。别迷信减肥产品，目前，不合格的减肥药品或减肥食品都存在两方面的问题，一是在广告中无限夸大减肥效果，二是某些产品中含有对人体有害的成分。国家食品药品监督管理总局也曾通报减肥保健品常常会添加西布曲明（减肥药）、酚酞（泻药）。对于确实需要采用药物减肥的人来说，不要随意购买减肥药，要在医生的指导下，合理使用减肥药。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 在瘦身的路上，要减肥的朋友们已经披荆斩棘，力行了多种减肥方式，为了少走弯路，你应该先审视一下，是否踏入了减肥误区，用了无效的减肥方法，才让你的减肥成效遥遥无期？</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 牢记健康减肥才是正道，瘦身改变体重的诀窍：第一，管住嘴，每天从少吃&ldquo;一口&rdquo;做起，（一口的标准是例如半只饺子、8颗开心果、一小块红烧肉等）；减肥的核心原则是造成能量负平衡；要让食物产生的能量入不敷出，即吃进去的食物转化的能量要小于人体消耗需要的能量。第二，迈开腿，每日快走30-60分钟。采取科学的态度对待减肥，采用科学的方法来实施减肥，达到减肥和维护健康的双重效果。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; 安吉朗：听了高教授的话，各位正在减肥路上的女士查一查自己是否踏进了误区，科学的方法来减肥才是健康的选择。经常会听人抱怨特别容易长肉，您如何看待&ldquo;喝凉水都长肉&rdquo;这件事？是真的有易胖体质？还是其他原因呢？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 高教授：目前没有喝凉水都长肉的体质，如果只喝凉水，人体一点能量也不摄入，怎么会长肉呢？肥胖的机理相当复杂，但是无论怎么复杂，有一点肯定是毋庸置疑的，一定是你长期的能量摄入超过了你的能量消耗。胖瘦与遗传有关，如有些人天生脂肪合成能力强。而后天吃什么和活动量与人胖瘦关系更大。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 研究人员将小鼠分成四组进行试验，好基因代表身体底子好，脂肪不易沉积体内造成肥胖；而坏基因则代表身体底子不好，脂肪较容易沉积体内造成肥胖；好饲料代表营养均衡的饮食，而坏饲料则代表高脂肪低纤维饮食。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 结果显示：坏基因和坏饲料最容易造成肥胖。所以控制体重，重点是控制饮食，保证健康的饮食结构。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 据《国际生物信息研究和应用杂志》报道，美国研究人员发现了基因在人体肥胖症中起主要作用的新证据。新发现虽然源于具有异常高肥胖症比例的现代北美印第安人的遗传基因，但是研究人员认为，肥胖遗传基因有可能同样存在于其他人群。我国的科学家们针对肥胖的遗传性进行了大量研究。有人做过这样的试验，给不同个体每天同样额外增加一定数量的能量，持续100天后，有的人体重增加的多，而有的人增加的少，可以相差近10kg。父母与子女肥胖发生率关联性的研究也显示：父母中有1人肥胖，其子女肥胖率在60%左右；如果父母都肥胖，子女肥胖率会高达90%。还有双胞胎无论是否生活在一起，他们体重的一致性比率比非双胞胎要高50%。这些情况都显示了遗传因素的作用。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 肥胖者的基因与正常人相比可能存在一定缺陷，比如有些基因可能影响人的食欲，有些基因可能影响身体能量的消耗，还有一些基因可能影响脂肪在体内的贮存。在这些与营养相关的基因中，无论哪种有缺陷，哪个环节有问题，都可能会直接或间接地促使肥胖发生。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 肥胖者身体里的脂肪细胞往往比正常体重的人更富有弹性、数量也较多。基础代谢率相对较低，对能量的消耗较少；食欲好、吃东西速度快；喜欢安静，而不愿意运动等也是肥胖者的特点。这些也可能都与他们具有容易引起肥胖的基因有一定关系。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 不过一个具有肥胖遗传基因的人，并不意味着他一定就会成为胖子，只不过他比不具有遗传因素的人更容易肥胖罢了。人发胖是脂肪细胞在起作用，如果脂肪细胞没有得到过分的能量，人是不会肥胖的。很多人觉得自己吃得不多但还胖，就归因为自己的体质是喝凉水都长肉，这部分人群应更多的关注自己的饮食结构，他们可能每顿饭吃得不多，但平常食品摄入没有节制，如喜欢喝可乐，大量吃坚果，零食吃得多，因此即使吃得量不多，但产生的热量多、脂肪多，人自然也就胖了。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; 安吉朗：高教授用大量的实验结果为我们讲解了肥胖的真正原因，让大家受益匪浅，谢谢高教授！与肥胖离不开的是减肥，而大家提到减肥，首先想到的是少吃多运动，只要坚持都会达到一个比较理想的效果，但如何少吃，吃些什么？哪些运动适于减脂，我们都很期待您的专业意见。</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 高教授：科学减肥的最基本的方法就是少吃多运动，要把它融入到我们日常生活当中。那么少吃，重点是少吃高能量的东西，减肥的根本原理就是控制摄入的能量小于消耗的能量，让身体每天都达到热量负平衡，只有这样，才能动员人体内储存的脂肪供能，消耗它们。每天要吃七八分饱，饮食要有所限制，养成一个良好的习惯。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 《黄帝内经》指出：养生之道在于&ldquo;饮食有节&rdquo;。不仅是减肥，只要想活得健康就得节制饮食。人发胖的根本原因就是吃多了，饮食摄入的热量多于消耗的热量。所以，减肥者调整饮食、减少能量摄入是合理的减肥方案必须包括的部分。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 甜酸咸的口味与肥胖之间是什么关系？第一，人们对甜的摄入量超标，肥胖的机会就可能增大。因为甜食是提供能量最基础的来源之一。第二，过咸的食物也很可能造成肥胖，盐可以通过直接和间接方式使人增肥。盐摄入过多，会刺激胰岛素的分泌，增加脂肪的合成。同时，高盐可以促进食欲，导致更多食物的摄入。第三，酸也会在一定程度上促进食欲，间接地催肥。因此减肥期间要注意限糖、限盐和少酸。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 减肥当中如何少吃，吃些什么？</p>\r\n\r\n<p>1、减少主食量</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 肥胖或超重的人要减少主食，相对于过去的食用量要减少大约三分之一的量。但要注意，减少主食量并非意味着主食越少越好甚至没有更好，完全不吃主食会导致身体中宝贵的蛋白质被当做&ldquo;柴火&rdquo;烧掉。全天主食不得少于3两。</p>\r\n\r\n<p>2、粗细搭配</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 注意主食的粗细搭配，粗粮要占到粮食总量的一半。粗粮可以增加胃肠的饱胀感，利于减少食物摄入。比如豆类、燕麦、糙米等。</p>\r\n\r\n<p>3、慎吃全麦食品</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 在选择全麦面包的问题上，我们一定要注意选择那些无添加剂的面包，没有黄油、没有起酥、没有糖&hellip;&hellip;没有那些让面包变好吃的一切。</p>\r\n\r\n<p>4、选择健康并且低脂的优质碳水化合物作为主食，例如大米、面、土豆、红薯、豆类等。</p>\r\n\r\n<p>5、定时定量进餐，不随时加餐</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 每日至少固定早、中、晚三餐，最好在上午10点和下午4点左右适当加餐水果或低脂酸奶。这样，虽然进食量很少，仍有助于减少饥饿感。特别应注意晚餐后不要再吃其他零食，尤其是甜点心、巧克力等致胖食品；</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 不少减肥者就餐时吃得很少，两餐间却不知不觉吃了很多高热量低营养的零食，这样不仅不能减肥，而且不利健康，所以减肥者需要更加重视三餐，吃好吃饱（靠多吃蔬菜吃饱）。</p>\r\n\r\n<p>6、三餐能量分配要得当：早餐吃饱，午餐吃好，晚餐吃少。</p>\r\n\r\n<p>7、多吃含能量低、饱腹感强的食品</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 选择蔬菜、粗粮等能量很低的食品，会产生很大的容积而消除饥饿感，有利于减肥的执行；多吃蔬菜是吃饱又减肥的关键。</p>\r\n\r\n<p>8、控制饮食总能量，重视营养均衡</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 饮食减肥的最重要原则是限制每日所有食物的总能量，但又要食物多样化，保证其他营养素的充足供给；</p>\r\n\r\n<p>9、节食食品应美味可口，切忌单调无味</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 减肥饮食并不应该成为单调口味的膳食，能量不高的美味佳肴更有利于减肥计划的执行；</p>\r\n\r\n<p>10、减肥计划应适应自己的饮食习惯，简便易行，大众化，不论在家中还是外出都能执行，以免减肥中断；</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 在控制了总能量的前提下每天要保证以下食物的摄入：3两主食、1-2袋脱脂牛奶、1个水煮鸡蛋（有高胆固醇血症的人每天吃半个鸡蛋）、1斤青菜、1两瘦肉、1～2两的豆制品</p>\r\n\r\n<p>哪些运动适于减脂呢？</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 运动减肥不仅仅是减体重，更多的是减体内的脂肪；减肥不仅是一个减体重的过程，也是一个培养良好生活方式的过程。因此，简便易行，适合自己，每天能坚持下去且能持续终生的运动就是最好的减肥运动，也是促进健康的运动。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 运动的方式和运动量：以减肥为目标的运动应以较长时间、中低强度、全身性的有氧运动为主，适当的肌肉力量训练为辅。肥胖者应该选择自己喜欢的运动方式，只有这样才不会感到枯燥，并能长期坚持下去。全身性的有氧运动有步行、跑步、自行车、游泳、跳舞、体操、爬山、跳绳、各种球类（足球、排球、篮球、乒乓球、网球）等；肌肉力量训练可以选择循环阻抗运动、借助些器械针对不同部位肌肉力量训练等。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 运动方式有很多种，你要减体重的时候，应该希望消耗我们身体里的脂肪，那就需要有一定的运动强度，有一定的运动量，每天你都去运动，这样效果就会好一些。至于选择一个什么样的方式，那就要选择你喜欢做的，能够坚持做的运动。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;运动时间：应根据肥胖者的身体状况和目前的身体活动水平而定，一般以每天30分钟以上为宜，可以分几次进行，即每天的运动时间可以累计计算，但每次运动时间不能少于10分钟，也不易超过120分钟。每周5-7天，最好每天都运动。</p>\r\n\r\n<p>运动能够提高机体的新陈代谢，消耗身体更多的脂肪，并能强壮肌肉，防止肌肉组织的丢失，从而提高了单纯靠饮食减肥的效果，同时也有效防止了过度控制饮食所造成的副作用。</p>\r\n\r\n<p>减肥贵在坚持，持之以恒，即使当体重达到理想后，仍应坚持健康饮食和运动，定期测体重，因为肥胖的&ldquo;反弹&rdquo;时刻环绕着您。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; 安吉朗：谢谢高教授专业而全面的为我们讲解如何健康的减脂瘦身，大家可以对照着来实施自己的减脂健身计划。另外，高教授中国自古有药食同源的观念，比如多吃猪蹄、猪皮能补充胶原蛋白，对女性皮肤有很好的滋养及修复作用，多吃这些食物真的能有如此功效吗？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 高教授：胶原蛋白的作用是连接机体组织、维持身体弹性所必需的物质。胶原蛋白是一种不完全蛋白，吸收率十分有限。随着年龄的增大，体内胶原蛋白量会逐渐减少，随之皮肤的弹性就会降低，皱纹也会产生。所以人们期望通过吃猪蹄、猪皮能够补充胶原蛋白，对皮肤有很好的滋养及修复等作用。作为日常食物的动物皮肤，如猪蹄、猪皮冻、鱼皮冻、鱼皮、鸡皮、筋腱，如筋、牛蹄筋等；软骨，如骨肉相连、脆骨等都含有丰富的胶原蛋白。猪肉、牛羊肉和禽肉中胶原蛋白含量较低，鱼肉中胶原蛋白含量稍高。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 在胶原蛋白以及其他蛋白质复杂的合成过程中，食物提供的仅仅是&lsquo;原料&rsquo;氨基酸，而不是体内蛋白质本身。也就是说，吃胶原蛋白并不会直接增加身体内的胶原蛋白。正如你吃血红蛋白如动物血液，并不会直接变成你的血红蛋白；你吃肌蛋白如猪肉，也并不会直接变成你的肌蛋白；</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 胶原蛋白进入人体消化道后，不可能仍以蛋白形式被吸收，而是逐步被分解，最后全部被还原成氨基酸。经肝脏等代谢途径后，有的转化为脂肪，有的转化为葡萄糖，还有一部分仍以氨基酸的形式参与人体组织的修复、重建和代谢更新，根据机体需要统一分配。换句话说，摄入人体的胶原蛋白通常会被肠道吸收，转化为人体必需的营养物质，并不能有效地作用于有皱纹的皮肤。不会&ldquo;吃胶原蛋白补胶原蛋白&rdquo;，直接输送到皮肤，这从生理学上是不可能的。因此，通过吃猪蹄、猪皮补充胶原蛋白的美容效果非常有限，没有任何一例研究表明，胶原蛋白具有除皱效果。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 胶原蛋白和骨骼健康有关，但不能减少皱纹，更不能使身材变苗条。只要在人体中有正常水平的维生素C，蛋白质和其他营养素够用，血液循环良好，激素平衡正常，人体可以自己合成足够的胶原蛋白。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; 安吉朗：&ldquo;女为悦己者容&rdquo;而胶原蛋白是目前大家比较接受的美容、抗衰老成分，市场上相关产品很多，不少厂家宣传其原料来自深海鳕鱼，那么原材料对胶原蛋白的品质有影响吗？我们应该以什么标准去挑选胶原蛋白产品？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 胶原蛋白类食品、保健品已成为了人们喜爱的产品，&ldquo;美容、抗皱、营养、抗衰老&rdquo;被人们称作是胶原蛋白的主要功绩，不少人对胶原蛋白的&ldquo;崇拜&rdquo;甚至到了必不可少的地步。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 胶原蛋白之所以成为时髦的美容、抗衰老成分，当然与厂商夸大宣传是分不开的。但更主要的原因是消费者不了解生命科学基本常识。相关保健品宣传中，只强调胶原蛋白作为连接机体组织、维持身体弹性所必需物质的功能，却忽略了摄入人体的胶原蛋白通常会被肠道吸收，并不能作用于有皱纹的皮肤的事实。也正因为这个事实，胶原蛋白的美容效果非常有限。市场上相关产品很多，不少厂家宣传其原料来自深海鳕鱼或其它的原材料，但是到目前为止，没有任何一例研究表明，胶原蛋白具有除皱美容的效果。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 胶原蛋白分子量大，不能被人体直接吸收。吃胶原蛋白并不能直接增加体内胶原蛋白合成，但它对身体，包括皮肤、关节、骨骼、脏器、肌肉等具有一定营养作用，在试验动物中尤其如此。不过，没有证据表明它的营养作用会超过鸡蛋、肉类或是大豆等普通食物中的蛋白质。&rdquo;</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 人体自己可以自制胶原蛋白。其次，皮肤的美丽不仅仅靠胶原蛋白，还需要足够的维生素A，维生素C，维生素B族，维生素E，锌，铁等很多种营养素的帮助，还需要有良好的血液循环，适当的激素水平。吃胶原蛋白，最多只能增加氨基酸的供应，并不能解决其他营养素缺乏的问题，也不能改善血液循环和其他代谢失调问题。美容、抗衰老不能光指望胶原蛋白。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; 安吉朗：高教授，想必您也注意到了在不断的信息轰炸中，我们听说到了&ldquo;胶原蛋白肽</strong><strong>&rdquo;</strong><strong>这个概念，它与胶原蛋白是同一种物质吗</strong><strong>? </strong><strong>这两者有何区别呢？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 高教授：作为保健品服用的胶原蛋白，有的是口服液，有的是粉剂；有的叫胶原蛋白，有的叫&ldquo;胶原蛋白肽&rdquo;，还有的叫&ldquo;水解胶原蛋白&rdquo;，同样是大同小异。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 水解胶原蛋白(或是宣传的&ldquo;小分子胶原蛋白&rdquo;)没有能帮助美容护肤的证据。水解胶原蛋白相当于把人体消化的过程在体外进行了一部分，吃下后消化吸收速度更快。此外，水解胶原蛋白中有很多二肽、三肽也叫胶原蛋白肽，被直接吸收进入血液，但它们无法进入细胞作为合成蛋白质的原料。研究表明, 胶原蛋白肽可以直接在肠道被吸收,而且小肽类比氨基酸具有更大的吸收量。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 胶原蛋白是一种纤维状蛋白，具有良好的韧性、抗拉强度，在人体约占所有蛋白质的四分之一。人的皮肤、骨骼、眼角膜和晶状体都含有大量的胶原蛋白。胶原蛋白纤维的作用是维持皮肤的外形和结构，令皮肤看起来平滑、无皱纹，所以几乎所有的胶原蛋白产品都强调了除皱、美白、保湿等功效。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 但是早在2010年，我国内地还没有兴起胶原蛋白热的时候，香港消费者委员会已经对胶原蛋白产品进行了详细分析，并出具了报告，结果出人意料。报告称&ldquo;产品所含的胶原蛋白肽可以直接用于合成胶原蛋白的说法并不成立&rdquo;，并指出&ldquo;相信部分产品供应商所指的吸收是指经消化道吸收，这和由皮肤直接吸收，两者的意思差别很大。&rdquo;很多专家认为&ldquo;即使长时间服用产品亦未必可以见到明显的美肌效果&rdquo;。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 到目前为止，没有大型研究的文献去证明，口服的胶原蛋白或胶原蛋白肽对我们皮肤有美容抗皱的作用。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; 安吉朗：谢谢高教授精彩、专业的讲解，让我们知道了瘦身减肥、美容健康的诸多真谛和知识。最后，高教授还想跟爱美的女性朋友说些什么，有哪些是您临床实践这么多年来，特别想跟大家说的话？</strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 高教授：食物营养美容是一种有别于化妆美容、医疗美容的方法，它可以通过滋补脏腑、充溢气血，达到健康美容的目的。没有哪一种食品能够像灵丹妙药一样让皮肤快速改善，长期健康生活才能让身体一直保持活力，从而透过皮肤表现出来。少吃油腻，少吃辛辣，少吃太咸和太甜的东西，少吃加工食品，饮食清淡天然，富含纤维和抗氧化物质，是保持好皮肤所必需的条件。运动也是非常好的美容措施。运动的时候，让身体能够热起来，心肺功能得到一点挑战的运动，能大大改善血液循环状况，使皮肤透出红润和光泽，肌肉力量得到了增强，脸上不容易松弛。</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; 均衡的营养，适当的运动，愉悦的心情，良好的起居习惯，会让你拥有健康的肤色和容颜。只有身体健康、营养充足、活力十足的人，才能表现出光泽滋润的皮肤状态。营养健康与美容不是随随便便的事,是需要一辈子来维护的。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; 安吉朗：好的，因为时间关系我们今天的专访就先到这里了。本次访谈我们就诸多关于减肥、美容等热点问题向高教授做了请教，十分感谢高教授全面而清晰的讲解，大家是不是受益匪浅？这里建议大家结合自身日常生活、饮食习惯与高教授所讲的内容做下对比，看有没有需要改正的，让我们离健康更近一步。各位朋友以上就是本次专访的所有内容，再次感谢高教授，您辛苦了！安吉朗祝您身体健康，工作顺利！</strong></p>\r\n', '2015-02-13 05:09:36', '5', '专访中国医学科学院整形外科医院营养科主任高玉霞------安吉朗“营养与健康”专家访谈（第一期）', '4', '4');
INSERT INTO `t_information` VALUES ('59', '<p>12121</p>\r\n', '2015-09-02 09:26:09', '0', '1212', '9', '0');

-- ----------------------------
-- Table structure for `t_information_type`
-- ----------------------------
DROP TABLE IF EXISTS `t_information_type`;
CREATE TABLE `t_information_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `detailContent` varchar(255) DEFAULT NULL,
  `detailTitle` varchar(255) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_information_type
-- ----------------------------
INSERT INTO `t_information_type` VALUES ('1', '2015年1月23-25日，中国医师协会营养医师专业委员会2014年年会在北京鑫海锦江大酒店国际会议厅举行，本次会议总结了近几年学科建设的经验与成功模式，探讨临床营养学科管理规范、人才规范化培养，同时探讨标准化临床营养学科建设方案，并传递国际国内最新前沿学术知识。安吉朗出席本次会议，会上展出日本原装进口治疗膳食，因品种多，覆盖广、口感优而引起现场专家的广泛关注。\r\n', '安吉朗膳食商城上线，产品全面预售中', '1', 'upload/information/2015/08/15/951b2ed6-03cc-479b-a143-df97256400ad.png', '公司新闻', 'infor/toInforDetail.do?id=51');
INSERT INTO `t_information_type` VALUES ('4', '这里有专家，这里有知识，这里有贴心的指导和细致的关怀。这里是安吉朗为您精心打造的营养膳食高端专访平台。', '膳食营养、营养科普', '1', 'upload/information/2015/08/15/36521c25-fa63-4e19-a8f2-356e1e07b215.png', '媒体报道', 'infor/toInforChannel.do?typeId=4');
INSERT INTO `t_information_type` VALUES ('8', '给您最专业的营养膳食资讯与营养科普，在这里您能了解到最全最专业的膳食营养信息。', '安吉朗膳食商城上线，产品全面预售中', '3', 'upload/information/2015/08/15/9477bed5-77c2-44c1-b230-901c42d81f95.png', '营养膳食', 'infor/toInforChannel.do?typeId=8');
INSERT INTO `t_information_type` VALUES ('9', '', '', '4', '', '健康与饮食', '');

-- ----------------------------
-- Table structure for `t_message`
-- ----------------------------
DROP TABLE IF EXISTS `t_message`;
CREATE TABLE `t_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` varchar(1000) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `isRead` int(11) NOT NULL,
  `fromUserId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `toUserId` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `crTime` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message
-- ----------------------------
INSERT INTO `t_message` VALUES ('2', '用户刘大爷向您提问,<a href=\"http://localhost:8080/anjilang/answer/answer.do?questionId=43\">点击查看详情</a>', '2015-01-18 22:22:50', '0', '4', '用户刘大爷向您提问', '3', '1', null);
INSERT INTO `t_message` VALUES ('3', '用户linqingsongsong向您提问,<a href=\"http://localhost:8080/anjilang/answer/answer.do?questionId=44\">点击查看详情</a>', '2015-01-18 22:52:27', '0', '6', '用户linqingsongsong向您提问', '10', '1', null);
INSERT INTO `t_message` VALUES ('4', '用户清咖向您提问,<a href=\"http://123.56.84.207:8080/anjilang/answer/answer.do?questionId=71\">点击查看详情</a>', '2015-01-19 14:53:23', '0', '9', '用户清咖向您提问', '32', '1', null);
INSERT INTO `t_message` VALUES ('5', '用户springyu向您提问,<a href=\"http://123.56.84.207:8080/anjilang/answer/answer.do?questionId=79\">点击查看详情</a>', '2015-01-20 11:31:28', '0', '9', '用户springyu向您提问', '8', '1', null);
INSERT INTO `t_message` VALUES ('6', '用户刘蕾向您提问,<a href=\"http://www.angelaround.com/answer/answer.do?questionId=92\">点击查看详情</a>', '2015-02-02 13:35:12', '0', '53', '用户刘蕾向您提问', '53', '1', null);
INSERT INTO `t_message` VALUES ('7', '用户周周向您提问,<a href=\"http://www.angelaround.com/answer/answer.do?questionId=117\">点击查看详情</a>', '2015-02-13 17:12:15', '0', '65', '用户周周向您提问', '44', '1', null);
INSERT INTO `t_message` VALUES ('8', '用户摘月亮的小兔向您提问,<a href=\"http://www.angelaround.com/answer/answer.do?questionId=118\">点击查看详情</a>', '2015-02-13 17:25:29', '0', '64', '用户摘月亮的小兔向您提问', '23', '1', null);

-- ----------------------------
-- Table structure for `t_patient_group`
-- ----------------------------
DROP TABLE IF EXISTS `t_patient_group`;
CREATE TABLE `t_patient_group` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '小组id',
  `group_name` varchar(20) NOT NULL COMMENT '小组名称',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `picurl` varchar(255) DEFAULT NULL COMMENT '头像图片地址',
  `userid` int(10) DEFAULT NULL COMMENT '创建者id',
  `cancel` tinyint(1) DEFAULT '0' COMMENT '是否注销',
  `description` text COMMENT '描述',
  `bgpicUrl` varchar(255) DEFAULT NULL COMMENT '背景图片地址',
  `adminid` int(10) DEFAULT NULL COMMENT '管理员id',
  `audit` char(1) DEFAULT NULL COMMENT '审核',
  `personcount` int(8) DEFAULT NULL COMMENT '成员个数',
  `topiccount` int(8) DEFAULT NULL COMMENT '发帖的个数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_patient_group
-- ----------------------------
INSERT INTO `t_patient_group` VALUES ('12', '第一次正式测试', '2015-07-19 17:21:51', 'hyh/images/lad.jpg', '7', '0', '<p>自从吃了真粒米，就不会</p>\r\n', 'hyh/images/banner.jpg', null, '2', null, '0');
INSERT INTO `t_patient_group` VALUES ('13', '第二次测试', '2015-08-11 11:57:54', 'hyh/images/lad.jpg', '7', '1', '<p>自从吃了真粒米，就不会</p>\r\n', 'hyh/images/banner.jpg', null, '1', null, '0');
INSERT INTO `t_patient_group` VALUES ('14', '登录之后第一次测试', '2015-07-19 17:13:58', 'hyh/images/lad.jpg', '3', '0', '<p>登陆之后第一次测试看看是否正确</p>\r\n', 'hyh/images/banner.jpg', null, '2', null, '0');
INSERT INTO `t_patient_group` VALUES ('15', '一个人旅行', '2015-08-11 11:57:50', 'hyh/images/lad.jpg', '10', '0', '<div>心飘过的地方，却留不下印记！<br />\r\n曾许何时，我到过你隐藏的地方，离开，<br />\r\n却再也找不到曾经的痕迹！</div>\r\n\r\n<p>走过那莲花盛开的地方~</p>\r\n\r\n<p><br />\r\n【QQ群】191488538</p>\r\n', 'hyh/images/banner.jpg', null, '2', null, '0');
INSERT INTO `t_patient_group` VALUES ('16', '胃友会', '2015-08-11 11:57:48', 'hyh/images/lad.jpg', '7', '0', '<p>胃，本义：人身体中的农田</p>\r\n\r\n<p>说明：胃别名&ldquo;肚&rdquo;，意为&ldquo;肉身中的田土&rdquo;</p>\r\n\r\n<p>又号&ldquo;太仓（大仓、天仓）&rdquo;</p>\r\n', 'hyh/images/banner.jpg', null, '2', null, '0');
INSERT INTO `t_patient_group` VALUES ('17', '出错后的测试', '2015-08-11 11:57:47', 'hyh/images/lad.jpg', '7', '1', '<p>为什么会有那么多的空格啊</p>\r\n\r\n<p>我是正常换行啊</p>\r\n', 'hyh/images/banner.jpg', null, '1', null, '0');
INSERT INTO `t_patient_group` VALUES ('18', '管理会', '2015-07-22 11:24:59', 'upload/2015/08/03/37cd4851-efaa-46f3-9eb3-2c7446e27adf.png', '7', '0', '<p>改回来</p>\r\n', 'hyh/images/banner.jpg', null, '2', null, '0');
INSERT INTO `t_patient_group` VALUES ('19', '再一次创建', '2015-08-11 11:57:46', 'upload/2015/08/03/9bfb83a7-ea41-43f1-96c8-e6ebaa0d83be.png', '7', '1', '<p>不会又是session出错吧</p>\r\n', 'hyh/images/banner.jpg', null, '2', null, '0');
INSERT INTO `t_patient_group` VALUES ('20', '老友会', '2015-08-11 11:57:44', 'hyh/images/lad.jpg', '3', '0', '<p>创建一个老友会</p>\r\n', 'hyh/images/banner.jpg', null, '2', null, '0');
INSERT INTO `t_patient_group` VALUES ('21', '创建一个新的', '2015-08-11 11:57:43', 'hyh/images/lad.jpg', '7', '1', '<p>就像创建一个新的</p>\r\n', 'hyh/images/banner.jpg', null, '1', null, '0');
INSERT INTO `t_patient_group` VALUES ('23', '老友会', '2015-08-05 15:36:10', 'hyh/images/lad.jpg', '7', '0', '<p>北京老友会官方群组，欢迎加入北京老友会QQ群：87675656<br />\r\n本群组自由加入，欢迎成员自由交流，请不要发布广告内容<br />\r\n每周三下午3点，定期举办线上问答活动，欢迎各位解释参与交流</p>\r\n', 'hyh/images/banner.jpg', null, '2', '17', '44');
INSERT INTO `t_patient_group` VALUES ('24', '肾友会', '2015-08-09 14:33:43', 'hyh/images/lad.jpg', '7', '0', '<p>有的人看上去眼圈黑，身体没觉得有什么不舒服，便说是&ldquo;肾虚&rdquo;。</p>\r\n\r\n<p>肾虚是中医学术语，泛指腰酸、肢冷、腿软、性功能减退、耳鸣，男性尿少、遗精、阳痿，&nbsp;女性经期异常、白带稀薄闭经等。</p>\r\n\r\n<p>那熊猫眼到底是否是肾虚呢?其实，单纯眼圈黑不是病态，现代医学认为，人的眼睑(眼皮)及其周围组织很薄，如劳累、失眠后，眼睑长时间收缩，能引起结&nbsp;缔组织血管充血，血流不畅，微循环障碍，所以眼圈发黑。</p>\r\n\r\n<p>出现黑眼圈用不着担惊&nbsp;害怕、乱吃补药，只要精神愉快，多活动锻炼身体，充足睡眠，少则3―5天，多则1―2周，黑眼圈随后也就消失了</p>\r\n', 'hyh/images/banner.jpg', null, '1', null, '0');
INSERT INTO `t_patient_group` VALUES ('25', '胃友会', '2015-08-11 11:48:03', 'hyh/images/lad.jpg', '7', '0', '<p>胃位于膈下，上接食道，下通小肠。</p>\r\n\r\n<p>胃的上口为贲门，下口为幽门。</p>\r\n\r\n<p>胃又称胃脘(guǎn管，又读wǎn碗)，&ldquo;脘&rdquo;的古音同&ldquo;管&rdquo;，义亦相通。</p>\r\n\r\n<p>故胃之上为食管，胃之下为肠管，胃居二者之间名为胃管(脘)。其分上、中、下三部。</p>\r\n\r\n<p>胃的上部称上脘，包括贲门;胃的中部称中脘，即胃体部分;胃的下部称下脘，包括幽门。《中国医学大辞典胃》按：&ldquo;胃，汇也，水谷汇聚之所也，为人体内消化器，形如囊，左大右小，横卧于膈膜下，上端为贲门，接于食道，下端为幽门，连于小肠。&rdquo;胃内腔宽阔，受纳饮食，《灵枢&bull;海论》称：&ldquo;胃者，水谷之海&rdquo;。又因饮食是人体气血生化之源，《灵枢&bull;玉版》称&ldquo;胃者，水谷气血之海也&rdquo;。</p>\r\n', 'hyh/images/banner.jpg', null, '1', '1', '0');
INSERT INTO `t_patient_group` VALUES ('26', '美丽会', '2015-08-24 09:13:25', 'hyh/images/lad.jpg', '8', '0', '<p>一个让大家</p>\r\n', 'hyh/images/banner.jpg', null, '2', '1', '0');

-- ----------------------------
-- Table structure for `t_picture`
-- ----------------------------
DROP TABLE IF EXISTS `t_picture`;
CREATE TABLE `t_picture` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `accessUrl` varchar(255) DEFAULT NULL,
  `diseaseId` bigint(20) DEFAULT NULL,
  `hospital` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `picUrl` varchar(255) DEFAULT NULL,
  `sortNum` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `nowprice` varchar(10) DEFAULT NULL,
  `pastprice` varchar(10) DEFAULT NULL,
  `typename` varchar(10) DEFAULT NULL,
  `productname` varchar(10) DEFAULT NULL,
  `overplus` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_picture
-- ----------------------------
INSERT INTO `t_picture` VALUES ('6', 'http://123.56.84.207:81/jmshop/goods.php?id=162', '5', null, null, 'upload/indexshop/2015/08/24/412fe1c6-0115-4fcf-a3ff-66b2c090966e.png', '2', '2', '420', '560', '助吞咽', '透罗咪', '120');
INSERT INTO `t_picture` VALUES ('14', '', null, '北京医院', '孙明晓', 'upload/indexdoctor/2015/01/28/8a453e8c-8b66-4b24-8912-75767859a0db.png', '1', '3', null, null, null, null, null);
INSERT INTO `t_picture` VALUES ('15', '', null, '空军总医院', '景洪江', 'upload/indexdoctor/2015/01/28/1db88f4c-3550-4372-a756-78f22c203e4f.png', '2', '3', null, null, null, null, null);
INSERT INTO `t_picture` VALUES ('17', 'http://123.56.84.207:81/jmshop/goods.php?id=197', '1', null, null, 'upload/indexshop/2015/08/24/2f996cc6-a9c9-4abe-9ee9-6d87caecf8fc.png', '3', '2', '49', '80', '低蛋白', '迷你加钙饼干', '150');
INSERT INTO `t_picture` VALUES ('21', '/shop/goods.php?id=76', '1', null, null, 'upload/indexshop/2015/08/25/6bb44322-1ec6-4bc4-a0a6-89fb47c3f365.png', '12', '2', '30', '120', '营养品', '棒棒糖', '110');
INSERT INTO `t_picture` VALUES ('23', 'http://123.56.84.207:81/jmshop/goods.php?id=190', '1', null, null, 'upload/indexshop/2015/08/24/8edf3a54-5008-4c77-b15f-1b74b74197d4.png', '1', '2', '199', '259', '低蛋白', '真粒米', '1600');
INSERT INTO `t_picture` VALUES ('24', 'http://123.56.84.207:81/jmshop/goods.php?id=199', '1', null, null, 'upload/indexshop/2015/08/24/9e720bb0-6dfa-4769-a280-d8e7dc869584.png', '4', '2', '49', '79', '低蛋白', '松软加钙夹心饼干', '110');
INSERT INTO `t_picture` VALUES ('30', '', null, '武汉同济医院', '姚颖', 'upload/indexdoctor/2015/01/28/932c0de7-27be-46cc-8d2d-53794c0298a2.png', '3', '3', null, null, null, null, null);
INSERT INTO `t_picture` VALUES ('31', '', null, '煤炭总医院', '仝慧君', 'upload/indexdoctor/2015/02/02/cbc343cb-0223-4f82-a51e-271cc892792c.png', '7', '3', null, null, null, null, null);
INSERT INTO `t_picture` VALUES ('32', 'infor/toInforDetail.do?id=57', null, null, null, 'upload/indextable/2015/08/14/38c0d090-8c9f-4add-b8ef-2869a314060a.png', '2', '1', null, null, null, null, null);
INSERT INTO `t_picture` VALUES ('35', 'infor/toInforDetail.do?id=57', null, null, null, 'upload/indextable/2015/08/14/8e47995e-9bbd-42b7-a9c3-fa9d0ec7d355.png', '3', '1', null, null, null, null, null);
INSERT INTO `t_picture` VALUES ('36', 'infor/toInforDetail.do?id=57', null, null, null, 'upload/indextable/2015/08/14/720e6c53-88af-405c-8feb-bd676a9a04e7.png', '4', '1', null, null, null, null, null);
INSERT INTO `t_picture` VALUES ('37', '', null, '北京协和医院', '陈伟', 'upload/indexdoctor/2015/02/02/487f99a2-3a93-4cca-a8e5-cc4ea8608bda.png', '4', '3', null, null, null, null, null);
INSERT INTO `t_picture` VALUES ('38', '', null, '高级公共营养师', '刘蕾', 'upload/indexdoctor/2015/01/29/1cbc2585-d83f-4b4a-a5a2-179c885bd517.png', '5', '3', null, null, null, null, null);
INSERT INTO `t_picture` VALUES ('39', '', null, '中国医学科学院整形外科医院', '高玉霞', 'upload/indexdoctor/2015/02/13/965e3d3b-2ec0-4b07-8285-21ebc9a9d05d.png', '6', '3', null, null, null, null, null);
INSERT INTO `t_picture` VALUES ('44', 'infor/toInforDetail.do?id=57', null, null, null, 'upload/indextable/2015/08/14/8e0ceb26-83d3-4e41-8b75-f639bbfe44c1.png', '1', '1', null, null, null, null, null);

-- ----------------------------
-- Table structure for `t_question`
-- ----------------------------
DROP TABLE IF EXISTS `t_question`;
CREATE TABLE `t_question` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id 主键',
  `addr` varchar(255) DEFAULT NULL COMMENT '来自地区',
  `answerNum` int(11) NOT NULL COMMENT '问题回答数',
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  `crTime` datetime DEFAULT NULL COMMENT '创建时间',
  `num` int(11) NOT NULL COMMENT '浏览数量',
  `diseaseId` bigint(20) DEFAULT NULL COMMENT '所属疾病项目id',
  `userId` bigint(20) NOT NULL COMMENT '提问用户id',
  `picture` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL COMMENT '问题标题',
  PRIMARY KEY (`id`),
  KEY `FKBA823BE672F2FC58` (`diseaseId`),
  KEY `FKBA823BE67B90E1B5` (`userId`),
  CONSTRAINT `FKBA823BE672F2FC58` FOREIGN KEY (`diseaseId`) REFERENCES `t_disease_project` (`id`),
  CONSTRAINT `FKBA823BE67B90E1B5` FOREIGN KEY (`userId`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_question
-- ----------------------------
INSERT INTO `t_question` VALUES ('95', null, '0', '血压高，蛋白有+号，最近总是失眠，HDL-C化验结果为0.91，结果偏低，血糖6.19餐前有点高，想问下，这个高密度胆固醇偏低是时由于什么引起的？应该注意些什么？谢谢！！', '2015-02-07 23:10:49', '101', '1', '28', '', '血压高，蛋白有+号，最近总是失眠');
INSERT INTO `t_question` VALUES ('96', null, '0', '慢性肾炎为什么爱复发?', '2015-02-08 10:30:05', '83', '1', '22', '', '慢性肾炎为什么爱复发?');
INSERT INTO `t_question` VALUES ('97', null, '7', '请问慢性肾小球肾炎可以吃黑鱼吗？吃的量有限制吗？', '2015-02-08 10:33:58', '157', '1', '29', '', '慢性肾小球肾炎可以吃黑鱼吗？');
INSERT INTO `t_question` VALUES ('98', null, '0', '高血压、慢性肾炎的人可以吃杏仁及板粟吗？', '2015-02-08 10:36:52', '90', '1', '23', '', '肾病怎么吃？');
INSERT INTO `t_question` VALUES ('99', null, '0', '到医院治疗后尿蛋白变阴性，隐血二个加，血压正常，请问我的肾病严重吗？我能否生孩子呢？', '2015-02-08 10:40:41', '36', '1', '24', '', '慢性肾病一直隐血，没有尿蛋白，血压正常能要孩子吗？');
INSERT INTO `t_question` VALUES ('101', null, '0', '请问慢性肾病在饮食上有哪些原则和注意点？另外听人说黑色入肾，可以吃黑豆什么的补肾吗？', '2015-02-08 10:49:48', '83', '1', '30', '', '慢性肾病饮食？');
INSERT INTO `t_question` VALUES ('102', null, '0', '糖尿病人一般应该进行一些体育锻炼，可是有病友说不宜锻炼，请问什么情况下糖尿病病人不宜进行体育锻炼？', '2015-02-08 11:00:26', '84', '4', '31', '', '糖尿病人是否需要进行体育锻炼？');
INSERT INTO `t_question` VALUES ('103', null, '0', '糖尿病病人该如何计算糖尿病病人一天应该摄入的总热量？', '2015-02-08 11:02:46', '77', '4', '32', '', '如何计算糖尿病病人一天应该摄入的总热量');
INSERT INTO `t_question` VALUES ('104', null, '0', '很多糖友都说自己通过饮食治疗，病情有很大改善，请问糖尿病饮食治疗有哪些要点？能详细点解答吗？谢谢！', '2015-02-08 11:05:10', '77', '1', '26', '', '糖尿病人饮食治疗的重要性');
INSERT INTO `t_question` VALUES ('105', null, '0', '很多糖友都说自己通过饮食治疗，病情有很大改善，请问糖尿病饮食治疗有哪些要点？能详细点解答吗？谢谢！', '2015-02-08 11:06:20', '72', '4', '26', '', '糖尿病人饮食治疗的重要性');
INSERT INTO `t_question` VALUES ('106', null, '0', '请问什么样的糖尿病人需要用胰岛素治疗？使用胰岛素治疗有哪些好处？谢谢', '2015-02-08 11:08:37', '71', '4', '27', '', '请教糖尿病胰岛素使用问题');
INSERT INTO `t_question` VALUES ('107', null, '0', '最近觉得身体不舒服，去医院检查,做了空腹血糖测量,是7.8mmol/l然后服用葡萄糖水3杯,1小时后指数为17.42小时后为11.13小时后为4.6。血糖最近空腹12点，消化系统不好，食欲较大。请问糖尿病会引起并发症吗？有哪些并发症？', '2015-02-08 11:11:52', '73', '4', '40', '', '糖尿病会引起并发症吗?');
INSERT INTO `t_question` VALUES ('108', null, '0', '怀孕可以服口服降糖药吗?会有什么影响?', '2015-02-08 11:13:54', '62', '4', '43', '', '怀孕可以服口服降糖药吗?会有什么影响?');
INSERT INTO `t_question` VALUES ('109', null, '0', '家里父亲最近吃饭,喝水无故呛咳,有时咽口水也会呛.呛到人会休克几秒。请问有什么办法解决？', '2015-02-08 11:15:48', '69', '5', '45', '', '家里老人呛咳怎么办？');
INSERT INTO `t_question` VALUES ('110', null, '0', '家中老人一直被便秘困扰，严重的时候一星期都不上厕所，泻药吃的时候管用，不吃就又不行了，请问有什么好的治疗方法吗？', '2015-02-08 11:17:52', '86', '5', '42', '', '老年人便秘如何解决？');
INSERT INTO `t_question` VALUES ('112', null, '0', '母亲牙一直不好，换了假牙，可是因为某些关系假牙经常发炎还是影响日常饮食，把老太太折腾的都快营养不良了，请问有没有什么好的办法解决？有没有什么营养全面的食物可以每天食用？', '2015-02-08 11:25:35', '79', '5', '44', '', '老人营养不良');
INSERT INTO `t_question` VALUES ('113', null, '0', '请问老人能都吃蛋白粉？每天的补充量多少合适？谢谢！', '2015-02-08 11:29:10', '71', '5', '21', '', '老人能否吃蛋白粉？');
INSERT INTO `t_question` VALUES ('114', null, '0', '请问老人的日常饮食有哪些注意点和要素，荤瘦搭配比例是多少，是否要去补充一些微量元素、蛋白质等膳食添加剂。谢谢！', '2015-02-08 11:41:00', '65', '5', '56', '', '老人饮食');
INSERT INTO `t_question` VALUES ('115', null, '0', '您好！我父亲今年80，爱好体育锻炼，可是家人担心他这样会对身体不好，尤其是年事已高 ，请问老人体育锻炼合适吗\r\n？锻炼项目有没有什么禁忌的？谢谢！', '2015-02-08 11:45:53', '66', '5', '57', '', '老人能否进行体育锻炼');
INSERT INTO `t_question` VALUES ('116', null, '0', '请问慢性肾病尿蛋白3个加好要注意22222些什么？谢谢！', '2015-02-10 15:06:18', '24', '1', '7', '', '慢性肾病尿蛋白3个加号要注意什2么？');
INSERT INTO `t_question` VALUES ('117', null, '1', '您好，目前市场上有大量的糖尿病代糖产品，请问这些产品吃下去后对血糖值是否有影响？吃的量是否有要求？谢谢！', '2015-02-13 17:12:15', '30', '4', '44', '', '请问代糖产品对糖尿病血糖值是否有影响？');
INSERT INTO `t_question` VALUES ('118', null, '1', '您好，与老人饮水不方便，容易呛咳，请问有没有使食物变粘稠的方法？', '2015-02-13 17:25:29', '26', '5', '23', '', '请问有没有可以使食物变粘稠的好办法？');
INSERT INTO `t_question` VALUES ('119', null, '0', '看看他往那里写', '2015-07-30 17:38:26', '0', '1', '3', '', '就是测试数据');

-- ----------------------------
-- Table structure for `t_regist_code`
-- ----------------------------
DROP TABLE IF EXISTS `t_regist_code`;
CREATE TABLE `t_regist_code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_regist_code
-- ----------------------------
INSERT INTO `t_regist_code` VALUES ('1', '2015-01-03 17:14:31', '2218280258@qq.com', '0', 'a260a4c5-87b5-46c0-bde7-d20f539fc54f');
INSERT INTO `t_regist_code` VALUES ('2', '2015-01-03 17:17:33', '2218280258@qq.com', '0', 'c2c93835-c9a6-417a-9ce8-4c643ade8b23');
INSERT INTO `t_regist_code` VALUES ('3', '2015-01-03 17:22:03', '2218280258@qq.com', '0', '33f37e4f-d22f-4976-a5d7-c58b83d8984f');
INSERT INTO `t_regist_code` VALUES ('4', '2015-01-03 17:25:01', '2218280258@qq.com', '0', 'b8a45b50-cd03-4f7e-aaa9-6397dfbc9292');
INSERT INTO `t_regist_code` VALUES ('5', '2015-01-03 17:29:30', '2218280258@qq.com', '0', 'eea20e1f-9941-4999-854c-74f199b085f6');
INSERT INTO `t_regist_code` VALUES ('6', '2015-01-03 17:35:12', '2218280258@qq.com', '0', 'de556b67-bdb4-499a-bc6b-4a07df98b1f6');
INSERT INTO `t_regist_code` VALUES ('7', '2015-01-03 17:49:26', '2218280258@qq.com', '0', '1a138633-0f5e-410e-b302-c953ba6efd0f');
INSERT INTO `t_regist_code` VALUES ('8', '2015-01-03 19:25:23', '2218280258@qq.com', '0', 'ce9b5269-d229-47a5-896f-86730e26527b');
INSERT INTO `t_regist_code` VALUES ('9', '2015-01-03 19:30:27', '2218280258@qq.com', '0', 'be9b6d44-ed01-4380-b741-2da244d32947');
INSERT INTO `t_regist_code` VALUES ('10', '2015-01-03 22:12:15', '281683400@qq.com', '0', '0c60e9ca-dfed-4ea9-a72c-35da39d4c558');
INSERT INTO `t_regist_code` VALUES ('11', '2015-01-03 22:16:05', '281683400@qq.com', '0', '0478b991-8621-4b5a-a72a-50ac7051afec');
INSERT INTO `t_regist_code` VALUES ('12', '2015-01-04 20:35:04', '281683400@qq.com', '0', '7366d8ea-ca09-42cc-8b4a-d38dd9080660');
INSERT INTO `t_regist_code` VALUES ('13', '2015-01-04 20:38:15', '281683400@qq.com', '0', '9e2f5334-7196-408d-8a7a-de18cb044710');
INSERT INTO `t_regist_code` VALUES ('14', '2015-01-04 20:45:18', '281683400@qq.com', '0', 'b7ed60ef-35ec-40e3-b5e9-85bb5797850e');
INSERT INTO `t_regist_code` VALUES ('15', '2015-01-04 20:48:57', '281683400@qq.com', '0', '0be554b0-b3dd-4ccf-90b2-fbb2fb3238f8');
INSERT INTO `t_regist_code` VALUES ('16', '2015-01-04 20:49:17', '441435938@qq.com', '0', 'f9b4f377-5506-4085-b847-e24cc61421b0');
INSERT INTO `t_regist_code` VALUES ('17', '2015-01-04 20:52:05', '441435938@qq.com', '0', 'ed42f623-87d2-43fd-a482-bd76dfcf12fd');
INSERT INTO `t_regist_code` VALUES ('18', '2015-01-04 20:54:28', '441435938@qq.com', '0', 'b022829a-df1f-406a-a59f-6cab3a45623d');
INSERT INTO `t_regist_code` VALUES ('19', '2015-01-04 21:01:46', '281683400@qq.com', '0', '5b094e91-50b4-44c5-a0cf-42a7538252f9');
INSERT INTO `t_regist_code` VALUES ('20', '2015-01-04 21:06:17', '441435938@qq.com', '0', '53b70113-020e-4fd6-b59a-79101481319b');
INSERT INTO `t_regist_code` VALUES ('21', '2015-01-04 21:13:45', '281683400@qq.com', '0', '34ddec9d-7844-4f77-afb0-8753f626dd76');
INSERT INTO `t_regist_code` VALUES ('22', '2015-01-04 21:22:00', '67773940@qq.com', '0', 'caee50b0-1bea-4eae-b449-ae92d6f46e94');
INSERT INTO `t_regist_code` VALUES ('23', '2015-01-04 21:39:19', '441435938@qq.com', '0', 'c7094163-ec44-428a-80f6-a3d704cf9707');
INSERT INTO `t_regist_code` VALUES ('24', '2015-01-04 21:53:23', '441435938@qq.com', '0', '56152f09-6200-4c4b-8087-d9333ddf9dde');
INSERT INTO `t_regist_code` VALUES ('25', '2015-01-04 22:20:45', '441435938@qq.com', '0', '6bbda31f-05a3-43ee-a423-0912ac50db57');
INSERT INTO `t_regist_code` VALUES ('26', '2015-01-04 22:21:00', '441435938@qq.com', '0', 'fd917c7b-8718-4a64-af66-f5e2e11a396a');
INSERT INTO `t_regist_code` VALUES ('27', '2015-01-04 22:22:20', '441435938@qq.com', '0', '1591f7cb-10d2-4b13-bd06-f24da931e0f3');
INSERT INTO `t_regist_code` VALUES ('28', '2015-01-04 22:55:03', 'lin_qs357357@sina.com', '0', 'f80380cc-1ef6-4d43-bf0f-020297a7440a');
INSERT INTO `t_regist_code` VALUES ('29', '2015-01-04 23:02:50', '2218280258@qq.com', '0', 'bd172f03-567c-41da-9845-4f24cf8f40dc');
INSERT INTO `t_regist_code` VALUES ('30', '2015-01-04 23:06:22', '281683400@qq.com', '0', '13fd7351-d2b4-4917-b2ca-3fe7103aa02b');
INSERT INTO `t_regist_code` VALUES ('31', '2015-01-04 23:07:41', '2218280258@qq.com', '0', 'd4f02f9b-dab6-4157-9ee5-3ea80144a1a6');
INSERT INTO `t_regist_code` VALUES ('32', '2015-01-04 23:08:12', 'lin_qs357357@sina.com', '0', '5422cef9-8814-40e6-a6ad-91daf0c429ef');
INSERT INTO `t_regist_code` VALUES ('33', '2015-01-06 00:01:00', '281683400@qq.com', '0', '44940acd-fe6b-4f86-a1d8-475862b46f2c');
INSERT INTO `t_regist_code` VALUES ('34', '2015-01-06 18:42:07', '281683400@qq.com', '0', '3a865f8d-9aee-49b0-b088-489fc04b1d19');
INSERT INTO `t_regist_code` VALUES ('35', '2015-01-07 10:54:21', '67773940@qq.com', '0', '1cea701c-3962-43bd-b3b5-92b621a5d4dd');
INSERT INTO `t_regist_code` VALUES ('36', '2015-01-08 16:48:01', '67773940@qq.com', '0', 'a5e50aa1-d73a-4ddf-8db4-587f83fc6072');
INSERT INTO `t_regist_code` VALUES ('37', '2015-01-08 16:48:07', '67773940@qq.com', '0', '8c2d260b-8ec7-4ae0-b47f-b5ae7757eb2e');
INSERT INTO `t_regist_code` VALUES ('38', '2015-01-10 11:23:29', 'ycycoo@qq.com', '0', '2df7a541-69e9-44a7-a4f9-7b9dd04e55fb');
INSERT INTO `t_regist_code` VALUES ('39', '2015-01-11 20:22:14', '281683400@qq.com', '0', 'cb8f2da3-84bd-4b87-8f66-ebe13ea10a19');
INSERT INTO `t_regist_code` VALUES ('40', '2015-01-11 20:22:26', '281683400@qq.com', '0', 'b2c9365b-b70e-4cb7-8787-d9eb5c52caff');
INSERT INTO `t_regist_code` VALUES ('41', '2015-01-11 20:29:56', '281683400@qq.com', '0', '7131253f-721c-4d80-8daf-e0c288167822');
INSERT INTO `t_regist_code` VALUES ('42', '2015-01-11 20:30:48', '281683400@qq.com', '0', '61f11692-6dea-4f36-b33c-85448292adfe');
INSERT INTO `t_regist_code` VALUES ('43', '2015-01-11 20:31:27', '281683400@qq.com', '0', '84ae1dd7-112e-4d68-9971-8ef54ed4199b');
INSERT INTO `t_regist_code` VALUES ('44', '2015-01-12 10:17:42', 'ycycoo@qq.com', '0', 'af8b2231-3204-4a4f-8125-71590dd69982');
INSERT INTO `t_regist_code` VALUES ('45', '2015-01-12 10:20:36', 'ycycoo@qq.com', '0', '5a7e3bf2-cb83-433a-82ad-e1b0c813026c');
INSERT INTO `t_regist_code` VALUES ('46', '2015-01-12 21:54:05', '67773940@qq.com', '0', 'e56690c8-558a-44ad-a53a-64c7aaf1d6e3');
INSERT INTO `t_regist_code` VALUES ('47', '2015-01-13 11:22:56', '281683400@qq.com', '0', 'daf1c786-15d4-4fd3-b380-156a68036f4b');
INSERT INTO `t_regist_code` VALUES ('48', '2015-01-16 16:54:40', '1328691629@qq.com', '0', '6f3f6224-b4d5-4ed3-ac4c-d4ad9450c9c3');
INSERT INTO `t_regist_code` VALUES ('49', '2015-01-16 16:54:42', '1328691629@qq.com', '0', '3999ac95-3e06-4d62-852c-be3ba6ca11c1');
INSERT INTO `t_regist_code` VALUES ('50', '2015-01-17 20:45:09', '2921166909@qq.com', '0', 'fec0cc6e-b786-40dd-888a-5293bca3db08');
INSERT INTO `t_regist_code` VALUES ('51', '2015-01-17 20:45:09', '2921166909@qq.com', '0', '7ee85201-8e1f-4c27-baf8-6eee1d95c6fd');
INSERT INTO `t_regist_code` VALUES ('52', '2015-01-17 21:22:02', 'gwang@angelaround.com', '0', '9aa27bf9-095d-4819-bb9e-783abaae9a59');
INSERT INTO `t_regist_code` VALUES ('53', '2015-01-18 11:48:33', '94255971@qq.com', '0', '36e15726-fe0f-47af-983b-e4ad7a4df90d');
INSERT INTO `t_regist_code` VALUES ('54', '2015-01-19 08:59:05', '1328691629@qq.com', '0', 'eb4fe4f6-da00-4eb8-ab1b-bc852b30179c');
INSERT INTO `t_regist_code` VALUES ('55', '2015-01-19 08:59:06', '1328691629@qq.com', '0', '864232af-2a99-4079-97b1-b071ece5113c');
INSERT INTO `t_regist_code` VALUES ('56', '2015-01-19 08:59:08', '1328691629@qq.com', '0', '393eb622-c650-4b0b-bc92-ae36851278e3');
INSERT INTO `t_regist_code` VALUES ('57', '2015-01-19 09:02:48', '1328691629@qq.com', '0', '49ef5472-133b-4a18-af4f-ee4abdbfc86a');
INSERT INTO `t_regist_code` VALUES ('58', '2015-01-19 09:02:50', '1328691629@qq.com', '0', '728a2c69-053a-4c1d-be70-e0e63c76f4e8');
INSERT INTO `t_regist_code` VALUES ('59', '2015-01-19 09:04:52', 'emilyxiaobai@163.com', '0', '6f71e641-b436-47a0-a636-a2422ddb721c');
INSERT INTO `t_regist_code` VALUES ('60', '2015-01-19 10:11:33', '254186329@qq.com', '0', 'f932d040-4024-4f8e-a1f8-c5d46b8efaf2');
INSERT INTO `t_regist_code` VALUES ('61', '2015-01-19 10:18:38', 'qyu@angelaround.com', '0', '7d80003d-c9f4-4e66-86d9-ce917bd3e40d');
INSERT INTO `t_regist_code` VALUES ('62', '2015-01-19 10:26:34', '1098322060@qq.com', '0', 'd274f69b-be48-4f67-ae53-dfc48e945ef5');
INSERT INTO `t_regist_code` VALUES ('63', '2015-01-19 10:26:42', '1098322060@qq.com', '0', 'a81cb87e-65e2-40b0-8d5e-7dd52f050c7f');
INSERT INTO `t_regist_code` VALUES ('64', '2015-01-19 10:27:06', '1098322060@qq.com', '0', 'd2714eb4-ba5b-4c33-8704-7933a049ed5c');
INSERT INTO `t_regist_code` VALUES ('65', '2015-01-19 10:27:14', '43424432@qq.com', '0', '974d88dd-bd7a-4f57-ae18-45b5ad6677a0');
INSERT INTO `t_regist_code` VALUES ('66', '2015-01-19 10:31:21', '43424432@qq.com', '0', 'f093e4ac-30f8-47c7-ab1c-d296a6ec1965');
INSERT INTO `t_regist_code` VALUES ('67', '2015-01-19 10:33:28', '254186329@qq.com', '0', 'b02f5ee2-75a6-4834-ab4b-5ce81f54be69');
INSERT INTO `t_regist_code` VALUES ('68', '2015-01-19 11:24:02', '215009266@qq.com', '0', 'c54bee27-fa16-4510-bd48-f0143e85bafe');
INSERT INTO `t_regist_code` VALUES ('69', '2015-01-19 11:34:45', '43424432@qq.com', '0', '7b1591a1-f025-44d8-afb0-984e8c74b1c0');
INSERT INTO `t_regist_code` VALUES ('70', '2015-01-19 11:34:51', '43424432@qq.com', '0', 'f970084b-c272-4c03-92a4-8f78aa23ca72');
INSERT INTO `t_regist_code` VALUES ('71', '2015-01-19 11:35:21', '7498327498273@qq.com', '0', '6d160db8-6c84-4d44-b558-c8cb6c514a55');
INSERT INTO `t_regist_code` VALUES ('72', '2015-01-19 11:36:19', '1328691629@qq.com', '0', '9dd55195-c19a-46f4-8a17-b3a16a1b6676');
INSERT INTO `t_regist_code` VALUES ('73', '2015-01-19 11:41:09', '281683400@qq.com', '0', '3992bf84-896a-4af6-b216-f36317ff152d');
INSERT INTO `t_regist_code` VALUES ('74', '2015-01-19 11:57:33', '3184845147@qq.com', '0', '8a0a9607-5214-42c2-865c-51346693df39');
INSERT INTO `t_regist_code` VALUES ('75', '2015-01-19 11:57:41', '3184845147@qq.com', '0', '641346ca-e7d7-405e-a403-b07f99ad0c39');
INSERT INTO `t_regist_code` VALUES ('76', '2015-01-19 11:57:46', '3184845147@qq.com', '0', 'a8e3d52d-6c01-4900-a6d1-b054dd50525b');
INSERT INTO `t_regist_code` VALUES ('77', '2015-01-19 11:58:04', '3184845147@qq.com', '0', '8f29f172-7d86-4cdf-a174-8849cff87e22');
INSERT INTO `t_regist_code` VALUES ('78', '2015-01-19 11:58:16', '3184845147@qq.com', '0', 'd465aaa7-44e6-4161-86c6-0626098bcfa9');
INSERT INTO `t_regist_code` VALUES ('79', '2015-01-19 11:58:21', '3184845147@qq.com', '0', 'bf4e1bd1-17de-492f-83ce-39a4bef8e1fd');
INSERT INTO `t_regist_code` VALUES ('80', '2015-01-19 11:58:31', '3184845147@qq.com', '0', '7d0ff5e9-ee49-451c-b8a3-844cfe3129a3');
INSERT INTO `t_regist_code` VALUES ('81', '2015-01-19 11:58:49', '3184845147@qq.com', '0', '51da6889-ce14-47c7-bfd8-64d4ad8a30af');
INSERT INTO `t_regist_code` VALUES ('82', '2015-01-19 11:58:55', '3184845147@qq.com', '0', '66b3c392-c4bd-4724-9bfb-94d48a408ba1');
INSERT INTO `t_regist_code` VALUES ('83', '2015-01-19 12:02:06', '3184845147@qq.com', '0', 'f6a38f86-c7b5-415f-b65c-bcd1d5417aab');
INSERT INTO `t_regist_code` VALUES ('84', '2015-01-19 12:02:11', '3184845147@qq.com', '0', 'be0d9ad7-38cc-40b5-b4c1-34c9738f9c50');
INSERT INTO `t_regist_code` VALUES ('85', '2015-01-19 12:07:37', '3184845147@qq.com', '0', '3c77b5b3-c562-4b6d-a502-287b29e50c7c');
INSERT INTO `t_regist_code` VALUES ('86', '2015-01-19 12:30:44', 'cabbage166@163.com', '0', 'bc96c331-0b8d-4497-bee1-4aa03b0bffcb');
INSERT INTO `t_regist_code` VALUES ('87', '2015-01-19 12:35:20', '281683400@qq.com', '0', '0214607a-d51a-4dac-8d5c-da8a8f9c97c3');
INSERT INTO `t_regist_code` VALUES ('88', '2015-01-19 12:49:11', 'sakura_pinpin@163.com', '0', '0ba8a87c-3603-49ba-bf16-3b882415f1c0');
INSERT INTO `t_regist_code` VALUES ('89', '2015-01-19 13:20:33', 'moon12s@163.com', '0', 'b96d5504-27c1-4a12-8684-10fde94fa838');
INSERT INTO `t_regist_code` VALUES ('90', '2015-01-19 13:29:03', 'hulunbeier200@163.com', '0', 'b566a963-e732-4207-904a-5fe91b487bba');
INSERT INTO `t_regist_code` VALUES ('91', '2015-01-19 13:33:20', 'xiaomili600@163.com', '0', '62a2c46e-fe37-495f-aac6-f0b5791a5793');
INSERT INTO `t_regist_code` VALUES ('92', '2015-01-19 13:39:48', 'qqtang888@yeah.net', '0', '34193cc8-2e89-40fb-9854-0a43c4b8cfe6');
INSERT INTO `t_regist_code` VALUES ('93', '2015-01-19 13:44:36', '2985200639@qq.com', '0', '4ba33a18-25cf-49d3-b630-92852c650557');
INSERT INTO `t_regist_code` VALUES ('94', '2015-01-19 13:47:25', 'baixiaobaitoo@163.com', '0', '1bb73d0e-2772-4361-996b-ae175b36d14d');
INSERT INTO `t_regist_code` VALUES ('95', '2015-01-19 13:50:18', 'purexiaobai@163.com', '0', '71c5d5a5-ca9e-4c0c-98d0-65df71b5078e');
INSERT INTO `t_regist_code` VALUES ('96', '2015-01-19 13:51:23', 'purexiaobai@163.com', '0', '1ba7e76e-423e-4c7d-aab9-2b9f0d69f454');
INSERT INTO `t_regist_code` VALUES ('97', '2015-01-19 13:51:39', 'purexiaobai@163.com', '0', '88dbdac0-d7d8-4706-aaf6-6f91a9cd9eac');
INSERT INTO `t_regist_code` VALUES ('98', '2015-01-19 13:52:00', 'purexiaobai@163.com', '0', '8681b2ec-2c1b-4b28-afe7-4af68e1a96df');
INSERT INTO `t_regist_code` VALUES ('99', '2015-01-19 13:52:02', 'purexiaobai@163.com', '0', 'ecdf32ad-fc31-43b7-ae74-95d9da6ef04b');
INSERT INTO `t_regist_code` VALUES ('100', '2015-01-19 13:52:48', 'purexiaobai@163.com', '0', 'ce6b1fb4-ed28-45e2-93f3-32e268eff421');
INSERT INTO `t_regist_code` VALUES ('101', '2015-01-19 13:55:40', 'xiaobaipure@163.com', '0', '7e9092cd-4ff7-495b-8181-3a4599cba833');
INSERT INTO `t_regist_code` VALUES ('102', '2015-01-19 13:56:17', 'xiaobaipure@163.com', '0', 'c09d7798-1185-416c-9e25-abcc69ff2daa');
INSERT INTO `t_regist_code` VALUES ('103', '2015-01-19 13:56:26', 'xiaobaipure@163.com', '0', 'c272f638-46c1-4d40-a291-6927a08c92f9');
INSERT INTO `t_regist_code` VALUES ('104', '2015-01-19 13:58:40', 'whitexiaobai@163.com', '0', '5d3b2e24-f8f8-47b5-ada8-9f3411097ef3');
INSERT INTO `t_regist_code` VALUES ('105', '2015-01-19 14:01:14', 'emilybob3333@163.com', '0', 'c3be82b6-89cf-45fc-9181-255b45a9c010');
INSERT INTO `t_regist_code` VALUES ('106', '2015-01-19 14:03:11', 'heixiaobaibaihei@163.com', '0', 'faee1163-18ff-4402-9b49-6379b330ddb6');
INSERT INTO `t_regist_code` VALUES ('107', '2015-01-19 14:03:22', 'heixiaobaibaihei@163.com', '0', '9bfa901d-d132-4541-8622-a51e60dbaf44');
INSERT INTO `t_regist_code` VALUES ('108', '2015-01-19 15:45:17', 'afangcaodi@163.com', '0', '2b9985fd-2fbc-4695-a2cd-e2bd52fd3c56');
INSERT INTO `t_regist_code` VALUES ('109', '2015-01-19 15:57:35', 'afangcaodi@163.com', '0', '1b00196e-6a2d-4670-a468-d01305aaf885');
INSERT INTO `t_regist_code` VALUES ('110', '2015-01-20 00:46:13', '281683400@qq.com', '0', '92aab0bf-7215-4d5a-82b7-3382cd689dc7');
INSERT INTO `t_regist_code` VALUES ('111', '2015-01-20 11:18:26', 'qyu@angel-around.com', '0', 'ce918c2d-80a9-434b-b451-acfbb6274489');
INSERT INTO `t_regist_code` VALUES ('112', '2015-01-20 23:49:22', '281683400@qq.com', '0', 'd67d63d6-1761-464d-be9b-92188897f979');
INSERT INTO `t_regist_code` VALUES ('113', '2015-01-20 23:50:43', '281683400@qq.com', '0', 'd7b9f526-6699-40bd-9fb8-bc7b1e19acd8');
INSERT INTO `t_regist_code` VALUES ('114', '2015-01-21 00:12:15', '281683400@qq.com', '0', 'dac3a139-b9c0-447e-ab78-644ac7f9499e');
INSERT INTO `t_regist_code` VALUES ('115', '2015-01-21 15:47:10', 'afangcaodi@163.com', '0', 'de1d5b6b-699c-460a-826e-9a362186a5ec');
INSERT INTO `t_regist_code` VALUES ('116', '2015-01-21 16:22:22', 'ikiiki123@163.com', '0', '2a438efe-c606-4c4e-a03d-9d83c7e23caf');
INSERT INTO `t_regist_code` VALUES ('117', '2015-01-21 16:32:15', 'october10rr@163.com', '0', '2cd792a5-6872-4aea-843b-7a876a76d5df');
INSERT INTO `t_regist_code` VALUES ('118', '2015-01-21 16:32:30', 'october10rr@163.com', '0', '58d0c7ae-8f5a-4a81-9bb1-8b00d0608972');
INSERT INTO `t_regist_code` VALUES ('119', '2015-01-21 16:35:30', 'emilyxu2233@126.com', '0', '3ca152d8-7057-465d-a399-0f7c6e28af5f');
INSERT INTO `t_regist_code` VALUES ('120', '2015-01-21 16:46:11', 'twobao2bao@163.com', '0', '8167070c-9573-4183-b320-b13610209147');
INSERT INTO `t_regist_code` VALUES ('121', '2015-01-21 17:40:33', 'alicezhou3322@163.com', '0', '31f2b04f-e809-43c3-8826-861bfe4f0df8');
INSERT INTO `t_regist_code` VALUES ('122', '2015-01-21 17:40:35', 'alicezhou3322@163.com', '0', '76797256-5035-426a-8b69-014816fce764');
INSERT INTO `t_regist_code` VALUES ('123', '2015-01-21 17:40:36', 'alicezhou3322@163.com', '0', 'c6c29422-2395-4087-9e98-73de0382332e');
INSERT INTO `t_regist_code` VALUES ('124', '2015-01-21 17:40:37', 'alicezhou3322@163.com', '0', '2c3afdde-440a-41e8-9b84-ac63ff738c50');
INSERT INTO `t_regist_code` VALUES ('125', '2015-01-21 17:40:37', 'alicezhou3322@163.com', '0', '89a1f3dc-7db3-4a9b-9040-add43848db2d');
INSERT INTO `t_regist_code` VALUES ('126', '2015-01-21 17:40:38', 'alicezhou3322@163.com', '0', '4a570324-18e4-41ea-8673-5ac91dea4059');
INSERT INTO `t_regist_code` VALUES ('127', '2015-01-21 17:40:39', 'alicezhou3322@163.com', '0', '926bef8f-9ddb-4443-9c02-96f9dca8a807');
INSERT INTO `t_regist_code` VALUES ('128', '2015-01-21 17:44:29', 'xiaobaiyang868@163.com', '0', 'f1dac2f2-5f59-4fad-af4b-e90bb4474520');
INSERT INTO `t_regist_code` VALUES ('129', '2015-01-22 10:20:19', 'jiuyi8866@163.com', '0', 'd30b787e-3ae8-4302-8a92-c0b26ed2a341');
INSERT INTO `t_regist_code` VALUES ('130', '2015-01-30 05:39:41', 'sugarain@126.com', '0', '556000bc-a922-47ed-b13a-740fd7c21d2c');
INSERT INTO `t_regist_code` VALUES ('131', '2015-01-30 05:54:53', '2064696853@qq.com', '0', 'b457f3df-0fe8-4ed0-be5a-196905e33658');
INSERT INTO `t_regist_code` VALUES ('132', '2015-01-30 05:55:26', '2064696853@qq.com', '0', '64a8ee34-2457-43ac-9dee-792b6afbcc82');
INSERT INTO `t_regist_code` VALUES ('133', '2015-01-30 05:56:37', '2064696853@qq.com', '0', 'e5b483bd-97e4-4cc8-b192-5fa76825ff6e');
INSERT INTO `t_regist_code` VALUES ('134', '2015-02-02 14:28:54', 'qyu@angel-around.com', '0', '2283436e-6604-4eb0-a123-6022cd4e9ba6');
INSERT INTO `t_regist_code` VALUES ('135', '2015-02-03 09:03:42', '2064696853@qq.com', '0', '5b15f565-95d4-43eb-849c-8710695f93f0');
INSERT INTO `t_regist_code` VALUES ('136', '2015-02-04 10:37:58', '2064696853@qq.com', '0', '1d5787d9-21e7-4f3e-b442-decbe886c755');
INSERT INTO `t_regist_code` VALUES ('137', '2015-02-04 11:19:54', '2064696853@qq.com', '0', 'bce99619-fbb8-4b91-95e7-7c0440f1c3e3');
INSERT INTO `t_regist_code` VALUES ('138', '2015-02-08 11:31:35', 'baibaizhao@163.com', '0', 'a6231835-56b8-41ee-9e78-807cee39ae4b');
INSERT INTO `t_regist_code` VALUES ('139', '2015-02-08 11:37:02', 'zhaokobeaiwo@163.com', '0', 'b98f933c-139c-4163-a776-223ded99140c');
INSERT INTO `t_regist_code` VALUES ('140', '2015-02-08 11:43:28', 'baichangqing1122@163.com', '0', '42d88d64-e2f1-46aa-9298-0d6f0b2c0b54');
INSERT INTO `t_regist_code` VALUES ('141', '2015-02-08 16:20:32', '441435938@qq.com', '0', 'bc65c145-2cde-4e6a-bba5-7c58cfa60a8b');
INSERT INTO `t_regist_code` VALUES ('142', '2015-02-25 11:38:59', '469466993@qq.com', '0', '55886bfa-d5b4-4e4f-bad5-6485b765c319');
INSERT INTO `t_regist_code` VALUES ('143', '2015-02-25 11:39:10', '469466993@qq.com', '0', '71b9dab9-ae1a-45ad-84f4-77d1d76ebd91');
INSERT INTO `t_regist_code` VALUES ('144', '2015-02-25 17:09:00', '11111adad@qq.com', '0', 'bcac9461-d807-4d7d-b1d4-ab3374c17fd7');
INSERT INTO `t_regist_code` VALUES ('145', '2015-02-26 15:59:11', 'wanglin.317@163.com', '0', '9ee41955-3c57-4f38-9aec-21d1c3070c6c');
INSERT INTO `t_regist_code` VALUES ('146', '2015-03-24 14:14:36', 'liu.kai@trs.com.cn', '0', 'bf7bf902-9855-4907-a4c4-e0f2d4cf4a0c');
INSERT INTO `t_regist_code` VALUES ('147', '2015-03-24 14:15:26', 'ycycoo88@gmail.com', '0', 'a401b014-40e1-4717-9ba0-f844b177c85f');
INSERT INTO `t_regist_code` VALUES ('148', '2015-03-24 15:13:13', '364408930@qq.com', '0', '556064b9-fcd1-4fd1-9c82-ebba82778998');
INSERT INTO `t_regist_code` VALUES ('149', '2015-03-24 15:16:51', '364408930@qq.com', '0', '701b04a6-8e02-4023-9346-4193e4a5ae13');
INSERT INTO `t_regist_code` VALUES ('150', '2015-03-25 15:44:49', '281683400@qq.com', '0', '8eb890be-9c10-4240-bdac-c70edb727c64');
INSERT INTO `t_regist_code` VALUES ('151', '2015-03-25 16:15:18', 'lin_qs357357@sina.com', '0', '877f6c58-4539-414c-8f7b-b40f232af926');
INSERT INTO `t_regist_code` VALUES ('152', '2015-08-24 11:08:41', 'jluhan_bin@sina.com.cn', '0', '4dd105b8-7041-418e-a36e-6f3e966a576f');
INSERT INTO `t_regist_code` VALUES ('153', '2015-08-25 11:23:25', '811148051@qq.com', '0', '2687cdcf-a9d2-45f8-9576-3d887d332493');
INSERT INTO `t_regist_code` VALUES ('154', '2015-08-25 11:30:02', '811148051@qq.com', '0', '3232f8dc-6185-4eff-bd5f-43273330daf9');
INSERT INTO `t_regist_code` VALUES ('155', '2015-08-25 11:30:20', '811148051@qq.com', '0', 'b6279f7e-ab91-4647-bc1b-329ce9049f2b');
INSERT INTO `t_regist_code` VALUES ('156', '2015-08-25 11:34:37', '811148051@qq.com', '0', '02ea7304-4ff8-4fbc-8dce-acdc2ad6678b');
INSERT INTO `t_regist_code` VALUES ('157', '2015-08-25 11:36:15', '811148051@qq.com', '0', 'b7b12100-14dc-49e1-8e90-ca6e48e5dcde');
INSERT INTO `t_regist_code` VALUES ('158', '2015-08-25 15:44:04', '811148051@qq.com', '0', 'ec815ca0-496a-496a-af36-4d5a421cddcc');
INSERT INTO `t_regist_code` VALUES ('159', '2015-08-31 16:56:27', '2745554997@qq.com', '0', 'f3766110-9ff5-49bd-96e5-1d57846a8f93');
INSERT INTO `t_regist_code` VALUES ('160', '2015-09-06 20:12:16', '811148051@qq.com', '0', '07309e0d-0787-4486-a27d-323770527ca7');

-- ----------------------------
-- Table structure for `t_report`
-- ----------------------------
DROP TABLE IF EXISTS `t_report`;
CREATE TABLE `t_report` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `reason` varchar(10) NOT NULL COMMENT '举报原因',
  `reasondetail` varchar(100) DEFAULT NULL COMMENT '详细原因',
  `repid` int(10) NOT NULL COMMENT '那一条回复',
  `reporttime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '举报时间',
  `content` varchar(1000) DEFAULT NULL COMMENT '举报内容的显示',
  `fromtable` varchar(20) NOT NULL COMMENT '举报内容来自于那张表：\r\nreply:是指来自于t_topic_reply\r\ncomment:是指来自于t_comment',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_report
-- ----------------------------
INSERT INTO `t_report` VALUES ('9', '色情污染', '有黄色的东西', '65', '2015-08-21 16:50:55', '<p>回复eric(成都):ssssssssssss</p>\r\n', 'reply');
INSERT INTO `t_report` VALUES ('11', '广告', '原因', '60', '2015-08-21 16:53:32', '<p>1111111111111</p>\r\n', 'reply');

-- ----------------------------
-- Table structure for `t_senior_doctor`
-- ----------------------------
DROP TABLE IF EXISTS `t_senior_doctor`;
CREATE TABLE `t_senior_doctor` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL COMMENT '资深营养师姓名',
  `description` varchar(255) DEFAULT NULL COMMENT '医生描述',
  `header` varchar(500) DEFAULT NULL COMMENT '头像图片路径',
  `url` varchar(500) DEFAULT NULL COMMENT '访问地址URL',
  `sort` int(20) DEFAULT NULL COMMENT '数字越大越靠前',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_senior_doctor
-- ----------------------------
INSERT INTO `t_senior_doctor` VALUES ('2', '孙明晓', '北京医院营养科主任', 'upload/indexseniordochead/2015/02/08/96202013-db53-4349-9d81-7f8f299485a0.png', 'http://localhost:8888/anjilang/infor/toInforDetail.do?id=54', '10000', '2015-02-08 00:11:54', '2015-09-14 20:12:17');
INSERT INTO `t_senior_doctor` VALUES ('3', '景洪江', '空军总医院营养科主治医师', 'upload/indexseniordochead/2015/02/08/613a3da6-18de-4362-86a6-cab4adc1641d.png', 'http://localhost:8888/anjilang/infor/toInforDetail.do?id=52', '9999', '2015-02-08 00:13:08', '2015-09-14 20:12:23');
INSERT INTO `t_senior_doctor` VALUES ('4', '姚颖', '武汉同济医院肾病内科主任', 'upload/indexseniordochead/2015/02/08/d74e9bf1-2ee8-429f-b277-b84c9e0f645b.png', 'http://localhost:8888/anjilang/infor/toInforDetail.do?id=53', '9998', '2015-02-08 00:13:42', '2015-09-14 20:12:27');
INSERT INTO `t_senior_doctor` VALUES ('5', '陈伟', '北京协和医院营养科主任', 'upload/indexseniordochead/2015/02/08/1d972e4e-142f-4ecd-bd6b-df793ed986d8.png', 'http://localhost:8888/anjilang/infor/toInforDetail.do?id=55', '9997', '2015-02-08 00:14:33', '2015-09-14 20:12:34');
INSERT INTO `t_senior_doctor` VALUES ('6', '仝惠君', '煤炭总医院营养科主任', 'upload/indexseniordochead/2015/02/08/ce6c1649-859c-4a04-aced-5e710aff3b74.png', 'http://localhost:8888/anjilang/infor/toInforDetail.do?id=56', '9996', '2015-02-08 00:15:40', '2015-09-14 20:12:38');
INSERT INTO `t_senior_doctor` VALUES ('8', '高玉霞', '中国医学科学院整形外科医院营养科主任', 'upload/indexseniordochead/2015/08/13/c279019f-fa99-4a1a-b00c-f18f870ee2e8.png', 'http://localhost:8888/anjilang/infor/toInforDetail.do?id=58', '9995', '2015-02-13 17:37:50', '2015-09-14 20:12:44');

-- ----------------------------
-- Table structure for `t_spec_col`
-- ----------------------------
DROP TABLE IF EXISTS `t_spec_col`;
CREATE TABLE `t_spec_col` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL COMMENT '专栏标题',
  `content` varchar(300) DEFAULT NULL COMMENT '专栏内容',
  `pic` varchar(300) DEFAULT NULL COMMENT '专栏标志图片',
  `url` varchar(300) DEFAULT NULL COMMENT '专栏访问地址',
  `sort` int(11) DEFAULT NULL COMMENT '排序数字大靠前排序',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` datetime DEFAULT NULL,
  `author` varchar(20) DEFAULT NULL COMMENT '作者',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_spec_col
-- ----------------------------
INSERT INTO `t_spec_col` VALUES ('2', '且“吃”且预防,营养膳食预防慢性病', '卫生部长陈竺提出，未来医生必须会开两张处方：一张是针对病情开具的药方；另一张是膳食营养处方。未来的医生必须具备营养学的知识，针对慢性病，特别要发挥营养治疗的作用。将来，让我们的健康取决于每一天均衡的营养，营养保健食品是时代的需求，也是必然的产物。营养治疗将是解决慢性疾病的关键！', 'upload/indexspeccol/2015/02/09/71697986-28fe-4e9c-ae3e-618d4aae15ea.png', 'http://localhost:8888/anjilang/dietican/articleContent.do?id=26', '9999', '2015-09-14 20:12:59', '2015-02-08 19:08:30', null);
INSERT INTO `t_spec_col` VALUES ('3', '治疗膳食配置，您了解多少？', '一、高能量膳食1、适用对象，各种因素导致机体能量消耗增加的人，如体重不足、结核病、甲状腺功能亢进、癌症及严重烧伤和创伤的病人，还包括运动员、重体力劳动者等。', 'upload/indexspeccol/2015/02/09/71697986-28fe-4e9c-ae3e-618d4aae15ea.png', 'http://localhost:8888/anjilang/dietican/articleContent.do?id=30', '9998', '2015-09-14 20:13:04', '2015-02-08 19:10:43', null);
INSERT INTO `t_spec_col` VALUES ('4', '为你解读：糖尿病肾病防治专家共识！', '糖尿病肾病是糖尿病最主要的微血管并发症之一，是目前引起终末期肾病（end-stage renal disease，ESRD）的首要原因。不久前，中华医学会糖尿病学分会微血管并发症学组组织国内的内分泌和肾内科领域专家共同制定《糖尿病肾病防治专家共识（2014年版）》', 'upload/indexspeccol/2015/02/09/71697986-28fe-4e9c-ae3e-618d4aae15ea.png', 'http://localhost:8888/anjilang/dietican/articleContent.do?id=41', '9997', '2015-09-14 20:13:08', '2015-02-08 19:12:37', null);
INSERT INTO `t_spec_col` VALUES ('5', '主食吃少易患6种病', '因为可以吃到新鲜的蔬菜水果、丰富的鸡鸭鱼肉，越来越多人觉得，主食只是用来填饱肚子的，吃不吃都可以。然而，这种行为背后却有着巨大的健康隐患。只吃菜不吃饭，小心给身体惹来癌症和疾病。', 'upload/indexspeccol/2015/02/09/71697986-28fe-4e9c-ae3e-618d4aae15ea.png', 'http://localhost:8888/anjilang/dietican/articleContent.do?id=43', '9996', '2015-09-14 20:13:12', '2015-07-21 10:29:56', null);
INSERT INTO `t_spec_col` VALUES ('6', '感冒后最该做的9件事情！', '冷风瑟瑟，转眼又到了感冒的高发季。但得了感冒该治，还是像有些人说的那样扛着，直到它自然痊愈？众说纷纭的观点也让人难辨真假。感冒到底是怎么回事、感冒后应该怎么办？综合美国最新研究，为您揭示了这一系列问题的答案。', 'upload/indexspeccol/2015/02/09/71697986-28fe-4e9c-ae3e-618d4aae15ea.png', 'http://localhost:8888/anjilang/dietican/articleContent.do?id=43', '8000', '2015-09-14 20:13:17', '2015-07-21 10:29:54', null);
INSERT INTO `t_spec_col` VALUES ('7', '“营养治病”抢先看！', '解放军301部队总医院正式启动亚健康门诊，功能性保健食品登录三甲医院，医生开方手册全部采用营养保健产品。医院实施亚健康病人、重病患者辅助治疗及病后康复治疗等项目。医院已经把增强机体免疫力，防治治病，提高人体健康素质纳入到保健治疗规划中。', 'upload/indexspeccol/2015/02/09/71697986-28fe-4e9c-ae3e-618d4aae15ea.png', 'http://localhost:8888/anjilang/dietican/articleContent.do?id=27', '7999', '2015-09-14 20:13:22', '2015-07-13 10:30:40', null);
INSERT INTO `t_spec_col` VALUES ('8', '随便填写了', '就是测试修改的内容对吗', 'upload/indexspeccol/2015/02/09/71697986-28fe-4e9c-ae3e-618d4aae15ea.png', 'http://localhost:8888/anjilang/dietican/articleContent.do?id=27', '0', '2015-09-14 20:13:28', '2015-07-30 15:50:42', null);

-- ----------------------------
-- Table structure for `t_topic_recom`
-- ----------------------------
DROP TABLE IF EXISTS `t_topic_recom`;
CREATE TABLE `t_topic_recom` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `rectype` varchar(255) DEFAULT NULL COMMENT '推荐文章的类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_topic_recom
-- ----------------------------
INSERT INTO `t_topic_recom` VALUES ('1', '首页图文');
INSERT INTO `t_topic_recom` VALUES ('2', '首页文章');
INSERT INTO `t_topic_recom` VALUES ('3', '内容页图文');
INSERT INTO `t_topic_recom` VALUES ('4', '内容页文章');

-- ----------------------------
-- Table structure for `t_topic_reply`
-- ----------------------------
DROP TABLE IF EXISTS `t_topic_reply`;
CREATE TABLE `t_topic_reply` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `content` varchar(1000) DEFAULT NULL COMMENT '内容',
  `floor` int(8) DEFAULT '0' COMMENT '楼层',
  `repid` int(10) DEFAULT NULL COMMENT '回复者id',
  `reptime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '回复时间',
  `topicid` int(10) DEFAULT NULL COMMENT '回复主题',
  `repcount` int(8) DEFAULT NULL COMMENT '回复的条数',
  `quoteid` int(10) DEFAULT NULL COMMENT '引用那个评论',
  `berelyid` int(10) DEFAULT NULL COMMENT '被回复的那一条topic_reply的id',
  `isdelete` tinyint(1) DEFAULT '0' COMMENT '是否删除？1代表true，0代表false',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_topic_reply
-- ----------------------------
INSERT INTO `t_topic_reply` VALUES ('1', '<p>不要在粗心大意了</p>\r\n', '1', '7', '2015-07-30 22:02:07', '2', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('2', '<p>再回一条吧<br />\r\n&nbsp;</p>\r\n', '2', '7', '2015-07-31 15:32:09', '2', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('3', '<p>回复eric(重庆):为什么会有空指针异常呢</p>\r\n', '3', '3', '2015-07-31 18:13:52', '2', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('4', '<p>回复刘大爷(重庆):回复给自己试试</p>\r\n', '4', '3', '2015-07-31 18:16:20', '2', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('5', '<p>回复刘大爷(成都市成华区云龙南路19号):回复最新一条资讯</p>\r\n', '5', '3', '2015-07-31 18:18:42', '2', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('6', '<p>添加最新回复</p>\r\n', '1', '3', '2015-07-31 18:19:43', '1', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('7', '<p>回复刘大爷(成都市成华区云龙南路19号):查看回复功能</p>\r\n', '2', '3', '2015-07-31 18:20:10', '1', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('8', '<p>进行回复，看看楼层对不对</p>\r\n', '3', '7', '2015-07-31 19:07:36', '1', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('9', '<p>回复刘大爷(成都市成华区云龙南路19号):会不会在增加浏览</p>\r\n', '6', '3', '2015-07-31 20:47:35', '2', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('10', '<p>回复():不知道会增加多少个</p>\r\n', '7', '7', '2015-07-31 19:38:29', '2', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('11', '<p>进行回复</p>\r\n', '4', '7', '2015-07-31 20:47:30', '1', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('12', '<p>现在进行回复是对的，但是没有对用户进行判断<br />\r\n&nbsp;</p>\r\n', '5', '3', '2015-07-31 20:49:08', '1', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('13', '<p>再一次进行猜测是</p>\r\n', '6', '60', '2015-07-31 21:06:54', '1', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('14', '<p>刚才信息出错，不好意思啊</p>\r\n', '7', '60', '2015-07-31 21:09:51', '1', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('15', '<p>不好意思，一直在出错</p>\r\n', '8', '60', '2015-07-31 21:12:04', '1', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('16', '<p>不想再产生脏数据了<br />\r\n&nbsp;</p>\r\n', '9', '60', '2015-07-31 21:24:53', '1', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('17', '<p>现在能提交评价了吧</p>\r\n', '10', '3', '2015-08-01 10:09:22', '1', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('18', '<p>我看看管理员能提交吗</p>\r\n', '11', '7', '2015-08-01 10:19:50', '1', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('19', '<p>回复邵清()的引文:是吗</p>\r\n', '12', '63', '2015-08-01 13:07:53', '1', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('20', '<p>thery</p>\r\n', '13', '63', '2015-08-01 18:56:03', '1', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('21', '<p>为什么昨天晚上就行啊<br />\r\n&nbsp;</p>\r\n', '14', '63', '2015-08-01 18:56:48', '1', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('22', '<p>回复<a href=\"#\">李晓牧</a>:我不是成员</p>\r\n', '1', '63', '2015-08-02 22:26:10', '14', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('23', '<p>回复李晓牧():为什么突然间又出错了</p>\r\n', '2', '63', '2015-08-02 22:30:37', '14', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('24', '<p>为</p>\r\n\r\n<p>神</p>\r\n\r\n<p>么</p>\r\n', '3', '63', '2015-08-02 22:32:26', '14', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('25', '<p>回复李晓牧():让他</p>\r\n', '4', '63', '2015-08-02 22:35:28', '14', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('26', '', '5', '63', '2015-08-02 22:37:28', '14', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('27', '<p>事实上</p>\r\n', '6', '63', '2015-08-02 22:37:44', '14', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('28', '<p>顶</p>\r\n', '7', '7', '2015-08-03 09:50:31', '14', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('29', '<p>的顶顶顶顶顶<br />\r\n&nbsp;</p>\r\n', '8', '63', '2015-08-03 09:52:07', '14', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('30', '<p>回复</p>\r\n', '1', '7', '2015-08-04 11:52:05', '32', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('31', '<p>回复<a href=\"#\">linqingsongsong12</a>:回复</p>\r\n', '2', '7', '2015-08-04 11:52:26', '32', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('32', '<p>回复一条信息</p>\r\n', '1', '3', '2015-08-04 16:41:33', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('33', '<p>顶</p>\r\n', '2', '7', '2015-08-04 16:51:32', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('34', '<p>再一次回复</p>\r\n', '3', '7', '2015-08-04 16:51:43', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('35', '<p>速七结局保罗和赛迪尔开着车相识一笑最终开往不同的两条岔路时,<br />\r\n感觉泪就自己掉下来了<br />\r\n感觉不是在看电影,是看见了人生<br />\r\n真的觉得这是最好的结局了,<br />\r\n为了永远的保罗沃克</p>\r\n', '4', '7', '2015-08-04 16:51:56', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('36', '<p>速七结局保罗和赛迪尔开着车相识一笑最终开往不同的两条岔路时,<br />\r\n感觉泪就自己掉下来了<br />\r\n感觉不是在看电影,是看见了人生<br />\r\n真的觉得这是最好的结局了,<br />\r\n为了永远的保罗沃克</p>\r\n', '5', '7', '2015-08-04 16:52:03', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('37', '<p>速七结局保罗和赛迪尔开着车相识一笑最终开往不同的两条岔路时,<br />\r\n感觉泪就自己掉下来了<br />\r\n感觉不是在看电影,是看见了人生<br />\r\n真的觉得这是最好的结局了,<br />\r\n为了永远的保罗沃克</p>\r\n', '6', '7', '2015-08-04 16:52:08', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('38', '', '7', '3', '2015-08-06 10:50:10', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('39', '', '8', '3', '2015-08-06 10:52:09', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('40', '', '9', '3', '2015-08-06 10:55:59', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('41', '', '10', '3', '2015-08-21 16:44:05', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('42', '', '11', '3', '2015-08-06 11:03:20', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('43', '', '12', '3', '2015-08-06 11:05:47', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('44', '', '13', '3', '2015-08-06 11:07:25', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('45', '', '14', '3', '2015-08-06 11:09:31', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('46', '<p>回复刘大爷(成都市成华区云龙南路19号):ttttt</p>\r\n', '15', '10', '2015-08-06 11:37:46', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('47', '<p>ttttt</p>\r\n', '16', '10', '2015-08-06 11:48:03', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('48', '', '17', '10', '2015-08-06 11:48:25', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('49', '<p>tttt</p>\r\n', '18', '10', '2015-08-06 11:48:51', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('50', '<p>ttttt</p>\r\n', '19', '3', '2015-08-06 15:10:42', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('51', '<p>tttttt</p>\r\n', '20', '3', '2015-08-06 15:11:16', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('52', '<p>ddddddd</p>\r\n', '21', '3', '2015-08-06 15:11:35', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('53', '<p>tttt</p>\r\n', '22', '3', '2015-08-06 15:13:40', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('54', '<p><br />\r\n&nbsp;</p>\r\n', '1', '3', '2015-08-07 10:00:29', '38', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('55', '<p>对对对对对对对</p>\r\n', '2', '3', '2015-08-07 10:01:01', '38', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('56', '<p>顶顶顶顶</p>\r\n', '3', '3', '2015-08-07 10:03:09', '38', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('57', '<p>顶顶顶顶顶顶顶顶顶顶</p>\r\n', '4', '3', '2015-08-09 15:18:06', '38', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('58', '<p>顶顶顶顶顶顶顶顶</p>\r\n', '5', '10', '2015-08-09 15:18:59', '38', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('59', '<p>顶</p>\r\n', '6', '10', '2015-08-09 18:40:51', '38', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('60', '<p>1111111111111</p>\r\n', '1', '7', '2015-08-16 20:22:22', '66', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('61', '<p>tttttttttttttttt</p>\r\n', '23', '7', '2015-08-16 20:26:35', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('62', '<p>sssssssssssssssss</p>\r\n', '24', '7', '2015-08-16 20:27:01', '33', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('63', '<p>ggggggggggggg</p>\r\n', '1', '7', '2015-08-16 20:37:01', '62', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('64', '<p>ddddddddddddd</p>\r\n', '2', '7', '2015-08-16 20:37:14', '62', null, null, null, '0');
INSERT INTO `t_topic_reply` VALUES ('65', '<p>回复eric(成都):ssssssssssss</p>\r\n', '2', '7', '2015-08-20 17:02:42', '66', null, null, null, '1');
INSERT INTO `t_topic_reply` VALUES ('66', '<p>回复刘大爷(成都市成华区云龙南路19号):ttttttttttttttt</p>\r\n', '25', '7', '2015-08-19 15:11:15', '33', null, null, '33', '0');
INSERT INTO `t_topic_reply` VALUES ('67', '<p>trrrrrr</p>\r\n', '1', '7', '2015-08-19 15:28:11', '65', null, null, '65', '0');
INSERT INTO `t_topic_reply` VALUES ('68', '<p>回复linqingsongsong12():ooooooooooooo</p>\r\n', '26', '7', '2015-08-19 15:48:21', '33', null, '49', '33', '0');
INSERT INTO `t_topic_reply` VALUES ('69', '<p>回复eric(成都):bbbbbbbbbb</p>\r\n', '3', '11', '2015-08-19 16:03:59', '66', null, '60', '66', '0');
INSERT INTO `t_topic_reply` VALUES ('70', '<p>回复eric(成都):ggtyy</p>\r\n', '4', '83', '2015-08-20 10:11:55', '66', null, '60', '66', '0');

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `weiboUid` varchar(50) DEFAULT NULL COMMENT '微博UID',
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `audit` varchar(255) DEFAULT NULL COMMENT '医生的审核状态(仅医生用)',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `certificate_no` varchar(255) DEFAULT NULL COMMENT '医生从业证书(仅医生用)',
  `city` bigint(20) DEFAULT NULL COMMENT '医生注册城市Id(仅医生用)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `header` varchar(255) DEFAULT NULL COMMENT '头像',
  `hospital` varchar(255) DEFAULT NULL COMMENT '医生工作医院(仅医生用)',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `phone` varchar(255) DEFAULT NULL COMMENT '手机号',
  `project` varchar(255) DEFAULT NULL COMMENT '擅长项目如: ,1,2, 格式存储(仅医生用)',
  `province` bigint(20) DEFAULT NULL COMMENT '医生注册身份(仅医生用)',
  `real_name` varchar(255) DEFAULT NULL COMMENT '真实姓名',
  `sex` int(11) DEFAULT NULL COMMENT '性别1-男 2-女',
  `title` varchar(255) DEFAULT NULL COMMENT '医生职务 (仅医生用)',
  `type` varchar(255) DEFAULT NULL COMMENT '1-医生2-普通用户3-管理员',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `user_name` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `signature` varchar(255) DEFAULT NULL COMMENT '个性签名',
  `doctor_type` int(11) DEFAULT NULL COMMENT '医生类型 表ID(仅医生用)',
  `addr` varchar(100) DEFAULT NULL COMMENT '居住地',
  `education` varchar(20) DEFAULT NULL COMMENT '学历',
  `eduExperience` text COMMENT '教育经历',
  `resume` text COMMENT '简历',
  `answerNum` int(11) DEFAULT '0' COMMENT '回答问题数',
  `qqOpenId` varchar(40) DEFAULT NULL COMMENT 'QQopenId',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (null, '3', '1', '2015-01-16', null, '1', '2015-01-11 20:31:47', 'image/defaultHead.png', '成都市第一人民医院', 'linqs357357', null, ',1,', '1', '刘大爷', '2', '主任医师', '2', null, '281683403@qq.com', '感冒了,一直流鼻涕。那么疑问来了', '1', '成都市成华区云龙南路19号', null, null, '倒萨大师大师大师的倒萨大师大大 sad大声道大声道 倒萨大师大师大师的倒萨大师大大 sad大声道大声道 倒萨大师大师大师的倒萨大师大大 sad大声道大声道 倒萨大师大师大师的倒萨大师大大 sad大声道大声道', '0', null);
INSERT INTO `t_user` VALUES (null, '7', null, '2014-12-12', null, null, '2015-01-12 10:21:11', 'upload/2015/08/03/e8f1b420-50c9-47b4-8a99-284ecfdd7e9f.png', null, '123456', null, null, null, 'eric', '1', null, '3', null, 'ycycoo@qq.com', 'aaa', null, '成都', null, null, null, '4', null);
INSERT INTO `t_user` VALUES (null, '8', null, '1986-01-08', null, null, '2015-01-12 21:54:39', 'upload/head/2015/01/21/50201911-f0ba-4a45-8867-9200eb1a4eba.png', '成都市第一人民医院', 'yuquan86', null, null, null, 'springyu', '1', null, '3', null, '67773940@qq.com', null, null, 'beijing', null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '10', null, null, null, null, '2015-01-13 11:25:19', 'image/defaultHead.png', null, '357357', null, null, null, 'linqingsongsong12', '1', null, '2', null, '281683402@qq.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '11', null, '2015-01-14', null, null, '2015-01-14 18:43:00', 'image/defaultHead.png', null, '123456', null, null, null, 'admin', '1', null, '3', null, 'admin@qq.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '16', null, null, null, null, '2015-01-17 21:01:14', 'upload/head/2015/01/21/5278de73-17de-45d9-abd3-b326fe9acc06.png', null, 'wanggeng123', null, null, null, 'qiaoyu', null, null, '3', null, '2921166909@qq.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '17', null, null, null, null, '2015-01-17 21:25:37', 'image/defaultHead.png', null, 'genkiwanggeng', null, null, null, 'takumi', null, null, '2', null, 'gwang@angelaround.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '18', null, null, null, null, '2015-01-18 11:49:24', 'image/defaultHead.png', null, '19840814', null, null, null, 'luffy', null, null, '3', null, '94255971@qq.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '19', null, null, null, null, '2015-01-19 10:20:55', 'image/defaultHead.png', null, 'yuquan', null, null, null, '于大', null, null, '2', null, 'qyu@angelaround.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '20', null, null, null, null, '2015-01-19 11:32:43', 'image/defaultHead.png', null, 'genkiwanggeng', null, null, null, 'liuxiaobao', null, null, '2', null, '215009266@qq.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '21', null, '1987-10-17', null, '1', '2015-01-19 11:37:47', 'image/defaultHead.png', null, '123456', null, ',1,4,5,', '4', '白白', '2', null, '3', null, '1328691629@qq.com', '健康', null, '北京', null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '22', null, null, null, null, '2015-01-19 12:08:44', 'image/defaultHead.png', null, '123456a', null, null, null, '爱吃大米', '2', null, '2', null, '3184845147@qq.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '23', null, null, null, null, '2015-01-19 12:31:41', 'image/defaultHead.png', null, '123456a', null, null, null, '摘月亮的小兔', null, null, '2', null, 'cabbage166@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '24', null, null, null, null, '2015-01-19 12:50:11', 'image/defaultHead.png', null, '123456a', null, null, null, 'sakura', null, null, '2', null, 'sakura_pinpin@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '25', null, null, null, null, '2015-01-19 13:22:03', 'image/defaultHead.png', null, '123456a', null, null, null, '老伙伴', null, null, '2', null, 'moon12s@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '26', null, null, null, null, '2015-01-19 13:30:12', 'image/defaultHead.png', null, '123456a', null, null, null, '草原', null, null, '3', null, 'hulunbeier200@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '27', null, null, null, null, '2015-01-19 13:34:26', 'image/defaultHead.png', null, '123456a', null, null, null, '小米粒', null, null, '2', null, 'xiaomili600@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '28', null, null, null, null, '2015-01-19 13:41:01', 'image/defaultHead.png', null, '123456a', null, null, null, 'QQ糖', null, null, '2', null, 'qqtang888@yeah.net', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '29', null, null, null, null, '2015-01-19 13:45:39', 'image/defaultHead.png', null, '123456a', null, null, null, '萌萌', '2', null, '2', null, '2985200639@qq.com', null, null, '北京', null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '30', null, null, null, null, '2015-01-19 13:48:43', 'image/defaultHead.png', null, '123456a', null, null, null, '白小白图', null, null, '2', null, 'baixiaobaitoo@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '31', null, null, null, null, '2015-01-19 13:54:12', 'image/defaultHead.png', null, '123456a', null, null, null, '纯色', null, null, '2', null, 'purexiaobai@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '32', null, '2015-01-19', null, null, '2015-01-19 13:57:17', 'image/defaultHead.png', null, '123456a', null, null, null, '陈云海', '2', null, '2', null, 'xiaobaipure@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '33', null, null, null, null, '2015-01-19 14:02:14', 'image/defaultHead.png', null, '123456a', null, null, null, 'bob3333', null, null, '2', null, 'emilybob3333@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '34', null, null, null, null, '2015-01-19 14:07:16', 'image/defaultHead.png', null, '123456a', null, null, null, '清风拂面', null, null, '2', null, 'heixiaobaibaihei@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '38', '2', '1980-10-20', '1000100206', '3', '2015-01-21 09:09:38', 'image/defaultHead.png', null, '123456a', '18532536982', ',1,4,5,', '1', '李巧郁', '2', '公共营养师', '3', null, 'oukou2005@yahoo.co.jp', null, '1', null, null, null, null, '2', null);
INSERT INTO `t_user` VALUES (null, '39', null, null, null, null, '2015-01-21 15:48:23', 'image/defaultHead.png', null, '123456a', null, null, null, '芳草地', null, null, '2', null, 'afangcaodi@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '40', null, null, null, null, '2015-01-21 16:23:16', 'image/defaultHead.png', null, '123456a', null, null, null, '伊可新', null, null, '2', null, 'ikiiki123@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '41', null, null, null, null, '2015-01-21 16:33:57', 'image/defaultHead.png', null, '123456a', null, null, null, 'jinqiu十月', null, null, '2', null, 'october10rr@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '42', null, null, null, null, '2015-01-21 16:36:33', 'image/defaultHead.png', null, '123456a', null, null, null, '爱米粒', null, null, '2', null, 'emilyxu2233@126.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '43', null, null, null, null, '2015-01-21 16:47:15', 'image/defaultHead.png', null, '123456a', null, null, null, '二宝mama', null, null, '2', null, 'twobao2bao@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '44', null, null, null, null, '2015-01-21 17:42:10', 'image/defaultHead.png', null, '123456a', null, null, null, '周周', null, null, '2', null, 'alicezhou3322@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '45', null, null, null, null, '2015-01-21 17:45:33', 'image/defaultHead.png', null, '123456a', null, null, null, '黄土高原的白杨', null, null, '2', null, 'xiaobaiyang868@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '46', null, null, null, null, '2015-01-22 10:21:14', 'image/defaultHead.png', null, '123456a', null, null, null, '伊伊', null, null, '2', null, 'jiuyi8866@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '52', '2', '1968-04-16', '1060032510733029', '3', '2015-01-29 17:34:25', 'upload/head/2015/01/29/2a6e168c-847a-430a-bf92-55854985a114.png', '高级公共营养师', '123456a', '10000000000', ',4,5,', '1', '王丹', '2', '高级公共营养师', '1', null, 'wandanyys@163.com', null, '2', null, null, null, '出版《同居的男人》等3部小说后，突然放弃美好的生活，开始世界游', '0', null);
INSERT INTO `t_user` VALUES (null, '53', '2', '1973-10-23', '1000227598364200', '25', '2015-01-29 17:40:40', 'upload/head/2015/01/29/77a6d258-1124-4e8f-946d-d405c9c2882e.png', '高级公共营养师', null, '10000000000', ',4,5,', '20', '刘蕾', '2', '高级公共营养师', '1', null, 'liuleiyysh@163.com', null, '1', null, null, null, '出版《同居的男人》等3部小说后，突然放弃美好的生活，开始世界游', '1', null);
INSERT INTO `t_user` VALUES (null, '54', '2', '1959-03-22', '1002136172005667', '866', '2015-01-29 17:48:25', 'upload/head/2015/01/29/2727ff90-4b3e-4ca8-bdb6-bab5fe823934.png', '上海市某医院', '123456a', '10000000000', ',1,4,', '860', '赵博清', '2', '高级公共营养师', '1', null, 'zhaoboqingyys@163.com', null, '1', null, null, null, '出版《同居的男人》等3部小说后，突然放弃美好的生活，开始世界游', '0', null);
INSERT INTO `t_user` VALUES (null, '55', null, null, null, null, '2015-02-08 11:32:09', 'image/defaultHead.png', null, '123456a', null, null, null, '赵科比', null, null, '2', null, 'baibaizhao@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '56', null, null, null, null, '2015-02-08 11:38:05', 'image/defaultHead.png', null, '123456a', null, null, null, '爱我中华', null, null, '2', null, 'zhaokobeaiwo@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '57', null, null, null, null, '2015-02-08 11:43:51', 'image/defaultHead.png', null, '123456a', null, null, null, '小豆', null, null, '2', null, 'baichangqing1122@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '58', '2', '1978-03-08', '123456789', '3', '2015-02-08 12:45:17', 'upload/head/2015/02/08/bbeb5866-4014-4428-bffe-84ee7dfbfbf6.png', '北京某医院', null, '13521441526', ',4,5,', '1', '徐立', '2', '临床营养师', '1', null, 'xulilixu@126.com', null, '1', null, null, null, null, '1', null);
INSERT INTO `t_user` VALUES (null, '59', '2', '1975-01-30', '123456', '3', '2015-02-08 15:45:06', 'upload/head/2015/02/08/5f95f2dd-9780-4d77-b314-928291a49b65.png', '天津某医科大学', null, '13520062123', ',1,4,', '1', '王昊然', '1', '高级公共营养师', '1', null, 'zhaohaojianjian@163.com', null, '1', null, null, null, null, '1', null);
INSERT INTO `t_user` VALUES (null, '60', '2', '1985-02-01', '123456', '1488', '2015-02-08 15:59:38', 'upload/head/2015/02/08/871729ca-ec17-4256-9e7f-e5ea71d6845c.png', '济南某医院', '123456a', '13520055696', ',4,5,', '1487', '邵清', '1', '临床营养师', '1', null, 'shaoqingyys@163.com', null, '1', null, null, null, null, '3', null);
INSERT INTO `t_user` VALUES (null, '61', '2', '1983-09-01', '123456', '5', '2015-02-08 16:10:48', 'upload/head/2015/02/08/bf9be53b-f28e-4a54-9e0a-f774630b6b46.png', '北京某医院', '123456a', '13521001145', ',4,', '1', '刘雪曦', '2', '临床营养师', '1', null, 'liuxuexiyys@163.com', null, '1', null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '62', '2', '1975-02-02', '123456', '862', '2015-02-08 16:15:27', 'upload/head/2015/02/08/d596c882-db1f-4a32-b8e2-b5db3c10ffff.png', '上海某医院', '123456a', '13520065698', ',1,', '860', '张子涵', '2', '高级公共营养师', '1', null, 'zihanzhangyys@163.com', null, '1', null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '63', '2', '1970-07-02', '123456', '629', '2015-02-08 16:31:37', 'upload/head/2015/02/08/0dcdaf38-4ea7-482f-b83a-c125cb1e5b27.png', '长春市某医院', '123456a', '13521115545', ',1,', '628', '李晓牧', '1', '临床营养师', '1', null, 'lixiaomoyys@163.com', null, '1', null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '64', '2', '1982-04-07', '123456', '3', '2015-02-08 16:36:50', 'upload/head/2015/02/08/fff729c2-7dcb-42a6-93e2-3d5bc46c6227.png', '北京某医院', null, '13525056323', ',1,4,', '1', '闫伟', '1', '高级公共营养师', '1', null, 'weiweiyanyys@163.com', null, '1', null, null, null, null, '1', null);
INSERT INTO `t_user` VALUES (null, '65', '2', '1975-09-08', '123456', '3', '2015-02-08 16:53:23', 'upload/head/2015/02/08/a42267fb-bd4b-4265-82be-c318f014eb39.png', '江苏某医院', null, '13562524151', ',4,5,', '1', '贾彬', '1', '临床营养师', '1', null, 'jiabinyys@163.com', null, '1', null, null, null, null, '1', null);
INSERT INTO `t_user` VALUES (null, '70', null, null, null, null, '2015-02-25 11:39:31', 'image/defaultHead.png', null, 'nihao123', null, null, null, 'xxxx', null, null, '2', null, '469466993@qq.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '73', null, null, null, null, '2015-02-25 22:01:39', 'image/defaultHead.png', null, null, null, null, null, '曐辰む朢月', null, null, '2', null, null, null, null, null, null, null, null, '0', '91C7620C74D07E0F74E5D09AC4D1BD8A');
INSERT INTO `t_user` VALUES ('1272723362', '74', null, null, null, null, '2015-02-26 14:58:07', 'image/defaultHead.png', null, null, null, null, null, '曐辰朢月', null, null, '2', null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '75', null, null, null, null, '2015-02-26 15:07:25', 'image/defaultHead.png', null, null, null, null, null, null, null, null, '2', null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '76', null, null, null, null, '2015-02-26 16:00:47', 'image/defaultHead.png', null, '123456', null, null, null, 'luke', null, null, '2', null, 'wanglin.317@163.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '77', null, null, null, null, '2015-02-28 14:29:11', 'image/defaultHead.png', null, null, null, null, null, null, null, null, '2', null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '78', null, null, null, null, '2015-03-24 14:16:29', 'image/defaultHead.png', null, '123456', null, null, null, 'aaccccc', null, null, '2', null, 'ycycoo88@gmail.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '79', null, null, null, null, '2015-03-24 15:17:25', 'image/defaultHead.png', null, '123456', null, null, null, 'aacccccb', null, null, '2', null, '364408930@qq.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '81', null, null, null, null, '2015-03-25 15:49:39', 'image/defaultHead.png', null, '357357', null, null, null, '你好', null, null, '2', null, '281683400@qq.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '82', null, null, null, null, '2015-03-25 16:15:50', 'image/defaultHead.png', null, '357357', null, null, null, '21312312213', null, null, '2', null, 'lin_qs357357@sina.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '84', null, null, null, null, null, null, null, '111111', null, null, null, null, null, null, null, null, '', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '85', null, null, null, null, '2015-09-06 10:40:00', 'image/defaultHead.png', null, '123456', '18600508871', null, null, 'lele', null, null, '2', null, 'jluhan_bin@sina.com.cn', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '89', null, null, null, null, '2015-09-14 20:33:05', 'image/defaultHead.png', null, '111111', '', null, null, 'wzw', null, null, '2', null, 'wzqjava@126.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '90', null, null, null, null, '2015-09-14 20:40:01', 'image/defaultHead.png', null, '111111', '', null, null, 'houjinfeng', null, null, '2', null, 'wzq@qq.com', null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '91', null, null, null, null, null, null, null, '111111', '13261500434', null, null, 'houhou222', null, null, null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '92', null, null, null, null, null, null, null, '123456', '13261500434', null, null, 'hahah', null, null, null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '93', null, null, null, null, null, null, null, '123456', '13261500434', null, null, 'gagag', null, null, null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '94', null, null, null, null, null, null, null, '123456', '13261500434', null, null, 'hhhhh', null, null, null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '95', null, null, null, null, null, null, null, '123456', '13261500434', null, null, 'wwww', null, null, null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO `t_user` VALUES (null, '96', null, null, null, null, null, null, null, '123456', '13261500434', null, null, 'fffff', null, null, null, null, null, null, null, null, null, null, null, '0', null);

-- ----------------------------
-- Table structure for `t_usercaller`
-- ----------------------------
DROP TABLE IF EXISTS `t_usercaller`;
CREATE TABLE `t_usercaller` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL COMMENT '访客userId',
  `crTime` datetime DEFAULT NULL,
  `callerUserId` bigint(20) DEFAULT NULL COMMENT '被访客userId',
  PRIMARY KEY (`id`),
  KEY `FK_t_anjilang_usercaller` (`userId`),
  CONSTRAINT `FK_t_anjilang_usercaller` FOREIGN KEY (`userId`) REFERENCES `t_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=429 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_usercaller
-- ----------------------------
INSERT INTO `t_usercaller` VALUES ('2', null, '2015-01-18 21:10:36', '3');
INSERT INTO `t_usercaller` VALUES ('3', null, '2015-01-18 21:21:28', '3');
INSERT INTO `t_usercaller` VALUES ('4', null, '2015-01-18 21:21:30', '3');
INSERT INTO `t_usercaller` VALUES ('5', null, '2015-01-18 21:22:40', '3');
INSERT INTO `t_usercaller` VALUES ('6', null, '2015-01-18 21:24:31', '3');
INSERT INTO `t_usercaller` VALUES ('7', null, '2015-01-18 21:25:43', '3');
INSERT INTO `t_usercaller` VALUES ('8', null, '2015-01-18 21:26:11', '3');
INSERT INTO `t_usercaller` VALUES ('9', null, '2015-01-18 21:30:44', '3');
INSERT INTO `t_usercaller` VALUES ('10', null, '2015-01-18 21:51:30', '3');
INSERT INTO `t_usercaller` VALUES ('11', null, '2015-01-18 22:02:53', '3');
INSERT INTO `t_usercaller` VALUES ('12', null, '2015-01-18 22:07:33', '3');
INSERT INTO `t_usercaller` VALUES ('13', null, '2015-01-18 22:08:07', '3');
INSERT INTO `t_usercaller` VALUES ('14', null, '2015-01-18 22:08:14', '3');
INSERT INTO `t_usercaller` VALUES ('15', '10', '2015-01-19 09:30:29', '9');
INSERT INTO `t_usercaller` VALUES ('16', '32', '2015-01-19 14:50:59', '9');
INSERT INTO `t_usercaller` VALUES ('17', '32', '2015-01-19 14:51:09', '6');
INSERT INTO `t_usercaller` VALUES ('18', '32', '2015-01-19 14:51:15', '4');
INSERT INTO `t_usercaller` VALUES ('19', null, '2015-01-19 20:24:55', '3');
INSERT INTO `t_usercaller` VALUES ('20', null, '2015-01-19 20:27:03', '3');
INSERT INTO `t_usercaller` VALUES ('21', null, '2015-01-19 20:27:24', '3');
INSERT INTO `t_usercaller` VALUES ('22', null, '2015-01-19 20:28:22', '3');
INSERT INTO `t_usercaller` VALUES ('23', null, '2015-01-19 20:34:14', '3');
INSERT INTO `t_usercaller` VALUES ('24', null, '2015-01-19 20:47:45', '3');
INSERT INTO `t_usercaller` VALUES ('25', null, '2015-01-19 20:51:05', '3');
INSERT INTO `t_usercaller` VALUES ('26', null, '2015-01-19 20:52:30', '3');
INSERT INTO `t_usercaller` VALUES ('27', null, '2015-01-19 20:53:06', '3');
INSERT INTO `t_usercaller` VALUES ('28', null, '2015-01-19 20:53:08', '3');
INSERT INTO `t_usercaller` VALUES ('29', null, '2015-01-19 20:54:02', '3');
INSERT INTO `t_usercaller` VALUES ('30', null, '2015-01-19 20:56:17', '3');
INSERT INTO `t_usercaller` VALUES ('31', null, '2015-01-19 20:56:29', '3');
INSERT INTO `t_usercaller` VALUES ('32', null, '2015-01-19 20:56:32', '3');
INSERT INTO `t_usercaller` VALUES ('33', null, '2015-01-19 20:57:29', '3');
INSERT INTO `t_usercaller` VALUES ('34', null, '2015-01-19 20:57:38', '3');
INSERT INTO `t_usercaller` VALUES ('35', null, '2015-01-19 20:57:57', '3');
INSERT INTO `t_usercaller` VALUES ('36', null, '2015-01-19 20:58:47', '3');
INSERT INTO `t_usercaller` VALUES ('37', null, '2015-01-19 20:59:33', '3');
INSERT INTO `t_usercaller` VALUES ('38', null, '2015-01-19 21:05:46', '3');
INSERT INTO `t_usercaller` VALUES ('39', null, '2015-01-19 21:06:33', '3');
INSERT INTO `t_usercaller` VALUES ('40', null, '2015-01-19 21:07:01', '3');
INSERT INTO `t_usercaller` VALUES ('41', null, '2015-01-19 21:08:21', '3');
INSERT INTO `t_usercaller` VALUES ('42', null, '2015-01-19 21:14:14', '3');
INSERT INTO `t_usercaller` VALUES ('43', null, '2015-01-19 21:14:16', '3');
INSERT INTO `t_usercaller` VALUES ('44', null, '2015-01-19 21:14:58', '3');
INSERT INTO `t_usercaller` VALUES ('45', null, '2015-01-19 21:15:07', '3');
INSERT INTO `t_usercaller` VALUES ('46', null, '2015-01-19 21:15:11', '3');
INSERT INTO `t_usercaller` VALUES ('47', null, '2015-01-19 21:15:34', '3');
INSERT INTO `t_usercaller` VALUES ('48', null, '2015-01-19 21:16:01', '3');
INSERT INTO `t_usercaller` VALUES ('49', null, '2015-01-19 21:22:35', '3');
INSERT INTO `t_usercaller` VALUES ('50', null, '2015-01-19 21:23:20', '3');
INSERT INTO `t_usercaller` VALUES ('51', null, '2015-01-19 21:27:46', '3');
INSERT INTO `t_usercaller` VALUES ('52', null, '2015-01-19 21:31:54', '3');
INSERT INTO `t_usercaller` VALUES ('53', null, '2015-01-19 21:35:23', '3');
INSERT INTO `t_usercaller` VALUES ('54', null, '2015-01-19 21:35:43', '3');
INSERT INTO `t_usercaller` VALUES ('55', null, '2015-01-19 21:37:20', '3');
INSERT INTO `t_usercaller` VALUES ('56', null, '2015-01-19 21:52:04', '3');
INSERT INTO `t_usercaller` VALUES ('57', null, '2015-01-19 22:09:41', '3');
INSERT INTO `t_usercaller` VALUES ('58', null, '2015-01-19 22:10:08', '3');
INSERT INTO `t_usercaller` VALUES ('59', null, '2015-01-19 22:11:02', '3');
INSERT INTO `t_usercaller` VALUES ('60', null, '2015-01-19 22:11:37', '3');
INSERT INTO `t_usercaller` VALUES ('61', null, '2015-01-19 22:13:58', '3');
INSERT INTO `t_usercaller` VALUES ('62', null, '2015-01-19 22:16:26', '3');
INSERT INTO `t_usercaller` VALUES ('63', null, '2015-01-19 22:16:59', '3');
INSERT INTO `t_usercaller` VALUES ('64', null, '2015-01-19 22:17:34', '3');
INSERT INTO `t_usercaller` VALUES ('65', null, '2015-01-19 22:20:34', '3');
INSERT INTO `t_usercaller` VALUES ('66', null, '2015-01-19 22:24:20', '3');
INSERT INTO `t_usercaller` VALUES ('67', null, '2015-01-19 22:35:41', '3');
INSERT INTO `t_usercaller` VALUES ('68', null, '2015-01-19 22:37:00', '3');
INSERT INTO `t_usercaller` VALUES ('69', null, '2015-01-19 22:38:57', '3');
INSERT INTO `t_usercaller` VALUES ('70', null, '2015-01-19 22:41:16', '3');
INSERT INTO `t_usercaller` VALUES ('73', null, '2015-01-19 23:01:51', '3');
INSERT INTO `t_usercaller` VALUES ('75', null, '2015-01-19 23:02:57', '3');
INSERT INTO `t_usercaller` VALUES ('79', null, '2015-01-19 23:04:12', '9');
INSERT INTO `t_usercaller` VALUES ('83', '3', '2015-01-19 23:06:00', '9');
INSERT INTO `t_usercaller` VALUES ('84', null, '2015-01-19 23:12:35', '9');
INSERT INTO `t_usercaller` VALUES ('85', null, '2015-01-19 23:15:11', '9');
INSERT INTO `t_usercaller` VALUES ('86', null, '2015-01-19 23:20:12', '9');
INSERT INTO `t_usercaller` VALUES ('87', null, '2015-01-19 23:20:50', '9');
INSERT INTO `t_usercaller` VALUES ('88', null, '2015-01-19 23:25:35', '9');
INSERT INTO `t_usercaller` VALUES ('89', null, '2015-01-19 23:29:53', '9');
INSERT INTO `t_usercaller` VALUES ('90', null, '2015-01-19 23:31:35', '9');
INSERT INTO `t_usercaller` VALUES ('91', null, '2015-01-19 23:33:18', '9');
INSERT INTO `t_usercaller` VALUES ('92', null, '2015-01-19 23:33:48', '9');
INSERT INTO `t_usercaller` VALUES ('93', null, '2015-01-19 23:34:42', '9');
INSERT INTO `t_usercaller` VALUES ('94', null, '2015-01-20 00:44:34', '9');
INSERT INTO `t_usercaller` VALUES ('95', null, '2015-01-20 13:44:04', '9');
INSERT INTO `t_usercaller` VALUES ('96', null, '2015-01-20 13:44:23', '9');
INSERT INTO `t_usercaller` VALUES ('97', null, '2015-01-20 13:44:37', '9');
INSERT INTO `t_usercaller` VALUES ('98', '8', '2015-01-20 17:15:16', '37');
INSERT INTO `t_usercaller` VALUES ('99', null, '2015-01-20 17:20:02', '6');
INSERT INTO `t_usercaller` VALUES ('100', null, '2015-01-20 17:25:01', '3');
INSERT INTO `t_usercaller` VALUES ('101', null, '2015-01-20 17:30:11', '37');
INSERT INTO `t_usercaller` VALUES ('102', null, '2015-01-20 17:30:15', '4');
INSERT INTO `t_usercaller` VALUES ('103', null, '2015-01-20 21:41:51', '37');
INSERT INTO `t_usercaller` VALUES ('104', null, '2015-01-20 21:43:14', '36');
INSERT INTO `t_usercaller` VALUES ('105', null, '2015-01-20 23:20:43', '37');
INSERT INTO `t_usercaller` VALUES ('106', null, '2015-01-20 23:33:09', '37');
INSERT INTO `t_usercaller` VALUES ('107', '8', '2015-01-21 00:46:32', '35');
INSERT INTO `t_usercaller` VALUES ('108', null, '2015-01-21 09:05:02', '36');
INSERT INTO `t_usercaller` VALUES ('109', null, '2015-01-21 10:25:30', '38');
INSERT INTO `t_usercaller` VALUES ('110', '16', '2015-01-21 14:03:26', '38');
INSERT INTO `t_usercaller` VALUES ('111', '16', '2015-01-21 14:03:45', '9');
INSERT INTO `t_usercaller` VALUES ('112', '16', '2015-01-21 14:04:00', '36');
INSERT INTO `t_usercaller` VALUES ('113', '16', '2015-01-21 14:04:11', '38');
INSERT INTO `t_usercaller` VALUES ('114', null, '2015-01-21 15:12:00', '9');
INSERT INTO `t_usercaller` VALUES ('115', null, '2015-01-21 15:24:09', '36');
INSERT INTO `t_usercaller` VALUES ('116', null, '2015-01-21 15:25:10', '38');
INSERT INTO `t_usercaller` VALUES ('117', null, '2015-01-21 15:25:54', '36');
INSERT INTO `t_usercaller` VALUES ('118', null, '2015-01-21 15:26:21', '9');
INSERT INTO `t_usercaller` VALUES ('119', null, '2015-01-21 15:30:42', '9');
INSERT INTO `t_usercaller` VALUES ('120', null, '2015-01-21 15:30:44', '6');
INSERT INTO `t_usercaller` VALUES ('121', null, '2015-01-21 15:30:46', '4');
INSERT INTO `t_usercaller` VALUES ('122', null, '2015-01-21 15:30:47', '5');
INSERT INTO `t_usercaller` VALUES ('123', null, '2015-01-21 15:30:48', '38');
INSERT INTO `t_usercaller` VALUES ('124', null, '2015-01-21 17:29:23', '9');
INSERT INTO `t_usercaller` VALUES ('125', null, '2015-01-21 17:53:49', '36');
INSERT INTO `t_usercaller` VALUES ('126', null, '2015-01-21 17:54:09', '6');
INSERT INTO `t_usercaller` VALUES ('127', null, '2015-01-21 18:34:08', '35');
INSERT INTO `t_usercaller` VALUES ('128', null, '2015-01-21 20:28:56', '3');
INSERT INTO `t_usercaller` VALUES ('129', null, '2015-01-21 20:32:32', '9');
INSERT INTO `t_usercaller` VALUES ('130', null, '2015-01-21 20:41:00', '9');
INSERT INTO `t_usercaller` VALUES ('131', null, '2015-01-21 20:42:22', '9');
INSERT INTO `t_usercaller` VALUES ('132', null, '2015-01-21 20:44:57', '9');
INSERT INTO `t_usercaller` VALUES ('133', null, '2015-01-21 20:46:09', '9');
INSERT INTO `t_usercaller` VALUES ('134', null, '2015-01-21 20:46:34', '9');
INSERT INTO `t_usercaller` VALUES ('135', null, '2015-01-21 20:47:32', '9');
INSERT INTO `t_usercaller` VALUES ('136', null, '2015-01-21 20:48:47', '9');
INSERT INTO `t_usercaller` VALUES ('137', null, '2015-01-21 20:50:54', '9');
INSERT INTO `t_usercaller` VALUES ('138', null, '2015-01-21 20:51:58', '9');
INSERT INTO `t_usercaller` VALUES ('139', null, '2015-01-21 20:53:53', '9');
INSERT INTO `t_usercaller` VALUES ('140', null, '2015-01-21 20:54:31', '9');
INSERT INTO `t_usercaller` VALUES ('141', null, '2015-01-21 20:55:13', '9');
INSERT INTO `t_usercaller` VALUES ('142', null, '2015-01-21 20:55:50', '9');
INSERT INTO `t_usercaller` VALUES ('143', null, '2015-01-21 20:56:50', '9');
INSERT INTO `t_usercaller` VALUES ('144', null, '2015-01-21 20:57:24', '9');
INSERT INTO `t_usercaller` VALUES ('145', null, '2015-01-21 20:58:03', '9');
INSERT INTO `t_usercaller` VALUES ('146', null, '2015-01-21 21:00:06', '9');
INSERT INTO `t_usercaller` VALUES ('147', null, '2015-01-21 21:00:44', '9');
INSERT INTO `t_usercaller` VALUES ('148', null, '2015-01-21 21:01:20', '9');
INSERT INTO `t_usercaller` VALUES ('149', null, '2015-01-21 21:03:05', '9');
INSERT INTO `t_usercaller` VALUES ('150', null, '2015-01-21 21:03:45', '9');
INSERT INTO `t_usercaller` VALUES ('151', null, '2015-01-21 21:08:07', '3');
INSERT INTO `t_usercaller` VALUES ('152', null, '2015-01-21 21:11:22', '9');
INSERT INTO `t_usercaller` VALUES ('153', null, '2015-01-21 21:12:19', '9');
INSERT INTO `t_usercaller` VALUES ('154', null, '2015-01-21 21:13:14', '9');
INSERT INTO `t_usercaller` VALUES ('155', null, '2015-01-21 21:13:20', '3');
INSERT INTO `t_usercaller` VALUES ('156', null, '2015-01-21 21:13:34', '3');
INSERT INTO `t_usercaller` VALUES ('157', null, '2015-01-21 21:14:01', '3');
INSERT INTO `t_usercaller` VALUES ('158', null, '2015-01-21 21:14:30', '9');
INSERT INTO `t_usercaller` VALUES ('159', null, '2015-01-21 21:14:58', '3');
INSERT INTO `t_usercaller` VALUES ('160', null, '2015-01-21 21:17:28', '3');
INSERT INTO `t_usercaller` VALUES ('161', null, '2015-01-21 21:18:46', '3');
INSERT INTO `t_usercaller` VALUES ('162', null, '2015-01-21 21:29:07', '9');
INSERT INTO `t_usercaller` VALUES ('163', null, '2015-01-21 21:29:42', '9');
INSERT INTO `t_usercaller` VALUES ('164', null, '2015-01-21 21:39:22', '4');
INSERT INTO `t_usercaller` VALUES ('165', null, '2015-01-21 21:47:39', '3');
INSERT INTO `t_usercaller` VALUES ('166', null, '2015-01-21 21:48:19', '9');
INSERT INTO `t_usercaller` VALUES ('167', null, '2015-01-21 21:49:34', '9');
INSERT INTO `t_usercaller` VALUES ('168', null, '2015-01-21 21:53:07', '9');
INSERT INTO `t_usercaller` VALUES ('169', null, '2015-01-21 21:56:18', '3');
INSERT INTO `t_usercaller` VALUES ('170', null, '2015-01-21 22:01:29', '9');
INSERT INTO `t_usercaller` VALUES ('171', null, '2015-01-21 22:01:47', '3');
INSERT INTO `t_usercaller` VALUES ('172', null, '2015-01-21 22:04:45', '3');
INSERT INTO `t_usercaller` VALUES ('173', null, '2015-01-21 22:08:14', '3');
INSERT INTO `t_usercaller` VALUES ('174', null, '2015-01-21 22:09:12', '3');
INSERT INTO `t_usercaller` VALUES ('175', null, '2015-01-21 22:09:34', '3');
INSERT INTO `t_usercaller` VALUES ('176', null, '2015-01-21 22:12:42', '3');
INSERT INTO `t_usercaller` VALUES ('177', null, '2015-01-21 22:13:29', '3');
INSERT INTO `t_usercaller` VALUES ('178', null, '2015-01-21 22:15:59', '9');
INSERT INTO `t_usercaller` VALUES ('179', null, '2015-01-21 22:11:12', '6');
INSERT INTO `t_usercaller` VALUES ('180', null, '2015-01-21 22:18:13', '3');
INSERT INTO `t_usercaller` VALUES ('181', null, '2015-01-21 22:22:39', '3');
INSERT INTO `t_usercaller` VALUES ('182', null, '2015-01-21 22:25:04', '3');
INSERT INTO `t_usercaller` VALUES ('183', null, '2015-01-21 22:30:36', '3');
INSERT INTO `t_usercaller` VALUES ('184', null, '2015-01-21 22:31:16', '3');
INSERT INTO `t_usercaller` VALUES ('185', null, '2015-01-21 22:32:16', '3');
INSERT INTO `t_usercaller` VALUES ('186', null, '2015-01-21 22:32:24', '9');
INSERT INTO `t_usercaller` VALUES ('187', null, '2015-01-21 22:32:49', '3');
INSERT INTO `t_usercaller` VALUES ('188', null, '2015-01-21 22:34:48', '9');
INSERT INTO `t_usercaller` VALUES ('189', null, '2015-01-21 22:35:25', '3');
INSERT INTO `t_usercaller` VALUES ('190', null, '2015-01-21 22:35:34', '9');
INSERT INTO `t_usercaller` VALUES ('191', null, '2015-01-21 22:37:04', '9');
INSERT INTO `t_usercaller` VALUES ('192', null, '2015-01-21 22:40:59', '9');
INSERT INTO `t_usercaller` VALUES ('193', null, '2015-01-21 22:44:33', '9');
INSERT INTO `t_usercaller` VALUES ('194', null, '2015-01-21 22:45:23', '9');
INSERT INTO `t_usercaller` VALUES ('195', null, '2015-01-21 22:45:51', '9');
INSERT INTO `t_usercaller` VALUES ('196', null, '2015-01-21 22:45:58', '9');
INSERT INTO `t_usercaller` VALUES ('197', null, '2015-01-21 22:47:11', '9');
INSERT INTO `t_usercaller` VALUES ('198', null, '2015-01-21 22:48:28', '9');
INSERT INTO `t_usercaller` VALUES ('199', '3', '2015-01-21 22:49:38', '9');
INSERT INTO `t_usercaller` VALUES ('200', '3', '2015-01-21 22:53:17', '9');
INSERT INTO `t_usercaller` VALUES ('201', '8', '2015-01-21 22:48:24', '9');
INSERT INTO `t_usercaller` VALUES ('202', null, '2015-01-21 22:54:30', '9');
INSERT INTO `t_usercaller` VALUES ('203', null, '2015-01-21 22:59:14', '9');
INSERT INTO `t_usercaller` VALUES ('204', null, '2015-01-21 22:59:26', '9');
INSERT INTO `t_usercaller` VALUES ('205', null, '2015-01-21 23:07:05', '38');
INSERT INTO `t_usercaller` VALUES ('206', null, '2015-01-21 23:19:54', '36');
INSERT INTO `t_usercaller` VALUES ('207', null, '2015-01-21 23:21:14', '9');
INSERT INTO `t_usercaller` VALUES ('208', null, '2015-01-21 23:22:05', '9');
INSERT INTO `t_usercaller` VALUES ('209', null, '2015-01-22 00:41:23', '9');
INSERT INTO `t_usercaller` VALUES ('210', null, '2015-01-22 04:49:25', '35');
INSERT INTO `t_usercaller` VALUES ('211', null, '2015-01-22 04:49:28', '38');
INSERT INTO `t_usercaller` VALUES ('212', null, '2015-01-22 04:49:49', '5');
INSERT INTO `t_usercaller` VALUES ('213', null, '2015-01-22 04:49:53', '36');
INSERT INTO `t_usercaller` VALUES ('214', null, '2015-01-22 04:49:59', '37');
INSERT INTO `t_usercaller` VALUES ('215', null, '2015-01-22 08:17:42', '5');
INSERT INTO `t_usercaller` VALUES ('216', null, '2015-01-22 09:18:03', '9');
INSERT INTO `t_usercaller` VALUES ('217', null, '2015-01-22 09:23:14', '9');
INSERT INTO `t_usercaller` VALUES ('218', '8', '2015-01-22 10:09:27', '38');
INSERT INTO `t_usercaller` VALUES ('219', '8', '2015-01-22 10:35:11', '38');
INSERT INTO `t_usercaller` VALUES ('220', '8', '2015-01-22 10:35:21', '9');
INSERT INTO `t_usercaller` VALUES ('221', '8', '2015-01-22 10:38:43', '9');
INSERT INTO `t_usercaller` VALUES ('222', null, '2015-01-22 15:24:22', '36');
INSERT INTO `t_usercaller` VALUES ('223', null, '2015-01-22 15:42:52', '38');
INSERT INTO `t_usercaller` VALUES ('224', null, '2015-01-22 16:19:55', '36');
INSERT INTO `t_usercaller` VALUES ('225', null, '2015-01-22 21:13:28', '35');
INSERT INTO `t_usercaller` VALUES ('226', null, '2015-01-22 21:33:08', '37');
INSERT INTO `t_usercaller` VALUES ('227', null, '2015-01-23 03:13:21', '36');
INSERT INTO `t_usercaller` VALUES ('228', null, '2015-01-23 09:16:53', '38');
INSERT INTO `t_usercaller` VALUES ('229', null, '2015-01-23 10:07:00', '36');
INSERT INTO `t_usercaller` VALUES ('230', '7', '2015-01-23 15:18:23', '37');
INSERT INTO `t_usercaller` VALUES ('231', '7', '2015-01-23 15:20:23', '37');
INSERT INTO `t_usercaller` VALUES ('232', null, '2015-01-23 19:19:56', '37');
INSERT INTO `t_usercaller` VALUES ('233', null, '2015-01-23 21:35:11', '9');
INSERT INTO `t_usercaller` VALUES ('234', null, '2015-01-23 22:19:57', '38');
INSERT INTO `t_usercaller` VALUES ('235', null, '2015-01-24 02:13:05', '6');
INSERT INTO `t_usercaller` VALUES ('236', null, '2015-01-24 13:38:24', '36');
INSERT INTO `t_usercaller` VALUES ('237', null, '2015-01-25 00:51:06', '9');
INSERT INTO `t_usercaller` VALUES ('238', null, '2015-01-25 01:42:24', '6');
INSERT INTO `t_usercaller` VALUES ('239', null, '2015-01-26 16:42:26', '36');
INSERT INTO `t_usercaller` VALUES ('240', null, '2015-01-26 17:09:16', '38');
INSERT INTO `t_usercaller` VALUES ('241', null, '2015-01-26 17:09:43', '38');
INSERT INTO `t_usercaller` VALUES ('242', null, '2015-01-26 17:43:36', '9');
INSERT INTO `t_usercaller` VALUES ('243', null, '2015-01-26 19:18:03', '6');
INSERT INTO `t_usercaller` VALUES ('244', null, '2015-01-28 05:04:11', '38');
INSERT INTO `t_usercaller` VALUES ('245', null, '2015-01-28 20:48:07', '9');
INSERT INTO `t_usercaller` VALUES ('246', null, '2015-01-28 20:48:38', '9');
INSERT INTO `t_usercaller` VALUES ('247', null, '2015-01-28 20:49:21', '9');
INSERT INTO `t_usercaller` VALUES ('248', '21', '2015-01-28 20:51:10', '9');
INSERT INTO `t_usercaller` VALUES ('256', null, '2015-01-28 21:36:08', '6');
INSERT INTO `t_usercaller` VALUES ('257', null, '2015-01-28 21:36:17', '36');
INSERT INTO `t_usercaller` VALUES ('258', null, '2015-01-28 21:43:43', '21');
INSERT INTO `t_usercaller` VALUES ('259', null, '2015-01-28 21:46:07', '21');
INSERT INTO `t_usercaller` VALUES ('260', null, '2015-01-28 23:40:03', '38');
INSERT INTO `t_usercaller` VALUES ('261', null, '2015-01-28 23:40:18', '38');
INSERT INTO `t_usercaller` VALUES ('262', null, '2015-01-29 12:00:40', '9');
INSERT INTO `t_usercaller` VALUES ('263', null, '2015-01-29 12:01:02', '36');
INSERT INTO `t_usercaller` VALUES ('264', null, '2015-01-29 12:02:21', '38');
INSERT INTO `t_usercaller` VALUES ('265', '8', '2015-01-29 16:43:09', '9');
INSERT INTO `t_usercaller` VALUES ('266', '8', '2015-01-29 16:45:51', '6');
INSERT INTO `t_usercaller` VALUES ('267', null, '2015-01-29 17:36:27', '52');
INSERT INTO `t_usercaller` VALUES ('268', null, '2015-01-29 17:36:49', '38');
INSERT INTO `t_usercaller` VALUES ('269', null, '2015-01-29 17:49:18', '36');
INSERT INTO `t_usercaller` VALUES ('270', '16', '2015-01-29 17:55:55', '54');
INSERT INTO `t_usercaller` VALUES ('271', '16', '2015-01-29 18:01:21', '54');
INSERT INTO `t_usercaller` VALUES ('272', null, '2015-01-29 18:10:01', '54');
INSERT INTO `t_usercaller` VALUES ('273', null, '2015-01-29 18:13:13', '53');
INSERT INTO `t_usercaller` VALUES ('274', null, '2015-01-29 18:13:22', '52');
INSERT INTO `t_usercaller` VALUES ('275', null, '2015-01-29 18:13:31', '54');
INSERT INTO `t_usercaller` VALUES ('276', null, '2015-01-29 18:58:57', '36');
INSERT INTO `t_usercaller` VALUES ('277', null, '2015-01-29 23:44:35', '52');
INSERT INTO `t_usercaller` VALUES ('278', null, '2015-01-30 04:50:46', '53');
INSERT INTO `t_usercaller` VALUES ('279', null, '2015-01-30 06:19:36', '54');
INSERT INTO `t_usercaller` VALUES ('280', null, '2015-01-30 06:20:22', '38');
INSERT INTO `t_usercaller` VALUES ('281', null, '2015-01-30 06:22:45', '9');
INSERT INTO `t_usercaller` VALUES ('282', null, '2015-01-30 06:25:26', '53');
INSERT INTO `t_usercaller` VALUES ('283', '54', '2015-01-30 06:30:23', '9');
INSERT INTO `t_usercaller` VALUES ('284', '54', '2015-01-30 06:30:26', '9');
INSERT INTO `t_usercaller` VALUES ('285', null, '2015-01-30 06:40:31', '54');
INSERT INTO `t_usercaller` VALUES ('286', null, '2015-01-30 06:41:26', '52');
INSERT INTO `t_usercaller` VALUES ('287', '54', '2015-01-30 06:42:39', '9');
INSERT INTO `t_usercaller` VALUES ('288', '54', '2015-01-30 06:43:53', '52');
INSERT INTO `t_usercaller` VALUES ('289', '54', '2015-01-30 06:45:36', '9');
INSERT INTO `t_usercaller` VALUES ('290', null, '2015-01-30 08:11:38', '54');
INSERT INTO `t_usercaller` VALUES ('291', null, '2015-01-30 13:18:16', '54');
INSERT INTO `t_usercaller` VALUES ('292', null, '2015-01-30 13:43:48', '36');
INSERT INTO `t_usercaller` VALUES ('293', null, '2015-01-30 23:17:30', '54');
INSERT INTO `t_usercaller` VALUES ('294', null, '2015-01-31 01:28:57', '36');
INSERT INTO `t_usercaller` VALUES ('295', null, '2015-01-31 03:05:24', '54');
INSERT INTO `t_usercaller` VALUES ('296', null, '2015-01-31 05:34:06', '54');
INSERT INTO `t_usercaller` VALUES ('297', null, '2015-01-31 06:04:22', '38');
INSERT INTO `t_usercaller` VALUES ('298', null, '2015-01-31 09:34:58', '54');
INSERT INTO `t_usercaller` VALUES ('299', null, '2015-01-31 12:44:18', '38');
INSERT INTO `t_usercaller` VALUES ('300', null, '2015-01-31 13:39:30', '36');
INSERT INTO `t_usercaller` VALUES ('301', null, '2015-01-31 13:39:39', '6');
INSERT INTO `t_usercaller` VALUES ('302', null, '2015-01-31 14:26:27', '52');
INSERT INTO `t_usercaller` VALUES ('303', null, '2015-01-31 17:09:12', '38');
INSERT INTO `t_usercaller` VALUES ('304', null, '2015-01-31 17:36:05', '54');
INSERT INTO `t_usercaller` VALUES ('305', null, '2015-01-31 18:41:58', '53');
INSERT INTO `t_usercaller` VALUES ('306', null, '2015-01-31 23:03:42', '38');
INSERT INTO `t_usercaller` VALUES ('307', null, '2015-02-01 01:34:15', '36');
INSERT INTO `t_usercaller` VALUES ('308', null, '2015-02-01 13:37:23', '36');
INSERT INTO `t_usercaller` VALUES ('309', null, '2015-02-01 15:51:43', '9');
INSERT INTO `t_usercaller` VALUES ('310', null, '2015-02-01 16:21:09', '54');
INSERT INTO `t_usercaller` VALUES ('311', null, '2015-02-01 16:22:07', '54');
INSERT INTO `t_usercaller` VALUES ('312', null, '2015-02-02 09:51:00', '9');
INSERT INTO `t_usercaller` VALUES ('313', '8', '2015-02-02 10:41:40', '54');
INSERT INTO `t_usercaller` VALUES ('314', null, '2015-02-02 10:48:09', '36');
INSERT INTO `t_usercaller` VALUES ('315', null, '2015-02-02 13:24:57', '54');
INSERT INTO `t_usercaller` VALUES ('316', null, '2015-02-02 13:25:39', '54');
INSERT INTO `t_usercaller` VALUES ('317', null, '2015-02-02 13:27:34', '36');
INSERT INTO `t_usercaller` VALUES ('318', '53', '2015-02-02 14:23:28', '36');
INSERT INTO `t_usercaller` VALUES ('319', '53', '2015-02-02 14:24:21', '36');
INSERT INTO `t_usercaller` VALUES ('320', '53', '2015-02-02 14:26:32', '54');
INSERT INTO `t_usercaller` VALUES ('321', '53', '2015-02-02 14:26:56', '54');
INSERT INTO `t_usercaller` VALUES ('322', null, '2015-02-03 03:10:25', '36');
INSERT INTO `t_usercaller` VALUES ('323', null, '2015-02-03 18:12:23', '52');
INSERT INTO `t_usercaller` VALUES ('324', null, '2015-02-03 19:28:51', '53');
INSERT INTO `t_usercaller` VALUES ('325', null, '2015-02-03 19:29:05', '54');
INSERT INTO `t_usercaller` VALUES ('326', null, '2015-02-03 20:30:26', '3');
INSERT INTO `t_usercaller` VALUES ('327', '21', '2015-02-03 20:33:36', '3');
INSERT INTO `t_usercaller` VALUES ('328', null, '2015-02-03 20:37:58', '21');
INSERT INTO `t_usercaller` VALUES ('329', null, '2015-02-03 20:35:02', '36');
INSERT INTO `t_usercaller` VALUES ('330', null, '2015-02-03 20:35:02', '52');
INSERT INTO `t_usercaller` VALUES ('331', null, '2015-02-03 20:35:03', '38');
INSERT INTO `t_usercaller` VALUES ('332', null, '2015-02-04 09:29:42', '36');
INSERT INTO `t_usercaller` VALUES ('333', null, '2015-02-04 10:08:00', '54');
INSERT INTO `t_usercaller` VALUES ('334', null, '2015-02-04 10:08:03', '54');
INSERT INTO `t_usercaller` VALUES ('335', null, '2015-02-04 16:54:33', '53');
INSERT INTO `t_usercaller` VALUES ('336', null, '2015-02-04 16:57:59', '54');
INSERT INTO `t_usercaller` VALUES ('337', null, '2015-02-04 17:09:04', '54');
INSERT INTO `t_usercaller` VALUES ('338', null, '2015-02-04 19:28:23', '38');
INSERT INTO `t_usercaller` VALUES ('339', '7', '2015-02-05 16:03:52', '54');
INSERT INTO `t_usercaller` VALUES ('340', '7', '2015-02-05 16:06:25', '36');
INSERT INTO `t_usercaller` VALUES ('341', '7', '2015-02-05 16:06:46', '36');
INSERT INTO `t_usercaller` VALUES ('342', '7', '2015-02-05 16:07:40', '36');
INSERT INTO `t_usercaller` VALUES ('345', null, '2015-02-06 14:13:47', '54');
INSERT INTO `t_usercaller` VALUES ('346', null, '2015-02-06 20:27:08', '54');
INSERT INTO `t_usercaller` VALUES ('347', '8', '2015-02-06 23:12:12', '54');
INSERT INTO `t_usercaller` VALUES ('348', null, '2015-02-06 23:48:35', '52');
INSERT INTO `t_usercaller` VALUES ('349', null, '2015-02-07 09:57:54', '53');
INSERT INTO `t_usercaller` VALUES ('350', '8', '2015-02-07 22:24:21', '54');
INSERT INTO `t_usercaller` VALUES ('351', '8', '2015-02-07 22:24:26', '54');
INSERT INTO `t_usercaller` VALUES ('352', null, '2015-02-08 01:39:25', '53');
INSERT INTO `t_usercaller` VALUES ('353', null, '2015-02-08 16:20:39', '54');
INSERT INTO `t_usercaller` VALUES ('354', null, '2015-02-08 19:43:31', '58');
INSERT INTO `t_usercaller` VALUES ('355', null, '2015-02-08 21:53:54', '65');
INSERT INTO `t_usercaller` VALUES ('356', null, '2015-02-08 21:53:55', '62');
INSERT INTO `t_usercaller` VALUES ('357', null, '2015-02-08 21:53:56', '63');
INSERT INTO `t_usercaller` VALUES ('358', null, '2015-02-08 21:53:57', '64');
INSERT INTO `t_usercaller` VALUES ('359', null, '2015-02-08 21:54:03', '61');
INSERT INTO `t_usercaller` VALUES ('360', null, '2015-02-08 22:09:58', '58');
INSERT INTO `t_usercaller` VALUES ('361', '18', '2015-02-09 09:22:53', '58');
INSERT INTO `t_usercaller` VALUES ('362', null, '2015-02-09 15:03:35', '59');
INSERT INTO `t_usercaller` VALUES ('363', null, '2015-02-09 15:48:44', '52');
INSERT INTO `t_usercaller` VALUES ('364', null, '2015-02-09 18:53:19', '54');
INSERT INTO `t_usercaller` VALUES ('365', null, '2015-02-10 00:32:11', '53');
INSERT INTO `t_usercaller` VALUES ('366', null, '2015-02-10 22:57:57', '65');
INSERT INTO `t_usercaller` VALUES ('367', null, '2015-02-10 22:58:13', '52');
INSERT INTO `t_usercaller` VALUES ('368', null, '2015-02-10 22:58:21', '58');
INSERT INTO `t_usercaller` VALUES ('369', null, '2015-02-11 02:12:08', '59');
INSERT INTO `t_usercaller` VALUES ('370', null, '2015-02-11 10:27:25', '60');
INSERT INTO `t_usercaller` VALUES ('371', null, '2015-02-11 10:50:01', '65');
INSERT INTO `t_usercaller` VALUES ('372', null, '2015-02-12 07:05:22', '38');
INSERT INTO `t_usercaller` VALUES ('373', '44', '2015-02-13 17:10:33', '65');
INSERT INTO `t_usercaller` VALUES ('374', '44', '2015-02-13 17:10:52', '65');
INSERT INTO `t_usercaller` VALUES ('375', '23', '2015-02-13 17:24:00', '64');
INSERT INTO `t_usercaller` VALUES ('376', null, '2015-02-14 08:16:54', '53');
INSERT INTO `t_usercaller` VALUES ('377', null, '2015-02-14 23:51:03', '61');
INSERT INTO `t_usercaller` VALUES ('378', null, '2015-02-14 23:51:12', '58');
INSERT INTO `t_usercaller` VALUES ('379', null, '2015-02-14 23:51:27', '54');
INSERT INTO `t_usercaller` VALUES ('380', null, '2015-02-14 23:51:30', '53');
INSERT INTO `t_usercaller` VALUES ('381', null, '2015-02-14 23:51:35', '52');
INSERT INTO `t_usercaller` VALUES ('382', null, '2015-02-14 23:51:38', '38');
INSERT INTO `t_usercaller` VALUES ('383', null, '2015-02-14 23:51:41', '36');
INSERT INTO `t_usercaller` VALUES ('384', null, '2015-02-14 23:51:47', '65');
INSERT INTO `t_usercaller` VALUES ('385', null, '2015-02-14 23:55:02', '65');
INSERT INTO `t_usercaller` VALUES ('386', null, '2015-02-14 23:55:12', '65');
INSERT INTO `t_usercaller` VALUES ('387', null, '2015-02-16 02:00:30', '36');
INSERT INTO `t_usercaller` VALUES ('388', null, '2015-02-16 06:56:32', '64');
INSERT INTO `t_usercaller` VALUES ('389', null, '2015-02-16 10:56:16', '65');
INSERT INTO `t_usercaller` VALUES ('390', null, '2015-02-18 00:48:23', '54');
INSERT INTO `t_usercaller` VALUES ('391', null, '2015-02-18 02:49:27', '52');
INSERT INTO `t_usercaller` VALUES ('392', null, '2015-02-20 08:47:18', '60');
INSERT INTO `t_usercaller` VALUES ('393', null, '2015-02-20 17:09:55', '52');
INSERT INTO `t_usercaller` VALUES ('394', null, '2015-02-23 06:26:38', '65');
INSERT INTO `t_usercaller` VALUES ('395', null, '2015-02-24 07:28:31', '60');
INSERT INTO `t_usercaller` VALUES ('396', null, '2015-02-25 09:53:48', '61');
INSERT INTO `t_usercaller` VALUES ('397', null, '2015-02-25 11:56:16', '65');
INSERT INTO `t_usercaller` VALUES ('398', null, '2015-02-25 11:56:35', '65');
INSERT INTO `t_usercaller` VALUES ('399', null, '2015-02-25 12:02:34', '65');
INSERT INTO `t_usercaller` VALUES ('400', null, '2015-02-25 15:17:07', '65');
INSERT INTO `t_usercaller` VALUES ('401', null, '2015-02-25 15:17:30', '65');
INSERT INTO `t_usercaller` VALUES ('402', null, '2015-02-25 15:18:15', '65');
INSERT INTO `t_usercaller` VALUES ('403', null, '2015-02-25 15:19:53', '65');
INSERT INTO `t_usercaller` VALUES ('404', null, '2015-02-25 15:20:11', '65');
INSERT INTO `t_usercaller` VALUES ('405', null, '2015-02-25 19:44:47', '3');
INSERT INTO `t_usercaller` VALUES ('406', null, '2015-02-25 19:45:34', '3');
INSERT INTO `t_usercaller` VALUES ('407', null, '2015-02-25 19:46:02', '65');
INSERT INTO `t_usercaller` VALUES ('408', null, '2015-02-25 19:47:08', '65');
INSERT INTO `t_usercaller` VALUES ('409', null, '2015-02-25 19:48:19', '65');
INSERT INTO `t_usercaller` VALUES ('410', null, '2015-02-25 19:48:48', '65');
INSERT INTO `t_usercaller` VALUES ('411', null, '2015-02-25 19:50:22', '65');
INSERT INTO `t_usercaller` VALUES ('412', null, '2015-02-25 19:51:11', '65');
INSERT INTO `t_usercaller` VALUES ('413', null, '2015-02-25 19:52:20', '65');
INSERT INTO `t_usercaller` VALUES ('414', null, '2015-02-25 19:57:53', '65');
INSERT INTO `t_usercaller` VALUES ('415', null, '2015-02-25 20:00:45', '65');
INSERT INTO `t_usercaller` VALUES ('416', null, '2015-02-25 20:08:02', '65');
INSERT INTO `t_usercaller` VALUES ('417', null, '2015-02-26 13:58:08', '65');
INSERT INTO `t_usercaller` VALUES ('418', null, '2015-03-02 04:11:46', '36');
INSERT INTO `t_usercaller` VALUES ('419', null, '2015-03-02 15:01:26', '61');
INSERT INTO `t_usercaller` VALUES ('420', null, '2015-03-03 10:39:49', '65');
INSERT INTO `t_usercaller` VALUES ('421', null, '2015-03-10 10:43:50', '65');
INSERT INTO `t_usercaller` VALUES ('422', null, '2015-03-10 21:38:43', '59');
INSERT INTO `t_usercaller` VALUES ('423', null, '2015-03-10 21:39:02', '65');
INSERT INTO `t_usercaller` VALUES ('424', '10', '2015-03-10 21:39:18', '65');
INSERT INTO `t_usercaller` VALUES ('425', null, '2015-07-29 19:46:40', '63');
INSERT INTO `t_usercaller` VALUES ('426', '7', '2015-07-29 21:53:54', '62');
INSERT INTO `t_usercaller` VALUES ('427', null, '2015-08-07 16:16:29', '64');
INSERT INTO `t_usercaller` VALUES ('428', null, '2015-08-11 16:26:09', '65');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `userName` varchar(255) DEFAULT NULL,
  `header` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `userName` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------

-- ----------------------------
-- Table structure for `website`
-- ----------------------------
DROP TABLE IF EXISTS `website`;
CREATE TABLE `website` (
  `siteId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `status` bit(1) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `remark` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`siteId`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of website
-- ----------------------------
