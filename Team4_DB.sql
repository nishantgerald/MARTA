CREATE DATABASE  IF NOT EXISTS `Beltline` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `Beltline`;
-- MySQL dump 10.13  Distrib 8.0.13, for macos10.14 (x86_64)
--
-- Host: localhost    Database: Beltline
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `connect`
--

DROP TABLE IF EXISTS `connect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `connect` (
  `TransitType` enum('MARTA','Bus','Bike') NOT NULL,
  `TransitRoute` varchar(20) NOT NULL,
  `SiteName` varchar(50) NOT NULL,
  PRIMARY KEY (`TransitType`,`TransitRoute`,`SiteName`),
  KEY `SiteName` (`SiteName`),
  CONSTRAINT `connect_ibfk_1` FOREIGN KEY (`TransitType`, `TransitRoute`) REFERENCES `transit` (`transittype`, `transitroute`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `connect_ibfk_2` FOREIGN KEY (`SiteName`) REFERENCES `site` (`sitename`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `connect`
--

LOCK TABLES `connect` WRITE;
/*!40000 ALTER TABLE `connect` DISABLE KEYS */;
INSERT INTO `connect` VALUES ('MARTA','Blue','Historic Fourth Ward Park'),('Bus','152','Historic Fourth Ward Park'),('Bike','Relay','Historic Fourth Ward Park'),('MARTA','Blue','Inman Park'),('Bus','152','Inman Park'),('MARTA','Blue','Piedmont Park'),('Bus','152','Piedmont Park'),('Bike','Relay','Piedmont Park'),('MARTA','Blue','Westview Cemetery');
/*!40000 ALTER TABLE `connect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emails`
--

DROP TABLE IF EXISTS `emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `emails` (
  `Email` varchar(50) NOT NULL,
  `Username` varchar(50) NOT NULL,
  PRIMARY KEY (`Email`),
  KEY `Username` (`Username`),
  CONSTRAINT `emails_ibfk_1` FOREIGN KEY (`Username`) REFERENCES `user` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emails`
--

LOCK TABLES `emails` WRITE;
/*!40000 ALTER TABLE `emails` DISABLE KEYS */;
INSERT INTO `emails` VALUES ('dsmith@outlook.com','david.smith'),('jsmith@gatech.edu','james.smith'),('jsmith@gmail.com','james.smith'),('jsmith@hotmail.com','james.smith'),('jsmith@outlook.com','james.smith'),('m1@beltline.com','manager1'),('m2@beltline.com','manager2'),('m3@beltline.com','manager3'),('m4@beltline.com','manager4'),('m5@beltline.com','manager5'),('mgarcia@gatech.edu','maria.garcia'),('mgarcia@yahoo.com','maria.garcia'),('mh@gatech.edu','maria.hernandez'),('mh123@gmail.com','maria.hernandez'),('mrodriguez@gmail.com','maria.rodriguez'),('mary@outlook.com','mary.smith'),('msmith@gmail.com','michael.smith'),('rsmith@hotmail.com','robert.smith'),('s1@beltline.com','staff1'),('s2@beltline.com','staff2'),('s3@beltline.com','staff3'),('u1@beltline.com','user1'),('v1@beltline.com','visitor1');
/*!40000 ALTER TABLE `emails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `employee` (
  `EmployeeID` char(9) NOT NULL,
  `Phone` decimal(10,0) NOT NULL,
  `EmployeeAddress` varchar(100) NOT NULL,
  `EmployeeCity` varchar(50) NOT NULL,
  `EmployeeState` enum('AK','AL','AR','AZ','CA','CO','CT','DE','FL','GA','HI','IA','ID','IL','IN','KS','KY','LA','MA','MD','ME','MI','MN','MO','MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VA','VT','WA','WI','WV','WY','other') NOT NULL,
  `EmployeeZipcode` decimal(5,0) NOT NULL,
  `EmployeeType` enum('Manager','Staff','Admin') NOT NULL,
  `Username` varchar(50) NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  UNIQUE KEY `Username` (`Username`),
  UNIQUE KEY `Phone` (`Phone`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`Username`) REFERENCES `user` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('1',4043721234,'123 East Main Street','Rochester','NY',14604,'Admin','james.smith'),('10',8031446782,'801 Atlantic Drive','Atlanta','GA',30332,'Manager','manager5'),('11',8024456765,'266 Ferst Drive Northwest','Atlanta','GA',30332,'Staff','staff1'),('12',8888888888,'266 Ferst Drive Northwest','Atlanta','GA',30332,'Staff','staff2'),('13',3333333333,'801 Atlantic Drive','Atlanta','GA',30332,'Staff','staff3'),('2',4043726789,'350 Ferst Drive','Atlanta','GA',30332,'Staff','michael.smith'),('3',1234567890,'123 East Main Street','Columbus','OH',43215,'Staff','robert.smith'),('4',7890123456,'123 East Main Street','Richland','PA',17987,'Manager','maria.garcia'),('5',5124776435,'350 Ferst Drive','Atlanta','GA',30332,'Manager','david.smith'),('6',8045126767,'123 East Main Street','Rochester','NY',14604,'Manager','manager1'),('7',9876543210,'123 East Main Street','Rochester','NY',14604,'Manager','manager2'),('8',5432167890,'350 Ferst Drive','Atlanta','GA',30332,'Manager','manager3'),('9',8053467565,'123 East Main Street','Columbus','OH',43215,'Manager','manager4');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `event` (
  `EventName` varchar(100) NOT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL,
  `EventPrice` decimal(7,2) NOT NULL,
  `Capacity` int(11) NOT NULL,
  `MinStaffRequired` int(11) NOT NULL,
  `Description` text NOT NULL,
  `SiteName` varchar(50) NOT NULL,
  PRIMARY KEY (`EventName`,`StartDate`,`SiteName`),
  UNIQUE KEY `EventName` (`EventName`,`StartDate`,`SiteName`),
  KEY `SiteName` (`SiteName`),
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`SiteName`) REFERENCES `site` (`sitename`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES ('Arboretum Walking Tour','2019-02-08','2019-02-11',5.00,5,1,'Official Atlanta BeltLine Arboretum Walking Tours provide an up-close view of the Westside Trail and the Atlanta BeltLine Arboretum led by Trees Atlanta Docents. The one and a half hour tours step off at at 10am (Oct thru May), and 9am (June thru September). Departure for all tours is from Rose Circle Park near Brown Middle School. More details at: https://beltline.org/visit/atlanta-beltline-tours/#arboretum-walking','Inman Park'),('Bus Tour','2019-02-01','2019-02-02',25.00,6,2,'The Atlanta BeltLine Partnership\'s tour program operates with a natural gas-powered, ADA accessible tour bus funded through contributions from 10th & Monroe, LLC, SunTrust Bank Trusteed Foundations\' Florence C. and Harry L. English Memorial Fund and Thomas Guy Woolford Charitable Trust, and AGL Resources','Inman Park'),('Bus Tour','2019-02-08','2019-02-10',25.00,6,2,'The Atlanta BeltLine Partnership\'s tour program operates with a natural gas-powered, ADA accessible tour bus funded through contributions from 10th & Monroe, LLC, SunTrust Bank Trusteed Foundations\' Florence C. and Harry L. English Memorial Fund and Thomas Guy Woolford Charitable Trust, and AGL Resources','Inman Park'),('Eastside Trail','2019-02-04','2019-02-05',0.00,99999,1,'A combination of multi-use trail and linear greenspace, the Eastside Trail was the first finished section of the Atlanta BeltLine trail in the old rail corridor. The Eastside Trail, which was funded by a combination of public and private philanthropic sources, runs from the tip of Piedmont Park to Reynoldstown. More details at https://beltline.org/explore-atlanta-beltline-trails/eastside-trail/','Inman Park'),('Eastside Trail','2019-02-04','2019-02-05',0.00,99999,1,'A combination of multi-use trail and linear greenspace, the Eastside Trail was the first finished section of the Atlanta BeltLine trail in the old rail corridor. The Eastside Trail, which was funded by a combination of public and private philanthropic sources, runs from the tip of Piedmont Park to Reynoldstown. More details at https://beltline.org/explore-atlanta-beltline-trails/eastside-trail/','Piedmont Park'),('Eastside Trail','2019-02-13','2019-02-14',0.00,99999,1,'A combination of multi-use trail and linear greenspace, the Eastside Trail was the first finished section of the Atlanta BeltLine trail in the old rail corridor. The Eastside Trail, which was funded by a combination of public and private philanthropic sources, runs from the tip of Piedmont Park to Reynoldstown. More details at https://beltline.org/explore-atlanta-beltline-trails/eastside-trail/','Historic Fourth Ward Park'),('Eastside Trail','2019-03-01','2019-03-02',0.00,99999,1,'A combination of multi-use trail and linear greenspace, the Eastside Trail was the first finished section of the Atlanta BeltLine trail in the old rail corridor. The Eastside Trail, which was funded by a combination of public and private philanthropic sources, runs from the tip of Piedmont Park to Reynoldstown. More details at https://beltline.org/explore-atlanta-beltline-trails/eastside-trail/','Inman Park'),('Official Atlanta BeltLine Bike Tour','2019-02-09','2019-02-14',5.00,5,1,'These tours will include rest stops highlighting assets and points of interest along the Atlanta BeltLine. Staff will lead the rides, and each group will have a ride sweep to help with any unexpected mechanical difficulties.','Atlanta BeltLine Center'),('Private Bus Tour','2019-02-01','2019-02-02',40.00,4,1,'Private tours are available most days, pending bus and tour guide availability. Private tours can accommodate up to 4 guests per tour, and are subject to a tour fee (nonprofit rates are available). As a nonprofit organization with limited resources, we are unable to offer free private tours. We thank you for your support and your understanding as we try to provide as many private group tours as possible. The Atlanta BeltLine Partnership\'s tour program operates with a natural gas-powered, ADA accessible tour bus funded through contributions from 10th & Monroe, LLC, SunTrust Bank Trusteed Foundations\' Florence C. and Harry L. English Memorial Fund and Thomas Guy Woolford Charitable Trust, and AGL Resources','Inman Park'),('Westside Trail','2019-02-18','2019-02-21',0.00,99999,1,'The Westside Trail is a free amenity that offers a bicycle and pedestrian-safe corridor with a 14-foot-wide multi-use trail surrounded by mature trees and grasses thanks to Trees Atlantas Arboretum. With 16 points of entry, 14 of which will be ADA-accessible with ramp and stair systems, the trail provides numerous access points for people of all abilities. More details at: https://beltline.org/explore-atlanta-beltline-trails/westside-trail/','Westview Cemetery');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site`
--

DROP TABLE IF EXISTS `site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `site` (
  `SiteName` varchar(50) NOT NULL,
  `SiteAddress` varchar(100) DEFAULT NULL,
  `SiteZipcode` decimal(5,0) NOT NULL,
  `OpenEveryday` enum('Yes','No') NOT NULL,
  `ManagerUsername` varchar(50) NOT NULL,
  PRIMARY KEY (`SiteName`),
  UNIQUE KEY `ManagerUsername` (`ManagerUsername`),
  CONSTRAINT `site_ibfk_1` FOREIGN KEY (`ManagerUsername`) REFERENCES `employee` (`username`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site`
--

LOCK TABLES `site` WRITE;
/*!40000 ALTER TABLE `site` DISABLE KEYS */;
INSERT INTO `site` VALUES ('Atlanta Beltline Center','112 Krog Street Northeast',30307,'No','manager3'),('Historic Fourth Ward Park','680 Dallas Street Northeast',30308,'Yes','manager4'),('Inman Park',NULL,30307,'Yes','david.smith'),('Piedmont Park','400 Park Drive Northeast',30306,'Yes','manager2'),('Westview Cemetery','1680 Westview Drive Southwest',30310,'No','manager5');
/*!40000 ALTER TABLE `site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_assignment`
--

DROP TABLE IF EXISTS `staff_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `staff_assignment` (
  `StaffUsername` varchar(50) NOT NULL,
  `EventName` varchar(100) NOT NULL,
  `SiteName` varchar(50) NOT NULL,
  `StartDate` date NOT NULL,
  PRIMARY KEY (`StaffUsername`,`EventName`,`StartDate`,`SiteName`),
  KEY `EventName` (`EventName`,`StartDate`,`SiteName`),
  CONSTRAINT `staff_assignment_ibfk_1` FOREIGN KEY (`StaffUsername`) REFERENCES `employee` (`username`) ON DELETE RESTRICT,
  CONSTRAINT `staff_assignment_ibfk_2` FOREIGN KEY (`EventName`, `StartDate`, `SiteName`) REFERENCES `event` (`eventname`, `startdate`, `sitename`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_assignment`
--

LOCK TABLES `staff_assignment` WRITE;
/*!40000 ALTER TABLE `staff_assignment` DISABLE KEYS */;
INSERT INTO `staff_assignment` VALUES ('staff3','Arboretum Walking Tour','Inman Park','2019-02-08'),('michael.smith','Bus Tour','Inman Park','2019-02-01'),('staff2','Bus Tour','Inman Park','2019-02-01'),('michael.smith','Bus Tour','Inman Park','2019-02-08'),('robert.smith','Bus Tour','Inman Park','2019-02-08'),('robert.smith','Eastside Trail','Inman Park','2019-02-04'),('staff2','Eastside Trail','Inman Park','2019-02-04'),('michael.smith','Eastside Trail','Piedmont Park','2019-02-04'),('staff1','Eastside Trail','Piedmont Park','2019-02-04'),('michael.smith','Eastside Trail','Historic Fourth Ward Park','2019-02-13'),('staff1','Eastside Trail','Inman Park','2019-03-01'),('staff1','Official Atlanta BeltLine Bike Tour','Atlanta BeltLine Center','2019-02-09'),('robert.smith','Private Bus Tour','Inman Park','2019-02-01'),('staff1','Westside Trail','Westview Cemetery','2019-02-18'),('staff3','Westside Trail','Westview Cemetery','2019-02-18');
/*!40000 ALTER TABLE `staff_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `take`
--

DROP TABLE IF EXISTS `take`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `take` (
  `TransitDate` date NOT NULL,
  `TransitType` enum('MARTA','Bus','Bike') NOT NULL,
  `TransitRoute` varchar(20) NOT NULL,
  `Username` varchar(50) NOT NULL,
  PRIMARY KEY (`Username`,`TransitType`,`TransitRoute`,`TransitDate`),
  KEY `TransitType` (`TransitType`,`TransitRoute`),
  CONSTRAINT `take_ibfk_1` FOREIGN KEY (`TransitType`, `TransitRoute`) REFERENCES `transit` (`transittype`, `transitroute`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `take_ibfk_2` FOREIGN KEY (`Username`) REFERENCES `user` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `take`
--

LOCK TABLES `take` WRITE;
/*!40000 ALTER TABLE `take` DISABLE KEYS */;
INSERT INTO `take` VALUES ('2019-03-20','MARTA','Blue','manager2'),('2019-03-21','MARTA','Blue','manager2'),('2019-03-22','MARTA','Blue','manager2'),('2019-03-21','MARTA','Blue','visitor1'),('2019-03-20','Bus','152','manager2'),('2019-03-20','Bus','152','maria.hernandez'),('2019-03-22','Bus','152','maria.hernandez'),('2019-03-20','Bike','Relay','manager3'),('2019-03-20','Bike','Relay','maria.hernandez'),('2019-03-23','Bike','Relay','mary.smith');
/*!40000 ALTER TABLE `take` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transit`
--

DROP TABLE IF EXISTS `transit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `transit` (
  `TransitType` enum('MARTA','Bus','Bike') NOT NULL,
  `TransitRoute` varchar(20) NOT NULL,
  `TransitPrice` decimal(7,2) NOT NULL,
  PRIMARY KEY (`TransitType`,`TransitRoute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transit`
--

LOCK TABLES `transit` WRITE;
/*!40000 ALTER TABLE `transit` DISABLE KEYS */;
INSERT INTO `transit` VALUES ('MARTA','Blue',2.00),('Bus','152',2.00),('Bike','Relay',1.00);
/*!40000 ALTER TABLE `transit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `Username` varchar(50) NOT NULL,
  `Password` varchar(200) NOT NULL,
  `Status` enum('Approved','Declined','Pending') NOT NULL,
  `UserType` varchar(50) NOT NULL,
  `Firstname` varchar(50) NOT NULL,
  `Lastname` varchar(50) NOT NULL,
  PRIMARY KEY (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('david.smith','07f4556478cb21b005f82051ef5ca3c8','Approved','Employee','David','Smith'),('james.smith','1254737c076cf867dc53d60a0364f38e','Approved','Employee','James','Smith'),('manager1','c240642ddef994358c96da82c0361a58','Pending','Employee','Manager','One'),('manager2','8df5127cd164b5bc2d2b78410a7eea0c','Approved','Employee, Visitor','Manager','Two'),('manager3','2d3a5db4a2a9717b43698520a8de57d0','Approved','Employee','Manager','Three'),('manager4','e1ec6fc941af3ba79a4ac5242dd39735','Approved','Employee, Visitor','Manager','Four'),('manager5','029cb1d27c0b9c551703ccba2591c334','Approved','Employee, Visitor','Manager','Five'),('maria.garcia','cc0c3924b78d426700360b76db8b2403','Approved','Employee, Visitor','Maria','Garcia'),('maria.hernandez','9acd33e5f3c729eeea08bbee68b62605','Approved','User','Maria','Hernandez'),('maria.rodriguez','08ed5c4b5499407be0a438654984da36','Declined','Visitor','Maria','Rodriguez'),('mary.smith','b4e4e07c0df7185cb5df959a0074d45b','Approved','Visitor','Mary','Susersusersusersmith'),('michael.smith','173dafbc79fd0527ee13bcdd75ae37e1','Approved','Employee, Visitor','Michael','Smith'),('robert.smith','5bb783f424929272aa2845165cf54727','Approved','Employee','Robert','Smith'),('staff1','04d4b37015f6ba05077ae49776a76b95','Approved','Employee','Staff','One'),('staff2','3c20c4518381a51023bdd5eb2eb66977','Approved','Employee, Visitor','Staff','Two'),('staff3','308a4c22bebf60c77f158b103695d0ec','Approved','Employee, Visitor','Staff','Three'),('user1','4da49c16db42ca04538d629ef0533fe8','Pending','User','User','One'),('visitor1','377656457556736de417e2f9d7fca8a1','Approved','Visitor','Visitor','One');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitevent`
--

DROP TABLE IF EXISTS `visitevent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `visitevent` (
  `VisitEventDate` date NOT NULL,
  `VisitorUsername` varchar(50) NOT NULL,
  `EventName` varchar(100) NOT NULL,
  `SiteName` varchar(50) NOT NULL,
  `StartDate` date NOT NULL,
  PRIMARY KEY (`VisitorUsername`,`EventName`,`StartDate`,`SiteName`,`VisitEventDate`),
  KEY `EventName` (`EventName`,`StartDate`,`SiteName`),
  CONSTRAINT `visitevent_ibfk_1` FOREIGN KEY (`VisitorUsername`) REFERENCES `user` (`username`) ON DELETE CASCADE,
  CONSTRAINT `visitevent_ibfk_2` FOREIGN KEY (`EventName`, `StartDate`, `SiteName`) REFERENCES `event` (`eventname`, `startdate`, `sitename`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitevent`
--

LOCK TABLES `visitevent` WRITE;
/*!40000 ALTER TABLE `visitevent` DISABLE KEYS */;
INSERT INTO `visitevent` VALUES ('2019-02-10','mary.smith','Arboretum Walking Tour','Inman Park','2019-02-08'),('2019-02-02','manager2','Bus Tour','Inman Park','2019-02-01'),('2019-02-01','manager4','Bus Tour','Inman Park','2019-02-01'),('2019-02-02','manager5','Bus Tour','Inman Park','2019-02-01'),('2019-02-02','maria.garcia','Bus Tour','Inman Park','2019-02-01'),('2019-02-01','mary.smith','Bus Tour','Inman Park','2019-02-01'),('2019-02-02','staff2','Bus Tour','Inman Park','2019-02-01'),('2019-02-04','mary.smith','Eastside Trail','Piedmont Park','2019-02-04'),('2019-02-13','mary.smith','Eastside Trail','Historic Fourth Ward Park','2019-02-13'),('2019-02-14','mary.smith','Eastside Trail','Historic Fourth Ward Park','2019-02-13'),('2019-02-14','visitor1','Eastside Trail','Historic Fourth Ward Park','2019-02-13'),('2019-02-10','mary.smith','Official Atlanta BeltLine Bike Tour','Atlanta BeltLine Center','2019-02-09'),('2019-02-10','visitor1','Official Atlanta BeltLine Bike Tour','Atlanta BeltLine Center','2019-02-09'),('2019-02-01','mary.smith','Private Bus Tour','Inman Park','2019-02-01'),('2019-02-02','mary.smith','Private Bus Tour','Inman Park','2019-02-01'),('2019-02-19','mary.smith','Westside Trail','Westview Cemetery','2019-02-18'),('2019-02-19','visitor1','Westside Trail','Westview Cemetery','2019-02-18');
/*!40000 ALTER TABLE `visitevent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitsite`
--

DROP TABLE IF EXISTS `visitsite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `visitsite` (
  `VisitSiteDate` date NOT NULL,
  `SiteName` varchar(50) NOT NULL,
  `VisitorUsername` varchar(50) NOT NULL,
  PRIMARY KEY (`VisitSiteDate`,`SiteName`,`VisitorUsername`),
  KEY `SiteName` (`SiteName`),
  KEY `VisitorUsername` (`VisitorUsername`),
  CONSTRAINT `visitsite_ibfk_1` FOREIGN KEY (`SiteName`) REFERENCES `site` (`sitename`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `visitsite_ibfk_2` FOREIGN KEY (`VisitorUsername`) REFERENCES `user` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitsite`
--

LOCK TABLES `visitsite` WRITE;
/*!40000 ALTER TABLE `visitsite` DISABLE KEYS */;
INSERT INTO `visitsite` VALUES ('2019-02-01','Atlanta Beltline Center','mary.smith'),('2019-02-09','Atlanta Beltline Center','visitor1'),('2019-02-10','Atlanta Beltline Center','mary.smith'),('2019-02-13','Atlanta Beltline Center','visitor1'),('2019-02-02','Historic Fourth Ward Park','mary.smith'),('2019-02-11','Historic Fourth Ward Park','visitor1'),('2019-02-01','Inman Park','mary.smith'),('2019-02-01','Inman Park','visitor1'),('2019-02-02','Inman Park','mary.smith'),('2019-02-03','Inman Park','mary.smith'),('2019-02-01','Piedmont Park','visitor1'),('2019-02-02','Piedmont Park','mary.smith'),('2019-02-11','Piedmont Park','visitor1'),('2019-02-06','Westview Cemetery','visitor1');
/*!40000 ALTER TABLE `visitsite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'Beltline'
--

--
-- Dumping routines for database 'Beltline'
--
/*!50003 DROP PROCEDURE IF EXISTS `s01_employee_check_type` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s01_employee_check_type`(IN
  EMailID VARCHAR(50))
BEGIN
	SELECT EmployeeType
    FROM employee
    WHERE Username in (SELECT Username FROM emails WHERE Email = EMailID);
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s01_user_login_check_email` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s01_user_login_check_email`(IN
  EMailID VARCHAR(50))
BEGIN
	SELECT EXISTS (SELECT Username FROM emails WHERE Email = EMailID);
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s01_user_login_check_password` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s01_user_login_check_password`(IN
  EMailID VARCHAR(50),
  Pass VARCHAR(200))
BEGIN
	set @hashp = MD5(Pass);
	SELECT UserType, Status
    FROM user
    WHERE Username in (SELECT Username FROM emails WHERE Email = EMailID) AND Password = @hashp;
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s03_register_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s03_register_user`(IN
  UName VARCHAR(50),
  Pass VARCHAR(200),
  UType ENUM('Visitor','User'),
  FName VARCHAR(50),
  LName VARCHAR(50))
BEGIN
 set @hashp = MD5(Pass);
 INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES (UName,@hashp,'Pending',FName,LName,UType);
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s03_remove_email` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s03_remove_email`(IN UName VARCHAR(50), EMail VARCHAR(50))
BEGIN
DELETE FROM emails
WHERE Username = UName AND Email = EMail;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s04_add_email` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s04_add_email`(IN UName VARCHAR(50),
  EMail VARCHAR(50))
BEGIN
 INSERT INTO emails(Username,Email) VALUES (UName,EMail);
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s04_register_visitor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s04_register_visitor`(IN UName VARCHAR(50),Pass VARCHAR(200),FName VARCHAR(50),LName VARCHAR(50))
BEGIN
set @hashp = MD5(Pass);
INSERT INTO user(Username, Password, Status, UserType, Firstname, Lastname)
VALUES(UName, @hashp, 'Pending', 'Visitor', FName, LName);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s05_register_employee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s05_register_employee`(IN
  UName VARCHAR(50),
  Pass VARCHAR(200),
  UType VARCHAR(50),
  FName VARCHAR(50),
  LName VARCHAR(50),
  EID CHAR(9),
  Phone DECIMAL(10,0),
  EAddress VARCHAR(100),
  ECity VARCHAR(50),
  EState ENUM('AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MI','MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VA', 'VT', 'WA', 'WI', 'WV', 'WY','other'),
  EZipcode CHAR(5),
  EType ENUM('Manager','Staff','Admin'))
BEGIN
 set @hashp = MD5(Pass);
 INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES (UName,@hashp,'Pending',FName,LName,UType);
 INSERT INTO employee(Username,EmployeeID,Phone,EmployeeAddress,EmployeeCity,EmployeeState,EmployeeZipcode,EmployeeType) VALUES (UName,EID,Phone,EAddress,ECity,EState,EZipcode,EType);
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s06_register_employee_visitor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s06_register_employee_visitor`(IN
  UName VARCHAR(50),
  Pass VARCHAR(200),
  UType VARCHAR(50),
  FName VARCHAR(50),
  LName VARCHAR(50),
  EID CHAR(9),
  Phone DECIMAL(10,0),
  EAddress VARCHAR(100),
  ECity VARCHAR(50),
  EState ENUM('AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MI','MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VA', 'VT', 'WA', 'WI', 'WV', 'WY','other'),
  EZipcode CHAR(5),
  EType ENUM('Manager','Staff','Admin'))
BEGIN
 set @hashp = MD5(Pass);
 INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES (UName,@hashp,'Pending',FName,LName,UType);
 INSERT INTO employee(Username,EmployeeID,Phone,EmployeeAddress,EmployeeCity,EmployeeState,EmployeeZipcode,EmployeeType) VALUES (UName,EID,Phone,EAddress,ECity,EState,EZipcode,EType);
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s15_get_route` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s15_get_route`(IN
  TType ENUM('MARTA','Bus','Bike'),
  Site VARCHAR(50),
  PrangeL DECIMAL(7,2),
  PrangeU DECIMAL(7,2))
BEGIN
SELECT connect.TransitType as Type,connect.TransitRoute as Route, transit.TransitPrice as Price, count(*) as No_of_Connected_Sites
FROM transit
JOIN connect ON transit.TransitType=connect.TransitType AND transit.TransitRoute=connect.TransitRoute
GROUP BY transit.TransitType,transit.TransitRoute HAVING CONCAT(transit.TransitType,transit.TransitRoute) IN (
  SELECT DISTINCT CONCAT(transit.TransitType,transit.TransitRoute)
  FROM transit
  JOIN connect ON transit.TransitType=connect.TransitType AND transit.TransitRoute=connect.TransitRoute
  WHERE
  CASE WHEN TType IS NULL
   THEN transit.TransitType=transit.TransitType
   ELSE transit.TransitType = TType END
   AND CASE WHEN Site IS NULL
   THEN connect.SiteName = connect.SiteName
   ELSE connect.SiteName = Site END
   AND transit.TransitPrice BETWEEN PrangeL AND PrangeU);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s15_get_sites` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s15_get_sites`()
BEGIN
SELECT DISTINCT SiteName
FROM site;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s15_log_transit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s15_log_transit`(IN Date DATE, Type ENUM('MARTA','Bus','Bike'), Route VARCHAR(20), Name VARCHAR(50))
BEGIN
INSERT INTO take(TransitDate, TransitType, TransitRoute, Username)
VALUES(Date, Type, Route, Name);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s16_transit_history` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s16_transit_history`(IN
  UName VARCHAR(50),
  TType VARCHAR(50),
  Site VARCHAR(50),
  Route VARCHAR(20),
  StartDate DATE,
  EndDate DATE)
BEGIN

DROP VIEW IF EXISTS transit_connections;

CREATE VIEW transit_connections AS
SELECT transit.TransitType, transit.TransitRoute, transit.TransitPrice, connect.SiteName
FROM transit
JOIN connect ON transit.TransitType=connect.TransitType AND transit.TransitRoute=connect.TransitRoute;

SELECT DISTINCT take.TransitDate as Date,take.TransitType as Type,take.TransitRoute as Route, transit_connections.TransitPrice as Price
FROM take
INNER JOIN transit_connections ON transit_connections.TransitType=take.TransitType AND transit_connections.TransitRoute=take.TransitRoute
WHERE take.username = UName AND
CASE WHEN TType IS NULL
 THEN transit_connections.TransitType=transit_connections.TransitType
 ELSE transit_connections.TransitType = TType END
 AND CASE WHEN Site IS NULL
 THEN transit_connections.SiteName = transit_connections.SiteName
 ELSE transit_connections.SiteName = Site END
  AND CASE WHEN Route IS NULL
 THEN transit_connections.TransitRoute = transit_connections.TransitRoute
 ELSE transit_connections.TransitRoute = Route END
 AND take.TransitDate BETWEEN StartDate AND EndDate;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s17_manage_profile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s17_manage_profile`(IN
  username VARCHAR(50),
  fname VARCHAR(50),
  lname VARCHAR(50),
  phone DECIMAL(10,0))
BEGIN
UPDATE user
SET user.Firstname=fname,user.Lastname=lname
WHERE user.Username=username;
UPDATE employee
SET employee.Phone=phone
WHERE employee.Username=username;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s18_manage_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s18_manage_user`(IN
  username VARCHAR(50),
  type ENUM('User','Visitor','Employee','Employee, Visitor'),
  status ENUM('Approved','Declined','Pending'))
BEGIN
SELECT DISTINCT user.Username as username,user.UserType as type, user.Status as status, count(*) as email_count
FROM user
INNER JOIN emails ON emails.Username=user.Username
GROUP BY emails.Username, user.UserType HAVING CONCAT(user.Username,user.UserType) IN (
  SELECT CONCAT(user.Username,user.UserType)
  FROM user
  WHERE
   CASE WHEN type IS NULL
   THEN user.UserType = user.UserType
   ELSE user.UserType = type END
   AND CASE WHEN username IS NULL
   THEN user.Username = user.Username
   ELSE user.Username = username END
	AND CASE WHEN status IS NULL
   THEN user.Status = user.Status
   ELSE user.Status = status END);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s18_user_status_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s18_user_status_update`(IN
  UName VARCHAR(50),
  UStat ENUM('Approved','Declined'))
BEGIN
  SET @EID = (SELECT MAX(EmployeeID) FROM Beltline.employee) + 1;
  UPDATE user
  SET Status = UStat
  WHERE Username = UName;
  UPDATE employee
  SET EmployeeID = @EID
  WHERE Username = UName;
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s19_delete_site` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s19_delete_site`(IN name VARCHAR(50))
BEGIN
DELETE FROM site
WHERE SiteName = name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s19_manager_list` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s19_manager_list`()
BEGIN
SELECT CONCAT(FirstName, ' ', LastName)
FROM user
WHERE UserName in (SELECT UserName FROM employee WHERE EmployeeType = 'Manager');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s19_manage_site` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s19_manage_site`(IN
  sitename VARCHAR(50),
  fname VARCHAR(50),
  lname VARCHAR(50),
  open_everyday ENUM('Yes','No'))
BEGIN
SELECT site.SiteName as Name,CONCAT(user.Firstname,' ',user.Lastname) as Manager,site.OpenEveryday
FROM site
INNER JOIN user ON user.Username=site.ManagerUsername
WHERE
  CASE WHEN sitename IS NULL
  THEN site.SiteName = site.SiteName
  ELSE site.SiteName = sitename END
  AND CASE WHEN fname IS NULL
  THEN user.Firstname = user.Firstname
  ELSE user.Firstname = fname END
  AND CASE WHEN lname IS NULL
  THEN user.Lastname = user.Lastname
  ELSE user.Lastname = lname END
  AND CASE WHEN open_everyday IS NULL
  THEN site.OpenEveryday = site.OpenEveryday
  ELSE site.OpenEveryday = open_everyday END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s20_edit_site` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s20_edit_site`(IN
  old_name VARCHAR(50),
  new_name VARCHAR(50),
  address VARCHAR(50),
  zipcode CHAR(5),
  fname VARCHAR(50),
  lname VARCHAR(50),
  open_everyday ENUM('Yes','No'))
BEGIN

UPDATE site
SET site.SiteName=new_name,site.siteZipcode=zipcode,site.SiteAddress=address,site.OpenEveryday=open_everyday ,site.ManagerUsername=(SELECT UserName FROM user WHERE user.Firstname=fname AND user.Lastname=lname)
WHERE site.SiteName = old_name;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s21_create_site` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s21_create_site`(IN
  SName VARCHAR(50),
  SAddress VARCHAR(50),
  SZipcode CHAR(5),
  Fname VARCHAR(50),
  Lname VARCHAR(50),
  open_everyday ENUM('Yes','No'))
BEGIN

SET @Mgrname=(SELECT UserName FROM user WHERE user.Firstname=Fname AND user.Lastname=Lname);
INSERT INTO site(Sitename, SiteAddress, SiteZipcode, OpenEveryday, ManagerUsername) VALUES (SName, SAddress, SZipcode, open_everyday, @Mgrname);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s21_manager_not_assigned` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s21_manager_not_assigned`()
BEGIN
SELECT CONCAT(FirstName, ' ', LastName)
FROM user
WHERE Username in (SELECT Username FROM employee WHERE EmployeeType = 'Manager')
AND Username not in (SELECT DISTINCT ManagerUsername FROM site);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s22_delete_transit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s22_delete_transit`(IN
  TType ENUM('MARTA','Bus','Bike'),
  Route VARCHAR(20))
BEGIN
DELETE FROM transit
WHERE TransitType = TType and TransitRoute = Route;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s22_manage_transit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s22_manage_transit`(IN
  TType ENUM('MARTA','Bus','Bike'),
  Site VARCHAR(50),
  Route VARCHAR(20),
  PrangeL DECIMAL(7,2),
  PrangeU DECIMAL(7,2))
BEGIN

DROP VIEW IF EXISTS log_counts;

CREATE VIEW log_counts AS
SELECT take.TransitType as TransitType, take.TransitRoute as TransitRoute, count(*) AS Num_logs
FROM take
GROUP BY take.TransitType, take.TransitRoute;

SELECT transit.TransitType, transit.TransitRoute, transit.TransitPrice, log_counts.Num_logs, count(*) AS conn_sites
FROM transit
JOIN connect ON transit.TransitType=connect.TransitType AND transit.TransitRoute=connect.TransitRoute
JOIN log_counts ON transit.TransitType=log_counts.TransitType AND transit.TransitRoute=log_counts.TransitRoute
GROUP BY transit.TransitType, transit.TransitRoute, transit.TransitPrice HAVING CONCAT(transit.TransitType, transit.TransitRoute, transit.TransitPrice) IN(
SELECT CONCAT(transit.TransitType, transit.TransitRoute, transit.TransitPrice)
FROM transit
JOIN connect ON transit.TransitType=connect.TransitType AND transit.TransitRoute=connect.TransitRoute
WHERE
CASE WHEN TType IS NULL
 THEN transit.TransitType=transit.TransitType
 ELSE transit.TransitType = TType END
 AND CASE WHEN Site IS NULL
 THEN connect.SiteName = connect.SiteName
 ELSE connect.SiteName = Site END
  AND CASE WHEN Route IS NULL
 THEN connect.TransitRoute = connect.TransitRoute
 ELSE connect.TransitRoute = Route END
 AND transit.TransitPrice BETWEEN PrangeL AND PrangeU);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s23_add_sites` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s23_add_sites`(
  IN Route VARCHAR(20),
  TType ENUM('MARTA','Bus','Bike'),
  Site_Name VARCHAR(20))
BEGIN
INSERT INTO connect (TransitType, TransitRoute, SiteName)
VALUES (TType, Route, Site_Name);
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s23_delete_sites` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s23_delete_sites`(IN
  TType ENUM('MARTA','Bus','Bike'),
  Route VARCHAR(20))
BEGIN
DELETE FROM connect
WHERE connect.TransitRoute = Route AND connect.TransitType = TType;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s23_edit_price` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s23_edit_price`(IN
  TType ENUM('MARTA','Bus','Bike'),
  Price DECIMAL(7,2),
  Route VARCHAR(20))
BEGIN
UPDATE transit
SET transit.TransitPrice = Price
WHERE transit.TransitRoute = Route AND transit.TransitType = TType;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s23_edit_route` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s23_edit_route`(IN
  TType ENUM('MARTA','Bus','Bike'),
  OldRoute VARCHAR(20),
  Route VARCHAR(20))
BEGIN
UPDATE transit
SET transit.TransitRoute = Route
WHERE transit.TransitRoute = OldRoute AND transit.TransitType = TType;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s23_site_list` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s23_site_list`(IN Route VARCHAR(20))
BEGIN
SELECT SiteName
FROM connect
WHERE TransitRoute = Route;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s24_create_transit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s24_create_transit`(IN
  TType ENUM('MARTA','Bus','Bike'),
  Route VARCHAR(20),
  Price DECIMAL(7,2))
BEGIN
INSERT INTO transit(TransitType, TransitRoute, TransitPrice)
VALUES (TType, Route, Price);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s25_manage_event` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s25_manage_event`(IN
  EName VARCHAR(50),
  Keyword VARCHAR(50),
  SName VARCHAR(50),
  SDate DATE,
  EDate DATE,
  DrangeL DECIMAL (7,0),
  DrangeU DECIMAL (7,0),
  DurangeL DECIMAL (7,0),
  DurangeU DECIMAL (7,0),
  VrangeL DECIMAL (7,0),
  VrangeU DECIMAL (7,0),
  RrangeL DECIMAL(7,2),
  RrangeU DECIMAL(7,2))
BEGIN

DROP VIEW IF EXISTS event_visit_counts;

CREATE VIEW event_visit_counts AS
SELECT event.EventName, event.SiteName, event.StartDate, count(*) AS total_visits, DATEDIFF(event.EndDate,event.StartDate) as duration, count(*)*event.EventPrice as revenue
FROM event
JOIN visitevent ON event.EventName = visitevent.EventName AND event.SiteName = visitevent.SiteName AND event.StartDate = visitevent.StartDate
GROUP BY event.EventName, event.SiteName, event.StartDate, event.EndDate;

DROP VIEW IF EXISTS event_staff_counts;

CREATE VIEW event_staff_counts AS
SELECT event.EventName, event.SiteName, event.StartDate, count(*) AS num_staff
FROM event
JOIN staff_assignment ON event.EventName = staff_assignment.EventName AND event.SiteName = staff_assignment.SiteName AND event.StartDate = staff_assignment.StartDate
GROUP BY event.EventName, event.SiteName, event.StartDate;

SELECT event.EventName, event_staff_counts.num_staff, event_visit_counts.duration, event_visit_counts.total_visits, event_visit_counts.revenue
FROM event
JOIN event_staff_counts ON event.EventName = event_staff_counts.EventName AND event.SiteName = event_staff_counts.SiteName AND event.StartDate = event_staff_counts.StartDate
JOIN event_visit_counts ON event.EventName = event_visit_counts.EventName AND event.SiteName = event_visit_counts.SiteName AND event.StartDate = event_visit_counts.StartDate
GROUP BY event.EventName, event.SiteName, event.StartDate HAVING CONCAT(event.EventName, event.SiteName, event.StartDate) IN(
SELECT CONCAT(event.EventName, event.SiteName, event.StartDate)
FROM event
JOIN event_visit_counts ON event.EventName = event_visit_counts.EventName AND event.SiteName = event_visit_counts.SiteName AND event.StartDate = event_visit_counts.StartDate
WHERE
CASE WHEN EName IS NULL
 THEN event.EventName=event.EventName
 ELSE event.EventName LIKE CONCAT('%',EName,'%') END
 AND CASE WHEN Keyword IS NULL
 THEN event.Description LIKE '%'
 ELSE event.Description LIKE CONCAT('%',Keyword,'%') END
 AND event.SiteName = SName
 AND event_visit_counts.revenue BETWEEN RrangeL AND RrangeU
 AND event_visit_counts.total_visits BETWEEN VrangeL AND VrangeU
 AND event_visit_counts.duration BETWEEN DurangeL AND DurangeU
 AND (event.StartDate BETWEEN SDate and EDate OR event.EndDate BETWEEN SDate and EDate));

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s26_add_staff` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s26_add_staff`(IN
  EName VARCHAR(50),
  SName VARCHAR(50),
  SDate Date,
  Fname VARCHAR(50),
  Lname VARCHAR(50))
BEGIN
SET @Staffname=(SELECT UserName FROM user WHERE user.Firstname=Fname AND user.Lastname=Lname);
INSERT INTO staff_assignment(StaffUsername, EventName, SiteName, StartDate)
VALUES (@Staffname, EName, SName, SDate);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s26_delete_event` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s26_delete_event`(IN
  EName VARCHAR(50),
  SName VARCHAR(50),
  SDate Date)
BEGIN
DELETE FROM event
WHERE EventName = EName and StartDate = SDate and SiteName = SName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s26_get_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s26_get_details`(IN
EName VARCHAR(50),
SDate DATE,
SName VARCHAR(50))
BEGIN
SELECT event.EventName as Name, event.EventPrice as Price, event.StartDate as StartDate, event.EndDate as EndDate, event.MinStaffRequired as MinimumStaffRequired, event.Capacity as Capacity
FROM event
WHERE event.EventName = EName AND event.StartDate = SDate AND event.SiteName = SName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s26_get_event_days` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s26_get_event_days`(IN
EName VARCHAR(50),
SDate DATE,
SName VARCHAR(50))
BEGIN
  SELECT visitevent.VisitEventDate as Date, COUNT(*) as DailyVisits, COUNT(*) *  event.EventPrice
  FROM visitevent
  JOIN event ON event.EventName = visitevent.EventName AND event.SiteName = visitevent.SiteName AND event.StartDate = visitevent.StartDate
  WHERE visitevent.EventName = EName AND visitevent.StartDate = SDate AND visitevent.SiteName = SName
  GROUP BY visitevent.VisitEventDate;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s26_get_staff` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s26_get_staff`(IN
EName VARCHAR(50),
SDate DATE,
SName VARCHAR(50))
BEGIN
  SELECT CONCAT(user.Firstname,' ',user.Lastname) as FullName
  FROM user
  JOIN staff_assignment ON user.Username = staff.StaffUsername
  WHERE event.EventName = EName AND event.StartDate = SDate AND event.SiteName = SName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s26_remove_staff` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s26_remove_staff`(IN
  EName VARCHAR(50),
  SName VARCHAR(50),
  SDate DATE,
  Fname VARCHAR(50),
  Lname VARCHAR(50))
BEGIN
SET @Staffname=(SELECT UserName FROM user WHERE user.Firstname=Fname AND user.Lastname=Lname);
DELETE FROM staff_assignment
WHERE EventName = EName AND StartDate = SDate AND SiteName = SName AND StaffUsername = @Staffname;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s26_update_description` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s26_update_description`(IN
  EName VARCHAR(50),
  SName VARCHAR(50),
  SDate Date,
  Descr TEXT)
BEGIN
UPDATE event
SET Description = Descr
WHERE EventName = EName and StartDate = SDate and SiteName = SName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s27_mgr_create_event` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s27_mgr_create_event`(IN Name VARCHAR(50), SDate date, EDate date,
Price DECIMAL(7,2), ECapacity INT(11), MinStaff INT(11), EDescr TEXT,
SName VARCHAR(50))
BEGIN
INSERT INTO event(EventName, StartDate, EndDate, EventPrice, Capacity, MinStaffRequired, Description, SiteName)
VALUE(Name, SDate, EDate, Price, ECapacity, MinStaff, EDescr, SName);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s27_staff_avail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s27_staff_avail`(IN
  SDate date,
  EDate date)
BEGIN
  SELECT CONCAT(Firstname,' ',Lastname)
  FROM user
  WHERE Username NOT IN (
    SELECT DISTINCT StaffUsername
    FROM staff_assignment
    JOIN event ON event.EventName = staff_assignment.EventName AND event.SiteName = staff_assignment.SiteName AND event.StartDate = staff_assignment.StartDate
    WHERE staff_assignment.StartDate BETWEEN SDate and EDate OR event.EndDate BETWEEN SDate and EDate )
	AND Username IN (
	  SELECT Username
    FROM employee
    WHERE EmployeeType = 'Staff');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s28_get_sites` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s28_get_sites`()
BEGIN
SELECT DISTINCT SiteName from site;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s28_mgr_manage_staff` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s28_mgr_manage_staff`(IN
  SName VARCHAR(50),
  Fname VARCHAR(50),
  Lname VARCHAR(50),
  SDate date,
  EDate date)
BEGIN

  SELECT CONCAT(user.Firstname,' ',user.Lastname) AS staff_name, count(*) AS num_shifts
  FROM staff_assignment
  JOIN user ON staff_assignment.StaffUsername = user.Username
  JOIN event ON event.EventName = staff_assignment.EventName AND event.SiteName = staff_assignment.SiteName AND event.StartDate = staff_assignment.StartDate
  WHERE staff_assignment.StartDate BETWEEN SDate and EDate OR event.EndDate BETWEEN SDate and EDate
  GROUP BY user.Firstname, user.Lastname HAVING CONCAT(user.Firstname, user.Lastname) IN (
    SELECT CONCAT(user.Firstname, user.Lastname)
    FROM staff_assignment
    JOIN user ON staff_assignment.StaffUsername = user.Username
    WHERE
    CASE WHEN SName IS NULL
    THEN staff_assignment.SiteName=staff_assignment.SiteName
    ELSE staff_assignment.SiteName = SName END
    AND CASE WHEN FName IS NULL
    THEN user.Firstname=user.Firstname
    ELSE user.Firstname = Fname END
    AND CASE WHEN LName IS NULL
    THEN user.Lastname=user.Lastname
    ELSE user.Lastname = Lname END);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s29_manager_site_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s29_manager_site_report`(IN
  SName VARCHAR(50),
  SDate DATE,
  EDate DATE,
  ECrangeL DECIMAL (7,0),
  ECrangeU DECIMAL (7,0),
  SCrangeL DECIMAL (7,0),
  SCrangeU DECIMAL (7,0),
  VrangeL DECIMAL (7,0),
  VrangeU DECIMAL (7,0),
  RrangeL DECIMAL(7,2),
  RrangeU DECIMAL(7,2))
BEGIN

/* Creating required views */
DROP VIEW IF EXISTS site_event_counts;

CREATE VIEW site_event_counts AS
SELECT SiteName, StartDate, EndDate, count(*) as num_events
FROM event
GROUP BY SiteName, StartDate, EndDate, SiteName;

DROP VIEW IF EXISTS site_visit_counts;

CREATE VIEW site_visit_counts AS
SELECT  SiteName, VisitSiteDate as VisitDate , count(*) as site_visits
FROM visitsite
GROUP BY SiteName,VisitSiteDate;

DROP VIEW IF EXISTS event_visit_counts;

CREATE VIEW event_visit_counts AS
SELECT  event.SiteName as SiteName, visitevent.VisitEventDate as VisitDate, count(*) as event_visits, count(*)*event.EventPrice as revenue
FROM event
JOIN visitevent ON event.EventName = visitevent.EventName AND event.SiteName = visitevent.SiteName AND event.StartDate = visitevent.StartDate
GROUP BY event.EventName, event.SiteName, event.StartDate, event.EndDate,visitevent.VisitEventDate;

DROP VIEW IF EXISTS daily_event_visits;

CREATE VIEW daily_event_visits AS
SELECT SiteName, VisitDate, SUM(event_visits)as event_visits, SUM(revenue)as revenue
FROM event_visit_counts
GROUP BY SiteName, VisitDate;

DROP VIEW IF EXISTS site_staff_counts;

CREATE VIEW site_staff_counts AS
SELECT event.SiteName as SiteName, event.StartDate as StartDate, event.EndDate as EndDate, count(*) AS num_staff
FROM event
JOIN staff_assignment ON event.EventName = staff_assignment.EventName AND event.SiteName = staff_assignment.SiteName AND event.StartDate = staff_assignment.StartDate
GROUP BY event.SiteName, event.StartDate, event.EndDate;
/* Created required views */

SELECT site_visit_counts.VisitDate,  (IFNULL(site_visit_counts.site_visits,0) + IFNULL(daily_event_visits.event_visits,0)) as total_visits, IFNULL(daily_event_visits.revenue,0) as revenue, IFNULL(site_staff_counts.num_staff,0) as staff_count, IFNULL(site_event_counts.num_events,0) as event_count
FROM site_visit_counts
LEFT JOIN site_staff_counts ON site_visit_counts.SiteName = site_staff_counts.SiteName AND site_visit_counts.VisitDate BETWEEN site_staff_counts.StartDate and site_staff_counts.EndDate
LEFT JOIN site_event_counts ON site_visit_counts.SiteName = site_event_counts.SiteName AND site_visit_counts.VisitDate BETWEEN site_event_counts.StartDate and site_event_counts.EndDate
RIGHT JOIN daily_event_visits ON daily_event_visits.SiteName = site_visit_counts.SiteName AND daily_event_visits.VisitDate = site_visit_counts.VisitDate
WHERE site_visit_counts.SiteName = SName
AND site_visit_counts.VisitDate BETWEEN SDate AND EDate
AND IFNULL(daily_event_visits.revenue,0) BETWEEN RrangeL AND RrangeU
AND (IFNULL(site_visit_counts.site_visits,0) + IFNULL(daily_event_visits.event_visits,0)) BETWEEN VrangeL AND VrangeU
UNION
SELECT site_visit_counts.VisitDate,  (IFNULL(site_visit_counts.site_visits,0) + IFNULL(daily_event_visits.event_visits,0)) as total_visits, IFNULL(daily_event_visits.revenue,0) as revenue, IFNULL(site_staff_counts.num_staff,0) as staff_count, IFNULL(site_event_counts.num_events,0) as event_count
FROM site_visit_counts
LEFT JOIN site_staff_counts ON site_visit_counts.SiteName = site_staff_counts.SiteName AND site_visit_counts.VisitDate BETWEEN site_staff_counts.StartDate and site_staff_counts.EndDate
LEFT JOIN site_event_counts ON site_visit_counts.SiteName = site_event_counts.SiteName AND site_visit_counts.VisitDate BETWEEN site_event_counts.StartDate and site_event_counts.EndDate
LEFT JOIN daily_event_visits ON daily_event_visits.SiteName = site_visit_counts.SiteName AND daily_event_visits.VisitDate = site_visit_counts.VisitDate
WHERE site_visit_counts.SiteName = SName
AND site_visit_counts.VisitDate BETWEEN SDate AND EDate
AND IFNULL(daily_event_visits.revenue,0) BETWEEN RrangeL AND RrangeU
AND (IFNULL(site_visit_counts.site_visits,0) + IFNULL(daily_event_visits.event_visits,0)) BETWEEN VrangeL AND VrangeU;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s30_mgr_daily_detail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s30_mgr_daily_detail`(IN
  SName VARCHAR(50),
  SDate date)
BEGIN

DROP VIEW IF EXISTS event_visit_counts;

CREATE VIEW event_visit_counts AS
SELECT  event.EventName as EventName,event.SiteName as SiteName,event.StartDate as StartDate, visitevent.VisitEventDate as VisitDate, count(*) as num_visits, count(*)*event.EventPrice as revenue
FROM event
JOIN visitevent ON event.EventName = visitevent.EventName AND event.SiteName = visitevent.SiteName AND event.StartDate = visitevent.StartDate
GROUP BY event.EventName, event.SiteName, event.StartDate, event.EndDate,visitevent.VisitEventDate;

DROP VIEW IF EXISTS event_staff_assignments;

CREATE VIEW event_staff_assignments AS
SELECT event.EventName, event.SiteName, event.StartDate, event.EndDate, CONCAT(user.Firstname,' ',user.Lastname) as staff_name
FROM staff_assignment
JOIN event ON event.EventName = staff_assignment.EventName AND event.SiteName = staff_assignment.SiteName AND event.StartDate = staff_assignment.StartDate
JOIN user ON staff_assignment.StaffUsername = user.Username;

SELECT event.EventName, GROUP_CONCAT(event_staff_assignments.staff_name SEPARATOR ', '), SUM(event_visit_counts.num_visits) AS total_visits, SUM(event_visit_counts.revenue) AS total_revenue
FROM event
JOIN event_visit_counts ON event.EventName = event_visit_counts.EventName AND event.SiteName = event_visit_counts.SiteName AND event.StartDate = event_visit_counts.StartDate
JOIN event_staff_assignments ON event.EventName = event_staff_assignments.EventName AND event.SiteName = event_staff_assignments.SiteName AND event.StartDate = event_staff_assignments.StartDate
WHERE event_visit_counts.VisitDate = SDate
AND event_staff_assignments.SiteName = SName
GROUP BY event.EventName, event.StartDate;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s31_view_schedule` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s31_view_schedule`(IN
  EName VARCHAR(50),
  SName VARCHAR(50),
  Keyword VARCHAR(50),
  SDate DATE,
  EDate DATE)
BEGIN
 SELECT staff_assignment.EventName, staff_assignment.SiteName, staff_assignment.StartDate, event.EndDate, Count(*) as StaffCount
 FROM staff_assignment
 INNER JOIN event ON staff_assignment.EventName = event.EventName AND staff_assignment.SiteName = event.SiteName AND staff_assignment.StartDate = event.StartDate
 WHERE
  CASE WHEN EName IS NULL
  THEN event.EventName = event.EventName
  ELSE event.EventName = EName END
  AND CASE WHEN SName IS NULL
  THEN event.SiteName = event.SiteName
  ELSE event.SiteName = SName END
  AND CASE WHEN Keyword IS NULL
  THEN event.Description LIKE '%'
  ELSE event.Description LIKE CONCAT ('%',Keyword,'%') END
  AND (event.StartDate BETWEEN SDate and EDate OR event.EndDate BETWEEN SDate and EDate)
 GROUP BY  staff_assignment.EventName, staff_assignment.SiteName, staff_assignment.StartDate, event.EndDate;
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s32_event_detail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s32_event_detail`(IN EName VARCHAR(50), SName VARCHAR(100), SDate DATE)
BEGIN
  SELECT event.EventName, event.SiteName, event.StartDate, event.EndDate, DATEDIFF(event.EndDate,event.StartDate) as Duration_days,event.Capacity, event.EventPrice, event.Description, GROUP_CONCAT(concat(user.Firstname," ",user.Lastname) SEPARATOR ', ') AS Staff_Assigned
  FROM event
  JOIN staff_assignment ON event.EventName = staff_assignment.EventName AND event.startDate = staff_assignment.StartDate AND event.SiteName = staff_assignment.SiteName
  JOIN user ON user.Username = staff_assignment.StaffUsername
  WHERE event.EventName = EName AND event.SiteName = SName AND event.StartDate = SDate
  GROUP BY event.EventName, event.SiteName, event.StartDate, event.EndDate, DATEDIFF(event.EndDate,event.StartDate), event.Capacity, event.EventPrice, event.Description;
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s33_explore_event` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s33_explore_event`(IN
  UName VARCHAR(50),
  EName VARCHAR(50),
  Keyword VARCHAR(50),
  SName VARCHAR(50),
  SDate DATE,
  EDate DATE,
  include_visited ENUM('Yes','No'),
  include_soldout ENUM('Yes','No'),
  VrangeL DECIMAL(3,0),
  VrangeU DECIMAL(3,0),
  PrangeL DECIMAL(6,2),
  PrangeU DECIMAL(6,2))
BEGIN

 DROP VIEW IF EXISTS user_visits;

 CREATE VIEW user_visits AS
 SELECT EventName,SiteName,StartDate,VisitorUsername, count(*) as myvisits
 FROM visitevent
 GROUP BY EventName,SiteName,StartDate,VisitorUsername;

 SELECT visitevent.EventName, visitevent.SiteName, event.StartDate, EventPrice, event.Capacity - count(*) as TixRemaining, Count(*) as TVisits, user_visits.myvisits
 FROM event
 JOIN visitevent on visitevent.EventName = event.EventName AND visitevent.SiteName = event.SiteName AND visitevent.StartDate = event.StartDate
 JOIN user_visits on user_visits.EventName = event.EventName AND user_visits.SiteName = event.SiteName AND user_visits.StartDate = event.StartDate
 WHERE user_visits.Visitorusername =  UName
 GROUP BY event.EventName, event.SiteName, event.StartDate
 HAVING count(*) BETWEEN VrangeL AND VrangeU
 AND CASE WHEN include_soldout = 'No'
 THEN TixRemaining > 0
 ELSE TixRemaining = TixRemaining END
 AND CONCAT(event.EventName,event.SiteName, event.StartDate) IN (
 SELECT CONCAT(event.EventName,event.SiteName, event.StartDate)
 FROM event
 WHERE
 CASE WHEN EName IS NULL
  THEN event.EventName = event.EventName
  ELSE event.EventName LIKE CONCAT('%',EName,'%') END
  AND CASE WHEN SName IS NULL
  THEN event.SiteName = event.SiteName
  ELSE event.SiteName = SName END
  AND CASE WHEN Keyword IS NULL
  THEN event.Description LIKE '%'
  ELSE event.Description LIKE CONCAT('%',Keyword,'%') END
  AND (event.StartDate BETWEEN SDate and EDate OR event.EndDate BETWEEN SDate and EDate)
  AND CASE WHEN include_visited = 'No'
  THEN CONCAT(event.EventName,event.SiteName, event.StartDate) NOT IN (
    SELECT CONCAT(visitevent.EventName,visitevent.SiteName, visitevent.StartDate)
    FROM visitevent WHERE VisitorUsername = UName)
  ELSE CONCAT(event.EventName,event.SiteName, event.StartDate) = CONCAT(event.EventName,event.SiteName, event.StartDate) END
  AND EventPrice BETWEEN PrangeL AND PrangeU);
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s33_get_sites` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s33_get_sites`()
BEGIN
SELECT DISTINCT SiteName from site;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s34_event_detail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s34_event_detail`(IN eName VARCHAR(100), sName VARCHAR(50), startDate DATE, tixRemaining INT)
BEGIN
SELECT EventName as Event, SiteName as Site, StartDate, EndDate, EventPrice as TicketPrice, tixRemaining as TicketsRemaining, Description
FROM Event
WHERE event.EventName = eName AND event.SiteName = sName AND event.StartDate = startDate;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s34_log_event_visit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s34_log_event_visit`(IN
  UName VARCHAR(50),
  EName VARCHAR(50),
  SName VARCHAR(50),
  SDate DATE,
  VDate DATE)
BEGIN
 INSERT INTO visitevent(VisitorUsername,EventName,StartDate,SiteName,VisitEventDate) VALUES (Uname,EName,SDate,SName,VDate);
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s35_explore_site` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s35_explore_site`(IN
  UName VARCHAR(50),
  SName VARCHAR(50),
  include_visited ENUM('Yes','No'),
  SDate date,
  EDate date,
  VrangeL DECIMAL(7,0),
  VrangeU DECIMAL(7,0),
  ECrangeL DECIMAL(7,0),
  ECrangeU DECIMAL(7,0))
BEGIN

  DROP VIEW IF EXISTS site_event_counts;

  CREATE VIEW site_event_counts AS
  SELECT SiteName,  count(*) as event_count
  FROM event
  GROUP BY SiteName;

  DROP VIEW IF EXISTS site_visit_counts;

  CREATE VIEW site_visit_counts AS
  SELECT  SiteName, count(*) as site_visits
  FROM visitsite
  GROUP BY SiteName;

  DROP VIEW IF EXISTS event_visit_counts;

  CREATE VIEW event_visit_counts AS
  SELECT  SiteName, count(*) as event_visits
  FROM visitevent
  GROUP BY visitevent.SiteName;

  DROP VIEW IF EXISTS total_visit_counts;

  CREATE VIEW total_visit_counts AS
  SELECT site.SiteName, (IFNULL(site_visit_counts.site_visits,0) + IFNULL(event_visit_counts.event_visits,0)) AS total_visits
  FROM site
  JOIN site_visit_counts ON site.SiteName = site_visit_counts.SiteName
  JOIN event_visit_counts ON site.SiteName = event_visit_counts.SiteName;

  DROP VIEW IF EXISTS total_user_visit_counts;

  CREATE VIEW total_user_visit_counts AS
  SELECT  SiteName, VisitSiteDate as VisitDate,VisitorUsername, count(*) as num_visits
  FROM visitsite
  GROUP BY SiteName, VisitSiteDate, VisitorUsername
  UNION ALL
  SELECT  SiteName, VisitEventDate as VisitDate,VisitorUsername, count(*) as num_visits
  FROM visitevent
  GROUP BY SiteName, VisitEventDate, VisitorUsername;

  SELECT site.SiteName, IFNULL(site_event_counts.event_count,0) as num_events, IFNULL(total_visit_counts.total_visits,0) as total_visits, sum(num_visits) as user_visits
  FROM site
  JOIN total_visit_counts on site.SiteName = total_visit_counts.SiteName
  JOIN site_event_counts on site.SiteName = site_event_counts.SiteName
  JOIN total_user_visit_counts on site.SiteName = total_user_visit_counts.SiteName
  WHERE
  total_user_visit_counts.VisitorUsername = UName
  AND total_user_visit_counts.VisitDate BETWEEN SDate AND EDate
  GROUP BY site.SiteName
   HAVING site.SiteName IN
  (
    SELECT DISTINCT site.SiteName
    FROM site
    JOIN total_visit_counts on site.SiteName = total_visit_counts.SiteName
    JOIN site_event_counts on site.SiteName = site_event_counts.SiteName
    JOIN total_user_visit_counts on site.SiteName = total_user_visit_counts.SiteName
    WHERE
    CASE WHEN SName IS NULL
    THEN site.SiteName = site.SiteName
    ELSE site.SiteName = SName END
    AND CASE WHEN include_visited = 'No'
    THEN site.SiteName NOT IN (
    SELECT DISTINCT visitsite.SiteName
    FROM visitsite WHERE VisitorUsername = UName)
    ELSE site.SiteName = site.SiteName END
    AND IFNULL(total_visit_counts.total_visits,0) BETWEEN VrangeL AND VrangeU
    AND IFNULL(site_event_counts.event_count,0) BETWEEN ECrangeL AND ECrangeU);
   END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s35_get_sites` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s35_get_sites`()
BEGIN
SELECT DISTINCT SiteName from site;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s36_log_transit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s36_log_transit`(In TDate DATE, TType ENUM('MARTA','Bus','Bike'), Route VARCHAR(20), UserN VARCHAR(50))
BEGIN
INSERT INTO take (TransitDate, TransitType, TransitRoute, Username)
VALUES (TDate, TType, Route, UserN);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s36_transit_detail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s36_transit_detail`(IN TType ENUM('MARTA','Bus','Bike'), sName VARCHAR(50))
BEGIN
DROP VIEW IF EXISTS conn_site_counts;

CREATE VIEW conn_site_counts AS
SELECT  TransitType, TransitRoute, count(*) as conn_sites
FROM connect;

SELECT transit.TransitRoute as Route, transit.TransitType as TransportType, transit.TransitPrice as Price, conn_site_counts.conn_sites as NumConnectedSites
FROM transit
JOIN connect ON transit.TransitRoute = connect.TransitRoute AND transit.TransitType = connect.TransitType
JOIN conn_site_counts on transit.TransitRoute = conn_site_counts.TransitRoute AND transit.transitType = conn_site_counts.TransitType
WHERE transit.TransitType = TType AND connect.siteName = sName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s37_log_site_visit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s37_log_site_visit`(IN VisitDate DATE, Name VARCHAR(50), Username VARCHAR(50))
BEGIN
INSERT INTO visitsite (VisitSiteDate, SiteName, VisitorUsername)
VALUES (VisitDate, Name, Username);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s37_view_site_detail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s37_view_site_detail`(IN
sName VARCHAR(50))
BEGIN
SELECT SiteName as Site, OpenEveryday, CONCAT(SiteAddress, ', Atlanta, GA ', SiteZipcode) as Address
FROM site
WHERE site.SiteName = sname;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s38_display_visit_history` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s38_display_visit_history`(IN
eName VARCHAR(100),
sName VARCHAR(50),
startDate DATE,
endDate DATE)
BEGIN
SELECT visitevent.VisitEventDate as Date, visitevent.EventName as Event, visitevent.SiteName as Site, event.EventPrice as Price
FROM visitEvent
JOIN event ON visitEvent.StartDate = Event.StartDate AND visitEvent.EventName = event.EventName AND visitEvent.SiteName = Event.SiteName
WHERE
CASE WHEN eName IS NULL
   THEN visitevent.EventName=visitevent.EventName
   ELSE visitevent.EventName LIKE CONCAT('%', eName, '%') END
   AND CASE WHEN sName IS NULL
   THEN visitevent.SiteName=visitevent.SiteName
   ELSE visitevent.SiteName = eName END
   AND visitEvent.VisitEventDate BETWEEN startDate AND endDate
UNION
SELECT visitsite.VisitSiteDate as Date, visitsite.SiteName as Site, 0 as Price, NULL as Event
FROM visitSite
JOIN event ON visitSite.SiteName = Event.SiteName
WHERE
CASE WHEN sName IS NULL
   THEN visitsite.SiteName=visitsite.SiteName
   ELSE visitsite.SiteName = sName END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `s38_get_sites` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `s38_get_sites`()
BEGIN
SELECT DISTINCT SiteName from site;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-23 10:46:34
