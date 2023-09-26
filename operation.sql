-- MySQL dump 10.13  Distrib 5.7.17, for Linux (x86_64)
--
-- Host: localhost    Database: operation
-- ------------------------------------------------------
-- Server version	5.7.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Consumables`
--

DROP TABLE IF EXISTS `Consumables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ConsumptionRecords`
-- -

DROP TABLE IF EXISTS `ConsumptionRecords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Departments`
--

DROP TABLE IF EXISTS `Departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Departments` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标识符，通常是自增的整数。',
  `DepartmentName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '部门的名称。',
  `DepartmentHead` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '该部门的负责人信息。',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Employees`
--

DROP TABLE IF EXISTS `Employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ProductTable`
--

DROP TABLE IF EXISTS `ProductTable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProductTable` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '产品ID',
  `ProductName` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '产品名称',
  `ProductStatus` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '已上架' COMMENT '产品状态',
  `ProductPrice` int(11) NOT NULL COMMENT '产品价格',
  `on_shelf_time` datetime DEFAULT NULL COMMENT '上架时间',
  `off_shelf_time` datetime DEFAULT NULL COMMENT '下架时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Suppliers`
--

DROP TABLE IF EXISTS `Suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Suppliers` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标识符，通常是自增的整数。',
  `SupplierName` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '供应商的名称。',
  `ContactInfo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '供应商的联系方式，如电话号码或电子邮件地址。',
  `ContactPerson` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Transactions`
--

DROP TABLE IF EXISTS `Transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Transactions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `ProductName` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '产品名称',
  `ProductPrice` decimal(10,2) NOT NULL COMMENT '产品价格',
  `isRefund` tinyint(1) DEFAULT '0' COMMENT '是否退款，1表示已退款，0表示未退款',
  `TransactionTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录该条目的创建日期',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-26 11:31:25
