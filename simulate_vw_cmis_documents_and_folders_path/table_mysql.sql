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

/*!40000 ALTER TABLE `stg_cmis_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `stg_cmis_documents` ENABLE KEYS */;

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

/*!40000 ALTER TABLE `stg_cmis_folders` DISABLE KEYS */;
/*!40000 ALTER TABLE `stg_cmis_folders` ENABLE KEYS */;

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

/*!40000 ALTER TABLE `ope_cmis_document_parent` DISABLE KEYS */;
/*!40000 ALTER TABLE `ope_cmis_document_parent` ENABLE KEYS */;

