
--
-- TOC entry 192 (class 1259 OID 17428)
-- Dependencies: 6
-- Name: stg_cmis_documents; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE stg_cmis_documents (
    alfresco_id smallint NOT NULL,
    cmis_islatestmajorversion character(1),
    cmis_contentstreamid character varying(1024),
    cmis_contentstreamlength integer,
    cmis_objecttypeid character varying(512),
    cmis_versionseriescheckedoutby character varying(512),
    cmis_versionseriescheckedoutid character varying(512),
    cmis_name character varying(1024),
    cmis_contentstreammimetype character varying(512),
    cmis_versionseriesid character varying(1024),
    cmis_creationdate timestamp without time zone,
    cmis_changetoken character varying(1024),
    cmis_islatestversion character(1),
    cmis_versionlabel character varying(256),
    cmis_isversionseriescheckedout character(1),
    cmis_lastmodifiedby character varying(512),
    cmis_createdby character varying(512),
    cmis_checkincomment text,
    cmis_objectid character varying(1024) NOT NULL,
    cmis_ismajorversion character(1),
    cmis_isimmutable character(1),
    alfcmis_noderef text,
    cmis_basetypeid character varying(512),
    cmis_lastmodificationdate timestamp without time zone,
    cmis_contentstreamfilename character varying(1024)
);



--
-- TOC entry 194 (class 1259 OID 17440)
-- Dependencies: 6
-- Name: stg_cmis_folders; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE stg_cmis_folders (
    alfresco_id smallint NOT NULL,
    cmis_allowedchildobjecttypeids character varying(1024),
    cmis_path character varying(4096),
    cmis_objecttypeid character varying(512),
    cmis_name character varying(1024),
    cmis_creationdate timestamp without time zone,
    cmis_changetoken character varying(1024),
    cmis_lastmodifiedby character varying(512),
    cmis_createdby character varying(512),
    cmis_objectid character varying(1024) NOT NULL,
    cmis_basetypeid character varying(512),
    alfcmis_noderef text,
    cmis_parentid character varying(1024),
    cmis_lastmodificationdate timestamp without time zone
);

--
-- TOC entry 190 (class 1259 OID 17416)
-- Dependencies: 6
-- Name: ope_cmis_document_parent; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ope_cmis_document_parent (
    alfresco_id smallint NOT NULL,
    cmis_objectid character varying(1024) NOT NULL,
    cmis_parentid character varying(1024) NOT NULL,
    cmis_path character varying(4096) NOT NULL
);
