



-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'PROFILE'
-- 
-- ---

DROP TABLE IF EXISTS `PROFILE`;
    
CREATE TABLE `PROFILE` (
  `profile_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `owner_id` INTEGER NULL DEFAULT NULL,
  `name` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`profile_id`)
);

-- ---
-- Table 'PROFILE_Device_instance'
-- 
-- ---

DROP TABLE IF EXISTS `PROFILE_Device_instance`;
    
CREATE TABLE `PROFILE_Device_instance` (
  `instance_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `archetype_id` INTEGER NULL DEFAULT NULL,
  `profile_id` INTEGER NULL DEFAULT NULL,
  `name` VARCHAR(50) NULL DEFAULT NULL,
  `age` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`instance_id`)
);

-- ---
-- Table 'PROFILE_Device_archetype'
-- 
-- ---

DROP TABLE IF EXISTS `PROFILE_Device_archetype`;
    
CREATE TABLE `PROFILE_Device_archetype` (
  `archetype_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `type` INTEGER NULL DEFAULT NULL,
  `name` VARCHAR(100) NULL DEFAULT NULL,
  `build_year` INTEGER NULL DEFAULT NULL,
  `brand` VARCHAR(100) NULL DEFAULT NULL,
  `model` VARCHAR(100) NULL DEFAULT NULL,
  `consumption` VARCHAR(100) NULL DEFAULT NULL,
  `creator_id` INTEGER NULL DEFAULT NULL,
  `device_type` INTEGER NULL DEFAULT NULL,
  `capacity` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`archetype_id`)
);

-- ---
-- Table 'AUTH_Users'
-- 
-- ---

DROP TABLE IF EXISTS `AUTH_Users`;
    
CREATE TABLE `AUTH_Users` (
  `user_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `username` VARCHAR(100) NULL DEFAULT NULL,
  `password` VARCHAR(100) NULL DEFAULT NULL,
  `first` VARCHAR(100) NULL DEFAULT NULL,
  `last` VARCHAR(100) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`)
);

-- ---
-- Table 'PROFILE_Fridge_instance'
-- 
-- ---

DROP TABLE IF EXISTS `PROFILE_Fridge_instance`;
    
CREATE TABLE `PROFILE_Fridge_instance` (
  `fridge_instance_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `instance_id` INTEGER NULL DEFAULT NULL,
  `location` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`fridge_instance_id`)
);

-- ---
-- Table 'PROFILE_Freezer_instance'
-- 
-- ---

DROP TABLE IF EXISTS `PROFILE_Freezer_instance`;
    
CREATE TABLE `PROFILE_Freezer_instance` (
  `freezer_instance_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `instance_id` INTEGER NULL DEFAULT NULL,
  `location` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`freezer_instance_id`)
);

-- ---
-- Table 'PROFILE_Microwave_instance'
-- 
-- ---

DROP TABLE IF EXISTS `PROFILE_Microwave_instance`;
    
CREATE TABLE `PROFILE_Microwave_instance` (
  `microwave_instance_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `instance_id` INTEGER NULL DEFAULT NULL,
  `usage` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`microwave_instance_id`)
);

-- ---
-- Table 'PROFILE_Dishwasher_instance'
-- 
-- ---

DROP TABLE IF EXISTS `PROFILE_Dishwasher_instance`;
    
CREATE TABLE `PROFILE_Dishwasher_instance` (
  `dishwasher_instance_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `instance_id` INTEGER NULL DEFAULT NULL,
  `usage` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`dishwasher_instance_id`)
);

-- ---
-- Table 'PROFILE_Stove_instance'
-- 
-- ---

DROP TABLE IF EXISTS `PROFILE_Stove_instance`;
    
CREATE TABLE `PROFILE_Stove_instance` (
  `stove_instance_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `instance_id` INTEGER NULL DEFAULT NULL,
  `usage` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`stove_instance_id`)
);

-- ---
-- Table 'PROFILE_Toaster_instance'
-- 
-- ---

DROP TABLE IF EXISTS `PROFILE_Toaster_instance`;
    
CREATE TABLE `PROFILE_Toaster_instance` (
  `toaster_instance_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `instance_id` INTEGER NULL DEFAULT NULL,
  `usage` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`toaster_instance_id`)
);

-- ---
-- Table 'PROFILE_Heating_instance'
-- 
-- ---

DROP TABLE IF EXISTS `PROFILE_Heating_instance`;
    
CREATE TABLE `PROFILE_Heating_instance` (
  `heating_instance_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `instance_id` INTEGER NULL DEFAULT NULL,
  `avgTemp` INTEGER NULL DEFAULT NULL,
  `location` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`heating_instance_id`)
);

-- ---
-- Table 'PROFILE_Water_instance'
-- 
-- ---

DROP TABLE IF EXISTS `PROFILE_Water_instance`;
    
CREATE TABLE `PROFILE_Water_instance` (
  `water_instance_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `instance_id` INTEGER NULL DEFAULT NULL,
  `temperature` INTEGER NULL DEFAULT NULL,
  `location` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`water_instance_id`)
);

-- ---
-- Table 'PROFILE_Cooling_instance'
-- 
-- ---

DROP TABLE IF EXISTS `PROFILE_Cooling_instance`;
    
CREATE TABLE `PROFILE_Cooling_instance` (
  `cooling_instance_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `instance_id` INTEGER NULL DEFAULT NULL,
  `temperature` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`cooling_instance_id`)
);

-- ---
-- Table 'PROFILE_Lights_instance'
-- 
-- ---

DROP TABLE IF EXISTS `PROFILE_Lights_instance`;
    
CREATE TABLE `PROFILE_Lights_instance` (
  `lights_instance_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `profile_id` INTEGER NULL DEFAULT NULL,
  `lights_archetype_id` INTEGER NULL DEFAULT NULL,
  `count` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`lights_instance_id`)
);

-- ---
-- Table 'PROFILE_Lights_archetype'
-- 
-- ---

DROP TABLE IF EXISTS `PROFILE_Lights_archetype`;
    
CREATE TABLE `PROFILE_Lights_archetype` (
  `lights_archetype_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `type` INTEGER NULL DEFAULT NULL,
  `consumption` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`lights_archetype_id`)
);

-- ---
-- Table 'PROFILE_Bathroom_instance'
-- 
-- ---

DROP TABLE IF EXISTS `PROFILE_Bathroom_instance`;
    
CREATE TABLE `PROFILE_Bathroom_instance` (
  `bathroom_instance_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `profile_id` INTEGER NULL DEFAULT NULL,
  `hairdryer` INTEGER NULL DEFAULT NULL,
  `shower_count` INTEGER NULL DEFAULT NULL,
  `shower_avgTemp` INTEGER NULL DEFAULT NULL,
  `shower_avgTime` INTEGER NULL DEFAULT NULL,
  `shower_pressure` INTEGER NULL DEFAULT NULL,
  `bath_count` INTEGER NULL DEFAULT NULL,
  `bath_avgTemp` INTEGER NULL DEFAULT NULL,
  `hasFan` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`bathroom_instance_id`)
);

-- ---
-- Table 'PROFILE_Washer_Instance'
-- 
-- ---

DROP TABLE IF EXISTS `PROFILE_Washer_Instance`;
    
CREATE TABLE `PROFILE_Washer_Instance` (
  `washer_instance_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `instance_id` INTEGER NULL DEFAULT NULL,
  `avg_loads` INTEGER NULL DEFAULT NULL,
  `avg_temp` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`washer_instance_id`)
);

-- ---
-- Table 'PROFILE_Dryer_instance'
-- 
-- ---

DROP TABLE IF EXISTS `PROFILE_Dryer_instance`;
    
CREATE TABLE `PROFILE_Dryer_instance` (
  `dryer_instance_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `instance_Id` INTEGER NULL DEFAULT NULL,
  `avg_loads` INTEGER NULL DEFAULT NULL,
  `avg_temp` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`dryer_instance_id`)
);

-- ---
-- Table 'PROFILE_Pool_instance'
-- 
-- ---

DROP TABLE IF EXISTS `PROFILE_Pool_instance`;
    
CREATE TABLE `PROFILE_Pool_instance` (
  `pool_instance_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `instance_id` INTEGER NULL DEFAULT NULL,
  `isHeated` INTEGER NULL DEFAULT NULL,
  `avgTemp` INTEGER NULL DEFAULT NULL,
  `usage_period` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`pool_instance_id`)
);

-- ---
-- Table 'PROFILE_Hottub_instance'
-- 
-- ---

DROP TABLE IF EXISTS `PROFILE_Hottub_instance`;
    
CREATE TABLE `PROFILE_Hottub_instance` (
  `hottub_instance_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `instance_id` INTEGER NULL DEFAULT NULL,
  `weekly_usage` INTEGER NULL DEFAULT NULL,
  `useage_period` INTEGER NULL DEFAULT NULL,
  `avg_temp` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`hottub_instance_id`)
);

-- ---
-- Table 'PROFILE_Home_instance'
-- 
-- ---

DROP TABLE IF EXISTS `PROFILE_Home_instance`;
    
CREATE TABLE `PROFILE_Home_instance` (
  `home_instance_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `profile_id` INTEGER NULL DEFAULT NULL,
  `residents` INTEGER NULL DEFAULT NULL,
  `wndow_type` INTEGER NULL DEFAULT NULL,
  `window_size` INTEGER NULL DEFAULT NULL,
  `window_pane_type` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`home_instance_id`)
);

-- ---
-- Table 'GOALS_Archetype'
-- 
-- ---

DROP TABLE IF EXISTS `GOALS_Archetype`;
    
CREATE TABLE `GOALS_Archetype` (
  `archetype_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `category_id` INTEGER NULL DEFAULT NULL,
  `description` MEDIUMTEXT NULL DEFAULT NULL,
  `unit` INTEGER NULL DEFAULT NULL,
  `creator_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`archetype_id`)
);

-- ---
-- Table 'GOALS_Category'
-- 
-- ---

DROP TABLE IF EXISTS `GOALS_Category`;
    
CREATE TABLE `GOALS_Category` (
  `category_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `name` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`)
);

-- ---
-- Table 'GOALS_Instance'
-- 
-- ---

DROP TABLE IF EXISTS `GOALS_Instance`;
    
CREATE TABLE `GOALS_Instance` (
  `instance_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `profile_id` INTEGER NULL DEFAULT NULL,
  `goal_archetype_id` INTEGER NULL DEFAULT NULL,
  `start_date` DATETIME NULL DEFAULT NULL,
  `completion_date` DATETIME NULL DEFAULT NULL,
  `completed_value` INTEGER NULL DEFAULT NULL,
  `completed` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`instance_id`)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `PROFILE` ADD FOREIGN KEY (owner_id) REFERENCES `AUTH_Users` (`user_id`);
ALTER TABLE `PROFILE_Device_instance` ADD FOREIGN KEY (archetype_id) REFERENCES `PROFILE_Device_archetype` (`archetype_id`);
ALTER TABLE `PROFILE_Device_instance` ADD FOREIGN KEY (profile_id) REFERENCES `PROFILE` (`profile_id`);
ALTER TABLE `PROFILE_Device_archetype` ADD FOREIGN KEY (creator_id) REFERENCES `AUTH_Users` (`user_id`);
ALTER TABLE `PROFILE_Fridge_instance` ADD FOREIGN KEY (instance_id) REFERENCES `PROFILE_Device_instance` (`instance_id`);
ALTER TABLE `PROFILE_Freezer_instance` ADD FOREIGN KEY (instance_id) REFERENCES `PROFILE_Device_instance` (`instance_id`);
ALTER TABLE `PROFILE_Microwave_instance` ADD FOREIGN KEY (instance_id) REFERENCES `PROFILE_Device_instance` (`instance_id`);
ALTER TABLE `PROFILE_Dishwasher_instance` ADD FOREIGN KEY (instance_id) REFERENCES `PROFILE_Device_instance` (`instance_id`);
ALTER TABLE `PROFILE_Stove_instance` ADD FOREIGN KEY (instance_id) REFERENCES `PROFILE_Device_instance` (`instance_id`);
ALTER TABLE `PROFILE_Toaster_instance` ADD FOREIGN KEY (instance_id) REFERENCES `PROFILE_Device_instance` (`instance_id`);
ALTER TABLE `PROFILE_Heating_instance` ADD FOREIGN KEY (instance_id) REFERENCES `PROFILE_Device_instance` (`instance_id`);
ALTER TABLE `PROFILE_Water_instance` ADD FOREIGN KEY (instance_id) REFERENCES `PROFILE_Device_instance` (`instance_id`);
ALTER TABLE `PROFILE_Cooling_instance` ADD FOREIGN KEY (instance_id) REFERENCES `PROFILE_Device_instance` (`instance_id`);
ALTER TABLE `PROFILE_Lights_instance` ADD FOREIGN KEY (profile_id) REFERENCES `PROFILE` (`profile_id`);
ALTER TABLE `PROFILE_Lights_instance` ADD FOREIGN KEY (lights_archetype_id) REFERENCES `PROFILE_Lights_archetype` (`lights_archetype_id`);
ALTER TABLE `PROFILE_Bathroom_instance` ADD FOREIGN KEY (profile_id) REFERENCES `PROFILE` (`profile_id`);
ALTER TABLE `PROFILE_Washer_Instance` ADD FOREIGN KEY (instance_id) REFERENCES `PROFILE_Device_instance` (`instance_id`);
ALTER TABLE `PROFILE_Dryer_instance` ADD FOREIGN KEY (instance_Id) REFERENCES `PROFILE_Device_instance` (`instance_id`);
ALTER TABLE `PROFILE_Pool_instance` ADD FOREIGN KEY (instance_id) REFERENCES `PROFILE_Device_instance` (`instance_id`);
ALTER TABLE `PROFILE_Hottub_instance` ADD FOREIGN KEY (instance_id) REFERENCES `PROFILE_Device_instance` (`instance_id`);
ALTER TABLE `PROFILE_Home_instance` ADD FOREIGN KEY (profile_id) REFERENCES `PROFILE` (`profile_id`);
ALTER TABLE `GOALS_Archetype` ADD FOREIGN KEY (category_id) REFERENCES `GOALS_Category` (`category_id`);
ALTER TABLE `GOALS_Archetype` ADD FOREIGN KEY (creator_id) REFERENCES `AUTH_Users` (`user_id`);
ALTER TABLE `GOALS_Instance` ADD FOREIGN KEY (profile_id) REFERENCES `PROFILE` (`profile_id`);
ALTER TABLE `GOALS_Instance` ADD FOREIGN KEY (goal_archetype_id) REFERENCES `GOALS_Archetype` (`archetype_id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `PROFILE` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PROFILE_Device_instance` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PROFILE_Device_archetype` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `AUTH_Users` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PROFILE_Fridge_instance` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PROFILE_Freezer_instance` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PROFILE_Microwave_instance` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PROFILE_Dishwasher_instance` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PROFILE_Stove_instance` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PROFILE_Toaster_instance` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PROFILE_Heating_instance` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PROFILE_Water_instance` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PROFILE_Cooling_instance` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PROFILE_Lights_instance` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PROFILE_Lights_archetype` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PROFILE_Bathroom_instance` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PROFILE_Washer_Instance` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PROFILE_Dryer_instance` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PROFILE_Pool_instance` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PROFILE_Hottub_instance` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PROFILE_Home_instance` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `GOALS_Archetype` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `GOALS_Category` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `GOALS_Instance` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `PROFILE` (`profile_id`,`owner_id`,`name`) VALUES
-- ('','','');
-- INSERT INTO `PROFILE_Device_instance` (`instance_id`,`archetype_id`,`profile_id`,`name`,`age`) VALUES
-- ('','','','','');
-- INSERT INTO `PROFILE_Device_archetype` (`archetype_id`,`type`,`name`,`build_year`,`brand`,`model`,`consumption`,`creator_id`,`device_type`,`capacity`) VALUES
-- ('','','','','','','','','','');
-- INSERT INTO `AUTH_Users` (`user_id`,`username`,`password`,`first`,`last`,`email`) VALUES
-- ('','','','','','');
-- INSERT INTO `PROFILE_Fridge_instance` (`fridge_instance_id`,`instance_id`,`location`) VALUES
-- ('','','');
-- INSERT INTO `PROFILE_Freezer_instance` (`freezer_instance_id`,`instance_id`,`location`) VALUES
-- ('','','');
-- INSERT INTO `PROFILE_Microwave_instance` (`microwave_instance_id`,`instance_id`,`usage`) VALUES
-- ('','','');
-- INSERT INTO `PROFILE_Dishwasher_instance` (`dishwasher_instance_id`,`instance_id`,`usage`) VALUES
-- ('','','');
-- INSERT INTO `PROFILE_Stove_instance` (`stove_instance_id`,`instance_id`,`usage`) VALUES
-- ('','','');
-- INSERT INTO `PROFILE_Toaster_instance` (`toaster_instance_id`,`instance_id`,`usage`) VALUES
-- ('','','');
-- INSERT INTO `PROFILE_Heating_instance` (`heating_instance_id`,`instance_id`,`avgTemp`,`location`) VALUES
-- ('','','','');
-- INSERT INTO `PROFILE_Water_instance` (`water_instance_id`,`instance_id`,`temperature`,`location`) VALUES
-- ('','','','');
-- INSERT INTO `PROFILE_Cooling_instance` (`cooling_instance_id`,`instance_id`,`temperature`) VALUES
-- ('','','');
-- INSERT INTO `PROFILE_Lights_instance` (`lights_instance_id`,`profile_id`,`lights_archetype_id`,`count`) VALUES
-- ('','','','');
-- INSERT INTO `PROFILE_Lights_archetype` (`lights_archetype_id`,`type`,`consumption`) VALUES
-- ('','','');
-- INSERT INTO `PROFILE_Bathroom_instance` (`bathroom_instance_id`,`profile_id`,`hairdryer`,`shower_count`,`shower_avgTemp`,`shower_avgTime`,`shower_pressure`,`bath_count`,`bath_avgTemp`,`hasFan`) VALUES
-- ('','','','','','','','','','');
-- INSERT INTO `PROFILE_Washer_Instance` (`washer_instance_id`,`instance_id`,`avg_loads`,`avg_temp`) VALUES
-- ('','','','');
-- INSERT INTO `PROFILE_Dryer_instance` (`dryer_instance_id`,`instance_Id`,`avg_loads`,`avg_temp`) VALUES
-- ('','','','');
-- INSERT INTO `PROFILE_Pool_instance` (`pool_instance_id`,`instance_id`,`isHeated`,`avgTemp`,`usage_period`) VALUES
-- ('','','','','');
-- INSERT INTO `PROFILE_Hottub_instance` (`hottub_instance_id`,`instance_id`,`weekly_usage`,`useage_period`,`avg_temp`) VALUES
-- ('','','','','');
-- INSERT INTO `PROFILE_Home_instance` (`home_instance_id`,`profile_id`,`residents`,`wndow_type`,`window_size`,`window_pane_type`) VALUES
-- ('','','','','','');
-- INSERT INTO `GOALS_Archetype` (`archetype_id`,`category_id`,`description`,`unit`,`creator_id`) VALUES
-- ('','','','','');
-- INSERT INTO `GOALS_Category` (`category_id`,`name`) VALUES
-- ('','');
-- INSERT INTO `GOALS_Instance` (`instance_id`,`profile_id`,`goal_archetype_id`,`start_date`,`completion_date`,`completed_value`,`completed`) VALUES
-- ('','','','','','','');

