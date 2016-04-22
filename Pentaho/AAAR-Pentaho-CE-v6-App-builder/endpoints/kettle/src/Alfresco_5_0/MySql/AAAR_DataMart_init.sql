-- 
-- A.A.A.R. - Alfresco Audit Analysis and Reporting
-- 
-- Script to clean the AAAR Data Mart.
-- Author: Francesco Corti (all rights reserved)
-- Date: 04 May, 2015
-- 
-- Disclaimer:
-- We can't be responsible for any damage done to your system,
-- which hopefully will not happen.
-- 
DELETE FROM `AAAR_DataMart`.`dm_fact_actions`;
DELETE FROM `AAAR_DataMart`.`dm_dim_workflow_items`;
DELETE FROM `AAAR_DataMart`.`dm_dim_workflow_tasks`;
DELETE FROM `AAAR_DataMart`.`dm_dim_workflow_instances`;
DELETE FROM `AAAR_DataMart`.`dm_dim_workflow_definitions`;
DELETE FROM `AAAR_DataMart`.`dm_dim_paths`;
DELETE FROM `AAAR_DataMart`.`dm_dim_documents`;
DELETE FROM `AAAR_DataMart`.`dm_dim_folders`;
DELETE FROM `AAAR_DataMart`.`dm_dim_minutes`;
DELETE FROM `AAAR_DataMart`.`dm_dim_hours`;
DELETE FROM `AAAR_DataMart`.`dm_dim_dates`;
DELETE FROM `AAAR_DataMart`.`dm_dim_months`;
DELETE FROM `AAAR_DataMart`.`dm_dim_years`;
DELETE FROM `AAAR_DataMart`.`dm_dim_users`;
DELETE FROM `AAAR_DataMart`.`dm_dim_months`;
DELETE FROM `AAAR_DataMart`.`dm_dim_minutes`;
DELETE FROM `AAAR_DataMart`.`dm_dim_actions`;
DELETE FROM `AAAR_DataMart`.`dm_dim_node_types`;
DELETE FROM `AAAR_DataMart`.`dm_dim_mime_types`;
DELETE FROM `AAAR_DataMart`.`log_channels`;
DELETE FROM `AAAR_DataMart`.`log_job`;
DELETE FROM `AAAR_DataMart`.`log_jobentry`;
DELETE FROM `AAAR_DataMart`.`log_performance`;
DELETE FROM `AAAR_DataMart`.`log_step`;
DELETE FROM `AAAR_DataMart`.`log_transformations`;
DELETE FROM `AAAR_DataMart`.`ope_audits`;
DELETE FROM `AAAR_DataMart`.`stg_audits`;
DELETE FROM `AAAR_DataMart`.`stg_rest_documents_custom_types`;
DELETE FROM `AAAR_DataMart`.`stg_rest_documents`;
DELETE FROM `AAAR_DataMart`.`stg_rest_folders_custom_types`;
DELETE FROM `AAAR_DataMart`.`stg_rest_folders`;
ALTER TABLE dm_fact_actions AUTO_INCREMENT=1;
ALTER TABLE dm_dim_paths AUTO_INCREMENT=1;
ALTER TABLE dm_dim_documents AUTO_INCREMENT=1;
ALTER TABLE dm_dim_folders AUTO_INCREMENT=1;
ALTER TABLE dm_dim_minutes AUTO_INCREMENT=1;
ALTER TABLE dm_dim_hours AUTO_INCREMENT=1;
ALTER TABLE dm_dim_dates AUTO_INCREMENT=1;
ALTER TABLE dm_dim_months AUTO_INCREMENT=1;
ALTER TABLE dm_dim_years AUTO_INCREMENT=1;
ALTER TABLE dm_dim_users AUTO_INCREMENT=1;
ALTER TABLE dm_dim_months AUTO_INCREMENT=1;
ALTER TABLE dm_dim_minutes AUTO_INCREMENT=1;
ALTER TABLE dm_dim_actions AUTO_INCREMENT=1;
ALTER TABLE dm_dim_node_types AUTO_INCREMENT=1;
ALTER TABLE dm_dim_mime_types AUTO_INCREMENT=1;
ALTER TABLE dm_dim_workflow_tasks AUTO_INCREMENT=1;
ALTER TABLE dm_dim_workflow_instances AUTO_INCREMENT=1;
ALTER TABLE dm_dim_workflow_definitions AUTO_INCREMENT=1;
