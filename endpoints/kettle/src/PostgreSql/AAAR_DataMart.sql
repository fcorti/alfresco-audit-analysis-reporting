--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.10
-- Dumped by pg_dump version 9.1.10
-- Started on 2014-05-26 23:13:34 CEST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 2256 (class 1262 OID 16384)
-- Name: AAAR_DataMart; Type: DATABASE; Schema: -; Owner: postgres
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 208 (class 3079 OID 11681)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2259 (class 0 OID 0)
-- Dependencies: 208
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 206 (class 1259 OID 17235)
-- Dependencies: 6
-- Name: seq_dm_custom_metadata_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_dm_custom_metadata_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_dm_custom_metadata_id OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 207 (class 1259 OID 17255)
-- Dependencies: 1989 1990 1991 1992 1993 6
-- Name: dm_custom_metadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dm_custom_metadata (
    id smallint DEFAULT nextval('seq_dm_custom_metadata_id'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    is_document_type character(1) DEFAULT 'N'::bpchar NOT NULL,
    is_folder_type character(1) DEFAULT 'N'::bpchar NOT NULL,
    is_aspect character(1) DEFAULT 'N'::bpchar NOT NULL,
    is_active character(1) DEFAULT 'Y'::bpchar NOT NULL,
    alfresco_id smallint NOT NULL
);


ALTER TABLE public.dm_custom_metadata OWNER TO postgres;

--
-- TOC entry 161 (class 1259 OID 16386)
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

--
-- TOC entry 162 (class 1259 OID 16388)
-- Dependencies: 1975 6
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
-- TOC entry 163 (class 1259 OID 16392)
-- Dependencies: 1976 6
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
-- TOC entry 164 (class 1259 OID 16399)
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
-- TOC entry 165 (class 1259 OID 16402)
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
-- TOC entry 166 (class 1259 OID 16404)
-- Dependencies: 1977 6
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
-- TOC entry 167 (class 1259 OID 16411)
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
-- TOC entry 168 (class 1259 OID 16413)
-- Dependencies: 1978 6
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
-- TOC entry 169 (class 1259 OID 16420)
-- Dependencies: 6
-- Name: dm_dim_hours; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dm_dim_hours (
    id smallint NOT NULL,
    "desc" character varying(16) NOT NULL
);


ALTER TABLE public.dm_dim_hours OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 16423)
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
-- TOC entry 171 (class 1259 OID 16425)
-- Dependencies: 1979 6
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
-- TOC entry 172 (class 1259 OID 16432)
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
-- TOC entry 173 (class 1259 OID 16435)
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
-- TOC entry 174 (class 1259 OID 16438)
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
-- TOC entry 175 (class 1259 OID 16440)
-- Dependencies: 1980 6
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
-- TOC entry 176 (class 1259 OID 16447)
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
-- TOC entry 177 (class 1259 OID 16449)
-- Dependencies: 1981 6
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
-- TOC entry 178 (class 1259 OID 16456)
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
-- TOC entry 179 (class 1259 OID 16458)
-- Dependencies: 1982 6
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
-- TOC entry 180 (class 1259 OID 16465)
-- Dependencies: 6
-- Name: dm_dim_years; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dm_dim_years (
    id smallint NOT NULL,
    "desc" character varying NOT NULL
);


ALTER TABLE public.dm_dim_years OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 16471)
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
-- TOC entry 182 (class 1259 OID 16474)
-- Dependencies: 1983 1984 1985 1986 1987 1988 6
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
-- TOC entry 183 (class 1259 OID 16486)
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
-- TOC entry 184 (class 1259 OID 16492)
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
-- TOC entry 185 (class 1259 OID 16498)
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
-- TOC entry 186 (class 1259 OID 16504)
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
-- TOC entry 187 (class 1259 OID 16510)
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
-- TOC entry 188 (class 1259 OID 16516)
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
-- TOC entry 189 (class 1259 OID 16522)
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
-- TOC entry 190 (class 1259 OID 16528)
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
-- TOC entry 191 (class 1259 OID 16534)
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
-- TOC entry 192 (class 1259 OID 16540)
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
-- TOC entry 193 (class 1259 OID 16546)
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
-- TOC entry 194 (class 1259 OID 16552)
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
-- TOC entry 195 (class 1259 OID 16558)
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
-- TOC entry 196 (class 1259 OID 16564)
-- Dependencies: 2205 6
-- Name: vw_cmis_documents_and_folders_path; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_cmis_documents_and_folders_path AS
    SELECT stg_cmis_document.cmis_objectid, stg_cmis_document.cmis_objecttypeid, ((upper((stg_cmis_folder.cmis_path)::text) || CASE WHEN ((stg_cmis_folder.cmis_path)::text <> '/'::text) THEN '/'::text ELSE ''::text END) || upper((stg_cmis_document.cmis_name)::text)) AS cmis_path FROM stg_cmis_documents stg_cmis_document, ope_cmis_document_parent, stg_cmis_folders stg_cmis_folder WHERE ((((stg_cmis_document.alfresco_id = ope_cmis_document_parent.alfresco_id) AND ((ope_cmis_document_parent.cmis_objectid)::text = (stg_cmis_document.cmis_objectid)::text)) AND (ope_cmis_document_parent.alfresco_id = stg_cmis_folder.alfresco_id)) AND ((ope_cmis_document_parent.cmis_parentid)::text = (stg_cmis_folder.cmis_objectid)::text)) UNION ALL SELECT stg_cmis_folder.cmis_objectid, stg_cmis_folder.cmis_objecttypeid, upper((stg_cmis_folder.cmis_path)::text) AS cmis_path FROM stg_cmis_folders stg_cmis_folder WHERE (stg_cmis_folder.cmis_path IS NOT NULL);


ALTER TABLE public.vw_cmis_documents_and_folders_path OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 16569)
-- Dependencies: 2206 6
-- Name: vw_dm_dim_dates; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_dm_dim_dates AS
    SELECT dm_dim_dates.id, dm_dim_dates."desc" AS day, dm_dim_dates.day_desc, dm_dim_dates.month_id, dm_dim_months."desc" AS month, dm_dim_months.month_desc, dm_dim_months.year_id, dm_dim_years."desc" AS year FROM dm_dim_dates, dm_dim_months, dm_dim_years WHERE ((dm_dim_dates.month_id = dm_dim_months.id) AND (dm_dim_months.year_id = dm_dim_years.id));


ALTER TABLE public.vw_dm_dim_dates OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16573)
-- Dependencies: 2207 6
-- Name: vw_dm_dim_documents; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_dm_dim_documents AS
    SELECT dm_dim_documents.id, dm_dim_documents.name, dm_dim_documents.path, dm_dim_documents.alfresco_id, dm_dim_documents.src_id FROM dm_dim_documents;


ALTER TABLE public.vw_dm_dim_documents OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16577)
-- Dependencies: 2208 6
-- Name: vw_dm_dim_flag_immutable; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_dm_dim_flag_immutable AS
    SELECT DISTINCT dm_dim_documents.is_immutable FROM dm_dim_documents;


ALTER TABLE public.vw_dm_dim_flag_immutable OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16581)
-- Dependencies: 2209 6
-- Name: vw_dm_dim_flag_latest_major_version; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_dm_dim_flag_latest_major_version AS
    SELECT DISTINCT dm_dim_documents.is_latest_major_version FROM dm_dim_documents;


ALTER TABLE public.vw_dm_dim_flag_latest_major_version OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16585)
-- Dependencies: 2210 6
-- Name: vw_dm_dim_flag_latest_version; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_dm_dim_flag_latest_version AS
    SELECT DISTINCT dm_dim_documents.is_latest_version FROM dm_dim_documents;


ALTER TABLE public.vw_dm_dim_flag_latest_version OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16589)
-- Dependencies: 2211 6
-- Name: vw_dm_dim_flag_major_version; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_dm_dim_flag_major_version AS
    SELECT DISTINCT dm_dim_documents.is_major_version FROM dm_dim_documents;


ALTER TABLE public.vw_dm_dim_flag_major_version OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16593)
-- Dependencies: 2212 6
-- Name: vw_dm_dim_minutes; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_dm_dim_minutes AS
    SELECT dm_dim_minutes.id, dm_dim_minutes."desc" AS minute, dm_dim_minutes.hour_id, dm_dim_hours."desc" AS hour FROM dm_dim_minutes, dm_dim_hours WHERE (dm_dim_minutes.hour_id = dm_dim_hours.id);


ALTER TABLE public.vw_dm_dim_minutes OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16597)
-- Dependencies: 2213 6
-- Name: vw_dm_fact_documents; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_dm_fact_documents AS
    SELECT dm_dim_documents.id, dm_dim_documents.id AS document_id, dm_dim_documents.node_type_id, dm_dim_documents.mime_type_id, dm_dim_documents.user_creator_id, dm_dim_documents.creation_date_id, dm_dim_documents.creation_minute_id, dm_dim_documents.user_last_modifier_id, dm_dim_documents.last_modification_date_id, dm_dim_documents.last_modification_minute_id, dm_dim_documents.is_latest_version, dm_dim_documents.is_major_version, dm_dim_documents.is_latest_major_version, dm_dim_documents.is_immutable, dm_dim_documents.parent_id, dm_dim_documents.content_stream_length, 1 AS number FROM dm_dim_documents;


ALTER TABLE public.vw_dm_fact_documents OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16601)
-- Dependencies: 2214 6
-- Name: vw_dm_min_date; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_dm_min_date AS
    SELECT t.alfresco_id, min(t.date) AS min_date FROM ((SELECT ope_audit.alfresco_id, min(ope_audit.date) AS date FROM ope_audits ope_audit GROUP BY ope_audit.alfresco_id UNION ALL SELECT stg_cmis_folder.alfresco_id, min(stg_cmis_folder.cmis_creationdate) AS date FROM stg_cmis_folders stg_cmis_folder GROUP BY stg_cmis_folder.alfresco_id) UNION ALL SELECT stg_cmis_document.alfresco_id, min(stg_cmis_document.cmis_creationdate) AS date FROM stg_cmis_documents stg_cmis_document GROUP BY stg_cmis_document.alfresco_id) t GROUP BY t.alfresco_id;


ALTER TABLE public.vw_dm_min_date OWNER TO postgres;

--
-- TOC entry 2251 (class 0 OID 17255)
-- Dependencies: 207 2252
-- Data for Name: dm_custom_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2216 (class 0 OID 16388)
-- Dependencies: 162 2252
-- Data for Name: dm_dim_actions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2217 (class 0 OID 16392)
-- Dependencies: 163 2252
-- Data for Name: dm_dim_alfresco; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO dm_dim_alfresco (id, "desc", login, password, url, url_audit_suffix, url_cmis_suffix, is_active) VALUES (1, 'Default Alfresco instance', 'admin', 'admin', 'http://192.168.1.7:8080', '/alfresco/service/api/audit/query/alfresco-access?verbose=true&limit=50000', '/alfresco/cmisatom', 'Y');


--
-- TOC entry 2218 (class 0 OID 16399)
-- Dependencies: 164 2252
-- Data for Name: dm_dim_dates; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2220 (class 0 OID 16404)
-- Dependencies: 166 2252
-- Data for Name: dm_dim_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2222 (class 0 OID 16413)
-- Dependencies: 168 2252
-- Data for Name: dm_dim_folders; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2223 (class 0 OID 16420)
-- Dependencies: 169 2252
-- Data for Name: dm_dim_hours; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2225 (class 0 OID 16425)
-- Dependencies: 171 2252
-- Data for Name: dm_dim_mime_types; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2226 (class 0 OID 16432)
-- Dependencies: 172 2252
-- Data for Name: dm_dim_minutes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2227 (class 0 OID 16435)
-- Dependencies: 173 2252
-- Data for Name: dm_dim_months; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2229 (class 0 OID 16440)
-- Dependencies: 175 2252
-- Data for Name: dm_dim_node_types; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2231 (class 0 OID 16449)
-- Dependencies: 177 2252
-- Data for Name: dm_dim_paths; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2233 (class 0 OID 16458)
-- Dependencies: 179 2252
-- Data for Name: dm_dim_users; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2234 (class 0 OID 16465)
-- Dependencies: 180 2252
-- Data for Name: dm_dim_years; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2235 (class 0 OID 16471)
-- Dependencies: 181 2252
-- Data for Name: dm_fact_actions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2236 (class 0 OID 16474)
-- Dependencies: 182 2252
-- Data for Name: dm_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (5, 'http://localhost:8080:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'audit_use.prpt', 'audit_use.pdf', '192.168.1.7', 121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (6, 'http://localhost:8080:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'document_active_users.prpt', 'document_active_users.pdf', '192.168.1.7', 121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (7, 'http://localhost:8080:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'document_hours_of_activity.prpt', 'document_hours_of_activity.pdf', '192.168.1.7', 121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (8, 'http://localhost:8080:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'document_mime_types.prpt', 'document_mime_types.pdf', '192.168.1.7', 121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (9, 'http://localhost:8080:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'document_size.prpt', 'document_size.pdf', '192.168.1.7', 121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (10, 'http://localhost:8080:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'document_types.prpt', 'document_types.pdf', '192.168.1.7', 121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (11, 'http://localhost:8080:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'folder_types.prpt', 'folder_types.pdf', '192.168.1.7', 121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (1, 'http://localhost:8080:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'audit_creation.prpt', 'audit_creation.pdf', '192.168.1.7', 121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (2, 'http://localhost:8080:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'audit_details.prpt', 'audit_details.pdf', '192.168.1.7', 121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (3, 'http://localhost:8080:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'audit_login.prpt', 'audit_login.pdf', '192.168.1.7', 121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO dm_reports (id, pentaho_url, pentaho_login, pentaho_password, pentaho_path, prpt_name, name, alfresco_ftp, alfresco_port, alfresco_login, alfresco_password, alfresco_path, is_active) VALUES (4, 'http://localhost:8080:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'audit_topTen.prpt', 'audit_topTen.pdf', '192.168.1.7', 121, 'admin', 'admin', 'alfresco', 'Y');


--
-- TOC entry 2237 (class 0 OID 16486)
-- Dependencies: 183 2252
-- Data for Name: log_channels; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2238 (class 0 OID 16492)
-- Dependencies: 184 2252
-- Data for Name: log_job; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2239 (class 0 OID 16498)
-- Dependencies: 185 2252
-- Data for Name: log_jobentry; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2240 (class 0 OID 16504)
-- Dependencies: 186 2252
-- Data for Name: log_performance; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2241 (class 0 OID 16510)
-- Dependencies: 187 2252
-- Data for Name: log_step; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2242 (class 0 OID 16516)
-- Dependencies: 188 2252
-- Data for Name: log_transformations; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2243 (class 0 OID 16522)
-- Dependencies: 189 2252
-- Data for Name: ope_audits; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2244 (class 0 OID 16528)
-- Dependencies: 190 2252
-- Data for Name: ope_cmis_document_parent; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2260 (class 0 OID 0)
-- Dependencies: 206
-- Name: seq_dm_custom_metadata_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_dm_custom_metadata_id', 1, false);


--
-- TOC entry 2261 (class 0 OID 0)
-- Dependencies: 161
-- Name: seq_dm_dim_actions_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_dm_dim_actions_id', 1, true);


--
-- TOC entry 2262 (class 0 OID 0)
-- Dependencies: 165
-- Name: seq_dm_dim_documents_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_dm_dim_documents_id', 1, true);


--
-- TOC entry 2263 (class 0 OID 0)
-- Dependencies: 167
-- Name: seq_dm_dim_folders_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_dm_dim_folders_id', 8837, true);


--
-- TOC entry 2264 (class 0 OID 0)
-- Dependencies: 170
-- Name: seq_dm_dim_mime_types_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_dm_dim_mime_types_id', 1, true);


--
-- TOC entry 2265 (class 0 OID 0)
-- Dependencies: 174
-- Name: seq_dm_dim_node_types_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_dm_dim_node_types_id', 1, true);


--
-- TOC entry 2266 (class 0 OID 0)
-- Dependencies: 176
-- Name: seq_dm_dim_paths_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_dm_dim_paths_id', 1, true);


--
-- TOC entry 2267 (class 0 OID 0)
-- Dependencies: 178
-- Name: seq_dm_dim_users_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_dm_dim_users_id', 1, true);


--
-- TOC entry 2245 (class 0 OID 16534)
-- Dependencies: 191 2252
-- Data for Name: stg_audits; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2246 (class 0 OID 16540)
-- Dependencies: 192 2252
-- Data for Name: stg_cmis_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2247 (class 0 OID 16546)
-- Dependencies: 193 2252
-- Data for Name: stg_cmis_documents_partial; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2248 (class 0 OID 16552)
-- Dependencies: 194 2252
-- Data for Name: stg_cmis_folders; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2249 (class 0 OID 16558)
-- Dependencies: 195 2252
-- Data for Name: stg_cmis_folders_partial; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2063 (class 2606 OID 17264)
-- Dependencies: 207 207 2253
-- Name: pk_dm_custom_metadata; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_custom_metadata
    ADD CONSTRAINT pk_dm_custom_metadata PRIMARY KEY (id);


--
-- TOC entry 1996 (class 2606 OID 16606)
-- Dependencies: 162 162 2253
-- Name: pk_dm_dim_action; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_actions
    ADD CONSTRAINT pk_dm_dim_action PRIMARY KEY (id);


--
-- TOC entry 2002 (class 2606 OID 16608)
-- Dependencies: 164 164 2253
-- Name: pk_dm_dim_dates; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_dates
    ADD CONSTRAINT pk_dm_dim_dates PRIMARY KEY (id);


--
-- TOC entry 2006 (class 2606 OID 16610)
-- Dependencies: 166 166 2253
-- Name: pk_dm_dim_documents; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT pk_dm_dim_documents PRIMARY KEY (id);


--
-- TOC entry 2012 (class 2606 OID 16612)
-- Dependencies: 168 168 2253
-- Name: pk_dm_dim_folders; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT pk_dm_dim_folders PRIMARY KEY (id);


--
-- TOC entry 2017 (class 2606 OID 16614)
-- Dependencies: 169 169 2253
-- Name: pk_dm_dim_hours; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_hours
    ADD CONSTRAINT pk_dm_dim_hours PRIMARY KEY (id);


--
-- TOC entry 2020 (class 2606 OID 16616)
-- Dependencies: 171 171 2253
-- Name: pk_dm_dim_mime_types; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_mime_types
    ADD CONSTRAINT pk_dm_dim_mime_types PRIMARY KEY (id);


--
-- TOC entry 2023 (class 2606 OID 16618)
-- Dependencies: 172 172 2253
-- Name: pk_dm_dim_minutes; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_minutes
    ADD CONSTRAINT pk_dm_dim_minutes PRIMARY KEY (id);


--
-- TOC entry 2026 (class 2606 OID 16620)
-- Dependencies: 173 173 2253
-- Name: pk_dm_dim_months; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_months
    ADD CONSTRAINT pk_dm_dim_months PRIMARY KEY (id);


--
-- TOC entry 2029 (class 2606 OID 16622)
-- Dependencies: 175 175 2253
-- Name: pk_dm_dim_node_types; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_node_types
    ADD CONSTRAINT pk_dm_dim_node_types PRIMARY KEY (id);


--
-- TOC entry 2032 (class 2606 OID 16624)
-- Dependencies: 177 177 2253
-- Name: pk_dm_dim_path; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_paths
    ADD CONSTRAINT pk_dm_dim_path PRIMARY KEY (id);


--
-- TOC entry 2035 (class 2606 OID 16626)
-- Dependencies: 179 179 2253
-- Name: pk_dm_dim_users; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_users
    ADD CONSTRAINT pk_dm_dim_users PRIMARY KEY (id);


--
-- TOC entry 2038 (class 2606 OID 16628)
-- Dependencies: 180 180 2253
-- Name: pk_dm_dim_years; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_years
    ADD CONSTRAINT pk_dm_dim_years PRIMARY KEY (id);


--
-- TOC entry 2046 (class 2606 OID 16630)
-- Dependencies: 190 190 190 190 2253
-- Name: pk_ope_cmis_document_parent; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ope_cmis_document_parent
    ADD CONSTRAINT pk_ope_cmis_document_parent PRIMARY KEY (alfresco_id, cmis_objectid, cmis_parentid);


--
-- TOC entry 2040 (class 2606 OID 16632)
-- Dependencies: 182 182 2253
-- Name: pk_reports; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_reports
    ADD CONSTRAINT pk_reports PRIMARY KEY (id);


--
-- TOC entry 1999 (class 2606 OID 16634)
-- Dependencies: 163 163 2253
-- Name: pk_stg_alfresco; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_alfresco
    ADD CONSTRAINT pk_stg_alfresco PRIMARY KEY (id);


--
-- TOC entry 2048 (class 2606 OID 16636)
-- Dependencies: 191 191 191 191 2253
-- Name: pk_stg_audit; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stg_audits
    ADD CONSTRAINT pk_stg_audit PRIMARY KEY (alfresco_id, id, application);


--
-- TOC entry 2044 (class 2606 OID 16638)
-- Dependencies: 189 189 189 189 2253
-- Name: pk_stg_audit_extended; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ope_audits
    ADD CONSTRAINT pk_stg_audit_extended PRIMARY KEY (alfresco_id, id, application);


--
-- TOC entry 2051 (class 2606 OID 16640)
-- Dependencies: 192 192 192 2253
-- Name: uni_cmis_document; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stg_cmis_documents
    ADD CONSTRAINT uni_cmis_document UNIQUE (alfresco_id, cmis_objectid);


--
-- TOC entry 2054 (class 2606 OID 16642)
-- Dependencies: 193 193 193 2253
-- Name: uni_cmis_document_partial; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stg_cmis_documents_partial
    ADD CONSTRAINT uni_cmis_document_partial UNIQUE (alfresco_id, cmis_objectid);


--
-- TOC entry 2057 (class 2606 OID 16644)
-- Dependencies: 194 194 194 2253
-- Name: uni_cmis_folder_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stg_cmis_folders
    ADD CONSTRAINT uni_cmis_folder_id UNIQUE (alfresco_id, cmis_objectid);


--
-- TOC entry 2060 (class 2606 OID 16646)
-- Dependencies: 195 195 195 2253
-- Name: uni_cmis_folder_partial__id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stg_cmis_folders_partial
    ADD CONSTRAINT uni_cmis_folder_partial__id UNIQUE (alfresco_id, cmis_objectid);


--
-- TOC entry 2008 (class 2606 OID 16648)
-- Dependencies: 166 166 166 2253
-- Name: unq_dm_dim_documents; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT unq_dm_dim_documents UNIQUE (alfresco_id, src_id);


--
-- TOC entry 2014 (class 2606 OID 16650)
-- Dependencies: 168 168 168 2253
-- Name: unq_dm_dim_folders; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT unq_dm_dim_folders UNIQUE (alfresco_id, src_id);


--
-- TOC entry 2061 (class 1259 OID 17270)
-- Dependencies: 207 2253
-- Name: idx_dm_custom_metadata; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_custom_metadata ON dm_custom_metadata USING btree (id);


--
-- TOC entry 1994 (class 1259 OID 16651)
-- Dependencies: 162 2253
-- Name: idx_dm_dim_actions; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_actions ON dm_dim_actions USING btree (id);


--
-- TOC entry 1997 (class 1259 OID 16652)
-- Dependencies: 163 2253
-- Name: idx_dm_dim_alfresco; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_alfresco ON dm_dim_alfresco USING btree (id);


--
-- TOC entry 2000 (class 1259 OID 16653)
-- Dependencies: 164 2253
-- Name: idx_dm_dim_dates; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_dates ON dm_dim_dates USING btree (id);


--
-- TOC entry 2003 (class 1259 OID 16654)
-- Dependencies: 166 2253
-- Name: idx_dm_dim_documents; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_documents ON dm_dim_documents USING btree (id);


--
-- TOC entry 2004 (class 1259 OID 16655)
-- Dependencies: 166 166 2253
-- Name: idx_dm_dim_documents_src_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_documents_src_id ON dm_dim_documents USING btree (alfresco_id, src_id);


--
-- TOC entry 2009 (class 1259 OID 16656)
-- Dependencies: 168 2253
-- Name: idx_dm_dim_folders; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_folders ON dm_dim_folders USING btree (id);


--
-- TOC entry 2010 (class 1259 OID 16657)
-- Dependencies: 168 168 2253
-- Name: idx_dm_dim_folders_src_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_folders_src_id ON dm_dim_folders USING btree (alfresco_id, src_id);


--
-- TOC entry 2015 (class 1259 OID 16658)
-- Dependencies: 169 2253
-- Name: idx_dm_dim_hours; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_hours ON dm_dim_hours USING btree (id);


--
-- TOC entry 2018 (class 1259 OID 16659)
-- Dependencies: 171 2253
-- Name: idx_dm_dim_mime_types; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_mime_types ON dm_dim_mime_types USING btree (id);


--
-- TOC entry 2021 (class 1259 OID 16660)
-- Dependencies: 172 2253
-- Name: idx_dm_dim_minutes; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_minutes ON dm_dim_minutes USING btree (id);


--
-- TOC entry 2024 (class 1259 OID 16661)
-- Dependencies: 173 2253
-- Name: idx_dm_dim_months; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_months ON dm_dim_months USING btree (id);


--
-- TOC entry 2027 (class 1259 OID 16662)
-- Dependencies: 175 2253
-- Name: idx_dm_dim_node_types; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_node_types ON dm_dim_node_types USING btree (id);


--
-- TOC entry 2030 (class 1259 OID 16663)
-- Dependencies: 177 2253
-- Name: idx_dm_dim_paths; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_paths ON dm_dim_paths USING btree (id);


--
-- TOC entry 2033 (class 1259 OID 16664)
-- Dependencies: 179 2253
-- Name: idx_dm_dim_users; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_users ON dm_dim_users USING btree (id);


--
-- TOC entry 2036 (class 1259 OID 16665)
-- Dependencies: 180 2253
-- Name: idx_dm_dim_years; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dm_dim_years ON dm_dim_years USING btree (id);


--
-- TOC entry 2041 (class 1259 OID 16666)
-- Dependencies: 188 2253
-- Name: idx_log_transformations_1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_log_transformations_1 ON log_transformations USING btree (id_batch);


--
-- TOC entry 2042 (class 1259 OID 16667)
-- Dependencies: 188 188 188 2253
-- Name: idx_log_transformations_2; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_log_transformations_2 ON log_transformations USING btree (errors, status, transname);


--
-- TOC entry 2049 (class 1259 OID 16668)
-- Dependencies: 192 192 192 2253
-- Name: idx_stg_cmis_documents_key; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_stg_cmis_documents_key ON stg_cmis_documents USING btree (alfresco_id, cmis_lastmodificationdate, cmis_name);


--
-- TOC entry 2052 (class 1259 OID 16669)
-- Dependencies: 193 193 193 2253
-- Name: idx_stg_cmis_documents_partial_key; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_stg_cmis_documents_partial_key ON stg_cmis_documents_partial USING btree (alfresco_id, cmis_contentstreamlength, cmis_name);


--
-- TOC entry 2055 (class 1259 OID 16670)
-- Dependencies: 194 194 194 2253
-- Name: idx_stg_cmis_folders_key; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_stg_cmis_folders_key ON stg_cmis_folders USING btree (alfresco_id, cmis_lastmodificationdate, cmis_name);


--
-- TOC entry 2058 (class 1259 OID 16671)
-- Dependencies: 195 195 195 2253
-- Name: idx_stg_cmis_folders_partial_key; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_stg_cmis_folders_partial_key ON stg_cmis_folders_partial USING btree (alfresco_id, cmis_lastmodificationdate, cmis_name);


--
-- TOC entry 2100 (class 2606 OID 16672)
-- Dependencies: 190 190 192 192 2050 2253
-- Name: fk_cmis_document_parent_document; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ope_cmis_document_parent
    ADD CONSTRAINT fk_cmis_document_parent_document FOREIGN KEY (alfresco_id, cmis_objectid) REFERENCES stg_cmis_documents(alfresco_id, cmis_objectid);


--
-- TOC entry 2101 (class 2606 OID 16677)
-- Dependencies: 190 190 194 194 2056 2253
-- Name: fk_cmis_document_parent_parent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ope_cmis_document_parent
    ADD CONSTRAINT fk_cmis_document_parent_parent FOREIGN KEY (alfresco_id, cmis_parentid) REFERENCES stg_cmis_folders(alfresco_id, cmis_objectid);


--
-- TOC entry 2103 (class 2606 OID 17265)
-- Dependencies: 207 1998 163 2253
-- Name: fk_dm_custom_metadata_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_custom_metadata
    ADD CONSTRAINT fk_dm_custom_metadata_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2064 (class 2606 OID 16682)
-- Dependencies: 162 163 1998 2253
-- Name: fk_dm_dim_action_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_actions
    ADD CONSTRAINT fk_dm_dim_action_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2065 (class 2606 OID 16687)
-- Dependencies: 164 173 2025 2253
-- Name: fk_dm_dim_dates_dm_dim_months; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_dates
    ADD CONSTRAINT fk_dm_dim_dates_dm_dim_months FOREIGN KEY (month_id) REFERENCES dm_dim_months(id);


--
-- TOC entry 2066 (class 2606 OID 16692)
-- Dependencies: 166 1998 163 2253
-- Name: fk_dm_dim_documents_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT fk_dm_dim_documents_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2067 (class 2606 OID 16697)
-- Dependencies: 164 2001 166 2253
-- Name: fk_dm_dim_documents_dm_dim_dates_creation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT fk_dm_dim_documents_dm_dim_dates_creation FOREIGN KEY (creation_date_id) REFERENCES dm_dim_dates(id);


--
-- TOC entry 2068 (class 2606 OID 16702)
-- Dependencies: 166 164 2001 2253
-- Name: fk_dm_dim_documents_dm_dim_dates_last_modification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT fk_dm_dim_documents_dm_dim_dates_last_modification FOREIGN KEY (last_modification_date_id) REFERENCES dm_dim_dates(id);


--
-- TOC entry 2069 (class 2606 OID 16707)
-- Dependencies: 166 2011 168 2253
-- Name: fk_dm_dim_documents_dm_dim_folders_parent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT fk_dm_dim_documents_dm_dim_folders_parent FOREIGN KEY (parent_id) REFERENCES dm_dim_folders(id);


--
-- TOC entry 2070 (class 2606 OID 16712)
-- Dependencies: 166 2019 171 2253
-- Name: fk_dm_dim_documents_dm_dim_mime_types; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT fk_dm_dim_documents_dm_dim_mime_types FOREIGN KEY (mime_type_id) REFERENCES dm_dim_mime_types(id);


--
-- TOC entry 2071 (class 2606 OID 16717)
-- Dependencies: 166 2022 172 2253
-- Name: fk_dm_dim_documents_dm_dim_minutes_creation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT fk_dm_dim_documents_dm_dim_minutes_creation FOREIGN KEY (creation_minute_id) REFERENCES dm_dim_minutes(id);


--
-- TOC entry 2072 (class 2606 OID 16722)
-- Dependencies: 166 2022 172 2253
-- Name: fk_dm_dim_documents_dm_dim_minutes_last_modification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT fk_dm_dim_documents_dm_dim_minutes_last_modification FOREIGN KEY (last_modification_minute_id) REFERENCES dm_dim_minutes(id);


--
-- TOC entry 2073 (class 2606 OID 16727)
-- Dependencies: 2028 175 166 2253
-- Name: fk_dm_dim_documents_dm_dim_node_types; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT fk_dm_dim_documents_dm_dim_node_types FOREIGN KEY (node_type_id) REFERENCES dm_dim_node_types(id);


--
-- TOC entry 2074 (class 2606 OID 16732)
-- Dependencies: 179 2034 166 2253
-- Name: fk_dm_dim_documents_dm_dim_users_creator; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT fk_dm_dim_documents_dm_dim_users_creator FOREIGN KEY (user_creator_id) REFERENCES dm_dim_users(id);


--
-- TOC entry 2075 (class 2606 OID 16737)
-- Dependencies: 179 2034 166 2253
-- Name: fk_dm_dim_documents_dm_dim_users_last_modifier; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_documents
    ADD CONSTRAINT fk_dm_dim_documents_dm_dim_users_last_modifier FOREIGN KEY (user_last_modifier_id) REFERENCES dm_dim_users(id);


--
-- TOC entry 2076 (class 2606 OID 16742)
-- Dependencies: 1998 163 168 2253
-- Name: fk_dm_dim_folders_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT fk_dm_dim_folders_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2077 (class 2606 OID 16747)
-- Dependencies: 168 164 2001 2253
-- Name: fk_dm_dim_folders_dm_dim_dates_creation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT fk_dm_dim_folders_dm_dim_dates_creation FOREIGN KEY (creation_date_id) REFERENCES dm_dim_dates(id);


--
-- TOC entry 2078 (class 2606 OID 16752)
-- Dependencies: 2001 168 164 2253
-- Name: fk_dm_dim_folders_dm_dim_dates_last_modification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT fk_dm_dim_folders_dm_dim_dates_last_modification FOREIGN KEY (last_modification_date_id) REFERENCES dm_dim_dates(id);


--
-- TOC entry 2079 (class 2606 OID 16757)
-- Dependencies: 168 2011 168 2253
-- Name: fk_dm_dim_folders_dm_dim_folders_aprent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT fk_dm_dim_folders_dm_dim_folders_aprent FOREIGN KEY (parent_id) REFERENCES dm_dim_folders(id);


--
-- TOC entry 2080 (class 2606 OID 16762)
-- Dependencies: 168 172 2022 2253
-- Name: fk_dm_dim_folders_dm_dim_minutes_creation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT fk_dm_dim_folders_dm_dim_minutes_creation FOREIGN KEY (creation_minute_id) REFERENCES dm_dim_minutes(id);


--
-- TOC entry 2081 (class 2606 OID 16767)
-- Dependencies: 168 172 2022 2253
-- Name: fk_dm_dim_folders_dm_dim_minutes_last_modification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT fk_dm_dim_folders_dm_dim_minutes_last_modification FOREIGN KEY (last_modification_minute_id) REFERENCES dm_dim_minutes(id);


--
-- TOC entry 2082 (class 2606 OID 16772)
-- Dependencies: 168 175 2028 2253
-- Name: fk_dm_dim_folders_dm_dim_node_types; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT fk_dm_dim_folders_dm_dim_node_types FOREIGN KEY (node_type_id) REFERENCES dm_dim_node_types(id);


--
-- TOC entry 2083 (class 2606 OID 16777)
-- Dependencies: 168 179 2034 2253
-- Name: fk_dm_dim_folders_dm_dim_users_creator; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT fk_dm_dim_folders_dm_dim_users_creator FOREIGN KEY (user_creator_id) REFERENCES dm_dim_users(id);


--
-- TOC entry 2084 (class 2606 OID 16782)
-- Dependencies: 168 179 2034 2253
-- Name: fk_dm_dim_folders_dm_dim_users_last_modifier; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_folders
    ADD CONSTRAINT fk_dm_dim_folders_dm_dim_users_last_modifier FOREIGN KEY (user_last_modifier_id) REFERENCES dm_dim_users(id);


--
-- TOC entry 2085 (class 2606 OID 16787)
-- Dependencies: 171 163 1998 2253
-- Name: fk_dm_dim_mime_types_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_mime_types
    ADD CONSTRAINT fk_dm_dim_mime_types_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2086 (class 2606 OID 16792)
-- Dependencies: 2016 169 172 2253
-- Name: fk_dm_dim_minutes_dm_dim_hours; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_minutes
    ADD CONSTRAINT fk_dm_dim_minutes_dm_dim_hours FOREIGN KEY (hour_id) REFERENCES dm_dim_hours(id);


--
-- TOC entry 2087 (class 2606 OID 16797)
-- Dependencies: 180 173 2037 2253
-- Name: fk_dm_dim_months_dm_dim_years; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_months
    ADD CONSTRAINT fk_dm_dim_months_dm_dim_years FOREIGN KEY (year_id) REFERENCES dm_dim_years(id);


--
-- TOC entry 2088 (class 2606 OID 16802)
-- Dependencies: 163 1998 175 2253
-- Name: fk_dm_dim_node_types_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_node_types
    ADD CONSTRAINT fk_dm_dim_node_types_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2089 (class 2606 OID 16807)
-- Dependencies: 177 1998 163 2253
-- Name: fk_dm_dim_path_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_paths
    ADD CONSTRAINT fk_dm_dim_path_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2090 (class 2606 OID 16812)
-- Dependencies: 177 2011 168 2253
-- Name: fk_dm_dim_path_dm_dim_folders; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_paths
    ADD CONSTRAINT fk_dm_dim_path_dm_dim_folders FOREIGN KEY (folder_id) REFERENCES dm_dim_folders(id);


--
-- TOC entry 2091 (class 2606 OID 16817)
-- Dependencies: 177 2005 166 2253
-- Name: fk_dm_dim_paths_dm_dim_documents; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_paths
    ADD CONSTRAINT fk_dm_dim_paths_dm_dim_documents FOREIGN KEY (document_id) REFERENCES dm_dim_documents(id);


--
-- TOC entry 2092 (class 2606 OID 16822)
-- Dependencies: 163 1998 179 2253
-- Name: fk_dm_dim_users_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_dim_users
    ADD CONSTRAINT fk_dm_dim_users_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2093 (class 2606 OID 16827)
-- Dependencies: 181 162 1995 2253
-- Name: fk_dm_fact_actions_dm_dim_actions; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_fact_actions
    ADD CONSTRAINT fk_dm_fact_actions_dm_dim_actions FOREIGN KEY (action_id) REFERENCES dm_dim_actions(id);


--
-- TOC entry 2094 (class 2606 OID 16832)
-- Dependencies: 1998 163 181 2253
-- Name: fk_dm_fact_actions_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_fact_actions
    ADD CONSTRAINT fk_dm_fact_actions_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2095 (class 2606 OID 16837)
-- Dependencies: 181 164 2001 2253
-- Name: fk_dm_fact_actions_dm_dim_dates; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_fact_actions
    ADD CONSTRAINT fk_dm_fact_actions_dm_dim_dates FOREIGN KEY (date_id) REFERENCES dm_dim_dates(id);


--
-- TOC entry 2096 (class 2606 OID 16842)
-- Dependencies: 172 2022 181 2253
-- Name: fk_dm_fact_actions_dm_dim_minutes; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_fact_actions
    ADD CONSTRAINT fk_dm_fact_actions_dm_dim_minutes FOREIGN KEY (minute_id) REFERENCES dm_dim_minutes(id);


--
-- TOC entry 2097 (class 2606 OID 16847)
-- Dependencies: 177 2031 181 2253
-- Name: fk_dm_fact_actions_dm_dim_paths; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_fact_actions
    ADD CONSTRAINT fk_dm_fact_actions_dm_dim_paths FOREIGN KEY (path_id) REFERENCES dm_dim_paths(id);


--
-- TOC entry 2098 (class 2606 OID 16852)
-- Dependencies: 2034 181 179 2253
-- Name: fk_dm_fact_actions_dm_dim_users; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dm_fact_actions
    ADD CONSTRAINT fk_dm_fact_actions_dm_dim_users FOREIGN KEY (user_id) REFERENCES dm_dim_users(id);


--
-- TOC entry 2102 (class 2606 OID 16857)
-- Dependencies: 191 1998 163 2253
-- Name: fk_stg_audit_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY stg_audits
    ADD CONSTRAINT fk_stg_audit_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2099 (class 2606 OID 16862)
-- Dependencies: 163 189 1998 2253
-- Name: fk_stg_audit_extended_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ope_audits
    ADD CONSTRAINT fk_stg_audit_extended_dm_dim_alfresco FOREIGN KEY (alfresco_id) REFERENCES dm_dim_alfresco(id);


--
-- TOC entry 2258 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2014-05-26 23:13:35 CEST

--
-- PostgreSQL database dump complete
--

