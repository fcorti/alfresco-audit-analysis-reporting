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
delete from dm_fact_actions;
delete from dm_dim_workflow_items;
delete from dm_dim_workflow_tasks;
delete from dm_dim_workflow_instances;
delete from dm_dim_workflow_definitions;
delete from dm_dim_paths;
delete from dm_dim_documents;
delete from dm_dim_folders;
delete from dm_dim_minutes;
delete from dm_dim_hours;
delete from dm_dim_dates;
delete from dm_dim_months;
delete from dm_dim_years;
delete from dm_dim_users;
delete from dm_dim_months;
delete from dm_dim_minutes;
delete from dm_dim_actions;
delete from dm_dim_node_types;
delete from dm_dim_mime_types;
delete from log_channels;
delete from log_job;
delete from log_jobentry;
delete from log_performance;
delete from log_step;
delete from log_transformations;
delete from ope_audits;
delete from ope_cmis_document_parent;
delete from stg_audits;
delete from stg_cmis_documents_partial;
delete from stg_cmis_folders_partial;
delete from stg_cmis_documents;
delete from stg_cmis_folders;
alter table dm_fact_actions AUTO_INCREMENT=1;
alter table dm_dim_paths AUTO_INCREMENT=1;
alter table dm_dim_documents AUTO_INCREMENT=1;
alter table dm_dim_folders AUTO_INCREMENT=1;
alter table dm_dim_minutes AUTO_INCREMENT=1;
alter table dm_dim_hours AUTO_INCREMENT=1;
alter table dm_dim_dates AUTO_INCREMENT=1;
alter table dm_dim_months AUTO_INCREMENT=1;
alter table dm_dim_years AUTO_INCREMENT=1;
alter table dm_dim_users AUTO_INCREMENT=1;
alter table dm_dim_months AUTO_INCREMENT=1;
alter table dm_dim_minutes AUTO_INCREMENT=1;
alter table dm_dim_actions AUTO_INCREMENT=1;
alter table dm_dim_node_types AUTO_INCREMENT=1;
alter table dm_dim_mime_types AUTO_INCREMENT=1;
alter table dm_dim_workflow_tasks AUTO_INCREMENT=1;
alter table dm_dim_workflow_instances AUTO_INCREMENT=1;
alter table dm_dim_workflow_definitions AUTO_INCREMENT=1;
