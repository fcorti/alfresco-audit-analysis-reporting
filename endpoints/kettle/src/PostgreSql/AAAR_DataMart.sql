--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.10
-- Dumped by pg_dump version 9.1.10
-- Started on 2013-11-19 22:03:52 CET

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 206 (class 3079 OID 11681)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2242 (class 0 OID 0)
-- Dependencies: 206
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 161 (class 1259 OID 17274)
-- Dependencies: 6
-- Name: seq_dm_dim_actions_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_dm_dim_actions_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_dm_dim_actions_id OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 162 (class 1259 OID 17276)
-- Dependencies: 1969 6
-- Name: dm_dim_actions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dm_dim_actions (
    id smallint DEFAULT nextval('seq_dm_dim_actions_id'::regclass) NOT NULL,
    "desc" character varying(128) NOT NULL,
    alfresco_id smallint NOT NULL,
    src_action character varying(128) NOT NULL
);


ALTER TABLE public.dm_dim_actions OWNER TO postgres;

--
-- TOC entry 163 (class 1259 OID 17280)
-- Dependencies: 1970 6
-- Name: dm_dim_alfresco; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dm_dim_alfresco (
    id smallint NOT NULL,
    "desc" character varying(255) NOT NULL,
    login character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    url character varying(1024) NOT NULL,
    url_audit_suffix character varying(1024) NOT NULL,
    url_cmis_suffix character varying(1024) NOT NULL,
    is_active character(1) DEFAULT 'Y'::bpchar NOT NULL
);


ALTER TABLE public.dm_dim_alfresco OWNER TO postgres;

--
-- TOC entry 164 (class 1259 OID 17287)
-- Dependencies: 6
-- Name: dm_dim_dates; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dm_dim_dates (
    id date NOT NULL,
    "desc" character varying(64) NOT NULL,
    day_desc character varying(64) NOT NULL,
    month_id date NOT NULL
);


ALTER TABLE public.dm_dim_dates OWNER TO postgres;

--
-- TOC entry 165 (class 1259 OID 17290)
-- Dependencies: 6
-- Name: seq_dm_dim_documents_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_dm_dim_documents_id
    START WITH 11
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_dm_dim_documents_id OWNER TO postgres;

--
-- TOC entry 166 (class 1259 OID 17292)
-- Dependencies: 1971 6
-- Name: dm_dim_documents; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dm_dim_documents (
    id integer DEFAULT nextval('seq_dm_dim_documents_id'::regclass) NOT NULL,
    name character varying(1024) NOT NULL,
    path character varying(4096) NOT NULL,
    node_type_id smallint NOT NULL,
    mime_type_id smallint NOT NULL,
    user_creator_id integer NOT NULL,
    creation_date_id date,
    creation_minute_id smallint NOT NULL,
    user_last_modifier_id integer NOT NULL,
    last_modification_date_id date NOT NULL,
    last_modification_minute_id smallint NOT NULL,
    content_stream_length integer NOT NULL,
    is_latest_version character(1) NOT NULL,
    is_major_version character(1) NOT NULL,
    is_latest_major_version character(1) NOT NULL,
    is_immutable character(1) NOT NULL,
    parent_id integer NOT NULL,
    alfresco_id smallint NOT NULL,
    src_id character varying(1024) NOT NULL
);


ALTER TABLE public.dm_dim_documents OWNER TO postgres;

--
-- TOC entry 167 (class 1259 OID 17299)
-- Dependencies: 6
-- Name: seq_dm_dim_folders_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_dm_dim_folders_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_dm_dim_folders_id OWNER TO postgres;

--
-- TOC entry 168 (class 1259 OID 17301)
-- Dependencies: 1972 6
-- Name: dm_dim_folders; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dm_dim_folders (
    id integer DEFAULT nextval('seq_dm_dim_folders_id'::regclass) NOT NULL,
    name character varying(1024) NOT NULL,
    path character varying(4096) NOT NULL,
    node_type_id smallint NOT NULL,
    user_creator_id integer NOT NULL,
    creation_date_id date,
    creation_minute_id smallint NOT NULL,
    user_last_modifier_id integer NOT NULL,
    last_modification_date_id date NOT NULL,
    last_modification_minute_id smallint NOT NULL,
    parent_id integer,
    alfresco_id smallint NOT NULL,
    src_id character varying(1024) NOT NULL
);


ALTER TABLE public.dm_dim_folders OWNER TO postgres;

--
-- TOC entry 169 (class 1259 OID 17308)
-- Dependencies: 6
-- Name: dm_dim_hours; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dm_dim_hours (
    id smallint NOT NULL,
    "desc" character varying(16) NOT NULL
);


ALTER TABLE public.dm_dim_hours OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 17311)
-- Dependencies: 6
-- Name: seq_dm_dim_mime_types_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_dm_dim_mime_types_id
    START WITH 11
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_dm_dim_mime_types_id OWNER TO postgres;

--
-- TOC entry 171 (class 1259 OID 17313)
-- Dependencies: 1973 6
-- Name: dm_dim_mime_types; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dm_dim_mime_types (
    id smallint DEFAULT nextval('seq_dm_dim_mime_types_id'::regclass) NOT NULL,
    "desc" character varying(512) NOT NULL,
    alfresco_id smallint NOT NULL,
    src_id character varying(512) NOT NULL
);


ALTER TABLE public.dm_dim_mime_types OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 17320)
-- Dependencies: 6
-- Name: dm_dim_minutes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dm_dim_minutes (
    id smallint NOT NULL,
    "desc" character varying(16) NOT NULL,
    hour_id smallint NOT NULL
);


ALTER TABLE public.dm_dim_minutes OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 17323)
-- Dependencies: 6
-- Name: dm_dim_months; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dm_dim_months (
    id date NOT NULL,
    "desc" character varying(64) NOT NULL,
    month_desc character varying(64) NOT NULL,
    year_id smallint NOT NULL
);


ALTER TABLE public.dm_dim_months OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 17326)
-- Dependencies: 6
-- Name: seq_dm_dim_node_types_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_dm_dim_node_types_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_dm_dim_node_types_id OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 17328)
-- Dependencies: 1974 6
-- Name: dm_dim_node_types; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dm_dim_node_types (
    id smallint DEFAULT nextval('seq_dm_dim_node_types_id'::regclass) NOT NULL,
    "desc" character varying(512) NOT NULL,
    base_type character varying(512) NOT NULL,
    alfresco_id smallint NOT NULL,
    src_id character varying(512) NOT NULL
);


ALTER TABLE public.dm_dim_node_types OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 17335)
-- Dependencies: 6
-- Name: seq_dm_dim_paths_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_dm_dim_paths_id
    START WITH 11
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_dm_dim_paths_id OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 17337)
-- Dependencies: 1975 6
-- Name: dm_dim_paths; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dm_dim_paths (
    id integer DEFAULT nextval('seq_dm_dim_paths_id'::regclass) NOT NULL,
    path character varying(4096) NOT NULL,
    folder_id integer,
    document_id integer,
    alfresco_id smallint NOT NULL,
    src_path character varying(4096) NOT NULL
);


ALTER TABLE public.dm_dim_paths OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 17344)
-- Dependencies: 6
-- Name: seq_dm_dim_users_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_dm_dim_users_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_dm_dim_users_id OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 17346)
-- Dependencies: 1976 6
-- Name: dm_dim_users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dm_dim_users (
    id integer DEFAULT nextval('seq_dm_dim_users_id'::regclass) NOT NULL,
    "desc" character varying(512) NOT NULL,
    alfresco_id smallint NOT NULL,
    src_user character varying(512) NOT NULL
);


ALTER TABLE public.dm_dim_users OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 17353)
-- Dependencies: 6
-- Name: dm_dim_years; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dm_dim_years (
    id smallint NOT NULL,
    "desc" character varying NOT NULL
);


ALTER TABLE public.dm_dim_years OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 17359)
-- Dependencies: 6
-- Name: dm_fact_actions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dm_fact_actions (
    alfresco_id smallint NOT NULL,
    user_id integer NOT NULL,
    date_id date NOT NULL,
    minute_id smallint NOT NULL,
    action_id smallint NOT NULL,
    path_id integer NOT NULL,
    num smallint NOT NULL,
    src_id bigint NOT NULL
);


ALTER TABLE public.dm_fact_actions OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 17362)
-- Dependencies: 1977 1978 1979 1980 1981 1982 6
-- Name: dm_reports; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dm_reports (
    id smallint NOT NULL,
    pentaho_url character varying(1024) NOT NULL,
    pentaho_login character varying(1024) NOT NULL,
    pentaho_password character varying(1024) NOT NULL,
    pentaho_path character varying(1024) NOT NULL,
    prpt_name character varying(1024) NOT NULL,
    name character varying DEFAULT 1024 NOT NULL,
    alfresco_ftp character varying DEFAULT 1024 NOT NULL,
    alfresco_port smallint NOT NULL,
    alfresco_login character varying DEFAULT 100 NOT NULL,
    alfresco_password character varying DEFAULT 100 NOT NULL,
    alfresco_path character varying DEFAULT 1024 NOT NULL,
    is_active character(1) DEFAULT 'Y'::bpchar NOT NULL
);


ALTER TABLE public.dm_reports OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 17374)
-- Dependencies: 6
-- Name: log_channels; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE log_channels (
    id_batch integer,
    channel_id character varying(255),
    log_date timestamp without time zone,
    logging_object_type character varying(255),
    object_name character varying(255),
    object_copy character varying(255),
    repository_directory character varying(255),
    filename character varying(255),
    object_id character varying(255),
    object_revision character varying(255),
    parent_channel_id character varying(255),
    root_channel_id character varying(255)
);


ALTER TABLE public.log_channels OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 17380)
-- Dependencies: 6
-- Name: log_job; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE log_job (
    id_job integer,
    channel_id character varying(255),
    jobname character varying(255),
    status character varying(15),
    lines_read bigint,
    lines_written bigint,
    lines_updated bigint,
    lines_input bigint,
    lines_output bigint,
    lines_rejected bigint,
    errors bigint,
    startdate timestamp without time zone,
    enddate timestamp without time zone,
    logdate timestamp without time zone,
    depdate timestamp without time zone,
    replaydate timestamp without time zone,
    log_field text
);


ALTER TABLE public.log_job OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 17386)
-- Dependencies: 6
-- Name: log_jobentry; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE log_jobentry (
    id_batch integer,
    channel_id character varying(255),
    log_date timestamp without time zone,
    transname character varying(255),
    stepname character varying(255),
    lines_read bigint,
    lines_written bigint,
    lines_updated bigint,
    lines_input bigint,
    lines_output bigint,
    lines_rejected bigint,
    errors bigint,
    result character(1),
    nr_result_rows bigint,
    nr_result_files bigint
);


ALTER TABLE public.log_jobentry OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 17392)
-- Dependencies: 6
-- Name: log_performance; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE log_performance (
    id_batch integer,
    seq_nr integer,
    logdate timestamp without time zone,
    transname character varying(255),
    stepname character varying(255),
    step_copy integer,
    lines_read bigint,
    lines_written bigint,
    lines_updated bigint,
    lines_input bigint,
    lines_output bigint,
    lines_rejected bigint,
    errors bigint,
    input_buffer_rows bigint,
    output_buffer_rows bigint
);


ALTER TABLE public.log_performance OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 17398)
-- Dependencies: 6
-- Name: log_step; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE log_step (
    id_batch integer,
    channel_id character varying(255),
    log_date timestamp without time zone,
    transname character varying(255),
    stepname character varying(255),
    step_copy smallint,
    lines_read bigint,
    lines_written bigint,
    lines_updated bigint,
    lines_input bigint,
    lines_output bigint,
    lines_rejected bigint,
    errors bigint
);


ALTER TABLE public.log_step OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 17404)
-- Dependencies: 6
-- Name: log_transformations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE log_transformations (
    id_batch integer,
    channel_id character varying(255),
    transname character varying(255),
    status character varying(15),
    lines_read bigint,
    lines_written bigint,
    lines_updated bigint,
    lines_input bigint,
    lines_output bigint,
    lines_rejected bigint,
    errors bigint,
    startdate timestamp without time zone,
    enddate timestamp without time zone,
    logdate timestamp without time zone,
    depdate timestamp without time zone,
    replaydate timestamp without time zone,
    log_field text
);


ALTER TABLE public.log_transformations OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 17410)
-- Dependencies: 6
-- Name: ope_audits; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ope_audits (
    alfresco_id smallint NOT NULL,
    id bigint NOT NULL,
    application character varying(128) NOT NULL,
    "user" character varying(512) NOT NULL,
    date date NOT NULL,
    action character varying(128) NOT NULL,
    hour smallint NOT NULL,
    minute smallint NOT NULL,
    path character varying(4096) NOT NULL,
    cmis_objectid character varying(1024),
    cmis_objecttypeid character varying(1024)
);


ALTER TABLE public.ope_audits OWNER TO postgres;

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


ALTER TABLE public.ope_cmis_document_parent OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 17422)
-- Dependencies: 6
-- Name: stg_audits; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE stg_audits (
    alfresco_id smallint NOT NULL,
    id bigint NOT NULL,
    application character varying(50) NOT NULL,
    "user" character varying(100),
    "time" character varying(50) NOT NULL,
    "values" character varying(5000)
);


ALTER TABLE public.stg_audits OWNER TO postgres;

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


ALTER TABLE public.stg_cmis_documents OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 17434)
-- Dependencies: 6
-- Name: stg_cmis_documents_partial; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE stg_cmis_documents_partial (
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


ALTER TABLE public.stg_cmis_documents_partial OWNER TO postgres;

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


ALTER TABLE public.stg_cmis_folders OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 17446)
-- Dependencies: 6
-- Name: stg_cmis_folders_partial; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE stg_cmis_folders_partial (
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


ALTER TABLE public.stg_cmis_folders_partial OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 17452)
-- Dependencies: 2190 6
-- Name: vw_cmis_documents_and_folders_path; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_cmis_documents_and_folders_path AS
    SELECT stg_cmis_document.cmis_objectid, stg_cmis_document.cmis_objecttypeid, ((upper((stg_cmis_folder.cmis_path)::text) || CASE WHEN ((stg_cmis_folder.cmis_path)::text <> '/'::text) THEN '/'::text ELSE ''::text END) || upper((stg_cmis_document.cmis_name)::text)) AS cmis_path FROM stg_cmis_documents stg_cmis_document, ope_cmis_document_parent, stg_cmis_folders stg_cmis_folder WHERE ((((stg_cmis_document.alfresco_id = ope_cmis_document_parent.alfresco_id) AND ((ope_cmis_document_parent.cmis_objectid)::text = (stg_cmis_document.cmis_objectid)::text)) AND (ope_cmis_document_parent.alfresco_id = stg_cmis_folder.alfresco_id)) AND ((ope_cmis_document_parent.cmis_parentid)::text = (stg_cmis_folder.cmis_objectid)::text)) UNION ALL SELECT stg_cmis_folder.cmis_objectid, stg_cmis_folder.cmis_objecttypeid, upper((stg_cmis_folder.cmis_path)::text) AS cmis_path FROM stg_cmis_folders stg_cmis_folder WHERE (stg_cmis_folder.cmis_path IS NOT NULL);


ALTER TABLE public.vw_cmis_documents_and_folders_path OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 17457)
-- Dependencies: 2191 6
-- Name: vw_dm_dim_dates; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_dm_dim_dates AS
    SELECT dm_dim_dates.id, dm_dim_dates."desc" AS day, dm_dim_dates.day_desc, dm_dim_dates.month_id, dm_dim_months."desc" AS month, dm_dim_months.month_desc, dm_dim_months.year_id, dm_dim_years."desc" AS year FROM dm_dim_dates, dm_dim_months, dm_dim_years WHERE ((dm_dim_dates.month_id = dm_dim_months.id) AND (dm_dim_months.year_id = dm_dim_years.id));


ALTER TABLE public.vw_dm_dim_dates OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 17461)
-- Dependencies: 2192 6
-- Name: vw_dm_dim_documents; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_dm_dim_documents AS
    SELECT dm_dim_documents.id, dm_dim_documents.name, dm_dim_documents.path, dm_dim_documents.alfresco_id, dm_dim_documents.src_id FROM dm_dim_documents;


ALTER TABLE public.vw_dm_dim_documents OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 17465)
-- Dependencies: 2193 6
-- Name: vw_dm_dim_flag_immutable; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_dm_dim_flag_immutable AS
    SELECT DISTINCT dm_dim_documents.is_immutable FROM dm_dim_documents;


ALTER TABLE public.vw_dm_dim_flag_immutable OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 17469)
-- Dependencies: 2194 6
-- Name: vw_dm_dim_flag_latest_major_version; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_dm_dim_flag_latest_major_version AS
    SELECT DISTINCT dm_dim_documents.is_latest_major_version FROM dm_dim_documents;


ALTER TABLE public.vw_dm_dim_flag_latest_major_version OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 17473)
-- Dependencies: 2195 6
-- Name: vw_dm_dim_flag_latest_version; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_dm_dim_flag_latest_version AS
    SELECT DISTINCT dm_dim_documents.is_latest_version FROM dm_dim_documents;


ALTER TABLE public.vw_dm_dim_flag_latest_version OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 17477)
-- Dependencies: 2196 6
-- Name: vw_dm_dim_flag_major_version; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_dm_dim_flag_major_version AS
    SELECT DISTINCT dm_dim_documents.is_major_version FROM dm_dim_documents;


ALTER TABLE public.vw_dm_dim_flag_major_version OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 17481)
-- Dependencies: 2197 6
-- Name: vw_dm_dim_minutes; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_dm_dim_minutes AS
    SELECT dm_dim_minutes.id, dm_dim_minutes."desc" AS minute, dm_dim_minutes.hour_id, dm_dim_hours."desc" AS hour FROM dm_dim_minutes, dm_dim_hours WHERE (dm_dim_minutes.hour_id = dm_dim_hours.id);


ALTER TABLE public.vw_dm_dim_minutes OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 17485)
-- Dependencies: 2198 6
-- Name: vw_dm_fact_documents; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_dm_fact_documents AS
    SELECT dm_dim_documents.id, dm_dim_documents.id AS document_id, dm_dim_documents.node_type_id, dm_dim_documents.mime_type_id, dm_dim_documents.user_creator_id, dm_dim_documents.creation_date_id, dm_dim_documents.creation_minute_id, dm_dim_documents.user_last_modifier_id, dm_dim_documents.last_modification_date_id, dm_dim_documents.last_modification_minute_id, dm_dim_documents.is_latest_version, dm_dim_documents.is_major_version, dm_dim_documents.is_latest_major_version, dm_dim_documents.is_immutable, dm_dim_documents.parent_id, dm_dim_documents.content_stream_length, 1 AS number FROM dm_dim_documents;


ALTER TABLE public.vw_dm_fact_documents OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 17489)
-- Dependencies: 2199 6
-- Name: vw_dm_min_date; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_dm_min_date AS
    SELECT t.alfresco_id, min(t.date) AS min_date FROM ((SELECT ope_audit.alfresco_id, min(ope_audit.date) AS date FROM ope_audits ope_audit GROUP BY ope_audit.alfresco_id UNION ALL SELECT stg_cmis_folder.alfresco_id, min(stg_cmis_folder.cmis_creationdate) AS date FROM stg_cmis_folders stg_cmis_folder GROUP BY stg_cmis_folder.alfresco_id) UNION ALL SELECT stg_cmis_document.alfresco_id, min(stg_cmis_document.cmis_creationdate) AS date FROM stg_cmis_documents stg_cmis_document GROUP BY stg_cmis_document.alfresco_id) t GROUP BY t.alfresco_id;


ALTER TABLE public.vw_dm_min_date OWNER TO postgres;

--
-- TOC entry 2201 (class 0 OID 17276)
-- Dependencies: 162 2235
-- Data for Name: dm_dim_actions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2202 (class 0 OID 17280)
-- Dependencies: 163 2235
-- Data for Name: dm_dim_alfresco; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO dm_dim_alfresco (id, "desc", login, password, url, url_audit_suffix, url_cmis_suffix, is_active) VALUES (1, 'Default Alfresco instance', 'admin', 'admin', 'http://localhost:8080', '/alfresco/service/api/audit/query/alfresco-access?verbose=true&limit=100000', '/alfresco/service/api/cmis', 'Y');


--
-- TOC entry 2203 (class 0 OID 17287)
-- Dependencies: 164 2235
-- Data for Name: dm_dim_dates; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2205 (class 0 OID 17292)
-- Dependencies: 166 2235
-- Data for Name: dm_dim_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2207 (class 0 OID 17301)
-- Dependencies: 168 2235
-- Data for Name: dm_dim_folders; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2208 (class 0 OID 17308)
-- Dependencies: 169 2235
-- Data for Name: dm_dim_hours; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2210 (class 0 OID 17313)
-- Dependencies: 171 2235
-- Data for Name: dm_dim_mime_types; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2211 (class 0 OID 17320)
-- Dependencies: 172 2235
-- Data for Name: dm_dim_minutes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2212 (class 0 OID 17323)
-- Dependencies: 173 2235
-- Data for Name: dm_dim_months; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2214 (class 0 OID 17328)
-- Dependencies: 175 2235
-- Data for Name: dm_dim_node_types; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2216 (class 0 OID 17337)
-- Dependencies: 177 2235
-- Data for Name: dm_dim_paths; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2218 (class 0 OID 17346)
-- Dependencies: 179 2235
-- Data for Name: dm_dim_users; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2219 (class 0 OID 17353)
-- Dependencies: 180 2235
-- Data for Name: dm_dim_years; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2220 (class 0 OID 17359)
-- Dependencies: 181 2235
-- Data for Name: dm_fact_actions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2221 (class 0 OID 17362)
-- Dependencies: 182 2235
-- Data for Name: dm_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (5, 'http://localhost:8080/pentaho', 'admin', 'password', '/', 'audit_use.prpt', 'audit_use.pdf', 'localhost', 1121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (6, 'http://localhost:8080/pentaho', 'admin', 'password', '/', 'document_active_users.prpt', 'document_active_users.pdf', 'localhost', 1121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (7, 'http://localhost:8080/pentaho', 'admin', 'password', '/', 'document_hours_of_activity.prpt', 'document_hours_of_activity.pdf', 'localhost', 1121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (8, 'http://localhost:8080/pentaho', 'admin', 'password', '/', 'document_mime_types.prpt', 'document_mime_types.pdf', 'localhost', 1121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (9, 'http://localhost:8080/pentaho', 'admin', 'password', '/', 'document_size.prpt', 'document_size.pdf', 'localhost', 1121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (10, 'http://localhost:8080/pentaho', 'admin', 'password', '/', 'document_types.prpt', 'document_types.pdf', 'localhost', 1121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (11, 'http://localhost:8080/pentaho', 'admin', 'password', '/', 'folder_types.prpt', 'folder_types.pdf', 'localhost', 1121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (1, 'http://localhost:8080/pentaho', 'admin', 'password', '/', 'audit_creation.prpt', 'audit_creation.pdf', 'localhost', 1121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (2, 'http://localhost:8080/pentaho', 'admin', 'password', '/', 'audit_details.prpt', 'audit_details.pdf', 'localhost', 1121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (3, 'http://localhost:8080/pentaho', 'admin', 'password', '/', 'audit_login.prpt', 'audit_login.pdf', 'localhost', 1121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (4, 'http://localhost:8080/pentaho', 'admin', 'password', '/', 'audit_topTen.prpt', 'audit_topTen.pdf', 'localhost', 1121, 'admin', 'admin', 'alfresco', 'Y');


--
-- TOC entry 2222 (class 0 OID 17374)
-- Dependencies: 183 2235
-- Data for Name: log_channels; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2223 (class 0 OID 17380)
-- Dependencies: 184 2235
-- Data for Name: log_job; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2224 (class 0 OID 17386)
-- Dependencies: 185 2235
-- Data for Name: log_jobentry; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2225 (class 0 OID 17392)
-- Dependencies: 186 2235
-- Data for Name: log_performance; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2226 (class 0 OID 17398)
-- Dependencies: 187 2235
-- Data for Name: log_step; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2227 (class 0 OID 17404)
-- Dependencies: 188 2235
-- Data for Name: log_transformations; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2228 (class 0 OID 17410)
-- Dependencies: 189 2235
-- Data for Name: ope_audits; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2229 (class 0 OID 17416)
-- Dependencies: 190 2235
-- Data for Name: ope_cmis_document_parent; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2243 (class 0 OID 0)
-- Dependencies: 161
-- Name: seq_dm_dim_actions_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_dm_dim_actions_id', 1, true);


--
-- TOC entry 2244 (class 0 OID 0)
-- Dependencies: 165
-- Name: seq_dm_dim_documents_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_dm_dim_documents_id', 1, true);


--
-- TOC entry 2245 (class 0 OID 0)
-- Dependencies: 167
-- Name: seq_dm_dim_folders_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_dm_dim_folders_id', 8837, true);


--
-- TOC entry 2246 (class 0 OID 0)
-- Dependencies: 170
-- Name: seq_dm_dim_mime_types_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_dm_dim_mime_types_id', 1, true);


--
-- TOC entry 2247 (class 0 OID 0)
-- Dependencies: 174
-- Name: seq_dm_dim_node_types_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_dm_dim_node_types_id', 1, true);


--
-- TOC entry 2248 (class 0 OID 0)
-- Dependencies: 176
-- Name: seq_dm_dim_paths_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_dm_dim_paths_id', 1, true);


--
-- TOC entry 2249 (class 0 OID 0)
-- Dependencies: 178
-- Name: seq_dm_dim_users_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_dm_dim_users_id', 1, true);


--
-- TOC entry 2230 (class 0 OID 17422)
-- Dependencies: 191 2235
-- Data for Name: stg_audits; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2231 (class 0 OID 17428)
-- Dependencies: 192 2235
-- Data for Name: stg_cmis_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2232 (class 0 OID 17434)
-- Dependencies: 193 2235
-- Data for Name: stg_cmis_documents_partial; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2233 (class 0 OID 17440)
-- Dependencies: 194 2235
-- Data for Name: stg_cmis_folders; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2234 (class 0 OID 17446)
-- Dependencies: 195 2235
-- Data for Name: stg_cmis_folders_partial; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 1985 (class 2606 OID 17494)
-- Dependencies: 162 162 2236
-- Name: pk_dm_dim_action; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_actions
    ADD CONSTRAINT pk_dm_dim_action PRIMARY KEY (id);


--
-- TOC entry 1991 (class 2606 OID 17496)
-- Dependencies: 164 164 2236
-- Name: pk_dm_dim_dates; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_dates
    ADD CONSTRAINT pk_dm_dim_dates PRIMARY KEY (id);


--
-- TOC entry 1995 (class 2606 OID 17498)
-- Dependencies: 166 166 2236
-- Name: pk_dm_dim_documents; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT pk_dm_dim_documents PRIMARY KEY (id);


--
-- TOC entry 2001 (class 2606 OID 17500)
-- Dependencies: 168 168 2236
-- Name: pk_dm_dim_folders; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT pk_dm_dim_folders PRIMARY KEY (id);


--
-- TOC entry 2006 (class 2606 OID 17502)
-- Dependencies: 169 169 2236
-- Name: pk_dm_dim_hours; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_hours
    ADD CONSTRAINT pk_dm_dim_hours PRIMARY KEY (id);


--
-- TOC entry 2009 (class 2606 OID 17504)
-- Dependencies: 171 171 2236
-- Name: pk_dm_dim_mime_types; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_mime_types
    ADD CONSTRAINT pk_dm_dim_mime_types PRIMARY KEY (id);


--
-- TOC entry 2012 (class 2606 OID 17506)
-- Dependencies: 172 172 2236
-- Name: pk_dm_dim_minutes; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_minutes
    ADD CONSTRAINT pk_dm_dim_minutes PRIMARY KEY (id);


--
-- TOC entry 2015 (class 2606 OID 17508)
-- Dependencies: 173 173 2236
-- Name: pk_dm_dim_months; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_months
    ADD CONSTRAINT pk_dm_dim_months PRIMARY KEY (id);


--
-- TOC entry 2018 (class 2606 OID 17510)
-- Dependencies: 175 175 2236
-- Name: pk_dm_dim_node_types; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_node_types
    ADD CONSTRAINT pk_dm_dim_node_types PRIMARY KEY (id);


--
-- TOC entry 2021 (class 2606 OID 17512)
-- Dependencies: 177 177 2236
-- Name: pk_dm_dim_path; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_paths
    ADD CONSTRAINT pk_dm_dim_path PRIMARY KEY (id);


--
-- TOC entry 2024 (class 2606 OID 17514)
-- Dependencies: 179 179 2236
-- Name: pk_dm_dim_users; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_users
    ADD CONSTRAINT pk_dm_dim_users PRIMARY KEY (id);


--
-- TOC entry 2027 (class 2606 OID 17516)
-- Dependencies: 180 180 2236
-- Name: pk_dm_dim_years; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_years
    ADD CONSTRAINT pk_dm_dim_years PRIMARY KEY (id);


--
-- TOC entry 2035 (class 2606 OID 17518)
-- Dependencies: 190 190 190 190 2236
-- Name: pk_ope_cmis_document_parent; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ope_cmis_document_parent
    ADD CONSTRAINT pk_ope_cmis_document_parent PRIMARY KEY (alfresco_id, cmis_objectid, cmis_parentid);


--
-- TOC entry 2029 (class 2606 OID 17520)
-- Dependencies: 182 182 2236
-- Name: pk_reports; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_reports
    ADD CONSTRAINT pk_reports PRIMARY KEY (id);


--
-- TOC entry 1988 (class 2606 OID 17522)
-- Dependencies: 163 163 2236
-- Name: pk_stg_alfresco; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_alfresco
    ADD CONSTRAINT pk_stg_alfresco PRIMARY KEY (id);


--
-- TOC entry 2037 (class 2606 OID 17524)
-- Dependencies: 191 191 191 191 2236
-- Name: pk_stg_audit; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stg_audits
    ADD CONSTRAINT pk_stg_audit PRIMARY KEY (alfresco_id, id, application);


--
-- TOC entry 2033 (class 2606 OID 17526)
-- Dependencies: 189 189 189 189 2236
-- Name: pk_stg_audit_extended; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ope_audits
    ADD CONSTRAINT pk_stg_audit_extended PRIMARY KEY (alfresco_id, id, application);


--
-- TOC entry 2040 (class 2606 OID 17528)
-- Dependencies: 192 192 192 2236
-- Name: uni_cmis_document; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stg_cmis_documents
    ADD CONSTRAINT uni_cmis_document UNIQUE (alfresco_id, cmis_objectid);


--
-- TOC entry 2043 (class 2606 OID 17530)
-- Dependencies: 193 193 193 2236
-- Name: uni_cmis_document_partial; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stg_cmis_documents_partial
    ADD CONSTRAINT uni_cmis_document_partial UNIQUE (alfresco_id, cmis_objectid);


--
-- TOC entry 2046 (class 2606 OID 17532)
-- Dependencies: 194 194 194 2236
-- Name: uni_cmis_folder_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stg_cmis_folders
    ADD CONSTRAINT uni_cmis_folder_id UNIQUE (alfresco_id, cmis_objectid);


--
-- TOC entry 2049 (class 2606 OID 17534)
-- Dependencies: 195 195 195 2236
-- Name: uni_cmis_folder_partial__id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stg_cmis_folders_partial
    ADD CONSTRAINT uni_cmis_folder_partial__id UNIQUE (alfresco_id, cmis_objectid);


--
-- TOC entry 1997 (class 2606 OID 17536)
-- Dependencies: 166 166 166 2236
-- Name: unq_dm_dim_documents; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT unq_dm_dim_documents UNIQUE (alfresco_id, src_id);


--
-- TOC entry 2003 (class 2606 OID 17538)
-- Dependencies: 168 168 168 2236
-- Name: unq_dm_dim_folders; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT unq_dm_dim_folders UNIQUE (alfresco_id, src_id);


--
-- TOC entry 1983 (class 1259 OID 17539)
-- Dependencies: 162 2236
-- Name: idx_dm_dim_actions; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_actions ON dm_dim_actions USING btree (id);


--
-- TOC entry 1986 (class 1259 OID 17540)
-- Dependencies: 163 2236
-- Name: idx_dm_dim_alfresco; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_alfresco ON dm_dim_alfresco USING btree (id);


--
-- TOC entry 1989 (class 1259 OID 17541)
-- Dependencies: 164 2236
-- Name: idx_dm_dim_dates; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_dates ON dm_dim_dates USING btree (id);


--
-- TOC entry 1992 (class 1259 OID 17542)
-- Dependencies: 166 2236
-- Name: idx_dm_dim_documents; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_documents ON dm_dim_documents USING btree (id);


--
-- TOC entry 1993 (class 1259 OID 17543)
-- Dependencies: 166 166 2236
-- Name: idx_dm_dim_documents_src_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_documents_src_id ON dm_dim_documents USING btree (alfresco_id, src_id);


--
-- TOC entry 1998 (class 1259 OID 17544)
-- Dependencies: 168 2236
-- Name: idx_dm_dim_folders; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_folders ON dm_dim_folders USING btree (id);


--
-- TOC entry 1999 (class 1259 OID 17545)
-- Dependencies: 168 168 2236
-- Name: idx_dm_dim_folders_src_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_folders_src_id ON dm_dim_folders USING btree (alfresco_id, src_id);


--
-- TOC entry 2004 (class 1259 OID 17546)
-- Dependencies: 169 2236
-- Name: idx_dm_dim_hours; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_hours ON dm_dim_hours USING btree (id);


--
-- TOC entry 2007 (class 1259 OID 17547)
-- Dependencies: 171 2236
-- Name: idx_dm_dim_mime_types; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_mime_types ON dm_dim_mime_types USING btree (id);


--
-- TOC entry 2010 (class 1259 OID 17548)
-- Dependencies: 172 2236
-- Name: idx_dm_dim_minutes; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_minutes ON dm_dim_minutes USING btree (id);


--
-- TOC entry 2013 (class 1259 OID 17549)
-- Dependencies: 173 2236
-- Name: idx_dm_dim_months; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_months ON dm_dim_months USING btree (id);


--
-- TOC entry 2016 (class 1259 OID 17550)
-- Dependencies: 175 2236
-- Name: idx_dm_dim_node_types; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_node_types ON dm_dim_node_types USING btree (id);


--
-- TOC entry 2019 (class 1259 OID 17551)
-- Dependencies: 177 2236
-- Name: idx_dm_dim_paths; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_paths ON dm_dim_paths USING btree (id);


--
-- TOC entry 2022 (class 1259 OID 17552)
-- Dependencies: 179 2236
-- Name: idx_dm_dim_users; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_users ON dm_dim_users USING btree (id);


--
-- TOC entry 2025 (class 1259 OID 17553)
-- Dependencies: 180 2236
-- Name: idx_dm_dim_years; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_years ON dm_dim_years USING btree (id);


--
-- TOC entry 2030 (class 1259 OID 17554)
-- Dependencies: 188 2236
-- Name: idx_log_transformations_1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_log_transformations_1 ON log_transformations USING btree (id_batch);


--
-- TOC entry 2031 (class 1259 OID 17555)
-- Dependencies: 188 188 188 2236
-- Name: idx_log_transformations_2; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_log_transformations_2 ON log_transformations USING btree (errors, status, transname);


--
-- TOC entry 2038 (class 1259 OID 17556)
-- Dependencies: 192 192 192 2236
-- Name: idx_stg_cmis_documents_key; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_stg_cmis_documents_key ON stg_cmis_documents USING btree (alfresco_id, cmis_lastmodificationdate, cmis_name);


--
-- TOC entry 2041 (class 1259 OID 17557)
-- Dependencies: 193 193 193 2236
-- Name: idx_stg_cmis_documents_partial_key; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_stg_cmis_documents_partial_key ON stg_cmis_documents_partial USING btree (alfresco_id, cmis_contentstreamlength, cmis_name);


--
-- TOC entry 2044 (class 1259 OID 17558)
-- Dependencies: 194 194 194 2236
-- Name: idx_stg_cmis_folders_key; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_stg_cmis_folders_key ON stg_cmis_folders USING btree (alfresco_id, cmis_lastmodificationdate, cmis_name);


--
-- TOC entry 2047 (class 1259 OID 17559)
-- Dependencies: 195 195 195 2236
-- Name: idx_stg_cmis_folders_partial_key; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_stg_cmis_folders_partial_key ON stg_cmis_folders_partial USING btree (alfresco_id, cmis_lastmodificationdate, cmis_name);


--
-- TOC entry 2086 (class 2606 OID 17560)
-- Dependencies: 2039 192 190 192 190 2236
-- Name: fk_cmis_document_parent_document; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ope_cmis_document_parent
    ADD CONSTRAINT fk_cmis_document_parent_document FOREIGN KEY (alfresco_id, cmis_objectid) REFERENCES stg_cmis_documents(alfresco_id, cmis_objectid);


--
-- TOC entry 2087 (class 2606 OID 17565)
-- Dependencies: 194 190 190 194 2045 2236
-- Name: fk_cmis_document_parent_parent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ope_cmis_document_parent
    ADD CONSTRAINT fk_cmis_document_parent_parent FOREIGN KEY (alfresco_id, cmis_parentid) REFERENCES stg_cmis_folders(alfresco_id, cmis_objectid);


--
-- TOC entry 2050 (class 2606 OID 17570)
-- Dependencies: 163 162 1987 2236
-- Name: fk_dm_dim_action_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_actions
    ADD CONSTRAINT fk_dm_dim_action_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2051 (class 2606 OID 17575)
-- Dependencies: 173 2014 164 2236
-- Name: fk_dm_dim_dates_dm_dim_months; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_dates
    ADD CONSTRAINT fk_dm_dim_dates_dm_dim_months FOREIGN KEY (month_id) REFERENCES dm_dim_months(id);


--
-- TOC entry 2052 (class 2606 OID 17580)
-- Dependencies: 166 163 1987 2236
-- Name: fk_dm_dim_documents_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT fk_dm_dim_documents_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2053 (class 2606 OID 17585)
-- Dependencies: 164 1990 166 2236
-- Name: fk_dm_dim_documents_dm_dim_dates_creation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT fk_dm_dim_documents_dm_dim_dates_creation FOREIGN KEY (creation_date_id) REFERENCES dm_dim_dates(id);


--
-- TOC entry 2054 (class 2606 OID 17590)
-- Dependencies: 166 1990 164 2236
-- Name: fk_dm_dim_documents_dm_dim_dates_last_modification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT fk_dm_dim_documents_dm_dim_dates_last_modification FOREIGN KEY (last_modification_date_id) REFERENCES dm_dim_dates(id);


--
-- TOC entry 2055 (class 2606 OID 17595)
-- Dependencies: 2000 168 166 2236
-- Name: fk_dm_dim_documents_dm_dim_folders_parent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT fk_dm_dim_documents_dm_dim_folders_parent FOREIGN KEY (parent_id) REFERENCES dm_dim_folders(id);


--
-- TOC entry 2056 (class 2606 OID 17600)
-- Dependencies: 2008 171 166 2236
-- Name: fk_dm_dim_documents_dm_dim_mime_types; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT fk_dm_dim_documents_dm_dim_mime_types FOREIGN KEY (mime_type_id) REFERENCES dm_dim_mime_types(id);


--
-- TOC entry 2057 (class 2606 OID 17605)
-- Dependencies: 172 2011 166 2236
-- Name: fk_dm_dim_documents_dm_dim_minutes_creation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT fk_dm_dim_documents_dm_dim_minutes_creation FOREIGN KEY (creation_minute_id) REFERENCES dm_dim_minutes(id);


--
-- TOC entry 2058 (class 2606 OID 17610)
-- Dependencies: 166 2011 172 2236
-- Name: fk_dm_dim_documents_dm_dim_minutes_last_modification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT fk_dm_dim_documents_dm_dim_minutes_last_modification FOREIGN KEY (last_modification_minute_id) REFERENCES dm_dim_minutes(id);


--
-- TOC entry 2059 (class 2606 OID 17615)
-- Dependencies: 2017 166 175 2236
-- Name: fk_dm_dim_documents_dm_dim_node_types; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT fk_dm_dim_documents_dm_dim_node_types FOREIGN KEY (node_type_id) REFERENCES dm_dim_node_types(id);


--
-- TOC entry 2060 (class 2606 OID 17620)
-- Dependencies: 179 166 2023 2236
-- Name: fk_dm_dim_documents_dm_dim_users_creator; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT fk_dm_dim_documents_dm_dim_users_creator FOREIGN KEY (user_creator_id) REFERENCES dm_dim_users(id);


--
-- TOC entry 2061 (class 2606 OID 17625)
-- Dependencies: 2023 166 179 2236
-- Name: fk_dm_dim_documents_dm_dim_users_last_modifier; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT fk_dm_dim_documents_dm_dim_users_last_modifier FOREIGN KEY (user_last_modifier_id) REFERENCES dm_dim_users(id);


--
-- TOC entry 2062 (class 2606 OID 17630)
-- Dependencies: 1987 168 163 2236
-- Name: fk_dm_dim_folders_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT fk_dm_dim_folders_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2063 (class 2606 OID 17635)
-- Dependencies: 164 1990 168 2236
-- Name: fk_dm_dim_folders_dm_dim_dates_creation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT fk_dm_dim_folders_dm_dim_dates_creation FOREIGN KEY (creation_date_id) REFERENCES dm_dim_dates(id);


--
-- TOC entry 2064 (class 2606 OID 17640)
-- Dependencies: 1990 164 168 2236
-- Name: fk_dm_dim_folders_dm_dim_dates_last_modification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT fk_dm_dim_folders_dm_dim_dates_last_modification FOREIGN KEY (last_modification_date_id) REFERENCES dm_dim_dates(id);


--
-- TOC entry 2065 (class 2606 OID 17645)
-- Dependencies: 168 2000 168 2236
-- Name: fk_dm_dim_folders_dm_dim_folders_aprent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT fk_dm_dim_folders_dm_dim_folders_aprent FOREIGN KEY (parent_id) REFERENCES dm_dim_folders(id);


--
-- TOC entry 2066 (class 2606 OID 17650)
-- Dependencies: 168 2011 172 2236
-- Name: fk_dm_dim_folders_dm_dim_minutes_creation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT fk_dm_dim_folders_dm_dim_minutes_creation FOREIGN KEY (creation_minute_id) REFERENCES dm_dim_minutes(id);


--
-- TOC entry 2067 (class 2606 OID 17655)
-- Dependencies: 168 2011 172 2236
-- Name: fk_dm_dim_folders_dm_dim_minutes_last_modification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT fk_dm_dim_folders_dm_dim_minutes_last_modification FOREIGN KEY (last_modification_minute_id) REFERENCES dm_dim_minutes(id);


--
-- TOC entry 2068 (class 2606 OID 17660)
-- Dependencies: 168 2017 175 2236
-- Name: fk_dm_dim_folders_dm_dim_node_types; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT fk_dm_dim_folders_dm_dim_node_types FOREIGN KEY (node_type_id) REFERENCES dm_dim_node_types(id);


--
-- TOC entry 2069 (class 2606 OID 17665)
-- Dependencies: 168 2023 179 2236
-- Name: fk_dm_dim_folders_dm_dim_users_creator; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT fk_dm_dim_folders_dm_dim_users_creator FOREIGN KEY (user_creator_id) REFERENCES dm_dim_users(id);


--
-- TOC entry 2070 (class 2606 OID 17670)
-- Dependencies: 2023 168 179 2236
-- Name: fk_dm_dim_folders_dm_dim_users_last_modifier; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT fk_dm_dim_folders_dm_dim_users_last_modifier FOREIGN KEY (user_last_modifier_id) REFERENCES dm_dim_users(id);


--
-- TOC entry 2071 (class 2606 OID 17675)
-- Dependencies: 1987 171 163 2236
-- Name: fk_dm_dim_mime_types_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_mime_types
    ADD CONSTRAINT fk_dm_dim_mime_types_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2072 (class 2606 OID 17680)
-- Dependencies: 172 169 2005 2236
-- Name: fk_dm_dim_minutes_dm_dim_hours; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_minutes
    ADD CONSTRAINT fk_dm_dim_minutes_dm_dim_hours FOREIGN KEY (hour_id) REFERENCES dm_dim_hours(id);


--
-- TOC entry 2073 (class 2606 OID 17685)
-- Dependencies: 180 173 2026 2236
-- Name: fk_dm_dim_months_dm_dim_years; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_months
    ADD CONSTRAINT fk_dm_dim_months_dm_dim_years FOREIGN KEY (year_id) REFERENCES dm_dim_years(id);


--
-- TOC entry 2074 (class 2606 OID 17690)
-- Dependencies: 163 175 1987 2236
-- Name: fk_dm_dim_node_types_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_node_types
    ADD CONSTRAINT fk_dm_dim_node_types_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2075 (class 2606 OID 17695)
-- Dependencies: 163 1987 177 2236
-- Name: fk_dm_dim_path_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_paths
    ADD CONSTRAINT fk_dm_dim_path_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2076 (class 2606 OID 17700)
-- Dependencies: 177 168 2000 2236
-- Name: fk_dm_dim_path_dm_dim_folders; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_paths
    ADD CONSTRAINT fk_dm_dim_path_dm_dim_folders FOREIGN KEY (folder_id) REFERENCES dm_dim_folders(id);


--
-- TOC entry 2077 (class 2606 OID 17705)
-- Dependencies: 177 1994 166 2236
-- Name: fk_dm_dim_paths_dm_dim_documents; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_paths
    ADD CONSTRAINT fk_dm_dim_paths_dm_dim_documents FOREIGN KEY (document_id) REFERENCES dm_dim_documents(id);


--
-- TOC entry 2078 (class 2606 OID 17710)
-- Dependencies: 1987 163 179 2236
-- Name: fk_dm_dim_users_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_users
    ADD CONSTRAINT fk_dm_dim_users_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2079 (class 2606 OID 17715)
-- Dependencies: 162 181 1984 2236
-- Name: fk_dm_fact_actions_dm_dim_actions; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_fact_actions
    ADD CONSTRAINT fk_dm_fact_actions_dm_dim_actions FOREIGN KEY (action_id) REFERENCES dm_dim_actions(id);


--
-- TOC entry 2080 (class 2606 OID 17720)
-- Dependencies: 1987 163 181 2236
-- Name: fk_dm_fact_actions_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_fact_actions
    ADD CONSTRAINT fk_dm_fact_actions_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2081 (class 2606 OID 17725)
-- Dependencies: 164 181 1990 2236
-- Name: fk_dm_fact_actions_dm_dim_dates; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_fact_actions
    ADD CONSTRAINT fk_dm_fact_actions_dm_dim_dates FOREIGN KEY (date_id) REFERENCES dm_dim_dates(id);


--
-- TOC entry 2082 (class 2606 OID 17730)
-- Dependencies: 181 172 2011 2236
-- Name: fk_dm_fact_actions_dm_dim_minutes; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_fact_actions
    ADD CONSTRAINT fk_dm_fact_actions_dm_dim_minutes FOREIGN KEY (minute_id) REFERENCES dm_dim_minutes(id);


--
-- TOC entry 2083 (class 2606 OID 17735)
-- Dependencies: 181 177 2020 2236
-- Name: fk_dm_fact_actions_dm_dim_paths; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_fact_actions
    ADD CONSTRAINT fk_dm_fact_actions_dm_dim_paths FOREIGN KEY (path_id) REFERENCES dm_dim_paths(id);


--
-- TOC entry 2084 (class 2606 OID 17740)
-- Dependencies: 179 2023 181 2236
-- Name: fk_dm_fact_actions_dm_dim_users; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_fact_actions
    ADD CONSTRAINT fk_dm_fact_actions_dm_dim_users FOREIGN KEY (user_id) REFERENCES dm_dim_users(id);


--
-- TOC entry 2088 (class 2606 OID 17745)
-- Dependencies: 1987 163 191 2236
-- Name: fk_stg_audit_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stg_audits
    ADD CONSTRAINT fk_stg_audit_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2085 (class 2606 OID 17750)
-- Dependencies: 189 1987 163 2236
-- Name: fk_stg_audit_extended_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ope_audits
    ADD CONSTRAINT fk_stg_audit_extended_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2241 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-11-19 22:03:52 CET

--
-- PostgreSQL database dump complete
--

