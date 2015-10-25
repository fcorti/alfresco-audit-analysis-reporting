CREATE DATABASE  IF NOT EXISTS `AAAR_DataMart` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `AAAR_DataMart`;
-- MySQL dump 10.13  Distrib 5.5.41, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: AAAR_DataMart
-- ------------------------------------------------------
-- Server version	5.5.41-0ubuntu0.14.04.1

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
-- ORDER BY:  `id`


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
-- ORDER BY:  `id`


--
-- Table structure for table `dm_dim_alfresco`
--

DROP TABLE IF EXISTS `dm_dim_alfresco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_dim_alfresco` (
  `id` smallint(16) NOT NULL,
  `desc` char(25) NOT NULL,
  `login` char(100) NOT NULL,
  `password` char(100) NOT NULL,
  `url` varchar(1024) NOT NULL,
  `url_audit_suffix` varchar(1024) NOT NULL,
  `audit_limit` int(11) NOT NULL,
  `url_nodes_modified_after_suffix` varchar(1024) NOT NULL,
  `url_nodes_modified_before_suffix` varchar(1024) NOT NULL,
  `node_limit` int(11) NOT NULL,
  `url_cmis_suffix` varchar(1024) NOT NULL,
  `url_workflow_definitions_suffix` varchar(1024) NOT NULL,
  `url_workflow_instances_suffix` varchar(2014) NOT NULL,
  `is_active` char(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_dim_alfresco`
--
-- ORDER BY:  `id`

INSERT INTO `dm_dim_alfresco` (`id`, `desc`, `login`, `password`, `url`, `url_audit_suffix`, `audit_limit`, `url_nodes_modified_after_suffix`, `url_nodes_modified_before_suffix`, `node_limit`, `url_cmis_suffix`, `url_workflow_definitions_suffix`, `url_workflow_instances_suffix`, `is_active`) VALUES (1, 'Default Alfresco instance', 'admin', 'admin', 'http://localhost:8080', '/alfresco/service/api/audit/query/alfresco-access?verbose=true', 50000, '/alfresco/service/AAAR/getNodesModifiedAfter', '/alfresco/service/AAAR/getNodeIdsModifiedBefore', 50000, '/alfresco/api/-default-/cmis/versions/1.1/atom', '/alfresco/service/api/workflow-definitions', '/alfresco/service/api/workflow-instances', 'Y');

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
-- ORDER BY:  `id`


--
-- Table structure for table `dm_dim_documents`
--

DROP TABLE IF EXISTS `dm_dim_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_dim_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `store-protocol` varchar(128) NOT NULL,
  `store-identifier` varchar(128) NOT NULL,
  `node-uuid` varchar(128) NOT NULL,
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
  `size` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `alfresco_id` smallint(6) NOT NULL,
  `src_id` int(11) NOT NULL,
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
-- ORDER BY:  `id`


--
-- Table structure for table `dm_dim_folders`
--

DROP TABLE IF EXISTS `dm_dim_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_dim_folders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `store-protocol` varchar(128) NOT NULL,
  `store-identifier` varchar(128) NOT NULL,
  `node-uuid` varchar(128) NOT NULL,
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
  `src_id` int(11) NOT NULL,
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
-- ORDER BY:  `id`


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
-- ORDER BY:  `id`


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
-- ORDER BY:  `id`


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
-- ORDER BY:  `id`


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
-- ORDER BY:  `id`


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
-- ORDER BY:  `id`


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
-- ORDER BY:  `id`


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
-- ORDER BY:  `id`


--
-- Table structure for table `dm_dim_workflow_definitions`
--

DROP TABLE IF EXISTS `dm_dim_workflow_definitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_dim_workflow_definitions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1024) NOT NULL,
  `title` varchar(1024) NOT NULL,
  `desc` varchar(1024) NOT NULL,
  `version` varchar(64) NOT NULL,
  `url` varchar(1024) NOT NULL,
  `alfresco_id` smallint(6) NOT NULL,
  `src_id` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dm_dim_workflow_definitions_dm_dim_alfresco` (`alfresco_id`),
  CONSTRAINT `fk_dm_dim_workflow_definitions_dm_dim_alfresco` FOREIGN KEY (`alfresco_id`) REFERENCES `dm_dim_alfresco` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_dim_workflow_definitions`
--
-- ORDER BY:  `id`


--
-- Table structure for table `dm_dim_workflow_instances`
--

DROP TABLE IF EXISTS `dm_dim_workflow_instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_dim_workflow_instances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `definition_id` int(11) NOT NULL,
  `name` varchar(1024) NOT NULL,
  `title` varchar(1024) NOT NULL,
  `desc` varchar(1024) NOT NULL,
  `is_active` varchar(16) NOT NULL,
  `initiator_id` int(11) NOT NULL,
  `start_date_id` date NOT NULL,
  `start_minute_id` smallint(6) NOT NULL,
  `due_date_id` date NOT NULL,
  `due_minute_id` smallint(6) NOT NULL,
  `end_date_id` date NOT NULL,
  `end_minute_id` smallint(6) NOT NULL,
  `diagram_url` varchar(1024) NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `max_duration` int(11) DEFAULT NULL,
  `alfresco_id` smallint(6) NOT NULL,
  `src_id` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dm_dim_workflow_instances_dm_dim_alfresco` (`alfresco_id`),
  KEY `fk_dm_dim_workflow_instances_dm_dim_dates_due` (`due_date_id`),
  KEY `fk_dm_dim_workflow_instances_dm_dim_dates_end` (`end_date_id`),
  KEY `fk_dm_dim_workflow_instances_dm_dim_dates_start` (`start_date_id`),
  KEY `fk_dm_dim_workflow_instances_dm_dim_minutes_due` (`due_minute_id`),
  KEY `fk_dm_dim_workflow_instances_dm_dim_minutes_end` (`end_minute_id`),
  KEY `fk_dm_dim_workflow_instances_dm_dim_minutes_start` (`start_minute_id`),
  KEY `fk_dm_dim_workflow_instances_dm_dim_users` (`initiator_id`),
  KEY `fk_dm_dim_workflow_instances_dm_dim_workflow_definitions` (`definition_id`),
  CONSTRAINT `fk_dm_dim_workflow_instances_dm_dim_alfresco` FOREIGN KEY (`alfresco_id`) REFERENCES `dm_dim_alfresco` (`id`),
  CONSTRAINT `fk_dm_dim_workflow_instances_dm_dim_dates_due` FOREIGN KEY (`due_date_id`) REFERENCES `dm_dim_dates` (`id`),
  CONSTRAINT `fk_dm_dim_workflow_instances_dm_dim_dates_end` FOREIGN KEY (`end_date_id`) REFERENCES `dm_dim_dates` (`id`),
  CONSTRAINT `fk_dm_dim_workflow_instances_dm_dim_dates_start` FOREIGN KEY (`start_date_id`) REFERENCES `dm_dim_dates` (`id`),
  CONSTRAINT `fk_dm_dim_workflow_instances_dm_dim_minutes_due` FOREIGN KEY (`due_minute_id`) REFERENCES `dm_dim_minutes` (`id`),
  CONSTRAINT `fk_dm_dim_workflow_instances_dm_dim_minutes_end` FOREIGN KEY (`end_minute_id`) REFERENCES `dm_dim_minutes` (`id`),
  CONSTRAINT `fk_dm_dim_workflow_instances_dm_dim_minutes_start` FOREIGN KEY (`start_minute_id`) REFERENCES `dm_dim_minutes` (`id`),
  CONSTRAINT `fk_dm_dim_workflow_instances_dm_dim_users` FOREIGN KEY (`initiator_id`) REFERENCES `dm_dim_users` (`id`),
  CONSTRAINT `fk_dm_dim_workflow_instances_dm_dim_workflow_definitions` FOREIGN KEY (`definition_id`) REFERENCES `dm_dim_workflow_definitions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_dim_workflow_instances`
--
-- ORDER BY:  `id`


--
-- Table structure for table `dm_dim_workflow_items`
--

DROP TABLE IF EXISTS `dm_dim_workflow_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_dim_workflow_items` (
  `workflow_instance_id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `ordinal` smallint(6) NOT NULL,
  `alfresco_id` smallint(6) NOT NULL,
  PRIMARY KEY (`alfresco_id`,`workflow_instance_id`,`ordinal`),
  KEY `fk_dm_dim_workflow_items_dm_dim_documents` (`document_id`),
  KEY `fk_dm_dim_workflow_items_dm_dim_workflow_instances` (`workflow_instance_id`),
  CONSTRAINT `fk_dm_dim_workflow_items_dm_dim_alfresco` FOREIGN KEY (`alfresco_id`) REFERENCES `dm_dim_alfresco` (`id`),
  CONSTRAINT `fk_dm_dim_workflow_items_dm_dim_documents` FOREIGN KEY (`document_id`) REFERENCES `dm_dim_documents` (`id`),
  CONSTRAINT `fk_dm_dim_workflow_items_dm_dim_workflow_instances` FOREIGN KEY (`workflow_instance_id`) REFERENCES `dm_dim_workflow_instances` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_dim_workflow_items`
--
-- ORDER BY:  `alfresco_id`,`workflow_instance_id`,`ordinal`


--
-- Table structure for table `dm_dim_workflow_tasks`
--

DROP TABLE IF EXISTS `dm_dim_workflow_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_dim_workflow_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_id` int(11) NOT NULL,
  `name` varchar(1024) NOT NULL,
  `title` varchar(1024) NOT NULL,
  `desc` varchar(1024) NOT NULL,
  `state` varchar(64) NOT NULL,
  `status` varchar(64) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `is_pooled` varchar(16) NOT NULL,
  `is_editable` varchar(16) NOT NULL,
  `is_reassignable` varchar(16) NOT NULL,
  `is_claimable` varchar(16) NOT NULL,
  `outcome` varchar(128) NOT NULL,
  `start_date_id` date NOT NULL,
  `start_minute_id` smallint(6) NOT NULL,
  `due_date_id` date NOT NULL,
  `due_minute_id` smallint(6) NOT NULL,
  `completion_date_id` date NOT NULL,
  `completion_minute_id` smallint(6) NOT NULL,
  `duration` int(11) NOT NULL,
  `max_duration` int(11) NOT NULL,
  `ordinal` smallint(6) NOT NULL,
  `alfresco_id` smallint(6) NOT NULL,
  `src_id` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dm_dim_workflow_tasks_dm_dim_alfresco` (`alfresco_id`),
  KEY `fk_dm_dim_workflow_tasks_dm_dim_dates_completion` (`completion_date_id`),
  KEY `fk_dm_dim_workflow_tasks_dm_dim_dates_due` (`due_date_id`),
  KEY `fk_dm_dim_workflow_tasks_dm_dim_dates_start` (`start_date_id`),
  KEY `fk_dm_dim_workflow_tasks_dm_dim_minutes_completion` (`completion_minute_id`),
  KEY `fk_dm_dim_workflow_tasks_dm_dim_minutes_due` (`due_minute_id`),
  KEY `fk_dm_dim_workflow_tasks_dm_dim_minutes_start` (`start_minute_id`),
  KEY `fk_dm_dim_workflow_tasks_dm_dim_users` (`owner_id`),
  KEY `fk_dm_dim_workflow_tasks_dm_dim_workflow_instances` (`instance_id`),
  CONSTRAINT `fk_dm_dim_workflow_tasks_dm_dim_alfresco` FOREIGN KEY (`alfresco_id`) REFERENCES `dm_dim_alfresco` (`id`),
  CONSTRAINT `fk_dm_dim_workflow_tasks_dm_dim_dates_completion` FOREIGN KEY (`completion_date_id`) REFERENCES `dm_dim_dates` (`id`),
  CONSTRAINT `fk_dm_dim_workflow_tasks_dm_dim_dates_due` FOREIGN KEY (`due_date_id`) REFERENCES `dm_dim_dates` (`id`),
  CONSTRAINT `fk_dm_dim_workflow_tasks_dm_dim_dates_start` FOREIGN KEY (`start_date_id`) REFERENCES `dm_dim_dates` (`id`),
  CONSTRAINT `fk_dm_dim_workflow_tasks_dm_dim_minutes_completion` FOREIGN KEY (`completion_minute_id`) REFERENCES `dm_dim_minutes` (`id`),
  CONSTRAINT `fk_dm_dim_workflow_tasks_dm_dim_minutes_due` FOREIGN KEY (`due_minute_id`) REFERENCES `dm_dim_minutes` (`id`),
  CONSTRAINT `fk_dm_dim_workflow_tasks_dm_dim_minutes_start` FOREIGN KEY (`start_minute_id`) REFERENCES `dm_dim_minutes` (`id`),
  CONSTRAINT `fk_dm_dim_workflow_tasks_dm_dim_users` FOREIGN KEY (`owner_id`) REFERENCES `dm_dim_users` (`id`),
  CONSTRAINT `fk_dm_dim_workflow_tasks_dm_dim_workflow_instances` FOREIGN KEY (`instance_id`) REFERENCES `dm_dim_workflow_instances` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_dim_workflow_tasks`
--
-- ORDER BY:  `id`


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
-- ORDER BY:  `id`


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
-- ORDER BY:  `id`

INSERT INTO `dm_reports` (`id`, `pentaho_url`, `pentaho_login`, `pentaho_password`, `pentaho_path`, `prpt_name`, `name`, `alfresco_ftp`, `alfresco_port`, `alfresco_login`, `alfresco_password`, `alfresco_path`, `is_active`) VALUES (1,'http://localhost:8180/pentaho','admin','password','/public/AAAR/Reports','audit_login.prpt','audit_login.pdf','localhost',121,'admin','admin','alfresco','Y'),(2,'http://localhost:8180/pentaho','admin','password','/public/AAAR/Reports','audit_creation.prpt','audit_creation.pdf','localhost',121,'admin','admin','alfresco','Y'),(3,'http://localhost:8180/pentaho','admin','password','/public/AAAR/Reports','audit_use.prpt','audit_use.pdf','localhost',121,'admin','admin','alfresco','Y'),(4,'http://localhost:8180/pentaho','admin','password','/public/AAAR/Reports','audit_topTen.prpt','audit_topTen.pdf','localhost',121,'admin','admin','alfresco','Y'),(5,'http://localhost:8180/pentaho','admin','password','/public/AAAR/Reports','audit_details.prpt','audit_details.pdf','localhost',121,'admin','admin','alfresco','Y'),(6,'http://localhost:8180/pentaho','admin','password','/public/AAAR/Reports','document_active_users.prpt','document_active_users.pdf','localhost',121,'admin','admin','alfresco','Y'),(7,'http://localhost:8180/pentaho','admin','password','/public/AAAR/Reports','document_hours_of_activity.prpt','document_hours_of_activity.pdf','localhost',121,'admin','admin','alfresco','Y'),(8,'http://localhost:8180/pentaho','admin','password','/public/AAAR/Reports','document_mime_types.prpt','document_mime_types.pdf','localhost',121,'admin','admin','alfresco','Y'),(9,'http://localhost:8180/pentaho','admin','password','/public/AAAR/Reports','document_size.prpt','document_size.pdf','localhost',121,'admin','admin','alfresco','Y'),(10,'http://localhost:8180/pentaho','admin','password','/public/AAAR/Reports','document_types.prpt','document_types.pdf','localhost',121,'admin','admin','alfresco','Y'),(11,'http://localhost:8180/pentaho','admin','password','/public/AAAR/Reports','folder_types.prpt','folder_types.pdf','localhost',121,'admin','admin','alfresco','Y');

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
  `node-dbid` int(11) DEFAULT NULL,
  `type` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`alfresco_id`,`id`,`application`),
  CONSTRAINT `fk_stg_audit_extended_dm_dim_alfresco` FOREIGN KEY (`alfresco_id`) REFERENCES `dm_dim_alfresco` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ope_audits`
--
-- ORDER BY:  `alfresco_id`,`id`,`application`


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
-- ORDER BY:  `alfresco_id`,`id`,`application`


--
-- Table structure for table `stg_rest_documents`
--

DROP TABLE IF EXISTS `stg_rest_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stg_rest_documents` (
  `alfresco_id` smallint(6) NOT NULL,
  `node-dbid` int(11) NOT NULL,
  `store-protocol` varchar(128) DEFAULT NULL,
  `store-identifier` varchar(128) DEFAULT NULL,
  `node-uuid` varchar(128) DEFAULT NULL,
  `name` varchar(1024) DEFAULT NULL,
  `type` varchar(1024) DEFAULT NULL,
  `creator` varchar(1024) DEFAULT NULL,
  `created` varchar(32) DEFAULT NULL,
  `locale` varchar(128) DEFAULT NULL,
  `modifier` varchar(1024) DEFAULT NULL,
  `modified` varchar(32) DEFAULT NULL,
  `path` varchar(3072) DEFAULT NULL,
  `mimetype` varchar(128) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `encoding` varchar(128) DEFAULT NULL,
  `content-locale` varchar(128) DEFAULT NULL,
  `parent-node-uuid` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`alfresco_id`,`node-dbid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stg_rest_documents`
--
-- ORDER BY:  `alfresco_id`,`node-dbid`

--
-- Table structure for table `stg_rest_folders`
--

DROP TABLE IF EXISTS `stg_rest_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stg_rest_folders` (
  `alfresco_id` smallint(6) NOT NULL,
  `node-dbid` int(11) NOT NULL,
  `store-protocol` varchar(128) DEFAULT NULL,
  `store-identifier` varchar(128) DEFAULT NULL,
  `node-uuid` varchar(128) DEFAULT NULL,
  `name` varchar(1024) DEFAULT NULL,
  `type` varchar(1024) DEFAULT NULL,
  `creator` varchar(1024) DEFAULT NULL,
  `created` varchar(32) DEFAULT NULL,
  `locale` varchar(128) DEFAULT NULL,
  `modifier` varchar(1024) DEFAULT NULL,
  `modified` varchar(32) DEFAULT NULL,
  `path` varchar(3072) DEFAULT NULL,
  `parent-node-uuid` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`alfresco_id`,`node-dbid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stg_rest_folders`
--
-- ORDER BY:  `alfresco_id`,`node-dbid`

--
-- Table structure for table `stg_workflow_definitions`
--

DROP TABLE IF EXISTS `stg_workflow_definitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stg_workflow_definitions` (
  `alfresco_id` smallint(6) NOT NULL,
  `id` varchar(1024) NOT NULL,
  `name` varchar(1024) DEFAULT NULL,
  `title` varchar(1024) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `version` varchar(1024) DEFAULT NULL,
  `url` varchar(1024) NOT NULL,
  KEY `fk_stg_workflow_definitions_dm_dim_alfresco` (`alfresco_id`),
  CONSTRAINT `fk_stg_workflow_definitions_dm_dim_alfresco` FOREIGN KEY (`alfresco_id`) REFERENCES `dm_dim_alfresco` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stg_workflow_definitions`
--

INSERT INTO `stg_workflow_definitions` (`alfresco_id`, `id`, `name`, `title`, `description`, `version`, `url`) VALUES (1,'activiti$activitiAdhoc:1:4','activiti$activitiAdhoc','New Task','Assign a new task to yourself or a colleague','1','api/workflow-definitions/activiti$activitiAdhoc:1:4'),(1,'activiti$activitiInvitationModerated:1:23','activiti$activitiInvitationModerated','Invitation - Moderated','Moderated invitation to a resource such as a web site.','1','api/workflow-definitions/activiti$activitiInvitationModerated:1:23'),(1,'activiti$activitiInvitationNominated:1:26','activiti$activitiInvitationNominated','Site Invitation - Nominated','Invitation to a Share Site, nominated by a site manager','1','api/workflow-definitions/activiti$activitiInvitationNominated:1:26'),(1,'activiti$activitiParallelGroupReview:1:20','activiti$activitiParallelGroupReview','Review and Approve (group review)','Assign a review task to a group','1','api/workflow-definitions/activiti$activitiParallelGroupReview:1:20'),(1,'activiti$activitiParallelReview:1:16','activiti$activitiParallelReview','Review and Approve (one or more reviewers)','Assign a review task to multiple reviewers','1','api/workflow-definitions/activiti$activitiParallelReview:1:16'),(1,'activiti$activitiReview:1:8','activiti$activitiReview','Review And Approve (single reviewer)','Assign a review task to a single reviewer','1','api/workflow-definitions/activiti$activitiReview:1:8'),(1,'activiti$activitiReviewPooled:1:12','activiti$activitiReviewPooled','Review and Approve (pooled review)','Assign a review task to multiple reviewers, who can take ownership of the task','1','api/workflow-definitions/activiti$activitiReviewPooled:1:12'),(1,'activiti$publishWebContent:1:29','activiti$publishWebContent','Publish Web Content Activiti Process','Publishing of web content using Activiti workflow engine','1','api/workflow-definitions/activiti$publishWebContent:1:29');

--
-- Table structure for table `stg_workflow_instances`
--

DROP TABLE IF EXISTS `stg_workflow_instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stg_workflow_instances` (
  `alfresco_id` smallint(6) NOT NULL,
  `id` varchar(1024) NOT NULL,
  `url` varchar(1024) DEFAULT NULL,
  `name` varchar(1024) DEFAULT NULL,
  `title` varchar(1024) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `isactive` varchar(1024) DEFAULT NULL,
  `startdate` varchar(128) DEFAULT NULL,
  `message` varchar(1024) DEFAULT NULL,
  `enddate` varchar(128) DEFAULT NULL,
  `duedate` varchar(128) DEFAULT NULL,
  `package` varchar(1024) DEFAULT NULL,
  `initiator` varchar(256) DEFAULT NULL,
  `definitionurl` varchar(1024) DEFAULT NULL,
  KEY `fk_stg_workflow_instances_dm_dim_alfresco` (`alfresco_id`),
  CONSTRAINT `fk_stg_workflow_instances_dm_dim_alfresco` FOREIGN KEY (`alfresco_id`) REFERENCES `dm_dim_alfresco` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stg_workflow_instances`
--

INSERT INTO `stg_workflow_instances` (`alfresco_id`, `id`, `url`, `name`, `title`, `description`, `isactive`, `startdate`, `message`, `enddate`, `duedate`, `package`, `initiator`, `definitionurl`) VALUES (1,'activiti$101','api/workflow-instances/activiti$101','activiti$activitiReview','Review And Approve (single reviewer)','Assign a review task to a single reviewer','false','2015-04-12T09:05:10.836+02:00','approva grazie','2015-04-12T09:05:55.200+02:00',NULL,'workspace://SpacesStore/9ddcdb20-cb6e-4935-b3cd-29c3e1d046ab','admin','api/workflow-definitions/activiti$activitiReview:1:8'),(1,'activiti$218','api/workflow-instances/activiti$218','activiti$activitiAdhoc','New Task','Assign a new task to yourself or a colleague','true','2015-04-12T09:06:39.032+02:00','nuovo task',NULL,NULL,'workspace://SpacesStore/847fae8f-9669-4cd8-9aae-ae067518bab6','admin','api/workflow-definitions/activiti$activitiAdhoc:1:4'),(1,'activiti$350','api/workflow-instances/activiti$350','activiti$activitiAdhoc','New Task','Assign a new task to yourself or a colleague','true','2015-04-12T14:26:41.591+02:00','pisquano',NULL,'2015-05-30T00:00:00.000+02:00','workspace://SpacesStore/c5c6c720-aaab-43d2-91c0-ae06cd49ae8e','admin','api/workflow-definitions/activiti$activitiAdhoc:1:4');

--
-- Table structure for table `stg_workflow_items`
--

DROP TABLE IF EXISTS `stg_workflow_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stg_workflow_items` (
  `alfresco_id` smallint(6) NOT NULL,
  `package` varchar(1024) NOT NULL,
  `ordinal` smallint(6) NOT NULL,
  `item` varchar(1024) NOT NULL,
  KEY `fk_stg_workflow_packages_dm_dim_alfresco` (`alfresco_id`),
  CONSTRAINT `fk_stg_workflow_packages_dm_dim_alfresco` FOREIGN KEY (`alfresco_id`) REFERENCES `dm_dim_alfresco` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stg_workflow_items`
--

INSERT INTO `stg_workflow_items` (`alfresco_id`, `package`, `ordinal`, `item`) VALUES (1,'workspace://SpacesStore/9ddcdb20-cb6e-4935-b3cd-29c3e1d046ab',0,'workspace://SpacesStore/baab68f0-dad0-4556-8a49-21465ccf7cb5'),(1,'workspace://SpacesStore/847fae8f-9669-4cd8-9aae-ae067518bab6',0,'workspace://SpacesStore/93edec54-701d-4fcc-9c5b-f76fc3641d90'),(1,'workspace://SpacesStore/c5c6c720-aaab-43d2-91c0-ae06cd49ae8e',0,'workspace://SpacesStore/e58d3b0f-a223-432f-8b50-f34f270683fc');

--
-- Table structure for table `stg_workflow_tasks`
--

DROP TABLE IF EXISTS `stg_workflow_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stg_workflow_tasks` (
  `alfresco_id` smallint(6) NOT NULL,
  `instance_id` varchar(1024) DEFAULT NULL,
  `ordinal` int(11) DEFAULT NULL,
  `id` varchar(1024) NOT NULL,
  `name` varchar(1024) DEFAULT NULL,
  `title` varchar(1024) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `state` varchar(128) DEFAULT NULL,
  `ispooled` varchar(64) DEFAULT NULL,
  `iseditable` varchar(64) DEFAULT NULL,
  `isreassignable` varchar(64) DEFAULT NULL,
  `isclaimable` varchar(64) DEFAULT NULL,
  `isreleasable` varchar(64) DEFAULT NULL,
  `outcome` varchar(64) DEFAULT NULL,
  `owner` varchar(256) DEFAULT NULL,
  `bpm_startdate` varchar(128) DEFAULT NULL,
  `bpm_duedate` varchar(128) DEFAULT NULL,
  `bpm_completiondate` varchar(128) DEFAULT NULL,
  `bpm_outcome` varchar(1024) DEFAULT NULL,
  `bpm_status` varchar(1024) DEFAULT NULL,
  `bpm_description` varchar(1024) DEFAULT NULL,
  KEY `fk_stg_workflow_tasks_dm_dim_alfresco` (`alfresco_id`),
  CONSTRAINT `fk_stg_workflow_tasks_dm_dim_alfresco` FOREIGN KEY (`alfresco_id`) REFERENCES `dm_dim_alfresco` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stg_workflow_tasks`
--

INSERT INTO `stg_workflow_tasks` (`alfresco_id`, `instance_id`, `ordinal`, `id`, `name`, `title`, `description`, `state`, `ispooled`, `iseditable`, `isreassignable`, `isclaimable`, `isreleasable`, `outcome`, `owner`, `bpm_startdate`, `bpm_duedate`, `bpm_completiondate`, `bpm_outcome`, `bpm_status`, `bpm_description`) VALUES (1,'activiti$101',0,'activiti$145','wf:activitiReviewTask','Review','approva grazie','COMPLETED','false','false','false','false','false','Approved','admin','2015-04-12T07:05:10.864Z',NULL,'2015-04-12T07:05:46.813Z','Approve','Completed','approva grazie'),(1,'activiti$101',1,'activiti$188','wf:approvedTask','Approved','The document was reviewed and approved.','COMPLETED','false','false','false','false','false','Task Done','admin','2015-04-12T07:05:46.816Z',NULL,'2015-04-12T07:05:55.199Z','Next','Completed','The document was reviewed and approved.'),(1,'activiti$101',2,'activiti$start101','wf:submitReviewTask','Start Review','Submit documents for review and approval','COMPLETED','false','false','false','false','false','Task Done','admin','2015-04-12T07:05:10.836Z',NULL,'2015-04-12T07:05:10.836Z','Next','Completed','approva grazie'),(1,'activiti$218',0,'activiti$264','wf:adhocTask','Task','Task allocated by colleague','IN_PROGRESS','false','true','true','false','false',NULL,'admin','2015-04-12T07:06:39.032Z',NULL,NULL,NULL,'Not Yet Started','nuovo task'),(1,'activiti$218',1,'activiti$start218','wf:submitAdhocTask','Task','Allocate task to colleague','COMPLETED','false','false','false','false','false','Task Done','admin','2015-04-12T07:06:39.032Z',NULL,'2015-04-12T07:06:39.032Z','Next','Completed','nuovo task'),(1,'activiti$350',0,'activiti$396','wf:adhocTask','Task','Task allocated by colleague','IN_PROGRESS','false','true','true','false','false',NULL,'admin','2015-04-12T12:26:41.625Z','2015-05-29T22:00:00.000Z',NULL,NULL,'Not Yet Started','pisquano'),(1,'activiti$350',1,'activiti$start350','wf:submitAdhocTask','Task','Allocate task to colleague','COMPLETED','false','false','false','false','false','Task Done','admin','2015-04-12T12:26:41.591Z','2015-05-29T22:00:00.000Z','2015-04-12T12:26:41.591Z','Next','Completed','pisquano');

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
-- Temporary table structure for view `vw_dm_fact_documents`
--

DROP TABLE IF EXISTS `vw_dm_fact_documents`;
/*!50001 DROP VIEW IF EXISTS `vw_dm_fact_documents`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_dm_fact_documents` (
  `id` tinyint NOT NULL,
  `document_id` tinyint NOT NULL,
  `alfresco_id` tinyint NOT NULL,
  `node_type_id` tinyint NOT NULL,
  `mime_type_id` tinyint NOT NULL,
  `user_creator_id` tinyint NOT NULL,
  `creation_date_id` tinyint NOT NULL,
  `creation_minute_id` tinyint NOT NULL,
  `user_last_modifier_id` tinyint NOT NULL,
  `last_modification_date_id` tinyint NOT NULL,
  `last_modification_minute_id` tinyint NOT NULL,
  `parent_id` tinyint NOT NULL,
  `size` tinyint NOT NULL,
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
  `name` tinyint NOT NULL,
  `path` tinyint NOT NULL,
  `alfresco_id` tinyint NOT NULL,
  `node_type_id` tinyint NOT NULL,
  `user_creator_id` tinyint NOT NULL,
  `creation_date_id` tinyint NOT NULL,
  `creation_minute_id` tinyint NOT NULL,
  `user_last_modifier_id` tinyint NOT NULL,
  `last_modification_date_id` tinyint NOT NULL,
  `last_modification_minute_id` tinyint NOT NULL,
  `parent_id` tinyint NOT NULL,
  `num` tinyint NOT NULL,
  `bytes` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_dm_min_max_date`
--

DROP TABLE IF EXISTS `vw_dm_min_max_date`;
/*!50001 DROP VIEW IF EXISTS `vw_dm_min_max_date`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_dm_min_max_date` (
  `alfresco_id` tinyint NOT NULL,
  `max_date` tinyint NOT NULL,
  `min_date` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_dm_min_max_date_sub1`
--

DROP TABLE IF EXISTS `vw_dm_min_max_date_sub1`;
/*!50001 DROP VIEW IF EXISTS `vw_dm_min_max_date_sub1`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_dm_min_max_date_sub1` (
  `alfresco_id` tinyint NOT NULL,
  `max_date` tinyint NOT NULL,
  `min_date` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_dm_min_max_date_sub2`
--

DROP TABLE IF EXISTS `vw_dm_min_max_date_sub2`;
/*!50001 DROP VIEW IF EXISTS `vw_dm_min_max_date_sub2`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_dm_min_max_date_sub2` (
  `alfresco_id` tinyint NOT NULL,
  `max_date` tinyint NOT NULL,
  `min_date` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_dm_min_max_date_sub3`
--

DROP TABLE IF EXISTS `vw_dm_min_max_date_sub3`;
/*!50001 DROP VIEW IF EXISTS `vw_dm_min_max_date_sub3`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_dm_min_max_date_sub3` (
  `alfresco_id` tinyint NOT NULL,
  `max_date` tinyint NOT NULL,
  `min_date` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

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
/*!50001 VIEW `vw_cmis_documents_and_folders_path` AS select `stg_rest_documents`.`alfresco_id`,`stg_rest_documents`.`node-dbid`,`stg_rest_documents`.`type`,`stg_rest_documents`.`path` from `stg_rest_documents` union all select `stg_rest_folders`.`alfresco_id`,
`stg_rest_folders`.`node-dbid`, `stg_rest_folders`.`type`, `stg_rest_folders`.`path` from `stg_rest_folders` */;
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
/*!50001 VIEW `vw_dm_fact_documents` AS select `dm_dim_documents`.`id` AS `id`,`dm_dim_documents`.`id` AS `document_id`,`dm_dim_documents`.`alfresco_id` AS `alfresco_id`,`dm_dim_documents`.`node_type_id` AS `node_type_id`,`dm_dim_documents`.`mime_type_id` AS `mime_type_id`,`dm_dim_documents`.`user_creator_id` AS `user_creator_id`,`dm_dim_documents`.`creation_date_id` AS `creation_date_id`,`dm_dim_documents`.`creation_minute_id` AS `creation_minute_id`,`dm_dim_documents`.`user_last_modifier_id` AS `user_last_modifier_id`,`dm_dim_documents`.`last_modification_date_id` AS `last_modification_date_id`,`dm_dim_documents`.`last_modification_minute_id` AS `last_modification_minute_id`,`dm_dim_documents`.`parent_id` AS `parent_id`,`dm_dim_documents`.`size` AS `size`,1 AS `number` from `dm_dim_documents` */;
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
/*!50001 VIEW `vw_dm_fact_repository` AS select concat('DOC_',`dm_dim_documents`.`id`) AS `id`,`dm_dim_documents`.`name` AS `name`,`dm_dim_documents`.`path` AS `path`,`dm_dim_documents`.`alfresco_id` AS `alfresco_id`,`dm_dim_documents`.`node_type_id` AS `node_type_id`,`dm_dim_documents`.`user_creator_id` AS `user_creator_id`,`dm_dim_documents`.`creation_date_id` AS `creation_date_id`,`dm_dim_documents`.`creation_minute_id` AS `creation_minute_id`,`dm_dim_documents`.`user_last_modifier_id` AS `user_last_modifier_id`,`dm_dim_documents`.`last_modification_date_id` AS `last_modification_date_id`,`dm_dim_documents`.`last_modification_minute_id` AS `last_modification_minute_id`,concat('FOL_',`dm_dim_documents`.`parent_id`) AS `parent_id`,1 AS `num`,`dm_dim_documents`.`size` AS `bytes` from `dm_dim_documents` union all select concat('FOL_',`dm_dim_folders`.`id`) AS `id`,`dm_dim_folders`.`name` AS `name`,`dm_dim_folders`.`path` AS `path`,`dm_dim_folders`.`alfresco_id` AS `alfresco_id`,`dm_dim_folders`.`node_type_id` AS `node_type_id`,`dm_dim_folders`.`user_creator_id` AS `user_creator_id`,`dm_dim_folders`.`creation_date_id` AS `creation_date_id`,`dm_dim_folders`.`creation_minute_id` AS `creation_minute_id`,`dm_dim_folders`.`user_last_modifier_id` AS `user_last_modifier_id`,`dm_dim_folders`.`last_modification_date_id` AS `last_modification_date_id`,`dm_dim_folders`.`last_modification_minute_id` AS `last_modification_minute_id`,concat('FOL_',`dm_dim_folders`.`parent_id`) AS `parent_id`,1 AS `num`,0 AS `bytes` from `dm_dim_folders` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_dm_min_max_date`
--

/*!50001 DROP TABLE IF EXISTS `vw_dm_min_max_date`*/;
/*!50001 DROP VIEW IF EXISTS `vw_dm_min_max_date`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dm_min_max_date` AS select `ope_audit`.`alfresco_id` AS `alfresco_id`,max(`ope_audit`.`max_date`) AS `max_date`,min(`ope_audit`.`min_date`) AS `min_date` from `vw_dm_min_max_date_sub3` `ope_audit` group by `ope_audit`.`alfresco_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_dm_min_max_date_sub1`
--

/*!50001 DROP TABLE IF EXISTS `vw_dm_min_max_date_sub1`*/;
/*!50001 DROP VIEW IF EXISTS `vw_dm_min_max_date_sub1`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dm_min_max_date_sub1` AS select `ope_audit`.`alfresco_id` AS `alfresco_id`,max(`ope_audit`.`date`) AS `max_date`,min(`ope_audit`.`date`) AS `min_date` from `ope_audits` `ope_audit` group by `ope_audit`.`alfresco_id` union all select `stg_rest_folder`.`alfresco_id` AS `alfresco_id`,max(`stg_rest_folder`.`created`) AS `max_date`,min(`stg_rest_folder`.`created`) AS `min_date` from `stg_rest_folders` `stg_rest_folder` group by `stg_rest_folder`.`alfresco_id` union all select `stg_rest_folder`.`alfresco_id` AS `alfresco_id`,max(`stg_rest_folder`.`modified`) AS `max_date`,min(`stg_rest_folder`.`modified`) AS `min_date` from `stg_rest_folders` `stg_rest_folder` group by `stg_rest_folder`.`alfresco_id`*/;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_dm_min_max_date_sub2`
--

/*!50001 DROP TABLE IF EXISTS `vw_dm_min_max_date_sub2`*/;
/*!50001 DROP VIEW IF EXISTS `vw_dm_min_max_date_sub2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dm_min_max_date_sub2` AS select `ope_audit`.`alfresco_id` AS `alfresco_id`,max(`ope_audit`.`max_date`) AS `max_date`,min(`ope_audit`.`min_date`) AS `min_date` from `vw_dm_min_max_date_sub1` `ope_audit` group by `ope_audit`.`alfresco_id` union all select `stg_rest_document`.`alfresco_id` AS `alfresco_id`,max(`stg_rest_document`.`created`) AS `max_date`,min(`stg_rest_document`.`created`) AS `min_date` from `stg_rest_documents` `stg_rest_document` group by `stg_rest_document`.`alfresco_id` union all select `stg_rest_document`.`alfresco_id` AS `alfresco_id`,max(`stg_rest_document`.`modified`) AS `max_date`,min(`stg_rest_document`.`modified`) AS `min_date` from `stg_rest_documents` `stg_rest_document` group by `stg_rest_document`.`alfresco_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_dm_min_max_date_sub3`
--

/*!50001 DROP TABLE IF EXISTS `vw_dm_min_max_date_sub3`*/;
/*!50001 DROP VIEW IF EXISTS `vw_dm_min_max_date_sub3`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dm_min_max_date_sub3` AS select `dm_dim_alfresco`.`id` AS `alfresco_id`,curdate() AS `max_date`,curdate() AS `min_date` from `dm_dim_alfresco` union all select `ope_audit`.`alfresco_id` AS `alfresco_id`,max(`ope_audit`.`max_date`) AS `max_date`,min(`ope_audit`.`min_date`) AS `min_date` from `vw_dm_min_max_date_sub2` `ope_audit` group by `ope_audit`.`alfresco_id` union all select `stg_workflow_instances`.`alfresco_id` AS `alfresco_id`,min(str_to_date(`stg_workflow_instances`.`startdate`,'%Y-%m-%d')) AS `min_date`,max(str_to_date(`stg_workflow_instances`.`startdate`,'%Y-%m-%d')) AS `max_date` from `stg_workflow_instances` group by `stg_workflow_instances`.`alfresco_id` union all select `stg_workflow_instances`.`alfresco_id` AS `alfresco_id`,min(str_to_date(`stg_workflow_instances`.`enddate`,'%Y-%m-%d')) AS `min_date`,max(str_to_date(`stg_workflow_instances`.`enddate`,'%Y-%m-%d')) AS `max_date` from `stg_workflow_instances` group by `stg_workflow_instances`.`alfresco_id` union all select `stg_workflow_instances`.`alfresco_id` AS `alfresco_id`,min(str_to_date(`stg_workflow_instances`.`duedate`,'%Y-%m-%d')) AS `min_date`,max(str_to_date(`stg_workflow_instances`.`duedate`,'%Y-%m-%d')) AS `max_date` from `stg_workflow_instances` group by `stg_workflow_instances`.`alfresco_id` union all select `stg_workflow_tasks`.`alfresco_id` AS `alfresco_id`,min(str_to_date(`stg_workflow_tasks`.`bpm_startdate`,'%Y-%m-%d')) AS `min_date`,max(str_to_date(`stg_workflow_tasks`.`bpm_startdate`,'%Y-%m-%d')) AS `max_date` from `stg_workflow_tasks` group by `stg_workflow_tasks`.`alfresco_id` union all select `stg_workflow_tasks`.`alfresco_id` AS `alfresco_id`,min(str_to_date(`stg_workflow_tasks`.`bpm_duedate`,'%Y-%m-%d')) AS `min_date`,max(str_to_date(`stg_workflow_tasks`.`bpm_duedate`,'%Y-%m-%d')) AS `max_date` from `stg_workflow_tasks` group by `stg_workflow_tasks`.`alfresco_id` union all select `stg_workflow_tasks`.`alfresco_id` AS `alfresco_id`,min(str_to_date(`stg_workflow_tasks`.`bpm_completiondate`,'%Y-%m-%d')) AS `min_date`,max(str_to_date(`stg_workflow_tasks`.`bpm_completiondate`,'%Y-%m-%d')) AS `max_date` from `stg_workflow_tasks` group by `stg_workflow_tasks`.`alfresco_id` */;
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

-- Dump completed on 2015-04-12 14:42:44
