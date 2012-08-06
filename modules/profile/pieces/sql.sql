-- phpMyAdmin SQL Dump
-- version 3.3.9.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 02, 2012 at 12:17 PM
-- Server version: 5.5.9
-- PHP Version: 5.3.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `profile`
--

-- --------------------------------------------------------

--
-- Table structure for table `AUTH_Users`
--

CREATE TABLE `AUTH_Users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `preferredContact` enum('phone','email','none') DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `AUTH_Users`
--


-- --------------------------------------------------------

--
-- Table structure for table `GOALS_data`
--

CREATE TABLE `GOALS_data` (
  `goal_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` mediumtext,
  `category` int(11) DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`goal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `GOALS_data`
--


-- --------------------------------------------------------

--
-- Table structure for table `GOALS_map`
--

CREATE TABLE `GOALS_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goal_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `completion_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `goal_id` (`goal_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `GOALS_map`
--


-- --------------------------------------------------------

--
-- Table structure for table `NOTIFICATION_Pending`
--

CREATE TABLE `NOTIFICATION_Pending` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(12) DEFAULT NULL,
  `message` varchar(140) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `emailSubject` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`notification_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `NOTIFICATION_Pending`
--


-- --------------------------------------------------------

--
-- Table structure for table `NOTIFICIATION_Archive`
--

CREATE TABLE `NOTIFICIATION_Archive` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(12) DEFAULT NULL,
  `message` varchar(140) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `emailSubject` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`notification_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `NOTIFICIATION_Archive`
--


-- --------------------------------------------------------

--
-- Table structure for table `PROFILE`
--

CREATE TABLE `PROFILE` (
  `profile_id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `last_accessed` datetime DEFAULT NULL,
  PRIMARY KEY (`profile_id`),
  KEY `owner_id` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `PROFILE`
--


-- --------------------------------------------------------

--
-- Table structure for table `PROFILE_Bathroom`
--

CREATE TABLE `PROFILE_Bathroom` (
  `bathroom_id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) DEFAULT NULL,
  `hairdryer` int(11) DEFAULT NULL,
  `shower_count` int(11) DEFAULT NULL,
  `shower_avgtemp` int(11) DEFAULT NULL,
  `shower_avgtime` int(11) DEFAULT NULL,
  `shower_pressure` int(11) DEFAULT NULL,
  `bath_count` int(11) DEFAULT NULL,
  `bath_avgtemp` int(11) DEFAULT NULL,
  `hasFan` bit(1) DEFAULT NULL,
  PRIMARY KEY (`bathroom_id`),
  KEY `profile_id` (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `PROFILE_Bathroom`
--


-- --------------------------------------------------------

--
-- Table structure for table `PROFILE_Electronics_defaults`
--

CREATE TABLE `PROFILE_Electronics_defaults` (
  `electronics_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `consumption` int(11) DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`electronics_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `PROFILE_Electronics_defaults`
--


-- --------------------------------------------------------

--
-- Table structure for table `PROFILE_Electronics_map`
--

CREATE TABLE `PROFILE_Electronics_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) DEFAULT NULL,
  `electronics_id` int(11) DEFAULT NULL,
  `usage` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `profile_id` (`profile_id`),
  KEY `electronics_id` (`electronics_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `PROFILE_Electronics_map`
--


-- --------------------------------------------------------

--
-- Table structure for table `PROFILE_Home`
--

CREATE TABLE `PROFILE_Home` (
  `home_id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) DEFAULT NULL,
  `hasBasic` bit(1) DEFAULT NULL,
  `hasLights` bit(1) DEFAULT NULL,
  `hasHeating` bit(1) DEFAULT NULL,
  `hasCooling` bit(1) DEFAULT NULL,
  `hasWater` bit(1) DEFAULT NULL,
  PRIMARY KEY (`home_id`),
  KEY `profile_id` (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `PROFILE_Home`
--


-- --------------------------------------------------------

--
-- Table structure for table `PROFILE_Home_basic`
--

CREATE TABLE `PROFILE_Home_basic` (
  `basic_id` int(11) NOT NULL AUTO_INCREMENT,
  `home_id` int(11) DEFAULT NULL,
  `residents` int(11) DEFAULT NULL,
  `window_type` enum('awning','casement','doublehung','picture','bay') DEFAULT NULL,
  `window_size` int(11) DEFAULT NULL,
  `window_pane_type` enum('insulated','regular') DEFAULT NULL,
  PRIMARY KEY (`basic_id`),
  KEY `home_id` (`home_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `PROFILE_Home_basic`
--


-- --------------------------------------------------------

--
-- Table structure for table `PROFILE_Home_cooling`
--

CREATE TABLE `PROFILE_Home_cooling` (
  `cooling_id` int(11) NOT NULL AUTO_INCREMENT,
  `home_id` int(11) DEFAULT NULL,
  `type` enum('default') DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `location` enum('basement','inside','outside') DEFAULT NULL,
  `temp` int(11) DEFAULT NULL,
  PRIMARY KEY (`cooling_id`),
  KEY `home_id` (`home_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `PROFILE_Home_cooling`
--


-- --------------------------------------------------------

--
-- Table structure for table `PROFILE_Home_heating`
--

CREATE TABLE `PROFILE_Home_heating` (
  `heating_id` int(11) NOT NULL AUTO_INCREMENT,
  `home_id` int(11) DEFAULT NULL,
  `type` enum('oil','heatpump','wood','electric') DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `location` enum('basement','outside','other') DEFAULT NULL,
  `temp` int(11) DEFAULT NULL,
  `has_fan` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`heating_id`),
  KEY `home_id` (`home_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `PROFILE_Home_heating`
--


-- --------------------------------------------------------

--
-- Table structure for table `PROFILE_Home_lights`
--

CREATE TABLE `PROFILE_Home_lights` (
  `light_id` int(11) NOT NULL AUTO_INCREMENT,
  `home_id` int(11) DEFAULT NULL,
  `cfl_count` int(11) DEFAULT NULL,
  `cfl_avg` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `avg` int(11) DEFAULT NULL,
  PRIMARY KEY (`light_id`),
  KEY `home_id` (`home_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `PROFILE_Home_lights`
--


-- --------------------------------------------------------

--
-- Table structure for table `PROFILE_Home_water`
--

CREATE TABLE `PROFILE_Home_water` (
  `water_id` int(11) NOT NULL AUTO_INCREMENT,
  `home_id` int(11) DEFAULT NULL,
  `type` enum('gas','electric','other') DEFAULT NULL,
  `location` enum('PLACEHOLDER') DEFAULT NULL,
  `age` enum('old','new','unknown') DEFAULT NULL,
  `temperature` int(11) DEFAULT NULL,
  PRIMARY KEY (`water_id`),
  KEY `home_id` (`home_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `PROFILE_Home_water`
--


-- --------------------------------------------------------

--
-- Table structure for table `PROFILE_Hottub`
--

CREATE TABLE `PROFILE_Hottub` (
  `hottub_id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) DEFAULT NULL,
  `weekly_use` int(11) DEFAULT NULL,
  `start_time` date DEFAULT NULL,
  `end_time` date DEFAULT NULL,
  PRIMARY KEY (`hottub_id`),
  KEY `profile_id` (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `PROFILE_Hottub`
--


-- --------------------------------------------------------

--
-- Table structure for table `PROFILE_Kitchen`
--

CREATE TABLE `PROFILE_Kitchen` (
  `kitchen_id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) DEFAULT NULL,
  `hasFridge` bit(1) DEFAULT NULL,
  `hasFreezer` bit(1) DEFAULT NULL,
  `hasDishwasher` bit(1) DEFAULT NULL,
  `doesHandwash` bit(1) DEFAULT NULL,
  `hasStove` bit(1) DEFAULT NULL,
  `hasMicrowave` bit(1) DEFAULT NULL,
  `hasToaster` bit(1) DEFAULT NULL,
  PRIMARY KEY (`kitchen_id`),
  KEY `profile_id` (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `PROFILE_Kitchen`
--


-- --------------------------------------------------------

--
-- Table structure for table `PROFILE_Kitchen_dishwasher`
--

CREATE TABLE `PROFILE_Kitchen_dishwasher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kitchen_id` int(11) DEFAULT NULL,
  `dishwasher_id` int(11) DEFAULT NULL,
  `isCustom` bit(1) DEFAULT NULL,
  `consumption` decimal(10,0) DEFAULT NULL,
  `capacity` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kitchen_id` (`kitchen_id`),
  KEY `dishwasher_id` (`dishwasher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `PROFILE_Kitchen_dishwasher`
--


-- --------------------------------------------------------

--
-- Table structure for table `PROFILE_Kitchen_freezer`
--

CREATE TABLE `PROFILE_Kitchen_freezer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kitchen_id` int(11) DEFAULT NULL,
  `freezer_id` int(11) DEFAULT NULL,
  `isCustom` bit(1) DEFAULT NULL,
  `consumption` decimal(10,0) DEFAULT NULL,
  `capacity` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kitchen_id` (`kitchen_id`),
  KEY `freezer_id` (`freezer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `PROFILE_Kitchen_freezer`
--


-- --------------------------------------------------------

--
-- Table structure for table `PROFILE_Kitchen_fridge`
--

CREATE TABLE `PROFILE_Kitchen_fridge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kitchen_id` int(11) DEFAULT NULL,
  `fridge_id` int(11) DEFAULT NULL,
  `isCustom` bit(1) DEFAULT NULL,
  `consumption` decimal(10,0) DEFAULT NULL,
  `capacity` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kitchen_id` (`kitchen_id`),
  KEY `fridge_id` (`fridge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `PROFILE_Kitchen_fridge`
--


-- --------------------------------------------------------

--
-- Table structure for table `PROFILE_Kitchen_microwave`
--

CREATE TABLE `PROFILE_Kitchen_microwave` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kitchen_id` int(11) DEFAULT NULL,
  `avgusage` int(11) DEFAULT NULL,
  `consumption` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kitchen_id` (`kitchen_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `PROFILE_Kitchen_microwave`
--


-- --------------------------------------------------------

--
-- Table structure for table `PROFILE_Kitchen_stove`
--

CREATE TABLE `PROFILE_Kitchen_stove` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kitchen_id` int(11) DEFAULT NULL,
  `stove_id` int(11) DEFAULT NULL,
  `avgusage` int(11) DEFAULT NULL,
  `isCustom` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kitchen_id` (`kitchen_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `PROFILE_Kitchen_stove`
--


-- --------------------------------------------------------

--
-- Table structure for table `PROFILE_Kitchen_toaster`
--

CREATE TABLE `PROFILE_Kitchen_toaster` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kitchen_id` int(11) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kitchen_id` (`kitchen_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `PROFILE_Kitchen_toaster`
--


-- --------------------------------------------------------

--
-- Table structure for table `PROFILE_Laundry`
--

CREATE TABLE `PROFILE_Laundry` (
  `laundry_id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) DEFAULT NULL,
  `washer_id` int(11) DEFAULT NULL,
  `washer_avg_loads` int(11) DEFAULT NULL,
  `washer_type` int(11) DEFAULT NULL,
  `washer_year` int(11) DEFAULT NULL,
  `washer_isCustom` bit(1) DEFAULT NULL,
  `washer_consumption` decimal(10,0) DEFAULT NULL,
  `washer_capacity` decimal(10,0) DEFAULT NULL,
  `dryer_id` int(11) DEFAULT NULL,
  `dryer_avg_loads` int(11) DEFAULT NULL,
  `dryer_type` int(11) DEFAULT NULL,
  `dryer_year` int(11) DEFAULT NULL,
  `dryer_isCustom` bit(1) DEFAULT NULL,
  `dryer_consumption` int(11) DEFAULT NULL,
  `dryer_capacity` int(11) DEFAULT NULL,
  PRIMARY KEY (`laundry_id`),
  KEY `profile_id` (`profile_id`),
  KEY `washer_id` (`washer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `PROFILE_Laundry`
--


-- --------------------------------------------------------

--
-- Table structure for table `PROFILE_Pool`
--

CREATE TABLE `PROFILE_Pool` (
  `pool_id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) DEFAULT NULL,
  `isHeated` bit(1) DEFAULT NULL,
  `heater_age` int(11) DEFAULT NULL,
  `size` decimal(10,0) DEFAULT NULL,
  `start_time` date DEFAULT NULL,
  `end_time` date DEFAULT NULL,
  PRIMARY KEY (`pool_id`),
  KEY `profile_id` (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `PROFILE_Pool`
--


-- --------------------------------------------------------

--
-- Table structure for table `REPO_Devices_ac`
--

CREATE TABLE `REPO_Devices_ac` (
  `ac_id` int(11) NOT NULL AUTO_INCREMENT,
  `brand` varchar(50) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `consumption` decimal(10,0) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `type` bit(1) DEFAULT NULL,
  PRIMARY KEY (`ac_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='- Consumption: Watts\n- Capacity: BTU\n- Type: 0 or 1 (Windo' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `REPO_Devices_ac`
--


-- --------------------------------------------------------

--
-- Table structure for table `REPO_Devices_dishwasher`
--

CREATE TABLE `REPO_Devices_dishwasher` (
  `dishwasher_id` int(11) NOT NULL AUTO_INCREMENT,
  `brand` varchar(50) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `consumption` decimal(10,0) DEFAULT NULL,
  `capacity` bit(1) DEFAULT NULL,
  PRIMARY KEY (`dishwasher_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='- Consumption: kWhr/year\n- Capacity: 0 or 1 (Compact or Sta' AUTO_INCREMENT=546 ;

--
-- Dumping data for table `REPO_Devices_dishwasher`
--

INSERT INTO `REPO_Devices_dishwasher` VALUES(1, 'DCS by Fisher & Paykel', 'DD124* V2', 154, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(2, 'Fisher & Paykel', 'DD24S* V2', 154, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(3, 'KitchenAid', 'KUDD03ST', 174, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(4, 'Haier', 'HDC1804**', 200, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(5, 'Avanti', 'DW6PS', 220, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(6, 'Avanti', 'DW6W', 220, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(7, 'Haier', 'HDC2406**', 220, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(8, 'Bosch', 'SHE8ER5#UC', 180, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(9, 'Bosch', 'SHX8ER5#UC', 180, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(10, 'Bosch ', 'SHE68E05UC', 180, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(11, 'Bosch ', 'SHE68E15UC', 180, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(12, 'Bosch ', 'SHV68E13UC', 180, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(13, 'Bosch ', 'SHX68E05UC', 180, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(14, 'Bosch ', 'SHX68E15UC', 180, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(15, 'Gaggenau', 'DF260760', 180, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(16, 'Gaggenau', 'DF261760', 180, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(17, 'Bosch', 'SHX98M0#UC', 190, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(18, 'Bosch', 'SHE9ER5#UC', 200, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(19, 'Bosch', 'SHV9ER5#UC', 200, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(20, 'Bosch', 'SHX9ER5#UC', 200, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(21, 'Bosch', 'SGE63E1#UC', 234, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(22, 'Bosch', 'SHE68R5#UC', 234, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(23, 'Bosch', 'SHV68R5#UC', 234, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(24, 'Bosch', 'SHX68R5#UC', 234, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(25, 'Bosch ', 'SGE63E0#UC', 234, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(26, 'Bosch ', 'SHE68P0#UC', 234, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(27, 'Bosch ', 'SHV68P03UC', 234, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(28, 'Bosch ', 'SHX68P05UC', 234, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(29, 'Kenmore', '1303*K***', 254, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(30, 'Kenmore', '1304*K***', 254, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(31, 'Kenmore', '1327*K***', 254, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(32, 'Kenmore', '1328*K***', 254, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(33, 'Kenmore', '1503*K***', 254, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(34, 'Kenmore', '1504*K***', 254, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(35, 'Bosch', 'SHE23R5#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(36, 'Bosch', 'SHE43P2#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(37, 'Bosch', 'SHE43R5#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(38, 'Bosch', 'SHE43RF#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(39, 'Bosch', 'SHE43RL#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(40, 'Bosch', 'SHE55R5#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(41, 'Bosch', 'SHE7ER5#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(42, 'Bosch', 'SHV43R5#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(43, 'Bosch', 'SHV55R5#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(44, 'Bosch', 'SHV7ER5#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(45, 'Bosch', 'SHX33R5#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(46, 'Bosch', 'SHX33RF#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(47, 'Bosch', 'SHX33RL#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(48, 'Bosch', 'SHX43R5#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(49, 'Bosch', 'SHX55R5#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(50, 'Bosch', 'SHX55RL#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(51, 'Bosch', 'SHX58E2#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(52, 'Bosch', 'SHX7ER5#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(53, 'Bosch ', 'SHE33P0#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(54, 'Bosch ', 'SHE43F1#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(55, 'Bosch ', 'SHE43P0#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(56, 'Bosch ', 'SHE43P1#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(57, 'Bosch ', 'SHE55M1#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(58, 'Bosch ', 'SHE55P0#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(59, 'Bosch ', 'SHE65P0#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(60, 'Bosch ', 'SHV43P13UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(61, 'Bosch ', 'SHV58E13UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(62, 'Bosch ', 'SHV65P03UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(63, 'Bosch ', 'SHX43P1#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(64, 'Bosch ', 'SHX45L05UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(65, 'Bosch ', 'SHX45L15UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(66, 'Bosch ', 'SHX45P0#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(67, 'Bosch ', 'SHX58E15UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(68, 'Bosch ', 'SHX65P0#UC', 259, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(69, 'Thermador', 'DWHD650G##', 260, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(70, 'Thermador', 'DWHD651GFP', 260, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(71, 'Electrolux', 'EIDW5905 * * * A', 264, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(72, 'Viking', 'DDB325E', 271, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(73, 'Viking', 'DFB325E', 271, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(74, 'Viking', 'VDB325E', 271, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(75, 'Dacor', 'EDWH24S', 272, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(76, 'Dacor', 'IDWH24', 272, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(77, 'Fisher & Paykel', 'DD36 (#)', 272, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(78, 'Dacor', 'DDWF24S', 274, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(79, 'GE', 'GDWF100V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(80, 'GE', 'GDWF160V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(81, 'GE', 'GDWT106V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(82, 'GE', 'GDWT166V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(83, 'GE', 'GDWT368V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(84, 'GE', 'GDWT668V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(85, 'GE', 'GDWT708V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(86, 'GE', 'GDWT768V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(87, 'GE', 'GLD2800V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(88, 'GE', 'GLD4500V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(89, 'GE', 'GLD4560V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(90, 'GE', 'GLD4604V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(91, 'GE', 'GLD4664V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(92, 'GE', 'GLD5606V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(93, 'GE', 'GLD5664V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(94, 'GE', 'GLD5666V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(95, 'GE', 'GLD7708V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(96, 'GE', 'GLD7768V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(97, 'GE Café', 'CDWT980V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(98, 'GE Monogram', 'ZBD6920V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(99, 'GE Monogram', 'ZBD7920V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(100, 'GE Monogram', 'ZBD8920V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(101, 'GE Profile', 'PDW7800V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(102, 'GE Profile', 'PDW7880V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(103, 'GE Profile', 'PDWT180V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(104, 'GE Profile', 'PDWT200V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(105, 'GE Profile', 'PDWT280V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(106, 'GE Profile', 'PDWT380V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(107, 'GE Profile', 'PDWT480V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(108, 'GE Profile', 'PDWT500V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(109, 'GE Profile', 'PDWT580V00', 275, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(110, 'Viking', 'DDB450E', 276, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(111, 'Viking', 'DFB450E', 276, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(112, 'Viking', 'VDB450E', 276, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(113, 'DCS by Fisher & Paykel', 'DD224* V2', 278, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(114, 'Fisher & Paykel', 'DD24D* V2', 278, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(115, 'Bosch', 'SHE3AR5#UC', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(116, 'Bosch', 'SHE3AR7#UC', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(117, 'Bosch', 'SHE3ARF#UC', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(118, 'Bosch', 'SHE3ARL#UC', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(119, 'Bosch', 'SHX3AR5#UC', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(120, 'Bosch', 'SHX3AR7#UC', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(121, 'Bosch ', 'SHE4AM1#UC ', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(122, 'Bosch ', 'SHE5AL0#UC', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(123, 'Bosch ', 'SHE6AF0#UC', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(124, 'Bosch ', 'SHE6AP0#UC', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(125, 'Bosch ', 'SHE6AP1#UC', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(126, 'Bosch ', 'SHX4AP0#UC', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(127, 'Bosch ', 'SHX5AL0#UC', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(128, 'Bosch ', 'SHX6AP0#UC', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(129, 'JennAir', 'JDB3200AW**', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(130, 'KitchenAid', 'KUDE20FX***', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(131, 'KitchenAid', 'KUDE20IX***', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(132, 'KitchenAid', 'KUDE40FX***', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(133, 'KitchenAid', 'KUDE48FX***', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(134, 'KitchenAid', 'KUDE50CX***', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(135, 'KitchenAid', 'KUDE60FX***', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(136, 'KitchenAid', 'KUDE60HX***', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(137, 'KitchenAid', 'KUDE70FX***', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(138, 'KitchenAid', 'KUDL15FX***', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(139, 'Samsung', 'DMT400***  ', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(140, 'Samsung', 'DMT800***  ', 279, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(141, 'Miele', 'G2732', 281, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(142, 'Frigidaire', 'BGHD2433 * * *  ', 283, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(143, 'Frigidaire', 'DGHD2433 * * *  ', 283, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(144, 'Frigidaire', 'FGHD2433 * * *  ', 283, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(145, 'Frigidaire', 'FGHD2461 * * *  ', 283, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(146, 'Frigidaire', 'FGHD2471 * * *  ', 283, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(147, 'Frigidaire', 'FPHD2481 * * *  ', 283, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(148, 'Kenmore', '1531 * * * * A', 283, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(149, 'Avanti', 'DW182ESS', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(150, 'Avanti', 'DW183W', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(151, 'Avanti', 'DW184B', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(152, 'LG', 'LDF692#**', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(153, 'LG', 'LDF792***', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(154, 'LG', 'LDF793#**', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(155, 'LG', 'LDF881#**', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(156, 'LG', 'LDF892***', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(157, 'LG', 'LDF981#**', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(158, 'LG', 'LDF993#**', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(159, 'LG', 'LDS482#**', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(160, 'LG', 'LSDF795**', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(161, 'LG', 'LSDF995**', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(162, 'Miele', 'G 4205 ', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(163, 'Miele', 'G 4270', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(164, 'Miele', 'G 4275', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(165, 'Miele', 'G 4500 ', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(166, 'Miele', 'G 4570 ', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(167, 'Miele', 'G 5105 ', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(168, 'Miele', 'G 5175', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(169, 'Miele', 'G 5505 ', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(170, 'Miele', 'G 5570 ', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(171, 'Miele', 'G 5575 ', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(172, 'Miele', 'G 5705 ', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(173, 'Miele', 'G 5775 ', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(174, 'Miele', 'G 5915 ', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(175, 'Miele', 'G 5915 ', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(176, 'Miele', 'G1202', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(177, 'Miele', 'G1262', 285, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(178, 'Avanti', 'DW18', 286, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(179, 'Ikea', 'IUD9500W**', 288, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(180, 'Ikea', 'IUD9750W**', 288, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(181, 'KitchenAid', 'KUDC10FX***', 288, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(182, 'KitchenAid', 'KUDC10IX***', 288, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(183, 'KitchenAid', 'KUDS30CX***', 288, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(184, 'KitchenAid', 'KUDS30FX***', 288, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(185, 'KitchenAid', 'KUDS30IX***', 288, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(186, 'KitchenAid', 'KUDS35FX***', 288, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(187, 'Miele', 'G1182', 289, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(188, 'Miele', 'G1472', 289, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(189, 'Samsung', 'DMR78***', 289, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(190, 'Blomberg', 'DWT 37200 NBL00', 290, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(191, 'Blomberg', 'DWT 37220 NBL00', 290, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(192, 'Blomberg', 'DWT 37240 NBL00', 290, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(193, 'Blomberg', 'DWT 37300 NBL00', 290, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(194, 'Blomberg', 'DWT 37310 NBL00', 290, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(195, 'Blomberg', 'DWT 37320 NBL00', 290, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(196, 'Blomberg', 'DWT 37340 NBL00', 290, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(197, 'Gaggenau', 'DF 251 760', 290, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(198, 'Kenmore', '1392*K***', 290, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(199, 'Kenmore', '1393*K***', 290, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(200, 'Kenmore', '1394*K***', 290, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(201, 'Kenmore', '1396*K***', 290, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(202, 'Kenmore', '1397*K***', 290, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(203, 'Kenmore', '1404*K***', 290, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(204, 'Maytag', 'MDB7749AW**', 291, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(205, 'Maytag', 'MDB7759AW**', 291, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(206, 'Maytag', 'MDB7760AW**', 291, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(207, 'Maytag', 'MDB8859AW**', 291, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(208, 'Maytag', 'MDB8959AW**', 291, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(209, 'Whirlpool', 'GU3200XTX**', 291, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(210, 'JennAir', 'JDB3600AW**', 292, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(211, 'JennAir', 'JDB3650AW**', 292, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(212, 'Miele', 'G2142', 292, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(213, 'Miele', 'G2143', 292, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(214, 'Miele', 'G2182', 292, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(215, 'Miele', 'G2183', 292, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(216, 'Viking', 'DDB200', 293, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(217, 'Viking', 'FDB200', 293, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(218, 'Viking', 'VDB200', 293, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(219, 'LG', 'LDF681#**', 294, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(220, 'LG', 'LDF781#**', 294, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(221, 'LG', 'LDS581#**', 294, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(222, 'Haier', 'DWL3025****', 295, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(223, 'Haier', 'DWL3525****', 295, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(224, 'Haier', 'DWL4035****', 295, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(225, 'Haier', 'DWL7075****', 295, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(226, 'Kenmore', '1774*K***', 296, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(227, 'Whirlpool', 'DP1040XTX**', 296, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(228, 'Miele', 'G2432', 297, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(229, 'Miele', 'G2472', 297, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(230, 'Miele', 'G2832', 298, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(231, 'Miele', 'G2872', 298, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(232, 'Electrolux', 'EDW7505 * * * A', 299, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(233, 'Electrolux', 'EIDW6105 * * * A', 299, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(234, 'Electrolux', 'EIDW6305 * * * A', 299, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(235, 'Electrolux', 'EIDW6405 * * * A', 299, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(236, 'Samsung', 'DMT300***', 299, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(237, 'Whirlpool', 'GU2800XTV**', 299, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(238, 'Amana', 'ADB1400AW**', 300, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(239, 'Crosley', 'CUD6710X**', 300, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(240, 'Estate', 'TUD8700X**', 300, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(241, 'Kenmore', '1318*', 300, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(242, 'Magic Chef', 'CDB7000AW**', 300, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(243, 'Maytag', 'MBD4630AW**', 300, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(244, 'Whirlpool', 'DU1010XTX**', 300, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(245, 'Whirlpool', 'DU1014XTX**', 300, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(246, 'Whirlpool', 'DU1015XTX**', 300, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(247, 'Whirlpool', 'DU1030XTX**', 300, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(248, 'GE', 'GLD5860P10', 301, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(249, 'GE', 'GSC3500R00', 301, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(250, 'GE', 'GSD2300R00', 301, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(251, 'GE', 'GSD2301R15', 301, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(252, 'GE', 'GSD2340R00', 301, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(253, 'GE', 'GSD2350R00', 301, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(254, 'GE', 'GSD3300R15', 301, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(255, 'GE', 'GSD3360R15', 301, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(256, 'GE Profile', 'PDWF788P10', 301, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(257, 'Hotpoint', 'HDA3600R00', 301, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(258, 'Hotpoint', 'HDA3640R00', 301, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(259, 'Kenmore', '1310*K***', 301, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(260, 'Whirlpool', 'GU3600XTV**', 301, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(261, 'GE', 'GLD2800T05', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(262, 'GE', 'GLD2850T05', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(263, 'GE', 'GLD4404R00', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(264, 'GE', 'GLD4406R00', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(265, 'GE', 'GLD4408R00', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(266, 'GE', 'GLD4456R00', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(267, 'GE', 'GLD4458R00', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(268, 'GE', 'GLD4464R00', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(269, 'GE', 'GLD4466R00', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(270, 'GE', 'GLD4468R00', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(271, 'GE', 'GLD4500R00', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(272, 'GE', 'GLD4550R00', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(273, 'GE', 'GLD4560R00', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(274, 'GE', 'GLD4908T05', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(275, 'GE', 'GLD4968T05', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(276, 'GE', 'GLD5600R00', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(277, 'GE', 'GLD5660R00', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(278, 'Kenmore', '1405*K***', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(279, 'Kenmore', '1406*K***', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(280, 'KitchenAid', 'KUDE60SX***', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(281, 'KitchenAid', 'KUDS30SX***', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(282, 'Maytag', 'MDB4709AW**', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(283, 'Maytag', 'MDB6709AW**', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(284, 'Maytag', 'MDB6769AW**', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(285, 'Maytag', 'MDBH949AW**', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(286, 'Maytag', 'MDBH969AW**', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(287, 'Maytag', 'MDBTT53AW**', 302, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(288, 'Blomberg', 'DW 14110 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(289, 'Blomberg', 'DW 14120 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(290, 'Blomberg', 'DW 14140 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(291, 'Blomberg', 'DW 15110 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(292, 'Blomberg', 'DW 15111 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(293, 'Blomberg', 'DW 15120 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(294, 'Blomberg', 'DW 15121 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(295, 'Blomberg', 'DW 15140 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(296, 'Blomberg', 'DW 15141 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(297, 'Blomberg', 'DW 34100 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(298, 'Blomberg', 'DW 34110 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(299, 'Blomberg', 'DW 34120 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(300, 'Blomberg', 'DW 34140 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(301, 'Blomberg', 'DW 35100 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(302, 'Blomberg', 'DW 35110 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(303, 'Blomberg', 'DW 35120 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(304, 'Blomberg', 'DW 35140 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(305, 'Blomberg', 'DW 36110 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(306, 'Blomberg', 'DW 36120 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(307, 'Blomberg', 'DW 36140 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(308, 'Blomberg', 'DWT 14210 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(309, 'Blomberg', 'DWT 14220 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(310, 'Blomberg', 'DWT 14240 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(311, 'Blomberg', 'DWT 14410 ULTRA', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(312, 'Blomberg', 'DWT 14420 ULTRA', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(313, 'Blomberg', 'DWT 14440 ULTRA', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(314, 'Blomberg', 'DWT 15210 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(315, 'Blomberg', 'DWT 15211 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(316, 'Blomberg', 'DWT 15220 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(317, 'Blomberg', 'DWT 15221 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(318, 'Blomberg', 'DWT 15240 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(319, 'Blomberg', 'DWT 15241 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(320, 'Blomberg', 'DWT 34200 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(321, 'Blomberg', 'DWT 34210 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(322, 'Blomberg', 'DWT 34220 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(323, 'Blomberg', 'DWT 34240 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(324, 'Blomberg', 'DWT 34400 ULTRA', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(325, 'Blomberg', 'DWT 34410 ULTRA', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(326, 'Blomberg', 'DWT 34420 ULTRA', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(327, 'Blomberg', 'DWT 34440 ULTRA', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(328, 'Blomberg', 'DWT 34500 CARRERA', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(329, 'Blomberg', 'DWT 34510 CARRERA', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(330, 'Blomberg', 'DWT 34520 CARRERA', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(331, 'Blomberg', 'DWT 34540 CARRERA', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(332, 'Blomberg', 'DWT 35200 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(333, 'Blomberg', 'DWT 35210 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(334, 'Blomberg', 'DWT 35220 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(335, 'Blomberg', 'DWT 35240 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(336, 'Blomberg', 'DWT 36200 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(337, 'Blomberg', 'DWT 36201 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(338, 'Blomberg', 'DWT 36210 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(339, 'Blomberg', 'DWT 36211 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(340, 'Blomberg', 'DWT 36220 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(341, 'Blomberg', 'DWT 36221 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(342, 'Blomberg', 'DWT 36240 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(343, 'Blomberg', 'DWT 36241 NBL00', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(344, 'Electrolux', 'EWDW6505 * * * B', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(345, 'Frigidaire', 'FFBD2405 * * * A', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(346, 'Kenmore', '1536 * * * * A', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(347, 'Porter&Charles', 'DWPC4FCSS', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(348, 'Porter&Charles', 'DWPC6FI', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(349, 'Porter&Charles', 'DWPC6SS', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(350, 'Porter&Charles', 'DWTPC6FI', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(351, 'Summit Professional', 'DW2432', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(352, 'Summit Professional', 'DW2432SS', 303, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(353, 'Maytag', 'MDB7609AW**', 304, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(354, 'Maytag', 'MDB7709AW**', 304, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(355, 'Maytag', 'MDB7809AW**', 304, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(356, 'Maytag', 'MDBH979AW**', 304, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(357, 'Maytag', 'MDBH989AW**', 304, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(358, 'Whirlpool', 'GU3000XTX**', 304, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(359, 'GE', 'GSD2100R00', 305, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(360, 'GE', 'GSD2101R15', 305, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(361, 'Hotpoint', 'HDA2100R00', 305, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(362, 'Kenmore', '1315*K', 305, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(363, 'Kenmore', '1319*K***', 305, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(364, 'Kenmore', '1320*K***', 305, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(365, 'Thermador', 'DWHD630G##', 305, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(366, 'Bosch', 'SRV53C13UC', 306, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(367, 'Bosch', 'SRX53C15UC', 306, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(368, 'Ikea', 'IUD4000W**', 306, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(369, 'Ikea', 'IUD6000W**', 306, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(370, 'Inglis', 'IPU2536*', 306, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(371, 'Kenmore', '630.1390#.01#', 306, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(372, 'Kenmore', '630.1391#.01#', 306, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(373, 'Kenmore', '630.1395#.01# ', 306, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(374, 'Kenmore', '630.13993.01#', 306, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(375, 'Kenmore', '1345*K***', 306, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(376, 'Kenmore', '1421*K***', 306, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(377, 'Maytag', 'MDB3601BWB', 306, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(378, 'Thermador', 'DWHD410H##', 306, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(379, 'Whirlpool', 'DU810SWP**', 306, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(380, 'Whirlpool', 'DU811SWP**', 306, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(381, 'Whirlpool', 'DU850SWP**', 306, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(382, 'Bosch ', 'SHE55C0#UC', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(383, 'GE', 'GSC3500V00', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(384, 'GE', 'GSD2100V00', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(385, 'GE', 'GSD2101V00', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(386, 'GE', 'GSD2300V00', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(387, 'GE', 'GSD2301V00', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(388, 'GE', 'GSD2340V00', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(389, 'GE', 'GSD2350V00', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(390, 'GE', 'GSD3300V00', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(391, 'GE', 'GSD3360V00', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(392, 'GE', 'GSD4000V00', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(393, 'GE', 'GSD4060V00', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(394, 'GE', 'GSM2200V00', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(395, 'GE Monogram', 'ZBD6900P10', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(396, 'GE Monogram', 'ZBD6920P10', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(397, 'GE Monogram', 'ZBD7920P10', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(398, 'GE Monogram', 'ZBD8920P10', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(399, 'Hotpoint', 'HDA2000V00', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(400, 'Hotpoint', 'HDA2100V00', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(401, 'Hotpoint', 'HDA3600V00', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(402, 'JennAir', 'JDB3000AW**', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(403, 'Kenmore', '1301*K***', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(404, 'Kenmore', '1302*K***', 307, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(405, 'Whirlpool', 'GU3200XTV**', 308, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(406, 'Crosley', 'CDB400 * * * A', 309, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(407, 'Crosley', 'CDB600 * * * A', 309, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(408, 'Frigidaire', 'FDB1100 * * * * A', 309, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(409, 'Frigidaire', 'FDB4315LF', 309, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(410, 'Frigidaire', 'FDB520 * * * * A', 309, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(411, 'Frigidaire', 'FDBB4365 * * *', 309, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(412, 'Frigidaire', 'FFBD2403 * * * B', 309, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(413, 'Frigidaire', 'FFBD2407 * * * B', 309, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(414, 'Kelvinator', 'KABD2405 * * * A', 309, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(415, 'Kenmore', '1523 * * * * A', 309, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(416, 'Amana', 'ADB1000AW**', 310, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(417, 'Crosely', 'CUD4000W**', 310, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(418, 'Estate', 'TUD4700W**', 310, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(419, 'Inglis', 'IWU2236*', 310, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(420, 'Kenmore', '1772*K***', 310, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(421, 'Magic Chef', 'CDB4000AW**', 310, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(422, 'Samsung', 'DMR57***', 310, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(423, 'Samsung', 'DMR77***', 310, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(424, 'Whirlpool', 'DU400SWW**', 310, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(425, 'Miele', 'G7856', 311, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(426, 'Crosley', 'CUD6710W**', 312, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(427, 'Estate', 'TUD6710W**', 312, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(428, 'Kenmore', '1312*K***', 312, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(429, 'Kenmore', '1340*K***', 312, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(430, 'Kenmore', '1344*K***', 312, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(431, 'Kenmore', '1773*K***', 312, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(432, 'Kenmore', '7796*K***', 312, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(433, 'Kenmore', '7797*K***', 312, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(434, 'Whirlpool', 'DU915PWW**', 312, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(435, 'Whirlpool', 'DU930PWW**', 312, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(436, 'Whirlpool', 'DU945PWW**', 312, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(437, 'Kenmore', '1316*K***', 313, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(438, 'Kenmore', '1317*K***', 313, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(439, 'Kenmore', '7798*K***', 313, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(440, 'Whirlpool', 'DU1055XTV**', 313, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(441, 'Whirlpool', 'DU1061XTV**', 313, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(442, 'Whirlpool', 'DU1300XTV**', 313, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(443, 'Whirlpool', 'DU1301XTV**', 313, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(444, 'Whirlpool', 'DU1345XTV**', 313, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(445, 'Kenmore', '1321*K***', 315, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(446, 'Kenmore', '1324*K***', 315, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(447, 'Frigidaire', 'DGBD2432 * * * ', 316, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(448, 'Frigidaire', 'FGBD2432 * * * ', 316, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(449, 'Frigidaire', 'FGBD2451 * * * ', 316, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(450, 'GE', 'GSD4000R00', 316, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(451, 'GE', 'GSD4060R15', 316, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(452, 'Kenmore', '1538 * * * * A', 316, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(453, 'Lowe''s', 'LGBD2432 * * * A', 316, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(454, 'Amana', 'ADB1600AW**', 317, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(455, 'Maytag', 'MDC4809AW**', 317, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(456, 'Frigidaire', 'FDB1450 * * * *', 318, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(457, 'Frigidaire', 'FDB1502 * * * *', 318, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(458, 'Frigidaire', 'FFBD2409 * * * A', 318, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(459, 'GE Profile', 'PDWT280P00', 318, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(460, 'Kenmore', '1526 * * * *  ', 318, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(461, 'Lowe''s', 'LFBD2409 * * * A', 318, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(462, 'Estate', 'TUD8700W**', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(463, 'Frigidaire', 'FGBD2431 * * *  ', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(464, 'Ikea', 'IUD8000W**', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(465, 'Inglis', 'IWU9866*', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(466, 'Kenmore', '1537 * * * * A', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(467, 'Kenmore', '1322*K***', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(468, 'Kenmore', '1346*K***', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(469, 'Kenmore', '1347*K***', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(470, 'Kenmore', '1348*K***', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(471, 'Kenmore', '1357*K***', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(472, 'Kenmore', '1358*K***', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(473, 'Kenmore', '1363*K***', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(474, 'Kenmore', '1373*K***', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(475, 'Kenmore', '1374*K***', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(476, 'Kenmore', '1383*K***', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(477, 'Kenmore', '1384*K***', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(478, 'Kenmore', '1389*K*', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(479, 'Kenmore', '7792*K***', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(480, 'Lowe''s', 'LGBD2431 * * * A', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(481, 'Whirlpool', 'GU2275XTV**', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(482, 'Whirlpool', 'GU2300XTV**', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(483, 'Whirlpool', 'GU2475XTV**', 320, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(484, 'GE', 'GDWF100R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(485, 'GE', 'GDWF160R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(486, 'GE', 'GDWT200R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(487, 'GE', 'GDWT260R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(488, 'GE', 'GDWT300R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(489, 'GE', 'GDWT360R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(490, 'GE', 'GLD6904R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(491, 'GE', 'GLD6906R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(492, 'GE', 'GLD6908R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(493, 'GE', 'GLD6964R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(494, 'GE', 'GLD6966R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(495, 'GE', 'GLD6968R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(496, 'GE', 'GLD7400R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(497, 'GE', 'GLD7460R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(498, 'GE Adora', 'GHDF360R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(499, 'GE Café', 'CDWT980R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(500, 'GE Profile', 'PDWF600R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(501, 'GE Profile', 'PDWF680R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(502, 'GE Profile', 'PDWF800R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(503, 'GE Profile', 'PDWF880R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(504, 'GE Profile', 'PDWT100R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(505, 'GE Profile', 'PDWT180R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(506, 'GE Profile', 'PDWT300R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(507, 'GE Profile', 'PDWT380R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(508, 'GE Profile', 'PDWT400R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(509, 'GE Profile', 'PDWT480R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(510, 'GE Profile', 'PDWT500R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(511, 'GE Profile', 'PDWT502R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(512, 'GE Profile', 'PDWT580R10', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(513, 'JennAir', 'JDD4000', 321, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(514, 'GE', 'GDWT100R00', 322, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(515, 'GE', 'GDWT160R05', 322, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(516, 'GE Profile', 'PDW7800P00', 322, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(517, 'GE Profile', 'PDW7880P00', 322, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(518, 'GE Profile', 'PDWT505T10', 322, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(519, 'GE Profile', 'PDWT585T10', 322, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(520, 'GE', 'GLC4400R05', 324, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(521, 'GE', 'GLD3806T05', 324, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(522, 'GE', 'GLD3846T05', 324, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(523, 'GE', 'GLD3866T05', 324, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(524, 'GE Profile', 'PDW7800R10', 324, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(525, 'GE Profile', 'PDW7880R10', 324, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(526, 'Hotpoint', 'HDA2000T00', 324, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(527, 'Moffat', 'MSD2100R15', 324, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(528, 'Kenmore', '1311*K***', 326, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(529, 'Kenmore', '1343*K***', 326, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(530, 'Frigidaire', 'FDB700BF', 328, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(531, 'Frigidaire', 'FDB2400 * * * A', 330, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(532, 'GE', 'GSD1300N10', 330, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(533, 'GE Americana', 'ADW1100N00', 330, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(534, 'Hotpoint', 'HDA1100N15', 330, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(535, 'Hotpoint', 'HDA2100N10', 330, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(536, 'Kenmore', '1401 * * * * A', 330, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(537, 'Tappan', 'TDB210 * * * * A', 330, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(538, 'White-Westinghouse', 'WWBD2400 * * * A', 330, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(539, 'GE', 'GSM2200N15', 333, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(540, 'GE', 'GSM2260N15', 333, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(541, 'GE', 'GSD4000N20', 337, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(542, 'KitchenAid', 'KUDD03DT', 339, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(543, 'KitchenAid', 'KUDH03DT', 339, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(544, 'Maytag', 'MDD8000', 339, '');
INSERT INTO `REPO_Devices_dishwasher` VALUES(545, 'GE', 'GLC4100N14', 341, '');

-- --------------------------------------------------------

--
-- Table structure for table `REPO_Devices_freezer`
--

CREATE TABLE `REPO_Devices_freezer` (
  `freezer_id` int(11) NOT NULL AUTO_INCREMENT,
  `brand` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `consumption` decimal(10,0) DEFAULT NULL,
  `capacity` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`freezer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `REPO_Devices_freezer`
--


-- --------------------------------------------------------

--
-- Table structure for table `REPO_Devices_fridge`
--

CREATE TABLE `REPO_Devices_fridge` (
  `fridge_id` int(11) NOT NULL AUTO_INCREMENT,
  `brand` varchar(50) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `consumption` decimal(10,0) DEFAULT NULL,
  `capacity` decimal(10,0) DEFAULT NULL,
  `type` bit(1) DEFAULT NULL,
  PRIMARY KEY (`fridge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='- Consumption: kWhr/year\n- Capacity: Cubic Feet' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `REPO_Devices_fridge`
--


-- --------------------------------------------------------

--
-- Table structure for table `REPO_Devices_washers`
--

CREATE TABLE `REPO_Devices_washers` (
  `washer_id` int(11) NOT NULL AUTO_INCREMENT,
  `brand` varchar(50) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `consumption` decimal(10,0) DEFAULT NULL,
  `capacity` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`washer_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='- Consumption: kWh/year /n- Capacity: Cubic Feet' AUTO_INCREMENT=1515 ;

--
-- Dumping data for table `REPO_Devices_washers`
--

INSERT INTO `REPO_Devices_washers` VALUES(1148, 'Crosley', 'CFW4700***', 83, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1149, 'Frigidaire', 'FAFW4011L**', 83, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1150, 'Samsung', 'WF511***', 93, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1151, 'Samsung', 'WF461***', 94, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1152, 'Haier', 'HWD1600', 95, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1153, 'Kenmore', '4153#21#', 95, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1154, 'Kenmore', '4154#21#', 95, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1155, 'LG', 'WM3150H**', 95, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1156, 'LG', 'WM3550H***', 95, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1157, 'Samsung', 'WF431***', 95, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1158, 'Summit', 'SPWD1800', 95, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1159, 'Thor', 'WD10000', 95, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1160, 'Crosley', 'CFW7700***', 96, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1161, 'Frigidaire', 'FAFS4272L**', 96, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1162, 'Frigidaire', 'LAFW7000L**', 96, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1163, 'Samsung', 'WF520***', 96, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1164, 'LG', 'WM2140C**', 97, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1165, 'Frigidaire', 'FAFW3001L**', 99, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1166, 'Frigidaire', 'FAFW3801L**', 99, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1167, 'LG', 'WM3360H***', 100, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1168, 'Samsung', 'WF231***', 100, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1169, 'Samsung', 'WF241***', 100, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1170, 'Samsung', 'WF501***', 100, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1171, 'Electrolux', 'EIFLS60**', 102, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1172, 'LG', 'WM2350H**', 102, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1173, 'Frigidaire', 'FAFS4473L**', 104, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1174, 'Frigidaire', 'FAFS4474L**', 104, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1175, 'Kenmore', '417.4110*', 104, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1176, 'LG', 'WM2450H**', 105, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1177, 'LG', 'WM2550H***', 105, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1178, 'Kenmore', '4172#00#', 108, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1179, 'LG', 'LSWF388H**', 108, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1180, 'LG', 'WM1355H*', 108, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1181, 'LG', 'WM3875H***', 108, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1182, 'LG', 'WM3885H***', 108, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1183, 'Samsung', 'WF438***', 108, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1184, 'Kenmore', '417.4413*', 109, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1185, 'Kenmore', '4102#90#', 110, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1186, 'LG', 'WM2240C**', 110, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1187, 'Frigidaire', 'FAFW4221L**', 111, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1188, 'Kenmore', '4051#90#', 112, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1189, 'Samsung', 'WF407***', 114, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1190, 'Ariston', 'ARWDF 129  (NA) ', 115, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1191, 'Ariston', 'ARWDF 129  (NA) #', 115, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1192, 'Ariston', 'ARWDF 129 S (NA) ', 115, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1193, 'Ariston', 'ARWDF 129 S (NA) #', 115, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1194, 'Ariston', 'ARWL 129 (NA) ', 115, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1195, 'Ariston', 'ARWL 129 (NA) #', 115, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1196, 'Ariston', 'ARWL 129 S(NA) ', 115, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1197, 'Ariston', 'ARWL 129 S(NA) #', 115, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1198, 'Ariston', 'ARWXF 129 W (NA)', 115, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1199, 'Ariston', 'ARWXF 129 W (NA) #', 115, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1200, 'Ariston', 'ARXL 129 W SP', 115, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1201, 'Samsung', 'WF330***', 116, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1202, 'Samsung', 'WF331***', 116, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1203, 'Samsung', 'WF340***', 116, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1204, 'Samsung', 'WF350***', 116, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1205, 'Electrolux', 'EWFLS70J***', 118, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1206, 'Samsung', 'WF409***', 118, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1207, 'Samsung', 'WF410***', 118, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1208, 'Samsung', 'WF419***', 118, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1209, 'Kenmore', '4031#90#', 119, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1210, 'Kenmore', '4044#90#', 119, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1211, 'Samsung', 'WF448***', 120, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1212, 'LG', 'CW2079C***', 121, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1213, 'GE', 'WCVH4800****', 122, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1214, 'GE', 'WCVH4815****', 122, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1215, 'Maytag', 'MVWX500X*+', 122, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1216, 'Maytag', 'MVWX550X*+', 122, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1217, 'Maytag', 'MVWX600X*+', 122, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1218, 'Maytag', 'MVWX700X*+', 122, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1219, 'Kenmore ', '2130*10+', 123, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1220, 'Kenmore ', '2130*10+', 123, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1221, 'Kenmore ', '2139*10+', 123, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1222, 'Kenmore ', '2139*10+', 123, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1223, 'Kenmore ', '2600*10+', 123, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1224, 'Kenmore ', '2601*10+', 123, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1225, 'Kenmore ', '2800*10+', 123, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1226, 'Kenmore ', '2801*10+', 123, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1227, 'Maytag', 'MVWC400X*+', 123, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1228, 'Maytag', 'MVWC400X*+', 123, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1229, 'Whirlpool', 'WTW5600X*+', 123, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1230, 'Whirlpool', 'WTW5640X*+', 123, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1231, 'Whirlpool', 'WTW5700X*+', 123, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1232, 'Whirlpool ', 'WTW4950X*+', 123, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1233, 'Whirlpool ', 'WTW4950X*+', 123, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1234, 'Crosley', 'CAW12444X*+', 124, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1235, 'Maytag', 'MHN30PDAW*+', 124, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1236, 'Maytag', 'MHN30PDAX*+', 124, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1237, 'Maytag', 'MHN30PRAW*+', 124, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1238, 'Maytag', 'MHP30PRAW*+', 124, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1239, 'Whirlpool', 'WFW9050X*+', 125, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1240, 'Whirlpool', 'WTW5500X*+', 125, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1241, 'Whirlpool', 'WTW5550X*+', 125, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1242, 'Kenmore', '4027#90#', 126, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1243, 'Maytag', 'MVWC450X*+', 128, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1244, 'Miele ', 'W3039', 128, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1245, 'Whirlpool', 'WTW5610X*+', 129, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1246, 'Samsung', 'WF219***', 130, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1247, 'Speed Queen', 'AWNA11SP111TW01', 130, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1248, 'Speed Queen', 'LWNA11SP111TW01', 130, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1249, 'Crosley', 'CAW12444X*+', 136, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1250, 'Whirlpool', 'WFW9640X*+', 136, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1251, 'Electrolux', 'EIFLS55I***', 138, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1252, 'Kenmore', '592-4900*', 138, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1253, 'Miele ', 'W3033', 139, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1254, 'Miele ', 'W3035', 139, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1255, 'Whirlpool', 'WFW97HEX*+', 140, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1256, 'Ariston', 'ARWF 149  (NA)', 141, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1257, 'Ariston', 'ARWF 149 S (NA) ', 141, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1258, 'Ariston', 'ARWF 149 S (NA) #', 141, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1259, 'Daewoo', 'DWD-WD3011RR', 141, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1260, 'Daewoo', 'DWD-WD3011WW', 141, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1261, 'Daewoo', 'DWD-WD33WS', 141, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1262, 'Samsung', 'WF210***', 141, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1263, 'Samsung', 'WF220***', 141, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1264, 'Samsung', 'WF221***', 141, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1265, 'Miele ', 'PW6065', 142, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1266, 'GE', 'WCVH6800J***', 144, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1267, 'Kenmore', '402.4903*01*', 144, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1268, 'Kenmore', '592-4903*', 144, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1269, 'Maytag ', 'MVWC300X*+', 144, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1270, 'Whirlpool', 'WFW9550W*+', 144, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1271, 'Whirlpool', 'WTW4850X*+', 144, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1272, 'Kenmore', '592-4908*', 145, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1273, 'LG', 'GCW1069**', 145, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1274, 'Maytag', 'MVWB455Y*+', 146, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1275, 'Maytag', 'MVWB755Y*+', 146, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1276, 'Samsung', 'WF209***', 146, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1277, 'Maytag', 'MHW9000Y*+', 147, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1278, 'Maytag', 'MHWE950W*+', 147, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1279, 'Kenmore', '592-4906*', 149, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1280, 'Kenmore', '592-4907*', 149, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1281, 'Whirlpool', 'WFW9750W*+', 149, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1282, 'Whirlpool', 'WFW9750W*+', 149, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1283, 'Kenmore ', '2125*10+', 150, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1284, 'Kenmore ', '2135*10+', 150, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1285, 'Speed Queen', 'LWNB11SP111TW01', 150, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1286, 'Fisher & Paykel', 'WL42T26***', 151, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1287, 'GE', 'GFWN1100L***', 151, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1288, 'Whirlpool', 'WFW97HEX*+', 151, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1289, 'Asko', 'WL6532 XXLW', 152, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1290, 'Asko', 'WL6532 XXLW RH', 152, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1291, 'Asko', 'WL6632 XXLPP', 152, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1292, 'Daewoo', 'DWD-WD1353WC', 152, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1293, 'Daewoo', 'DWD-WD1363RC', 152, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1294, 'Daewoo', 'DWD-WD1363WC', 152, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1295, 'Samsung', 'WF338***', 153, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1296, 'Samsung', 'WF339***', 153, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1297, 'Splendide', ' WD 2100 XC (NA) ', 153, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1298, 'Splendide', ' WD 2100 XC (NA) #', 153, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1299, 'Splendide', ' WDC 7100 XC (NA) ', 153, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1300, 'Splendide', ' WDC 7100 XC (NA) #', 153, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1301, 'Maytag', 'MHWE201Y*+', 154, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1302, 'Maytag', 'MHWE251Y*+', 154, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1303, 'Maytag', 'MHWE301Y*+', 154, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1304, 'Speed Queen', 'LFNA0FSP111TW01', 154, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1305, 'Speed Queen', 'LFNA0RSP111TW01', 154, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1306, 'Whirlpool', 'WFW9151Y*+', 154, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1307, 'Whirlpool', 'WFW9351Y*+', 154, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1308, 'Whirlpool', 'CHW9900W*+', 156, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1309, 'LG', 'WM2101H*', 160, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1310, 'GE', 'GCWN5050M', 160, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1311, 'GE', 'GLWN5050M', 160, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1312, 'GE', 'GRWN5150M', 160, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1313, 'GE', 'GTWN4950L', 160, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1314, 'GE', 'GTWN5050M', 160, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1315, 'GE Profile', 'PTWN6050M', 160, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1316, 'GE Profile', 'PTWN6250M', 160, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1317, 'Samsung', 'WF328***', 161, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1318, 'Avanti', 'W757-1', 163, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1319, 'Whirlpool', 'WTW7300X*+', 163, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1320, 'Whirlpool', 'WTW7300X*+', 163, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1321, 'Whirlpool', 'WTW7320Y*+', 163, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1322, 'Kenmore', '592-4904*', 165, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1323, 'Kenmore', '592-4905*', 165, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1324, 'Samsung', 'WF218***', 165, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1325, 'Samsung', 'WF229***', 165, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1326, 'Ariston', 'AWD 129 (NA)', 168, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1327, 'Maytag', 'MHW6000X*+', 168, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1328, 'Whirlpool', 'WFW94HEX*+', 168, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1329, 'Maytag', 'MHW7000X*+', 169, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1330, 'Maytag', 'MHW7000X*+', 169, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1331, 'Whirlpool', 'WFW9451X*+', 169, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1332, 'Whirlpool', 'WFW95HEX*+', 169, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1333, 'Whirlpool', 'WFW95HEX*+', 169, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1334, 'Samsung', 'WF-J1254', 170, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1335, 'Haier', 'HWF5000AW', 171, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1336, 'Haier', 'HWF5300AW', 173, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1337, 'Maytag', 'MHWE400W*+', 174, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1338, 'Maytag', 'MHWE450W*+', 174, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1339, 'Fisher & Paykel', 'WL37T26*', 175, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1340, 'Haier', 'HBF1055TVE', 175, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1341, 'LG', 'WT4801C*', 175, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1342, 'Ariston', 'AWD 121 (NA)', 177, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1343, 'Avanti', 'W798SS-1', 179, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1344, 'Staber', 'HXW2304', 180, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1345, 'Staber', 'HXW2404', 180, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1346, 'Staber', 'HXW2504', 180, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1347, 'Whirlpool', 'CHW8990X*+', 183, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1348, 'Whirlpool', 'WTW8200Y*+', 183, 5);
INSERT INTO `REPO_Devices_washers` VALUES(1349, 'Whirlpool', 'WTW8240Y*+', 183, 5);
INSERT INTO `REPO_Devices_washers` VALUES(1350, 'Whirlpool', 'WTW8280Y*+', 183, 5);
INSERT INTO `REPO_Devices_washers` VALUES(1351, 'Whirlpool', 'WTW8400Y*+', 183, 5);
INSERT INTO `REPO_Devices_washers` VALUES(1352, 'Whirlpool', 'WTW8440Y*+', 183, 5);
INSERT INTO `REPO_Devices_washers` VALUES(1353, 'Whirlpool', 'WTW8600Y*+', 183, 5);
INSERT INTO `REPO_Devices_washers` VALUES(1354, 'Huebsch', 'LTZA7***', 184, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1355, 'Huebsch', 'LTZA9***', 184, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1356, 'IPSO', 'BFN5SFP111TW01', 184, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1357, 'IPSO', 'BTEBEFSP171TW01', 184, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1358, 'IPSO', 'BTGBEFSP111TW01', 184, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1359, 'Speed Queen', 'AFN50FSP111TW01', 184, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1360, 'Speed Queen', 'AFN50RSP111TW01', 184, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1361, 'Speed Queen', 'AFN51FSP111TN01', 184, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1362, 'Speed Queen', 'ATE50FGP171TW01', 184, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1363, 'Speed Queen', 'ATG50FGP111TW01', 184, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1364, 'Speed Queen', 'FTSA0***', 184, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1365, 'Speed Queen', 'FTSA1***', 184, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1366, 'Speed Queen', 'LTSA0***', 184, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1367, 'Speed Queen', 'LTSA7***', 184, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1368, 'Speed Queen', 'LTSA9***', 184, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1369, 'Unimac', 'LTUA7***', 184, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1370, 'Unimac', 'LTUA9***', 184, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1371, 'GE', 'GTWN4250M', 186, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1372, 'GE', 'GTWN4450M', 186, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1373, 'Miele ', 'W4802', 186, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1374, 'Miele ', 'W4842', 186, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1375, 'Maytag', 'MAH2400***', 190, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1376, 'Maytag', 'MVWB750Y*+', 190, 5);
INSERT INTO `REPO_Devices_washers` VALUES(1377, 'Maytag', 'MVWB800Y*+', 190, 5);
INSERT INTO `REPO_Devices_washers` VALUES(1378, 'Whirlpool', 'WTW7340X*+', 191, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1379, 'Whirlpool', 'WTW7340X*+', 191, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1380, 'Whirlpool', 'WTW7600X*+', 191, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1381, 'Whirlpool', 'WTW7600X*+', 191, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1382, 'Whirlpool', 'WTW7800X*+', 191, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1383, 'Whirlpool', 'WTW7800X*+', 191, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1384, 'ELBA', 'WA37T26*', 198, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1385, 'Fisher & Paykel', 'WA42T26*', 198, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1386, 'Maytag', 'MVWB850Y*+', 198, 5);
INSERT INTO `REPO_Devices_washers` VALUES(1387, 'Maytag', 'MVWB950Y*+', 198, 5);
INSERT INTO `REPO_Devices_washers` VALUES(1388, 'Fisher & Paykel', 'WL26CW2', 199, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1389, 'Fisher & Paykel', 'WL37T*', 199, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1390, 'Samsung', 'WA5471***', 199, 5);
INSERT INTO `REPO_Devices_washers` VALUES(1391, 'GE', 'GFWH2400L***', 200, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1392, 'GE', 'GFWH2405L***', 200, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1393, 'GE', 'GFWS3500L***', 200, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1394, 'GE', 'GFWS3505L***', 200, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1395, 'Haier', 'GWT460AW', 200, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1396, 'Haier', 'HWD1000', 200, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1397, 'GE', 'PFWS4600L***', 201, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1398, 'GE', 'PFWS4605L***', 201, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1399, 'Summit', 'SPW1200P', 205, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1400, 'Whirlpool', 'WTW7990X*+', 205, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1401, 'Whirlpool', 'WTW7990X*+', 205, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1402, 'Samsung', 'WF206***', 210, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1403, 'Samsung', 'WF306***', 210, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1404, 'Samsung', 'WF337***', 210, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1405, 'Speed Queen', 'AFB50RSP111TW01', 211, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1406, 'Samsung', 'WF203***', 216, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1407, 'Samsung', 'WF316***', 220, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1408, 'Samsung', 'WF317***', 220, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1409, 'Haier', 'GWT450AW', 230, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1410, 'Samsung', 'WA5451***', 247, 5);
INSERT INTO `REPO_Devices_washers` VALUES(1411, 'Kenmore', '2927#00#', 250, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1412, 'Kenmore', '2947#00#', 250, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1413, 'LG', 'WT5001C*', 250, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1414, 'LG', 'WT5101H*', 250, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1415, 'GE', 'GTUP240EM0WW', 251, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1416, 'GE', 'GTUP240GM0WW', 251, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1417, 'GE', 'GUAP240EMWW', 251, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1418, 'Kenmore', '2661532XXX         ', 251, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1419, 'Maytag', 'MVWB300W*+', 257, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1420, 'Maytag ', 'MVWB450W*+', 258, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1421, 'Maytag ', 'MVWB750W*+', 258, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1422, 'Maytag ', 'MVWB850W*+', 258, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1423, 'GE', 'PTWN805#M#**', 263, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1424, 'Kenmore', '2900#00#', 273, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1425, 'Kenmore', '2711*60+', 284, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1426, 'Kenmore', '2717*60+', 284, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1427, 'Kenmore ', '506*11+', 287, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1428, 'Speed Queen', 'LWS05**', 288, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1429, 'GE', 'GTUP270EM0WW', 289, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1430, 'GE', 'GTUP270GM0WW', 289, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1431, 'GE', 'GUAP270EMWW', 289, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1432, 'Kenmore', '2671532XXX', 289, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1433, 'Maytag', 'MAT14PDAWW*+', 289, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1434, 'Maytag', 'MAT14PDAXW*+', 289, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1435, 'Maytag', 'MAT14PRAWW*+', 289, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1436, 'Amana', 'NTW4800X*+', 290, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1437, 'Amana', 'NTW4880X*+', 290, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1438, 'Inglis', 'IV4800X*+', 290, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1439, 'Maytag ', 'MET3800X*+', 290, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1440, 'Maytag ', 'MGT3800X*+', 290, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1441, 'Whirlpool', 'WET3300X*+', 290, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1442, 'Whirlpool', 'WGT3300X*+', 290, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1443, 'GE', 'WNRD2050G', 297, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1444, 'Admiral', 'ATW4475X*+', 299, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1445, 'Estate', 'ETW4400X*+', 299, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1446, 'Roper', 'RTW4440X*+', 299, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1447, 'Amana', 'NTW4600X*+', 302, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1448, 'Inglis', 'IV4600X*+', 302, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1449, 'Haier', 'GWT750AW', 309, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1450, 'Maytag', 'MAT14CSAWW*+', 310, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1451, 'Amana', 'NTW4500X*+', 318, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1452, 'Inglis', 'ITW4300X*+', 318, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1453, 'Roper', 'RTW4305X*+', 318, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1454, 'Haier', 'RTW350AW', 324, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1455, 'Avanti', 'W711', 330, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1456, 'Avanti', 'W712PS', 330, 2);
INSERT INTO `REPO_Devices_washers` VALUES(1457, 'Haier', 'RTW150AW', 359, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1458, 'Maytag', 'MAT15MNAWW*+', 377, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1459, 'Amana', 'NTW5100X*+', 386, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1460, 'GE', 'WSL *1500J0WW', 389, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1461, 'Amana', 'IV4500X*+', 392, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1462, 'Speed Queen', 'AWN311SP111TW01', 400, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1463, 'Speed Queen', 'AWN412SP111TW01', 400, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1464, 'Speed Queen', 'AWN432SP111TW01', 400, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1465, 'Speed Queen', 'AWN542SP111TW01', 400, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1466, 'Speed Queen', 'LWN311PP111TW01', 400, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1467, 'Speed Queen', 'LWN311SP111TW01', 400, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1468, 'Speed Queen', 'LWN311WP111TW01', 400, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1469, 'Speed Queen', 'LWN412SP111TW01', 400, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1470, 'Speed Queen', 'OWN311PP111TW01', 400, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1471, 'Speed Queen', 'OWN311SP111TW01', 400, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1472, 'Speed Queen', 'OWN412SP111TW01', 400, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1473, 'Speed Queen', 'OWN542SP111TW01', 400, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1474, 'Amana', 'NTW4601X*', 402, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1475, 'Whirlpool', 'GCAM2792T*+', 402, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1476, 'Whirlpool', 'CAM2762T*+', 404, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1477, 'Whirlpool', 'CAM2742T*+', 406, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1478, 'Whirlpool', 'CAM2752T*+', 406, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1479, 'Whirlpool', 'CAW9444X*+', 408, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1480, 'Whirlpool', 'CAW9244X*+', 414, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1481, 'GE', 'GLWP2000M', 414, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1482, 'GE', 'GTWP2000M', 414, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1483, 'GE', 'GTWP2005M', 414, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1484, 'GE', 'WCCD2050H', 417, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1485, 'GE', 'WMCD2050H', 417, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1486, 'Hotpoint', 'HTWP1000M', 424, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1487, 'GE', 'GCWP1000M', 427, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1488, 'GE', 'GCWP1005M', 427, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1489, 'GE', 'GHWP1000M', 427, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1490, 'GE', 'GTWP1000M', 427, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1491, 'GE', 'GCWN3000M', 431, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1492, 'GE', 'GTWN3000M', 431, 4);
INSERT INTO `REPO_Devices_washers` VALUES(1493, 'Amana', 'NTW4501X*', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1494, 'Crosley', 'CAW9244X*+', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1495, 'Crosley', 'CAW9444X*+', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1496, 'Kenmore', '2002*01+', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1497, 'Kenmore', '2110*01+', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1498, 'Kenmore', '2111*01+', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1499, 'Kenmore', '2118*01+', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1500, 'Kenmore', '2120*01+', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1501, 'Kenmore', '2129*01+', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1502, 'Maytag', 'MVWC100Y*+', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1503, 'Maytag', 'MVWC100Y*+', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1504, 'Maytag', 'MVWC200X*+', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1505, 'Whirlpool', '1CWTW4740Y*+', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1506, 'Whirlpool', '1CWTW4800Y*+', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1507, 'Whirlpool', '1CWTW4840Y*+', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1508, 'Whirlpool', 'WTW4700Y*+', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1509, 'Whirlpool', 'WTW4750Y*+', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1510, 'Whirlpool', 'WTW4800X*+', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1511, 'Whirlpool', 'WTW4820X*+', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1512, 'Whirlpool', 'WTW4910X*+', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1513, 'Whirlpool', 'WTW4930X*+', 470, 3);
INSERT INTO `REPO_Devices_washers` VALUES(1514, 'GE', 'GTWN4000M', 504, 4);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `GOALS_map`
--
ALTER TABLE `GOALS_map`
  ADD CONSTRAINT `goals_map_ibfk_1` FOREIGN KEY (`goal_id`) REFERENCES `GOALS_data` (`goal_id`),
  ADD CONSTRAINT `goals_map_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `AUTH_Users` (`user_id`);

--
-- Constraints for table `PROFILE`
--
ALTER TABLE `PROFILE`
  ADD CONSTRAINT `profile_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `AUTH_Users` (`user_id`);

--
-- Constraints for table `PROFILE_Bathroom`
--
ALTER TABLE `PROFILE_Bathroom`
  ADD CONSTRAINT `profile_bathroom_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `PROFILE` (`profile_id`);

--
-- Constraints for table `PROFILE_Electronics_map`
--
ALTER TABLE `PROFILE_Electronics_map`
  ADD CONSTRAINT `profile_electronics_map_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `PROFILE` (`profile_id`),
  ADD CONSTRAINT `profile_electronics_map_ibfk_2` FOREIGN KEY (`electronics_id`) REFERENCES `PROFILE_Electronics_defaults` (`electronics_id`);

--
-- Constraints for table `PROFILE_Home`
--
ALTER TABLE `PROFILE_Home`
  ADD CONSTRAINT `profile_home_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `PROFILE` (`profile_id`);

--
-- Constraints for table `PROFILE_Home_basic`
--
ALTER TABLE `PROFILE_Home_basic`
  ADD CONSTRAINT `profile_home_basic_ibfk_1` FOREIGN KEY (`home_id`) REFERENCES `PROFILE_Home` (`home_id`);

--
-- Constraints for table `PROFILE_Home_cooling`
--
ALTER TABLE `PROFILE_Home_cooling`
  ADD CONSTRAINT `profile_home_cooling_ibfk_1` FOREIGN KEY (`home_id`) REFERENCES `PROFILE_Home` (`home_id`);

--
-- Constraints for table `PROFILE_Home_heating`
--
ALTER TABLE `PROFILE_Home_heating`
  ADD CONSTRAINT `profile_home_heating_ibfk_1` FOREIGN KEY (`home_id`) REFERENCES `PROFILE_Home` (`home_id`);

--
-- Constraints for table `PROFILE_Home_lights`
--
ALTER TABLE `PROFILE_Home_lights`
  ADD CONSTRAINT `profile_home_lights_ibfk_1` FOREIGN KEY (`home_id`) REFERENCES `PROFILE_Home` (`home_id`);

--
-- Constraints for table `PROFILE_Home_water`
--
ALTER TABLE `PROFILE_Home_water`
  ADD CONSTRAINT `profile_home_water_ibfk_1` FOREIGN KEY (`home_id`) REFERENCES `PROFILE_Home` (`home_id`);

--
-- Constraints for table `PROFILE_Hottub`
--
ALTER TABLE `PROFILE_Hottub`
  ADD CONSTRAINT `profile_hottub_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `PROFILE` (`profile_id`);

--
-- Constraints for table `PROFILE_Kitchen`
--
ALTER TABLE `PROFILE_Kitchen`
  ADD CONSTRAINT `profile_kitchen_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `PROFILE` (`profile_id`);

--
-- Constraints for table `PROFILE_Kitchen_dishwasher`
--
ALTER TABLE `PROFILE_Kitchen_dishwasher`
  ADD CONSTRAINT `profile_kitchen_dishwasher_ibfk_1` FOREIGN KEY (`kitchen_id`) REFERENCES `PROFILE_Kitchen` (`kitchen_id`),
  ADD CONSTRAINT `profile_kitchen_dishwasher_ibfk_2` FOREIGN KEY (`dishwasher_id`) REFERENCES `REPO_Devices_dishwasher` (`dishwasher_id`);

--
-- Constraints for table `PROFILE_Kitchen_freezer`
--
ALTER TABLE `PROFILE_Kitchen_freezer`
  ADD CONSTRAINT `profile_kitchen_freezer_ibfk_1` FOREIGN KEY (`kitchen_id`) REFERENCES `PROFILE_Kitchen` (`kitchen_id`),
  ADD CONSTRAINT `profile_kitchen_freezer_ibfk_2` FOREIGN KEY (`freezer_id`) REFERENCES `REPO_Devices_freezer` (`freezer_id`);

--
-- Constraints for table `PROFILE_Kitchen_fridge`
--
ALTER TABLE `PROFILE_Kitchen_fridge`
  ADD CONSTRAINT `profile_kitchen_fridge_ibfk_1` FOREIGN KEY (`kitchen_id`) REFERENCES `PROFILE_Kitchen` (`kitchen_id`),
  ADD CONSTRAINT `profile_kitchen_fridge_ibfk_2` FOREIGN KEY (`fridge_id`) REFERENCES `REPO_Devices_fridge` (`fridge_id`);

--
-- Constraints for table `PROFILE_Kitchen_microwave`
--
ALTER TABLE `PROFILE_Kitchen_microwave`
  ADD CONSTRAINT `profile_kitchen_microwave_ibfk_1` FOREIGN KEY (`kitchen_id`) REFERENCES `PROFILE_Kitchen` (`kitchen_id`);

--
-- Constraints for table `PROFILE_Kitchen_stove`
--
ALTER TABLE `PROFILE_Kitchen_stove`
  ADD CONSTRAINT `profile_kitchen_stove_ibfk_1` FOREIGN KEY (`kitchen_id`) REFERENCES `PROFILE_Kitchen` (`kitchen_id`);

--
-- Constraints for table `PROFILE_Kitchen_toaster`
--
ALTER TABLE `PROFILE_Kitchen_toaster`
  ADD CONSTRAINT `profile_kitchen_toaster_ibfk_1` FOREIGN KEY (`kitchen_id`) REFERENCES `PROFILE_Kitchen` (`kitchen_id`);

--
-- Constraints for table `PROFILE_Laundry`
--
ALTER TABLE `PROFILE_Laundry`
  ADD CONSTRAINT `profile_laundry_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `PROFILE` (`profile_id`),
  ADD CONSTRAINT `profile_laundry_ibfk_2` FOREIGN KEY (`washer_id`) REFERENCES `REPO_Devices_washers` (`washer_id`);

--
-- Constraints for table `PROFILE_Pool`
--
ALTER TABLE `PROFILE_Pool`
  ADD CONSTRAINT `profile_pool_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `PROFILE` (`profile_id`);