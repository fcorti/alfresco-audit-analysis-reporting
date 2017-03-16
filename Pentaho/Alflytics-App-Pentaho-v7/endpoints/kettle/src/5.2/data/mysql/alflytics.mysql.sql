DROP DATABASE alflytics;
CREATE DATABASE alflytics;
USE alflytics;

CREATE TABLE `DWH_ALF_DIM_INSTANCES`(`ID` SMALLINT NOT NULL PRIMARY KEY,`DESCRIPTION` VARCHAR(1024) NOT NULL,`LOGIN` VARCHAR(1024) NOT NULL,`PASSWORD` VARCHAR(1024) NOT NULL,`PROTOCOL` VARCHAR(1024) NOT NULL,`HOST` VARCHAR(1024) NOT NULL,`PORT` VARCHAR(1024) NOT NULL,`USER_LIMIT` INTEGER NOT NULL,`AUDIT_LIMIT` INTEGER NOT NULL,`NODE_LIMIT` INTEGER NOT NULL,`WORKFLOW_LIMIT` INTEGER NOT NULL,`IS_ACTIVE` CHARACTER(1) DEFAULT 'Y' NOT NULL);

CREATE TABLE `DWH_DATA_QUALITY`(`SOURCE_TYPE` VARCHAR(1024) NOT NULL,`SOURCE_ID` SMALLINT NOT NULL,`BATCH_ID` VARCHAR(1024) NOT NULL,`ENTITIES` VARCHAR(1024) NOT NULL,`LAYER` VARCHAR(1024) NOT NULL,`VALUE` INTEGER NOT NULL,`CREATION` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP());

CREATE TABLE `DWH_DATA_QUALITY_LOGS`(`SOURCE_TYPE` VARCHAR(1024) NOT NULL,`SOURCE_ID` SMALLINT NOT NULL,`BATCH_ID` VARCHAR(1024) NOT NULL,`DESCRIPTION` VARCHAR(1024) NOT NULL,`BATCH_START` DATETIME NOT NULL,`BATCH_END` DATETIME NOT NULL,`SUCCESS` CHARACTER(1) NOT NULL);

CREATE TABLE `DWH_ALF_CLASSES`(`ID` SMALLINT NOT NULL PRIMARY KEY,`NAME` VARCHAR(1024) NOT NULL,`IS_FILE` CHARACTER(1) NOT NULL,`IS_FOLDER` CHARACTER(1) NOT NULL,`IS_ASPECT` CHARACTER(1) NOT NULL,`IS_ROOT` CHARACTER(1) NOT NULL,`OPE_TABLE_NAME` VARCHAR(1024) NOT NULL,`DWH_TABLE_NAME` VARCHAR(1024),`ORDINAL` SMALLINT NOT NULL,`INSTANCE_ID` SMALLINT NOT NULL,`IS_ACTIVE` CHARACTER(1) DEFAULT 'Y' NOT NULL,CONSTRAINT `FK_DWH_ALF_CLASSES_DWH_ALF_DIM_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE UNIQUE INDEX `UNQ_DWH_ALF_CLASSES` ON `DWH_ALF_CLASSES`(`INSTANCE_ID`,`NAME`);

CREATE TABLE `STG_ALF_NODES`(`INSTANCE_ID` SMALLINT NOT NULL,`ID` VARCHAR(1024) NOT NULL,`IS_MODIFIED` CHARACTER(1) NOT NULL,`ENTRY` TEXT NOT NULL,`FILE_NAME` VARCHAR(1024) NOT NULL,CONSTRAINT `PK_STG_ALF_NODES` PRIMARY KEY(`INSTANCE_ID`,`ID`),CONSTRAINT `FK_STG_ALF_NODES_DWH_ALF_DIM_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `STG_ALF_CATEGORIES`(`INSTANCE_ID` SMALLINT NOT NULL,`ID` VARCHAR(1024) NOT NULL,`IS_MODIFIED` CHARACTER(1) NOT NULL,`ENTRY` TEXT NOT NULL,`FILE_NAME` VARCHAR(1024) NOT NULL,CONSTRAINT `PK_STG_ALF_CATEGORIES` PRIMARY KEY(`INSTANCE_ID`,`ID`),CONSTRAINT `FK_STG_ALF_CATEGORIES_DWH_ALF_DIM_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `DWH_ALF_CLASS_PROPERTIES`(`ID` SMALLINT NOT NULL PRIMARY KEY,`NAME` VARCHAR(1024) NOT NULL,`TYPE` VARCHAR(1024) NOT NULL,`IS_MULTIVALUE` CHARACTER(1) DEFAULT 'N' NOT NULL,`OPE_TABLE_NAME` VARCHAR(1024),`IS_OPE_INDEXED` CHARACTER(1),`DWH_TABLE_NAME` VARCHAR(1024),`IS_DWH_INDEXED` CHARACTER(1),`JSON_PATH` VARCHAR(1024) NOT NULL,`FIELD_NAME` VARCHAR(1024) NOT NULL,`CLASS_ID` SMALLINT NOT NULL,`IS_ACTIVE` CHARACTER(1) DEFAULT 'Y' NOT NULL,CONSTRAINT `FK_DWH_ALF_CLASS_PROPERTIES_DWH_ALF_CLASSES` FOREIGN KEY(`CLASS_ID`) REFERENCES `DWH_ALF_CLASSES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE UNIQUE INDEX `UNQ_DWH_ALF_CLASS_PROPERTIES` ON `DWH_ALF_CLASS_PROPERTIES`(`CLASS_ID`,`NAME`);

CREATE INDEX `IDX_DWH_ALF_CLASS_PROPERTIES_CLASS_ID` ON `DWH_ALF_CLASS_PROPERTIES`(`CLASS_ID`);

CREATE TABLE `STG_ALF_USERS`(`INSTANCE_ID` SMALLINT NOT NULL,`ID` VARCHAR(1024) NOT NULL,`IS_MODIFIED` CHARACTER(1) NOT NULL,`ENTRY` TEXT NOT NULL,`FILE_NAME` VARCHAR(1024) NOT NULL,CONSTRAINT `PK_STG_ALF_USERS` PRIMARY KEY(`INSTANCE_ID`,`ID`),CONSTRAINT `FK_STG_ALF_USERS_DWH_ALF_DIM_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `OPE_ALF_USERS`(`INSTANCE_ID` SMALLINT NOT NULL,`ID` VARCHAR(1024) NOT NULL,`EMAIL` VARCHAR(1024),`FIRST_NAME` VARCHAR(1024) NOT NULL,`LAST_NAME` VARCHAR(1024),`ORGANIZATION` VARCHAR(1024),`IS_EMAIL_NOTIFICATIONS_ENABLED` BOOLEAN,`IS_ENABLED` BOOLEAN,CONSTRAINT `PK_OPE_ALF_USERS` PRIMARY KEY(`INSTANCE_ID`,`ID`),CONSTRAINT `FK_OPE_ALF_USERS_DWH_ALF_DIM_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `DWH_ALF_DIM_USERS`(`ID` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,`ALF_ID` VARCHAR(1024) NOT NULL,`EMAIL` VARCHAR(1024) NOT NULL,`FIRST_NAME` VARCHAR(1024) NOT NULL,`LAST_NAME` VARCHAR(1024) NOT NULL,`ORGANIZATION` VARCHAR(1024) NOT NULL,`IS_EMAIL_NOTIFICATIONS_ENABLED` BOOLEAN NOT NULL,`IS_ENABLED` BOOLEAN NOT NULL,`DT_DELETED` DATE,`INSTANCE_ID` SMALLINT NOT NULL,`SRC_ID` VARCHAR(1024) NOT NULL,CONSTRAINT `FK_DWH_ALF_DIM_USERS_DWH_ALF_DIM_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

ALTER TABLE `DWH_ALF_DIM_USERS` AUTO_INCREMENT=1;

CREATE UNIQUE INDEX `IDX_DWH_ALF_DIM_USERS_SRC_ID` ON `DWH_ALF_DIM_USERS`(`INSTANCE_ID`,`SRC_ID`);

CREATE UNIQUE INDEX `UNQ_DWH_ALF_DIM_USERS` ON `DWH_ALF_DIM_USERS`(`ALF_ID`,`INSTANCE_ID`);

CREATE TABLE `OPE_ALF_CATEGORIES`(`INSTANCE_ID` SMALLINT NOT NULL,`NODE_UUID` VARCHAR(1024) NOT NULL,`NODE_TYPE` VARCHAR(1024) NOT NULL,`NAME` VARCHAR(1024) NOT NULL,`CREATED_AT` DATETIME NOT NULL,`CREATED_BY` VARCHAR(1024) NOT NULL,`MODIFIED_AT` DATETIME NOT NULL,`MODIFIED_BY` VARCHAR(1024) NOT NULL,`PARENT_NODE_UUID` VARCHAR(1024) NOT NULL,CONSTRAINT `PK_OPE_ALF_CATEGORIES` PRIMARY KEY(`INSTANCE_ID`,`NODE_UUID`));

CREATE TABLE `DWH_DIM_DATES_YEARS`(`ID` SMALLINT PRIMARY KEY,`DESCRIPTION` VARCHAR(1024) NOT NULL);

CREATE TABLE `DWH_DIM_DATES_MONTHS`(`ID` DATE PRIMARY KEY,`DESCRIPTION` VARCHAR(1024) NOT NULL,`MONTH_DESCRIPTION` VARCHAR(1024) NOT NULL,`YEAR_ID` SMALLINT NOT NULL,FOREIGN KEY(`YEAR_ID`) REFERENCES `DWH_DIM_DATES_YEARS`(`ID`));

CREATE TABLE `DWH_DIM_DATES`(`ID` DATE PRIMARY KEY,`DESCRIPTION` VARCHAR(1024) NOT NULL,`DATE_DESCRIPTION` VARCHAR(1024) NOT NULL,`MONTH_ID` DATE NOT NULL,FOREIGN KEY(`MONTH_ID`) REFERENCES `DWH_DIM_DATES_MONTHS`(`ID`));

CREATE TABLE `DWH_ALF_DIM_CATEGORIES`(`ID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,`NAME` VARCHAR(1024) NOT NULL,`CREATED_AT` DATE NOT NULL,`CREATED_BY` INTEGER NOT NULL,`MODIFIED_AT` DATE NOT NULL,`MODIFIED_BY` INTEGER NOT NULL,`PARENT_ID` INTEGER NOT NULL,`INSTANCE_ID` SMALLINT NOT NULL,`SRC_ID` VARCHAR(1024) NOT NULL,FOREIGN KEY(`CREATED_BY`) REFERENCES `DWH_ALF_DIM_USERS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,FOREIGN KEY(`MODIFIED_BY`) REFERENCES `DWH_ALF_DIM_USERS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,FOREIGN KEY(`CREATED_AT`) REFERENCES `DWH_DIM_DATES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,FOREIGN KEY(`MODIFIED_AT`) REFERENCES `DWH_DIM_DATES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,FOREIGN KEY(`PARENT_ID`) REFERENCES `DWH_ALF_DIM_CATEGORIES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

ALTER TABLE `DWH_ALF_DIM_CATEGORIES` AUTO_INCREMENT=1;

CREATE UNIQUE INDEX `IDX_DWH_ALF_DIM_CATEGORIES_SRC_ID` ON `DWH_ALF_DIM_CATEGORIES`(`INSTANCE_ID`,`SRC_ID`);

CREATE TABLE `DWH_ALF_DIM_TAGS`(`ID` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,`NAME` VARCHAR(1024) NOT NULL,`CREATED_AT` DATE NOT NULL,`CREATED_BY` INTEGER NOT NULL,`MODIFIED_AT` DATE NOT NULL,`MODIFIED_BY` INTEGER NOT NULL,`INSTANCE_ID` SMALLINT NOT NULL,`SRC_ID` VARCHAR(1024) NOT NULL,FOREIGN KEY(`CREATED_BY`) REFERENCES `DWH_ALF_DIM_USERS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,FOREIGN KEY(`MODIFIED_BY`) REFERENCES `DWH_ALF_DIM_USERS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,FOREIGN KEY(`CREATED_AT`) REFERENCES `DWH_DIM_DATES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,FOREIGN KEY(`MODIFIED_AT`) REFERENCES `DWH_DIM_DATES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

ALTER TABLE `DWH_ALF_DIM_TAGS` AUTO_INCREMENT=1;

CREATE UNIQUE INDEX `IDX_DWH_ALF_DIM_TAGS_SRC_ID` ON `DWH_ALF_DIM_TAGS`(`INSTANCE_ID`,`SRC_ID`);

CREATE TABLE `DWH_ALF_DIM_NODE_TYPES`(`ID` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,`DESCRIPTION` VARCHAR(1024) NOT NULL,`INSTANCE_ID` SMALLINT NOT NULL,`SRC_ID` VARCHAR(1024) NOT NULL,CONSTRAINT `FK_DWH_ALF_DIM_NODE_TYPES_DWH_ALF_DIM_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`));

ALTER TABLE `DWH_ALF_DIM_NODE_TYPES` AUTO_INCREMENT=1;

CREATE UNIQUE INDEX `IDX_DWH_ALF_DIM_NODE_TYPES_SRC_ID` ON `DWH_ALF_DIM_NODE_TYPES`(`INSTANCE_ID`,`SRC_ID`);

CREATE TABLE `DWH_ALF_DIM_MIME_TYPES`(`ID` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,`DESCRIPTION` VARCHAR(1024) NOT NULL,`INSTANCE_ID` SMALLINT NOT NULL,`SRC_ID` VARCHAR(1024) NOT NULL,CONSTRAINT `FK_DWH_ALF_DIM_MIME_TYPES_DWH_ALF_DIM_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`));

ALTER TABLE `DWH_ALF_DIM_MIME_TYPES` AUTO_INCREMENT=1;

CREATE UNIQUE INDEX `IDX_DWH_ALF_DIM_MIME_TYPES_SRC_ID` ON `DWH_ALF_DIM_MIME_TYPES`(`INSTANCE_ID`,`SRC_ID`);

CREATE TABLE `DWH_DIM_TIME_HOURS`(`ID` SMALLINT NOT NULL PRIMARY KEY,`DESCRIPTION` VARCHAR(1024) NOT NULL);

CREATE TABLE `DWH_DIM_TIME_MINUTES`(`ID` SMALLINT NOT NULL PRIMARY KEY,`DESCRIPTION` VARCHAR(1024) NOT NULL,`HOUR_ID` SMALLINT NOT NULL,CONSTRAINT `FK_DWH_DIM_TIME_MINUTES_DWH_DIM_TIME_HOURS` FOREIGN KEY(`HOUR_ID`) REFERENCES `DWH_DIM_TIME_HOURS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `DWH_ALF_DIM_CONTENTS`(`ID` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,`NAME` VARCHAR(1024) NOT NULL,`NODE_TYPE_ID` INTEGER NOT NULL,`MIME_TYPE_ID` INTEGER NOT NULL,`CREATED_DT` DATE NOT NULL,`CREATED_AT` SMALLINT NOT NULL,`CREATED_BY_ID` INTEGER NOT NULL,`MODIFIED_DT` DATE NOT NULL,`MODIFIED_AT` SMALLINT NOT NULL,`MODIFIED_BY_ID` INTEGER NOT NULL,`OWNER_ID` INTEGER NOT NULL,`SIZE_IN_BYTES` INTEGER NOT NULL,`PARENT_ID` INTEGER NOT NULL,`INSTANCE_ID` SMALLINT NOT NULL,`SRC_ID` VARCHAR(1024) NOT NULL,CONSTRAINT `FK_DWH_ALF_DIM_CONTENTS_DWH_ALF_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_CONTENTS_DWH_ALF_DIM_NODE_TYPES` FOREIGN KEY(`NODE_TYPE_ID`) REFERENCES `DWH_ALF_DIM_NODE_TYPES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_CONTENTS_DWH_ALF_DIM_MIME_TYPES` FOREIGN KEY(`MIME_TYPE_ID`) REFERENCES `DWH_ALF_DIM_MIME_TYPES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_CONTENTS_DWH_ALF_DIM_DATES_CREATED` FOREIGN KEY(`CREATED_DT`) REFERENCES `DWH_DIM_DATES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_CONTENTS_DWH_ALF_DIM_DATES_MODIFIED` FOREIGN KEY(`MODIFIED_DT`) REFERENCES `DWH_DIM_DATES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_CONTENTS_DWH_ALF_DIM_MINUTES_CREATED` FOREIGN KEY(`CREATED_AT`) REFERENCES `DWH_DIM_TIME_MINUTES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_CONTENTS_DWH_ALF_DIM_MINUTES_MODIFIED` FOREIGN KEY(`MODIFIED_AT`) REFERENCES `DWH_DIM_TIME_MINUTES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_CONTENTS_DWH_ALF_DIM_USERS_CREATED` FOREIGN KEY(`CREATED_BY_ID`) REFERENCES `DWH_ALF_DIM_USERS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_CONTENTS_DWH_ALF_DIM_USERS_MODIFIED` FOREIGN KEY(`MODIFIED_BY_ID`) REFERENCES `DWH_ALF_DIM_USERS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_CONTENTS_DWH_ALF_DIM_USERS_OWNER` FOREIGN KEY(`OWNER_ID`) REFERENCES `DWH_ALF_DIM_USERS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

ALTER TABLE `DWH_ALF_DIM_CONTENTS` AUTO_INCREMENT=1;

CREATE UNIQUE INDEX `IDX_DWH_ALF_DIM_CONTENTS_SRC_ID` ON `DWH_ALF_DIM_CONTENTS`(`INSTANCE_ID`,`SRC_ID`);

CREATE TABLE `DWH_ALF_DIM_FOLDERS`(`ID` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,`NAME` VARCHAR(1024) NOT NULL,`NODE_TYPE_ID` INTEGER NOT NULL,`CREATED_DT` DATE NOT NULL,`CREATED_AT` SMALLINT NOT NULL,`CREATED_BY_ID` INTEGER NOT NULL,`MODIFIED_DT` DATE NOT NULL,`MODIFIED_AT` SMALLINT NOT NULL,`MODIFIED_BY_ID` INTEGER NOT NULL,`OWNER_ID` INTEGER NOT NULL,`PARENT_ID` INTEGER NOT NULL,`INSTANCE_ID` SMALLINT NOT NULL,`SRC_ID` VARCHAR(1024) NOT NULL,CONSTRAINT `FK_DWH_ALF_DIM_FOLDERS_DWH_ALF_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_FOLDERS_DWH_ALF_DIM_NODE_TYPES` FOREIGN KEY(`NODE_TYPE_ID`) REFERENCES `DWH_ALF_DIM_NODE_TYPES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_FOLDERS_DWH_ALF_DIM_DATES_CREATED` FOREIGN KEY(`CREATED_DT`) REFERENCES `DWH_DIM_DATES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_FOLDERS_DWH_ALF_DIM_DATES_MODIFIED` FOREIGN KEY(`MODIFIED_DT`) REFERENCES `DWH_DIM_DATES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_FOLDERS_DWH_ALF_DIM_MINUTES_CREATED` FOREIGN KEY(`CREATED_AT`) REFERENCES `DWH_DIM_TIME_MINUTES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_FOLDERS_DWH_ALF_DIM_MINUTES_MODIFIED` FOREIGN KEY(`MODIFIED_AT`) REFERENCES `DWH_DIM_TIME_MINUTES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_FOLDERS_DWH_ALF_DIM_USERS_CREATED` FOREIGN KEY(`CREATED_BY_ID`) REFERENCES `DWH_ALF_DIM_USERS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_FOLDERS_DWH_ALF_DIM_USERS_MODIFIED` FOREIGN KEY(`MODIFIED_BY_ID`) REFERENCES `DWH_ALF_DIM_USERS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_FOLDERS_DWH_ALF_DIM_USERS_OWNER` FOREIGN KEY(`OWNER_ID`) REFERENCES `DWH_ALF_DIM_USERS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_FOLDERS_DWH_ALF_DIM_FOLDERS` FOREIGN KEY(`PARENT_ID`) REFERENCES `DWH_ALF_DIM_FOLDERS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

ALTER TABLE `DWH_ALF_DIM_FOLDERS` AUTO_INCREMENT=1;

CREATE UNIQUE INDEX `IDX_DWH_ALF_DIM_FOLDERS_SRC_ID` ON `DWH_ALF_DIM_FOLDERS`(`INSTANCE_ID`,`SRC_ID`);

CREATE TABLE `DWH_ALF_DIM_CONTENT_TAGS`(`CONTENT_ID` INTEGER NOT NULL,`ORDINAL` SMALLINT NOT NULL,`TAG_ID` INTEGER NOT NULL,`INSTANCE_ID` SMALLINT NOT NULL,CONSTRAINT `PK_DWH_ALF_DIM_CONTENT_TAGS` PRIMARY KEY(`INSTANCE_ID`,`CONTENT_ID`,`ORDINAL`),CONSTRAINT `FK_DWH_ALF_DIM_CONTENT_TAGS_DWH_ALF_DIM_CONTENTS` FOREIGN KEY(`CONTENT_ID`) REFERENCES `DWH_ALF_DIM_CONTENTS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_CONTENT_TAGS_DWH_ALF_DIM_TAGS` FOREIGN KEY(`TAG_ID`) REFERENCES `DWH_ALF_DIM_TAGS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `DWH_ALF_DIM_FOLDER_TAGS`(`FOLDER_ID` INTEGER NOT NULL,`ORDINAL` SMALLINT NOT NULL,`TAG_ID` INTEGER NOT NULL,`INSTANCE_ID` SMALLINT NOT NULL,CONSTRAINT `PK_DWH_ALF_DIM_FOLDER_TAGS` PRIMARY KEY(`INSTANCE_ID`,`FOLDER_ID`,`ORDINAL`),CONSTRAINT `FK_DWH_ALF_DIM_FOLDER_TAGS_DWH_ALF_DIM_FOLDERS` FOREIGN KEY(`FOLDER_ID`) REFERENCES `DWH_ALF_DIM_FOLDERS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_FOLDER_TAGS_DWH_ALF_DIM_TAGS` FOREIGN KEY(`TAG_ID`) REFERENCES `DWH_ALF_DIM_TAGS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `DWH_ALF_DIM_FOLDER_CATEGORIES`(`FOLDER_ID` INTEGER NOT NULL,`ORDINAL` SMALLINT NOT NULL,`CATEGORY_ID` INTEGER NOT NULL,`INSTANCE_ID` SMALLINT NOT NULL,CONSTRAINT `PK_DWH_ALF_DIM_FOLDER_CATEGORIES` PRIMARY KEY(`INSTANCE_ID`,`FOLDER_ID`,`ORDINAL`),CONSTRAINT `FK_DWH_ALF_DIM_FOLDER_CATEGORIES_DWH_ALF_DIM_FOLDERS` FOREIGN KEY(`FOLDER_ID`) REFERENCES `DWH_ALF_DIM_FOLDERS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_FOLDER_CATEGORIES_DWH_ALF_DIM_CATEGORIES` FOREIGN KEY(`CATEGORY_ID`) REFERENCES `DWH_ALF_DIM_CATEGORIES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `DWH_ALF_DIM_CONTENT_CATEGORIES`(`CONTENT_ID` INTEGER NOT NULL,`ORDINAL` SMALLINT NOT NULL,`CATEGORY_ID` INTEGER NOT NULL,`INSTANCE_ID` SMALLINT NOT NULL,CONSTRAINT `PK_DWH_ALF_DIM_CONTENT_CATEGORIES` PRIMARY KEY(`INSTANCE_ID`,`CONTENT_ID`,`ORDINAL`),CONSTRAINT `FK_DWH_ALF_DIM_CONTENT_CATEGORIES_DWH_ALF_DIM_CONTENTS` FOREIGN KEY(`CONTENT_ID`) REFERENCES `DWH_ALF_DIM_CONTENTS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_CONTENT_CATEGORIES_DWH_ALF_DIM_CATEGORIES` FOREIGN KEY(`CATEGORY_ID`) REFERENCES `DWH_ALF_DIM_CATEGORIES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `STG_ALF_WF_DEPLOYMENTS`(`INSTANCE_ID` SMALLINT NOT NULL,`ID` INTEGER NOT NULL,`IS_MODIFIED` CHARACTER(1) NOT NULL,`ENTRY` TEXT NOT NULL,`FILE_NAME` VARCHAR(1024) NOT NULL,CONSTRAINT `PK_STG_ALF_WF_DEPLOYMENTS` PRIMARY KEY(`INSTANCE_ID`,`ID`),CONSTRAINT `FK_STG_ALF_WF_DEPLOYMENTS_DWH_ALF_DIM_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `STG_ALF_WF_DEFINITIONS`(`INSTANCE_ID` SMALLINT NOT NULL,`ID` VARCHAR(1024) NOT NULL,`IS_MODIFIED` CHARACTER(1) NOT NULL,`ENTRY` TEXT NOT NULL,`FILE_NAME` VARCHAR(1024) NOT NULL,CONSTRAINT `PK_STG_ALF_WF_DEFINITIONS` PRIMARY KEY(`INSTANCE_ID`,`ID`),CONSTRAINT `FK_STG_ALF_WF_DEFINITIONS_DWH_ALF_DIM_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `STG_ALF_WF_TASKS`(`INSTANCE_ID` SMALLINT NOT NULL,`ID` INTEGER NOT NULL,`IS_MODIFIED` CHARACTER(1) NOT NULL,`ENTRY` TEXT NOT NULL,`FILE_NAME` VARCHAR(1024) NOT NULL,CONSTRAINT `PK_STG_ALF_WF_TASKS` PRIMARY KEY(`INSTANCE_ID`,`ID`),CONSTRAINT `FK_STG_ALF_WF_TASKS_DWH_ALF_DIM_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `STG_ALF_WF_ITEMS`(`INSTANCE_ID` SMALLINT NOT NULL,`ID` VARCHAR(1024) NOT NULL,`IS_MODIFIED` CHARACTER(1) NOT NULL,`ENTRY` TEXT NOT NULL,`FILE_NAME` VARCHAR(1024) NOT NULL,CONSTRAINT `FK_STG_ALF_WF_ITEMS_DWH_ALF_DIM_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `OPE_ALF_WF_DEPLOYMENTS`(`INSTANCE_ID` SMALLINT NOT NULL,`ID` INTEGER NOT NULL,`NAME` VARCHAR(1024) NOT NULL,`DEPLOYED_AT` DATETIME NOT NULL,CONSTRAINT `PK_OPE_ALF_WF_DEPLOYMENTS` PRIMARY KEY(`INSTANCE_ID`,`ID`));

CREATE TABLE `OPE_ALF_WF_DEFINITIONS`(`INSTANCE_ID` SMALLINT NOT NULL,`ID` VARCHAR(1024) NOT NULL,`DEPLOYMENT_ID` INTEGER NOT NULL,`NAME` VARCHAR(1024) NOT NULL,`DESCRIPTION` VARCHAR(1024) NOT NULL,`VERSION` INTEGER NOT NULL,`KEY` VARCHAR(1024) NOT NULL,CONSTRAINT `PK_OPE_ALF_WF_DEFINITIONS` PRIMARY KEY(`INSTANCE_ID`,`ID`),CONSTRAINT `FK_OPE_ALF_WF_DEFINITIONS_OPE_ALF_WF_DEPLOYMENTS` FOREIGN KEY(`INSTANCE_ID`,`DEPLOYMENT_ID`) REFERENCES `OPE_ALF_WF_DEPLOYMENTS`(`INSTANCE_ID`,`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `STG_ALF_WF_INSTANCES`(`INSTANCE_ID` SMALLINT NOT NULL,`ID` INTEGER NOT NULL,`IS_MODIFIED` CHARACTER(1) NOT NULL,`ENTRY` TEXT NOT NULL,`FILE_NAME` VARCHAR(1024) NOT NULL,CONSTRAINT `PK_STG_ALF_WF_INSTANCES` PRIMARY KEY(`INSTANCE_ID`,`ID`),CONSTRAINT `FK_STG_ALF_WF_INSTANCES_DWH_ALF_DIM_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `OPE_ALF_WF_INSTANCES`(`INSTANCE_ID` SMALLINT NOT NULL,`ID` INTEGER NOT NULL,`DEFINITION_ID` VARCHAR(1024) NOT NULL,`COMPLETED` BOOLEAN NOT NULL,`STARTED_AT` DATETIME NOT NULL,`ENDED_AT`  DATETIME NULL,CONSTRAINT `PK_OPE_ALF_WF_INSTANCES` PRIMARY KEY(`INSTANCE_ID`,`ID`),CONSTRAINT `FK_OPE_ALF_WF_INSTANCES_OPE_ALF_WF_DEFINITIONS` FOREIGN KEY(`INSTANCE_ID`,`DEFINITION_ID`) REFERENCES `OPE_ALF_WF_DEFINITIONS`(`INSTANCE_ID`,`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `OPE_ALF_WF_TASKS`(`INSTANCE_ID` SMALLINT NOT NULL,`ID` INTEGER NOT NULL,`WF_INSTANCE_ID` INTEGER NOT NULL,`NAME` VARCHAR(1024) NOT NULL,`DESCRIPTION` VARCHAR(1024) NOT NULL,`STARTED_AT` DATETIME NOT NULL,`DUE_AT` DATETIME NULL,`ASSIGNEE` VARCHAR(1024) NOT NULL,`STATE` VARCHAR(1024) NOT NULL,`PRIORITY` INTEGER NOT NULL,`TASK_DEFINITION_ID` VARCHAR(1024) NOT NULL,CONSTRAINT `PK_OPE_ALF_WF_TASKS` PRIMARY KEY(`INSTANCE_ID`,`ID`),CONSTRAINT `FK_OPE_ALF_WF_TASKS_OPE_ALF_WF_INSTANCES` FOREIGN KEY(`INSTANCE_ID`,`WF_INSTANCE_ID`) REFERENCES `OPE_ALF_WF_INSTANCES`(`INSTANCE_ID`,`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `OPE_ALF_WF_ITEMS`(`INSTANCE_ID` SMALLINT NOT NULL,`ID` VARCHAR(1024) NOT NULL,`WF_INSTANCE_ID` INTEGER NOT NULL,CONSTRAINT `PK_OPE_ALF_WF_ITEMS` PRIMARY KEY(`INSTANCE_ID`,`ID`,`WF_INSTANCE_ID`),CONSTRAINT `FK_OPE_ALF_WF_ITEMS_OPE_ALF_WF_INSTANCES` FOREIGN KEY(`INSTANCE_ID`,`WF_INSTANCE_ID`) REFERENCES `OPE_ALF_WF_INSTANCES`(`INSTANCE_ID`,`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `DWH_ALF_DIM_WF_DEPLOYMENTS`(`ID` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,`NAME` VARCHAR(1024) NOT NULL,`DEPLOYED_DT` DATE NOT NULL,`INSTANCE_ID` SMALLINT NOT NULL,`SRC_ID` INTEGER NOT NULL,CONSTRAINT `FK_DWH_ALF_DIM_WF_DEPLOYMENTS_DWH_ALF_DIM_DEPLOYED_DT` FOREIGN KEY(`DEPLOYED_DT`) REFERENCES `DWH_DIM_DATES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_WF_DEPLOYMENTS_DWH_ALF_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

ALTER TABLE `DWH_ALF_DIM_WF_DEPLOYMENTS` AUTO_INCREMENT=1;

CREATE UNIQUE INDEX `IDX_DWH_ALF_DIM_WF_DEPLOYMENTS_SRC_ID` ON `DWH_ALF_DIM_WF_DEPLOYMENTS`(`INSTANCE_ID`,`SRC_ID`);

CREATE TABLE `DWH_ALF_DIM_WF_DEFINITIONS`(`ID` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,`NAME` VARCHAR(1024) NOT NULL,`DESCRIPTION` VARCHAR(1024) NOT NULL,`VERSION` INTEGER NOT NULL,`KEY` VARCHAR(1024) NOT NULL,`DEPLOYMENT_ID` INTEGER NOT NULL,`INSTANCE_ID` SMALLINT NOT NULL,`SRC_ID` VARCHAR(1024) NOT NULL,CONSTRAINT `FK_DWH_ALF_DIM_WF_DEFINITIONS_DWH_ALF_DIM_DEPLOYMENTS` FOREIGN KEY(`DEPLOYMENT_ID`) REFERENCES `DWH_ALF_DIM_WF_DEPLOYMENTS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_WF_DEFINITIONS_DWH_ALF_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

ALTER TABLE `DWH_ALF_DIM_WF_DEFINITIONS` AUTO_INCREMENT=1;

CREATE UNIQUE INDEX `IDX_DWH_ALF_DIM_WF_DEFINITIONS_SRC_ID` ON `DWH_ALF_DIM_WF_DEFINITIONS`(`INSTANCE_ID`,`SRC_ID`);

CREATE TABLE `DWH_ALF_DIM_WF_INSTANCES`(`ID` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,`COMPLETED` BOOLEAN NOT NULL,`STARTED_DT` DATE NOT NULL,`STARTED_AT` SMALLINT NOT NULL,`ENDED_DT` DATE NOT NULL,`ENDED_AT` SMALLINT NOT NULL,`DEFINITION_ID` INTEGER NOT NULL,`INSTANCE_ID` SMALLINT NOT NULL,`SRC_ID` INTEGER NOT NULL,CONSTRAINT `FK_DWH_ALF_DIM_WF_INSTANCES_DWH_ALF_DIM_DEFINITIONS` FOREIGN KEY(`DEFINITION_ID`) REFERENCES `DWH_ALF_DIM_WF_DEFINITIONS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_WF_INSTANCES_DWH_ALF_DIM_DATES_STARTED_DT` FOREIGN KEY(`STARTED_DT`) REFERENCES `DWH_DIM_DATES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_WF_INSTANCES_DWH_ALF_DIM_TIME_MINUTES_STARTED_AT` FOREIGN KEY(`STARTED_AT`) REFERENCES `DWH_DIM_TIME_MINUTES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_WF_INSTANCES_DWH_ALF_DIM_DATES_ENDED_DT` FOREIGN KEY(`ENDED_DT`) REFERENCES `DWH_DIM_DATES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_WF_INSTANCES_DWH_ALF_DIM_TIME_MINUTES_ENDED_AT` FOREIGN KEY(`ENDED_AT`) REFERENCES `DWH_DIM_TIME_MINUTES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_WF_INSTANCES_DWH_ALF_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

ALTER TABLE `DWH_ALF_DIM_WF_INSTANCES` AUTO_INCREMENT=1;

CREATE UNIQUE INDEX `IDX_DWH_ALF_DIM_WF_INSTANCES_SRC_ID` ON `DWH_ALF_DIM_WF_INSTANCES`(`INSTANCE_ID`,`SRC_ID`);

CREATE TABLE `DWH_ALF_DIM_WF_ITEMS`(`CONTENT_ID` INTEGER NOT NULL,`FOLDER_ID` INTEGER NOT NULL,`WF_INSTANCE_ID` INTEGER NOT NULL,`INSTANCE_ID` SMALLINT NOT NULL,`SRC_NODE_ID` VARCHAR(1024) NOT NULL,`SRC_WF_INSTANCE_ID` INTEGER NOT NULL,CONSTRAINT `FK_DWH_ALF_DIM_WF_ITEMS_DWH_ALF_DIM_CONTENTS` FOREIGN KEY(`CONTENT_ID`) REFERENCES `DWH_ALF_DIM_CONTENTS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_WF_ITEMS_DWH_ALF_DIM_FOLDERS` FOREIGN KEY(`FOLDER_ID`) REFERENCES `DWH_ALF_DIM_FOLDERS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_WF_ITEMS_DWH_ALF_DIM_WF_INSTANCES` FOREIGN KEY(`WF_INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_WF_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_WF_ITEMS_DWH_ALF_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE INDEX `IDX_DWH_ALF_DIM_WF_ITEMS_SRC_NODE_ID` ON `DWH_ALF_DIM_WF_ITEMS`(`INSTANCE_ID`,`SRC_NODE_ID`);

CREATE INDEX `IDX_DWH_ALF_DIM_WF_ITEMS_SRC_WF_INSTANCEID` ON `DWH_ALF_DIM_WF_ITEMS`(`INSTANCE_ID`,`SRC_WF_INSTANCE_ID`);

CREATE UNIQUE INDEX `IDX_DWH_ALF_DIM_WF_ITEMS_SRC_WF_INSTANCEID_SRC_NODE_ID` ON `DWH_ALF_DIM_WF_ITEMS`(`INSTANCE_ID`,`SRC_NODE_ID`,`SRC_WF_INSTANCE_ID`);

CREATE TABLE `DWH_ALF_DIM_WF_TASKS`(`ID` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,`NAME` VARCHAR(1024) NOT NULL,`DESCRIPTION` VARCHAR(1024) NOT NULL,`STARTED_DT` DATE NOT NULL,`STARTED_AT` SMALLINT NOT NULL,`DUE_DT` DATE NOT NULL,`DUE_AT` SMALLINT NOT NULL,`ASSIGNEE` VARCHAR(1024) NOT NULL,`STATE` VARCHAR(1024) NOT NULL,`PRIORITY` INTEGER NOT NULL,`TASK_DEFINITION_ID` VARCHAR(1024) NOT NULL,`WF_INSTANCE_ID` INTEGER NOT NULL,`INSTANCE_ID` SMALLINT NOT NULL,`SRC_ID` INTEGER NOT NULL,CONSTRAINT `FK_DWH_ALF_DIM_WF_TASKS_DWH_ALF_DIM_DATES_STARTED_DT` FOREIGN KEY(`STARTED_DT`) REFERENCES `DWH_DIM_DATES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_WF_TASKS_DWH_ALF_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_WF_TASKS_DWH_ALF_DIM_WF_INSTANCES` FOREIGN KEY(`WF_INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_WF_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_WF_TASKS_DWH_ALF_DIM_DATES_DUE_AT` FOREIGN KEY(`DUE_DT`) REFERENCES `DWH_DIM_DATES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_WF_TASKS_DWH_ALF_DIM_TIME_MINUTES_DUE_AT` FOREIGN KEY(`DUE_AT`) REFERENCES `DWH_DIM_TIME_MINUTES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_DIM_WF_TASKS_DWH_ALF_DIM_TIME_MINUTES_STARTED_AT` FOREIGN KEY(`STARTED_AT`) REFERENCES `DWH_DIM_TIME_MINUTES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

ALTER TABLE `DWH_ALF_DIM_WF_TASKS` AUTO_INCREMENT=1;

CREATE UNIQUE INDEX `IDX_DWH_ALF_DIM_WF_TASKS_SRC_ID` ON `DWH_ALF_DIM_WF_TASKS`(`INSTANCE_ID`,`SRC_ID`);

CREATE TABLE `STG_ALF_AUDITS`(`INSTANCE_ID` SMALLINT NOT NULL,`ID` INTEGER NOT NULL,`APPLICATION` VARCHAR(1024) NOT NULL,`ENTRY` TEXT NOT NULL,`FILE_NAME` VARCHAR(1024) NOT NULL,CONSTRAINT `PK_STG_ALF_AUDITS` PRIMARY KEY(`INSTANCE_ID`,`ID`,`APPLICATION`),CONSTRAINT `FK_STG_ALF_AUDITS_DWH_ALF_DIM_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `DWH_ALF_AUDIT_APPS`(`ID` SMALLINT NOT NULL PRIMARY KEY,`NAME` VARCHAR(1024) NOT NULL,`URL_SUFFIX` VARCHAR(1024) NOT NULL,`QUERY_MAX_ID` VARCHAR(1024) NOT NULL,`OPE_TABLE_NAME` VARCHAR(1024) NOT NULL,`ORDINAL` SMALLINT NOT NULL,`INSTANCE_ID` SMALLINT NOT NULL,`IS_ACTIVE` CHARACTER(1) DEFAULT 'Y' NOT NULL,CONSTRAINT `FK_DWH_ALF_AUDIT_APPS_DWH_ALF_DIM_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `DWH_ALF_AUDIT_PROPERTIES`(`ID` SMALLINT NOT NULL PRIMARY KEY,`NAME` VARCHAR(1024) NOT NULL,`TYPE` VARCHAR(1024) NOT NULL,`IS_OPE_INDEXED` CHARACTER(1),`JSON_PATH` VARCHAR(1024) NOT NULL,`FIELD_NAME` VARCHAR(1024) NOT NULL,`APP_ID` SMALLINT NOT NULL,`IS_ACTIVE` CHARACTER(1) DEFAULT 'Y' NOT NULL,CONSTRAINT `FK_DWH_ALF_AUDIT_PROPERTIES_DWH_ALF_AUDIT_APPS` FOREIGN KEY(`APP_ID`) REFERENCES `DWH_ALF_AUDIT_APPS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE `DWH_ALF_DIM_ACTIONS`(`ID` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,`DESCRIPTION` VARCHAR(1024) NOT NULL,`INSTANCE_ID` SMALLINT NOT NULL,`SRC_ID` VARCHAR(1024) NOT NULL,CONSTRAINT `FK_DWH_ALF_DIM_ACTIONS_DWH_ALF_DIM_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`));

ALTER TABLE `DWH_ALF_DIM_ACTIONS` AUTO_INCREMENT=1;

CREATE UNIQUE INDEX `IDX_DWH_ALF_DIM_ACTIONS_SRC_ID` ON `DWH_ALF_DIM_ACTIONS`(`INSTANCE_ID`,`SRC_ID`);

CREATE TABLE `DWH_ALF_FACT_ACCESSES`(`USER_ID` INTEGER NOT NULL,`DATE_ID` DATE NOT NULL,`MINUTE_ID` SMALLINT NOT NULL,`ACTION_ID` INTEGER NOT NULL,`USER_DESCRIPTION` VARCHAR(1024) NOT NULL,`NODE_PATH` VARCHAR(1024) NOT NULL,`INSTANCE_ID` SMALLINT NOT NULL,`APP_ID` SMALLINT NOT NULL,`SRC_ID` INTEGER NOT NULL,CONSTRAINT `PK_DWH_ALF_FACT_ACCESSES` PRIMARY KEY(`INSTANCE_ID`,`APP_ID`,`SRC_ID`),CONSTRAINT `FK_DWH_ALF_FACT_ACCESSES_DWH_ALF_INSTANCES` FOREIGN KEY(`INSTANCE_ID`) REFERENCES `DWH_ALF_DIM_INSTANCES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_FACT_ACCESSES_DWH_ALF_DIM_USERS` FOREIGN KEY(`USER_ID`) REFERENCES `DWH_ALF_DIM_USERS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_FACT_ACCESSES_DWH_DIM_DATES` FOREIGN KEY(`DATE_ID`) REFERENCES `DWH_DIM_DATES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_FACT_ACCESSES_DWH_DIM_MINUTES` FOREIGN KEY(`MINUTE_ID`) REFERENCES `DWH_DIM_TIME_MINUTES`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_FACT_ACCESSES_DWH_ALF_DIM_ACTIONS` FOREIGN KEY(`ACTION_ID`) REFERENCES `DWH_ALF_DIM_ACTIONS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,CONSTRAINT `FK_DWH_ALF_FACT_ACCESSES_DWH_ALF_AUDIT_APPS` FOREIGN KEY(`APP_ID`) REFERENCES `DWH_ALF_AUDIT_APPS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE);

ALTER TABLE `DWH_ALF_DIM_CONTENTS` ADD CONSTRAINT `FK_DWH_ALF_DIM_CONTENTS_DWH_ALF_DIM_FOLDERS` FOREIGN KEY(`PARENT_ID`) REFERENCES `DWH_ALF_DIM_FOLDERS`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE VIEW `VW_DWH_ALF_FACT_TAGS` AS SELECT `CONTENT_ID`, -`INSTANCE_ID` AS `FOLDER_ID`, `ORDINAL`,`TAG_ID`,`INSTANCE_ID` FROM `DWH_ALF_DIM_CONTENT_TAGS` UNION ALL SELECT -`INSTANCE_ID` AS `CONTENT_ID`,`FOLDER_ID`,`ORDINAL`,`TAG_ID`,`INSTANCE_ID` FROM `DWH_ALF_DIM_FOLDER_TAGS`;

CREATE VIEW `VW_DWH_ALF_FACT_CATEGORIES` AS SELECT `CONTENT_ID`, -`INSTANCE_ID` AS `FOLDER_ID`, `ORDINAL`,`CATEGORY_ID`,`INSTANCE_ID` FROM `DWH_ALF_DIM_CONTENT_CATEGORIES` UNION ALL SELECT -`INSTANCE_ID` AS `CONTENT_ID`,`FOLDER_ID`,`ORDINAL`,`CATEGORY_ID`,`INSTANCE_ID` FROM `DWH_ALF_DIM_FOLDER_CATEGORIES`;

INSERT INTO `DWH_ALF_DIM_INSTANCES` VALUES(1,'Alfresco','admin','admin','http','localhost','8080',5000,5000,5000,5000,'Y');
INSERT INTO `DWH_ALF_CLASSES` VALUES(1,'cm:content','Y','N','N','Y','OPE_ALF_CONTENTS',NULL,1,1,'Y');
INSERT INTO `DWH_ALF_CLASSES` VALUES(2,'cm:folder','N','Y','N','Y','OPE_ALF_FOLDERS',NULL,2,1,'Y');
INSERT INTO `DWH_ALF_CLASSES` VALUES(3,'exif:exif','N','N','Y','N','OPE_ALF_ASPECT_EXIF','DWH_ALF_DIM_ASPECT_EXIF',3,1,'Y');
INSERT INTO `DWH_ALF_CLASSES` VALUES(4,'dl:dataList','N','Y','N','N','OPE_ALF_FOLDER_DATALIST','DWH_ALF_DIM_FOLDER_DATALIST',4,1,'Y');
INSERT INTO `DWH_ALF_CLASSES` VALUES(5,'dl:todoList','Y','N','N','N','OPE_ALF_CONTENT_TODOLIST','DWH_ALF_DIM_CONTENT_TODOLIST',5,1,'Y');
INSERT INTO `DWH_ALF_CLASSES` VALUES(6,'cm:versionable','N','N','Y','N','OPE_ALF_ASPECT_VERSIONABLE','DWH_ALF_DIM_ASPECT_VERSIONABLE',6,1,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(1,'cm:node_type','d:text','N',NULL,NULL,NULL,NULL,'["nodeType"]','NODE_TYPE',1,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(2,'cm:name','d:text','N',NULL,'Y',NULL,NULL,'["name"]','NAME',1,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(3,'cm:created','d:datetime','N',NULL,NULL,NULL,NULL,'["createdAt"]','CREATED_AT',1,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(4,'cm:creator','d:text','N',NULL,'Y',NULL,NULL,'["createdByUser","id"]','CREATED_BY',1,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(5,'cm:modified','d:datetime','N',NULL,NULL,NULL,NULL,'["modifiedAt"]','MODIFIED_AT',1,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(6,'cm:modifier','d:text','N',NULL,'Y',NULL,NULL,'["modifiedByUser","id"]','MODIFIED_BY',1,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(7,'cm:owner','d:text','N',NULL,'Y',NULL,NULL,'["properties","cm:owner","id"]','OWNER',1,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(8,'mimeType','d:text','N',NULL,NULL,NULL,NULL,'["content","mimeType"]','MIME_TYPE',1,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(9,'sizeInBytes','d:int','N',NULL,NULL,NULL,NULL,'["content","sizeInBytes"]','SIZE_IN_BYTES',1,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(10,'cm:taggable','d:category','Y','OPE_ALF_CONTENT_TAGS','Y',NULL,NULL,'["properties","cm:taggable"]','TAG_NODE_UUID',1,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(11,'cm:categories','d:category','Y','OPE_ALF_CONTENT_CATEGORIES','Y',NULL,NULL,'["properties","cm:categories"]','CATEGORY_NODE_UUID',1,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(12,'parent_id','d:text','N',NULL,'Y',NULL,'Y','["parentId"]','PARENT_NODE_UUID',1,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(13,'cm:node_type','d:text','N',NULL,NULL,NULL,NULL,'["nodeType"]','NODE_TYPE',2,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(14,'cm:name','d:text','N',NULL,'Y',NULL,NULL,'["name"]','NAME',2,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(15,'cm:created','d:datetime','N',NULL,NULL,NULL,NULL,'["createdAt"]','CREATED_AT',2,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(16,'cm:creator','d:text','N',NULL,'Y',NULL,NULL,'["createdByUser","id"]','CREATED_BY',2,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(17,'cm:modified','d:datetime','N',NULL,NULL,NULL,NULL,'["modifiedAt"]','MODIFIED_AT',2,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(18,'cm:modifier','d:text','N',NULL,'Y',NULL,NULL,'["modifiedByUser","id"]','MODIFIED_BY',2,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(19,'cm:owner','d:text','N',NULL,'Y',NULL,NULL,'["properties","cm:owner","id"]','OWNER',2,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(20,'cm:taggable','d:category','Y','OPE_ALF_FOLDER_TAGS','Y',NULL,NULL,'["properties","cm:taggable"]','TAG_NODE_UUID',2,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(21,'cm:categories','d:category','Y','OPE_ALF_FOLDER_CATEGORIES','Y',NULL,NULL,'["properties","cm:categories"]','CATEGORY_NODE_UUID',2,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(22,'parent_id','d:text','N',NULL,'Y',NULL,'Y','["parentId"]','PARENT_NODE_UUID',2,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(23,'exif:xResolution','d:int','N',NULL,NULL,NULL,NULL,'["properties","exif:xResolution"]','XRESOLUTION',3,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(24,'exif:yResolution','d:int','N',NULL,'Y',NULL,NULL,'["properties","exif:yResolution"]','YRESOLUTION',3,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(25,'exif:model','d:text','N',NULL,NULL,NULL,NULL,'["properties","exif:model"]','MODEL',3,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(26,'exif:flash','d:boolean','N',NULL,NULL,NULL,NULL,'["properties","exif:flash"]','FLASH',3,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(27,'exif:fNumber','d:float','N',NULL,NULL,NULL,NULL,'["properties","exif:fNumber"]','F_NUMBER',3,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(28,'exif:dateTimeOriginal','d:datetime','N',NULL,'Y',NULL,NULL,'["properties","exif:dateTimeOriginal"]','DT_ORIGINAL',3,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(29,'dl:dataListItemType','d:text','N',NULL,'Y',NULL,NULL,'["properties","dl:dataListItemType"]','DATA_LIST_ITEM_TYPE',4,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(30,'dl:todoTitle','d:text','N',NULL,'Y',NULL,NULL,'["properties","dl:todoTitle"]','TODO_TITLE',5,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(31,'dl:todoDueDate','d:datetime','N',NULL,'Y',NULL,NULL,'["properties","dl:todoDueDate"]','TODO_DUE_DATE',5,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(32,'dl:todoPriority','d:int','N',NULL,'Y',NULL,NULL,'["properties","dl:todoPriority"]','TODO_PRIORITY',5,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(33,'dl:todoStatus','d:text','N',NULL,'Y',NULL,NULL,'["properties","dl:todoStatus"]','TODO_STATUS',5,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(34,'cm:versionLabel','d:text','N',NULL,'Y',NULL,NULL,'["properties","cm:versionLabel"]','VERSION_LABEL',6,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(35,'cm:initialVersion','d:boolean','N',NULL,'Y',NULL,NULL,'["properties","cm:initialVersion"]','INTIAL_VERSION',6,'Y');
INSERT INTO `DWH_ALF_CLASS_PROPERTIES` VALUES(36,'cm:autoVersion','d:boolean','N',NULL,'Y',NULL,NULL,'["properties","cm:autoVersion"]','AUTO_VERSION',6,'Y');
INSERT INTO `DWH_ALF_AUDIT_APPS` VALUES(1,'alfresco-access','/alfresco-access','warehouseAuditsAccessMaxId','OPE_ALF_AUDIT_ACCESSES',1,1,'Y');
INSERT INTO `DWH_ALF_AUDIT_PROPERTIES` VALUES(1,'user','d:text','N','["user"]','USER',1,'Y');
INSERT INTO `DWH_ALF_AUDIT_PROPERTIES` VALUES(2,'userLogin','d:text','N','["values","\/alfresco-access\/login\/user"]','USER_LOGIN',1,'Y');
INSERT INTO `DWH_ALF_AUDIT_PROPERTIES` VALUES(3,'userLoginFailure','d:text','N','["values","\/alfresco-access\/loginFailure\/user"]','USER_LOGIN_FAILURE',1,'Y');
INSERT INTO `DWH_ALF_AUDIT_PROPERTIES` VALUES(4,'userLogout','d:text','N','["values","\/alfresco-access\/logout\/user"]','USER_LOGOUT',1,'Y');
INSERT INTO `DWH_ALF_AUDIT_PROPERTIES` VALUES(5,'time','d:datetime','N','["time"]','TIME',1,'Y');
INSERT INTO `DWH_ALF_AUDIT_PROPERTIES` VALUES(6,'action','d:text','N','["values","\/alfresco-access\/transaction\/action"]','ACTION',1,'Y');
INSERT INTO `DWH_ALF_AUDIT_PROPERTIES` VALUES(7,'path','d:text','N','["values","\/alfresco-access\/transaction\/path"]','NODE_PATH',1,'Y');

