CREATE DATABASE  IF NOT EXISTS `AAAR_DataMart` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `AAAR_DataMart`;
-- MySQL dump 10.13  Distrib 5.5.37, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: AAAR_DataMart
-- ------------------------------------------------------
-- Server version	5.5.37-0ubuntu0.12.04.1

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
-- Temporary table structure for view `vw_dm_dim_flag_major_version`
--

DROP TABLE IF EXISTS `vw_dm_dim_flag_major_version`;
/*!50001 DROP VIEW IF EXISTS `vw_dm_dim_flag_major_version`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_dm_dim_flag_major_version` (
  `is_major_version` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_dm_dim_flag_immutable`
--

DROP TABLE IF EXISTS `vw_dm_dim_flag_immutable`;
/*!50001 DROP VIEW IF EXISTS `vw_dm_dim_flag_immutable`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_dm_dim_flag_immutable` (
  `is_immutable` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `dm_fact_actions`
--

DROP TABLE IF EXISTS `dm_fact_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_fact_actions` (
  `alfresco_id` smallint(16) NOT NULL,
  `user_id` int(32) NOT NULL,
  `date_id` date NOT NULL,
  `minute_id` smallint(16) NOT NULL,
  `action_id` smallint(16) NOT NULL,
  `path_id` int(32) NOT NULL,
  `num` smallint(16) NOT NULL,
  `src_id` bigint(64) NOT NULL,
  KEY `fk_dm_fact_actions_dm_dim_actions` (`action_id`),
  KEY `fk_dm_fact_actions_dm_dim_alfresco` (`alfresco_id`),
  KEY `fk_dm_fact_actions_dm_dim_dates` (`date_id`),
  KEY `fk_dm_fact_actions_dm_dim_minutes` (`minute_id`),
  KEY `fk_dm_fact_actions_dm_dim_paths` (`path_id`),
  KEY `fk_dm_fact_actions_dm_dim_users` (`user_id`),
  CONSTRAINT `fk_dm_fact_actions_dm_dim_actions` FOREIGN KEY (`action_id`) REFERENCES `dm_dim_actions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_dm_fact_actions_dm_dim_alfresco` FOREIGN KEY (`alfresco_id`) REFERENCES `dm_dim_alfresco` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_dm_fact_actions_dm_dim_dates` FOREIGN KEY (`date_id`) REFERENCES `dm_dim_dates` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_dm_fact_actions_dm_dim_minutes` FOREIGN KEY (`minute_id`) REFERENCES `dm_dim_minutes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_dm_fact_actions_dm_dim_paths` FOREIGN KEY (`path_id`) REFERENCES `dm_dim_paths` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_dm_fact_actions_dm_dim_users` FOREIGN KEY (`user_id`) REFERENCES `dm_dim_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_fact_actions`
--


--
-- Table structure for table `dm_dim_minutes`
--

DROP TABLE IF EXISTS `dm_dim_minutes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_dim_minutes` (
  `id` smallint(16) NOT NULL,
  `desc` char(15) NOT NULL,
  `hour_id` smallint(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dm_dim_minutes_dm_dim_hours` (`hour_id`),
  CONSTRAINT `fk_dm_dim_minutes_dm_dim_hours` FOREIGN KEY (`hour_id`) REFERENCES `dm_dim_hours` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_dim_minutes`
--


--
-- Temporary table structure for view `vw_dm_min_date`
--

DROP TABLE IF EXISTS `vw_dm_min_date`;
/*!50001 DROP VIEW IF EXISTS `vw_dm_min_date`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_dm_min_date` (
  `alfresco_id` tinyint NOT NULL,
  `min_date` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `dm_reports`
--

DROP TABLE IF EXISTS `dm_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_reports` (
  `id` smallint(16) NOT NULL,
  `pentaho_url` varchar(255) NOT NULL,
  `pentaho_login` varchar(255) NOT NULL,
  `pentaho_password` varchar(255) NOT NULL,
  `pentaho_path` varchar(255) NOT NULL,
  `prpt_name` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `alfresco_ftp` varchar(255) NOT NULL,
  `alfresco_port` mediumint(9) NOT NULL,
  `alfresco_login` varchar(255) NOT NULL,
  `alfresco_password` varchar(255) NOT NULL,
  `alfresco_path` varchar(255) NOT NULL,
  `is_active` char(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_reports`
--

INSERT INTO `dm_reports` VALUES (1,'http://localhost:8080/pentaho','admin','password','/public/AAAR/Reports','audit_login.prpt','audit_login.pdf','localhost',121,'admin','admin','alfresco','Y'),(2,'http://localhost:8080/pentaho','admin','password','/public/AAAR/Reports','audit_creation.prpt','audit_creation.pdf','localhost',121,'admin','admin','alfresco','Y'),(3,'http://localhost:8080/pentaho','admin','password','/public/AAAR/Reports','audit_use.prpt','audit_use.pdf','localhost',121,'admin','admin','alfresco','Y'),(4,'http://localhost:8080/pentaho','admin','password','/public/AAAR/Reports','audit_topTen.prpt','audit_topTen.pdf','localhost',121,'admin','admin','alfresco','Y'),(5,'http://localhost:8080/pentaho','admin','password','/public/AAAR/Reports','audit_details.prpt','audit_details.pdf','localhost',121,'admin','admin','alfresco','Y'),(6,'http://localhost:8080/pentaho','admin','password','/public/AAAR/Reports','document_active_users.prpt','document_active_users.pdf','localhost',121,'admin','admin','alfresco','Y'),(7,'http://localhost:8080/pentaho','admin','password','/public/AAAR/Reports','document_hours_of_activity.prpt','document_hours_of_activity.pdf','localhost',121,'admin','admin','alfresco','Y'),(8,'http://localhost:8080/pentaho','admin','password','/public/AAAR/Reports','document_mime_types.prpt','document_mime_types.pdf','localhost',121,'admin','admin','alfresco','Y'),(9,'http://localhost:8080/pentaho','admin','password','/public/AAAR/Reports','document_size.prpt','document_size.pdf','localhost',121,'admin','admin','alfresco','Y'),(10,'http://localhost:8080/pentaho','admin','password','/public/AAAR/Reports','document_types.prpt','document_types.pdf','localhost',121,'admin','admin','alfresco','Y'),(11,'http://localhost:8080/pentaho','admin','password','/public/AAAR/Reports','folder_types.prpt','folder_types.pdf','localhost',121,'admin','admin','alfresco','Y');

--
-- Temporary table structure for view `vw_dm_min_date_sub2`
--

DROP TABLE IF EXISTS `vw_dm_min_date_sub2`;
/*!50001 DROP VIEW IF EXISTS `vw_dm_min_date_sub2`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_dm_min_date_sub2` (
  `alfresco_id` tinyint NOT NULL,
  `date` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `log_transformations`
--

DROP TABLE IF EXISTS `log_transformations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_transformations` (
  `id_batch` int(32) DEFAULT NULL,
  `channel_id` char(255) DEFAULT NULL,
  `transname` char(255) DEFAULT NULL,
  `status` char(15) DEFAULT NULL,
  `lines_read` bigint(64) DEFAULT NULL,
  `lines_written` bigint(64) DEFAULT NULL,
  `lines_updated` bigint(64) DEFAULT NULL,
  `lines_input` bigint(64) DEFAULT NULL,
  `lines_output` bigint(64) DEFAULT NULL,
  `lines_rejected` bigint(64) DEFAULT NULL,
  `errors` bigint(64) DEFAULT NULL,
  `startdate` timestamp NULL DEFAULT NULL,
  `enddate` timestamp NULL DEFAULT NULL,
  `logdate` timestamp NULL DEFAULT NULL,
  `depdate` timestamp NULL DEFAULT NULL,
  `replaydate` timestamp NULL DEFAULT NULL,
  `log_field` text,
  KEY `idx_log_transformations_1` (`id_batch`),
  KEY `idx_log_transformations_2` (`transname`,`status`,`errors`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_transformations`
--


--
-- Temporary table structure for view `vw_dm_dim_flag_latest_version`
--

DROP TABLE IF EXISTS `vw_dm_dim_flag_latest_version`;
/*!50001 DROP VIEW IF EXISTS `vw_dm_dim_flag_latest_version`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_dm_dim_flag_latest_version` (
  `is_latest_version` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `log_channels`
--

DROP TABLE IF EXISTS `log_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_channels` (
  `id_batch` int(32) DEFAULT NULL,
  `channel_id` char(255) DEFAULT NULL,
  `log_date` timestamp NULL DEFAULT NULL,
  `logging_object_type` char(255) DEFAULT NULL,
  `object_name` char(255) DEFAULT NULL,
  `object_copy` char(255) DEFAULT NULL,
  `repository_directory` char(255) DEFAULT NULL,
  `filename` char(255) DEFAULT NULL,
  `object_id` char(255) DEFAULT NULL,
  `object_revision` char(255) DEFAULT NULL,
  `parent_channel_id` char(255) DEFAULT NULL,
  `root_channel_id` char(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_channels`
--


--
-- Table structure for table `ope_audits`
--

DROP TABLE IF EXISTS `ope_audits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ope_audits` (
  `alfresco_id` smallint(6) NOT NULL,
  `id` bigint(20) NOT NULL,
  `application` varchar(128) NOT NULL,
  `user` varchar(512) NOT NULL,
  `date` date NOT NULL,
  `action` varchar(128) NOT NULL,
  `hour` smallint(6) NOT NULL,
  `minute` smallint(6) NOT NULL,
  `path` varchar(4096) NOT NULL,
  `cmis_objectid` varchar(1024) DEFAULT NULL,
  `cmis_objecttypeid` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`alfresco_id`,`id`,`application`),
  CONSTRAINT `fk_stg_audit_extended_dm_dim_alfresco` FOREIGN KEY (`alfresco_id`) REFERENCES `dm_dim_alfresco` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ope_audits`
--


--
-- Table structure for table `stg_cmis_documents_partial`
--

DROP TABLE IF EXISTS `stg_cmis_documents_partial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stg_cmis_documents_partial` (
  `alfresco_id` smallint(6) NOT NULL,
  `cmis_islatestmajorversion` char(1) DEFAULT NULL,
  `cmis_contentstreamid` varchar(1024) DEFAULT NULL,
  `cmis_contentstreamlength` int(11) DEFAULT NULL,
  `cmis_objecttypeid` varchar(512) DEFAULT NULL,
  `cmis_versionseriescheckedoutby` varchar(512) DEFAULT NULL,
  `cmis_versionseriescheckedoutid` varchar(512) DEFAULT NULL,
  `cmis_name` varchar(1024) DEFAULT NULL,
  `cmis_contentstreammimetype` varchar(512) DEFAULT NULL,
  `cmis_versionseriesid` varchar(1024) DEFAULT NULL,
  `cmis_creationdate` datetime DEFAULT NULL,
  `cmis_changetoken` varchar(1024) DEFAULT NULL,
  `cmis_islatestversion` char(1) DEFAULT NULL,
  `cmis_versionlabel` varchar(256) DEFAULT NULL,
  `cmis_isversionseriescheckedout` char(1) DEFAULT NULL,
  `cmis_lastmodifiedby` varchar(512) DEFAULT NULL,
  `cmis_createdby` varchar(512) DEFAULT NULL,
  `cmis_checkincomment` text,
  `cmis_objectid` varchar(255) NOT NULL,
  `cmis_ismajorversion` char(1) DEFAULT NULL,
  `cmis_isimmutable` char(1) DEFAULT NULL,
  `alfcmis_noderef` text,
  `cmis_basetypeid` varchar(512) DEFAULT NULL,
  `cmis_lastmodificationdate` datetime DEFAULT NULL,
  `cmis_contentstreamfilename` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`alfresco_id`,`cmis_objectid`),
  KEY `idx_stg_cmis_documents_partial_key` (`alfresco_id`,`cmis_contentstreamlength`,`cmis_name`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stg_cmis_documents_partial`
--


--
-- Table structure for table `log_job`
--

DROP TABLE IF EXISTS `log_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_job` (
  `id_job` int(32) DEFAULT NULL,
  `channel_id` char(255) DEFAULT NULL,
  `jobname` char(255) DEFAULT NULL,
  `status` char(15) DEFAULT NULL,
  `lines_read` bigint(64) DEFAULT NULL,
  `lines_written` bigint(64) DEFAULT NULL,
  `lines_updated` bigint(64) DEFAULT NULL,
  `lines_input` bigint(64) DEFAULT NULL,
  `lines_output` bigint(64) DEFAULT NULL,
  `lines_rejected` bigint(64) DEFAULT NULL,
  `errors` bigint(64) DEFAULT NULL,
  `startdate` timestamp NULL DEFAULT NULL,
  `enddate` timestamp NULL DEFAULT NULL,
  `logdate` timestamp NULL DEFAULT NULL,
  `depdate` timestamp NULL DEFAULT NULL,
  `replaydate` timestamp NULL DEFAULT NULL,
  `log_field` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_job`
--


--
-- Table structure for table `ope_cmis_document_parent`
--

DROP TABLE IF EXISTS `ope_cmis_document_parent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ope_cmis_document_parent` (
  `alfresco_id` smallint(6) NOT NULL,
  `cmis_objectid` varchar(255) NOT NULL,
  `cmis_parentid` varchar(255) NOT NULL,
  `cmis_path` varchar(4096) NOT NULL,
  PRIMARY KEY (`alfresco_id`,`cmis_objectid`,`cmis_parentid`),
  KEY `fk_cmis_document_parent_document` (`alfresco_id`,`cmis_objectid`),
  KEY `fk_cmis_document_parent_parent` (`alfresco_id`,`cmis_parentid`),
  CONSTRAINT `fk_cmis_document_parent_document` FOREIGN KEY (`alfresco_id`, `cmis_objectid`) REFERENCES `stg_cmis_documents` (`alfresco_id`, `cmis_objectid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cmis_document_parent_parent` FOREIGN KEY (`alfresco_id`, `cmis_parentid`) REFERENCES `stg_cmis_folders` (`alfresco_id`, `cmis_objectid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ope_cmis_document_parent`
--


--
-- Table structure for table `dm_dim_paths`
--

DROP TABLE IF EXISTS `dm_dim_paths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_dim_paths` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `path` longtext NOT NULL,
  `folder_id` int(11) DEFAULT NULL,
  `document_id` int(11) DEFAULT NULL,
  `alfresco_id` smallint(16) NOT NULL,
  `src_path` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dm_dim_path_dm_dim_alfresco` (`alfresco_id`),
  KEY `fk_dm_dim_path_dm_dim_folders` (`folder_id`),
  KEY `fk_dm_dim_paths_dm_dim_documents` (`document_id`),
  CONSTRAINT `fk_dm_dim_paths_dm_dim_documents` FOREIGN KEY (`document_id`) REFERENCES `dm_dim_documents` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_dm_dim_path_dm_dim_alfresco` FOREIGN KEY (`alfresco_id`) REFERENCES `dm_dim_alfresco` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_dm_dim_path_dm_dim_folders` FOREIGN KEY (`folder_id`) REFERENCES `dm_dim_folders` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_dim_paths`
--


--
-- Table structure for table `dm_dim_actions`
--

DROP TABLE IF EXISTS `dm_dim_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_dim_actions` (
  `id` smallint(16) NOT NULL AUTO_INCREMENT,
  `desc` char(100) NOT NULL,
  `alfresco_id` smallint(16) NOT NULL,
  `src_action` char(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dm_dim_action_dm_dim_alfresco` (`alfresco_id`),
  CONSTRAINT `fk_dm_dim_action_dm_dim_alfresco` FOREIGN KEY (`alfresco_id`) REFERENCES `dm_dim_alfresco` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_dim_actions`
--


--
-- Table structure for table `log_performance`
--

DROP TABLE IF EXISTS `log_performance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_performance` (
  `id_batch` int(32) DEFAULT NULL,
  `seq_nr` int(32) DEFAULT NULL,
  `logdate` timestamp NULL DEFAULT NULL,
  `transname` char(255) DEFAULT NULL,
  `stepname` char(255) DEFAULT NULL,
  `step_copy` int(32) DEFAULT NULL,
  `lines_read` bigint(64) DEFAULT NULL,
  `lines_written` bigint(64) DEFAULT NULL,
  `lines_updated` bigint(64) DEFAULT NULL,
  `lines_input` bigint(64) DEFAULT NULL,
  `lines_output` bigint(64) DEFAULT NULL,
  `lines_rejected` bigint(64) DEFAULT NULL,
  `errors` bigint(64) DEFAULT NULL,
  `input_buffer_rows` bigint(64) DEFAULT NULL,
  `output_buffer_rows` bigint(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_performance`
--


--
-- Table structure for table `log_step`
--

DROP TABLE IF EXISTS `log_step`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_step` (
  `id_batch` int(32) DEFAULT NULL,
  `channel_id` char(255) DEFAULT NULL,
  `log_date` timestamp NULL DEFAULT NULL,
  `transname` char(255) DEFAULT NULL,
  `stepname` char(255) DEFAULT NULL,
  `step_copy` smallint(16) DEFAULT NULL,
  `lines_read` bigint(64) DEFAULT NULL,
  `lines_written` bigint(64) DEFAULT NULL,
  `lines_updated` bigint(64) DEFAULT NULL,
  `lines_input` bigint(64) DEFAULT NULL,
  `lines_output` bigint(64) DEFAULT NULL,
  `lines_rejected` bigint(64) DEFAULT NULL,
  `errors` bigint(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_step`
--


--
-- Temporary table structure for view `generator_65536`
--

DROP TABLE IF EXISTS `generator_65536`;
/*!50001 DROP VIEW IF EXISTS `generator_65536`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `generator_65536` (
  `n` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `stg_audits`
--

DROP TABLE IF EXISTS `stg_audits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stg_audits` (
  `alfresco_id` smallint(6) NOT NULL,
  `id` bigint(20) NOT NULL,
  `application` varchar(50) NOT NULL,
  `user` varchar(100) DEFAULT NULL,
  `time` varchar(50) NOT NULL,
  `values` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`alfresco_id`,`id`,`application`),
  CONSTRAINT `fk_stg_audit_dm_dim_alfresco` FOREIGN KEY (`alfresco_id`) REFERENCES `dm_dim_alfresco` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stg_audits`
--


--
-- Temporary table structure for view `vw_dm_dim_dates`
--

DROP TABLE IF EXISTS `vw_dm_dim_dates`;
/*!50001 DROP VIEW IF EXISTS `vw_dm_dim_dates`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_dm_dim_dates` (
  `id` tinyint NOT NULL,
  `day` tinyint NOT NULL,
  `day_desc` tinyint NOT NULL,
  `month_id` tinyint NOT NULL,
  `month` tinyint NOT NULL,
  `month_desc` tinyint NOT NULL,
  `year_id` tinyint NOT NULL,
  `year` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `dm_dim_dates`
--

DROP TABLE IF EXISTS `dm_dim_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_dim_dates` (
  `id` date NOT NULL,
  `desc` char(50) NOT NULL,
  `day_desc` char(50) NOT NULL,
  `month_id` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dm_dim_dates_dm_dim_months` (`month_id`),
  CONSTRAINT `fk_dm_dim_dates_dm_dim_months` FOREIGN KEY (`month_id`) REFERENCES `dm_dim_months` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_dim_dates`
--


--
-- Table structure for table `dm_dim_hours`
--

DROP TABLE IF EXISTS `dm_dim_hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_dim_hours` (
  `id` smallint(16) NOT NULL,
  `desc` char(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_dim_hours`
--


--
-- Temporary table structure for view `vw_dm_dim_minutes`
--

DROP TABLE IF EXISTS `vw_dm_dim_minutes`;
/*!50001 DROP VIEW IF EXISTS `vw_dm_dim_minutes`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_dm_dim_minutes` (
  `id` tinyint NOT NULL,
  `minute` tinyint NOT NULL,
  `hour_id` tinyint NOT NULL,
  `hour` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_cmis_documents_and_folders_path`
--

DROP TABLE IF EXISTS `vw_cmis_documents_and_folders_path`;
/*!50001 DROP VIEW IF EXISTS `vw_cmis_documents_and_folders_path`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_cmis_documents_and_folders_path` (
  `cmis_objectid` tinyint NOT NULL,
  `cmis_objecttypeid` tinyint NOT NULL,
  `cmis_path` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `dm_dim_years`
--

DROP TABLE IF EXISTS `dm_dim_years`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_dim_years` (
  `id` smallint(16) NOT NULL,
  `desc` varchar(255) NOT NULL DEFAULT '20',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_dim_years`
--


--
-- Temporary table structure for view `generator_256`
--

DROP TABLE IF EXISTS `generator_256`;
/*!50001 DROP VIEW IF EXISTS `generator_256`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `generator_256` (
  `n` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `dm_dim_mime_types`
--

DROP TABLE IF EXISTS `dm_dim_mime_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_dim_mime_types` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `desc` varchar(512) NOT NULL,
  `alfresco_id` smallint(6) NOT NULL,
  `src_id` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dm_dim_mime_types_dm_dim_alfresco` (`alfresco_id`),
  KEY `idx_dm_dim_mime_types` (`id`),
  CONSTRAINT `fk_dm_dim_mime_types_dm_dim_alfresco` FOREIGN KEY (`alfresco_id`) REFERENCES `dm_dim_alfresco` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_dim_mime_types`
--


--
-- Table structure for table `dm_dim_alfresco`
--

DROP TABLE IF EXISTS `dm_dim_alfresco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_dim_alfresco` (
  `id` smallint(16) NOT NULL,
  `desc` char(255) NOT NULL,
  `login` char(100) NOT NULL,
  `password` char(100) NOT NULL,
  `url` varchar(1024) NOT NULL,
  `url_audit_suffix` varchar(1024) NOT NULL,
  `url_cmis_suffix` varchar(1024) NOT NULL,
  `is_active` char(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_dim_alfresco`
--

INSERT INTO `dm_dim_alfresco` VALUES (1,'Default','admin','admin','http://localhost:8080','/alfresco/service/api/audit/query/alfresco-access?verbose=true&limit=50000','/alfresco/api/-default-/cmis/versions/1.1/atom','Y');

--
-- Table structure for table `dm_dim_node_types`
--

DROP TABLE IF EXISTS `dm_dim_node_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_dim_node_types` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `desc` varchar(512) NOT NULL,
  `base_type` varchar(512) NOT NULL,
  `alfresco_id` smallint(6) NOT NULL,
  `src_id` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dm_dim_node_types_dm_dim_alfresco` (`alfresco_id`),
  KEY `idx_dm_dim_node_types` (`id`),
  CONSTRAINT `fk_dm_dim_node_types_dm_dim_alfresco` FOREIGN KEY (`alfresco_id`) REFERENCES `dm_dim_alfresco` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_dim_node_types`
--


--
-- Temporary table structure for view `vw_dm_min_date_sub1`
--

DROP TABLE IF EXISTS `vw_dm_min_date_sub1`;
/*!50001 DROP VIEW IF EXISTS `vw_dm_min_date_sub1`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_dm_min_date_sub1` (
  `alfresco_id` tinyint NOT NULL,
  `date` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `dm_dim_users`
--

DROP TABLE IF EXISTS `dm_dim_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_dim_users` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `desc` char(255) NOT NULL,
  `alfresco_id` smallint(16) NOT NULL,
  `src_user` char(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dm_dim_users_dm_dim_alfresco` (`alfresco_id`),
  CONSTRAINT `fk_dm_dim_users_dm_dim_alfresco` FOREIGN KEY (`alfresco_id`) REFERENCES `dm_dim_alfresco` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_dim_users`
--


--
-- Table structure for table `dm_dim_months`
--

DROP TABLE IF EXISTS `dm_dim_months`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_dim_months` (
  `id` date NOT NULL,
  `desc` char(50) NOT NULL,
  `month_desc` char(100) NOT NULL,
  `year_id` smallint(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dm_dim_months_dm_dim_years` (`year_id`),
  CONSTRAINT `fk_dm_dim_months_dm_dim_years` FOREIGN KEY (`year_id`) REFERENCES `dm_dim_years` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_dim_months`
--


--
-- Table structure for table `dm_dim_folders`
--

DROP TABLE IF EXISTS `dm_dim_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_dim_folders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1024) NOT NULL,
  `path` varchar(4096) NOT NULL,
  `node_type_id` smallint(6) NOT NULL,
  `user_creator_id` int(11) NOT NULL,
  `creation_date_id` date DEFAULT NULL,
  `creation_minute_id` smallint(6) NOT NULL,
  `user_last_modifier_id` int(11) NOT NULL,
  `last_modification_date_id` date NOT NULL,
  `last_modification_minute_id` smallint(6) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `alfresco_id` smallint(6) NOT NULL,
  `src_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_dm_dim_folders` (`alfresco_id`,`src_id`),
  KEY `fk_dm_dim_folders_dm_dim_dates_creation` (`creation_date_id`),
  KEY `fk_dm_dim_folders_dm_dim_dates_last_modification` (`last_modification_date_id`),
  KEY `fk_dm_dim_folders_dm_dim_minutes_creation` (`creation_minute_id`),
  KEY `fk_dm_dim_folders_dm_dim_minutes_last_modification` (`last_modification_minute_id`),
  KEY `fk_dm_dim_folders_dm_dim_node_types` (`node_type_id`),
  KEY `fk_dm_dim_folders_dm_dim_users_creator` (`user_creator_id`),
  KEY `fk_dm_dim_folders_dm_dim_users_last_modifier` (`user_last_modifier_id`),
  KEY `fk_dm_dim_folders_dm_dim_folders_parent` (`parent_id`),
  CONSTRAINT `fk_dm_dim_folders_dm_dim_alfresco` FOREIGN KEY (`alfresco_id`) REFERENCES `dm_dim_alfresco` (`id`),
  CONSTRAINT `fk_dm_dim_folders_dm_dim_dates_creation` FOREIGN KEY (`creation_date_id`) REFERENCES `dm_dim_dates` (`id`),
  CONSTRAINT `fk_dm_dim_folders_dm_dim_dates_last_modification` FOREIGN KEY (`last_modification_date_id`) REFERENCES `dm_dim_dates` (`id`),
  CONSTRAINT `fk_dm_dim_folders_dm_dim_folders_parent` FOREIGN KEY (`parent_id`) REFERENCES `dm_dim_folders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_dm_dim_folders_dm_dim_minutes_creation` FOREIGN KEY (`creation_minute_id`) REFERENCES `dm_dim_minutes` (`id`),
  CONSTRAINT `fk_dm_dim_folders_dm_dim_minutes_last_modification` FOREIGN KEY (`last_modification_minute_id`) REFERENCES `dm_dim_minutes` (`id`),
  CONSTRAINT `fk_dm_dim_folders_dm_dim_node_types` FOREIGN KEY (`node_type_id`) REFERENCES `dm_dim_node_types` (`id`),
  CONSTRAINT `fk_dm_dim_folders_dm_dim_users_creator` FOREIGN KEY (`user_creator_id`) REFERENCES `dm_dim_users` (`id`),
  CONSTRAINT `fk_dm_dim_folders_dm_dim_users_last_modifier` FOREIGN KEY (`user_last_modifier_id`) REFERENCES `dm_dim_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_dim_folders`
--


--
-- Temporary table structure for view `vw_dm_dim_flag_latest_major_version`
--

DROP TABLE IF EXISTS `vw_dm_dim_flag_latest_major_version`;
/*!50001 DROP VIEW IF EXISTS `vw_dm_dim_flag_latest_major_version`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_dm_dim_flag_latest_major_version` (
  `is_latest_major_version` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `stg_cmis_documents`
--

DROP TABLE IF EXISTS `stg_cmis_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stg_cmis_documents` (
  `alfresco_id` smallint(6) NOT NULL,
  `cmis_islatestmajorversion` char(1) DEFAULT NULL,
  `cmis_contentstreamid` varchar(1024) DEFAULT NULL,
  `cmis_contentstreamlength` int(11) DEFAULT NULL,
  `cmis_objecttypeid` varchar(512) DEFAULT NULL,
  `cmis_versionseriescheckedoutby` varchar(512) DEFAULT NULL,
  `cmis_versionseriescheckedoutid` varchar(512) DEFAULT NULL,
  `cmis_name` varchar(1024) DEFAULT NULL,
  `cmis_contentstreammimetype` varchar(512) DEFAULT NULL,
  `cmis_versionseriesid` varchar(1024) DEFAULT NULL,
  `cmis_creationdate` datetime DEFAULT NULL,
  `cmis_changetoken` varchar(1024) DEFAULT NULL,
  `cmis_islatestversion` char(1) DEFAULT NULL,
  `cmis_versionlabel` varchar(256) DEFAULT NULL,
  `cmis_isversionseriescheckedout` char(1) DEFAULT NULL,
  `cmis_lastmodifiedby` varchar(512) DEFAULT NULL,
  `cmis_createdby` varchar(512) DEFAULT NULL,
  `cmis_checkincomment` text,
  `cmis_objectid` varchar(255) NOT NULL,
  `cmis_ismajorversion` char(1) DEFAULT NULL,
  `cmis_isimmutable` char(1) DEFAULT NULL,
  `alfcmis_noderef` text,
  `cmis_basetypeid` varchar(512) DEFAULT NULL,
  `cmis_lastmodificationdate` datetime DEFAULT NULL,
  `cmis_contentstreamfilename` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`alfresco_id`,`cmis_objectid`),
  KEY `idx_stg_cmis_documents_key` (`alfresco_id`,`cmis_lastmodificationdate`,`cmis_name`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stg_cmis_documents`
--


--
-- Table structure for table `stg_cmis_folders_partial`
--

DROP TABLE IF EXISTS `stg_cmis_folders_partial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stg_cmis_folders_partial` (
  `alfresco_id` smallint(6) NOT NULL,
  `cmis_allowedchildobjecttypeids` varchar(1024) DEFAULT NULL,
  `cmis_path` varchar(4096) DEFAULT NULL,
  `cmis_objecttypeid` varchar(512) DEFAULT NULL,
  `cmis_name` varchar(1024) DEFAULT NULL,
  `cmis_creationdate` datetime DEFAULT NULL,
  `cmis_changetoken` varchar(1024) DEFAULT NULL,
  `cmis_lastmodifiedby` varchar(512) DEFAULT NULL,
  `cmis_createdby` varchar(512) DEFAULT NULL,
  `cmis_objectid` varchar(255) NOT NULL,
  `cmis_basetypeid` varchar(512) DEFAULT NULL,
  `alfcmis_noderef` text,
  `cmis_parentid` varchar(1024) DEFAULT NULL,
  `cmis_lastmodificationdate` datetime DEFAULT NULL,
  PRIMARY KEY (`alfresco_id`,`cmis_objectid`),
  KEY `idx_stg_cmis_folders_partial_key` (`alfresco_id`,`cmis_lastmodificationdate`,`cmis_name`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stg_cmis_folders_partial`
--


--
-- Table structure for table `stg_cmis_folders`
--

DROP TABLE IF EXISTS `stg_cmis_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stg_cmis_folders` (
  `alfresco_id` smallint(6) NOT NULL,
  `cmis_allowedchildobjecttypeids` varchar(1024) DEFAULT NULL,
  `cmis_path` varchar(4096) DEFAULT NULL,
  `cmis_objecttypeid` varchar(512) DEFAULT NULL,
  `cmis_name` varchar(1024) DEFAULT NULL,
  `cmis_creationdate` datetime DEFAULT NULL,
  `cmis_changetoken` varchar(1024) DEFAULT NULL,
  `cmis_lastmodifiedby` varchar(512) DEFAULT NULL,
  `cmis_createdby` varchar(512) DEFAULT NULL,
  `cmis_objectid` varchar(255) NOT NULL,
  `cmis_basetypeid` varchar(512) DEFAULT NULL,
  `alfcmis_noderef` text,
  `cmis_parentid` varchar(1024) DEFAULT NULL,
  `cmis_lastmodificationdate` datetime DEFAULT NULL,
  PRIMARY KEY (`alfresco_id`,`cmis_objectid`),
  KEY `idx_stg_cmis_folders_key` (`alfresco_id`,`cmis_lastmodificationdate`,`cmis_name`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stg_cmis_folders`
--


--
-- Temporary table structure for view `generator_16`
--

DROP TABLE IF EXISTS `generator_16`;
/*!50001 DROP VIEW IF EXISTS `generator_16`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `generator_16` (
  `n` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `dm_dim_documents`
--

DROP TABLE IF EXISTS `dm_dim_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_dim_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1024) NOT NULL,
  `path` varchar(4096) NOT NULL,
  `node_type_id` smallint(6) NOT NULL,
  `mime_type_id` smallint(6) NOT NULL,
  `user_creator_id` int(11) NOT NULL,
  `creation_date_id` date DEFAULT NULL,
  `creation_minute_id` smallint(6) NOT NULL,
  `user_last_modifier_id` int(11) NOT NULL,
  `last_modification_date_id` date NOT NULL,
  `last_modification_minute_id` smallint(6) NOT NULL,
  `content_stream_length` int(11) NOT NULL,
  `is_latest_version` char(1) NOT NULL,
  `is_major_version` char(1) NOT NULL,
  `is_latest_major_version` char(1) NOT NULL,
  `is_immutable` char(1) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `alfresco_id` smallint(6) NOT NULL,
  `src_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_dm_dim_documents` (`alfresco_id`,`src_id`),
  KEY `fk_dm_dim_documents_dm_dim_dates_creation` (`creation_date_id`),
  KEY `fk_dm_dim_documents_dm_dim_dates_last_modification` (`last_modification_date_id`),
  KEY `fk_dm_dim_documents_dm_dim_folders_parent` (`parent_id`),
  KEY `fk_dm_dim_documents_dm_dim_mime_types` (`mime_type_id`),
  KEY `fk_dm_dim_documents_dm_dim_minutes_creation` (`creation_minute_id`),
  KEY `fk_dm_dim_documents_dm_dim_minutes_last_modification` (`last_modification_minute_id`),
  KEY `fk_dm_dim_documents_dm_dim_node_types` (`node_type_id`),
  KEY `fk_dm_dim_documents_dm_dim_users_creator` (`user_creator_id`),
  KEY `fk_dm_dim_documents_dm_dim_users_last_modifier` (`user_last_modifier_id`),
  CONSTRAINT `fk_dm_dim_documents_dm_dim_alfresco` FOREIGN KEY (`alfresco_id`) REFERENCES `dm_dim_alfresco` (`id`),
  CONSTRAINT `fk_dm_dim_documents_dm_dim_dates_creation` FOREIGN KEY (`creation_date_id`) REFERENCES `dm_dim_dates` (`id`),
  CONSTRAINT `fk_dm_dim_documents_dm_dim_dates_last_modification` FOREIGN KEY (`last_modification_date_id`) REFERENCES `dm_dim_dates` (`id`),
  CONSTRAINT `fk_dm_dim_documents_dm_dim_folders_parent` FOREIGN KEY (`parent_id`) REFERENCES `dm_dim_folders` (`id`),
  CONSTRAINT `fk_dm_dim_documents_dm_dim_mime_types` FOREIGN KEY (`mime_type_id`) REFERENCES `dm_dim_mime_types` (`id`),
  CONSTRAINT `fk_dm_dim_documents_dm_dim_minutes_creation` FOREIGN KEY (`creation_minute_id`) REFERENCES `dm_dim_minutes` (`id`),
  CONSTRAINT `fk_dm_dim_documents_dm_dim_minutes_last_modification` FOREIGN KEY (`last_modification_minute_id`) REFERENCES `dm_dim_minutes` (`id`),
  CONSTRAINT `fk_dm_dim_documents_dm_dim_node_types` FOREIGN KEY (`node_type_id`) REFERENCES `dm_dim_node_types` (`id`),
  CONSTRAINT `fk_dm_dim_documents_dm_dim_users_creator` FOREIGN KEY (`user_creator_id`) REFERENCES `dm_dim_users` (`id`),
  CONSTRAINT `fk_dm_dim_documents_dm_dim_users_last_modifier` FOREIGN KEY (`user_last_modifier_id`) REFERENCES `dm_dim_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_dim_documents`
--


--
-- Table structure for table `dm_custom_metadata`
--

DROP TABLE IF EXISTS `dm_custom_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_custom_metadata` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_document_type` char(1) NOT NULL DEFAULT 'N',
  `is_folder_type` char(1) NOT NULL DEFAULT 'N',
  `is_aspect` char(1) NOT NULL DEFAULT 'N',
  `is_active` char(1) NOT NULL DEFAULT 'Y',
  `alfresco_id` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dm_custom_metadata_dm_dim_alfresco` (`alfresco_id`),
  CONSTRAINT `fk_dm_custom_metadata_dm_dim_alfresco` FOREIGN KEY (`alfresco_id`) REFERENCES `dm_dim_alfresco` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_custom_metadata`
--


--
-- Temporary table structure for view `vw_dm_dim_documents`
--

DROP TABLE IF EXISTS `vw_dm_dim_documents`;
/*!50001 DROP VIEW IF EXISTS `vw_dm_dim_documents`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_dm_dim_documents` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `path` tinyint NOT NULL,
  `alfresco_id` tinyint NOT NULL,
  `src_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_dm_fact_documents`
--

DROP TABLE IF EXISTS `vw_dm_fact_documents`;
/*!50001 DROP VIEW IF EXISTS `vw_dm_fact_documents`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_dm_fact_documents` (
  `id` tinyint NOT NULL,
  `document_id` smallint NOT NULL,
  `alfresco_id` tinyint NOT NULL,
  `node_type_id` tinyint NOT NULL,
  `mime_type_id` tinyint NOT NULL,
  `user_creator_id` tinyint NOT NULL,
  `creation_date_id` tinyint NOT NULL,
  `creation_minute_id` tinyint NOT NULL,
  `user_last_modifier_id` tinyint NOT NULL,
  `last_modification_date_id` tinyint NOT NULL,
  `last_modification_minute_id` tinyint NOT NULL,
  `is_latest_version` tinyint NOT NULL,
  `is_major_version` tinyint NOT NULL,
  `is_latest_major_version` tinyint NOT NULL,
  `is_immutable` tinyint NOT NULL,
  `parent_id` tinyint NOT NULL,
  `content_stream_length` tinyint NOT NULL,
  `number` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_dm_fact_repository`
--

DROP TABLE IF EXISTS `vw_dm_fact_repository`;
/*!50001 DROP VIEW IF EXISTS `vw_dm_fact_repository`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_dm_fact_repository` (
  `id` tinyint NOT NULL,
  `name` varchar(1024) NOT NULL,
  `path` varchar(4096) NOT NULL,
  `alfresco_id` tinyint NOT NULL,
  `node_type_id` tinyint NOT NULL,
  `user_creator_id` tinyint NOT NULL,
  `creation_date_id` tinyint NOT NULL,
  `creation_minute_id` tinyint NOT NULL,
  `user_last_modifier_id` tinyint NOT NULL,
  `last_modification_date_id` tinyint NOT NULL,
  `last_modification_minute_id` tinyint NOT NULL,
  `parent_id` varchar(50) NOT NULL,
  `num` tinyint NOT NULL,
  `mb` int(32) NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `log_jobentry`
--

DROP TABLE IF EXISTS `log_jobentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_jobentry` (
  `id_batch` int(32) DEFAULT NULL,
  `channel_id` char(255) DEFAULT NULL,
  `log_date` timestamp NULL DEFAULT NULL,
  `transname` char(255) DEFAULT NULL,
  `stepname` char(255) DEFAULT NULL,
  `lines_read` bigint(64) DEFAULT NULL,
  `lines_written` bigint(64) DEFAULT NULL,
  `lines_updated` bigint(64) DEFAULT NULL,
  `lines_input` bigint(64) DEFAULT NULL,
  `lines_output` bigint(64) DEFAULT NULL,
  `lines_rejected` bigint(64) DEFAULT NULL,
  `errors` bigint(64) DEFAULT NULL,
  `result` char(1) DEFAULT NULL,
  `nr_result_rows` bigint(64) DEFAULT NULL,
  `nr_result_files` bigint(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_jobentry`
--


--
-- Final view structure for view `vw_dm_dim_flag_major_version`
--

/*!50001 DROP TABLE IF EXISTS `vw_dm_dim_flag_major_version`*/;
/*!50001 DROP VIEW IF EXISTS `vw_dm_dim_flag_major_version`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dm_dim_flag_major_version` AS select distinct `dm_dim_documents`.`is_major_version` AS `is_major_version` from `dm_dim_documents` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_dm_dim_flag_immutable`
--

/*!50001 DROP TABLE IF EXISTS `vw_dm_dim_flag_immutable`*/;
/*!50001 DROP VIEW IF EXISTS `vw_dm_dim_flag_immutable`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dm_dim_flag_immutable` AS select distinct `dm_dim_documents`.`is_immutable` AS `is_immutable` from `dm_dim_documents` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_dm_min_date`
--

/*!50001 DROP TABLE IF EXISTS `vw_dm_min_date`*/;
/*!50001 DROP VIEW IF EXISTS `vw_dm_min_date`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dm_min_date` AS select `t`.`alfresco_id` AS `alfresco_id`,min(`t`.`date`) AS `min_date` from `vw_dm_min_date_sub2` `t` group by `t`.`alfresco_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_dm_min_date_sub2`
--

/*!50001 DROP TABLE IF EXISTS `vw_dm_min_date_sub2`*/;
/*!50001 DROP VIEW IF EXISTS `vw_dm_min_date_sub2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dm_min_date_sub2` AS select `ope_audit`.`alfresco_id` AS `alfresco_id`,min(`ope_audit`.`date`) AS `date` from `vw_dm_min_date_sub1` `ope_audit` group by `ope_audit`.`alfresco_id` union all select `stg_cmis_document`.`alfresco_id` AS `alfresco_id`,min(`stg_cmis_document`.`cmis_creationdate`) AS `date` from `stg_cmis_documents` `stg_cmis_document` group by `stg_cmis_document`.`alfresco_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_dm_dim_flag_latest_version`
--

/*!50001 DROP TABLE IF EXISTS `vw_dm_dim_flag_latest_version`*/;
/*!50001 DROP VIEW IF EXISTS `vw_dm_dim_flag_latest_version`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dm_dim_flag_latest_version` AS select distinct `dm_dim_documents`.`is_latest_version` AS `is_latest_version` from `dm_dim_documents` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `generator_65536`
--

/*!50001 DROP TABLE IF EXISTS `generator_65536`*/;
/*!50001 DROP VIEW IF EXISTS `generator_65536`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `generator_65536` AS select ((`hi`.`n` * 256) + `lo`.`n`) AS `n` from (`generator_256` `lo` join `generator_256` `hi`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_dm_dim_dates`
--

/*!50001 DROP TABLE IF EXISTS `vw_dm_dim_dates`*/;
/*!50001 DROP VIEW IF EXISTS `vw_dm_dim_dates`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dm_dim_dates` AS select `dm_dim_dates`.`id` AS `id`,`dm_dim_dates`.`desc` AS `day`,`dm_dim_dates`.`day_desc` AS `day_desc`,`dm_dim_dates`.`month_id` AS `month_id`,`dm_dim_months`.`desc` AS `month`,`dm_dim_months`.`month_desc` AS `month_desc`,`dm_dim_months`.`year_id` AS `year_id`,`dm_dim_years`.`desc` AS `year` from ((`dm_dim_dates` join `dm_dim_months`) join `dm_dim_years`) where ((`dm_dim_dates`.`month_id` = `dm_dim_months`.`id`) and (`dm_dim_months`.`year_id` = `dm_dim_years`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_dm_dim_minutes`
--

/*!50001 DROP TABLE IF EXISTS `vw_dm_dim_minutes`*/;
/*!50001 DROP VIEW IF EXISTS `vw_dm_dim_minutes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dm_dim_minutes` AS select `dm_dim_minutes`.`id` AS `id`,`dm_dim_minutes`.`desc` AS `minute`,`dm_dim_minutes`.`hour_id` AS `hour_id`,`dm_dim_hours`.`desc` AS `hour` from (`dm_dim_minutes` join `dm_dim_hours`) where (`dm_dim_minutes`.`hour_id` = `dm_dim_hours`.`id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_cmis_documents_and_folders_path`
--

/*!50001 DROP TABLE IF EXISTS `vw_cmis_documents_and_folders_path`*/;
/*!50001 DROP VIEW IF EXISTS `vw_cmis_documents_and_folders_path`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_cmis_documents_and_folders_path` AS select `stg_cmis_document`.`cmis_objectid` AS `cmis_objectid`,`stg_cmis_document`.`cmis_objecttypeid` AS `cmis_objecttypeid`,(ucase(`stg_cmis_folder`.`cmis_path`) or (case when (`stg_cmis_folder`.`cmis_path` <> '/') then '/' else '' end) or ucase(`stg_cmis_document`.`cmis_name`)) AS `cmis_path` from ((`stg_cmis_documents` `stg_cmis_document` join `ope_cmis_document_parent`) join `stg_cmis_folders` `stg_cmis_folder`) where ((`stg_cmis_document`.`alfresco_id` = `ope_cmis_document_parent`.`alfresco_id`) and (`ope_cmis_document_parent`.`cmis_objectid` = `stg_cmis_document`.`cmis_objectid`) and (`ope_cmis_document_parent`.`alfresco_id` = `stg_cmis_folder`.`alfresco_id`) and (`ope_cmis_document_parent`.`cmis_parentid` = `stg_cmis_folder`.`cmis_objectid`)) union all select `stg_cmis_folder`.`cmis_objectid` AS `cmis_objectid`,`stg_cmis_folder`.`cmis_objecttypeid` AS `cmis_objecttypeid`,ucase(`stg_cmis_folder`.`cmis_path`) AS `cmis_path` from `stg_cmis_folders` `stg_cmis_folder` where (`stg_cmis_folder`.`cmis_path` is not null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `generator_256`
--

/*!50001 DROP TABLE IF EXISTS `generator_256`*/;
/*!50001 DROP VIEW IF EXISTS `generator_256`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `generator_256` AS select ((`hi`.`n` * 16) + `lo`.`n`) AS `n` from (`generator_16` `lo` join `generator_16` `hi`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_dm_min_date_sub1`
--

/*!50001 DROP TABLE IF EXISTS `vw_dm_min_date_sub1`*/;
/*!50001 DROP VIEW IF EXISTS `vw_dm_min_date_sub1`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dm_min_date_sub1` AS select `ope_audit`.`alfresco_id` AS `alfresco_id`,min(`ope_audit`.`date`) AS `date` from `ope_audits` `ope_audit` group by `ope_audit`.`alfresco_id` union all select `stg_cmis_folder`.`alfresco_id` AS `alfresco_id`,min(`stg_cmis_folder`.`cmis_creationdate`) AS `date` from `stg_cmis_folders` `stg_cmis_folder` group by `stg_cmis_folder`.`alfresco_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_dm_dim_flag_latest_major_version`
--

/*!50001 DROP TABLE IF EXISTS `vw_dm_dim_flag_latest_major_version`*/;
/*!50001 DROP VIEW IF EXISTS `vw_dm_dim_flag_latest_major_version`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dm_dim_flag_latest_major_version` AS select distinct `dm_dim_documents`.`is_latest_major_version` AS `is_latest_major_version` from `dm_dim_documents` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `generator_16`
--

/*!50001 DROP TABLE IF EXISTS `generator_16`*/;
/*!50001 DROP VIEW IF EXISTS `generator_16`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `generator_16` AS select 0 AS `n` union all select 1 AS `1` union all select 2 AS `2` union all select 3 AS `3` union all select 4 AS `4` union all select 5 AS `5` union all select 6 AS `6` union all select 7 AS `7` union all select 8 AS `8` union all select 9 AS `9` union all select 10 AS `10` union all select 11 AS `11` union all select 12 AS `12` union all select 13 AS `13` union all select 14 AS `14` union all select 15 AS `15` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_dm_dim_documents`
--

/*!50001 DROP TABLE IF EXISTS `vw_dm_dim_documents`*/;
/*!50001 DROP VIEW IF EXISTS `vw_dm_dim_documents`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dm_dim_documents` AS select `dm_dim_documents`.`id` AS `id`,`dm_dim_documents`.`name` AS `name`,`dm_dim_documents`.`path` AS `path`,`dm_dim_documents`.`alfresco_id` AS `alfresco_id`,`dm_dim_documents`.`src_id` AS `src_id` from `dm_dim_documents` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_dm_fact_documents`
--

/*!50001 DROP TABLE IF EXISTS `vw_dm_fact_documents`*/;
/*!50001 DROP VIEW IF EXISTS `vw_dm_fact_documents`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dm_fact_documents` AS select `dm_dim_documents`.`id` AS `id`,`dm_dim_documents`.`id` AS `document_id`,`dm_dim_documents`.`alfresco_id` AS `alfresco_id`,`dm_dim_documents`.`node_type_id` AS `node_type_id`,`dm_dim_documents`.`mime_type_id` AS `mime_type_id`,`dm_dim_documents`.`user_creator_id` AS `user_creator_id`,`dm_dim_documents`.`creation_date_id` AS `creation_date_id`,`dm_dim_documents`.`creation_minute_id` AS `creation_minute_id`,`dm_dim_documents`.`user_last_modifier_id` AS `user_last_modifier_id`,`dm_dim_documents`.`last_modification_date_id` AS `last_modification_date_id`,`dm_dim_documents`.`last_modification_minute_id` AS `last_modification_minute_id`,`dm_dim_documents`.`is_latest_version` AS `is_latest_version`,`dm_dim_documents`.`is_major_version` AS `is_major_version`,`dm_dim_documents`.`is_latest_major_version` AS `is_latest_major_version`,`dm_dim_documents`.`is_immutable` AS `is_immutable`,`dm_dim_documents`.`parent_id` AS `parent_id`,`dm_dim_documents`.`content_stream_length` AS `content_stream_length`,1 AS `number` from `dm_dim_documents` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_dm_fact_repository`
--

/*!50001 DROP TABLE IF EXISTS `vw_dm_fact_repository`*/;
/*!50001 DROP VIEW IF EXISTS `vw_dm_fact_repository`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dm_fact_repository` AS SELECT concat("DOC_",`dm_dim_documents`.`id`) AS `id`, `dm_dim_documents`.`name` AS `name`, `dm_dim_documents`.`path` AS `path`, `dm_dim_documents`.`alfresco_id` AS `alfresco_id`, `dm_dim_documents`.`node_type_id` AS `node_type_id`, `dm_dim_documents`.`user_creator_id` AS `user_creator_id`, `dm_dim_documents`.`creation_date_id` AS `creation_date_id`, `dm_dim_documents`.`creation_minute_id` AS `creation_minute_id`, `dm_dim_documents`.`user_last_modifier_id` AS `user_last_modification_id`, `dm_dim_documents`.`last_modification_date_id` AS `last_modification_date_id`, `dm_dim_documents`.`last_modification_minute_id` AS `last_modification_minute_id`, concat("FOL_",`dm_dim_documents`.`parent_id`) AS `parent_id`, 1 AS `num`, `dm_dim_documents`.`content_stream_length` AS `bytes` FROM `dm_dim_documents` UNION ALL SELECT concat("FOL_",`dm_dim_folders`.`id`) AS `id`, `dm_dim_folders`.`name` AS `name`, `dm_dim_folders`.`path` AS `path`, `dm_dim_folders`.`alfresco_id` AS `alfresco_id`, `dm_dim_folders`.`node_type_id` AS `node_type_id`, `dm_dim_folders`.`user_creator_id` AS `user_creator_id`, `dm_dim_folders`.`creation_date_id` AS `creation_date_id`, `dm_dim_folders`.`creation_minute_id` AS `creation_minute_id`, `dm_dim_folders`.`user_last_modifier_id` AS `user_last_modifier_id`, `dm_dim_folders`.`last_modification_date_id` AS `last_modification_date_id`, `dm_dim_folders`.`last_modification_minute_id` AS `last_modification_minute_id`, concat("FOL_",`dm_dim_folders`.`parent_id`) AS `parent_id`, 1 AS `num`, 0 AS `bytes` FROM `dm_dim_folders` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;


/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-05-12 19:42:11
