--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.6
-- Dumped by pg_dump version 9.3.6
-- Started on 2015-04-10 15:50:16 CEST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 229 (class 3079 OID 11789)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "plpgsql" WITH SCHEMA "pg_catalog";


--
-- TOC entry 2447 (class 0 OID 0)
-- Dependencies: 229
-- Name: EXTENSION "plpgsql"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "plpgsql" IS 'PL/pgSQL procedural language';


SET search_path = "public", pg_catalog;

--
-- TOC entry 170 (class 1259 OID 19277)
-- Name: seq_dm_custom_metadata_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_custom_metadata_id"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."seq_dm_custom_metadata_id" OWNER TO "postgres";

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 171 (class 1259 OID 19279)
-- Name: dm_custom_metadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "dm_custom_metadata" (
    "id" smallint DEFAULT "nextval"('"seq_dm_custom_metadata_id"'::"regclass") NOT NULL,
    "name" character varying(255) NOT NULL,
    "is_document_type" character(1) DEFAULT 'N'::"bpchar" NOT NULL,
    "is_folder_type" character(1) DEFAULT 'N'::"bpchar" NOT NULL,
    "is_aspect" character(1) DEFAULT 'N'::"bpchar" NOT NULL,
    "is_active" character(1) DEFAULT 'Y'::"bpchar" NOT NULL,
    "alfresco_id" smallint NOT NULL
);


ALTER TABLE "public"."dm_custom_metadata" OWNER TO "postgres";

--
-- TOC entry 172 (class 1259 OID 19287)
-- Name: seq_dm_dim_actions_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_dim_actions_id"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."seq_dm_dim_actions_id" OWNER TO "postgres";

--
-- TOC entry 173 (class 1259 OID 19289)
-- Name: dm_dim_actions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "dm_dim_actions" (
    "id" smallint DEFAULT "nextval"('"seq_dm_dim_actions_id"'::"regclass") NOT NULL,
    "desc" character varying(128) NOT NULL,
    "alfresco_id" smallint NOT NULL,
    "src_action" character varying(128) NOT NULL
);


ALTER TABLE "public"."dm_dim_actions" OWNER TO "postgres";

--
-- TOC entry 174 (class 1259 OID 19293)
-- Name: dm_dim_alfresco; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "dm_dim_alfresco" (
    "id" smallint NOT NULL,
    "desc" character varying(25) NOT NULL,
    "login" character varying(100) NOT NULL,
    "password" character varying(100) NOT NULL,
    "url" character varying(1024) NOT NULL,
    "url_audit_suffix" character varying(1024) NOT NULL,
    "audit_limit" integer NOT NULL,
    "url_nodes_modified_after_suffix" character varying(128) NOT NULL,
    "url_nodes_modified_before_suffix" character varying(128) NOT NULL,
    "node_limit" integer NOT NULL,
    "url_cmis_suffix" character varying(1024) NOT NULL,
    "url_workflow_definitions_suffix" character varying(1024) NOT NULL,
    "url_workflow_instances_suffix" character varying(1024) NOT NULL,
    "is_active" character(1) DEFAULT 'Y'::"bpchar" NOT NULL
);


ALTER TABLE "public"."dm_dim_alfresco" OWNER TO "postgres";

--
-- TOC entry 175 (class 1259 OID 19300)
-- Name: dm_dim_dates; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "dm_dim_dates" (
    "id" "date" NOT NULL,
    "desc" character varying(64) NOT NULL,
    "day_desc" character varying(64) NOT NULL,
    "month_id" "date" NOT NULL
);


ALTER TABLE "public"."dm_dim_dates" OWNER TO "postgres";

--
-- TOC entry 176 (class 1259 OID 19303)
-- Name: seq_dm_dim_documents_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_dim_documents_id"
    START WITH 11
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."seq_dm_dim_documents_id" OWNER TO "postgres";

--
-- TOC entry 177 (class 1259 OID 19305)
-- Name: dm_dim_documents; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "dm_dim_documents" (
    "id" integer DEFAULT "nextval"('"seq_dm_dim_documents_id"'::"regclass") NOT NULL,
    "store-protocol" character varying(128) NOT NULL,
    "store-identifier" character varying(128) NOT NULL,
    "node-uuid" character varying(128) NOT NULL,
    "name" character varying(1024) NOT NULL,
    "path" character varying(4096) NOT NULL,
    "node_type_id" smallint NOT NULL,
    "mime_type_id" smallint NOT NULL,
    "user_creator_id" integer NOT NULL,
    "creation_date_id" "date",
    "creation_minute_id" smallint NOT NULL,
    "user_last_modifier_id" integer NOT NULL,
    "last_modification_date_id" "date" NOT NULL,
    "last_modification_minute_id" smallint NOT NULL,
    "size" integer NOT NULL,
    "parent_id" integer NOT NULL,
    "alfresco_id" smallint NOT NULL,
    "src_id" integer NOT NULL
);


ALTER TABLE "public"."dm_dim_documents" OWNER TO "postgres";

--
-- TOC entry 178 (class 1259 OID 19312)
-- Name: seq_dm_dim_folders_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_dim_folders_id"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."seq_dm_dim_folders_id" OWNER TO "postgres";

--
-- TOC entry 179 (class 1259 OID 19314)
-- Name: dm_dim_folders; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "dm_dim_folders" (
    "id" integer DEFAULT "nextval"('"seq_dm_dim_folders_id"'::"regclass") NOT NULL,
    "store-protocol" character varying(128) NOT NULL,
    "store-identifier" character varying(128) NOT NULL,
    "node-uuid" character varying(128) NOT NULL,
    "name" character varying(1024) NOT NULL,
    "path" character varying(4096) NOT NULL,
    "node_type_id" smallint NOT NULL,
    "user_creator_id" integer NOT NULL,
    "creation_date_id" "date",
    "creation_minute_id" smallint NOT NULL,
    "user_last_modifier_id" integer NOT NULL,
    "last_modification_date_id" "date" NOT NULL,
    "last_modification_minute_id" smallint NOT NULL,
    "parent_id" integer,
    "alfresco_id" smallint NOT NULL,
    "src_id" integer NOT NULL
);


ALTER TABLE "public"."dm_dim_folders" OWNER TO "postgres";

--
-- TOC entry 180 (class 1259 OID 19321)
-- Name: dm_dim_hours; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "dm_dim_hours" (
    "id" smallint NOT NULL,
    "desc" character varying(16) NOT NULL
);


ALTER TABLE "public"."dm_dim_hours" OWNER TO "postgres";

--
-- TOC entry 181 (class 1259 OID 19324)
-- Name: seq_dm_dim_mime_types_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_dim_mime_types_id"
    START WITH 11
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."seq_dm_dim_mime_types_id" OWNER TO "postgres";

--
-- TOC entry 182 (class 1259 OID 19326)
-- Name: dm_dim_mime_types; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "dm_dim_mime_types" (
    "id" smallint DEFAULT "nextval"('"seq_dm_dim_mime_types_id"'::"regclass") NOT NULL,
    "desc" character varying(512) NOT NULL,
    "alfresco_id" smallint NOT NULL,
    "src_id" character varying(512) NOT NULL
);


ALTER TABLE "public"."dm_dim_mime_types" OWNER TO "postgres";

--
-- TOC entry 183 (class 1259 OID 19333)
-- Name: dm_dim_minutes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "dm_dim_minutes" (
    "id" smallint NOT NULL,
    "desc" character varying(16) NOT NULL,
    "hour_id" smallint NOT NULL
);


ALTER TABLE "public"."dm_dim_minutes" OWNER TO "postgres";

--
-- TOC entry 184 (class 1259 OID 19336)
-- Name: dm_dim_months; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "dm_dim_months" (
    "id" "date" NOT NULL,
    "desc" character varying(64) NOT NULL,
    "month_desc" character varying(64) NOT NULL,
    "year_id" smallint NOT NULL
);


ALTER TABLE "public"."dm_dim_months" OWNER TO "postgres";

--
-- TOC entry 185 (class 1259 OID 19339)
-- Name: seq_dm_dim_node_types_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_dim_node_types_id"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."seq_dm_dim_node_types_id" OWNER TO "postgres";

--
-- TOC entry 186 (class 1259 OID 19341)
-- Name: dm_dim_node_types; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "dm_dim_node_types" (
    "id" smallint DEFAULT "nextval"('"seq_dm_dim_node_types_id"'::"regclass") NOT NULL,
    "desc" character varying(512) NOT NULL,
    "base_type" character varying(512) NOT NULL,
    "alfresco_id" smallint NOT NULL,
    "src_id" character varying(512) NOT NULL
);


ALTER TABLE "public"."dm_dim_node_types" OWNER TO "postgres";

--
-- TOC entry 187 (class 1259 OID 19348)
-- Name: seq_dm_dim_paths_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_dim_paths_id"
    START WITH 11
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."seq_dm_dim_paths_id" OWNER TO "postgres";

--
-- TOC entry 188 (class 1259 OID 19350)
-- Name: dm_dim_paths; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "dm_dim_paths" (
    "id" integer DEFAULT "nextval"('"seq_dm_dim_paths_id"'::"regclass") NOT NULL,
    "path" character varying(4096) NOT NULL,
    "folder_id" integer,
    "document_id" integer,
    "alfresco_id" smallint NOT NULL,
    "src_path" character varying(4096) NOT NULL
);


ALTER TABLE "public"."dm_dim_paths" OWNER TO "postgres";

--
-- TOC entry 189 (class 1259 OID 19357)
-- Name: seq_dm_dim_users_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_dim_users_id"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."seq_dm_dim_users_id" OWNER TO "postgres";

--
-- TOC entry 190 (class 1259 OID 19359)
-- Name: dm_dim_users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "dm_dim_users" (
    "id" integer DEFAULT "nextval"('"seq_dm_dim_users_id"'::"regclass") NOT NULL,
    "desc" character varying(512) NOT NULL,
    "alfresco_id" smallint NOT NULL,
    "src_user" character varying(512) NOT NULL
);


ALTER TABLE "public"."dm_dim_users" OWNER TO "postgres";

--
-- TOC entry 220 (class 1259 OID 27662)
-- Name: seq_dm_dim_workflow_definitions_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_dim_workflow_definitions_id"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."seq_dm_dim_workflow_definitions_id" OWNER TO "postgres";

--
-- TOC entry 224 (class 1259 OID 28688)
-- Name: dm_dim_workflow_definitions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "dm_dim_workflow_definitions" (
    "id" integer DEFAULT "nextval"('"seq_dm_dim_workflow_definitions_id"'::"regclass") NOT NULL,
    "name" character varying(1024) NOT NULL,
    "title" character varying(1024) NOT NULL,
    "desc" character varying(1024) NOT NULL,
    "version" character varying(64) NOT NULL,
    "url" character varying(1024) NOT NULL,
    "alfresco_id" smallint NOT NULL,
    "src_id" character varying(1024) NOT NULL
);


ALTER TABLE "public"."dm_dim_workflow_definitions" OWNER TO "postgres";

--
-- TOC entry 221 (class 1259 OID 27725)
-- Name: seq_dm_dim_workflow_instances_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_dim_workflow_instances_id"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."seq_dm_dim_workflow_instances_id" OWNER TO "postgres";

--
-- TOC entry 225 (class 1259 OID 28703)
-- Name: dm_dim_workflow_instances; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "dm_dim_workflow_instances" (
    "id" integer DEFAULT "nextval"('"seq_dm_dim_workflow_instances_id"'::"regclass") NOT NULL,
    "definition_id" integer NOT NULL,
    "name" character varying(1024) NOT NULL,
    "title" character varying(1024) NOT NULL,
    "desc" character varying(1024) NOT NULL,
    "is_active" character varying(16) NOT NULL,
    "initiator_id" integer NOT NULL,
    "start_date_id" "date" NOT NULL,
    "start_minute_id" smallint NOT NULL,
    "due_date_id" "date" NOT NULL,
    "due_minute_id" smallint NOT NULL,
    "end_date_id" "date" NOT NULL,
    "end_minute_id" smallint NOT NULL,
    "diagram_url" character varying(1024) NOT NULL,
    "duration" integer,
    "max_duration" integer,
    "alfresco_id" smallint NOT NULL,
    "src_id" character varying(1024) NOT NULL
);


ALTER TABLE "public"."dm_dim_workflow_instances" OWNER TO "postgres";

--
-- TOC entry 228 (class 1259 OID 29100)
-- Name: dm_dim_workflow_items; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "dm_dim_workflow_items" (
    "workflow_instance_id" integer NOT NULL,
    "document_id" integer NOT NULL,
    "ordinal" smallint NOT NULL,
    "alfresco_id" smallint NOT NULL
);


ALTER TABLE "public"."dm_dim_workflow_items" OWNER TO "postgres";

--
-- TOC entry 222 (class 1259 OID 27727)
-- Name: seq_dm_dim_workflow_tasks_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_dim_workflow_tasks_id"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."seq_dm_dim_workflow_tasks_id" OWNER TO "postgres";

--
-- TOC entry 226 (class 1259 OID 28848)
-- Name: dm_dim_workflow_tasks; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "dm_dim_workflow_tasks" (
    "id" integer DEFAULT "nextval"('"seq_dm_dim_workflow_tasks_id"'::"regclass") NOT NULL,
    "instance_id" integer NOT NULL,
    "name" character varying(1024) NOT NULL,
    "title" character varying(1024) NOT NULL,
    "desc" character varying(1024) NOT NULL,
    "state" character varying(64) NOT NULL,
    "status" character varying(64) NOT NULL,
    "owner_id" integer NOT NULL,
    "is_pooled" character varying(16) NOT NULL,
    "is_editable" character varying(16) NOT NULL,
    "is_reassignable" character varying(16) NOT NULL,
    "is_claimable" character varying(16) NOT NULL,
    "outcome" character varying(128) NOT NULL,
    "start_date_id" "date" NOT NULL,
    "start_minute_id" smallint NOT NULL,
    "due_date_id" "date" NOT NULL,
    "due_minute_id" smallint NOT NULL,
    "completion_date_id" "date" NOT NULL,
    "completion_minute_id" smallint NOT NULL,
    "duration" integer NOT NULL,
    "max_duration" integer NOT NULL,
    "ordinal" smallint NOT NULL,
    "alfresco_id" smallint NOT NULL,
    "src_id" character varying(1024) NOT NULL
);


ALTER TABLE "public"."dm_dim_workflow_tasks" OWNER TO "postgres";

--
-- TOC entry 191 (class 1259 OID 19366)
-- Name: dm_dim_years; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "dm_dim_years" (
    "id" smallint NOT NULL,
    "desc" character varying NOT NULL
);


ALTER TABLE "public"."dm_dim_years" OWNER TO "postgres";

--
-- TOC entry 192 (class 1259 OID 19372)
-- Name: dm_fact_actions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "dm_fact_actions" (
    "alfresco_id" smallint NOT NULL,
    "user_id" integer NOT NULL,
    "date_id" "date" NOT NULL,
    "minute_id" smallint NOT NULL,
    "action_id" smallint NOT NULL,
    "path_id" integer NOT NULL,
    "num" smallint NOT NULL,
    "src_id" bigint NOT NULL
);


ALTER TABLE "public"."dm_fact_actions" OWNER TO "postgres";

--
-- TOC entry 193 (class 1259 OID 19375)
-- Name: dm_reports; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "dm_reports" (
    "id" smallint NOT NULL,
    "pentaho_url" character varying(1024) NOT NULL,
    "pentaho_login" character varying(1024) NOT NULL,
    "pentaho_password" character varying(1024) NOT NULL,
    "pentaho_path" character varying(1024) NOT NULL,
    "prpt_name" character varying(1024) NOT NULL,
    "name" character varying DEFAULT 1024 NOT NULL,
    "alfresco_ftp" character varying DEFAULT 1024 NOT NULL,
    "alfresco_port" integer NOT NULL,
    "alfresco_login" character varying DEFAULT 100 NOT NULL,
    "alfresco_password" character varying DEFAULT 100 NOT NULL,
    "alfresco_path" character varying DEFAULT 1024 NOT NULL,
    "is_active" character(1) DEFAULT 'Y'::"bpchar" NOT NULL
);


ALTER TABLE "public"."dm_reports" OWNER TO "postgres";

--
-- TOC entry 194 (class 1259 OID 19387)
-- Name: log_channels; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "log_channels" (
    "id_batch" integer,
    "channel_id" character varying(255),
    "log_date" timestamp without time zone,
    "logging_object_type" character varying(255),
    "object_name" character varying(255),
    "object_copy" character varying(255),
    "repository_directory" character varying(255),
    "filename" character varying(255),
    "object_id" character varying(255),
    "object_revision" character varying(255),
    "parent_channel_id" character varying(255),
    "root_channel_id" character varying(255)
);


ALTER TABLE "public"."log_channels" OWNER TO "postgres";

--
-- TOC entry 195 (class 1259 OID 19393)
-- Name: log_job; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "log_job" (
    "id_job" integer,
    "channel_id" character varying(255),
    "jobname" character varying(255),
    "status" character varying(15),
    "lines_read" bigint,
    "lines_written" bigint,
    "lines_updated" bigint,
    "lines_input" bigint,
    "lines_output" bigint,
    "lines_rejected" bigint,
    "errors" bigint,
    "startdate" timestamp without time zone,
    "enddate" timestamp without time zone,
    "logdate" timestamp without time zone,
    "depdate" timestamp without time zone,
    "replaydate" timestamp without time zone,
    "log_field" "text"
);


ALTER TABLE "public"."log_job" OWNER TO "postgres";

--
-- TOC entry 196 (class 1259 OID 19399)
-- Name: log_jobentry; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "log_jobentry" (
    "id_batch" integer,
    "channel_id" character varying(255),
    "log_date" timestamp without time zone,
    "transname" character varying(255),
    "stepname" character varying(255),
    "lines_read" bigint,
    "lines_written" bigint,
    "lines_updated" bigint,
    "lines_input" bigint,
    "lines_output" bigint,
    "lines_rejected" bigint,
    "errors" bigint,
    "result" character(1),
    "nr_result_rows" bigint,
    "nr_result_files" bigint
);


ALTER TABLE "public"."log_jobentry" OWNER TO "postgres";

--
-- TOC entry 197 (class 1259 OID 19405)
-- Name: log_performance; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "log_performance" (
    "id_batch" integer,
    "seq_nr" integer,
    "logdate" timestamp without time zone,
    "transname" character varying(255),
    "stepname" character varying(255),
    "step_copy" integer,
    "lines_read" bigint,
    "lines_written" bigint,
    "lines_updated" bigint,
    "lines_input" bigint,
    "lines_output" bigint,
    "lines_rejected" bigint,
    "errors" bigint,
    "input_buffer_rows" bigint,
    "output_buffer_rows" bigint
);


ALTER TABLE "public"."log_performance" OWNER TO "postgres";

--
-- TOC entry 198 (class 1259 OID 19411)
-- Name: log_step; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "log_step" (
    "id_batch" integer,
    "channel_id" character varying(255),
    "log_date" timestamp without time zone,
    "transname" character varying(255),
    "stepname" character varying(255),
    "step_copy" smallint,
    "lines_read" bigint,
    "lines_written" bigint,
    "lines_updated" bigint,
    "lines_input" bigint,
    "lines_output" bigint,
    "lines_rejected" bigint,
    "errors" bigint
);


ALTER TABLE "public"."log_step" OWNER TO "postgres";

--
-- TOC entry 199 (class 1259 OID 19417)
-- Name: log_transformations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "log_transformations" (
    "id_batch" integer,
    "channel_id" character varying(255),
    "transname" character varying(255),
    "status" character varying(15),
    "lines_read" bigint,
    "lines_written" bigint,
    "lines_updated" bigint,
    "lines_input" bigint,
    "lines_output" bigint,
    "lines_rejected" bigint,
    "errors" bigint,
    "startdate" timestamp without time zone,
    "enddate" timestamp without time zone,
    "logdate" timestamp without time zone,
    "depdate" timestamp without time zone,
    "replaydate" timestamp without time zone,
    "log_field" "text"
);


ALTER TABLE "public"."log_transformations" OWNER TO "postgres";

--
-- TOC entry 200 (class 1259 OID 19423)
-- Name: ope_audits; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "ope_audits" (
    "alfresco_id" smallint NOT NULL,
    "id" bigint NOT NULL,
    "application" character varying(128) NOT NULL,
    "user" character varying(512) NOT NULL,
    "date" "date" NOT NULL,
    "action" character varying(128) NOT NULL,
    "hour" smallint NOT NULL,
    "minute" smallint NOT NULL,
    "path" character varying(4096) NOT NULL,
    "node-dbid" integer,
    "type" character varying(1024)
);


ALTER TABLE "public"."ope_audits" OWNER TO "postgres";

--
-- TOC entry 202 (class 1259 OID 19435)
-- Name: stg_audits; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "stg_audits" (
    "alfresco_id" smallint NOT NULL,
    "id" bigint NOT NULL,
    "application" character varying(50) NOT NULL,
    "user" character varying(100),
    "time" character varying(50) NOT NULL,
    "values" character varying(5000)
);


ALTER TABLE "public"."stg_audits" OWNER TO "postgres";

--
-- TOC entry 203 (class 1259 OID 19441)
-- Name: stg_cmis_documents; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "stg_rest_documents" (
    "alfresco_id" smallint NOT NULL,
    "node-dbid" integer,
    "store-protocol" character varying(128),
    "store-identifier" character varying(128),
    "node-uuid" character varying(128),
    "name" character varying(1024),
    "type" character varying(1024),
    "creator" character varying(1024),
    "created" character varying(32),
    "locale" character varying(128),
    "modifier" character varying(1024),
    "modified" character varying(32),
    "path" character varying(3072),
    "mimetype" character varying(128),
    "size" integer,
    "encoding" character varying(128),
    "content-locale" character varying(128),
    "parent-node-uuid" character varying(128)
);


ALTER TABLE "public"."stg_rest_documents" OWNER TO "postgres";

--
-- TOC entry 205 (class 1259 OID 19453)
-- Name: stg_cmis_folders; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "stg_rest_folders" (
    "alfresco_id" smallint NOT NULL,
    "node-dbid" integer,
    "store-protocol" character varying(128),
    "store-identifier" character varying(128),
    "node-uuid" character varying(128),
    "name" character varying(1024),
    "type" character varying(1024),
    "creator" character varying(1024),
    "created" character varying(32),
    "locale" character varying(128),
    "modifier" character varying(1024),
    "modified" character varying(32),
    "path" character varying(3072),
    "parent-node-uuid" character varying(128)
);


ALTER TABLE "public"."stg_rest_folders" OWNER TO "postgres";

--
-- TOC entry 223 (class 1259 OID 28596)
-- Name: stg_workflow_definitions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "stg_workflow_definitions" (
    "alfresco_id" smallint NOT NULL,
    "id" character varying(1024) NOT NULL,
    "name" character varying(1024),
    "title" character varying(1024),
    "description" character varying(1024),
    "version" character varying(1024),
    "url" character varying(1024) NOT NULL
);


ALTER TABLE "public"."stg_workflow_definitions" OWNER TO "postgres";

--
-- TOC entry 217 (class 1259 OID 27568)
-- Name: stg_workflow_instances; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "stg_workflow_instances" (
    "alfresco_id" smallint NOT NULL,
    "id" character varying(1024) NOT NULL,
    "url" character varying(1024),
    "name" character varying(1024),
    "title" character varying(1024),
    "description" character varying(1024),
    "isactive" character varying(1024),
    "startdate" character varying(128),
    "message" character varying(1024),
    "enddate" character varying(128),
    "duedate" character varying(128),
    "package" character varying(1024),
    "initiator" character varying(256),
    "definitionurl" character varying(1024)
);


ALTER TABLE "public"."stg_workflow_instances" OWNER TO "postgres";

--
-- TOC entry 227 (class 1259 OID 28975)
-- Name: stg_workflow_items; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "stg_workflow_items" (
    "alfresco_id" smallint NOT NULL,
    "package" character varying(1024) NOT NULL,
    "ordinal" smallint NOT NULL,
    "item" character varying(1024) NOT NULL
);


ALTER TABLE "public"."stg_workflow_items" OWNER TO "postgres";

--
-- TOC entry 218 (class 1259 OID 27589)
-- Name: stg_workflow_tasks; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "stg_workflow_tasks" (
    "alfresco_id" smallint NOT NULL,
    "instance_id" character varying(1024),
    "ordinal" integer,
    "id" character varying(1024) NOT NULL,
    "name" character varying(1024),
    "title" character varying(1024),
    "description" character varying(1024),
    "state" character varying(128),
    "ispooled" character varying(64),
    "iseditable" character varying(64),
    "isreassignable" character varying(64),
    "isclaimable" character varying(64),
    "isreleasable" character varying(64),
    "outcome" character varying(64),
    "owner" character varying(256),
    "bpm_startdate" character varying(128),
    "bpm_duedate" character varying(128),
    "bpm_completiondate" character varying(128),
    "bpm_outcome" character varying(1024),
    "bpm_status" character varying(1024),
    "bpm_description" character varying(1024)
);


ALTER TABLE "public"."stg_workflow_tasks" OWNER TO "postgres";


--
-- TOC entry 207 (class 1259 OID 19465)
-- Name: vw_cmis_documents_and_folders_path; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "vw_rest_documents_and_folders_path" AS
 SELECT "stg_rest_documents"."alfresco_id",
    "stg_rest_documents"."node-dbid",
    "stg_rest_documents"."type",
    "stg_rest_documents"."path"
   FROM "stg_rest_documents"
UNION ALL
 SELECT "stg_rest_folders"."alfresco_id",
    "stg_rest_folders"."node-dbid",
    "stg_rest_folders"."type",
    "stg_rest_folders"."path"
   FROM "stg_rest_folders";


--
-- TOC entry 208 (class 1259 OID 19470)
-- Name: vw_dm_dim_dates; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "vw_dm_dim_dates" AS
 SELECT "dm_dim_dates"."id",
    "dm_dim_dates"."desc" AS "day",
    "dm_dim_dates"."day_desc",
    "dm_dim_dates"."month_id",
    "dm_dim_months"."desc" AS "month",
    "dm_dim_months"."month_desc",
    "dm_dim_months"."year_id",
    "dm_dim_years"."desc" AS "year"
   FROM "dm_dim_dates",
    "dm_dim_months",
    "dm_dim_years"
  WHERE (("dm_dim_dates"."month_id" = "dm_dim_months"."id") AND ("dm_dim_months"."year_id" = "dm_dim_years"."id"));


ALTER TABLE "public"."vw_dm_dim_dates" OWNER TO "postgres";

--
-- TOC entry 209 (class 1259 OID 19474)
-- Name: vw_dm_dim_documents; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "vw_dm_dim_documents" AS
 SELECT "dm_dim_documents"."id",
    "dm_dim_documents"."store-protocol" || '://' || "dm_dim_documents"."store-identifier" || '/' || "dm_dim_documents"."node-uuid" as "noderef",
    "dm_dim_documents"."name",
    "dm_dim_documents"."path",
    "dm_dim_documents"."alfresco_id",
    "dm_dim_documents"."src_id"
   FROM "dm_dim_documents";


ALTER TABLE "public"."vw_dm_dim_documents" OWNER TO "postgres";

--
-- TOC entry 214 (class 1259 OID 19494)
-- Name: vw_dm_dim_minutes; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "vw_dm_dim_minutes" AS
 SELECT "dm_dim_minutes"."id",
    "dm_dim_minutes"."desc" AS "minute",
    "dm_dim_minutes"."hour_id",
    "dm_dim_hours"."desc" AS "hour"
   FROM "dm_dim_minutes",
    "dm_dim_hours"
  WHERE ("dm_dim_minutes"."hour_id" = "dm_dim_hours"."id");


ALTER TABLE "public"."vw_dm_dim_minutes" OWNER TO "postgres";

--
-- TOC entry 215 (class 1259 OID 19498)
-- Name: vw_dm_fact_documents; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "vw_dm_fact_documents" AS
 SELECT "dm_dim_documents"."id",
    "dm_dim_documents"."id" AS "document_id",
    "dm_dim_documents"."alfresco_id",
    "dm_dim_documents"."node_type_id",
    "dm_dim_documents"."mime_type_id",
    "dm_dim_documents"."user_creator_id",
    "dm_dim_documents"."creation_date_id",
    "dm_dim_documents"."creation_minute_id",
    "dm_dim_documents"."user_last_modifier_id",
    "dm_dim_documents"."last_modification_date_id",
    "dm_dim_documents"."last_modification_minute_id",
    "dm_dim_documents"."parent_id",
    "dm_dim_documents"."size",
    1 AS "number"
   FROM "dm_dim_documents";


ALTER TABLE "public"."vw_dm_fact_documents" OWNER TO "postgres";

--
-- TOC entry 216 (class 1259 OID 19502)
-- Name: vw_dm_fact_repository; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "vw_dm_fact_repository" AS
 SELECT ('DOC_'::"text" || "dm_dim_documents"."id") AS "id",
    "dm_dim_documents"."store-protocol" || '://' || "dm_dim_documents"."store-identifier" || '/' || "dm_dim_documents"."node-uuid" as "noderef",
    "dm_dim_documents"."name",
    "dm_dim_documents"."path",
    "dm_dim_documents"."alfresco_id",
    "dm_dim_documents"."node_type_id",
    "dm_dim_documents"."user_creator_id",
    "dm_dim_documents"."creation_date_id",
    "dm_dim_documents"."creation_minute_id",
    "dm_dim_documents"."user_last_modifier_id",
    "dm_dim_documents"."last_modification_date_id",
    "dm_dim_documents"."last_modification_minute_id",
    ('FOL_'::"text" || "dm_dim_documents"."parent_id") AS "parent_id",
    1 AS "num",
    "dm_dim_documents"."size" AS "bytes"
   FROM "dm_dim_documents"
UNION ALL
 SELECT ('FOL_'::"text" || "dm_dim_folders"."id") AS "id",
    "dm_dim_folders"."store-protocol" || '://' || "dm_dim_folders"."store-identifier" || '/' || "dm_dim_folders"."node-uuid" as "noderef",
    "dm_dim_folders"."name",
    "dm_dim_folders"."path",
    "dm_dim_folders"."alfresco_id",
    "dm_dim_folders"."node_type_id",
    "dm_dim_folders"."user_creator_id",
    "dm_dim_folders"."creation_date_id",
    "dm_dim_folders"."creation_minute_id",
    "dm_dim_folders"."user_last_modifier_id",
    "dm_dim_folders"."last_modification_date_id",
    "dm_dim_folders"."last_modification_minute_id",
    ('FOL_'::"text" || "dm_dim_folders"."parent_id") AS "parent_id",
    1 AS "num",
    0 AS "bytes"
   FROM "dm_dim_folders";


ALTER TABLE "public"."vw_dm_fact_repository" OWNER TO "postgres";

--
-- TOC entry 219 (class 1259 OID 27657)
-- Name: vw_dm_min_max_date; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "vw_dm_min_max_date" AS
 SELECT "t"."alfresco_id",
    "min"("t"."min_date") AS "min_date",
    "max"("t"."max_date") AS "max_date"
   FROM ( SELECT "dm_dim_alfresco"."id" AS "alfresco_id",
            ('now'::"text")::"date" AS "min_date",
            ('now'::"text")::"date" AS "max_date"
           FROM "dm_dim_alfresco"
        UNION ALL
         SELECT "ope_audit"."alfresco_id",
            "min"("ope_audit"."date") AS "min_date",
            "max"("ope_audit"."date") AS "max_date"
           FROM "ope_audits" "ope_audit"
          GROUP BY "ope_audit"."alfresco_id"
        UNION ALL
         SELECT "stg_rest_folder"."alfresco_id",
            "min"(("stg_rest_folder"."created")::"date") AS "min_date",
            "max"(("stg_rest_folder"."created")::"date") AS "max_date"
           FROM "stg_rest_folders" "stg_rest_folder"
          GROUP BY "stg_rest_folder"."alfresco_id"
        UNION ALL
         SELECT "stg_rest_folder"."alfresco_id",
            "min"(("stg_rest_folder"."modified")::"date") AS "min_date",
            "max"(("stg_rest_folder"."modified")::"date") AS "max_date"
           FROM "stg_rest_folders" "stg_rest_folder"
          GROUP BY "stg_rest_folder"."alfresco_id"
        UNION ALL
         SELECT "stg_rest_document"."alfresco_id",
            "min"(("stg_rest_document"."created")::"date") AS "min_date",
            "max"(("stg_rest_document"."created")::"date") AS "max_date"
           FROM "stg_rest_documents" "stg_rest_document"
          GROUP BY "stg_rest_document"."alfresco_id"
        UNION ALL
         SELECT "stg_rest_document"."alfresco_id",
            "min"(("stg_rest_document"."modified")::"date") AS "min_date",
            "max"(("stg_rest_document"."modified")::"date") AS "max_date"
           FROM "stg_rest_documents" "stg_rest_document"
          GROUP BY "stg_rest_document"."alfresco_id"
        UNION ALL
         SELECT "stg_workflow_instances"."alfresco_id",
            "min"(("stg_workflow_instances"."startdate")::"date") AS "min_date",
            "max"(("stg_workflow_instances"."startdate")::"date") AS "max_date"
           FROM "stg_workflow_instances" "stg_workflow_instances"
          GROUP BY "stg_workflow_instances"."alfresco_id"
        UNION ALL
         SELECT "stg_workflow_instances"."alfresco_id",
            "min"(("stg_workflow_instances"."enddate")::"date") AS "min_date",
            "max"(("stg_workflow_instances"."enddate")::"date") AS "max_date"
           FROM "stg_workflow_instances" "stg_workflow_instances"
          GROUP BY "stg_workflow_instances"."alfresco_id"
        UNION ALL
         SELECT "stg_workflow_instances"."alfresco_id",
            "min"(("stg_workflow_instances"."duedate")::"date") AS "min_date",
            "max"(("stg_workflow_instances"."duedate")::"date") AS "max_date"
           FROM "stg_workflow_instances" "stg_workflow_instances"
          GROUP BY "stg_workflow_instances"."alfresco_id"
        UNION ALL
         SELECT "stg_workflow_tasks"."alfresco_id",
            "min"(("stg_workflow_tasks"."bpm_startdate")::"date") AS "min_date",
            "max"(("stg_workflow_tasks"."bpm_startdate")::"date") AS "max_date"
           FROM "stg_workflow_tasks" "stg_workflow_tasks"
          GROUP BY "stg_workflow_tasks"."alfresco_id"
        UNION ALL
         SELECT "stg_workflow_tasks"."alfresco_id",
            "min"(("stg_workflow_tasks"."bpm_duedate")::"date") AS "min_date",
            "max"(("stg_workflow_tasks"."bpm_duedate")::"date") AS "max_date"
           FROM "stg_workflow_tasks" "stg_workflow_tasks"
          GROUP BY "stg_workflow_tasks"."alfresco_id"
        UNION ALL
         SELECT "stg_workflow_tasks"."alfresco_id",
            "min"(("stg_workflow_tasks"."bpm_completiondate")::"date") AS "min_date",
            "max"(("stg_workflow_tasks"."bpm_completiondate")::"date") AS "max_date"
           FROM "stg_workflow_tasks" "stg_workflow_tasks"
          GROUP BY "stg_workflow_tasks"."alfresco_id") "t"
  GROUP BY "t"."alfresco_id";

ALTER TABLE "public"."vw_dm_min_max_date" OWNER TO "postgres";

--
-- TOC entry 2393 (class 0 OID 19279)
-- Dependencies: 171
-- Data for Name: dm_custom_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- TOC entry 2395 (class 0 OID 19289)
-- Dependencies: 173
-- Data for Name: dm_dim_actions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2396 (class 0 OID 19293)
-- Dependencies: 174
-- Data for Name: dm_dim_alfresco; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dm_dim_alfresco" ("id", "desc", "login", "password", "url", "url_audit_suffix", "audit_limit", "url_nodes_modified_after_suffix", "url_nodes_modified_before_suffix", "node_limit",  "url_cmis_suffix", "url_workflow_definitions_suffix", "url_workflow_instances_suffix", "is_active") VALUES (1, 'Default Alfresco instance', 'admin', 'admin', 'http://localhost:8080', '/alfresco/service/api/audit/query/alfresco-access?verbose=true', 50000, '/alfresco/service/AAAR/getNodesModifiedAfter', '/alfresco/service/AAAR/getNodeIdsModifiedBefore', 50000, '/alfresco/api/-default-/cmis/versions/1.1/atom', '/alfresco/service/api/workflow-definitions', '/alfresco/service/api/workflow-instances', 'Y');


--
-- TOC entry 2415 (class 0 OID 19375)
-- Dependencies: 193
-- Data for Name: dm_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (5, 'http://localhost:8181/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'audit_use.prpt', 'audit_use.pdf', 'localhost', 2121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (6, 'http://localhost:8181/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'document_active_users.prpt', 'document_active_users.pdf', 'localhost', 2121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (7, 'http://localhost:8181/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'document_hours_of_activity.prpt', 'document_hours_of_activity.pdf', 'localhost', 2121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (8, 'http://localhost:8181/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'document_mime_types.prpt', 'document_mime_types.pdf', 'localhost', 2121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (9, 'http://localhost:8181/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'document_size.prpt', 'document_size.pdf', 'localhost', 2121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (10, 'http://localhost:8181/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'document_types.prpt', 'document_types.pdf', 'localhost', 2121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (11, 'http://localhost:8181/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'folder_types.prpt', 'folder_types.pdf', 'localhost', 2121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (1, 'http://localhost:8181/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'audit_creation.prpt', 'audit_creation.pdf', 'localhost', 2121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (2, 'http://localhost:8181/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'audit_details.prpt', 'audit_details.pdf', 'localhost', 2121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (3, 'http://localhost:8181/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'audit_login.prpt', 'audit_login.pdf', 'localhost', 2121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (4, 'http://localhost:8181/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'audit_topTen.prpt', 'audit_topTen.pdf', 'localhost', 2121, 'admin', 'admin', 'alfresco', 'Y');


--
-- TOC entry 2448 (class 0 OID 0)
-- Dependencies: 170
-- Name: seq_dm_custom_metadata_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_custom_metadata_id"', 1, false);


--
-- TOC entry 2449 (class 0 OID 0)
-- Dependencies: 172
-- Name: seq_dm_dim_actions_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_dim_actions_id"', 1, true);


--
-- TOC entry 2450 (class 0 OID 0)
-- Dependencies: 176
-- Name: seq_dm_dim_documents_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_dim_documents_id"', 1, true);


--
-- TOC entry 2451 (class 0 OID 0)
-- Dependencies: 178
-- Name: seq_dm_dim_folders_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_dim_folders_id"', 1, true);


--
-- TOC entry 2452 (class 0 OID 0)
-- Dependencies: 181
-- Name: seq_dm_dim_mime_types_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_dim_mime_types_id"', 1, true);


--
-- TOC entry 2453 (class 0 OID 0)
-- Dependencies: 185
-- Name: seq_dm_dim_node_types_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_dim_node_types_id"', 1, true);


--
-- TOC entry 2454 (class 0 OID 0)
-- Dependencies: 187
-- Name: seq_dm_dim_paths_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_dim_paths_id"', 1, true);


--
-- TOC entry 2455 (class 0 OID 0)
-- Dependencies: 189
-- Name: seq_dm_dim_users_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_dim_users_id"', 1, true);


--
-- TOC entry 2456 (class 0 OID 0)
-- Dependencies: 220
-- Name: seq_dm_dim_workflow_definitions_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_dim_workflow_definitions_id"', 1, true);


--
-- TOC entry 2457 (class 0 OID 0)
-- Dependencies: 221
-- Name: seq_dm_dim_workflow_instances_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_dim_workflow_instances_id"', 1, true);


--
-- TOC entry 2458 (class 0 OID 0)
-- Dependencies: 222
-- Name: seq_dm_dim_workflow_tasks_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_dim_workflow_tasks_id"', 1, true);


--
-- TOC entry 2122 (class 2606 OID 19512)
-- Name: pk_dm_custom_metadata; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_custom_metadata"
    ADD CONSTRAINT "pk_dm_custom_metadata" PRIMARY KEY ("id");


--
-- TOC entry 2125 (class 2606 OID 19514)
-- Name: pk_dm_dim_action; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_dim_actions"
    ADD CONSTRAINT "pk_dm_dim_action" PRIMARY KEY ("id");


--
-- TOC entry 2131 (class 2606 OID 19516)
-- Name: pk_dm_dim_dates; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_dim_dates"
    ADD CONSTRAINT "pk_dm_dim_dates" PRIMARY KEY ("id");


--
-- TOC entry 2135 (class 2606 OID 19518)
-- Name: pk_dm_dim_documents; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "pk_dm_dim_documents" PRIMARY KEY ("id");


--
-- TOC entry 2141 (class 2606 OID 19520)
-- Name: pk_dm_dim_folders; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "pk_dm_dim_folders" PRIMARY KEY ("id");


--
-- TOC entry 2146 (class 2606 OID 19522)
-- Name: pk_dm_dim_hours; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_dim_hours"
    ADD CONSTRAINT "pk_dm_dim_hours" PRIMARY KEY ("id");


--
-- TOC entry 2149 (class 2606 OID 19524)
-- Name: pk_dm_dim_mime_types; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_dim_mime_types"
    ADD CONSTRAINT "pk_dm_dim_mime_types" PRIMARY KEY ("id");


--
-- TOC entry 2152 (class 2606 OID 19526)
-- Name: pk_dm_dim_minutes; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_dim_minutes"
    ADD CONSTRAINT "pk_dm_dim_minutes" PRIMARY KEY ("id");


--
-- TOC entry 2155 (class 2606 OID 19528)
-- Name: pk_dm_dim_months; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_dim_months"
    ADD CONSTRAINT "pk_dm_dim_months" PRIMARY KEY ("id");


--
-- TOC entry 2158 (class 2606 OID 19530)
-- Name: pk_dm_dim_node_types; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_dim_node_types"
    ADD CONSTRAINT "pk_dm_dim_node_types" PRIMARY KEY ("id");


--
-- TOC entry 2161 (class 2606 OID 19532)
-- Name: pk_dm_dim_path; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_dim_paths"
    ADD CONSTRAINT "pk_dm_dim_path" PRIMARY KEY ("id");


--
-- TOC entry 2164 (class 2606 OID 19534)
-- Name: pk_dm_dim_users; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_dim_users"
    ADD CONSTRAINT "pk_dm_dim_users" PRIMARY KEY ("id");


--
-- TOC entry 2196 (class 2606 OID 28696)
-- Name: pk_dm_dim_workflow_definitions; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_dim_workflow_definitions"
    ADD CONSTRAINT "pk_dm_dim_workflow_definitions" PRIMARY KEY ("id");


--
-- TOC entry 2199 (class 2606 OID 28711)
-- Name: pk_dm_dim_workflow_instances; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_dim_workflow_instances"
    ADD CONSTRAINT "pk_dm_dim_workflow_instances" PRIMARY KEY ("id");


--
-- TOC entry 2207 (class 2606 OID 29104)
-- Name: pk_dm_dim_workflow_items; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_dim_workflow_items"
    ADD CONSTRAINT "pk_dm_dim_workflow_items" PRIMARY KEY ("alfresco_id", "workflow_instance_id", "ordinal");


--
-- TOC entry 2202 (class 2606 OID 28856)
-- Name: pk_dm_dim_workflow_tasks; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_dim_workflow_tasks"
    ADD CONSTRAINT "pk_dm_dim_workflow_tasks" PRIMARY KEY ("id");


--
-- TOC entry 2167 (class 2606 OID 19536)
-- Name: pk_dm_dim_years; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_dim_years"
    ADD CONSTRAINT "pk_dm_dim_years" PRIMARY KEY ("id");


--
-- TOC entry 2169 (class 2606 OID 19540)
-- Name: pk_reports; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_reports"
    ADD CONSTRAINT "pk_reports" PRIMARY KEY ("id");


--
-- TOC entry 2128 (class 2606 OID 19542)
-- Name: pk_stg_alfresco; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_dim_alfresco"
    ADD CONSTRAINT "pk_stg_alfresco" PRIMARY KEY ("id");


--
-- TOC entry 2177 (class 2606 OID 19544)
-- Name: pk_stg_audit; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "stg_audits"
    ADD CONSTRAINT "pk_stg_audit" PRIMARY KEY ("alfresco_id", "id", "application");


--
-- TOC entry 2173 (class 2606 OID 19546)
-- Name: pk_stg_audit_extended; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "ope_audits"
    ADD CONSTRAINT "pk_stg_audit_extended" PRIMARY KEY ("alfresco_id", "id", "application");


--
-- TOC entry 2191 (class 2606 OID 27575)
-- Name: pk_stg_workflow_instances; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "stg_workflow_instances"
    ADD CONSTRAINT "pk_stg_workflow_instances" PRIMARY KEY ("alfresco_id", "id");


--
-- TOC entry 2204 (class 2606 OID 28982)
-- Name: pk_stg_workflow_packages; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "stg_workflow_items"
    ADD CONSTRAINT "pk_stg_workflow_packages" PRIMARY KEY ("alfresco_id", "package", "item");


--
-- TOC entry 2193 (class 2606 OID 27596)
-- Name: pk_stg_workflow_tasks; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "stg_workflow_tasks"
    ADD CONSTRAINT "pk_stg_workflow_tasks" PRIMARY KEY ("alfresco_id", "id");


--
-- TOC entry 2180 (class 2606 OID 19548)
-- Name: uni_cmis_document; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "stg_rest_documents"
    ADD CONSTRAINT "uni_document_id" UNIQUE ("alfresco_id", "node-dbid");

--
-- TOC entry 2186 (class 2606 OID 19552)
-- Name: uni_cmis_folder_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "stg_rest_folders"
    ADD CONSTRAINT "uni_folder_id" UNIQUE ("alfresco_id", "node-dbid");


--
-- TOC entry 2137 (class 2606 OID 19556)
-- Name: unq_dm_dim_documents; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "unq_dm_dim_documents" UNIQUE ("alfresco_id", "src_id");


--
-- TOC entry 2143 (class 2606 OID 19558)
-- Name: unq_dm_dim_folders; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "unq_dm_dim_folders" UNIQUE ("alfresco_id", "src_id");


--
-- TOC entry 2120 (class 1259 OID 19559)
-- Name: idx_dm_custom_metadata; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_dm_custom_metadata" ON "dm_custom_metadata" USING "btree" ("id");


--
-- TOC entry 2123 (class 1259 OID 19560)
-- Name: idx_dm_dim_actions; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_dm_dim_actions" ON "dm_dim_actions" USING "btree" ("id");


--
-- TOC entry 2126 (class 1259 OID 19561)
-- Name: idx_dm_dim_alfresco; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_dm_dim_alfresco" ON "dm_dim_alfresco" USING "btree" ("id");


--
-- TOC entry 2129 (class 1259 OID 19562)
-- Name: idx_dm_dim_dates; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_dm_dim_dates" ON "dm_dim_dates" USING "btree" ("id");


--
-- TOC entry 2132 (class 1259 OID 19563)
-- Name: idx_dm_dim_documents; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_dm_dim_documents" ON "dm_dim_documents" USING "btree" ("id");


--
-- TOC entry 2133 (class 1259 OID 19564)
-- Name: idx_dm_dim_documents_src_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_dm_dim_documents_src_id" ON "dm_dim_documents" USING "btree" ("alfresco_id", "src_id");


--
-- TOC entry 2138 (class 1259 OID 19565)
-- Name: idx_dm_dim_folders; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_dm_dim_folders" ON "dm_dim_folders" USING "btree" ("id");


--
-- TOC entry 2139 (class 1259 OID 19566)
-- Name: idx_dm_dim_folders_src_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_dm_dim_folders_src_id" ON "dm_dim_folders" USING "btree" ("alfresco_id", "src_id");


--
-- TOC entry 2144 (class 1259 OID 19567)
-- Name: idx_dm_dim_hours; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_dm_dim_hours" ON "dm_dim_hours" USING "btree" ("id");


--
-- TOC entry 2147 (class 1259 OID 19568)
-- Name: idx_dm_dim_mime_types; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_dm_dim_mime_types" ON "dm_dim_mime_types" USING "btree" ("id");


--
-- TOC entry 2150 (class 1259 OID 19569)
-- Name: idx_dm_dim_minutes; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_dm_dim_minutes" ON "dm_dim_minutes" USING "btree" ("id");


--
-- TOC entry 2153 (class 1259 OID 19570)
-- Name: idx_dm_dim_months; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_dm_dim_months" ON "dm_dim_months" USING "btree" ("id");


--
-- TOC entry 2156 (class 1259 OID 19571)
-- Name: idx_dm_dim_node_types; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_dm_dim_node_types" ON "dm_dim_node_types" USING "btree" ("id");


--
-- TOC entry 2159 (class 1259 OID 19572)
-- Name: idx_dm_dim_paths; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_dm_dim_paths" ON "dm_dim_paths" USING "btree" ("id");


--
-- TOC entry 2162 (class 1259 OID 19573)
-- Name: idx_dm_dim_users; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_dm_dim_users" ON "dm_dim_users" USING "btree" ("id");


--
-- TOC entry 2194 (class 1259 OID 28702)
-- Name: idx_dm_dim_workflow_definitions; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_dm_dim_workflow_definitions" ON "dm_dim_workflow_definitions" USING "btree" ("id");


--
-- TOC entry 2197 (class 1259 OID 28757)
-- Name: idx_dm_dim_workflow_instances; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_dm_dim_workflow_instances" ON "dm_dim_workflow_instances" USING "btree" ("id");


--
-- TOC entry 2205 (class 1259 OID 29120)
-- Name: idx_dm_dim_workflow_items; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_dm_dim_workflow_items" ON "dm_dim_workflow_items" USING "btree" ("alfresco_id", "workflow_instance_id", "ordinal");


--
-- TOC entry 2200 (class 1259 OID 28902)
-- Name: idx_dm_dim_workflow_tasks; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_dm_dim_workflow_tasks" ON "dm_dim_workflow_tasks" USING "btree" ("id");


--
-- TOC entry 2165 (class 1259 OID 19574)
-- Name: idx_dm_dim_years; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_dm_dim_years" ON "dm_dim_years" USING "btree" ("id");


--
-- TOC entry 2170 (class 1259 OID 19575)
-- Name: idx_log_transformations_1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_log_transformations_1" ON "log_transformations" USING "btree" ("id_batch");


--
-- TOC entry 2171 (class 1259 OID 19576)
-- Name: idx_log_transformations_2; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_log_transformations_2" ON "log_transformations" USING "btree" ("errors", "status", "transname");


--
-- TOC entry 2208 (class 2606 OID 19591)
-- Name: fk_dm_custom_metadata_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_custom_metadata"
    ADD CONSTRAINT "fk_dm_custom_metadata_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2209 (class 2606 OID 19596)
-- Name: fk_dm_dim_action_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_actions"
    ADD CONSTRAINT "fk_dm_dim_action_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2210 (class 2606 OID 19601)
-- Name: fk_dm_dim_dates_dm_dim_months; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_dates"
    ADD CONSTRAINT "fk_dm_dim_dates_dm_dim_months" FOREIGN KEY ("month_id") REFERENCES "dm_dim_months"("id");


--
-- TOC entry 2211 (class 2606 OID 19606)
-- Name: fk_dm_dim_documents_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "fk_dm_dim_documents_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2212 (class 2606 OID 19611)
-- Name: fk_dm_dim_documents_dm_dim_dates_creation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "fk_dm_dim_documents_dm_dim_dates_creation" FOREIGN KEY ("creation_date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2213 (class 2606 OID 19616)
-- Name: fk_dm_dim_documents_dm_dim_dates_last_modification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "fk_dm_dim_documents_dm_dim_dates_last_modification" FOREIGN KEY ("last_modification_date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2214 (class 2606 OID 19621)
-- Name: fk_dm_dim_documents_dm_dim_folders_parent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "fk_dm_dim_documents_dm_dim_folders_parent" FOREIGN KEY ("parent_id") REFERENCES "dm_dim_folders"("id");


--
-- TOC entry 2215 (class 2606 OID 19626)
-- Name: fk_dm_dim_documents_dm_dim_mime_types; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "fk_dm_dim_documents_dm_dim_mime_types" FOREIGN KEY ("mime_type_id") REFERENCES "dm_dim_mime_types"("id");


--
-- TOC entry 2216 (class 2606 OID 19631)
-- Name: fk_dm_dim_documents_dm_dim_minutes_creation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "fk_dm_dim_documents_dm_dim_minutes_creation" FOREIGN KEY ("creation_minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2217 (class 2606 OID 19636)
-- Name: fk_dm_dim_documents_dm_dim_minutes_last_modification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "fk_dm_dim_documents_dm_dim_minutes_last_modification" FOREIGN KEY ("last_modification_minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2218 (class 2606 OID 19641)
-- Name: fk_dm_dim_documents_dm_dim_node_types; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "fk_dm_dim_documents_dm_dim_node_types" FOREIGN KEY ("node_type_id") REFERENCES "dm_dim_node_types"("id");


--
-- TOC entry 2219 (class 2606 OID 19646)
-- Name: fk_dm_dim_documents_dm_dim_users_creator; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "fk_dm_dim_documents_dm_dim_users_creator" FOREIGN KEY ("user_creator_id") REFERENCES "dm_dim_users"("id");


--
-- TOC entry 2220 (class 2606 OID 19651)
-- Name: fk_dm_dim_documents_dm_dim_users_last_modifier; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "fk_dm_dim_documents_dm_dim_users_last_modifier" FOREIGN KEY ("user_last_modifier_id") REFERENCES "dm_dim_users"("id");


--
-- TOC entry 2221 (class 2606 OID 19656)
-- Name: fk_dm_dim_folders_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "fk_dm_dim_folders_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2222 (class 2606 OID 19661)
-- Name: fk_dm_dim_folders_dm_dim_dates_creation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "fk_dm_dim_folders_dm_dim_dates_creation" FOREIGN KEY ("creation_date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2223 (class 2606 OID 19666)
-- Name: fk_dm_dim_folders_dm_dim_dates_last_modification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "fk_dm_dim_folders_dm_dim_dates_last_modification" FOREIGN KEY ("last_modification_date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2224 (class 2606 OID 19671)
-- Name: fk_dm_dim_folders_dm_dim_folders_aprent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "fk_dm_dim_folders_dm_dim_folders_aprent" FOREIGN KEY ("parent_id") REFERENCES "dm_dim_folders"("id");


--
-- TOC entry 2225 (class 2606 OID 19676)
-- Name: fk_dm_dim_folders_dm_dim_minutes_creation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "fk_dm_dim_folders_dm_dim_minutes_creation" FOREIGN KEY ("creation_minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2226 (class 2606 OID 19681)
-- Name: fk_dm_dim_folders_dm_dim_minutes_last_modification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "fk_dm_dim_folders_dm_dim_minutes_last_modification" FOREIGN KEY ("last_modification_minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2227 (class 2606 OID 19686)
-- Name: fk_dm_dim_folders_dm_dim_node_types; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "fk_dm_dim_folders_dm_dim_node_types" FOREIGN KEY ("node_type_id") REFERENCES "dm_dim_node_types"("id");


--
-- TOC entry 2228 (class 2606 OID 19691)
-- Name: fk_dm_dim_folders_dm_dim_users_creator; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "fk_dm_dim_folders_dm_dim_users_creator" FOREIGN KEY ("user_creator_id") REFERENCES "dm_dim_users"("id");


--
-- TOC entry 2229 (class 2606 OID 19696)
-- Name: fk_dm_dim_folders_dm_dim_users_last_modifier; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "fk_dm_dim_folders_dm_dim_users_last_modifier" FOREIGN KEY ("user_last_modifier_id") REFERENCES "dm_dim_users"("id");


--
-- TOC entry 2230 (class 2606 OID 19701)
-- Name: fk_dm_dim_mime_types_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_mime_types"
    ADD CONSTRAINT "fk_dm_dim_mime_types_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2231 (class 2606 OID 19706)
-- Name: fk_dm_dim_minutes_dm_dim_hours; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_minutes"
    ADD CONSTRAINT "fk_dm_dim_minutes_dm_dim_hours" FOREIGN KEY ("hour_id") REFERENCES "dm_dim_hours"("id");


--
-- TOC entry 2232 (class 2606 OID 19711)
-- Name: fk_dm_dim_months_dm_dim_years; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_months"
    ADD CONSTRAINT "fk_dm_dim_months_dm_dim_years" FOREIGN KEY ("year_id") REFERENCES "dm_dim_years"("id");

--
-- TOC entry 2233 (class 2606 OID 19716)
-- Name: fk_dm_dim_node_types_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_node_types"
    ADD CONSTRAINT "fk_dm_dim_node_types_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2234 (class 2606 OID 19721)
-- Name: fk_dm_dim_path_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_paths"
    ADD CONSTRAINT "fk_dm_dim_path_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2235 (class 2606 OID 19726)
-- Name: fk_dm_dim_path_dm_dim_folders; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_paths"
    ADD CONSTRAINT "fk_dm_dim_path_dm_dim_folders" FOREIGN KEY ("folder_id") REFERENCES "dm_dim_folders"("id");


--
-- TOC entry 2236 (class 2606 OID 19731)
-- Name: fk_dm_dim_paths_dm_dim_documents; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_paths"
    ADD CONSTRAINT "fk_dm_dim_paths_dm_dim_documents" FOREIGN KEY ("document_id") REFERENCES "dm_dim_documents"("id");


--
-- TOC entry 2237 (class 2606 OID 19736)
-- Name: fk_dm_dim_users_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_users"
    ADD CONSTRAINT "fk_dm_dim_users_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2251 (class 2606 OID 28697)
-- Name: fk_dm_dim_workflow_definitions_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_definitions"
    ADD CONSTRAINT "fk_dm_dim_workflow_definitions_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2252 (class 2606 OID 28712)
-- Name: fk_dm_dim_workflow_instances_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_instances"
    ADD CONSTRAINT "fk_dm_dim_workflow_instances_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2253 (class 2606 OID 28717)
-- Name: fk_dm_dim_workflow_instances_dm_dim_dates_due; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_instances"
    ADD CONSTRAINT "fk_dm_dim_workflow_instances_dm_dim_dates_due" FOREIGN KEY ("due_date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2254 (class 2606 OID 28722)
-- Name: fk_dm_dim_workflow_instances_dm_dim_dates_end; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_instances"
    ADD CONSTRAINT "fk_dm_dim_workflow_instances_dm_dim_dates_end" FOREIGN KEY ("end_date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2255 (class 2606 OID 28727)
-- Name: fk_dm_dim_workflow_instances_dm_dim_dates_start; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_instances"
    ADD CONSTRAINT "fk_dm_dim_workflow_instances_dm_dim_dates_start" FOREIGN KEY ("start_date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2256 (class 2606 OID 28732)
-- Name: fk_dm_dim_workflow_instances_dm_dim_minutes_due; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_instances"
    ADD CONSTRAINT "fk_dm_dim_workflow_instances_dm_dim_minutes_due" FOREIGN KEY ("due_minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2257 (class 2606 OID 28737)
-- Name: fk_dm_dim_workflow_instances_dm_dim_minutes_end; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_instances"
    ADD CONSTRAINT "fk_dm_dim_workflow_instances_dm_dim_minutes_end" FOREIGN KEY ("end_minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2258 (class 2606 OID 28742)
-- Name: fk_dm_dim_workflow_instances_dm_dim_minutes_start; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_instances"
    ADD CONSTRAINT "fk_dm_dim_workflow_instances_dm_dim_minutes_start" FOREIGN KEY ("start_minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2259 (class 2606 OID 28747)
-- Name: fk_dm_dim_workflow_instances_dm_dim_users; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_instances"
    ADD CONSTRAINT "fk_dm_dim_workflow_instances_dm_dim_users" FOREIGN KEY ("initiator_id") REFERENCES "dm_dim_users"("id");


--
-- TOC entry 2260 (class 2606 OID 28752)
-- Name: fk_dm_dim_workflow_instances_dm_dim_workflow_definitions; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_instances"
    ADD CONSTRAINT "fk_dm_dim_workflow_instances_dm_dim_workflow_definitions" FOREIGN KEY ("definition_id") REFERENCES "dm_dim_workflow_definitions"("id");


--
-- TOC entry 2271 (class 2606 OID 29105)
-- Name: fk_dm_dim_workflow_items_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_items"
    ADD CONSTRAINT "fk_dm_dim_workflow_items_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2272 (class 2606 OID 29110)
-- Name: fk_dm_dim_workflow_items_dm_dim_documents; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_items"
    ADD CONSTRAINT "fk_dm_dim_workflow_items_dm_dim_documents" FOREIGN KEY ("document_id") REFERENCES "dm_dim_documents"("id");


--
-- TOC entry 2273 (class 2606 OID 29115)
-- Name: fk_dm_dim_workflow_items_dm_dim_workflow_instances; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_items"
    ADD CONSTRAINT "fk_dm_dim_workflow_items_dm_dim_workflow_instances" FOREIGN KEY ("workflow_instance_id") REFERENCES "dm_dim_workflow_instances"("id");


--
-- TOC entry 2261 (class 2606 OID 28857)
-- Name: fk_dm_dim_workflow_tasks_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_tasks"
    ADD CONSTRAINT "fk_dm_dim_workflow_tasks_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2262 (class 2606 OID 28862)
-- Name: fk_dm_dim_workflow_tasks_dm_dim_dates_completion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_tasks"
    ADD CONSTRAINT "fk_dm_dim_workflow_tasks_dm_dim_dates_completion" FOREIGN KEY ("completion_date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2263 (class 2606 OID 28867)
-- Name: fk_dm_dim_workflow_tasks_dm_dim_dates_due; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_tasks"
    ADD CONSTRAINT "fk_dm_dim_workflow_tasks_dm_dim_dates_due" FOREIGN KEY ("due_date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2264 (class 2606 OID 28872)
-- Name: fk_dm_dim_workflow_tasks_dm_dim_dates_start; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_tasks"
    ADD CONSTRAINT "fk_dm_dim_workflow_tasks_dm_dim_dates_start" FOREIGN KEY ("start_date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2265 (class 2606 OID 28877)
-- Name: fk_dm_dim_workflow_tasks_dm_dim_minutes_completion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_tasks"
    ADD CONSTRAINT "fk_dm_dim_workflow_tasks_dm_dim_minutes_completion" FOREIGN KEY ("completion_minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2266 (class 2606 OID 28882)
-- Name: fk_dm_dim_workflow_tasks_dm_dim_minutes_due; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_tasks"
    ADD CONSTRAINT "fk_dm_dim_workflow_tasks_dm_dim_minutes_due" FOREIGN KEY ("due_minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2267 (class 2606 OID 28887)
-- Name: fk_dm_dim_workflow_tasks_dm_dim_minutes_start; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_tasks"
    ADD CONSTRAINT "fk_dm_dim_workflow_tasks_dm_dim_minutes_start" FOREIGN KEY ("start_minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2268 (class 2606 OID 28892)
-- Name: fk_dm_dim_workflow_tasks_dm_dim_users; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_tasks"
    ADD CONSTRAINT "fk_dm_dim_workflow_tasks_dm_dim_users" FOREIGN KEY ("owner_id") REFERENCES "dm_dim_users"("id");


--
-- TOC entry 2269 (class 2606 OID 28897)
-- Name: fk_dm_dim_workflow_tasks_dm_dim_workflow_instances; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_tasks"
    ADD CONSTRAINT "fk_dm_dim_workflow_tasks_dm_dim_workflow_instances" FOREIGN KEY ("instance_id") REFERENCES "dm_dim_workflow_instances"("id");


--
-- TOC entry 2238 (class 2606 OID 19741)
-- Name: fk_dm_fact_actions_dm_dim_actions; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_fact_actions"
    ADD CONSTRAINT "fk_dm_fact_actions_dm_dim_actions" FOREIGN KEY ("action_id") REFERENCES "dm_dim_actions"("id");


--
-- TOC entry 2239 (class 2606 OID 19746)
-- Name: fk_dm_fact_actions_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_fact_actions"
    ADD CONSTRAINT "fk_dm_fact_actions_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2240 (class 2606 OID 19751)
-- Name: fk_dm_fact_actions_dm_dim_dates; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_fact_actions"
    ADD CONSTRAINT "fk_dm_fact_actions_dm_dim_dates" FOREIGN KEY ("date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2241 (class 2606 OID 19756)
-- Name: fk_dm_fact_actions_dm_dim_minutes; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_fact_actions"
    ADD CONSTRAINT "fk_dm_fact_actions_dm_dim_minutes" FOREIGN KEY ("minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2242 (class 2606 OID 19761)
-- Name: fk_dm_fact_actions_dm_dim_paths; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_fact_actions"
    ADD CONSTRAINT "fk_dm_fact_actions_dm_dim_paths" FOREIGN KEY ("path_id") REFERENCES "dm_dim_paths"("id");


--
-- TOC entry 2243 (class 2606 OID 19766)
-- Name: fk_dm_fact_actions_dm_dim_users; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_fact_actions"
    ADD CONSTRAINT "fk_dm_fact_actions_dm_dim_users" FOREIGN KEY ("user_id") REFERENCES "dm_dim_users"("id");


--
-- TOC entry 2247 (class 2606 OID 19771)
-- Name: fk_stg_audit_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_audits"
    ADD CONSTRAINT "fk_stg_audit_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2244 (class 2606 OID 19776)
-- Name: fk_stg_audit_extended_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ope_audits"
    ADD CONSTRAINT "fk_stg_audit_extended_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2250 (class 2606 OID 28602)
-- Name: fk_stg_workflow_definitions_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_workflow_definitions"
    ADD CONSTRAINT "fk_stg_workflow_definitions_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2248 (class 2606 OID 27576)
-- Name: fk_stg_workflow_instances_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_workflow_instances"
    ADD CONSTRAINT "fk_stg_workflow_instances_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2270 (class 2606 OID 28983)
-- Name: fk_stg_workflow_packages_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_workflow_items"
    ADD CONSTRAINT "fk_stg_workflow_packages_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2249 (class 2606 OID 27597)
-- Name: fk_stg_workflow_tasks_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_workflow_tasks"
    ADD CONSTRAINT "fk_stg_workflow_tasks_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2133 (class 1259 OID 19564)
-- Name: idx_stg_rest_folders_node_uuid; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_stg_rest_folders_node_uuid" ON "stg_rest_folders" USING "btree" ("alfresco_id", "store-protocol", "store-identifier", "node-uuid");


--
-- TOC entry 2133 (class 1259 OID 19564)
-- Name: idx_stg_rest_folders_parent_node_uuid; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "idx_stg_rest_folders_parent_node_uuid" ON "stg_rest_folders" USING "btree" ("alfresco_id", "store-protocol", "store-identifier", "parent-node-uuid");


--
-- TOC entry 2446 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA "public" FROM PUBLIC;
REVOKE ALL ON SCHEMA "public" FROM "postgres";
GRANT ALL ON SCHEMA "public" TO "postgres";
GRANT ALL ON SCHEMA "public" TO PUBLIC;


-- Completed on 2015-04-10 15:50:17 CEST

--
-- PostgreSQL database dump complete
--

