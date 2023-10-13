/*
 Navicat MySQL Data Transfer

 Source Server         : operation
 Source Server Type    : MySQL
 Source Server Version : 50717 (5.7.17)
 Source Host           : 192.168.0.164:3306
 Source Schema         : operation

 Target Server Type    : MySQL
 Target Server Version : 50717 (5.7.17)
 File Encoding         : 65001

 Date: 13/10/2023 10:12:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for Consumables
-- ----------------------------
DROP TABLE IF EXISTS `Consumables`;
CREATE TABLE `Consumables` (
  `ConsumableID` int(11) NOT NULL COMMENT '耗材ID',
  `ConsumableName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '耗材名称',
  `Type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '耗材的类型，例如办公用品、医疗用品等。',
  `Specification` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述耗材的规格和型号。',
  `Unit` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表示耗材的计量单位，如个、箱、卷等。',
  `StockQuantity` int(11) DEFAULT NULL COMMENT '当前库存中的数量。',
  `Supplier` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '提供耗材的供应商信息。',
  `PurchasePrice` decimal(10,2) DEFAULT NULL COMMENT '每单位耗材的购入价格。',
  `CreatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录该条目的创建日期。',
  `UpdatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录该条目的最后更新日期。',
  PRIMARY KEY (`ConsumableID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for ConsumptionRecords
-- ----------------------------
DROP TABLE IF EXISTS `ConsumptionRecords`;
CREATE TABLE `ConsumptionRecords` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标识符，通常是自增的整数。',
  `ConsumableID` int(11) DEFAULT NULL COMMENT '与耗材表关联，表示哪种耗材被消耗。',
  `ConsumableName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '耗材名称',
  `Quantity` int(11) DEFAULT NULL COMMENT '消耗的数量。',
  `ConsumptionDate` datetime DEFAULT NULL COMMENT '记录消耗的日期和时间。',
  `User` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '记录使用该耗材的员工或部门。',
  `Note` text COLLATE utf8mb4_unicode_ci COMMENT '可选字段，用于记录任何额外的信息。',
  PRIMARY KEY (`ID`),
  KEY `ConsumableID` (`ConsumableID`),
  CONSTRAINT `ConsumptionRecords_ibfk_1` FOREIGN KEY (`ConsumableID`) REFERENCES `Consumables` (`ConsumableID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for Departments
-- ----------------------------
DROP TABLE IF EXISTS `Departments`;
CREATE TABLE `Departments` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标识符，通常是自增的整数。',
  `DepartmentName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '部门的名称。',
  `DepartmentHead` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '该部门的负责人信息。',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for Employees
-- ----------------------------
DROP TABLE IF EXISTS `Employees`;
CREATE TABLE `Employees` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标识符，通常是自增的整数。',
  `Name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '员工的姓名。',
  `Sex` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '员工性别',
  `Department` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '员工所属的部门信息。',
  `Position` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '员工的职位信息。',
  `ContactInfo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '员工的联系方式，如电话号码或电子邮件地址。',
  `Home_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '员工住址',
  `PassWord` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登录密码',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for ProductTable
-- ----------------------------
DROP TABLE IF EXISTS `ProductTable`;
CREATE TABLE `ProductTable` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '产品ID',
  `ProductName` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '产品名称',
  `ProductStatus` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '已上架' COMMENT '产品状态',
  `ProductPrice` int(11) NOT NULL COMMENT '产品价格',
  `on_shelf_time` datetime DEFAULT NULL COMMENT '上架时间',
  `off_shelf_time` datetime DEFAULT NULL COMMENT '下架时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for Suppliers
-- ----------------------------
DROP TABLE IF EXISTS `Suppliers`;
CREATE TABLE `Suppliers` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标识符，通常是自增的整数。',
  `SupplierName` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '供应商的名称。',
  `ContactInfo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '供应商的联系方式，如电话号码或电子邮件地址。',
  `ContactPerson` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for Transactions
-- ----------------------------
DROP TABLE IF EXISTS `Transactions`;
CREATE TABLE `Transactions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `ProductName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '产品名称',
  `ProductPrice` decimal(10,2) NOT NULL COMMENT '产品价格',
  `isRefund` tinyint(1) DEFAULT '0' COMMENT '是否退款，1表示已退款，0表示未退款',
  `TransactionTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录该条目的创建日期',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
