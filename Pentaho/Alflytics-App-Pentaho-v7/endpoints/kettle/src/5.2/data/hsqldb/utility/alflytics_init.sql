/*
 * 
 * Alflytics - The Alfresco data warehouse and analytics for Pentaho platform.
 * 
 * Script to clean the Alflytics Data Warehouse.
 * Author: Francesco Corti (all rights reserved)
 * Date: 10 May, 2016
 *
 * Disclaimer:
 * We can't be responsible for any damage done to your system,
 * which hopefully will not happen.
 *
 */ 
TRUNCATE TABLE DWH_ALF_DIM_USERS;
TRUNCATE TABLE DWH_DATA_QUALITY_LOGS;
TRUNCATE TABLE DWH_DATA_QUALITY;
TRUNCATE TABLE STG_ALF_USERS;
ALTER TABLE DWH_ALF_DIM_USERS ALTER COLUMN ID RESTART WITH 0;

