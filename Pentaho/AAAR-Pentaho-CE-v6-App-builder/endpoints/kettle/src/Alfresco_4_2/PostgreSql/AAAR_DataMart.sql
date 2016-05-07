--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.2

-- Started on 2016-05-07 22:57:18 CEST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 1 (class 3079 OID 12395)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "plpgsql" WITH SCHEMA "pg_catalog";


--
-- TOC entry 2601 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION "plpgsql"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "plpgsql" IS 'PL/pgSQL procedural language';


SET search_path = "public", pg_catalog;

--
-- TOC entry 181 (class 1259 OID 16386)
-- Name: seq_dm_custom_metadata_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_custom_metadata_id"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "seq_dm_custom_metadata_id" OWNER TO "postgres";

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 182 (class 1259 OID 16388)
-- Name: dm_custom_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "dm_custom_metadata" (
    "id" smallint DEFAULT "nextval"('"seq_dm_custom_metadata_id"'::"regclass") NOT NULL,
    "class" character varying(255) NOT NULL,
    "name" character varying(255) NOT NULL,
    "type" character varying(255) NOT NULL,
    "is_document_subtype" character(1) DEFAULT 'N'::"bpchar" NOT NULL,
    "is_folder_subtype" character(1) DEFAULT 'N'::"bpchar" NOT NULL,
    "is_aspect" character(1) DEFAULT 'N'::"bpchar" NOT NULL,
    "is_active" character(1) DEFAULT 'Y'::"bpchar" NOT NULL,
    "alfresco_id" smallint NOT NULL
);


ALTER TABLE "dm_custom_metadata" OWNER TO "postgres";

--
-- TOC entry 236 (class 1259 OID 17467)
-- Name: dm_data_quality; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "dm_data_quality" (
    "alfresco_id" smallint NOT NULL,
    "batch_id" character varying(128) NOT NULL,
    "entities" character varying(128) NOT NULL,
    "layer" character varying(128) NOT NULL,
    "value" integer NOT NULL,
    "creation" timestamp without time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "dm_data_quality" OWNER TO "postgres";

--
-- TOC entry 183 (class 1259 OID 16399)
-- Name: seq_dm_dim_actions_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_dim_actions_id"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "seq_dm_dim_actions_id" OWNER TO "postgres";

--
-- TOC entry 184 (class 1259 OID 16401)
-- Name: dm_dim_actions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "dm_dim_actions" (
    "id" smallint DEFAULT "nextval"('"seq_dm_dim_actions_id"'::"regclass") NOT NULL,
    "desc" character varying(128) NOT NULL,
    "alfresco_id" smallint NOT NULL,
    "src_action" character varying(128) NOT NULL
);


ALTER TABLE "dm_dim_actions" OWNER TO "postgres";

--
-- TOC entry 185 (class 1259 OID 16405)
-- Name: dm_dim_alfresco; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE "dm_dim_alfresco" OWNER TO "postgres";

--
-- TOC entry 186 (class 1259 OID 16412)
-- Name: dm_dim_dates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "dm_dim_dates" (
    "id" "date" NOT NULL,
    "desc" character varying(64) NOT NULL,
    "day_desc" character varying(64) NOT NULL,
    "month_id" "date" NOT NULL
);


ALTER TABLE "dm_dim_dates" OWNER TO "postgres";

--
-- TOC entry 187 (class 1259 OID 16415)
-- Name: seq_dm_dim_documents_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_dim_documents_id"
    START WITH 11
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "seq_dm_dim_documents_id" OWNER TO "postgres";

--
-- TOC entry 188 (class 1259 OID 16417)
-- Name: dm_dim_documents; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE "dm_dim_documents" OWNER TO "postgres";

--
-- TOC entry 189 (class 1259 OID 16424)
-- Name: seq_dm_dim_folders_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_dim_folders_id"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "seq_dm_dim_folders_id" OWNER TO "postgres";

--
-- TOC entry 190 (class 1259 OID 16426)
-- Name: dm_dim_folders; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE "dm_dim_folders" OWNER TO "postgres";

--
-- TOC entry 191 (class 1259 OID 16433)
-- Name: dm_dim_hours; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "dm_dim_hours" (
    "id" smallint NOT NULL,
    "desc" character varying(16) NOT NULL
);


ALTER TABLE "dm_dim_hours" OWNER TO "postgres";

--
-- TOC entry 192 (class 1259 OID 16436)
-- Name: seq_dm_dim_mime_types_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_dim_mime_types_id"
    START WITH 11
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "seq_dm_dim_mime_types_id" OWNER TO "postgres";

--
-- TOC entry 193 (class 1259 OID 16438)
-- Name: dm_dim_mime_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "dm_dim_mime_types" (
    "id" smallint DEFAULT "nextval"('"seq_dm_dim_mime_types_id"'::"regclass") NOT NULL,
    "desc" character varying(512) NOT NULL,
    "alfresco_id" smallint NOT NULL,
    "src_id" character varying(512) NOT NULL
);


ALTER TABLE "dm_dim_mime_types" OWNER TO "postgres";

--
-- TOC entry 194 (class 1259 OID 16445)
-- Name: dm_dim_minutes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "dm_dim_minutes" (
    "id" smallint NOT NULL,
    "desc" character varying(16) NOT NULL,
    "hour_id" smallint NOT NULL
);


ALTER TABLE "dm_dim_minutes" OWNER TO "postgres";

--
-- TOC entry 195 (class 1259 OID 16448)
-- Name: dm_dim_months; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "dm_dim_months" (
    "id" "date" NOT NULL,
    "desc" character varying(64) NOT NULL,
    "month_desc" character varying(64) NOT NULL,
    "year_id" smallint NOT NULL
);


ALTER TABLE "dm_dim_months" OWNER TO "postgres";

--
-- TOC entry 196 (class 1259 OID 16451)
-- Name: seq_dm_dim_node_types_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_dim_node_types_id"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "seq_dm_dim_node_types_id" OWNER TO "postgres";

--
-- TOC entry 197 (class 1259 OID 16453)
-- Name: dm_dim_node_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "dm_dim_node_types" (
    "id" smallint DEFAULT "nextval"('"seq_dm_dim_node_types_id"'::"regclass") NOT NULL,
    "desc" character varying(512) NOT NULL,
    "base_type" character varying(512) NOT NULL,
    "alfresco_id" smallint NOT NULL,
    "src_id" character varying(512) NOT NULL
);


ALTER TABLE "dm_dim_node_types" OWNER TO "postgres";

--
-- TOC entry 198 (class 1259 OID 16460)
-- Name: seq_dm_dim_paths_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_dim_paths_id"
    START WITH 11
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "seq_dm_dim_paths_id" OWNER TO "postgres";

--
-- TOC entry 199 (class 1259 OID 16462)
-- Name: dm_dim_paths; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "dm_dim_paths" (
    "id" integer DEFAULT "nextval"('"seq_dm_dim_paths_id"'::"regclass") NOT NULL,
    "path" character varying(4096) NOT NULL,
    "folder_id" integer,
    "document_id" integer,
    "alfresco_id" smallint NOT NULL,
    "src_path" character varying(4096) NOT NULL
);


ALTER TABLE "dm_dim_paths" OWNER TO "postgres";

--
-- TOC entry 200 (class 1259 OID 16469)
-- Name: seq_dm_dim_users_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_dim_users_id"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "seq_dm_dim_users_id" OWNER TO "postgres";

--
-- TOC entry 201 (class 1259 OID 16471)
-- Name: dm_dim_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "dm_dim_users" (
    "id" integer DEFAULT "nextval"('"seq_dm_dim_users_id"'::"regclass") NOT NULL,
    "desc" character varying(512) NOT NULL,
    "alfresco_id" smallint NOT NULL,
    "src_user" character varying(512) NOT NULL
);


ALTER TABLE "dm_dim_users" OWNER TO "postgres";

--
-- TOC entry 202 (class 1259 OID 16478)
-- Name: seq_dm_dim_workflow_definitions_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_dim_workflow_definitions_id"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "seq_dm_dim_workflow_definitions_id" OWNER TO "postgres";

--
-- TOC entry 203 (class 1259 OID 16480)
-- Name: dm_dim_workflow_definitions; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE "dm_dim_workflow_definitions" OWNER TO "postgres";

--
-- TOC entry 204 (class 1259 OID 16487)
-- Name: seq_dm_dim_workflow_instances_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_dim_workflow_instances_id"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "seq_dm_dim_workflow_instances_id" OWNER TO "postgres";

--
-- TOC entry 205 (class 1259 OID 16489)
-- Name: dm_dim_workflow_instances; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE "dm_dim_workflow_instances" OWNER TO "postgres";

--
-- TOC entry 206 (class 1259 OID 16496)
-- Name: dm_dim_workflow_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "dm_dim_workflow_items" (
    "workflow_instance_id" integer NOT NULL,
    "document_id" integer NOT NULL,
    "ordinal" smallint NOT NULL,
    "alfresco_id" smallint NOT NULL
);


ALTER TABLE "dm_dim_workflow_items" OWNER TO "postgres";

--
-- TOC entry 207 (class 1259 OID 16499)
-- Name: seq_dm_dim_workflow_tasks_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "seq_dm_dim_workflow_tasks_id"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "seq_dm_dim_workflow_tasks_id" OWNER TO "postgres";

--
-- TOC entry 208 (class 1259 OID 16501)
-- Name: dm_dim_workflow_tasks; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE "dm_dim_workflow_tasks" OWNER TO "postgres";

--
-- TOC entry 209 (class 1259 OID 16508)
-- Name: dm_dim_years; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "dm_dim_years" (
    "id" smallint NOT NULL,
    "desc" character varying NOT NULL
);


ALTER TABLE "dm_dim_years" OWNER TO "postgres";

--
-- TOC entry 210 (class 1259 OID 16514)
-- Name: dm_fact_actions; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE "dm_fact_actions" OWNER TO "postgres";

--
-- TOC entry 235 (class 1259 OID 17459)
-- Name: dm_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "dm_logs" (
    "alfresco_id" smallint NOT NULL,
    "batch_id" character varying(128) NOT NULL,
    "description" character varying(256) NOT NULL,
    "batch_start" timestamp without time zone NOT NULL,
    "batch_end" timestamp without time zone NOT NULL,
    "success" character(1) NOT NULL
);


ALTER TABLE "dm_logs" OWNER TO "postgres";

--
-- TOC entry 211 (class 1259 OID 16517)
-- Name: dm_reports; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE "dm_reports" OWNER TO "postgres";

--
-- TOC entry 212 (class 1259 OID 16529)
-- Name: log_channels; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE "log_channels" OWNER TO "postgres";

--
-- TOC entry 213 (class 1259 OID 16535)
-- Name: log_job; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE "log_job" OWNER TO "postgres";

--
-- TOC entry 214 (class 1259 OID 16541)
-- Name: log_jobentry; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE "log_jobentry" OWNER TO "postgres";

--
-- TOC entry 215 (class 1259 OID 16547)
-- Name: log_performance; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE "log_performance" OWNER TO "postgres";

--
-- TOC entry 216 (class 1259 OID 16553)
-- Name: log_step; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE "log_step" OWNER TO "postgres";

--
-- TOC entry 217 (class 1259 OID 16559)
-- Name: log_transformations; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE "log_transformations" OWNER TO "postgres";

--
-- TOC entry 218 (class 1259 OID 16565)
-- Name: ope_audits; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE "ope_audits" OWNER TO "postgres";

--
-- TOC entry 219 (class 1259 OID 16571)
-- Name: stg_audits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "stg_audits" (
    "alfresco_id" smallint NOT NULL,
    "id" bigint NOT NULL,
    "application" character varying(50) NOT NULL,
    "user" character varying(100),
    "time" character varying(50) NOT NULL,
    "values" character varying(5000)
);


ALTER TABLE "stg_audits" OWNER TO "postgres";

--
-- TOC entry 220 (class 1259 OID 16577)
-- Name: stg_rest_documents; Type: TABLE; Schema: public; Owner: postgres
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
    "parent-node-uuid" character varying(128),
    "custom_aspects" character varying(8192)
);


ALTER TABLE "stg_rest_documents" OWNER TO "postgres";

--
-- TOC entry 221 (class 1259 OID 16583)
-- Name: stg_rest_documents_custom_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "stg_rest_documents_custom_types" (
    "alfresco_id" smallint NOT NULL,
    "node-dbid" integer,
    "custom_types" character varying(8192)
);


ALTER TABLE "stg_rest_documents_custom_types" OWNER TO "postgres";

--
-- TOC entry 222 (class 1259 OID 16589)
-- Name: stg_rest_folders; Type: TABLE; Schema: public; Owner: postgres
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
    "parent-node-uuid" character varying(128),
    "custom_aspects" character varying(8192)
);


ALTER TABLE "stg_rest_folders" OWNER TO "postgres";

--
-- TOC entry 223 (class 1259 OID 16595)
-- Name: stg_rest_folders_custom_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "stg_rest_folders_custom_types" (
    "alfresco_id" smallint NOT NULL,
    "node-dbid" integer,
    "custom_types" character varying(8192)
);


ALTER TABLE "stg_rest_folders_custom_types" OWNER TO "postgres";

--
-- TOC entry 224 (class 1259 OID 16601)
-- Name: stg_workflow_definitions; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE "stg_workflow_definitions" OWNER TO "postgres";

--
-- TOC entry 225 (class 1259 OID 16607)
-- Name: stg_workflow_instances; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE "stg_workflow_instances" OWNER TO "postgres";

--
-- TOC entry 226 (class 1259 OID 16613)
-- Name: stg_workflow_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "stg_workflow_items" (
    "alfresco_id" smallint NOT NULL,
    "package" character varying(1024) NOT NULL,
    "ordinal" smallint NOT NULL,
    "item" character varying(1024) NOT NULL
);


ALTER TABLE "stg_workflow_items" OWNER TO "postgres";

--
-- TOC entry 227 (class 1259 OID 16619)
-- Name: stg_workflow_tasks; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE "stg_workflow_tasks" OWNER TO "postgres";

--
-- TOC entry 229 (class 1259 OID 16629)
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


ALTER TABLE "vw_dm_dim_dates" OWNER TO "postgres";

--
-- TOC entry 230 (class 1259 OID 16633)
-- Name: vw_dm_dim_documents; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "vw_dm_dim_documents" AS
 SELECT "dm_dim_documents"."id",
    ((((("dm_dim_documents"."store-protocol")::"text" || '://'::"text") || ("dm_dim_documents"."store-identifier")::"text") || '/'::"text") || ("dm_dim_documents"."node-uuid")::"text") AS "noderef",
    "dm_dim_documents"."name",
    "dm_dim_documents"."path",
    "dm_dim_documents"."alfresco_id",
    "dm_dim_documents"."src_id"
   FROM "dm_dim_documents";


ALTER TABLE "vw_dm_dim_documents" OWNER TO "postgres";

--
-- TOC entry 231 (class 1259 OID 16637)
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


ALTER TABLE "vw_dm_dim_minutes" OWNER TO "postgres";

--
-- TOC entry 232 (class 1259 OID 16641)
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


ALTER TABLE "vw_dm_fact_documents" OWNER TO "postgres";

--
-- TOC entry 233 (class 1259 OID 16645)
-- Name: vw_dm_fact_repository; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "vw_dm_fact_repository" AS
 SELECT ('DOC_'::"text" || "dm_dim_documents"."id") AS "id",
    ((((("dm_dim_documents"."store-protocol")::"text" || '://'::"text") || ("dm_dim_documents"."store-identifier")::"text") || '/'::"text") || ("dm_dim_documents"."node-uuid")::"text") AS "noderef",
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
    ((((("dm_dim_folders"."store-protocol")::"text" || '://'::"text") || ("dm_dim_folders"."store-identifier")::"text") || '/'::"text") || ("dm_dim_folders"."node-uuid")::"text") AS "noderef",
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


ALTER TABLE "vw_dm_fact_repository" OWNER TO "postgres";

--
-- TOC entry 234 (class 1259 OID 16650)
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


ALTER TABLE "vw_dm_min_max_date" OWNER TO "postgres";

--
-- TOC entry 228 (class 1259 OID 16625)
-- Name: vw_rest_documents_and_folders_path; Type: VIEW; Schema: public; Owner: postgres
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


ALTER TABLE "vw_rest_documents_and_folders_path" OWNER TO "postgres";

--
-- TOC entry 2546 (class 0 OID 16388)
-- Dependencies: 182
-- Data for Name: dm_custom_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2593 (class 0 OID 17467)
-- Dependencies: 236
-- Data for Name: dm_data_quality; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2548 (class 0 OID 16401)
-- Dependencies: 184
-- Data for Name: dm_dim_actions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2549 (class 0 OID 16405)
-- Dependencies: 185
-- Data for Name: dm_dim_alfresco; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dm_dim_alfresco" ("id", "desc", "login", "password", "url", "url_audit_suffix", "audit_limit", "url_nodes_modified_after_suffix", "url_nodes_modified_before_suffix", "node_limit", "url_cmis_suffix", "url_workflow_definitions_suffix", "url_workflow_instances_suffix", "is_active") VALUES (1, 'Default Alfresco instance', 'admin', 'admin', 'http://localhost:8080', '/alfresco/service/api/audit/query/alfresco-access?verbose=true', 50000, '/alfresco/service/AAAR/getNodesModifiedAfter', '/alfresco/service/AAAR/getNodeIdsModifiedBefore', 50000, '/alfresco/api/-default-/cmis/versions/1.1/atom', '/alfresco/service/api/workflow-definitions', '/alfresco/service/api/workflow-instances', 'Y');


--
-- TOC entry 2550 (class 0 OID 16412)
-- Dependencies: 186
-- Data for Name: dm_dim_dates; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2552 (class 0 OID 16417)
-- Dependencies: 188
-- Data for Name: dm_dim_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2554 (class 0 OID 16426)
-- Dependencies: 190
-- Data for Name: dm_dim_folders; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2555 (class 0 OID 16433)
-- Dependencies: 191
-- Data for Name: dm_dim_hours; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2557 (class 0 OID 16438)
-- Dependencies: 193
-- Data for Name: dm_dim_mime_types; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2558 (class 0 OID 16445)
-- Dependencies: 194
-- Data for Name: dm_dim_minutes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2559 (class 0 OID 16448)
-- Dependencies: 195
-- Data for Name: dm_dim_months; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2561 (class 0 OID 16453)
-- Dependencies: 197
-- Data for Name: dm_dim_node_types; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2563 (class 0 OID 16462)
-- Dependencies: 199
-- Data for Name: dm_dim_paths; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2565 (class 0 OID 16471)
-- Dependencies: 201
-- Data for Name: dm_dim_users; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2567 (class 0 OID 16480)
-- Dependencies: 203
-- Data for Name: dm_dim_workflow_definitions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2569 (class 0 OID 16489)
-- Dependencies: 205
-- Data for Name: dm_dim_workflow_instances; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2570 (class 0 OID 16496)
-- Dependencies: 206
-- Data for Name: dm_dim_workflow_items; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2572 (class 0 OID 16501)
-- Dependencies: 208
-- Data for Name: dm_dim_workflow_tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2573 (class 0 OID 16508)
-- Dependencies: 209
-- Data for Name: dm_dim_years; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2574 (class 0 OID 16514)
-- Dependencies: 210
-- Data for Name: dm_fact_actions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2592 (class 0 OID 17459)
-- Dependencies: 235
-- Data for Name: dm_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2575 (class 0 OID 16517)
-- Dependencies: 211
-- Data for Name: dm_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (5, 'http://localhost:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'audit_use.prpt', 'audit_use.pdf', 'localhost', 121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (6, 'http://localhost:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'document_active_users.prpt', 'document_active_users.pdf', 'localhost', 121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (7, 'http://localhost:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'document_hours_of_activity.prpt', 'document_hours_of_activity.pdf', 'localhost', 121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (8, 'http://localhost:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'document_mime_types.prpt', 'document_mime_types.pdf', 'localhost', 121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (9, 'http://localhost:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'document_size.prpt', 'document_size.pdf', 'localhost', 121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (10, 'http://localhost:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'document_types.prpt', 'document_types.pdf', 'localhost', 121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (11, 'http://localhost:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'folder_types.prpt', 'folder_types.pdf', 'localhost', 121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (1, 'http://localhost:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'audit_creation.prpt', 'audit_creation.pdf', 'localhost', 121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (2, 'http://localhost:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'audit_details.prpt', 'audit_details.pdf', 'localhost', 121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (3, 'http://localhost:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'audit_login.prpt', 'audit_login.pdf', 'localhost', 121, 'admin', 'admin', 'alfresco', 'Y');
INSERT INTO "dm_reports" ("id", "pentaho_url", "pentaho_login", "pentaho_password", "pentaho_path", "prpt_name", "name", "alfresco_ftp", "alfresco_port", "alfresco_login", "alfresco_password", "alfresco_path", "is_active") VALUES (4, 'http://localhost:8080/pentaho', 'admin', 'password', '/public/AAAR/Reports', 'audit_topTen.prpt', 'audit_topTen.pdf', 'localhost', 121, 'admin', 'admin', 'alfresco', 'Y');


--
-- TOC entry 2576 (class 0 OID 16529)
-- Dependencies: 212
-- Data for Name: log_channels; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2577 (class 0 OID 16535)
-- Dependencies: 213
-- Data for Name: log_job; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2578 (class 0 OID 16541)
-- Dependencies: 214
-- Data for Name: log_jobentry; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2579 (class 0 OID 16547)
-- Dependencies: 215
-- Data for Name: log_performance; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2580 (class 0 OID 16553)
-- Dependencies: 216
-- Data for Name: log_step; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2581 (class 0 OID 16559)
-- Dependencies: 217
-- Data for Name: log_transformations; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2582 (class 0 OID 16565)
-- Dependencies: 218
-- Data for Name: ope_audits; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2602 (class 0 OID 0)
-- Dependencies: 181
-- Name: seq_dm_custom_metadata_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_custom_metadata_id"', 1, false);


--
-- TOC entry 2603 (class 0 OID 0)
-- Dependencies: 183
-- Name: seq_dm_dim_actions_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_dim_actions_id"', 1, true);


--
-- TOC entry 2604 (class 0 OID 0)
-- Dependencies: 187
-- Name: seq_dm_dim_documents_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_dim_documents_id"', 1, true);


--
-- TOC entry 2605 (class 0 OID 0)
-- Dependencies: 189
-- Name: seq_dm_dim_folders_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_dim_folders_id"', 1, true);


--
-- TOC entry 2606 (class 0 OID 0)
-- Dependencies: 192
-- Name: seq_dm_dim_mime_types_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_dim_mime_types_id"', 1, true);


--
-- TOC entry 2607 (class 0 OID 0)
-- Dependencies: 196
-- Name: seq_dm_dim_node_types_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_dim_node_types_id"', 1, true);


--
-- TOC entry 2608 (class 0 OID 0)
-- Dependencies: 198
-- Name: seq_dm_dim_paths_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_dim_paths_id"', 1, true);


--
-- TOC entry 2609 (class 0 OID 0)
-- Dependencies: 200
-- Name: seq_dm_dim_users_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_dim_users_id"', 1, true);


--
-- TOC entry 2610 (class 0 OID 0)
-- Dependencies: 202
-- Name: seq_dm_dim_workflow_definitions_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_dim_workflow_definitions_id"', 1, true);


--
-- TOC entry 2611 (class 0 OID 0)
-- Dependencies: 204
-- Name: seq_dm_dim_workflow_instances_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_dim_workflow_instances_id"', 1, true);


--
-- TOC entry 2612 (class 0 OID 0)
-- Dependencies: 207
-- Name: seq_dm_dim_workflow_tasks_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"seq_dm_dim_workflow_tasks_id"', 1, true);


--
-- TOC entry 2583 (class 0 OID 16571)
-- Dependencies: 219
-- Data for Name: stg_audits; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2584 (class 0 OID 16577)
-- Dependencies: 220
-- Data for Name: stg_rest_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2585 (class 0 OID 16583)
-- Dependencies: 221
-- Data for Name: stg_rest_documents_custom_types; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2586 (class 0 OID 16589)
-- Dependencies: 222
-- Data for Name: stg_rest_folders; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2587 (class 0 OID 16595)
-- Dependencies: 223
-- Data for Name: stg_rest_folders_custom_types; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2588 (class 0 OID 16601)
-- Dependencies: 224
-- Data for Name: stg_workflow_definitions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2589 (class 0 OID 16607)
-- Dependencies: 225
-- Data for Name: stg_workflow_instances; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2590 (class 0 OID 16613)
-- Dependencies: 226
-- Data for Name: stg_workflow_items; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2591 (class 0 OID 16619)
-- Dependencies: 227
-- Data for Name: stg_workflow_tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2269 (class 2606 OID 16656)
-- Name: pk_dm_custom_metadata; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_custom_metadata"
    ADD CONSTRAINT "pk_dm_custom_metadata" PRIMARY KEY ("id");


--
-- TOC entry 2274 (class 2606 OID 16660)
-- Name: pk_dm_dim_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_actions"
    ADD CONSTRAINT "pk_dm_dim_action" PRIMARY KEY ("id");


--
-- TOC entry 2280 (class 2606 OID 16662)
-- Name: pk_dm_dim_dates; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_dates"
    ADD CONSTRAINT "pk_dm_dim_dates" PRIMARY KEY ("id");


--
-- TOC entry 2285 (class 2606 OID 16664)
-- Name: pk_dm_dim_documents; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "pk_dm_dim_documents" PRIMARY KEY ("id");


--
-- TOC entry 2292 (class 2606 OID 16666)
-- Name: pk_dm_dim_folders; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "pk_dm_dim_folders" PRIMARY KEY ("id");


--
-- TOC entry 2297 (class 2606 OID 16668)
-- Name: pk_dm_dim_hours; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_hours"
    ADD CONSTRAINT "pk_dm_dim_hours" PRIMARY KEY ("id");


--
-- TOC entry 2300 (class 2606 OID 16670)
-- Name: pk_dm_dim_mime_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_mime_types"
    ADD CONSTRAINT "pk_dm_dim_mime_types" PRIMARY KEY ("id");


--
-- TOC entry 2303 (class 2606 OID 16672)
-- Name: pk_dm_dim_minutes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_minutes"
    ADD CONSTRAINT "pk_dm_dim_minutes" PRIMARY KEY ("id");


--
-- TOC entry 2306 (class 2606 OID 16674)
-- Name: pk_dm_dim_months; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_months"
    ADD CONSTRAINT "pk_dm_dim_months" PRIMARY KEY ("id");


--
-- TOC entry 2309 (class 2606 OID 16676)
-- Name: pk_dm_dim_node_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_node_types"
    ADD CONSTRAINT "pk_dm_dim_node_types" PRIMARY KEY ("id");


--
-- TOC entry 2313 (class 2606 OID 16678)
-- Name: pk_dm_dim_path; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_paths"
    ADD CONSTRAINT "pk_dm_dim_path" PRIMARY KEY ("id");


--
-- TOC entry 2316 (class 2606 OID 16680)
-- Name: pk_dm_dim_users; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_users"
    ADD CONSTRAINT "pk_dm_dim_users" PRIMARY KEY ("id");


--
-- TOC entry 2319 (class 2606 OID 16682)
-- Name: pk_dm_dim_workflow_definitions; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_definitions"
    ADD CONSTRAINT "pk_dm_dim_workflow_definitions" PRIMARY KEY ("id");


--
-- TOC entry 2322 (class 2606 OID 16684)
-- Name: pk_dm_dim_workflow_instances; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_instances"
    ADD CONSTRAINT "pk_dm_dim_workflow_instances" PRIMARY KEY ("id");


--
-- TOC entry 2325 (class 2606 OID 16686)
-- Name: pk_dm_dim_workflow_items; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_items"
    ADD CONSTRAINT "pk_dm_dim_workflow_items" PRIMARY KEY ("alfresco_id", "workflow_instance_id", "ordinal");


--
-- TOC entry 2328 (class 2606 OID 16688)
-- Name: pk_dm_dim_workflow_tasks; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_tasks"
    ADD CONSTRAINT "pk_dm_dim_workflow_tasks" PRIMARY KEY ("id");


--
-- TOC entry 2331 (class 2606 OID 16690)
-- Name: pk_dm_dim_years; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_years"
    ADD CONSTRAINT "pk_dm_dim_years" PRIMARY KEY ("id");


--
-- TOC entry 2333 (class 2606 OID 16692)
-- Name: pk_reports; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_reports"
    ADD CONSTRAINT "pk_reports" PRIMARY KEY ("id");


--
-- TOC entry 2277 (class 2606 OID 16694)
-- Name: pk_stg_alfresco; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_alfresco"
    ADD CONSTRAINT "pk_stg_alfresco" PRIMARY KEY ("id");


--
-- TOC entry 2339 (class 2606 OID 16696)
-- Name: pk_stg_audit; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_audits"
    ADD CONSTRAINT "pk_stg_audit" PRIMARY KEY ("alfresco_id", "id", "application");


--
-- TOC entry 2337 (class 2606 OID 16698)
-- Name: pk_stg_audit_extended; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ope_audits"
    ADD CONSTRAINT "pk_stg_audit_extended" PRIMARY KEY ("alfresco_id", "id", "application");


--
-- TOC entry 2347 (class 2606 OID 16700)
-- Name: pk_stg_workflow_instances; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_workflow_instances"
    ADD CONSTRAINT "pk_stg_workflow_instances" PRIMARY KEY ("alfresco_id", "id");


--
-- TOC entry 2349 (class 2606 OID 16702)
-- Name: pk_stg_workflow_packages; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_workflow_items"
    ADD CONSTRAINT "pk_stg_workflow_packages" PRIMARY KEY ("alfresco_id", "package", "item");


--
-- TOC entry 2351 (class 2606 OID 16704)
-- Name: pk_stg_workflow_tasks; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_workflow_tasks"
    ADD CONSTRAINT "pk_stg_workflow_tasks" PRIMARY KEY ("alfresco_id", "id");


--
-- TOC entry 2341 (class 2606 OID 16706)
-- Name: uni_document_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_rest_documents"
    ADD CONSTRAINT "uni_document_id" UNIQUE ("alfresco_id", "node-dbid");


--
-- TOC entry 2345 (class 2606 OID 16723)
-- Name: uni_folder_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_rest_folders"
    ADD CONSTRAINT "uni_folder_id" UNIQUE ("alfresco_id", "node-dbid");


--
-- TOC entry 2271 (class 2606 OID 16658)
-- Name: unq_dm_custom_metadata; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_custom_metadata"
    ADD CONSTRAINT "unq_dm_custom_metadata" UNIQUE ("class", "name");


--
-- TOC entry 2287 (class 2606 OID 16740)
-- Name: unq_dm_dim_documents; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "unq_dm_dim_documents" UNIQUE ("alfresco_id", "src_id");


--
-- TOC entry 2294 (class 2606 OID 16742)
-- Name: unq_dm_dim_folders; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "unq_dm_dim_folders" UNIQUE ("alfresco_id", "src_id");


--
-- TOC entry 2267 (class 1259 OID 16743)
-- Name: idx_dm_custom_metadata; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_custom_metadata" ON "dm_custom_metadata" USING "btree" ("id");


--
-- TOC entry 2272 (class 1259 OID 16744)
-- Name: idx_dm_dim_actions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_actions" ON "dm_dim_actions" USING "btree" ("id");


--
-- TOC entry 2275 (class 1259 OID 16745)
-- Name: idx_dm_dim_alfresco; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_alfresco" ON "dm_dim_alfresco" USING "btree" ("id");


--
-- TOC entry 2278 (class 1259 OID 16746)
-- Name: idx_dm_dim_dates; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_dates" ON "dm_dim_dates" USING "btree" ("id");


--
-- TOC entry 2281 (class 1259 OID 16747)
-- Name: idx_dm_dim_documents; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_documents" ON "dm_dim_documents" USING "btree" ("id");


--
-- TOC entry 2282 (class 1259 OID 16749)
-- Name: idx_dm_dim_documents_path; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_documents_path" ON "dm_dim_documents" USING "btree" ("path");


--
-- TOC entry 2283 (class 1259 OID 16748)
-- Name: idx_dm_dim_documents_src_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_documents_src_id" ON "dm_dim_documents" USING "btree" ("alfresco_id", "src_id");


--
-- TOC entry 2288 (class 1259 OID 16750)
-- Name: idx_dm_dim_folders; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_folders" ON "dm_dim_folders" USING "btree" ("id");


--
-- TOC entry 2289 (class 1259 OID 16752)
-- Name: idx_dm_dim_folders_path; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_folders_path" ON "dm_dim_folders" USING "btree" ("path");


--
-- TOC entry 2290 (class 1259 OID 16751)
-- Name: idx_dm_dim_folders_src_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_folders_src_id" ON "dm_dim_folders" USING "btree" ("alfresco_id", "src_id");


--
-- TOC entry 2295 (class 1259 OID 16753)
-- Name: idx_dm_dim_hours; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_hours" ON "dm_dim_hours" USING "btree" ("id");


--
-- TOC entry 2298 (class 1259 OID 16754)
-- Name: idx_dm_dim_mime_types; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_mime_types" ON "dm_dim_mime_types" USING "btree" ("id");


--
-- TOC entry 2301 (class 1259 OID 16755)
-- Name: idx_dm_dim_minutes; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_minutes" ON "dm_dim_minutes" USING "btree" ("id");


--
-- TOC entry 2304 (class 1259 OID 16756)
-- Name: idx_dm_dim_months; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_months" ON "dm_dim_months" USING "btree" ("id");


--
-- TOC entry 2307 (class 1259 OID 16757)
-- Name: idx_dm_dim_node_types; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_node_types" ON "dm_dim_node_types" USING "btree" ("id");


--
-- TOC entry 2310 (class 1259 OID 16758)
-- Name: idx_dm_dim_paths; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_paths" ON "dm_dim_paths" USING "btree" ("id");


--
-- TOC entry 2311 (class 1259 OID 16759)
-- Name: idx_dm_dim_paths_src_path; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_paths_src_path" ON "dm_dim_paths" USING "btree" ("src_path");


--
-- TOC entry 2314 (class 1259 OID 16760)
-- Name: idx_dm_dim_users; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_users" ON "dm_dim_users" USING "btree" ("id");


--
-- TOC entry 2317 (class 1259 OID 16761)
-- Name: idx_dm_dim_workflow_definitions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_workflow_definitions" ON "dm_dim_workflow_definitions" USING "btree" ("id");


--
-- TOC entry 2320 (class 1259 OID 16762)
-- Name: idx_dm_dim_workflow_instances; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_workflow_instances" ON "dm_dim_workflow_instances" USING "btree" ("id");


--
-- TOC entry 2323 (class 1259 OID 16763)
-- Name: idx_dm_dim_workflow_items; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_workflow_items" ON "dm_dim_workflow_items" USING "btree" ("alfresco_id", "workflow_instance_id", "ordinal");


--
-- TOC entry 2326 (class 1259 OID 16764)
-- Name: idx_dm_dim_workflow_tasks; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_workflow_tasks" ON "dm_dim_workflow_tasks" USING "btree" ("id");


--
-- TOC entry 2329 (class 1259 OID 16765)
-- Name: idx_dm_dim_years; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_dm_dim_years" ON "dm_dim_years" USING "btree" ("id");


--
-- TOC entry 2334 (class 1259 OID 16766)
-- Name: idx_log_transformations_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_log_transformations_1" ON "log_transformations" USING "btree" ("id_batch");


--
-- TOC entry 2335 (class 1259 OID 16767)
-- Name: idx_log_transformations_2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_log_transformations_2" ON "log_transformations" USING "btree" ("errors", "status", "transname");


--
-- TOC entry 2342 (class 1259 OID 17088)
-- Name: idx_stg_rest_folders_node_uuid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_stg_rest_folders_node_uuid" ON "stg_rest_folders" USING "btree" ("alfresco_id", "store-protocol", "store-identifier", "node-uuid");


--
-- TOC entry 2343 (class 1259 OID 17089)
-- Name: idx_stg_rest_folders_parent_node_uuid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_stg_rest_folders_parent_node_uuid" ON "stg_rest_folders" USING "btree" ("alfresco_id", "store-protocol", "store-identifier", "parent-node-uuid");


--
-- TOC entry 2352 (class 2606 OID 16768)
-- Name: fk_dm_custom_metadata_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_custom_metadata"
    ADD CONSTRAINT "fk_dm_custom_metadata_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2423 (class 2606 OID 17471)
-- Name: fk_dm_data_quality_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_data_quality"
    ADD CONSTRAINT "fk_dm_data_quality_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2353 (class 2606 OID 16773)
-- Name: fk_dm_dim_action_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_actions"
    ADD CONSTRAINT "fk_dm_dim_action_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2354 (class 2606 OID 16778)
-- Name: fk_dm_dim_dates_dm_dim_months; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_dates"
    ADD CONSTRAINT "fk_dm_dim_dates_dm_dim_months" FOREIGN KEY ("month_id") REFERENCES "dm_dim_months"("id");


--
-- TOC entry 2355 (class 2606 OID 16783)
-- Name: fk_dm_dim_documents_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "fk_dm_dim_documents_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2356 (class 2606 OID 16788)
-- Name: fk_dm_dim_documents_dm_dim_dates_creation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "fk_dm_dim_documents_dm_dim_dates_creation" FOREIGN KEY ("creation_date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2357 (class 2606 OID 16793)
-- Name: fk_dm_dim_documents_dm_dim_dates_last_modification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "fk_dm_dim_documents_dm_dim_dates_last_modification" FOREIGN KEY ("last_modification_date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2358 (class 2606 OID 16798)
-- Name: fk_dm_dim_documents_dm_dim_folders_parent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "fk_dm_dim_documents_dm_dim_folders_parent" FOREIGN KEY ("parent_id") REFERENCES "dm_dim_folders"("id");


--
-- TOC entry 2359 (class 2606 OID 16803)
-- Name: fk_dm_dim_documents_dm_dim_mime_types; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "fk_dm_dim_documents_dm_dim_mime_types" FOREIGN KEY ("mime_type_id") REFERENCES "dm_dim_mime_types"("id");


--
-- TOC entry 2360 (class 2606 OID 16808)
-- Name: fk_dm_dim_documents_dm_dim_minutes_creation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "fk_dm_dim_documents_dm_dim_minutes_creation" FOREIGN KEY ("creation_minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2361 (class 2606 OID 16813)
-- Name: fk_dm_dim_documents_dm_dim_minutes_last_modification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "fk_dm_dim_documents_dm_dim_minutes_last_modification" FOREIGN KEY ("last_modification_minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2362 (class 2606 OID 16818)
-- Name: fk_dm_dim_documents_dm_dim_node_types; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "fk_dm_dim_documents_dm_dim_node_types" FOREIGN KEY ("node_type_id") REFERENCES "dm_dim_node_types"("id");


--
-- TOC entry 2363 (class 2606 OID 16823)
-- Name: fk_dm_dim_documents_dm_dim_users_creator; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "fk_dm_dim_documents_dm_dim_users_creator" FOREIGN KEY ("user_creator_id") REFERENCES "dm_dim_users"("id");


--
-- TOC entry 2364 (class 2606 OID 16828)
-- Name: fk_dm_dim_documents_dm_dim_users_last_modifier; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_documents"
    ADD CONSTRAINT "fk_dm_dim_documents_dm_dim_users_last_modifier" FOREIGN KEY ("user_last_modifier_id") REFERENCES "dm_dim_users"("id");


--
-- TOC entry 2365 (class 2606 OID 16833)
-- Name: fk_dm_dim_folders_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "fk_dm_dim_folders_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2366 (class 2606 OID 16838)
-- Name: fk_dm_dim_folders_dm_dim_dates_creation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "fk_dm_dim_folders_dm_dim_dates_creation" FOREIGN KEY ("creation_date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2367 (class 2606 OID 16843)
-- Name: fk_dm_dim_folders_dm_dim_dates_last_modification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "fk_dm_dim_folders_dm_dim_dates_last_modification" FOREIGN KEY ("last_modification_date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2368 (class 2606 OID 16848)
-- Name: fk_dm_dim_folders_dm_dim_folders_aprent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "fk_dm_dim_folders_dm_dim_folders_aprent" FOREIGN KEY ("parent_id") REFERENCES "dm_dim_folders"("id");


--
-- TOC entry 2369 (class 2606 OID 16853)
-- Name: fk_dm_dim_folders_dm_dim_minutes_creation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "fk_dm_dim_folders_dm_dim_minutes_creation" FOREIGN KEY ("creation_minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2370 (class 2606 OID 16858)
-- Name: fk_dm_dim_folders_dm_dim_minutes_last_modification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "fk_dm_dim_folders_dm_dim_minutes_last_modification" FOREIGN KEY ("last_modification_minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2371 (class 2606 OID 16863)
-- Name: fk_dm_dim_folders_dm_dim_node_types; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "fk_dm_dim_folders_dm_dim_node_types" FOREIGN KEY ("node_type_id") REFERENCES "dm_dim_node_types"("id");


--
-- TOC entry 2372 (class 2606 OID 16868)
-- Name: fk_dm_dim_folders_dm_dim_users_creator; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "fk_dm_dim_folders_dm_dim_users_creator" FOREIGN KEY ("user_creator_id") REFERENCES "dm_dim_users"("id");


--
-- TOC entry 2373 (class 2606 OID 16873)
-- Name: fk_dm_dim_folders_dm_dim_users_last_modifier; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_folders"
    ADD CONSTRAINT "fk_dm_dim_folders_dm_dim_users_last_modifier" FOREIGN KEY ("user_last_modifier_id") REFERENCES "dm_dim_users"("id");


--
-- TOC entry 2374 (class 2606 OID 16878)
-- Name: fk_dm_dim_mime_types_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_mime_types"
    ADD CONSTRAINT "fk_dm_dim_mime_types_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2375 (class 2606 OID 16883)
-- Name: fk_dm_dim_minutes_dm_dim_hours; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_minutes"
    ADD CONSTRAINT "fk_dm_dim_minutes_dm_dim_hours" FOREIGN KEY ("hour_id") REFERENCES "dm_dim_hours"("id");


--
-- TOC entry 2376 (class 2606 OID 16888)
-- Name: fk_dm_dim_months_dm_dim_years; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_months"
    ADD CONSTRAINT "fk_dm_dim_months_dm_dim_years" FOREIGN KEY ("year_id") REFERENCES "dm_dim_years"("id");


--
-- TOC entry 2377 (class 2606 OID 16893)
-- Name: fk_dm_dim_node_types_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_node_types"
    ADD CONSTRAINT "fk_dm_dim_node_types_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2378 (class 2606 OID 16898)
-- Name: fk_dm_dim_path_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_paths"
    ADD CONSTRAINT "fk_dm_dim_path_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2379 (class 2606 OID 17476)
-- Name: fk_dm_dim_paths_dm_dim_documents; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_paths"
    ADD CONSTRAINT "fk_dm_dim_paths_dm_dim_documents" FOREIGN KEY ("document_id") REFERENCES "dm_dim_documents"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2380 (class 2606 OID 17481)
-- Name: fk_dm_dim_paths_dm_dim_folders; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_paths"
    ADD CONSTRAINT "fk_dm_dim_paths_dm_dim_folders" FOREIGN KEY ("folder_id") REFERENCES "dm_dim_folders"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2381 (class 2606 OID 16913)
-- Name: fk_dm_dim_users_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_users"
    ADD CONSTRAINT "fk_dm_dim_users_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2382 (class 2606 OID 16918)
-- Name: fk_dm_dim_workflow_definitions_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_definitions"
    ADD CONSTRAINT "fk_dm_dim_workflow_definitions_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2383 (class 2606 OID 16923)
-- Name: fk_dm_dim_workflow_instances_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_instances"
    ADD CONSTRAINT "fk_dm_dim_workflow_instances_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2384 (class 2606 OID 16928)
-- Name: fk_dm_dim_workflow_instances_dm_dim_dates_due; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_instances"
    ADD CONSTRAINT "fk_dm_dim_workflow_instances_dm_dim_dates_due" FOREIGN KEY ("due_date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2385 (class 2606 OID 16933)
-- Name: fk_dm_dim_workflow_instances_dm_dim_dates_end; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_instances"
    ADD CONSTRAINT "fk_dm_dim_workflow_instances_dm_dim_dates_end" FOREIGN KEY ("end_date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2386 (class 2606 OID 16938)
-- Name: fk_dm_dim_workflow_instances_dm_dim_dates_start; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_instances"
    ADD CONSTRAINT "fk_dm_dim_workflow_instances_dm_dim_dates_start" FOREIGN KEY ("start_date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2387 (class 2606 OID 16943)
-- Name: fk_dm_dim_workflow_instances_dm_dim_minutes_due; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_instances"
    ADD CONSTRAINT "fk_dm_dim_workflow_instances_dm_dim_minutes_due" FOREIGN KEY ("due_minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2388 (class 2606 OID 16948)
-- Name: fk_dm_dim_workflow_instances_dm_dim_minutes_end; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_instances"
    ADD CONSTRAINT "fk_dm_dim_workflow_instances_dm_dim_minutes_end" FOREIGN KEY ("end_minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2389 (class 2606 OID 16953)
-- Name: fk_dm_dim_workflow_instances_dm_dim_minutes_start; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_instances"
    ADD CONSTRAINT "fk_dm_dim_workflow_instances_dm_dim_minutes_start" FOREIGN KEY ("start_minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2390 (class 2606 OID 16958)
-- Name: fk_dm_dim_workflow_instances_dm_dim_users; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_instances"
    ADD CONSTRAINT "fk_dm_dim_workflow_instances_dm_dim_users" FOREIGN KEY ("initiator_id") REFERENCES "dm_dim_users"("id");


--
-- TOC entry 2391 (class 2606 OID 16963)
-- Name: fk_dm_dim_workflow_instances_dm_dim_workflow_definitions; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_instances"
    ADD CONSTRAINT "fk_dm_dim_workflow_instances_dm_dim_workflow_definitions" FOREIGN KEY ("definition_id") REFERENCES "dm_dim_workflow_definitions"("id");


--
-- TOC entry 2392 (class 2606 OID 16968)
-- Name: fk_dm_dim_workflow_items_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_items"
    ADD CONSTRAINT "fk_dm_dim_workflow_items_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2393 (class 2606 OID 16973)
-- Name: fk_dm_dim_workflow_items_dm_dim_documents; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_items"
    ADD CONSTRAINT "fk_dm_dim_workflow_items_dm_dim_documents" FOREIGN KEY ("document_id") REFERENCES "dm_dim_documents"("id");


--
-- TOC entry 2394 (class 2606 OID 16978)
-- Name: fk_dm_dim_workflow_items_dm_dim_workflow_instances; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_items"
    ADD CONSTRAINT "fk_dm_dim_workflow_items_dm_dim_workflow_instances" FOREIGN KEY ("workflow_instance_id") REFERENCES "dm_dim_workflow_instances"("id");


--
-- TOC entry 2395 (class 2606 OID 16983)
-- Name: fk_dm_dim_workflow_tasks_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_tasks"
    ADD CONSTRAINT "fk_dm_dim_workflow_tasks_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2396 (class 2606 OID 16988)
-- Name: fk_dm_dim_workflow_tasks_dm_dim_dates_completion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_tasks"
    ADD CONSTRAINT "fk_dm_dim_workflow_tasks_dm_dim_dates_completion" FOREIGN KEY ("completion_date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2397 (class 2606 OID 16993)
-- Name: fk_dm_dim_workflow_tasks_dm_dim_dates_due; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_tasks"
    ADD CONSTRAINT "fk_dm_dim_workflow_tasks_dm_dim_dates_due" FOREIGN KEY ("due_date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2398 (class 2606 OID 16998)
-- Name: fk_dm_dim_workflow_tasks_dm_dim_dates_start; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_tasks"
    ADD CONSTRAINT "fk_dm_dim_workflow_tasks_dm_dim_dates_start" FOREIGN KEY ("start_date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2399 (class 2606 OID 17003)
-- Name: fk_dm_dim_workflow_tasks_dm_dim_minutes_completion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_tasks"
    ADD CONSTRAINT "fk_dm_dim_workflow_tasks_dm_dim_minutes_completion" FOREIGN KEY ("completion_minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2400 (class 2606 OID 17008)
-- Name: fk_dm_dim_workflow_tasks_dm_dim_minutes_due; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_tasks"
    ADD CONSTRAINT "fk_dm_dim_workflow_tasks_dm_dim_minutes_due" FOREIGN KEY ("due_minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2401 (class 2606 OID 17013)
-- Name: fk_dm_dim_workflow_tasks_dm_dim_minutes_start; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_tasks"
    ADD CONSTRAINT "fk_dm_dim_workflow_tasks_dm_dim_minutes_start" FOREIGN KEY ("start_minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2402 (class 2606 OID 17018)
-- Name: fk_dm_dim_workflow_tasks_dm_dim_users; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_tasks"
    ADD CONSTRAINT "fk_dm_dim_workflow_tasks_dm_dim_users" FOREIGN KEY ("owner_id") REFERENCES "dm_dim_users"("id");


--
-- TOC entry 2403 (class 2606 OID 17023)
-- Name: fk_dm_dim_workflow_tasks_dm_dim_workflow_instances; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_dim_workflow_tasks"
    ADD CONSTRAINT "fk_dm_dim_workflow_tasks_dm_dim_workflow_instances" FOREIGN KEY ("instance_id") REFERENCES "dm_dim_workflow_instances"("id");


--
-- TOC entry 2404 (class 2606 OID 17028)
-- Name: fk_dm_fact_actions_dm_dim_actions; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_fact_actions"
    ADD CONSTRAINT "fk_dm_fact_actions_dm_dim_actions" FOREIGN KEY ("action_id") REFERENCES "dm_dim_actions"("id");


--
-- TOC entry 2405 (class 2606 OID 17033)
-- Name: fk_dm_fact_actions_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_fact_actions"
    ADD CONSTRAINT "fk_dm_fact_actions_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2406 (class 2606 OID 17038)
-- Name: fk_dm_fact_actions_dm_dim_dates; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_fact_actions"
    ADD CONSTRAINT "fk_dm_fact_actions_dm_dim_dates" FOREIGN KEY ("date_id") REFERENCES "dm_dim_dates"("id");


--
-- TOC entry 2407 (class 2606 OID 17043)
-- Name: fk_dm_fact_actions_dm_dim_minutes; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_fact_actions"
    ADD CONSTRAINT "fk_dm_fact_actions_dm_dim_minutes" FOREIGN KEY ("minute_id") REFERENCES "dm_dim_minutes"("id");


--
-- TOC entry 2408 (class 2606 OID 17048)
-- Name: fk_dm_fact_actions_dm_dim_paths; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_fact_actions"
    ADD CONSTRAINT "fk_dm_fact_actions_dm_dim_paths" FOREIGN KEY ("path_id") REFERENCES "dm_dim_paths"("id");


--
-- TOC entry 2409 (class 2606 OID 17053)
-- Name: fk_dm_fact_actions_dm_dim_users; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_fact_actions"
    ADD CONSTRAINT "fk_dm_fact_actions_dm_dim_users" FOREIGN KEY ("user_id") REFERENCES "dm_dim_users"("id");


--
-- TOC entry 2422 (class 2606 OID 17462)
-- Name: fk_dm_logs_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "dm_logs"
    ADD CONSTRAINT "fk_dm_logs_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2411 (class 2606 OID 17058)
-- Name: fk_stg_audit_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_audits"
    ADD CONSTRAINT "fk_stg_audit_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2410 (class 2606 OID 17063)
-- Name: fk_stg_audit_extended_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ope_audits"
    ADD CONSTRAINT "fk_stg_audit_extended_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2413 (class 2606 OID 16712)
-- Name: fk_stg_rest_documents_custom_types_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_rest_documents_custom_types"
    ADD CONSTRAINT "fk_stg_rest_documents_custom_types_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2414 (class 2606 OID 16717)
-- Name: fk_stg_rest_documents_custom_types_stg_rest_documents; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_rest_documents_custom_types"
    ADD CONSTRAINT "fk_stg_rest_documents_custom_types_stg_rest_documents" FOREIGN KEY ("alfresco_id", "node-dbid") REFERENCES "stg_rest_documents"("alfresco_id", "node-dbid");


--
-- TOC entry 2412 (class 2606 OID 16707)
-- Name: fk_stg_rest_documents_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_rest_documents"
    ADD CONSTRAINT "fk_stg_rest_documents_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2416 (class 2606 OID 16729)
-- Name: fk_stg_rest_folders_custom_types_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_rest_folders_custom_types"
    ADD CONSTRAINT "fk_stg_rest_folders_custom_types_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2417 (class 2606 OID 16734)
-- Name: fk_stg_rest_folders_custom_types_stg_rest_folders; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_rest_folders_custom_types"
    ADD CONSTRAINT "fk_stg_rest_folders_custom_types_stg_rest_folders" FOREIGN KEY ("alfresco_id", "node-dbid") REFERENCES "stg_rest_folders"("alfresco_id", "node-dbid");


--
-- TOC entry 2415 (class 2606 OID 16724)
-- Name: fk_stg_rest_folders_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_rest_folders"
    ADD CONSTRAINT "fk_stg_rest_folders_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2418 (class 2606 OID 17068)
-- Name: fk_stg_workflow_definitions_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_workflow_definitions"
    ADD CONSTRAINT "fk_stg_workflow_definitions_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2419 (class 2606 OID 17073)
-- Name: fk_stg_workflow_instances_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_workflow_instances"
    ADD CONSTRAINT "fk_stg_workflow_instances_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2420 (class 2606 OID 17078)
-- Name: fk_stg_workflow_packages_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_workflow_items"
    ADD CONSTRAINT "fk_stg_workflow_packages_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2421 (class 2606 OID 17083)
-- Name: fk_stg_workflow_tasks_dm_dim_alfresco; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "stg_workflow_tasks"
    ADD CONSTRAINT "fk_stg_workflow_tasks_dm_dim_alfresco" FOREIGN KEY ("alfresco_id") REFERENCES "dm_dim_alfresco"("id");


--
-- TOC entry 2600 (class 0 OID 0)
-- Dependencies: 7
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA "public" FROM PUBLIC;
REVOKE ALL ON SCHEMA "public" FROM "postgres";
GRANT ALL ON SCHEMA "public" TO "postgres";
GRANT ALL ON SCHEMA "public" TO PUBLIC;


-- Completed on 2016-05-07 22:57:18 CEST

--
-- PostgreSQL database dump complete
--

