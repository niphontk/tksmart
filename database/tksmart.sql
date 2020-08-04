/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : tksmart

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2020-08-04 15:45:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ChooseType` text DEFAULT NULL,
  `Name` text DEFAULT NULL,
  `User` text DEFAULT NULL,
  `Password` text DEFAULT NULL,
  `NameShop` text DEFAULT NULL,
  `Address` text DEFAULT NULL,
  `Phone` text DEFAULT NULL,
  `urlPicture` text DEFAULT NULL,
  `Lat` text DEFAULT NULL,
  `Lng` text DEFAULT NULL,
  `Token` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'User', 'นิพนธ์', 'user1', '1234', 'NalinFood', null, null, null, null, null, null);
INSERT INTO `user` VALUES ('5', 'Rider', 'ผู้ส่งอาหาร', 'rider', '1234', null, null, null, null, null, null, null);
INSERT INTO `user` VALUES ('6', 'Shop', 'เจ้าของร้าน', 'shop', '1234', 'NalinShop', '207 หมู่ที่ 8 โรงพยาบาลตระการพืชผล\r\nต.ขุหลุ  อ.ตระการพืชผล\r\nจ.อุบลราชธานี  34130', '0910139660', '/tksmart/Shop/editShop97441.jpg', '15.6090714', '105.0192482', null);
INSERT INTO `user` VALUES ('14', 'Admin', 'Niphon', 'admin', '1234', 'NalinShop', '207 หมู่ที่ 8 โรงพยาบาลตระการพืชผล\r\nต.ขุหลุ  อ.ตระการพืชผล\r\nจ.อุบลราชธานี  34130', '0910139660', '/tksmart/Shop/shop900814.jpg', '15.605501', '105.034139', '');
INSERT INTO `user` VALUES ('15', 'Shop', 'Salisa', 'salisa', '1234', 'Suksoomboon', 'Huana', '0885717810', '/nalinfood/Shop/shop838553.jpg', '15.612296', '105.043702', '');
INSERT INTO `user` VALUES ('16', 'Shop', 'test', 'test', '1234', '$nameShop', '$address', '$phone', '$urlImage', '$lat', '$lng', null);
