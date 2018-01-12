/*
Navicat MySQL Data Transfer

Source Server         : 本地mysql
Source Server Version : 50625
Source Host           : localhost:3306
Source Database       : graph

Target Server Type    : MYSQL
Target Server Version : 50625
File Encoding         : 65001

Date: 2018-01-12 18:42:30
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `dataset`
-- ----------------------------
DROP TABLE IF EXISTS `dataset`;
CREATE TABLE `dataset` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '数据集主键',
  `type` int(1) DEFAULT NULL COMMENT '数据集归属0：tlp，1：lcd',
  `name` varchar(100) DEFAULT NULL COMMENT '数据集名称',
  `train_path` varchar(500) DEFAULT NULL COMMENT '训练集路径',
  `test_path` varchar(500) DEFAULT NULL COMMENT '测试集路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `lcd_category`
-- ----------------------------
DROP TABLE IF EXISTS `lcd_category`;
CREATE TABLE `lcd_category` (
  `id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lcd_category
-- ----------------------------
INSERT INTO lcd_category VALUES ('1', '类别2');
INSERT INTO lcd_category VALUES ('0', '类别1');

-- ----------------------------
-- Table structure for `lcd_link`
-- ----------------------------
DROP TABLE IF EXISTS `lcd_link`;
CREATE TABLE `lcd_link` (
  `source` text,
  `target` text,
  `weight` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `lcd_link_test`
-- ----------------------------
DROP TABLE IF EXISTS `lcd_link_test`;
CREATE TABLE `lcd_link_test` (
  `source` text,
  `target` text,
  `weight` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `lcd_node`
-- ----------------------------
DROP TABLE IF EXISTS `lcd_node`;
CREATE TABLE `lcd_node` (
  `id` bigint(20) NOT NULL,
  `name` text,
  `value` bigint(20) NOT NULL,
  `category` int(11) NOT NULL,
  `symbolSize` double NOT NULL,
  `type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `lcd_node_test`
-- ----------------------------
DROP TABLE IF EXISTS `lcd_node_test`;
CREATE TABLE `lcd_node_test` (
  `id` bigint(20) NOT NULL,
  `name` text,
  `value` bigint(20) NOT NULL,
  `category` int(11) NOT NULL,
  `symbolSize` double NOT NULL,
  `type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `tlp_category`
-- ----------------------------
DROP TABLE IF EXISTS `tlp_category`;
CREATE TABLE `tlp_category` (
  `id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tlp_category
-- ----------------------------
INSERT INTO tlp_category VALUES ('1', '类别1');

-- ----------------------------
-- Table structure for `tlp_link`
-- ----------------------------
DROP TABLE IF EXISTS `tlp_link`;
CREATE TABLE `tlp_link` (
  `source` text,
  `target` text,
  `weight` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `tlp_link_test`
-- ----------------------------
DROP TABLE IF EXISTS `tlp_link_test`;
CREATE TABLE `tlp_link_test` (
  `source` text,
  `target` text,
  `weight` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `tlp_node`
-- ----------------------------
DROP TABLE IF EXISTS `tlp_node`;
CREATE TABLE `tlp_node` (
  `id` bigint(20) NOT NULL,
  `name` text,
  `value` bigint(20) NOT NULL,
  `category` int(11) NOT NULL,
  `symbolSize` double NOT NULL,
  `type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `tlp_node_test`
-- ----------------------------
DROP TABLE IF EXISTS `tlp_node_test`;
CREATE TABLE `tlp_node_test` (
  `id` bigint(20) NOT NULL,
  `name` text,
  `value` bigint(20) NOT NULL,
  `category` int(11) NOT NULL,
  `symbolSize` double NOT NULL,
  `type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;