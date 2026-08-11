--
-- PostgreSQL database dump
--

\restrict zLrWw6xeGASwv9J5ueyG1cGV3RZtLDlVvHgxwZQQV7edZyPzFSEzdPFe0BnygAQ

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ai_command_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ai_command_history (
    id integer NOT NULL,
    command_text text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.ai_command_history OWNER TO postgres;

--
-- Name: ai_command_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ai_command_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ai_command_history_id_seq OWNER TO postgres;

--
-- Name: ai_command_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ai_command_history_id_seq OWNED BY public.ai_command_history.id;


--
-- Name: flow_master; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flow_master (
    flow_id integer NOT NULL,
    flow_name character varying(100) NOT NULL,
    description character varying(500),
    module character varying(50),
    status character varying(20) DEFAULT 'Draft'::character varying,
    created_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.flow_master OWNER TO postgres;

--
-- Name: flow_master_flow_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flow_master_flow_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.flow_master_flow_id_seq OWNER TO postgres;

--
-- Name: flow_master_flow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.flow_master_flow_id_seq OWNED BY public.flow_master.flow_id;


--
-- Name: flow_steps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flow_steps (
    step_id integer NOT NULL,
    flow_id integer NOT NULL,
    sequence_no integer NOT NULL,
    transaction_code character varying(20) NOT NULL,
    description character varying(255),
    created_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.flow_steps OWNER TO postgres;

--
-- Name: flow_steps_step_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flow_steps_step_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.flow_steps_step_id_seq OWNER TO postgres;

--
-- Name: flow_steps_step_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.flow_steps_step_id_seq OWNED BY public.flow_steps.step_id;


--
-- Name: repository_assets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.repository_assets (
    asset_id integer NOT NULL,
    asset_name character varying(100) NOT NULL,
    module character varying(20) NOT NULL,
    transaction_code character varying(20),
    script_name character varying(255) NOT NULL,
    description character varying(500),
    status character varying(20) DEFAULT 'Active'::character varying,
    created_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.repository_assets OWNER TO postgres;

--
-- Name: repository_assets_asset_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.repository_assets_asset_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.repository_assets_asset_id_seq OWNER TO postgres;

--
-- Name: repository_assets_asset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.repository_assets_asset_id_seq OWNED BY public.repository_assets.asset_id;


--
-- Name: sap_process_library; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sap_process_library (
    process_id integer NOT NULL,
    process_name character varying(100) NOT NULL,
    module character varying(20) NOT NULL,
    flow_type character varying(30) NOT NULL,
    description character varying(500),
    status character varying(20) DEFAULT 'Active'::character varying
);


ALTER TABLE public.sap_process_library OWNER TO postgres;

--
-- Name: sap_process_library_process_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sap_process_library_process_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sap_process_library_process_id_seq OWNER TO postgres;

--
-- Name: sap_process_library_process_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sap_process_library_process_id_seq OWNED BY public.sap_process_library.process_id;


--
-- Name: sap_process_steps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sap_process_steps (
    process_step_id integer NOT NULL,
    process_id integer NOT NULL,
    sequence_no integer NOT NULL,
    transaction_code character varying(20) NOT NULL,
    step_name character varying(200) NOT NULL,
    description character varying(500)
);


ALTER TABLE public.sap_process_steps OWNER TO postgres;

--
-- Name: sap_process_steps_process_step_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sap_process_steps_process_step_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sap_process_steps_process_step_id_seq OWNER TO postgres;

--
-- Name: sap_process_steps_process_step_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sap_process_steps_process_step_id_seq OWNED BY public.sap_process_steps.process_step_id;


--
-- Name: script_master; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.script_master (
    script_id integer NOT NULL,
    script_name character varying(255) NOT NULL,
    description text,
    module character varying(50),
    version integer DEFAULT 1,
    status character varying(20) DEFAULT 'Draft'::character varying,
    created_by character varying(100),
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    transaction_code character varying(20),
    flow_id integer
);


ALTER TABLE public.script_master OWNER TO postgres;

--
-- Name: script_master_script_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.script_master_script_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.script_master_script_id_seq OWNER TO postgres;

--
-- Name: script_master_script_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.script_master_script_id_seq OWNED BY public.script_master.script_id;


--
-- Name: script_steps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.script_steps (
    id integer NOT NULL,
    script_id character varying(20),
    step_sequence integer,
    action_type character varying(50),
    parameter_name character varying(100),
    parameter_value character varying(500)
);


ALTER TABLE public.script_steps OWNER TO postgres;

--
-- Name: script_steps_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.script_steps_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.script_steps_id_seq OWNER TO postgres;

--
-- Name: script_steps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.script_steps_id_seq OWNED BY public.script_steps.id;


--
-- Name: test_cases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_cases (
    id integer NOT NULL,
    test_case_id character varying(100),
    title character varying(255),
    module character varying(100),
    company_code character varying(20),
    e2e_process character varying(255),
    scenario character varying(255),
    transaction_code character varying(50),
    process_step text,
    priority character varying(20),
    automation_status character varying(20),
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    script_path character varying(500),
    asset_name character varying(100)
);


ALTER TABLE public.test_cases OWNER TO postgres;

--
-- Name: test_cases_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_cases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_cases_id_seq OWNER TO postgres;

--
-- Name: test_cases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_cases_id_seq OWNED BY public.test_cases.id;


--
-- Name: test_coverage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_coverage (
    id integer NOT NULL,
    name text,
    is_multi_module boolean DEFAULT false,
    parent_id integer
);


ALTER TABLE public.test_coverage OWNER TO postgres;

--
-- Name: test_coverage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_coverage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_coverage_id_seq OWNER TO postgres;

--
-- Name: test_coverage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_coverage_id_seq OWNED BY public.test_coverage.id;


--
-- Name: test_coverage_modules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_coverage_modules (
    id integer NOT NULL,
    coverage_id integer,
    module text
);


ALTER TABLE public.test_coverage_modules OWNER TO postgres;

--
-- Name: test_coverage_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_coverage_modules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_coverage_modules_id_seq OWNER TO postgres;

--
-- Name: test_coverage_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_coverage_modules_id_seq OWNED BY public.test_coverage_modules.id;


--
-- Name: test_coverage_structure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_coverage_structure (
    id integer NOT NULL,
    module text,
    process text,
    test_type text
);


ALTER TABLE public.test_coverage_structure OWNER TO postgres;

--
-- Name: test_coverage_structure_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_coverage_structure_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_coverage_structure_id_seq OWNER TO postgres;

--
-- Name: test_coverage_structure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_coverage_structure_id_seq OWNED BY public.test_coverage_structure.id;


--
-- Name: test_coverage_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_coverage_types (
    id integer NOT NULL,
    coverage_id integer,
    test_type text
);


ALTER TABLE public.test_coverage_types OWNER TO postgres;

--
-- Name: test_coverage_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_coverage_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_coverage_types_id_seq OWNER TO postgres;

--
-- Name: test_coverage_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_coverage_types_id_seq OWNED BY public.test_coverage_types.id;


--
-- Name: test_execution_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_execution_history (
    id integer NOT NULL,
    test_id integer,
    module text,
    process text,
    test_type text,
    status text,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.test_execution_history OWNER TO postgres;

--
-- Name: test_execution_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_execution_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_execution_history_id_seq OWNER TO postgres;

--
-- Name: test_execution_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_execution_history_id_seq OWNED BY public.test_execution_history.id;


--
-- Name: test_steps_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_steps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_steps_id_seq OWNER TO postgres;

--
-- Name: test_steps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_steps (
    id bigint DEFAULT nextval('public.test_steps_id_seq'::regclass) NOT NULL,
    scenario_id text,
    transaction_code character varying(100),
    process_step text,
    test_step_name text,
    company_code text,
    module character varying(100),
    sequence integer,
    e2e_process text,
    step_description text,
    expected_result text,
    step_number integer,
    step_id integer NOT NULL,
    execution_status text
);


ALTER TABLE public.test_steps OWNER TO postgres;

--
-- Name: test_steps_step_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_steps_step_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_steps_step_id_seq OWNER TO postgres;

--
-- Name: test_steps_step_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_steps_step_id_seq OWNED BY public.test_steps.step_id;


--
-- Name: test_templates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_templates (
    id integer NOT NULL,
    module text,
    country_code text,
    test_type text,
    e2e_process text,
    scenario_id text,
    transaction_code text,
    process_step text,
    test_step_name text
);


ALTER TABLE public.test_templates OWNER TO postgres;

--
-- Name: test_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_templates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_templates_id_seq OWNER TO postgres;

--
-- Name: test_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_templates_id_seq OWNED BY public.test_templates.id;


--
-- Name: ai_command_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_command_history ALTER COLUMN id SET DEFAULT nextval('public.ai_command_history_id_seq'::regclass);


--
-- Name: flow_master flow_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flow_master ALTER COLUMN flow_id SET DEFAULT nextval('public.flow_master_flow_id_seq'::regclass);


--
-- Name: flow_steps step_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flow_steps ALTER COLUMN step_id SET DEFAULT nextval('public.flow_steps_step_id_seq'::regclass);


--
-- Name: repository_assets asset_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.repository_assets ALTER COLUMN asset_id SET DEFAULT nextval('public.repository_assets_asset_id_seq'::regclass);


--
-- Name: sap_process_library process_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sap_process_library ALTER COLUMN process_id SET DEFAULT nextval('public.sap_process_library_process_id_seq'::regclass);


--
-- Name: sap_process_steps process_step_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sap_process_steps ALTER COLUMN process_step_id SET DEFAULT nextval('public.sap_process_steps_process_step_id_seq'::regclass);


--
-- Name: script_master script_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.script_master ALTER COLUMN script_id SET DEFAULT nextval('public.script_master_script_id_seq'::regclass);


--
-- Name: script_steps id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.script_steps ALTER COLUMN id SET DEFAULT nextval('public.script_steps_id_seq'::regclass);


--
-- Name: test_cases id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_cases ALTER COLUMN id SET DEFAULT nextval('public.test_cases_id_seq'::regclass);


--
-- Name: test_coverage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_coverage ALTER COLUMN id SET DEFAULT nextval('public.test_coverage_id_seq'::regclass);


--
-- Name: test_coverage_modules id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_coverage_modules ALTER COLUMN id SET DEFAULT nextval('public.test_coverage_modules_id_seq'::regclass);


--
-- Name: test_coverage_structure id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_coverage_structure ALTER COLUMN id SET DEFAULT nextval('public.test_coverage_structure_id_seq'::regclass);


--
-- Name: test_coverage_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_coverage_types ALTER COLUMN id SET DEFAULT nextval('public.test_coverage_types_id_seq'::regclass);


--
-- Name: test_execution_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_execution_history ALTER COLUMN id SET DEFAULT nextval('public.test_execution_history_id_seq'::regclass);


--
-- Name: test_steps step_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_steps ALTER COLUMN step_id SET DEFAULT nextval('public.test_steps_step_id_seq'::regclass);


--
-- Name: test_templates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_templates ALTER COLUMN id SET DEFAULT nextval('public.test_templates_id_seq'::regclass);


--
-- Data for Name: ai_command_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ai_command_history (id, command_text, created_at) FROM stdin;
1	What Should We Automate Next?	2026-07-26 13:07:01.047541
2	Create Flow	2026-07-26 14:04:23.846418
3	Show Process Dependencies For Purchase Order\r\n\r\nBuild Test Plan For Purchase Order\r\n\r\nWhat Should We Automate Next?\r\n\r\nShow Missing Assets For Purchase Order\r\n\r\nAnalyze CO Coverage	2026-07-26 14:06:02.985341
4	Show Process Dependencies For Purchase Order\r\n\r\nBuild Test Plan For Purchase Order\r\n\r\nWhat Should We Automate Next?\r\n\r\nShow Missing Assets For Purchase Order\r\n\r\nAnalyze CO Coverage	2026-07-26 14:06:10.609465
5	Create Flow	2026-07-26 14:06:23.65521
6	Work Oder	2026-07-26 14:06:34.008454
7	\r\n1. Create repository assets\r\n2. Import automation scripts\r\n3. Record business process in Script Studio	2026-07-26 14:06:51.78496
8	\r\nCreate repository assets\r\nImport automation scripts\r\nRecord business process in Script Studio	2026-07-26 14:07:09.860971
9	Create Flow	2026-07-26 14:11:25.767204
10	Show Procure To Pay Process	2026-07-26 14:15:54.528382
11	Show Record To Report Process	2026-07-26 14:16:08.367212
12	Show Process Dependencies For Purchase Order	2026-07-26 14:17:16.316365
13	Build Test Cases For Purchase Order	2026-07-26 17:04:06.4198
14	Build Test Cases For Purchase Order	2026-07-26 17:23:08.077772
15	Build Test Cases For Sales Order	2026-07-26 17:23:43.5946
16	Build Test Cases For Work Order	2026-07-26 17:24:19.082278
17	Build Test Cases For Cost Center	2026-07-26 17:24:27.851044
18	Generate And Save Test Cases For Purchase Order	2026-07-26 17:29:42.035491
19	Generate And Save Test Cases For Purchase Order	2026-07-26 17:36:00.200752
20	Show Test Cases For Purchase Order	2026-07-26 17:36:37.506937
21	Show Test Cases For Purchase Order	2026-07-26 17:36:47.169474
22	Build Test Cases For Purchase Order	2026-07-26 17:56:41.37401
23	Build Test Cases For Purchase Order	2026-07-26 17:56:48.709767
24	Build Test Cases For Purchase Order	2026-07-26 18:00:57.668485
25	YES	2026-07-26 18:01:05.746831
26	Build Test Cases For Purchase Order	2026-07-26 18:02:23.142025
27	Build Test Cases For Cost Center	2026-07-26 18:02:50.601255
28	YES	2026-07-26 18:02:59.711615
29	Build Test Cases For Cost Center	2026-07-26 18:04:16.45811
30	YES	2026-07-26 18:04:35.771613
31	Build Test Cases For Work Order	2026-07-26 18:05:47.27831
32	YES	2026-07-26 18:06:03.442403
33	Build Test Cases For Work Order	2026-07-26 18:20:51.388061
34	Build Test Cases For Work Order	2026-07-26 18:21:05.865279
35	YES	2026-07-26 18:21:13.544773
36	Build Test Cases For Purchase Order	2026-07-26 21:30:48.846705
37	Yes	2026-07-26 21:31:00.713256
38	Build Test Cases For Purchase Order	2026-07-26 21:31:54.912604
39	YES	2026-07-26 21:32:02.146
40	Build Test Cases For Work Order	2026-07-26 21:40:51.336986
41	YES	2026-07-26 21:40:57.932078
42	Build Test Cases For Work Order	2026-07-26 21:41:39.740934
43	YES	2026-07-26 21:42:00.667071
44	Build Test Cases For Work Order	2026-07-26 21:48:52.645751
45	Yes	2026-07-26 21:48:58.598995
46	Build Test Cases For Work Order	2026-07-26 21:49:50.425004
47	Yes	2026-07-26 21:49:54.045906
48	Build Test Cases For Work Order	2026-07-28 09:10:19.681062
49	YES	2026-07-28 09:10:25.595037
50	Build Test Cases For Purchase Order	2026-07-28 09:10:35.838783
51	YES	2026-07-28 09:10:41.67625
52	Build Test Cases For Sales Order	2026-07-28 09:10:59.29675
53	YES	2026-07-28 09:11:05.619466
54	Build Test Cases For Work Order	2026-07-28 09:13:59.131407
55	YES	2026-07-28 09:14:04.847416
56	Build Test Cases For Work Order	2026-07-28 09:16:32.723581
57	YES	2026-07-28 09:16:36.817061
58	Create Flow	2026-08-06 12:28:53.327503
59	SCM	2026-08-06 12:29:07.805892
60	YES	2026-08-06 12:29:15.938767
61	YES	2026-08-06 12:29:32.165611
62	Creta flow	2026-08-08 17:01:42.473071
63	Create Flow	2026-08-08 17:01:52.956803
64	Purchase Order	2026-08-08 17:02:15.483118
65	YES	2026-08-08 17:02:21.448577
\.


--
-- Data for Name: flow_master; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flow_master (flow_id, flow_name, description, module, status, created_on) FROM stdin;
43	PROC_PO_RELEASE_SUITE	Description: Execute purchase order approval workflows and release strategies.        	PROC	Draft	2026-07-20 07:41:19.817253
44	PROC_CONTRACT_MANAGEMENT_SUITE	Description: Maintain long-term supplier contracts and procurement agreements.        	PROC	Draft	2026-07-20 07:41:39.640538
24	SD_CUSTOMER_MASTER_SUITE	Description: Manage customer master data including creation, maintenance, and display of customer records for sales processing.	SD	Draft	2026-07-19 19:04:17.570756
25	SD_INQUIRY_SUITE	Capture and manage customer inquiries regarding products, pricing, and sales opportunities.       	SD	Draft	2026-07-20 07:35:03.658601
26	SD_QUOTATION_SUITE	Description: Create and maintain sales quotations that define proposed pricing, quantities, and delivery conditions.        	SD	Draft	2026-07-20 07:35:26.202041
27	SD_SALES_ORDER_SUITE	Description: Process customer sales orders from creation through maintenance and monitoring.        	SD	Draft	2026-07-20 07:35:45.216892
28	SD_DELIVERY_SUITE	Description: Manage outbound delivery creation, shipping activities, and delivery tracking.        	SD	Draft	2026-07-20 07:36:01.225345
29	SD_BILLING_SUITE	Description: Generate customer invoices and maintain billing documents related to sales transactions.        	SD	Draft	2026-07-20 07:36:20.159635
30	SD_RETURNS_SUITE	Description: Handle customer return requests, return deliveries, and credit memo processing.        	SD	Draft	2026-07-20 07:36:42.732472
31	MM_MATERIAL_MASTER_SUITE	Description: Maintain material master records used across procurement, inventory, production, and sales processes.        	MM	Draft	2026-07-20 07:37:04.501152
32	MM_SOURCE_LIST_SUITE	Description: Define approved procurement sources and vendor-material relationships.        	MM	Draft	2026-07-20 07:37:23.517123
33	MM_PURCHASE_REQUISITION_SUITE	Description: Create and manage internal requests for purchasing goods and services.        	MM	Draft	2026-07-20 07:37:59.00126
34	MM_PURCHASE_ORDER_SUITE	Description: Manage the complete purchase order lifecycle from creation through monitoring.        	MM	Draft	2026-07-20 07:38:14.445362
35	MM_GOODS_RECEIPT_SUITE	Description: Process receipt of goods from vendors and update inventory records.        	MM	Draft	2026-07-20 07:38:32.863012
36	MM_INVOICE_VERIFICATION_SUITE	Description: Match vendor invoices against purchase orders and goods receipts.        	MM	Draft	2026-07-20 07:38:55.001852
37	PROC_VENDOR_ONBOARDING_SUITE	Description: Register, approve, and maintain vendor master data required for procurement activities.        	PROC	Draft	2026-07-20 07:39:29.494858
38	PROC_SOURCE_DETERMINATION_SUITE	Description: Identify and maintain preferred purchasing sources, contracts, and procurement agreements.        	PROC	Draft	2026-07-20 07:39:48.367102
39	PROC_PURCHASE_REQUISITION_SUITE	Description: Request goods and services through the procurement approval workflow.        	PROC	Draft	2026-07-20 07:40:05.324584
40	PROC_PR_APPROVAL_SUITE	Description: Review, approve, and release purchase requisitions according to authorization levels.        	PROC	Draft	2026-07-20 07:40:23.317224
41	PROC_RFQ_SUITE	Description: Manage the request for quotation process and vendor bidding activities.        	PROC	Draft	2026-07-20 07:40:39.633393
42	PROC_PURCHASE_ORDER_SUITE	Description: Convert approved purchasing requirements into formal purchase orders.        	PROC	Draft	2026-07-20 07:41:03.96571
45	PROC_SCHEDULING_AGREEMENT_SUITE	Description: Manage recurring procurement through scheduling agreements and delivery schedules.        	PROC	Draft	2026-07-20 07:41:56.852856
46	PROC_GOODS_RECEIPT_SUITE	Description: Verify and post receipt of procured goods and services.        	PROC	Draft	2026-07-20 07:42:34.439983
47	PROC_SERVICE_PROCUREMENT_SUITE	Description: Procure external services through service-based purchasing processes.        	PROC	Draft	2026-07-20 07:42:50.285649
48	PROC_INVOICE_VERIFICATION_SUITE	Description: Validate vendor invoices using purchase order and goods receipt matching.        	PROC	Draft	2026-07-20 07:43:07.565363
49	PROC_VENDOR_PAYMENT_SUITE	Description: Execute supplier payments and clear vendor liabilities.        	PROC	Draft	2026-07-20 07:43:23.95774
50	PROC_VENDOR_EVALUATION_SUITE	Description: Measure supplier performance using quality, cost, and delivery metrics.        	PROC	Draft	2026-07-20 07:43:42.600895
51	PROC_END_TO_END_P2P_SUITE	Description: Complete procure-to-pay process from requisition creation through vendor payment.        	PROC	Draft	2026-07-20 07:44:22.299177
52	FI_GL_ACCOUNT_SUITE	Description: Maintain general ledger accounts used for financial postings and reporting.        	FI	Draft	2026-07-20 07:44:45.953065
53	FI_VENDOR_MASTER_SUITE	Description: Manage vendor accounting data for accounts payable transactions.        	FI	Draft	2026-07-20 07:45:03.15317
54	FI_CUSTOMER_MASTER_SUITE	Description: Manage customer accounting data for accounts receivable processing.        	FI	Draft	2026-07-20 07:45:19.584311
55	FI_JOURNAL_ENTRY_SUITE	Description: Record and manage manual accounting journal entries.        	FI	Draft	2026-07-20 07:45:36.335399
56	FI_AP_SUITE	Description: Process vendor invoices, payments, and accounts payable activities.        	FI	Draft	2026-07-20 07:45:52.921592
57	FI_AR_SUITE	Description: Process customer billing, collections, and accounts receivable activities.        	FI	Draft	2026-07-20 07:46:06.529978
58	FI_ASSET_ACCOUNTING_SUITE	Description: Manage fixed asset acquisition, capitalization, depreciation, and retirement.        	FI	Draft	2026-07-20 07:46:22.036635
59	CO_COST_CENTER_SUITE	Description: Maintain organizational cost centers for planning, budgeting, and reporting purposes.        	CO	Draft	2026-07-20 07:47:00.309304
60	CO_INTERNAL_ORDER_SUITE	Description: Track costs and revenues for projects, events, and temporary business activities.       	CO	Draft	2026-07-20 07:47:23.890325
61	CO_PROFIT_CENTER_SUITE	Description: Monitor organizational profitability through profit center accounting.        	CO	Draft	2026-07-20 07:47:40.457051
62	CO_ALLOCATION_SUITE	Description: Allocate and distribute costs between business units and organizational objects.        	CO	Draft	2026-07-20 07:47:55.299073
63	LO_STOCK_TRANSFER_SUITE	Description: Transfer inventory between storage locations, plants, and distribution centers.        	LO	Draft	2026-07-20 07:48:22.522385
64	LO_INBOUND_PROCESS_SUITE	Description: Manage inbound logistics from supplier shipment to warehouse receipt.        	LO	Draft	2026-07-20 07:48:43.047883
65	LO_OUTBOUND_PROCESS_SUITE	Description: Control outbound logistics from order fulfillment through shipment execution.        	LO	Draft	2026-07-20 07:48:59.660057
66	LO_PHYSICAL_INVENTORY_SUITE	Description: Perform stock counting and inventory reconciliation activities.        	LO	Draft	2026-07-20 07:49:17.993304
67	TR_BANK_MASTER_SUITE	Description: Maintain banking structures, house banks, and financial institution master data.        	TR	Draft	2026-07-20 07:49:46.764762
68	TR_CASH_MANAGEMENT_SUITE	Description: Monitor cash positions, liquidity forecasts, and fund availability.        	TR	Draft	2026-07-20 07:50:02.359949
69	TR_PAYMENT_PROCESSING_SUITE	Description: Execute and monitor corporate payment transactions.        	TR	Draft	2026-07-20 07:50:20.372532
70	TR_BANK_RECONCILIATION_SUITE	Description: Reconcile bank statements against accounting transactions.        	TR	Draft	2026-07-20 07:50:38.491023
71	PM_NOTIFICATION_SUITE	Description: Record maintenance issues, breakdowns, and equipment-related requests.        	PM	Draft	2026-07-20 07:51:29.208961
72	PM_MAINTENANCE_ORDER_SUITE	Description: Plan, execute, and monitor maintenance activities using maintenance orders.        	PM	Draft	2026-07-20 07:51:46.824066
73	PM_PREVENTIVE_MAINTENANCE_SUITE	Description: Schedule and execute preventive maintenance activities to improve equipment reliability.        	PM	Draft	2026-07-20 07:52:05.071699
74	PM_CONFIRMATION_SUITE	Description: Confirm maintenance work completion, labor hours, and consumed resources.        	PM	Draft	2026-07-20 07:52:22.387704
75	PM_REPORTING_SUITE	Description: Confirm maintenance reporting        	PM	Draft	2026-07-20 07:52:55.162794
76	PP_BOM_SUITE	Description: Define and maintain bill of material structures used during manufacturing.        	PP	Draft	2026-07-20 07:53:45.312267
77	PP_ROUTING_SUITE	Description: Define manufacturing operations, resources, and production sequences.        	PP	Draft	2026-07-20 07:54:02.058838
78	PP_PRODUCTION_ORDER_SUITE	Description: Plan and execute manufacturing through production orders.        	PP	Draft	2026-07-20 07:54:29.044
79	PP_ORDER_CONFIRMATION_SUITE	Description: Confirm production activities and record manufacturing progress.        	PP	Draft	2026-07-20 07:54:56.306439
80	PP_MRP_SUITE	Description: Execute material requirements planning for production and procurement needs.        	PP	Draft	2026-07-20 07:55:16.328239
81	PLM_DOCUMENT_MANAGEMENT_SUITE	Description: Manage engineering documents, technical specifications, and product files.        	PLM	Draft	2026-07-20 08:42:32.199795
82	PLM_CHANGE_MASTER_SUITE	Description: Control product changes through engineering change management processes.        	PLM	Draft	2026-07-20 08:42:49.345821
83	PLM_PRODUCT_STRUCTURE_SUITE	Description: Manage product structures including materials, BOMs, and documentation.        	PLM	Draft	2026-07-20 08:43:05.476762
84	QM_INSPECTION_LOT_SUITE	Description: Create and manage inspection lots for quality validation activities.        	QM	Draft	2026-07-20 08:43:28.031232
85	QM_RESULTS_RECORDING_SUITE	Description: Record, review, and maintain inspection results and measurement data.        	QM	Draft	2026-07-20 08:43:50.49813
86	QM_USAGE_DECISION_SUITE	Description: Approve, reject, or release materials based on inspection outcomes.        	QM	Draft	2026-07-20 08:44:04.944574
87	QM_QUALITY_NOTIFICATION_SUITE	Description: Record and process quality issues, defects, and corrective actions.        	QM	Draft	2026-07-20 08:44:20.382164
88	WM_TRANSFER_ORDER_SUITE	Description: Manage internal warehouse stock movements through transfer orders.        	WM	Draft	2026-07-20 08:44:43.349478
89	WM_GOODS_RECEIPT_SUITE	Description: Receive and store inventory in designated warehouse locations.        	WM	Draft	2026-07-20 08:45:02.045351
90	WM_PICKING_SUITE	Description: Execute picking activities for outbound delivery fulfillment.        	WM	Draft	2026-07-20 08:45:15.610287
91	WM_PHYSICAL_INVENTORY_SUITE	Description: Perform warehouse inventory counting and stock reconciliation.        	WM	Draft	2026-07-20 08:45:30.365612
92	SCM_DEMAND_PLANNING_SUITE	 Description: Forecast market demand and create supply plans to meet customer requirements.       	SCM	Draft	2026-07-20 08:45:56.761259
93	SCM_SUPPLY_PLANNING_SUITE	Description: Balance supply and demand while optimizing inventory and production resources.        	SCM	Draft	2026-07-20 08:46:11.044308
94	SCM_TRANSPORTATION_SUITE	Description: Plan, execute, and monitor transportation operations and shipment movements.        	SCM	Draft	2026-07-20 08:46:24.408216
95	SCM_NETWORK_PLANNING_SUITE	Description: Optimize distribution networks, inventory positioning, and supply flows.        	SCM	Draft	2026-07-20 08:46:43.595634
96	OTC_ORDER_TO_CASH_SUITE	Description: Complete customer sales process from order creation through delivery, billing, and payment collection.        	E2E	Draft	2026-07-20 08:47:06.277851
97	P2P_PROCURE_TO_PAY_SUITE	Description: Manage maintenance work from notification creation through execution and financial settlement.        	E2E	Draft	2026-07-20 08:47:22.611413
98	PLAN_TO_PRODUCE_SUITE	Description: Execute manufacturing activities from planning through production confirmation and goods receipt.        	SCM	Draft	2026-07-20 08:47:39.579821
100	EXECUTION_ENGINE_TEST	MCSTAP Execution Test        	E2E	Draft	2026-07-21 15:19:17.878986
106	PURCHASE_ORDER_LIFECYCLE	AI Generated Flow for PURCHASE_ORDER	MM	Draft	2026-07-23 11:44:49.453227
107	COST_CENTER_LIFECYCLE	AI Generated Flow for COST_CENTER	CO	Draft	2026-07-23 11:45:33.90521
108	SALES_ORDER_PLACEHOLDER	AI Generated Placeholder Flow	SD	Draft	2026-07-23 14:09:03.522824
109	MAINTENANCE_PLAN_PLACEHOLDER	AI Generated Placeholder Flow	PM	Draft	2026-07-24 12:30:41.986324
110	PURCHASE_ORDER_LIFECYCLE	AI Generated Flow for PURCHASE_ORDER	MM	Draft	2026-07-25 11:31:10.961788
111	WORK_ORDER_PLACEHOLDER	AI Generated Placeholder Flow	PM	Draft	2026-07-25 11:45:05.806527
112	WORK_ORDER_PLACEHOLDER	AI Generated Placeholder Flow	PM	Draft	2026-07-25 15:20:31.519583
113	SALES_ORDER_PLACEHOLDER	AI Generated Placeholder Flow	SD	Draft	2026-07-25 15:38:54.115329
114	AVAILABLE_TO_PROMISE_SCM_PLACEHOLDER	AI Generated Placeholder Flow	SCM	Draft	2026-08-06 12:29:32.226315
115	PURCHASE_ORDER_LIFECYCLE	AI Generated Flow for PURCHASE_ORDER	MM	Draft	2026-08-08 17:02:21.512054
\.


--
-- Data for Name: flow_steps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flow_steps (step_id, flow_id, sequence_no, transaction_code, description, created_on) FROM stdin;
2	24	1	VD01	Create Customer	2026-07-19 19:04:53.158929
3	24	2	VD02	Change Customer	2026-07-19 19:05:13.589455
4	24	3	VD03	Display Customer	2026-07-19 19:05:32.195889
5	59	1	KS01	Create Cost Center	2026-07-20 09:46:04.154628
6	59	2	KS02	Change Cost Center	2026-07-20 09:46:29.284782
7	59	3	KS03	Display Cost Center	2026-07-20 09:46:50.183081
9	59	4	KS04	Delete Order. It can't be delete but you can suspend it.	2026-07-20 09:58:48.475719
11	62	1	HELLO	HELLO_WORLD_TEST	2026-07-20 12:56:50.517518
12	100	1	HELLO	MCSTAP Execution Test	2026-07-21 15:20:13.48989
13	62	2	DATE	date and time execution	2026-07-22 07:49:22.19312
14	100	2	DATE	Test Date and Time	2026-07-22 13:51:41.614739
30	106	1	ME21N	\N	2026-07-23 11:44:49.453227
31	106	2	ME22N	\N	2026-07-23 11:44:49.453227
32	106	3	ME23N	\N	2026-07-23 11:44:49.453227
33	107	1	KS01	\N	2026-07-23 11:45:33.90521
34	107	2	KS02	\N	2026-07-23 11:45:33.90521
35	107	3	KS03	\N	2026-07-23 11:45:33.90521
36	107	4	KS04	\N	2026-07-23 11:45:33.90521
37	108	1	VA01	\N	2026-07-23 14:09:03.522824
38	108	2	VL01N	\N	2026-07-23 14:09:03.522824
39	108	3	VL02N	\N	2026-07-23 14:09:03.522824
40	108	4	VF01	\N	2026-07-23 14:09:03.522824
41	108	5	VF03	\N	2026-07-23 14:09:03.522824
42	109	1	IP01	\N	2026-07-24 12:30:41.986324
43	109	1	IP01	\N	2026-07-24 12:30:41.986324
44	109	2	IP02	\N	2026-07-24 12:30:41.986324
45	109	2	IP02	\N	2026-07-24 12:30:41.986324
46	109	3	IP03	\N	2026-07-24 12:30:41.986324
47	109	3	IP03	\N	2026-07-24 12:30:41.986324
48	109	4	IP10	\N	2026-07-24 12:30:41.986324
49	110	1	ME21N	\N	2026-07-25 11:31:10.961788
50	110	2	ME22N	\N	2026-07-25 11:31:10.961788
51	110	3	ME23N	\N	2026-07-25 11:31:10.961788
52	111	1	IW31	\N	2026-07-25 11:45:05.806527
53	111	1	IW31	\N	2026-07-25 11:45:05.806527
54	111	2	IW32	\N	2026-07-25 11:45:05.806527
55	111	2	IW32	\N	2026-07-25 11:45:05.806527
56	111	3	IW33	\N	2026-07-25 11:45:05.806527
57	111	3	IW33	\N	2026-07-25 11:45:05.806527
58	111	4	IW38	\N	2026-07-25 11:45:05.806527
59	111	4	IW38	\N	2026-07-25 11:45:05.806527
60	112	1	IW31	\N	2026-07-25 15:20:31.519583
61	112	1	IW31	\N	2026-07-25 15:20:31.519583
62	112	2	IW32	\N	2026-07-25 15:20:31.519583
63	112	2	IW32	\N	2026-07-25 15:20:31.519583
64	112	3	IW33	\N	2026-07-25 15:20:31.519583
65	112	3	IW33	\N	2026-07-25 15:20:31.519583
66	112	4	IW38	\N	2026-07-25 15:20:31.519583
67	112	4	IW38	\N	2026-07-25 15:20:31.519583
68	113	1	VA01	\N	2026-07-25 15:38:54.115329
69	113	1	VA01	\N	2026-07-25 15:38:54.115329
70	113	1	VA01	\N	2026-07-25 15:38:54.115329
71	113	1	VA01	\N	2026-07-25 15:38:54.115329
72	113	2	VA02	\N	2026-07-25 15:38:54.115329
73	113	2	VL01N	\N	2026-07-25 15:38:54.115329
74	113	2	VL01N	\N	2026-07-25 15:38:54.115329
75	113	3	VL02N	\N	2026-07-25 15:38:54.115329
76	113	3	VL02N	\N	2026-07-25 15:38:54.115329
77	113	3	VA03	\N	2026-07-25 15:38:54.115329
78	113	4	VF01	\N	2026-07-25 15:38:54.115329
79	113	4	VA05	\N	2026-07-25 15:38:54.115329
80	113	4	VF01	\N	2026-07-25 15:38:54.115329
81	113	5	VF03	\N	2026-07-25 15:38:54.115329
82	114	1	GATP	\N	2026-08-06 12:29:32.226315
83	114	2	CO09	\N	2026-08-06 12:29:32.226315
84	114	3	/SAPAPO/AC42	\N	2026-08-06 12:29:32.226315
85	115	1	ME21N	\N	2026-08-08 17:02:21.512054
86	115	2	ME22N	\N	2026-08-08 17:02:21.512054
87	115	3	ME23N	\N	2026-08-08 17:02:21.512054
\.


--
-- Data for Name: repository_assets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.repository_assets (asset_id, asset_name, module, transaction_code, script_name, description, status, created_on) FROM stdin;
8	ME21N Create Purchase Order	MM	ME21N	ME21N_CREATE_PURCHAGE_ORDER.py	Description: Create Purchase Order\r\nSteps:\r\n1.\tExecute ME21N\r\n2.\tSelect Vendor\r\n3.\tReference Purchase Requisition\r\n4.\tVerify pricing\r\n5.\tVerify delivery schedule\r\n6.\tSave\r\n7.\tVerify PO Number created\r\n	Active	2026-07-22 09:35:15.836436
7	ME51N Create Purchase Requisition	MM	ME51N	ME51N_CREATE_PURCHASE_REQISITION.py	Description: Create Purchase Requisition\r\nSteps:\r\n1.\tExecute ME51N\r\n2.\tEnter Material\r\n3.\tEnter Quantity\r\n4.\tEnter Plant\r\n5.\tEnter Delivery Date\r\n6.\tSave\r\n7.\tVerify PR Number generated\r\n	Active	2026-07-22 09:34:07.328954
9	ME22N Change Purchase Order	MM	ME22N	ME22N_CHANGE_PURCHAGE_ORDER.py	Description: Change Purchase Order\r\nSteps:\r\n1.\tExecute ME22N\r\n2.\tEnter PO Number\r\n3.\tModify quantity\r\n4.\tUpdate delivery date\r\n5.\tSave\r\n6.\tVerify changes\r\n\r\n	Active	2026-07-22 09:37:03.622502
10	ME23N Display Purchase Order	MM	ME23N	ME51N_DISPLAY_PURCHASE_ORDER.py	Description: Display Purchase Order\r\nSteps:\r\n1.\tExecute ME23N\r\n2.\tEnter PO Number\r\n3.\tValidate Header\r\n4.\tValidate Items\r\n5.\tValidate Conditions\r\n6.\tValidate History\r\n	Active	2026-07-22 09:40:05.11645
2	KS02_MODIFY_COST_CENTER	CO	KS02	KS02_MODIFY_COST_CENTER.py	Description: Change Cost Center\r\nSteps:\r\n1.\tExecute KS02\r\n2.\tEnter Cost Center\r\n3.\tSelect Change\r\n4.\tModify Description\r\n5.\tModify Responsible Person\r\n6.\tSave\r\n7.\tVerify changes updated\r\n	Active	2026-07-21 14:45:48.275047
3	KS03_DISPLAY_COST_CENTER3	CO	KS03	KS03_DISPLAY_COST_CENTER.py	Description: Display Cost Center\r\nSteps:\r\n1.\tExecute KS03\r\n2.\tEnter Cost Center\r\n3.\tDisplay Master Data\r\n4.\tVerify Organization Assignment\r\n5.\tVerify Validity Dates\r\n6.\tVerify Cost Center Status\r\n	Active	2026-07-21 14:46:54.714918
4	KS04_BLOCK_COST_CENTER3	CO	KS04	KS04_BLOCK_COST_CENTER.py	Description: Block Cost Center\r\nSteps:\r\n1.\tExecute KS04\r\n2.\tEnter Cost Center\r\n3.\tDisplay Master Data\r\n4.\tDelete \r\n	Active	2026-07-21 14:47:29.072942
5	HELLO_WORLD_TEST	E2E	HELLO	HELLO_WORLD_TEST.py	MCSTAP Execution Test	Active	2026-07-21 15:18:08.3486
6	Test day and time	E2E	DATE	REPOSITORY_ENGINE_TEST.py	Date and time	Active	2026-07-22 07:37:54.03672
1	KS01_CREATE_COST_CENTER	CO	KS01	KS01_CREATE_COST_CENTER.py	Description: Create Cost Center\r\nSteps:\r\n1.\tExecute KS01\r\n2.\tEnter Controlling Area\r\n3.\tEnter Cost Center ID\r\n4.\tEnter Name and Description\r\n5.\tEnter Valid From Date\r\n6.\tAssign Cost Center Category\r\n7.\tAssign Profit Center\r\n8.\tSave\r\n9.\tVerify Cost Center created successfully\r\n	Active	2026-07-20 12:41:23.672259
11	ME51N_CREATE_PURCHASE_REQUISITION	MM	ME51N	ME51N_CREATE_PURCHASE_REQUISITION.py	Generated from AI Test Case Builder	Draft	2026-07-26 21:31:00.771379
12	ME21N_CREATE_PO	MM	ME21N	ME21N_CREATE_PO.py	Generated from AI Test Case Builder	Draft	2026-07-26 21:31:00.771379
13	MIGO_GOODS_RECEIPT	MM	MIGO	MIGO_GOODS_RECEIPT.py	Generated from AI Test Case Builder	Draft	2026-07-26 21:31:00.771379
14	MIRO_INVOICE_VERIFICATION	MM	MIRO	MIRO_INVOICE_VERIFICATION.py	Generated from AI Test Case Builder	Draft	2026-07-26 21:31:00.771379
19	IW31_CREATE_WORK_ORDER	PM	IW31	IW31_CREATE_WORK_ORDER.py	Generated from AI Test Case Builder	Draft	2026-07-26 21:40:57.989637
20	IW32_CHANGE_WORK_ORDER	PM	IW32	IW32_CHANGE_WORK_ORDER.py	Generated from AI Test Case Builder	Draft	2026-07-26 21:40:57.989637
21	IW33_DISPLAY_WORK_ORDER	PM	IW33	IW33_DISPLAY_WORK_ORDER.py	Generated from AI Test Case Builder	Draft	2026-07-26 21:40:57.989637
22	IW38_ORDER_LIST	PM	IW38	IW38_ORDER_LIST.py	Generated from AI Test Case Builder	Draft	2026-07-26 21:40:57.989637
35	VA01_CREATE_SALES_ORDER	SD	VA01	VA01_CREATE_SALES_ORDER.py	Generated from AI Test Case Builder	Draft	2026-07-28 09:11:05.673135
36	VA02_CHANGE_SALES_ORDER	SD	VA02	VA02_CHANGE_SALES_ORDER.py	Generated from AI Test Case Builder	Draft	2026-07-28 09:11:05.673135
37	VL01N_CREATE_DELIVERY	SD	VL01N	VL01N_CREATE_DELIVERY.py	Generated from AI Test Case Builder	Draft	2026-07-28 09:11:05.673135
38	VA03_DISPLAY_SALES_ORDER	SD	VA03	VA03_DISPLAY_SALES_ORDER.py	Generated from AI Test Case Builder	Draft	2026-07-28 09:11:05.673135
39	VL02N_POST_GOODS_ISSUE	SD	VL02N	VL02N_POST_GOODS_ISSUE.py	Generated from AI Test Case Builder	Draft	2026-07-28 09:11:05.673135
40	VA05_SALES_ORDER_LIST	SD	VA05	VA05_SALES_ORDER_LIST.py	Generated from AI Test Case Builder	Draft	2026-07-28 09:11:05.673135
41	VF01_CREATE_BILLING_DOCUMENT	SD	VF01	VF01_CREATE_BILLING_DOCUMENT.py	Generated from AI Test Case Builder	Draft	2026-07-28 09:11:05.673135
42	VF03_DISPLAY_BILLING_DOCUMENT	SD	VF03	VF03_DISPLAY_BILLING_DOCUMENT.py	Generated from AI Test Case Builder	Draft	2026-07-28 09:11:05.673135
\.


--
-- Data for Name: sap_process_library; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sap_process_library (process_id, process_name, module, flow_type, description, status) FROM stdin;
1	Sales Order	SD	E2E	Sales and Distribution End-to-End Process	Active
2	Purchase Order	MM	E2E	Purchase Order End-to-End Process	Active
3	Cost Center	CO	Lifecycle	Cost Center Lifecycle Process	Active
4	Internal Order	CO	Lifecycle	Internal Order Lifecycle Process	Active
5	Profit Center	CO	Lifecycle	Profit Center Lifecycle Process	Active
6	Maintenance Plan	PM	Lifecycle	Maintenance Plan Lifecycle	Active
7	Work Order	PM	Lifecycle	Work Order Lifecycle	Active
8	Equipment	PM	Lifecycle	Equipment Lifecycle	Active
9	Vendor Invoice	FI	E2E	Vendor Invoice Processing	Active
10	Customer Receivable	FI	E2E	Customer Receivable Process	Active
11	General Ledger	FI	Functional	General Ledger Posting Process	Active
12	Transfer Order	WM	Functional	Warehouse Transfer Order	Active
13	Physical Inventory	WM	Functional	Warehouse Physical Inventory	Active
14	Inspection Lot	QM	Lifecycle	Quality Inspection Lot Lifecycle	Active
15	Quality Notification	QM	Lifecycle	Quality Notification Lifecycle	Active
16	Cost Center	CO	Lifecycle	Cost Center Lifecycle	Active
17	Internal Order	CO	Lifecycle	Internal Order Lifecycle	Active
18	Profit Center	CO	Lifecycle	Profit Center Lifecycle	Active
19	Cost Element	CO	Lifecycle	Cost Element Lifecycle	Active
20	Statistical Key Figure	CO	Lifecycle	SKF Lifecycle	Active
21	Assessment Cycle	CO	Functional	Assessment Cycle Processing	Active
22	Distribution Cycle	CO	Functional	Distribution Cycle Processing	Active
23	Activity Type	CO	Lifecycle	Activity Type Lifecycle	Active
24	Cost Center Planning	CO	Functional	Cost Center Planning	Active
25	Budget Planning	CO	Functional	Budget Planning Process	Active
26	Cost Center	CO	Lifecycle	Cost Center Lifecycle	Active
27	Internal Order	CO	Lifecycle	Internal Order Lifecycle	Active
28	Profit Center	CO	Lifecycle	Profit Center Lifecycle	Active
29	Cost Element	CO	Lifecycle	Cost Element Lifecycle	Active
30	Purchase Requisition	MM	Functional	Purchase Requisition Process	Active
31	Purchase Order	MM	E2E	Purchase Order End-to-End	Active
32	Vendor Lifecycle	MM	Lifecycle	Vendor Lifecycle	Active
33	Material Master	MM	Lifecycle	Material Master Lifecycle	Active
34	Sales Order	SD	E2E	Sales Order End-to-End	Active
35	Customer Lifecycle	SD	Lifecycle	Customer Lifecycle	Active
36	Quotation	SD	Functional	Quotation Processing	Active
37	Maintenance Plan	PM	Lifecycle	Maintenance Plan Lifecycle	Active
38	Work Order	PM	Lifecycle	Work Order Lifecycle	Active
39	Equipment	PM	Lifecycle	Equipment Lifecycle	Active
40	General Ledger	FI	Functional	General Ledger Processing	Active
41	Vendor Invoice	FI	E2E	Vendor Invoice Processing	Active
42	Customer Receivable	FI	E2E	Customer Receivable Process	Active
43	Transfer Order	WM	Functional	Transfer Order Processing	Active
44	Physical Inventory	WM	Functional	Physical Inventory	Active
45	Inspection Lot	QM	Lifecycle	Inspection Lot Lifecycle	Active
46	Quality Notification	QM	Lifecycle	Quality Notification	Active
47	Production Order	PP	Lifecycle	Production Order Lifecycle	Active
48	MRP	PP	Functional	Material Requirements Planning	Active
49	Payment Processing	TR	E2E	Treasury Payment Processing	Active
50	Cash Management	TR	Functional	Cash Management	Active
51	Demand Planning	SCM	Functional	Demand Planning	Active
52	Supply Planning	SCM	Functional	Supply Planning	Active
53	Cost Center	CO	Lifecycle	Cost Center Lifecycle	Active
54	Internal Order	CO	Lifecycle	Internal Order Lifecycle	Active
55	Profit Center	CO	Lifecycle	Profit Center Lifecycle	Active
56	Cost Element	CO	Lifecycle	Cost Element Lifecycle	Active
57	Statistical Key Figure	CO	Lifecycle	Statistical Key Figure Lifecycle	Active
58	Activity Type	CO	Lifecycle	Activity Type Lifecycle	Active
59	Assessment Cycle	CO	Functional	Assessment Cycle Management	Active
60	Distribution Cycle	CO	Functional	Distribution Cycle Management	Active
61	Cost Center Planning	CO	Functional	Cost Center Planning	Active
62	Budget Planning	CO	Functional	Budget Planning Process	Active
63	Allocation Cycle	CO	Functional	Allocation Cycle Processing	Active
64	Reposting	CO	Functional	Cost Reposting Process	Active
65	Direct Activity Allocation	CO	Functional	Direct Activity Allocation	Active
66	Indirect Activity Allocation	CO	Functional	Indirect Activity Allocation	Active
67	Settlement Rule	CO	Lifecycle	Settlement Rule Management	Active
68	Allocation Structure	CO	Lifecycle	Allocation Structure Management	Active
69	Overhead Calculation	CO	Functional	Overhead Calculation Process	Active
70	Costing Sheet	CO	Lifecycle	Costing Sheet Management	Active
71	Product Cost Planning	CO	Functional	Product Cost Planning	Active
72	Variance Analysis	CO	Functional	Variance Analysis Process	Active
73	Period-End Closing	CO	Functional	Period-End Closing Activities	Active
74	Actual Costing	CO	Functional	Actual Cost Calculation	Active
75	Cost Object Controlling	CO	Functional	Cost Object Lifecycle	Active
76	Product Cost Collector	CO	Lifecycle	Product Cost Collector Lifecycle	Active
77	Responsibility Area	CO	Lifecycle	Responsibility Area Management	Active
78	Profitability Analysis	CO	Functional	CO-PA Analysis	Active
79	Settlement Processing	CO	Functional	Settlement Processing	Active
80	Template Allocation	CO	Functional	Template Allocation Process	Active
81	Universal Allocation	CO	Functional	Universal Allocation	Active
82	Profitability Segment	CO	Lifecycle	Profitability Segment Lifecycle	Active
83	Actual Activity Allocation	CO	Functional	Actual Activity Allocation Processing	Active
84	Plan Activity Allocation	CO	Functional	Plan Activity Allocation	Active
85	Plan Assessment	CO	Functional	Plan Assessment Processing	Active
86	Plan Distribution	CO	Functional	Plan Distribution Processing	Active
87	Cost Rollup	CO	Functional	Cost Rollup Processing	Active
88	Management Reporting	CO	Reporting	Management Reporting Process	Active
89	Cost Analysis	CO	Reporting	Cost Analysis Reporting	Active
90	Margin Analysis	CO	Reporting	Margin Analysis	Active
91	CO Closing Cockpit	CO	Functional	CO Closing Cockpit Process	Active
92	Universal Journal Analysis	CO	Reporting	Universal Journal Reporting	Active
93	Purchase Requisition	MM	Lifecycle	Purchase Requisition Lifecycle	Active
94	Purchase Order	MM	Lifecycle	Purchase Order Lifecycle	Active
95	Request For Quotation	MM	Lifecycle	RFQ Lifecycle	Active
96	Quotation Comparison	MM	Functional	Quotation Comparison Process	Active
97	Source List	MM	Lifecycle	Source List Management	Active
98	Quota Arrangement	MM	Lifecycle	Quota Arrangement Management	Active
99	Vendor Master	MM	Lifecycle	Vendor Master Maintenance	Active
100	Material Master	MM	Lifecycle	Material Master Maintenance	Active
101	Goods Receipt	MM	Functional	Goods Receipt Processing	Active
102	Invoice Verification	MM	Functional	Invoice Verification Processing	Active
103	Contract Management	MM	Lifecycle	Purchasing Contract Lifecycle	Active
104	Scheduling Agreement	MM	Lifecycle	Scheduling Agreement Lifecycle	Active
105	Stock Transfer	MM	Functional	Stock Transfer Process	Active
106	Physical Inventory	MM	Functional	Physical Inventory Process	Active
107	Subcontracting	MM	Functional	Subcontracting Process	Active
108	Consignment	MM	Functional	Consignment Processing	Active
109	Vendor Evaluation	MM	Functional	Vendor Evaluation Process	Active
110	Release Strategy	MM	Functional	Purchase Approval Process	Active
111	Goods Issue	MM	Functional	Goods Issue Processing	Active
112	Reservation Management	MM	Lifecycle	Reservation Lifecycle	Active
113	Contract Management	MM	Lifecycle	Purchasing Contract Lifecycle	Active
114	Scheduling Agreement	MM	Lifecycle	Scheduling Agreement Lifecycle	Active
115	Stock Transfer	MM	Functional	Stock Transfer Process	Active
116	Physical Inventory	MM	Functional	Physical Inventory Process	Active
117	Subcontracting	MM	Functional	Subcontracting Process	Active
118	Consignment	MM	Functional	Consignment Processing	Active
119	Vendor Evaluation	MM	Functional	Vendor Evaluation Process	Active
120	Release Strategy	MM	Functional	Purchase Approval Process	Active
121	Goods Issue	MM	Functional	Goods Issue Processing	Active
122	Reservation Management	MM	Lifecycle	Reservation Lifecycle	Active
123	Service Procurement	MM	Functional	External Service Procurement	Active
124	Batch Management	MM	Lifecycle	Batch Management Process	Active
125	Material Ledger	MM	Functional	Material Ledger Processing	Active
126	Split Valuation	MM	Lifecycle	Split Valuation Management	Active
127	Consumption Based Planning	MM	Functional	CBP Process	Active
128	Forecasting	MM	Functional	Demand Forecasting	Active
129	Returns To Vendor	MM	Functional	Vendor Return Process	Active
130	Pipeline Materials	MM	Functional	Pipeline Material Management	Active
131	Material Valuation	MM	Lifecycle	Material Valuation Management	Active
132	Physical Inventory Reconciliation	MM	Functional	Inventory Reconciliation Process	Active
133	Warehouse Integration	MM	Functional	MM Warehouse Integration	Active
134	Stock Determination	MM	Functional	Automatic Stock Determination	Active
135	MRP Integration	MM	Functional	MRP Integration Process	Active
136	Valuation Class	MM	Lifecycle	Valuation Class Maintenance	Active
137	Material Type Management	MM	Lifecycle	Material Type Administration	Active
138	Storage Location Management	MM	Lifecycle	Storage Location Management	Active
139	Vendor Consignment Fill-Up	MM	Functional	Vendor Consignment Fill-Up	Active
140	Stock Aging Analysis	MM	Reporting	Stock Aging Reporting	Active
141	Inventory Reporting	MM	Reporting	Inventory Reporting	Active
142	Purchasing Analytics	MM	Reporting	Purchasing Analytics	Active
143	Sales Order	SD	Lifecycle	Sales Order Lifecycle	Active
144	Inquiry	SD	Lifecycle	Inquiry Lifecycle	Active
145	Quotation	SD	Lifecycle	Quotation Lifecycle	Active
146	Customer Contract	SD	Lifecycle	Customer Contract Lifecycle	Active
147	Delivery Processing	SD	Functional	Outbound Delivery Processing	Active
148	Billing Processing	SD	Functional	Billing Processing	Active
149	Returns Processing	SD	Functional	Customer Return Processing	Active
150	Customer Master	SD	Lifecycle	Customer Master Lifecycle	Active
151	Pricing Management	SD	Functional	Pricing Management	Active
152	Credit Memo Processing	SD	Functional	Credit Memo Processing	Active
153	Backorder Processing	SD	Functional	Backorder Management	Active
154	ATP Check	SD	Functional	Available-To-Promise Processing	Active
155	Free Of Charge Delivery	SD	Functional	Free Of Charge Delivery Process	Active
156	Third Party Sales	SD	E2E	Third Party Sales Process	Active
157	Intercompany Sales	SD	E2E	Intercompany Sales Process	Active
158	Consignment Processing	SD	E2E	Customer Consignment Process	Active
159	Debit Memo Processing	SD	Functional	Debit Memo Processing	Active
160	Output Determination	SD	Functional	Output Processing	Active
161	Customer Hierarchy	SD	Lifecycle	Customer Hierarchy Management	Active
162	Shipping Point Management	SD	Lifecycle	Shipping Point Management	Active
163	Backorder Processing	SD	Functional	Backorder Management	Active
164	ATP Check	SD	Functional	Available-To-Promise Processing	Active
165	Free Of Charge Delivery	SD	Functional	Free Of Charge Delivery Process	Active
166	Third Party Sales	SD	E2E	Third Party Sales Process	Active
167	Intercompany Sales	SD	E2E	Intercompany Sales Process	Active
168	Consignment Processing	SD	E2E	Customer Consignment Process	Active
169	Debit Memo Processing	SD	Functional	Debit Memo Processing	Active
170	Output Determination	SD	Functional	Output Processing	Active
171	Customer Hierarchy	SD	Lifecycle	Customer Hierarchy Management	Active
172	Shipping Point Management	SD	Lifecycle	Shipping Point Management	Active
173	Sales Scheduling Agreement	SD	Lifecycle	Sales Scheduling Agreement Process	Active
174	Cash Sales	SD	Functional	Cash Sales Process	Active
175	Rush Order	SD	Functional	Rush Order Process	Active
176	Credit Management	SD	Functional	Credit Management Process	Active
177	Rebate Processing	SD	Functional	Rebate Management	Active
178	Billing Plan	SD	Lifecycle	Billing Plan Management	Active
179	Delivery Scheduling	SD	Functional	Delivery Scheduling	Active
180	Customer Returns Credit	SD	Functional	Return Credit Processing	Active
181	Sales Analytics	SD	Reporting	Sales Analysis Reporting	Active
182	Sales Forecasting	SD	Reporting	Sales Forecasting Process	Active
183	Work Order	PM	Lifecycle	Work Order Lifecycle	Active
184	Maintenance Plan	PM	Lifecycle	Maintenance Plan Lifecycle	Active
185	Equipment	PM	Lifecycle	Equipment Lifecycle	Active
186	Functional Location	PM	Lifecycle	Functional Location Lifecycle	Active
187	Maintenance Notification	PM	Lifecycle	Maintenance Notification Process	Active
188	Preventive Maintenance	PM	Functional	Preventive Maintenance Process	Active
189	Breakdown Maintenance	PM	Functional	Breakdown Maintenance Process	Active
190	Task List	PM	Lifecycle	Task List Management	Active
191	Calibration Management	PM	Functional	Calibration Management	Active
192	Refurbishment Management	PM	Functional	Equipment Refurbishment Process	Active
193	Maintenance Item	PM	Lifecycle	Maintenance Item Lifecycle	Active
194	Maintenance Strategy	PM	Lifecycle	Maintenance Strategy Management	Active
195	Maintenance Package	PM	Lifecycle	Maintenance Package Management	Active
196	Measuring Point	PM	Lifecycle	Measuring Point Lifecycle	Active
197	Measuring Document	PM	Lifecycle	Measuring Document Lifecycle	Active
198	Permit Management	PM	Functional	Work Permit Management	Active
199	Shutdown Maintenance	PM	Functional	Shutdown Maintenance Process	Active
200	Capacity Planning	PM	Functional	PM Capacity Planning	Active
201	Workforce Scheduling	PM	Functional	Maintenance Workforce Scheduling	Active
202	Linear Asset Management	PM	Lifecycle	Linear Asset Management	Active
203	General Ledger	FI	Lifecycle	General Ledger Lifecycle	Active
204	Accounts Payable	FI	Lifecycle	Accounts Payable Process	Active
205	Accounts Receivable	FI	Lifecycle	Accounts Receivable Process	Active
206	Vendor Invoice	FI	Lifecycle	Vendor Invoice Lifecycle	Active
207	Customer Invoice	FI	Lifecycle	Customer Invoice Lifecycle	Active
208	Payment Run	FI	Functional	Automatic Payment Processing	Active
209	Bank Reconciliation	FI	Functional	Bank Reconciliation Process	Active
210	Asset Accounting	FI	Lifecycle	Asset Accounting Lifecycle	Active
211	Recurring Entries	FI	Functional	Recurring Entry Management	Active
212	Accrual Posting	FI	Functional	Accrual Processing	Active
213	Period Close	FI	Functional	Financial Period Closing	Active
214	Tax Processing	FI	Functional	Tax Determination and Posting	Active
215	Customer Payment	FI	Functional	Customer Payment Processing	Active
216	Vendor Payment	FI	Functional	Vendor Payment Processing	Active
217	Dunning Process	FI	Functional	Customer Dunning	Active
218	Cash Journal	FI	Functional	Cash Journal Management	Active
219	Depreciation Run	FI	Functional	Asset Depreciation Processing	Active
220	Asset Retirement	FI	Lifecycle	Asset Retirement Process	Active
221	Profit Center Accounting	FI	Functional	Profit Center Accounting	Active
222	Document Splitting	FI	Functional	Document Splitting Process	Active
223	Foreign Currency Valuation	FI	Functional	Foreign Currency Valuation Process	Active
224	Intercompany Accounting	FI	Functional	Intercompany Accounting	Active
225	Electronic Bank Statement	FI	Functional	Electronic Bank Statement Processing	Active
226	Special G/L Transactions	FI	Functional	Special General Ledger Transactions	Active
227	Customer Credit Management	FI	Functional	Customer Credit Management	Active
228	Lockbox Processing	FI	Functional	Lockbox Processing	Active
229	Financial Statement Reporting	FI	Reporting	Financial Statement Reporting	Active
230	Open Item Clearing	FI	Functional	Open Item Clearing Process	Active
231	Document Parking	FI	Lifecycle	Document Parking Workflow	Active
232	GR IR Reconciliation	FI	Functional	GR IR Reconciliation Process	Active
233	Production Order	PP	Lifecycle	Production Order Lifecycle	Active
234	Planned Order	PP	Lifecycle	Planned Order Lifecycle	Active
235	Material Requirements Planning	PP	Functional	MRP Process	Active
236	Bill Of Material	PP	Lifecycle	BOM Lifecycle	Active
237	Routing Management	PP	Lifecycle	Routing Lifecycle	Active
238	Work Center	PP	Lifecycle	Work Center Lifecycle	Active
239	Production Confirmation	PP	Functional	Production Confirmation Process	Active
240	Capacity Planning	PP	Functional	Capacity Planning Process	Active
241	Production Version	PP	Lifecycle	Production Version Lifecycle	Active
242	Shop Floor Control	PP	Functional	Shop Floor Control	Active
243	Process Order	PP	Lifecycle	Process Order Lifecycle	Active
244	Repetitive Manufacturing	PP	Functional	Repetitive Manufacturing Process	Active
245	Long Term Planning	PP	Functional	Long Term Planning	Active
246	Demand Management	PP	Functional	Demand Management Process	Active
247	Production Resources Tools	PP	Lifecycle	PRT Management	Active
248	Batch Determination	PP	Functional	Batch Determination Process	Active
249	Kanban	PP	Functional	Kanban Replenishment Process	Active
250	Backflush Processing	PP	Functional	Backflush Processing	Active
251	Engineering Change Management	PP	Lifecycle	Engineering Change Management	Active
252	Production Analytics	PP	Reporting	Production Analytics	Active
253	Master Production Scheduling	PP	Functional	Master Production Scheduling	Active
254	Production Campaign	PP	Functional	Production Campaign Management	Active
255	Production Cost Analysis	PP	Reporting	Production Cost Analysis	Active
256	Production Settlement	PP	Functional	Production Order Settlement	Active
257	Production Variance Analysis	PP	Reporting	Production Variance Analysis	Active
258	Production Execution	PP	Functional	Production Execution Process	Active
259	Production Backlog Management	PP	Reporting	Production Backlog Management	Active
260	Production Change Management	PP	Lifecycle	Production Change Management	Active
261	Production KPI Reporting	PP	Reporting	Production KPI Reporting	Active
262	Production Resource Planning	PP	Functional	Production Resource Planning	Active
263	Inspection Lot	QM	Lifecycle	Inspection Lot Lifecycle	Active
264	Quality Notification	QM	Lifecycle	Quality Notification Lifecycle	Active
265	Results Recording	QM	Functional	Inspection Results Recording	Active
266	Usage Decision	QM	Functional	Usage Decision Process	Active
267	Quality Certificate	QM	Lifecycle	Quality Certificate Management	Active
268	Vendor Quality Management	QM	Functional	Vendor Quality Management	Active
269	Customer Complaint	QM	Lifecycle	Customer Complaint Management	Active
270	Audit Management	QM	Lifecycle	Quality Audit Management	Active
271	Calibration Quality	QM	Functional	Calibration Quality Process	Active
272	Quality Reporting	QM	Reporting	Quality Reporting and Analytics	Active
273	Inspection Planning	QM	Lifecycle	Inspection Planning Lifecycle	Active
274	Defect Recording	QM	Functional	Defect Recording Process	Active
275	Quality Improvement Program	QM	Functional	Continuous Improvement Program	Active
276	Supplier Audit	QM	Lifecycle	Supplier Audit Process	Active
277	Internal Quality Audit	QM	Lifecycle	Internal Audit Management	Active
278	Quality Scorecard	QM	Reporting	Quality Scorecard Reporting	Active
279	Non Conformance Management	QM	Lifecycle	Non Conformance Process	Active
280	Corrective Action Management	QM	Lifecycle	Corrective Action Process	Active
281	Preventive Action Management	QM	Lifecycle	Preventive Action Process	Active
282	Quality Cost Analysis	QM	Reporting	Quality Cost Analysis	Active
283	Quality Inspection Method	QM	Lifecycle	Inspection Method Lifecycle	Active
284	Sampling Procedure	QM	Lifecycle	Sampling Procedure Management	Active
285	Control Plan Management	QM	Lifecycle	Control Plan Management	Active
286	Quality Agreement	QM	Lifecycle	Quality Agreement Management	Active
287	Supplier Complaint Management	QM	Lifecycle	Supplier Complaint Process	Active
288	Customer Quality Portal	QM	Functional	Customer Quality Portal Process	Active
289	Quality Trend Analysis	QM	Reporting	Quality Trend Analysis	Active
290	Defect Analytics	QM	Reporting	Defect Analytics	Active
291	Quality Risk Management	QM	Functional	Quality Risk Assessment	Active
292	Quality KPI Dashboard	QM	Reporting	Quality KPI Dashboard	Active
293	Transfer Order	WM	Lifecycle	Transfer Order Lifecycle	Active
294	Putaway Processing	WM	Functional	Warehouse Putaway Process	Active
295	Picking Processing	WM	Functional	Warehouse Picking Process	Active
296	Stock Transfer	WM	Functional	Warehouse Stock Transfer	Active
297	Bin Management	WM	Lifecycle	Storage Bin Management	Active
298	Replenishment	WM	Functional	Warehouse Replenishment	Active
299	Goods Receipt WM	WM	Functional	Warehouse Goods Receipt	Active
300	Goods Issue WM	WM	Functional	Warehouse Goods Issue	Active
301	Cycle Counting	WM	Functional	Cycle Counting Process	Active
302	Warehouse Monitoring	WM	Reporting	Warehouse Monitoring and Reporting	Active
303	Wave Picking	WM	Functional	Wave Picking Process	Active
304	Cross Docking	WM	Functional	Cross Docking Process	Active
305	Stock Placement Strategy	WM	Functional	Stock Placement Strategy	Active
306	Storage Type Management	WM	Lifecycle	Storage Type Management	Active
307	Inventory Difference Processing	WM	Functional	Inventory Difference Processing	Active
308	Warehouse Reorganization	WM	Functional	Warehouse Reorganization	Active
309	Returns Warehouse Processing	WM	Functional	Warehouse Returns Processing	Active
310	Bulk Storage Management	WM	Lifecycle	Bulk Storage Management	Active
311	Open Transfer Order Analysis	WM	Reporting	Open TO Analysis	Active
312	Warehouse KPI Reporting	WM	Reporting	Warehouse KPI Reporting	Active
313	Cash Management	TR	Functional	Cash Management Process	Active
314	Liquidity Planning	TR	Functional	Liquidity Planning Process	Active
315	Treasury Position	TR	Functional	Treasury Position Monitoring	Active
316	Bank Communication	TR	Functional	Bank Communication Management	Active
317	Foreign Exchange Management	TR	Functional	Foreign Currency Management	Active
318	Investment Management	TR	Lifecycle	Investment Management Lifecycle	Active
319	Debt Management	TR	Lifecycle	Debt Management Process	Active
320	Treasury Reporting	TR	Reporting	Treasury Reporting and Analytics	Active
321	In House Cash	TR	Functional	In House Cash Management	Active
322	Risk Management	TR	Functional	Treasury Risk Management	Active
323	Money Market Transactions	TR	Lifecycle	Money Market Transaction Lifecycle	Active
324	Securities Management	TR	Lifecycle	Securities Portfolio Management	Active
325	Derivatives Management	TR	Lifecycle	Derivative Instrument Management	Active
326	Hedge Management	TR	Functional	Hedge Management Process	Active
327	Treasury Payments	TR	Functional	Treasury Payment Processing	Active
328	Cash Concentration	TR	Functional	Cash Concentration Process	Active
329	Bank Account Management	TR	Lifecycle	Bank Account Lifecycle	Active
330	Liquidity Reporting	TR	Reporting	Liquidity Reporting	Active
331	Treasury Forecasting	TR	Reporting	Treasury Forecasting	Active
332	Treasury Compliance	TR	Functional	Treasury Compliance Monitoring	Active
333	Demand Planning	SCM	Functional	Demand Planning Process	Active
334	Supply Planning	SCM	Functional	Supply Planning Process	Active
335	Transportation Planning	SCM	Functional	Transportation Planning Process	Active
336	Distribution Planning	SCM	Functional	Distribution Planning Process	Active
337	Inventory Optimization	SCM	Functional	Inventory Optimization	Active
338	Forecast Collaboration	SCM	Functional	Forecast Collaboration Process	Active
339	Supply Network Planning	SCM	Functional	Supply Network Planning	Active
340	Available To Promise SCM	SCM	Functional	Supply Chain ATP Process	Active
341	Logistics Collaboration	SCM	Functional	Logistics Collaboration Process	Active
342	SCM Analytics	SCM	Reporting	Supply Chain Analytics	Active
\.


--
-- Data for Name: sap_process_steps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sap_process_steps (process_step_id, process_id, sequence_no, transaction_code, step_name, description) FROM stdin;
1	1	1	VA01	Create Sales Order	\N
2	1	2	VL01N	Create Outbound Delivery	\N
3	1	3	VL02N	Post Goods Issue	\N
4	1	4	VF01	Create Billing Document	\N
5	1	5	VF03	Display Billing Document	\N
6	2	1	ME51N	Create Purchase Requisition	\N
7	2	2	ME21N	Create Purchase Order	\N
8	2	3	MIGO	Goods Receipt	\N
9	2	4	MIRO	Invoice Verification	\N
10	3	1	KS01	Create Cost Center	\N
11	3	2	KS02	Change Cost Center	\N
12	3	3	KS03	Display Cost Center	\N
13	3	4	KS04	Block Cost Center	\N
14	4	1	KO01	Create Internal Order	\N
15	4	2	KO02	Change Internal Order	\N
16	4	3	KO03	Display Internal Order	\N
17	4	4	KO04	Lock Internal Order	\N
18	4	1	KO01	Create Internal Order	\N
19	4	2	KO02	Change Internal Order	\N
20	4	3	KO03	Display Internal Order	\N
21	4	4	KO04	Lock Internal Order	\N
22	5	1	KE51	Create Profit Center	\N
23	5	2	KE52	Change Profit Center	\N
24	5	3	KE53	Display Profit Center	\N
28	6	1	IP01	Create Maintenance Plan	\N
29	6	2	IP02	Change Maintenance Plan	\N
30	6	3	IP03	Display Maintenance Plan	\N
31	7	1	IW31	Create Work Order	\N
32	7	2	IW32	Change Work Order	\N
33	7	3	IW33	Display Work Order	\N
34	7	4	IW38	Order List	\N
35	8	1	IE01	Create Equipment	\N
36	8	2	IE02	Change Equipment	\N
37	8	3	IE03	Display Equipment	\N
38	9	1	FB60	Enter Vendor Invoice	\N
39	9	2	F110	Automatic Payment Run	\N
40	9	3	FB03	Display Accounting Document	\N
41	10	1	FB70	Customer Invoice	\N
42	10	2	F-28	Incoming Payment	\N
43	10	3	FB03	Display Accounting Document	\N
44	11	1	F-02	Post Document	\N
45	11	2	FB03	Display Document	\N
46	11	3	FB08	Reverse Document	\N
47	12	1	LT01	Create Transfer Order	\N
48	12	2	LT12	Confirm Transfer Order	\N
49	12	3	LX03	Bin Status Report	\N
50	13	1	LI01N	Create Inventory Document	\N
51	13	2	LI11N	Count Inventory	\N
52	13	3	LI20	Clear Inventory Differences	\N
53	14	1	QA01	Create Inspection Lot	\N
54	14	2	QA32	Process Inspection Lot	\N
55	14	3	QA11	Usage Decision	\N
56	15	1	QM01	Create Notification	\N
57	15	2	QM02	Change Notification	\N
58	15	3	QM03	Display Notification	\N
67	1	1	VA01	Create Sales Order	\N
68	34	1	VA01	Create Sales Order	\N
69	1	2	VL01N	Create Delivery	\N
70	34	2	VL01N	Create Delivery	\N
71	1	3	VL02N	Post Goods Issue	\N
72	34	3	VL02N	Post Goods Issue	\N
73	1	4	VF01	Create Billing	\N
74	34	4	VF01	Create Billing	\N
75	2	1	ME51N	Create PR	\N
76	31	1	ME51N	Create PR	\N
77	2	2	ME21N	Create PO	\N
78	31	2	ME21N	Create PO	\N
79	2	3	MIGO	Goods Receipt	\N
80	31	3	MIGO	Goods Receipt	\N
81	2	4	MIRO	Invoice Verification	\N
82	31	4	MIRO	Invoice Verification	\N
83	3	1	KS01	Create Cost Center	\N
84	16	1	KS01	Create Cost Center	\N
85	26	1	KS01	Create Cost Center	\N
86	53	1	KS01	Create Cost Center	\N
87	3	2	KS02	Change Cost Center	\N
88	16	2	KS02	Change Cost Center	\N
89	26	2	KS02	Change Cost Center	\N
90	53	2	KS02	Change Cost Center	\N
91	3	3	KS03	Display Cost Center	\N
92	16	3	KS03	Display Cost Center	\N
93	26	3	KS03	Display Cost Center	\N
94	53	3	KS03	Display Cost Center	\N
95	3	4	KS04	Block Cost Center	\N
96	16	4	KS04	Block Cost Center	\N
97	26	4	KS04	Block Cost Center	\N
98	53	4	KS04	Block Cost Center	\N
99	4	1	KO01	Create Internal Order	\N
100	17	1	KO01	Create Internal Order	\N
101	27	1	KO01	Create Internal Order	\N
102	54	1	KO01	Create Internal Order	\N
103	4	2	KO02	Change Internal Order	\N
104	17	2	KO02	Change Internal Order	\N
105	27	2	KO02	Change Internal Order	\N
106	54	2	KO02	Change Internal Order	\N
107	4	3	KO03	Display Internal Order	\N
108	17	3	KO03	Display Internal Order	\N
109	27	3	KO03	Display Internal Order	\N
110	54	3	KO03	Display Internal Order	\N
111	4	4	KO04	Lock Internal Order	\N
112	17	4	KO04	Lock Internal Order	\N
113	27	4	KO04	Lock Internal Order	\N
114	54	4	KO04	Lock Internal Order	\N
115	5	1	KE51	Create Profit Center	\N
116	18	1	KE51	Create Profit Center	\N
117	28	1	KE51	Create Profit Center	\N
118	55	1	KE51	Create Profit Center	\N
119	5	2	KE52	Change Profit Center	\N
120	18	2	KE52	Change Profit Center	\N
121	28	2	KE52	Change Profit Center	\N
122	55	2	KE52	Change Profit Center	\N
123	5	3	KE53	Display Profit Center	\N
124	18	3	KE53	Display Profit Center	\N
125	28	3	KE53	Display Profit Center	\N
126	55	3	KE53	Display Profit Center	\N
127	19	1	KA01	Create Cost Element	\N
128	29	1	KA01	Create Cost Element	\N
129	56	1	KA01	Create Cost Element	\N
130	19	2	KA02	Change Cost Element	\N
131	29	2	KA02	Change Cost Element	\N
132	56	2	KA02	Change Cost Element	\N
133	19	3	KA03	Display Cost Element	\N
134	29	3	KA03	Display Cost Element	\N
135	56	3	KA03	Display Cost Element	\N
136	20	1	KK01	Create Statistical Key Figure	\N
137	57	1	KK01	Create Statistical Key Figure	\N
138	20	2	KK02	Change Statistical Key Figure	\N
139	57	2	KK02	Change Statistical Key Figure	\N
140	20	3	KK03	Display Statistical Key Figure	\N
141	57	3	KK03	Display Statistical Key Figure	\N
142	23	1	KL01	Create Activity Type	\N
143	58	1	KL01	Create Activity Type	\N
144	23	2	KL02	Change Activity Type	\N
145	58	2	KL02	Change Activity Type	\N
146	23	3	KL03	Display Activity Type	\N
147	58	3	KL03	Display Activity Type	\N
148	63	1	KSC1	Create Allocation Cycle	\N
149	63	2	KSC2	Change Allocation Cycle	\N
150	63	3	KSC3	Display Allocation Cycle	\N
151	63	4	KSC5	Execute Allocation Cycle	\N
152	64	1	KB11N	Manual Reposting	\N
153	64	2	KB61	Repost Line Items	\N
154	64	3	KSB1	Display Cost Line Items	\N
155	65	1	KB21N	Create Direct Activity Allocation	\N
156	65	2	KB22N	Change Direct Activity Allocation	\N
157	65	3	KB23N	Display Direct Activity Allocation	\N
158	66	1	KSC1	Create Indirect Allocation	\N
159	66	2	KSC2	Change Indirect Allocation	\N
160	66	3	KSC5	Execute Indirect Allocation	\N
161	67	1	KO8G	Generate Settlement Rule	\N
162	67	2	KO02	Maintain Settlement Rule	\N
163	67	3	KO03	Display Settlement Rule	\N
164	68	1	OKO6	Create Allocation Structure	\N
165	68	2	OKO7	Change Allocation Structure	\N
166	68	3	OKO8	Display Allocation Structure	\N
167	69	1	KGI2	Execute Overhead Calculation	\N
168	69	2	KGI3	Display Overhead Results	\N
169	70	1	KZS2	Create Costing Sheet	\N
170	70	2	KZS3	Display Costing Sheet	\N
171	71	1	CK11N	Create Cost Estimate	\N
172	71	2	CK13N	Display Cost Estimate	\N
173	71	3	CK24	Mark and Release Cost Estimate	\N
174	72	1	KKS1	Variance Calculation	\N
175	72	2	KKS2	Display Variance	\N
176	72	3	KKS6	Variance Analysis Report	\N
177	73	1	KKAO	WIP Calculation	\N
178	73	2	KKS1	Variance Calculation	\N
179	73	3	KO88	Settlement	\N
180	73	4	KSU5	Assessment	\N
181	73	5	KSV5	Distribution	\N
182	74	1	CKMLCP	Actual Costing Run	\N
183	74	2	CKM3N	Material Cost Analysis	\N
184	74	3	CKMVFM	Actual Cost Monitoring	\N
185	75	1	KKF6N	Create Cost Object	\N
186	75	2	KKF7N	Change Cost Object	\N
187	75	3	KKF8N	Display Cost Object	\N
188	76	1	KKF6N	Create Cost Collector	\N
189	76	2	KKF7N	Change Cost Collector	\N
190	76	3	KKF8N	Display Cost Collector	\N
191	77	1	KE59	Create Responsibility Area	\N
192	77	2	KE5Z	Change Responsibility Area	\N
193	77	3	KE5Y	Display Responsibility Area	\N
194	78	1	KE30	Profitability Report	\N
195	78	2	KE24	Display Actual Line Items	\N
196	78	3	KEAT	Top Down Distribution	\N
197	79	1	KO88	Actual Settlement	\N
198	79	2	CJ88	Project Settlement	\N
199	79	3	VA88	Order Settlement	\N
200	80	1	KTCT	Create Template	\N
201	80	2	KTCF	Execute Template Allocation	\N
202	81	1	F2913	Create Universal Allocation Cycle	\N
203	81	2	F3547	Run Universal Allocation	\N
204	82	1	KE21N	Create Profitability Segment	\N
205	82	2	KE24	Display Profitability Segment	\N
206	82	3	KE30	Analyze Profitability Segment	\N
207	83	1	KB21N	Create Actual Activity Allocation	\N
208	83	2	KB23N	Display Actual Activity Allocation	\N
209	83	3	KSB1	Review Activity Allocation Posting	\N
210	84	1	KP26	Plan Activity Prices	\N
211	84	2	KP06	Plan Activity Quantities	\N
212	84	3	KP97	Execute Planning	\N
213	85	1	KSU1	Create Plan Assessment Cycle	\N
214	85	2	KSU2	Change Plan Assessment Cycle	\N
215	85	3	KSU5	Execute Plan Assessment	\N
216	86	1	KSV1	Create Plan Distribution Cycle	\N
217	86	2	KSV2	Change Plan Distribution Cycle	\N
218	86	3	KSV5	Execute Plan Distribution	\N
219	87	1	CK40N	Execute Cost Rollup	\N
220	87	2	CK13N	Display Cost Estimate	\N
221	87	3	CK24	Release Cost Estimate	\N
222	88	1	S_ALR_87013611	Cost Center Report	\N
223	88	2	S_ALR_87013620	Internal Order Report	\N
224	88	3	KE30	Profitability Report	\N
225	89	1	KSB1	Cost Analysis Line Items	\N
226	89	2	KOB1	Order Cost Analysis	\N
227	89	3	S_ALR_87013611	Cost Center Analysis	\N
228	90	1	KE30	Margin Analysis Report	\N
229	90	2	KE24	Review Actual Margin Data	\N
230	90	3	KEAT	Distribute Margin Data	\N
231	91	1	KKAO	Run WIP Calculation	\N
232	91	2	KKS1	Run Variance Analysis	\N
233	91	3	KO88	Execute Settlement	\N
234	92	1	FAGLL03H	Universal Journal Display	\N
235	92	2	FBL3H	G/L Line Item Analysis	\N
236	92	3	KE24	Profitability Analysis	\N
237	30	1	ME51N	Create Purchase Requisition	\N
238	93	1	ME51N	Create Purchase Requisition	\N
239	30	2	ME52N	Change Purchase Requisition	\N
240	93	2	ME52N	Change Purchase Requisition	\N
241	30	3	ME53N	Display Purchase Requisition	\N
242	93	3	ME53N	Display Purchase Requisition	\N
243	30	1	ME51N	Create Purchase Requisition	\N
244	93	1	ME51N	Create Purchase Requisition	\N
245	30	2	ME52N	Change Purchase Requisition	\N
246	93	2	ME52N	Change Purchase Requisition	\N
247	30	3	ME53N	Display Purchase Requisition	\N
248	93	3	ME53N	Display Purchase Requisition	\N
249	95	1	ME41	Create RFQ	\N
250	95	2	ME42	Change RFQ	\N
251	95	3	ME43	Display RFQ	\N
252	97	1	ME01	Create Source List	\N
253	97	2	ME02	Change Source List	\N
254	97	3	ME03	Display Source List	\N
255	98	1	MEQ1	Create Quota Arrangement	\N
256	98	2	MEQ2	Change Quota Arrangement	\N
257	98	3	MEQ3	Display Quota Arrangement	\N
258	98	1	MEQ1	Create Quota Arrangement	\N
259	98	2	MEQ2	Change Quota Arrangement	\N
260	98	3	MEQ3	Display Quota Arrangement	\N
261	99	1	XK01	Create Vendor	\N
262	99	2	XK02	Change Vendor	\N
263	99	3	XK03	Display Vendor	\N
264	99	4	MK05	Block Vendor	\N
265	101	1	MIGO	Post Goods Receipt	\N
266	101	2	MB03	Display Material Document	\N
267	101	3	MB51	Material Document List	\N
268	102	1	MIRO	Enter Invoice	\N
269	102	2	MIR4	Display Invoice Document	\N
270	102	3	MRBR	Release Blocked Invoice	\N
271	96	2	ME49	Price Comparison	\N
272	96	3	ME48	Display Quotation	\N
273	96	1	ME47	Maintain Quotation	\N
274	96	2	ME49	Price Comparison	\N
275	103	1	ME31K	Create Contract	\N
276	113	1	ME31K	Create Contract	\N
277	103	2	ME32K	Change Contract	\N
278	113	2	ME32K	Change Contract	\N
279	103	3	ME33K	Display Contract	\N
280	113	3	ME33K	Display Contract	\N
281	103	4	ME3C	Contract List	\N
282	113	4	ME3C	Contract List	\N
283	104	1	ME31L	Create Scheduling Agreement	\N
284	114	1	ME31L	Create Scheduling Agreement	\N
285	104	2	ME32L	Change Scheduling Agreement	\N
286	114	2	ME32L	Change Scheduling Agreement	\N
287	104	3	ME33L	Display Scheduling Agreement	\N
288	114	3	ME33L	Display Scheduling Agreement	\N
289	105	1	MB1B	Post Stock Transfer	\N
290	115	1	MB1B	Post Stock Transfer	\N
291	105	2	MIGO	Stock Transfer Posting	\N
292	115	2	MIGO	Stock Transfer Posting	\N
293	105	3	MB5T	Stock In Transit Report	\N
294	115	3	MB5T	Stock In Transit Report	\N
295	107	1	ME21N	Create Subcontract PO	\N
296	117	1	ME21N	Create Subcontract PO	\N
297	107	2	MIGO	Goods Receipt Subcontracting	\N
298	117	2	MIGO	Goods Receipt Subcontracting	\N
299	107	3	MB51	Subcontract Material Movement	\N
300	117	3	MB51	Subcontract Material Movement	\N
301	107	1	ME21N	Create Subcontract PO	\N
302	117	1	ME21N	Create Subcontract PO	\N
303	107	2	MIGO	Goods Receipt Subcontracting	\N
304	117	2	MIGO	Goods Receipt Subcontracting	\N
305	107	3	MB51	Subcontract Material Movement	\N
306	117	3	MB51	Subcontract Material Movement	\N
307	108	2	MRKO	Consignment Settlement	\N
308	118	2	MRKO	Consignment Settlement	\N
309	108	3	MB54	Consignment Stock Report	\N
310	118	3	MB54	Consignment Stock Report	\N
311	109	1	ME61	Maintain Vendor Evaluation	\N
312	119	1	ME61	Maintain Vendor Evaluation	\N
313	109	2	ME63	Display Vendor Evaluation	\N
314	119	2	ME63	Display Vendor Evaluation	\N
315	109	3	ME6H	Vendor Evaluation List	\N
316	119	3	ME6H	Vendor Evaluation List	\N
317	110	1	ME28	Release Purchase Documents	\N
318	120	1	ME28	Release Purchase Documents	\N
319	110	2	ME29N	Release Purchase Order	\N
320	120	2	ME29N	Release Purchase Order	\N
321	110	3	ME35K	Release Contract	\N
322	120	3	ME35K	Release Contract	\N
323	111	1	MB1A	Post Goods Issue	\N
324	121	1	MB1A	Post Goods Issue	\N
325	111	2	MIGO	Goods Issue Posting	\N
326	121	2	MIGO	Goods Issue Posting	\N
327	111	3	MB51	Goods Issue Report	\N
328	121	3	MB51	Goods Issue Report	\N
329	112	1	MB21	Create Reservation	\N
330	122	1	MB21	Create Reservation	\N
331	112	2	MB22	Change Reservation	\N
332	122	2	MB22	Change Reservation	\N
333	112	3	MB23	Display Reservation	\N
334	122	3	MB23	Display Reservation	\N
335	133	1	MIGO	Goods Movement Integration	\N
336	133	2	LT01	Create Transfer Order	\N
337	133	3	LT12	Confirm Transfer Order	\N
338	134	1	OMCG	Configure Stock Determination	\N
339	134	2	MIGO	Execute Stock Determination	\N
340	134	3	MB52	Review Stock Levels	\N
341	135	1	MD01	Run MRP	\N
342	135	2	MD04	Review Requirements	\N
343	135	3	MD06	MRP Exception List	\N
344	137	1	OMS2	Define Material Type	\N
345	137	2	MM01	Create Material By Type	\N
346	137	3	MM03	Display Material Type	\N
347	138	2	MMBE	Review Storage Location Stock	\N
348	138	3	MB52	Storage Location Report	\N
349	139	1	ME21N	Create Consignment PO	\N
350	139	2	MIGO	Receive Consignment Stock	\N
351	139	3	MB54	Review Consignment Stock	\N
352	139	1	ME21N	Create Consignment PO	\N
353	139	2	MIGO	Receive Consignment Stock	\N
354	139	3	MB54	Review Consignment Stock	\N
355	140	1	MB5B	Historical Stock Analysis	\N
356	140	2	MC.9	Inventory Turnover Analysis	\N
357	140	3	MB52	Current Stock Review	\N
358	141	1	MB52	Warehouse Stock Report	\N
359	141	2	MB5L	Inventory Value Report	\N
360	141	3	MB5B	Inventory Historical Report	\N
361	142	1	ME80FN	Purchasing Analytics	\N
362	142	2	ME2N	Purchase Order Reporting	\N
363	142	3	ME2L	Vendor Purchasing Analysis	\N
364	1	1	VA01	Create Sales Order	\N
365	34	1	VA01	Create Sales Order	\N
366	143	1	VA01	Create Sales Order	\N
367	1	1	VA01	Create Sales Order	\N
368	34	1	VA01	Create Sales Order	\N
369	143	1	VA01	Create Sales Order	\N
370	1	2	VA02	Change Sales Order	\N
371	34	2	VA02	Change Sales Order	\N
372	143	2	VA02	Change Sales Order	\N
373	1	3	VA03	Display Sales Order	\N
374	34	3	VA03	Display Sales Order	\N
375	143	3	VA03	Display Sales Order	\N
376	1	4	VA05	Sales Order List	\N
377	34	4	VA05	Sales Order List	\N
378	143	4	VA05	Sales Order List	\N
379	144	1	VA11	Create Inquiry	\N
380	144	2	VA12	Change Inquiry	\N
381	144	3	VA13	Display Inquiry	\N
382	36	1	VA21	Create Quotation	\N
383	145	1	VA21	Create Quotation	\N
384	36	2	VA22	Change Quotation	\N
385	145	2	VA22	Change Quotation	\N
386	36	3	VA23	Display Quotation	\N
387	145	3	VA23	Display Quotation	\N
388	36	4	VA25	Quotation List	\N
389	145	4	VA25	Quotation List	\N
390	36	1	VA21	Create Quotation	\N
391	145	1	VA21	Create Quotation	\N
392	36	2	VA22	Change Quotation	\N
393	145	2	VA22	Change Quotation	\N
394	36	3	VA23	Display Quotation	\N
395	145	3	VA23	Display Quotation	\N
396	36	4	VA25	Quotation List	\N
397	145	4	VA25	Quotation List	\N
398	146	1	VA41	Create Contract	\N
399	146	2	VA42	Change Contract	\N
400	146	3	VA43	Display Contract	\N
401	147	1	VL01N	Create Outbound Delivery	\N
402	147	2	VL02N	Change Outbound Delivery	\N
403	147	3	VL03N	Display Outbound Delivery	\N
404	147	4	VL06O	Delivery Monitor	\N
405	148	1	VF01	Create Billing Document	\N
406	148	2	VF02	Change Billing Document	\N
407	148	3	VF03	Display Billing Document	\N
408	148	4	VF05	Billing List	\N
409	149	1	VA01	Create Return Order	\N
410	149	2	VL01N	Create Return Delivery	\N
411	149	3	VF01	Create Return Credit	\N
412	150	1	XD01	Create Customer	\N
413	150	2	XD02	Change Customer	\N
414	150	3	XD03	Display Customer	\N
415	150	4	FD32	Maintain Credit Management	\N
416	151	1	VK11	Create Pricing Condition	\N
417	151	2	VK12	Change Pricing Condition	\N
418	151	3	VK13	Display Pricing Condition	\N
419	153	1	V_RA	Backorder Processing	\N
420	163	1	V_RA	Backorder Processing	\N
421	153	2	VA05	Review Sales Orders	\N
422	163	2	VA05	Review Sales Orders	\N
423	153	3	CO06	Availability Overview	\N
424	163	3	CO06	Availability Overview	\N
425	154	1	CO09	Availability Check	\N
426	164	1	CO09	Availability Check	\N
427	154	2	VA02	Review Confirmed Quantities	\N
428	164	2	VA02	Review Confirmed Quantities	\N
429	154	3	MD04	Stock Requirements Review	\N
430	164	3	MD04	Stock Requirements Review	\N
431	155	1	VA01	Create Free Of Charge Order	\N
432	165	1	VA01	Create Free Of Charge Order	\N
433	155	2	VL01N	Create Delivery	\N
434	165	2	VL01N	Create Delivery	\N
435	155	3	VL02N	Post Goods Issue	\N
436	165	3	VL02N	Post Goods Issue	\N
437	156	1	VA01	Create Third Party Order	\N
438	166	1	VA01	Create Third Party Order	\N
439	156	2	ME21N	Automatic Purchase Order	\N
440	166	2	ME21N	Automatic Purchase Order	\N
441	156	3	VF01	Customer Billing	\N
442	166	3	VF01	Customer Billing	\N
443	157	1	VA01	Create Intercompany Sales Order	\N
444	167	1	VA01	Create Intercompany Sales Order	\N
445	157	2	VL01N	Create Delivery	\N
446	167	2	VL01N	Create Delivery	\N
447	157	3	VF01	Intercompany Billing	\N
448	167	3	VF01	Intercompany Billing	\N
449	158	1	KB21N	Fill-Up Consignment Stock	\N
450	168	1	KB21N	Fill-Up Consignment Stock	\N
451	158	2	VA01	Consignment Issue	\N
452	168	2	VA01	Consignment Issue	\N
453	158	3	VF01	Consignment Billing	\N
454	168	3	VF01	Consignment Billing	\N
455	159	1	VA01	Create Debit Memo Request	\N
456	169	1	VA01	Create Debit Memo Request	\N
457	159	2	VF01	Create Debit Memo	\N
458	169	2	VF01	Create Debit Memo	\N
459	159	3	VF03	Display Debit Memo	\N
460	169	3	VF03	Display Debit Memo	\N
461	160	1	VV11	Create Output Condition	\N
462	170	1	VV11	Create Output Condition	\N
463	160	2	VV12	Change Output Condition	\N
464	170	2	VV12	Change Output Condition	\N
465	160	3	VV13	Display Output Condition	\N
466	170	3	VV13	Display Output Condition	\N
467	161	1	VDH1N	Create Customer Hierarchy	\N
468	171	1	VDH1N	Create Customer Hierarchy	\N
469	161	2	VDH2N	Change Customer Hierarchy	\N
470	171	2	VDH2N	Change Customer Hierarchy	\N
471	161	3	VDH3N	Display Customer Hierarchy	\N
472	171	3	VDH3N	Display Customer Hierarchy	\N
473	162	1	OVXD	Maintain Shipping Point	\N
474	172	1	OVXD	Maintain Shipping Point	\N
475	162	2	VL06O	Monitor Deliveries	\N
476	172	2	VL06O	Monitor Deliveries	\N
477	162	3	VL03N	Review Delivery	\N
478	172	3	VL03N	Review Delivery	\N
479	173	1	VA31	Create Scheduling Agreement	\N
480	173	2	VA32	Change Scheduling Agreement	\N
481	173	3	VA33	Display Scheduling Agreement	\N
482	174	1	VA01	Create Cash Sale Order	\N
483	174	2	VL01N	Immediate Delivery	\N
484	174	3	VF01	Cash Sale Billing	\N
485	175	1	VA01	Create Rush Order	\N
486	175	2	VL01N	Immediate Delivery Creation	\N
487	175	3	VL02N	Post Goods Issue	\N
488	176	1	FD32	Maintain Credit Limit	\N
489	176	2	VKM1	Blocked Orders	\N
490	176	3	VKM3	Release Sales Orders	\N
491	177	1	VB01	Create Rebate Agreement	\N
492	177	2	VB02	Change Rebate Agreement	\N
493	177	3	VB03	Display Rebate Agreement	\N
494	178	1	VA41	Create Billing Plan Contract	\N
495	178	2	VA42	Maintain Billing Plan	\N
496	178	3	VF04	Billing Due List	\N
497	179	1	VL10A	Delivery Due List	\N
498	179	2	VL01N	Create Scheduled Delivery	\N
499	179	3	VL06O	Monitor Delivery Execution	\N
500	180	1	VA01	Create Return Order	\N
501	180	2	VF01	Create Return Credit Memo	\N
502	180	3	VF03	Display Credit Memo	\N
503	181	1	VA05	Sales Order Analytics	\N
504	181	2	VF05	Billing Analytics	\N
505	181	3	MC+E	Sales Information System	\N
506	182	1	MC94	Create Sales Forecast	\N
507	182	2	MC95	Forecast Evaluation	\N
508	182	3	MC90	Forecast Analysis	\N
509	7	1	IW31	Create Work Order	\N
510	38	1	IW31	Create Work Order	\N
511	183	1	IW31	Create Work Order	\N
512	7	2	IW32	Change Work Order	\N
513	38	2	IW32	Change Work Order	\N
514	183	2	IW32	Change Work Order	\N
515	7	3	IW33	Display Work Order	\N
516	38	3	IW33	Display Work Order	\N
517	183	3	IW33	Display Work Order	\N
518	7	4	IW38	Work Order List	\N
519	38	4	IW38	Work Order List	\N
520	183	4	IW38	Work Order List	\N
521	6	1	IP01	Create Maintenance Plan	\N
522	37	1	IP01	Create Maintenance Plan	\N
523	184	1	IP01	Create Maintenance Plan	\N
524	6	2	IP02	Change Maintenance Plan	\N
525	37	2	IP02	Change Maintenance Plan	\N
526	184	2	IP02	Change Maintenance Plan	\N
527	6	3	IP03	Display Maintenance Plan	\N
528	37	3	IP03	Display Maintenance Plan	\N
529	184	3	IP03	Display Maintenance Plan	\N
530	6	4	IP10	Schedule Maintenance Plan	\N
531	37	4	IP10	Schedule Maintenance Plan	\N
532	184	4	IP10	Schedule Maintenance Plan	\N
533	8	1	IE01	Create Equipment	\N
534	39	1	IE01	Create Equipment	\N
535	185	1	IE01	Create Equipment	\N
536	8	2	IE02	Change Equipment	\N
537	39	2	IE02	Change Equipment	\N
538	185	2	IE02	Change Equipment	\N
539	8	3	IE03	Display Equipment	\N
540	39	3	IE03	Display Equipment	\N
541	185	3	IE03	Display Equipment	\N
542	8	4	IH08	Equipment List	\N
543	39	4	IH08	Equipment List	\N
544	185	4	IH08	Equipment List	\N
545	186	1	IL01	Create Functional Location	\N
546	186	2	IL02	Change Functional Location	\N
547	186	3	IL03	Display Functional Location	\N
548	186	4	IL05	Functional Location List	\N
549	187	1	IW21	Create Notification	\N
550	187	2	IW22	Change Notification	\N
551	187	3	IW23	Display Notification	\N
552	187	4	IW28	Notification List	\N
553	188	1	IP01	Create Preventive Plan	\N
554	188	2	IP10	Schedule Plan	\N
555	188	3	IW38	Generated Work Orders	\N
556	189	1	IW21	Create Breakdown Notification	\N
557	189	2	IW31	Create Breakdown Work Order	\N
558	189	3	IW32	Process Repair Order	\N
559	190	1	IA05	Create Task List	\N
560	190	2	IA06	Change Task List	\N
561	190	3	IA07	Display Task List	\N
562	191	1	IK01	Create Measuring Point	\N
563	191	2	IK11	Record Measurement Reading	\N
564	191	3	IK17	Measurement Document List	\N
565	192	1	IW81	Create Refurbishment Order	\N
566	192	2	IW82	Change Refurbishment Order	\N
567	192	3	IW83	Display Refurbishment Order	\N
568	193	1	IP41	Create Maintenance Item	\N
569	193	2	IP42	Change Maintenance Item	\N
570	193	3	IP43	Display Maintenance Item	\N
571	194	1	IP11	Create Maintenance Strategy	\N
572	194	2	IP12	Change Maintenance Strategy	\N
573	194	3	IP13	Display Maintenance Strategy	\N
574	195	1	IP11	Create Maintenance Package	\N
575	195	2	IP12	Change Maintenance Package	\N
576	195	3	IP13	Display Maintenance Package	\N
577	196	1	IK01	Create Measuring Point	\N
578	196	2	IK02	Change Measuring Point	\N
579	196	3	IK03	Display Measuring Point	\N
580	197	1	IK11	Create Measuring Document	\N
581	197	2	IK12	Change Measuring Document	\N
582	197	3	IK13	Display Measuring Document	\N
583	198	1	IW31	Create Work Requiring Permit	\N
584	198	2	IW32	Assign Permit	\N
585	198	3	IW33	Review Permit Status	\N
586	199	1	IW31	Create Shutdown Order	\N
587	199	2	IW38	Coordinate Shutdown Work	\N
588	199	3	IW39	Shutdown Order Analysis	\N
589	200	1	CM01	Capacity Planning	\N
590	200	2	CM25	Capacity Leveling	\N
591	200	3	CM50	Capacity Evaluation	\N
592	201	1	IW37N	Schedule Maintenance Workforce	\N
593	201	2	IW38	Monitor Assigned Work	\N
594	201	3	IW39	Workforce Performance Review	\N
595	202	1	IL01	Create Linear Asset	\N
596	202	2	IL02	Change Linear Asset	\N
597	202	3	IL03	Display Linear Asset	\N
598	11	1	F-02	Post G/L Document	\N
599	40	1	F-02	Post G/L Document	\N
600	203	1	F-02	Post G/L Document	\N
601	11	2	FB03	Display G/L Document	\N
602	40	2	FB03	Display G/L Document	\N
603	203	2	FB03	Display G/L Document	\N
604	11	3	FB08	Reverse G/L Document	\N
605	40	3	FB08	Reverse G/L Document	\N
606	203	3	FB08	Reverse G/L Document	\N
607	11	4	FBL3N	G/L Line Item Display	\N
608	40	4	FBL3N	G/L Line Item Display	\N
609	203	4	FBL3N	G/L Line Item Display	\N
610	204	1	FB60	Post Vendor Invoice	\N
611	204	2	F110	Automatic Payment Run	\N
612	204	3	FBL1N	Vendor Line Items	\N
613	204	4	FK03	Display Vendor Master	\N
614	205	1	FB70	Create Customer Invoice	\N
615	205	2	F-28	Incoming Customer Payment	\N
616	205	3	FBL5N	Customer Line Items	\N
617	205	4	FD33	Customer Balance Display	\N
618	9	1	FB60	Create Vendor Invoice	\N
619	41	1	FB60	Create Vendor Invoice	\N
620	206	1	FB60	Create Vendor Invoice	\N
621	9	2	FB02	Change Vendor Invoice	\N
622	41	2	FB02	Change Vendor Invoice	\N
623	206	2	FB02	Change Vendor Invoice	\N
624	9	3	FB03	Display Vendor Invoice	\N
625	41	3	FB03	Display Vendor Invoice	\N
626	206	3	FB03	Display Vendor Invoice	\N
627	9	4	FBL1N	Vendor Invoice Analysis	\N
628	41	4	FBL1N	Vendor Invoice Analysis	\N
629	206	4	FBL1N	Vendor Invoice Analysis	\N
630	207	1	FB70	Create Customer Invoice	\N
631	207	2	FB75	Create Credit Memo	\N
632	207	3	FB03	Display Customer Invoice	\N
633	207	4	FBL5N	Customer Invoice Analysis	\N
634	208	1	F110	Create Payment Proposal	\N
635	208	2	F110	Execute Payment Run	\N
636	208	3	FBZP	Maintain Payment Configuration	\N
637	209	1	FF67	Manual Bank Statement	\N
638	209	2	FF_5	Electronic Bank Statement	\N
639	209	3	FEBAN	Bank Statement Reprocessing	\N
640	210	1	AS01	Create Asset	\N
641	210	2	AS02	Change Asset	\N
642	210	3	AS03	Display Asset	\N
643	210	4	AW01N	Asset Explorer	\N
644	211	1	FBD1	Create Recurring Entry	\N
645	211	2	FBD2	Change Recurring Entry	\N
646	211	3	F.14	Execute Recurring Entries	\N
647	212	1	FBS1	Create Accrual Document	\N
648	212	2	F.81	Accrual Posting Run	\N
649	212	3	FB03	Review Accrual Posting	\N
650	213	1	OB52	Open/Close Posting Period	\N
651	213	2	F.16	Balance Carry Forward	\N
652	213	3	F.01	Financial Statements	\N
653	214	1	FTXP	Maintain Tax Codes	\N
654	214	2	FB60	Post Tax Relevant Invoice	\N
655	214	3	S_ALR_87012357	Tax Reporting	\N
656	215	1	F-28	Post Incoming Payment	\N
657	215	2	FBL5N	Review Customer Items	\N
658	215	3	FD33	Review Customer Balance	\N
659	216	1	F110	Execute Vendor Payment	\N
660	216	2	FBL1N	Review Vendor Items	\N
661	216	3	FK03	Display Vendor	\N
662	217	1	F150	Execute Dunning Run	\N
663	217	2	F150	Generate Dunning Notice	\N
664	217	3	FBL5N	Review Overdue Items	\N
665	218	1	FBCJ	Create Cash Journal Entry	\N
666	218	2	FBCJ	Post Cash Transaction	\N
667	218	2	FBCJ	Post Cash Transaction	\N
668	218	3	FBCJ	Cash Journal Reporting	\N
669	218	1	FBCJ	Create Cash Journal Entry	\N
670	218	2	FBCJ	Post Cash Transaction	\N
671	218	3	FBCJ	Cash Journal Reporting	\N
672	219	1	AFAB	Execute Depreciation Run	\N
673	219	2	AW01N	Review Asset Values	\N
674	219	3	AR02	Adjust Depreciation Parameters	\N
675	220	1	F-92	Post Asset Retirement	\N
676	220	2	AW01N	Review Retired Asset	\N
677	220	3	ABAVN	Asset Retirement With Revenue	\N
678	221	1	KE5Z	Profit Center Reporting	\N
679	221	2	KE53	Display Profit Center	\N
680	221	3	KE30	Profitability Review	\N
681	222	1	FAGL_SPLIT_ANALYZE	Document Split Analysis	\N
682	222	2	FB03	Review Split Document	\N
683	222	3	FAGLL03H	Universal Journal Review	\N
684	223	1	F.05	Foreign Currency Valuation	\N
685	223	2	FAGL_FCV	Review Valuation Results	\N
686	223	3	FB03	Display Valuation Posting	\N
687	224	1	FB50	Post Intercompany Entry	\N
688	224	2	FB03	Review Intercompany Posting	\N
689	224	3	F.01	Intercompany Reporting	\N
690	225	1	FF_5	Import Bank Statement	\N
691	225	2	FEBAN	Process Exceptions	\N
692	225	3	FEBA	Review Posted Items	\N
693	226	2	F-48	Vendor Down Payment	\N
694	226	3	F-54	Down Payment Clearing	\N
695	227	1	FD32	Maintain Credit Limit	\N
696	227	2	F.31	Credit Exposure Review	\N
697	227	3	FD33	Customer Credit Analysis	\N
698	228	1	FLB1	Import Lockbox File	\N
699	228	2	FLB2	Post Lockbox Receipts	\N
700	228	3	FBL5N	Review Customer Clearing	\N
701	229	1	F.01	Balance Sheet Reporting	\N
702	229	2	S_ALR_87012284	Financial Statement Analysis	\N
703	229	3	FAGLB03	Financial Reporting	\N
704	230	1	F-32	Customer Clearing	\N
705	230	2	F-44	Vendor Clearing	\N
706	230	3	F.13	Automatic Clearing	\N
707	231	1	FBV1	Park Document	\N
708	231	2	FBV2	Change Parked Document	\N
709	231	3	FBV3	Display Parked Document	\N
710	232	1	F.19	GR IR Reconciliation	\N
711	232	2	MB5S	GR IR Analysis	\N
712	232	3	MR11	GR IR Adjustment	\N
713	47	1	CO01	Create Production Order	\N
714	233	1	CO01	Create Production Order	\N
715	47	2	CO02	Change Production Order	\N
716	233	2	CO02	Change Production Order	\N
717	47	3	CO03	Display Production Order	\N
718	233	3	CO03	Display Production Order	\N
719	47	4	COHV	Mass Order Processing	\N
720	233	4	COHV	Mass Order Processing	\N
721	234	1	MD11	Create Planned Order	\N
722	234	2	MD12	Change Planned Order	\N
723	234	3	MD13	Display Planned Order	\N
724	235	1	MD01	Run MRP	\N
725	235	2	MD04	Stock Requirements List	\N
726	235	3	MD06	MRP Exception Messages	\N
727	235	4	MD07	Current Material Situation	\N
728	236	1	CS01	Create BOM	\N
729	236	2	CS02	Change BOM	\N
730	236	3	CS03	Display BOM	\N
731	236	4	CS11	BOM Explosion	\N
732	237	1	CA01	Create Routing	\N
733	237	2	CA02	Change Routing	\N
734	237	3	CA03	Display Routing	\N
735	237	4	CA85N	Mass Routing Processing	\N
736	238	1	CR01	Create Work Center	\N
737	238	2	CR02	Change Work Center	\N
738	238	3	CR03	Display Work Center	\N
739	239	1	CO11N	Enter Confirmation	\N
740	239	2	CO14	Display Confirmation	\N
741	239	3	CO15	Collective Confirmation	\N
742	200	1	CM01	Capacity Planning	\N
743	240	1	CM01	Capacity Planning	\N
744	200	2	CM25	Capacity Leveling	\N
745	240	2	CM25	Capacity Leveling	\N
746	200	3	CM50	Capacity Evaluation	\N
747	240	3	CM50	Capacity Evaluation	\N
748	241	1	C223	Create Production Version	\N
749	241	2	C223	Maintain Production Version	\N
750	241	3	MM03	Review Production Version	\N
751	242	1	COHV	Production Order Monitoring	\N
752	242	2	COOIS	Production Information System	\N
753	242	3	MF50	Production Planning Table	\N
754	243	1	COR1	Create Process Order	\N
755	243	2	COR2	Change Process Order	\N
756	243	3	COR3	Display Process Order	\N
757	244	1	MF50	Planning Table	\N
758	244	2	MFBF	Backflush Repetitive Manufacturing	\N
759	244	3	MF47	Reporting Point Confirmation	\N
760	245	1	MS01	Run Long Term Planning	\N
761	245	2	MS04	Display Planning Results	\N
762	245	3	MS31	Create Planning Scenario	\N
763	246	1	MD61	Create Planned Independent Requirements	\N
764	246	2	MD62	Change PIR	\N
765	246	3	MD63	Display PIR	\N
766	247	1	CF01	Create PRT	\N
767	247	2	CF02	Change PRT	\N
768	247	3	CF03	Display PRT	\N
769	248	1	CO02	Assign Batch Determination	\N
770	248	2	MSC3N	Display Batch	\N
771	248	3	COGI	Batch Issue Review	\N
772	249	1	PK01	Create Kanban Control Cycle	\N
773	249	2	PK13N	Kanban Board	\N
774	249	3	PKMC	Kanban Monitoring	\N
775	250	1	MFBF	Execute Backflush	\N
776	250	2	MB51	Material Movements Review	\N
777	250	3	COGI	Error Processing	\N
778	251	1	CC01	Create Change Number	\N
779	251	2	CC02	Change Engineering Record	\N
780	251	3	CC03	Display Engineering Record	\N
781	252	1	MCBT	Production Analysis	\N
782	252	2	COOIS	Production Information System	\N
783	252	3	MC.9	Production KPI Review	\N
784	253	1	MS01	Run Master Production Scheduling	\N
785	253	2	MS04	Display MPS Results	\N
786	253	3	MD04	Review Planned Supply	\N
787	254	1	CO01	Create Production Campaign Order	\N
788	254	2	COHV	Campaign Mass Processing	\N
789	254	3	COOIS	Campaign Monitoring	\N
790	255	1	KKBC_ORD	Production Cost Analysis	\N
791	255	2	KOB1	Production Cost Line Items	\N
792	255	3	S_ALR_87012993	Production Cost Report	\N
793	256	1	KO88	Settle Production Order	\N
794	256	2	CO03	Review Order Settlement	\N
795	256	3	KOB1	Settlement Analysis	\N
796	257	1	KKS2	Variance Analysis	\N
797	257	2	KKS1	Calculate Variances	\N
798	257	3	CO03	Review Production Order	\N
799	258	1	CO02	Release Production Order	\N
800	258	2	CO11N	Production Confirmation	\N
801	258	3	MIGO	Finished Goods Receipt	\N
802	259	1	COOIS	Review Open Orders	\N
803	259	2	COHV	Mass Order Processing	\N
804	259	3	MD04	Review Material Shortages	\N
805	260	1	CC01	Create Change Number	\N
806	260	2	CC02	Maintain Change Number	\N
807	260	3	CC03	Display Change Number	\N
808	261	1	MC$G	Production KPI Dashboard	\N
809	261	2	COOIS	Production KPI Analysis	\N
810	261	3	MC.9	Manufacturing Performance Review	\N
811	262	1	CM01	Resource Capacity Planning	\N
812	262	2	CM25	Resource Leveling	\N
813	262	3	CR03	Review Resource Utilization	\N
814	14	1	QA01	Create Inspection Lot	\N
815	45	1	QA01	Create Inspection Lot	\N
816	263	1	QA01	Create Inspection Lot	\N
817	14	2	QA02	Change Inspection Lot	\N
818	45	2	QA02	Change Inspection Lot	\N
819	263	2	QA02	Change Inspection Lot	\N
820	14	3	QA03	Display Inspection Lot	\N
821	45	3	QA03	Display Inspection Lot	\N
822	263	3	QA03	Display Inspection Lot	\N
823	14	4	QA32	Process Inspection Lot	\N
824	45	4	QA32	Process Inspection Lot	\N
825	263	4	QA32	Process Inspection Lot	\N
826	15	1	QM01	Create Quality Notification	\N
827	46	1	QM01	Create Quality Notification	\N
828	264	1	QM01	Create Quality Notification	\N
829	15	2	QM02	Change Quality Notification	\N
830	46	2	QM02	Change Quality Notification	\N
831	264	2	QM02	Change Quality Notification	\N
832	15	3	QM03	Display Quality Notification	\N
833	46	3	QM03	Display Quality Notification	\N
834	264	3	QM03	Display Quality Notification	\N
835	15	4	QM10	Notification List	\N
836	46	4	QM10	Notification List	\N
837	264	4	QM10	Notification List	\N
838	265	1	QE51N	Record Inspection Results	\N
839	265	2	QE11	Display Results	\N
840	265	3	QE03	Results Analysis	\N
841	266	1	QA11	Create Usage Decision	\N
842	266	2	QA12	Change Usage Decision	\N
843	266	3	QA13	Display Usage Decision	\N
844	267	1	QC01	Create Quality Certificate	\N
845	267	2	QC02	Change Quality Certificate	\N
846	267	3	QC03	Display Quality Certificate	\N
847	268	1	QI01	Vendor Inspection Setup	\N
848	268	2	QA32	Vendor Inspection Processing	\N
849	268	3	ME63	Vendor Evaluation Review	\N
850	269	1	QM01	Create Customer Complaint	\N
851	269	2	QM02	Investigate Complaint	\N
852	269	3	QM03	Close Complaint	\N
853	270	1	QAUDIT	Create Audit Plan	\N
854	270	2	QAUDIT	Execute Audit	\N
855	270	3	QAUDIT	Audit Reporting	\N
856	271	1	IK11	Record Calibration Reading	\N
857	271	2	QA32	Calibration Inspection	\N
858	271	3	QA11	Calibration Acceptance	\N
859	272	1	MCXA	Quality KPI Reporting	\N
860	272	2	MCXB	Defect Trend Analysis	\N
861	272	3	MCXC	Quality Performance Dashboard	\N
862	273	1	QP01	Create Inspection Plan	\N
863	273	2	QP02	Change Inspection Plan	\N
864	273	3	QP03	Display Inspection Plan	\N
865	274	1	QE51N	Record Defect	\N
866	274	2	QM10	Review Defects	\N
867	274	3	QM11	Defect Analysis	\N
868	275	1	QM01	Create Improvement Initiative	\N
869	275	2	QM02	Maintain Improvement Plan	\N
870	275	3	QM03	Review Improvement Effectiveness	\N
871	276	1	QAUDIT	Create Supplier Audit	\N
872	276	2	QAUDIT	Execute Supplier Audit	\N
873	276	3	QAUDIT	Supplier Audit Reporting	\N
874	277	1	QAUDIT	Create Internal Audit	\N
875	277	2	QAUDIT	Perform Internal Audit	\N
876	277	3	QAUDIT	Close Internal Audit	\N
877	278	1	MCXA	Generate Quality Scorecard	\N
878	278	2	MCXB	KPI Trend Analysis	\N
879	278	3	MCXC	Management Quality Dashboard	\N
880	279	1	QM01	Create Non Conformance	\N
881	279	2	QM02	Investigate Non Conformance	\N
882	279	3	QM03	Close Non Conformance	\N
883	280	1	QM01	Create Corrective Action	\N
884	280	2	QM02	Implement Corrective Action	\N
885	280	3	QM03	Verify Corrective Action	\N
886	281	1	QM01	Create Preventive Action	\N
887	281	2	QM02	Implement Preventive Action	\N
888	281	3	QM03	Validate Preventive Action	\N
889	282	1	MCXA	Quality Cost Analysis	\N
890	283	1	QS21	Create Inspection Method	\N
891	283	2	QS22	Change Inspection Method	\N
892	283	3	QS23	Display Inspection Method	\N
893	284	1	QDV1	Create Sampling Procedure	\N
894	284	2	QDV2	Change Sampling Procedure	\N
895	284	3	QDV3	Display Sampling Procedure	\N
896	285	1	QP01	Create Control Plan	\N
897	285	2	QP02	Change Control Plan	\N
898	285	3	QP03	Display Control Plan	\N
899	286	1	QA01	Create Quality Agreement	\N
900	286	2	QA02	Update Quality Agreement	\N
901	286	3	QA03	Review Quality Agreement	\N
902	287	1	QM01	Create Supplier Complaint	\N
903	287	2	QM02	Investigate Supplier Complaint	\N
904	287	3	QM03	Close Supplier Complaint	\N
905	288	1	QM10	Customer Issue Registration	\N
906	288	2	QM11	Issue Investigation	\N
907	288	3	QM12	Customer Feedback Closure	\N
908	289	1	MCXA	Defect Trend Analysis	\N
909	289	2	MCXB	Trend Reporting	\N
910	289	3	MCXC	Quality Trend Dashboard	\N
911	290	1	QE51N	Defect Capture	\N
912	290	2	QM10	Defect Analysis	\N
913	290	3	MCXA	Defect KPI Reporting	\N
914	291	1	QM01	Create Risk Assessment	\N
915	291	2	QM02	Evaluate Risk Controls	\N
916	291	3	QM03	Approve Risk Mitigation	\N
917	292	1	MCXA	Generate Quality KPI Dashboard	\N
918	292	2	MCXB	Quality KPI Analysis	\N
919	292	3	MCXC	Executive Quality Review	\N
920	12	1	LT01	Create Transfer Order	\N
921	43	1	LT01	Create Transfer Order	\N
922	293	1	LT01	Create Transfer Order	\N
923	12	2	LT02	Change Transfer Order	\N
924	43	2	LT02	Change Transfer Order	\N
925	293	2	LT02	Change Transfer Order	\N
926	12	3	LT03	Display Transfer Order	\N
927	43	3	LT03	Display Transfer Order	\N
928	293	3	LT03	Display Transfer Order	\N
929	12	4	LT12	Confirm Transfer Order	\N
930	43	4	LT12	Confirm Transfer Order	\N
931	293	4	LT12	Confirm Transfer Order	\N
932	294	1	LT01	Create Putaway Transfer Order	\N
933	294	2	LT10	Putaway Bin Allocation	\N
934	294	3	LT12	Confirm Putaway	\N
935	295	1	LT03	Pick List Display	\N
936	295	2	LT12	Confirm Picking	\N
937	295	3	VL02N	Post Picking Confirmation	\N
938	105	1	LT09	Stock Transfer Request	\N
939	115	1	LT09	Stock Transfer Request	\N
940	296	1	LT09	Stock Transfer Request	\N
941	105	2	LT10	Internal Stock Transfer	\N
942	115	2	LT10	Internal Stock Transfer	\N
943	296	2	LT10	Internal Stock Transfer	\N
944	105	3	LT12	Confirm Stock Transfer	\N
945	115	3	LT12	Confirm Stock Transfer	\N
946	296	3	LT12	Confirm Stock Transfer	\N
947	297	1	LS01N	Create Storage Bin	\N
948	297	2	LS02N	Change Storage Bin	\N
949	297	3	LS03N	Display Storage Bin	\N
950	298	1	LP21	Create Replenishment Proposal	\N
951	298	2	LT01	Create Replenishment TO	\N
952	298	3	LT12	Confirm Replenishment	\N
953	299	1	LT0F	Warehouse Goods Receipt	\N
954	299	2	LT01	Generate Putaway TO	\N
955	299	3	LT12	Confirm Putaway	\N
956	300	1	LT03	Create Picking TO	\N
957	300	2	LT12	Confirm Picking TO	\N
958	300	3	VL02N	Post Goods Issue	\N
959	301	1	LX26	Cycle Counting Selection	\N
960	301	2	LI11N	Enter Physical Count	\N
961	301	3	LI20	Clear Inventory Differences	\N
962	302	1	LX03	Bin Status Report	\N
963	302	2	LX02	Warehouse Stock Overview	\N
964	302	3	LT24	Open Transfer Orders	\N
965	303	1	LT0E	Create Wave Picking TO	\N
966	303	2	LT12	Confirm Wave Picking	\N
967	303	3	VL06P	Picking Monitor	\N
968	304	1	LT01	Cross Dock Transfer Order	\N
969	304	2	LT12	Cross Dock Confirmation	\N
970	304	3	LX03	Cross Dock Monitoring	\N
971	305	1	OMLY	Configure Placement Strategy	\N
972	305	2	LT01	Execute Placement	\N
973	305	3	LX02	Validate Bin Occupancy	\N
974	306	1	OMLW	Create Storage Type	\N
975	306	2	OMLV	Maintain Storage Type	\N
976	306	3	LX03	Review Storage Utilization	\N
977	307	1	LI20	Review Inventory Differences	\N
978	307	2	LI21	Post Inventory Differences	\N
979	307	3	LX26	Difference Analysis	\N
980	308	1	LT10	Warehouse Reorganization Transfer	\N
981	308	2	LT12	Confirm Reorganization	\N
982	308	3	LX02	Review Warehouse Layout	\N
983	309	1	LT01	Create Return TO	\N
984	309	2	LT12	Confirm Return Handling	\N
985	309	3	LX03	Returns Stock Review	\N
986	310	1	LS01N	Create Bulk Storage Bin	\N
987	310	2	LS02N	Maintain Bulk Storage Bin	\N
988	310	3	LX03	Review Bulk Storage Usage	\N
989	311	1	LT24	Review Open TOs	\N
990	311	2	LT22	Analyze TO Delays	\N
991	311	3	LX03	Warehouse Activity Review	\N
992	312	1	LX03	Warehouse KPI Collection	\N
993	312	2	MC.9	Warehouse KPI Analysis	\N
994	312	3	LX02	Warehouse Dashboard Review	\N
995	50	1	FF7A	Cash Position	\N
996	313	1	FF7A	Cash Position	\N
997	50	2	FF7B	Liquidity Forecast	\N
998	313	2	FF7B	Liquidity Forecast	\N
999	50	3	FF7C	Cash Analysis	\N
1000	313	3	FF7C	Cash Analysis	\N
1001	314	1	FF63	Liquidity Planning	\N
1002	314	2	FF64	Liquidity Forecast	\N
1003	314	3	FF65	Liquidity Review	\N
1004	315	1	TPM13	Treasury Position Overview	\N
1005	315	2	TPM20	Treasury Deal Analysis	\N
1006	315	3	TPM44	Treasury Evaluation	\N
1007	316	1	BNK_MONI	Bank Communication Monitor	\N
1008	316	2	FF_5	Bank Statement Import	\N
1009	316	3	FEBAN	Statement Exception Processing	\N
1010	317	1	TBEX	Create FX Transaction	\N
1011	317	2	TPM1	Manage FX Exposure	\N
1012	317	3	TPM44	FX Valuation	\N
1013	318	1	IM01	Create Investment Program	\N
1014	318	2	IM02	Change Investment Program	\N
1015	318	3	IM03	Display Investment Program	\N
1016	319	1	FTR_CREATE	Create Loan Contract	\N
1017	319	2	FTR_EDIT	Maintain Debt Instrument	\N
1018	319	3	TPM13	Debt Portfolio Review	\N
1019	320	1	TPM44	Treasury Reporting	\N
1020	320	2	FF7A	Cash Analytics	\N
1021	320	3	TPM13	Treasury Dashboard	\N
1022	321	1	IHC0	Create Internal Payment	\N
1023	321	2	IHC1	Process Internal Transfer	\N
1024	321	3	IHC3	In House Cash Reporting	\N
1025	322	1	TPM20	Risk Exposure Analysis	\N
1026	322	2	TPM44	Risk Valuation	\N
1027	322	3	TPM13	Risk Dashboard	\N
1028	323	1	TM01	Create Money Market Deal	\N
1029	323	2	TM02	Change Money Market Deal	\N
1030	323	3	TM03	Display Money Market Deal	\N
1031	324	1	FWZZ	Create Security Position	\N
1032	324	2	TPM13	Security Portfolio Review	\N
1033	324	3	TPM44	Security Valuation	\N
1034	325	1	TBB1	Create Derivative Position	\N
1035	325	2	TPM20	Derivative Exposure Review	\N
1036	325	3	TPM44	Derivative Valuation	\N
1037	326	1	TPM28	Create Hedge Relationship	\N
1038	326	2	TPM29	Maintain Hedge Relationship	\N
1039	326	3	TPM44	Evaluate Hedge Effectiveness	\N
1040	327	1	F110	Generate Treasury Payments	\N
1041	327	2	BNK_MONI	Transmit Payment File	\N
1042	327	3	FF7A	Review Payment Position	\N
1043	328	1	FF7A	Review Cash Position	\N
1044	328	2	IHC1	Execute Internal Cash Transfer	\N
1045	328	3	FF7B	Review Concentrated Position	\N
1046	329	1	FI12	Create Bank Account	\N
1047	329	2	FI13	Maintain Bank Account	\N
1048	329	3	NWBC	Bank Account Review	\N
1049	330	1	FF7A	Liquidity Analysis	\N
1050	330	2	FF7B	Liquidity Forecast Review	\N
1051	330	3	TPM13	Liquidity Dashboard	\N
1052	331	1	FF63	Create Treasury Forecast	\N
1053	331	2	FF64	Review Forecast	\N
1054	331	3	FF65	Forecast Variance Analysis	\N
1055	332	1	TPM20	Compliance Monitoring	\N
1056	332	2	TPM44	Compliance Evaluation	\N
1057	332	3	TPM13	Compliance Reporting	\N
1058	51	1	/SAPAPO/SDP94	Create Demand Plan	\N
1059	333	1	/SAPAPO/SDP94	Create Demand Plan	\N
1060	51	2	/SAPAPO/MC62	Maintain Forecast	\N
1061	333	2	/SAPAPO/MC62	Maintain Forecast	\N
1062	51	3	/SAPAPO/SDP94	Demand Plan Review	\N
1063	333	3	/SAPAPO/SDP94	Demand Plan Review	\N
1064	52	1	/SAPAPO/RRP3	Supply Planning	\N
1065	334	1	/SAPAPO/RRP3	Supply Planning	\N
1066	52	2	/SAPAPO/CDPS0	Capacity Evaluation	\N
1067	334	2	/SAPAPO/CDPS0	Capacity Evaluation	\N
1068	52	3	/SAPAPO/RRP4	Supply Review	\N
1069	334	3	/SAPAPO/RRP4	Supply Review	\N
1070	335	1	VT01N	Create Shipment	\N
1071	335	2	VT02N	Maintain Shipment	\N
1072	335	3	VT03N	Display Shipment	\N
1073	336	1	/SAPAPO/TLB10	Transportation Load Builder	\N
1074	336	2	/SAPAPO/SNP94	Distribution Plan	\N
1075	336	3	/SAPAPO/SCC_TQ1	Distribution Analysis	\N
1076	337	1	MC.9	Inventory Analysis	\N
1077	337	2	MB52	Inventory Review	\N
1078	337	3	MD04	Supply Demand Review	\N
1079	338	1	/SAPAPO/SDP94	Collaborative Forecast	\N
1080	338	2	/SAPAPO/MC62	Forecast Validation	\N
1081	338	3	/SAPAPO/SDP94	Forecast Approval	\N
1082	339	1	/SAPAPO/SNP94	Create Network Plan	\N
1083	339	2	/SAPAPO/SCC_TQ1	Network Optimization	\N
1084	339	3	/SAPAPO/RRP3	Execution Planning	\N
1085	340	1	GATP	Global ATP Check	\N
1086	340	2	CO09	Availability Analysis	\N
1087	340	3	/SAPAPO/AC42	ATP Simulation	\N
1088	341	1	VL10A	Delivery Collaboration	\N
1089	341	2	VT01N	Transportation Collaboration	\N
1090	341	3	LX03	Logistics Visibility	\N
1091	342	1	MC.9	Supply Chain KPI Analysis	\N
1092	342	2	/SAPAPO/SCC_TQ1	Supply Chain Dashboard	\N
1093	342	3	/SAPAPO/SDP94	Forecast Accuracy Analysis	\N
\.


--
-- Data for Name: script_master; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.script_master (script_id, script_name, description, module, version, status, created_by, created_date, updated_date, transaction_code, flow_id) FROM stdin;
4	Creat PM Master record 	This is End to End test	PM	1	Draft	Biranchi	2026-07-14 15:17:07.407971	2026-07-14 15:17:07.407971	IW31	\N
\.


--
-- Data for Name: script_steps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.script_steps (id, script_id, step_sequence, action_type, parameter_name, parameter_value) FROM stdin;
9	4	1	LOGIN	Login to SAP	None
12	4	2	EXECUTE_FLOW	FLOW	IW31
13	4	3	EXECUTE_FLOW	FLOW	IW32
14	4	4	EXECUTE_FLOW	FLOW	IW33
15	4	5	EXECUTE_FLOW	FLOW	IW41
16	4	6	EXECUTE_FLOW	FLOW	ME51N
18	4	7	LOGOUT	Logout from SAP	None
19	101	1	START_TRANSACTION	TCODE	IW31
\.


--
-- Data for Name: test_cases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_cases (id, test_case_id, title, module, company_code, e2e_process, scenario, transaction_code, process_step, priority, automation_status, created_date, script_path, asset_name) FROM stdin;
22	TC0003	KS03_DISPLAY_COST_CENTER3	CO	\N	\N	\N	KS03	Description: Display Cost Center\r\nSteps:\r\n1.\tExecute KS03\r\n2.\tEnter Cost Center\r\n3.\tDisplay Master Data\r\n4.\tVerify Organization Assignment\r\n5.\tVerify Validity Dates\r\n6.\tVerify Cost Center Status\r\n	\N	Automated	2026-07-21 14:46:54.714918	KS03_DISPLAY_COST_CENTER.py	\N
23	TC0004	KS04_BLOCK_COST_CENTER3	CO	\N	\N	\N	KS04	Description: Block Cost Center\r\nSteps:\r\n1.\tExecute KS04\r\n2.\tEnter Cost Center\r\n3.\tDisplay Master Data\r\n4.\tDelete \r\n	\N	Automated	2026-07-21 14:47:29.072942	KS04_BLOCK_COST_CENTER.py	\N
24	TC0005	HELLO_WORLD_TEST	E2E	\N	\N	\N	HELLO	MCSTAP Execution Test	\N	Automated	2026-07-21 15:18:08.3486	HELLO_WORLD_TEST.py	\N
25	TC0006	Test day and time	E2E	\N	\N	\N	DATE	Date and time	\N	Automated	2026-07-22 07:37:54.03672	REPOSITORY_ENGINE_TEST.py	\N
20	TC0001	KS01_CREATE_COST_CENTER	CO	\N	\N	\N	KS01	Description: Create Cost Center\r\nSteps:\r\n1.\tExecute KS01\r\n2.\tEnter Controlling Area\r\n3.\tEnter Cost Center ID\r\n4.\tEnter Name and Description\r\n5.\tEnter Valid From Date\r\n6.\tAssign Cost Center Category\r\n7.\tAssign Profit Center\r\n8.\tSave\r\n9.\tVerify Cost Center created successfully\r\n	\N	Automated	2026-07-21 14:45:06.8352	KS01_CREATE_COST_CENTER.py	\N
27	TC0008	ME21N Create Purchase Order	MM	\N	\N	\N	ME21N	Description: Create Purchase Order\r\nSteps:\r\n1.\tExecute ME21N\r\n2.\tSelect Vendor\r\n3.\tReference Purchase Requisition\r\n4.\tVerify pricing\r\n5.\tVerify delivery schedule\r\n6.\tSave\r\n7.\tVerify PO Number created\r\n	\N	Automated	2026-07-22 09:35:15.836436	ME21N_CREATE_PURCHAGE_ORDER.py	\N
26	TC0007	ME51N Create Purchase Requisition	MM	\N	\N	\N	ME51N	Description: Create Purchase Requisition\r\nSteps:\r\n1.\tExecute ME51N\r\n2.\tEnter Material\r\n3.\tEnter Quantity\r\n4.\tEnter Plant\r\n5.\tEnter Delivery Date\r\n6.\tSave\r\n7.\tVerify PR Number generated\r\n	\N	Automated	2026-07-22 09:34:07.328954	ME51N_CREATE_PURCHASE_REQISITION.py	\N
28	TC0009	ME22N Change Purchase Order	MM	\N	\N	\N	ME22N	Description: Change Purchase Order\r\nSteps:\r\n1.\tExecute ME22N\r\n2.\tEnter PO Number\r\n3.\tModify quantity\r\n4.\tUpdate delivery date\r\n5.\tSave\r\n6.\tVerify changes\r\n\r\n	\N	Automated	2026-07-22 09:37:03.622502	ME22N_CHANGE_PURCHAGE_ORDER.py	\N
29	TC0010	ME23N Display Purchase Order	MM	\N	\N	\N	ME23N	Description: Display Purchase Order\r\nSteps:\r\n1.\tExecute ME23N\r\n2.\tEnter PO Number\r\n3.\tValidate Header\r\n4.\tValidate Items\r\n5.\tValidate Conditions\r\n6.\tValidate History\r\n	\N	Automated	2026-07-22 09:40:05.11645	ME51N_DISPLAY_PURCHASE_ORDER.py	\N
21	TC0002	KS02_MODIFY_COST_CENTER	CO	\N	\N	\N	KS02	Description: Change Cost Center\r\nSteps:\r\n1.\tExecute KS02\r\n2.\tEnter Cost Center\r\n3.\tSelect Change\r\n4.\tModify Description\r\n5.\tModify Responsible Person\r\n6.\tSave\r\n7.\tVerify changes updated\r\n	\N	Automated	2026-07-21 14:45:48.275047	KS02_MODIFY_COST_CENTER.py	\N
\.


--
-- Data for Name: test_coverage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_coverage (id, name, is_multi_module, parent_id) FROM stdin;
1	SAP Upgrade SP05 2026 	t	\N
2	Test	t	\N
3		f	\N
4	Test1	t	\N
5	Test1	t	\N
6	Test1	f	\N
7	Test1	t	\N
\.


--
-- Data for Name: test_coverage_modules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_coverage_modules (id, coverage_id, module) FROM stdin;
1	1	Sales Distribution/SD
2	1	Supply Chain Transaction
3	1	Test
4	1	Treasury
5	1	Warehouse Management
6	2	Sales Distribution/SD
7	2	Supply Chain Transaction
8	2	Test
9	2	Treasury
10	2	Warehouse Management
11	4	Sales Distribution/SD
12	4	Supply Chain Transaction
13	4	Test
14	4	Treasury
15	4	Warehouse Management
16	5	Sales Distribution/SD
17	5	Supply Chain Transaction
18	5	Test
19	5	Treasury
20	5	Warehouse Management
21	6	Sales Distribution/SD
22	7	Sales Distribution/SD
23	7	Supply Chain Transaction
24	7	Test
25	7	Treasury
26	7	Warehouse Management
\.


--
-- Data for Name: test_coverage_structure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_coverage_structure (id, module, process, test_type) FROM stdin;
1628	Plant Maintenance/PM	IW32	E2E
1630	Plant Maintenance/PM	Belupo PM Test	Functional
1631	Plant Maintenance/PM	Belupo PM Test	E2E
1633	Logistics/LO	Test Coverage	Functional
1634	Logistics/LO	Test Coverage	Functional
1635	Sales Distribution/SD	Test Coverage	E2E
1641	Plant Maintenance/PM	PODD	Standalone
\.


--
-- Data for Name: test_coverage_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_coverage_types (id, coverage_id, test_type) FROM stdin;
1	2	E2E
2	2	Functional
3	2	Negative
4	2	Standalone
5	2	Regression
6	3	E2E
7	3	Functional
8	3	Negative
9	3	Standalone
10	3	Regression
11	4	E2E
12	4	Functional
13	4	Negative
14	4	Standalone
15	4	Regression
16	5	E2E
17	5	Functional
18	5	Negative
19	5	Standalone
20	5	Regression
21	6	E2E
22	6	Functional
23	6	Negative
24	6	Standalone
25	6	Regression
26	7	E2E
27	7	Functional
28	7	Negative
29	7	Standalone
30	7	Regression
\.


--
-- Data for Name: test_execution_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_execution_history (id, test_id, module, process, test_type, status, executed_at) FROM stdin;
1	4755	MM	Material to display	E2E	FAILED	2026-06-23 15:02:15.257188
2	4756	MM	Material to display	E2E	PASSED	2026-06-23 15:02:16.163857
3	4757	MM	Material to display	E2E	FAILED	2026-06-23 15:02:17.14007
4	4773	FI	Financial Report	E2E	FAILED	2026-06-23 15:02:21.286198
5	4774	FI	Financial Report	E2E	PASSED	2026-06-23 15:02:22.242766
6	4775	FI	Financial Report	E2E	FAILED	2026-06-23 15:02:23.192841
7	4764	FI	Financial Report	E2E	PASSED	2026-06-23 15:02:24.040275
8	4765	FI	Financial Report	E2E	FAILED	2026-06-23 15:02:24.850781
9	4766	FI	Financial Report	E2E	PASSED	2026-06-23 15:02:25.708372
10	4773	FI	Financial Report	E2E	FAILED	2026-06-24 09:45:50.556711
11	4774	FI	Financial Report	E2E	PASSED	2026-06-24 09:45:51.486589
12	4775	FI	Financial Report	E2E	FAILED	2026-06-24 09:45:52.40587
13	4764	FI	Financial Report	E2E	PASSED	2026-06-24 09:45:53.157333
14	4765	FI	Financial Report	E2E	FAILED	2026-06-24 09:45:54.136386
15	4766	FI	Financial Report	E2E	PASSED	2026-06-24 09:45:54.940744
16	4773	FI	Financial Report	E2E	FAILED	2026-06-24 09:52:25.187156
17	4774	FI	Financial Report	E2E	PASSED	2026-06-24 09:52:26.097553
18	4775	FI	Financial Report	E2E	FAILED	2026-06-24 09:52:26.987964
19	4764	FI	Financial Report	E2E	PASSED	2026-06-24 09:52:27.812801
20	4765	FI	Financial Report	E2E	FAILED	2026-06-24 09:52:28.820459
21	4766	FI	Financial Report	E2E	PASSED	2026-06-24 09:52:29.75193
22	4773	FI	Financial Report	E2E	FAILED	2026-06-24 09:56:26.499445
23	4774	FI	Financial Report	E2E	PASSED	2026-06-24 09:56:27.289182
24	4775	FI	Financial Report	E2E	FAILED	2026-06-24 09:56:28.149317
25	4764	FI	Financial Report	E2E	PASSED	2026-06-24 09:56:29.033334
26	4765	FI	Financial Report	E2E	FAILED	2026-06-24 09:56:29.958138
27	4766	FI	Financial Report	E2E	PASSED	2026-06-24 09:56:30.786098
28	4773	FI	Financial Report	E2E	FAILED	2026-06-24 09:58:28.62753
29	4774	FI	Financial Report	E2E	PASSED	2026-06-24 09:58:29.462677
30	4775	FI	Financial Report	E2E	FAILED	2026-06-24 09:58:30.340955
31	4764	FI	Financial Report	E2E	PASSED	2026-06-24 09:58:31.125557
32	4765	FI	Financial Report	E2E	FAILED	2026-06-24 09:58:32.008725
33	4766	FI	Financial Report	E2E	PASSED	2026-06-24 09:58:32.882415
34	3992	Sales Distribution/SD	Order-To-Cash	Standalone	PASSED	2026-06-24 10:04:01.125878
35	3985	Sales Distribution/SD	Order-To-Cash	Standalone	FAILED	2026-06-24 10:04:02.129452
36	3978	Sales Distribution/SD	Order-To-Cash	Standalone	PASSED	2026-06-24 10:04:02.980273
37	3971	Sales Distribution/SD	Order-To-Cash	Standalone	FAILED	2026-06-24 10:04:03.894868
38	3992	Sales Distribution/SD	Order-To-Cash	Standalone	PASSED	2026-06-24 10:08:34.196941
39	3985	Sales Distribution/SD	Order-To-Cash	Standalone	FAILED	2026-06-24 10:08:35.036645
40	3978	Sales Distribution/SD	Order-To-Cash	Standalone	PASSED	2026-06-24 10:08:35.839656
41	3971	Sales Distribution/SD	Order-To-Cash	Standalone	FAILED	2026-06-24 10:08:36.712144
42	4801	SD	Order-to-Cash	E2E	FAILED	2026-06-24 15:12:54.377521
43	4802	SD	Order-to-Cash	E2E	PASSED	2026-06-24 15:12:55.105191
44	4803	SD	Order-to-Cash	E2E	FAILED	2026-06-24 15:12:56.047833
45	4740	SD	Order-to-Cash	E2E	PASSED	2026-06-24 15:12:56.887355
46	4741	SD	Order-to-Cash	E2E	FAILED	2026-06-24 15:12:57.803623
47	4742	SD	Order-to-Cash	E2E	PASSED	2026-06-24 15:12:58.656039
48	4725	SD	Order-to-Cash	E2E	FAILED	2026-06-24 15:12:59.580646
49	4726	SD	Order-to-Cash	E2E	PASSED	2026-06-24 15:13:00.480073
50	4727	SD	Order-to-Cash	E2E	FAILED	2026-06-24 15:13:01.368686
51	4792	SD	Order-to-Cash	E2E	PASSED	2026-06-24 15:13:02.165178
52	4793	SD	Order-to-Cash	E2E	FAILED	2026-06-24 15:13:02.988801
53	4794	SD	Order-to-Cash	E2E	PASSED	2026-06-24 15:13:03.792719
54	3972	Sales Distribution/SD	Order-To-Cash	E2E	PASSED	2026-06-25 08:53:02.023543
55	3973	Sales Distribution/SD	Order-To-Cash	E2E	FAILED	2026-06-25 08:53:03.103414
56	3974	Sales Distribution/SD	Order-To-Cash	E2E	PASSED	2026-06-25 08:53:04.032459
57	3979	Sales Distribution/SD	Order-To-Cash	E2E	FAILED	2026-06-25 08:53:04.975301
58	3980	Sales Distribution/SD	Order-To-Cash	E2E	PASSED	2026-06-25 08:53:05.822214
59	3981	Sales Distribution/SD	Order-To-Cash	E2E	FAILED	2026-06-25 08:53:06.725168
60	3986	Sales Distribution/SD	Order-To-Cash	E2E	PASSED	2026-06-25 08:53:07.531383
61	3987	Sales Distribution/SD	Order-To-Cash	E2E	FAILED	2026-06-25 08:53:08.475169
62	3988	Sales Distribution/SD	Order-To-Cash	E2E	PASSED	2026-06-25 08:53:09.389059
63	4882	Sales Distribution/SD	Order-To-Cash	E2E	PASSED	2026-06-25 08:53:10.276016
64	4883	Sales Distribution/SD	Order-To-Cash	E2E	FAILED	2026-06-25 08:53:11.230524
65	4884	Sales Distribution/SD	Order-To-Cash	E2E	PASSED	2026-06-25 08:53:12.166912
66	3965	Sales Distribution/SD	Order-To-Cash	E2E	FAILED	2026-06-25 08:53:13.154864
67	3966	Sales Distribution/SD	Order-To-Cash	E2E	PASSED	2026-06-25 08:53:14.034146
68	3967	Sales Distribution/SD	Order-To-Cash	E2E	FAILED	2026-06-25 08:53:14.925838
69	3968	Sales Distribution/SD	Order-To-Cash	Functional	PASSED	2026-06-25 08:53:39.581108
70	3969	Sales Distribution/SD	Order-To-Cash	Functional	FAILED	2026-06-25 08:53:40.567311
71	3975	Sales Distribution/SD	Order-To-Cash	Functional	FAILED	2026-06-25 08:53:41.554143
72	3976	Sales Distribution/SD	Order-To-Cash	Functional	PASSED	2026-06-25 08:53:42.439475
73	4887	Sales Distribution/SD	Order-To-Cash	Functional	FAILED	2026-06-25 08:53:43.369557
74	3982	Sales Distribution/SD	Order-To-Cash	Functional	PASSED	2026-06-25 08:53:44.242918
75	3983	Sales Distribution/SD	Order-To-Cash	Functional	FAILED	2026-06-25 08:53:45.166568
76	3989	Sales Distribution/SD	Order-To-Cash	Functional	FAILED	2026-06-25 08:53:46.038445
77	3990	Sales Distribution/SD	Order-To-Cash	Functional	PASSED	2026-06-25 08:53:46.96485
78	4885	Sales Distribution/SD	Order-To-Cash	Functional	FAILED	2026-06-25 08:53:47.943236
79	4886	Sales Distribution/SD	Order-To-Cash	Functional	PASSED	2026-06-25 08:53:48.801773
80	3970	Sales Distribution/SD	Order-To-Cash	Negative	PASSED	2026-06-25 08:54:01.236393
81	3977	Sales Distribution/SD	Order-To-Cash	Negative	FAILED	2026-06-25 08:54:02.603636
82	3984	Sales Distribution/SD	Order-To-Cash	Negative	PASSED	2026-06-25 08:54:03.52347
83	3991	Sales Distribution/SD	Order-To-Cash	Negative	FAILED	2026-06-25 08:54:04.476845
84	4888	Sales Distribution/SD	Order-To-Cash	Negative	PASSED	2026-06-25 08:54:05.330808
85	4889	Sales Distribution/SD	Order-To-Cash	Negative	FAILED	2026-06-25 08:54:06.270751
86	4890	Sales Distribution/SD	Order-To-Cash	Negative	PASSED	2026-06-25 08:54:07.158819
\.


--
-- Data for Name: test_steps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_steps (id, scenario_id, transaction_code, process_step, test_step_name, company_code, module, sequence, e2e_process, step_description, expected_result, step_number, step_id, execution_status) FROM stdin;
13280	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	PODD	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1	7488	\N
13281	ZN01 - A1	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	PODD	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	2	7489	\N
13282	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	PODD	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	3	7490	\N
13283	ZN01 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	PODD	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	4	7491	\N
13284	ZN02 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	PODD	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	5	7492	\N
13285	ZN02 - AA	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	PODD	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	6	7493	\N
13286	ZN02 - AA	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	PODD	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	7	7494	\N
13287	ZN02 - AA	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	PODD	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	8	7495	\N
13288	ZNBM - A1	VA01	Kreira se nalog bez otpreme/Create Order without shipping	Kreira se nalog bez otpreme/Create Order without shipping	PODD	Sales Distribution/SD	\N	Nalog bez otpreme / Order without shipping	Kreira se nalog bez otpreme/Create Order without shipping	Kreira se nalog bez otpreme/Create Order without shipping	9	7496	\N
13289	ZNBM - A1	VF01	Kreira se faktura/Create invoice	Kreira se faktura/Create invoice	PODD	Sales Distribution/SD	\N	Nalog bez otpreme / Order without shipping	Kreira se faktura/Create invoice	Kreira se faktura/Create invoice	10	7497	\N
13290	ZNBO - A1	VA01	Kreira se nalog bez otpreme/Create Order without shipping	Kreira se nalog bez otpreme/Create Order without shipping	PODD	Sales Distribution/SD	\N	Nalog bez otpreme / Order without shipping	Kreira se nalog bez otpreme/Create Order without shipping	Kreira se nalog bez otpreme/Create Order without shipping	11	7498	\N
13291	ZNBO - A1	VF01	Kreira se faktura/Create invoice	Kreira se faktura/Create invoice	PODD	Sales Distribution/SD	\N	Nalog bez otpreme / Order without shipping	Kreira se faktura/Create invoice	Kreira se faktura/Create invoice	12	7499	\N
13292	ZNOI - AA	VA01	Kreira se nalog bez otpreme/Create Order without shipping	Kreira se nalog bez otpreme/Create Order without shipping	PODD	Sales Distribution/SD	\N	Nalog bez otpreme / Order without shipping	Kreira se nalog bez otpreme/Create Order without shipping	Kreira se nalog bez otpreme/Create Order without shipping	13	7500	\N
13293	ZNOI - AA	VF01	Kreira se faktura/Create invoice	Kreira se faktura/Create invoice	PODD	Sales Distribution/SD	\N	Nalog bez otpreme / Order without shipping	Kreira se faktura/Create invoice	Kreira se faktura/Create invoice	14	7501	\N
13294	ZPVP - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	PODD	Sales Distribution/SD	\N	Obračun sponzorstva - roba / Calculation of sponsorship - goods	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	15	7502	\N
13295	ZPVP - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	PODD	Sales Distribution/SD	\N	Obračun sponzorstva - roba / Calculation of sponsorship - goods	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	16	7503	\N
13296	ZPVP - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	PODD	Sales Distribution/SD	\N	Obračun sponzorstva - roba / Calculation of sponsorship - goods	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	17	7504	\N
13297	ZUS - A1	VA01	Kreiraj prodajni nalog/Create sales  order	Kreiraj prodajni nalog/Create sales  order	PODD	Sales Distribution/SD	\N	Obračun sponzorstva - usluga / Calculation of sponsorship - service	Kreiraj prodajni nalog/Create sales  order	Kreiraj prodajni nalog/Create sales  order	18	7505	\N
13298	ZUS - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	PODD	Sales Distribution/SD	\N	Obračun sponzorstva - usluga / Calculation of sponsorship - service	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	19	7506	\N
13299	ZTRM - A1	ZODO	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	PODD	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	20	7507	\N
13300	ZTRM - AA	ZODO	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	PODD	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	21	7508	\N
13301	ZNR	ZODO	Pregled sporazuma o rabatu/Overview of rebate agreements	Pregled sporazuma o rabatu/Overview of rebate agreements	PODD	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Pregled sporazuma o rabatu/Overview of rebate agreements	Pregled sporazuma o rabatu/Overview of rebate agreements	22	7509	\N
13302	ZNR	ZODO	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	PODD	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	23	7510	\N
13303	ZNR-A1	VF01	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	PODD	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	24	7511	\N
13304	ZNR	VF02	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	PODD	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	25	7512	\N
13305	ZNR - A1	ZODO	Pregled sporazuma o rabatu/Overview of rebate agreements	Pregled sporazuma o rabatu/Overview of rebate agreements	PODD	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Pregled sporazuma o rabatu/Overview of rebate agreements	Pregled sporazuma o rabatu/Overview of rebate agreements	26	7513	\N
13306	ZNR - AA	ZODO	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	PODD	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	27	7514	\N
13307	ZNR - AA	VF01	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	PODD	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	28	7515	\N
13308	ZN04 - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	29	7516	\N
13309	ZN04 - A1, proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	30	7517	\N
13310	ZN04 - A1, usluge	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	31	7518	\N
13311	ZN04 - A1, usluge	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	32	7519	\N
13312	ZN05 - A1,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	33	7520	\N
13313	ZN05 - A1,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	34	7521	\N
13314	ZN06 - A1,  usluge	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	35	7522	\N
13315	ZN06 - A1,  usluge	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	36	7523	\N
13316	ZN06 - A1,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	37	7524	\N
13317	ZN06 - A1,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	38	7525	\N
13318	ZN07 - A1,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	39	7526	\N
13319	ZN07 - A1,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	40	7527	\N
13320	ZN04 - AA, usluge	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	41	7528	\N
13321	ZN04 - AA, usluge	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	42	7529	\N
13322	ZN04 - AA,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	43	7530	\N
13323	ZN04 - AA,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	44	7531	\N
13324	ZN05 - AA,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	45	7532	\N
13703	ZN02 - AA	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	HUMA	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	424	7911	\N
13325	ZN05 - AA,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	46	7533	\N
13326	ZN06 - AA,  usluge	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	47	7534	\N
13327	ZN06 - AA,  usluge	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	48	7535	\N
13328	ZN06 - AA,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	49	7536	\N
13329	ZN06 - AA,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	50	7537	\N
13330	ZN07 - AA,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	51	7538	\N
13331	ZN07 - AA,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	52	7539	\N
13332	ZN1 - A1	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	53	7540	\N
13333	ZN1 - A1	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	54	7541	\N
13334	ZN08 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	PODD	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	55	7542	\N
13335	ZN08 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	PODD	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	56	7543	\N
13336	ZN08 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	PODD	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	57	7544	\N
13337	ZN09 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	PODD	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	58	7545	\N
13338	ZN09 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	PODD	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	59	7546	\N
13339	ZN09 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	PODD	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	60	7547	\N
13340	ZN08 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	PODD	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	61	7548	\N
13341	ZN08 - AA	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	PODD	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	62	7549	\N
13342	ZN08 - AA	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	PODD	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	63	7550	\N
13343	ZN09 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	PODD	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	64	7551	\N
13344	ZN09 - AA	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	PODD	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	65	7552	\N
13345	ZN09 - AA	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	PODD	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	66	7553	\N
13346	ZCRM - A1	VA01	Kreiraj nalog odobrenja/Create  an approval order	Kreiraj nalog odobrenja/Create  an approval order	PODD	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje -  financijsko odobrenje / Sale of goods through retail – financial a	Kreiraj nalog odobrenja/Create  an approval order	Kreiraj nalog odobrenja/Create  an approval order	67	7554	\N
13466	TEST	ZOKR	TM obavijest ZOKR/ TM notification  ZOKR	TM obavijest ZOKR/ TM notification  ZOKR	POLJ	Sales Distribution/SD	\N	TM obavijest ZOKR/ TM notification  ZOKR	TM obavijest ZOKR/ TM notification  ZOKR	TM obavijest ZOKR/ TM notification  ZOKR	187	7674	\N
13347	ZCRM - A1	VF01	Kreiraj financijsko odobrenje maloprodaje / Create a retail financial approval	Kreiraj financijsko odobrenje maloprodaje / Create a retail financial approval	PODD	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje -  financijsko odobrenje / Sale of goods through retail – financial a	Kreiraj financijsko odobrenje maloprodaje / Create a retail financial approval	Kreiraj financijsko odobrenje maloprodaje / Create a retail financial approval	68	7555	\N
13348	ZPNM - A1	VA01	Kreiraj nalog povrata/Create  a return order	Kreiraj nalog povrata/Create  a return order	PODD	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje -  povrat / Sale of goods through retail - return	Kreiraj nalog povrata/Create  a return order	Kreiraj nalog povrata/Create  a return order	69	7556	\N
13349	ZPNM - A1	VL01N	Kreiraj isporuku povrata/Create  a delivery of return	Kreiraj isporuku povrata/Create  a delivery of return	PODD	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje -  povrat / Sale of goods through retail - return	Kreiraj isporuku povrata/Create  a delivery of return	Kreiraj isporuku povrata/Create  a delivery of return	70	7557	\N
13350	ZPNM - A1	VF01	Kreiraj  povrat zaduženja maloprodaje/ Create chergeback	Kreiraj  povrat zaduženja maloprodaje/ Create chergeback	PODD	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje -  povrat / Sale of goods through retail - return	Kreiraj  povrat zaduženja maloprodaje/ Create chergeback	Kreiraj  povrat zaduženja maloprodaje/ Create chergeback	71	7558	\N
13351	ZREM - A1	VA01	Kreiraj nalog povrata/Create  a return order	Kreiraj nalog povrata/Create  a return order	PODD	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje -  povrat / Sale of goods through retail - return	Kreiraj nalog povrata/Create  a return order	Kreiraj nalog povrata/Create  a return order	72	7559	\N
13352	ZREM - A1	VL01N	Kreiraj isporuku povrata/Create  a delivery of return	Kreiraj isporuku povrata/Create  a delivery of return	PODD	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje -  povrat / Sale of goods through retail - return	Kreiraj isporuku povrata/Create  a delivery of return	Kreiraj isporuku povrata/Create  a delivery of return	73	7560	\N
13353	ZREM - A1	VF01	Kreiraj  povrat zaduženja maloprodaje/ Create chergeback	Kreiraj  povrat zaduženja maloprodaje/ Create chergeback	PODD	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje -  povrat / Sale of goods through retail - return	Kreiraj  povrat zaduženja maloprodaje/ Create chergeback	Kreiraj  povrat zaduženja maloprodaje/ Create chergeback	74	7561	\N
13354	ZMP - A1	VA01	Kreiraj prodajni nalog- /Create sales order	Kreiraj prodajni nalog- /Create sales order	PODD	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje - zaduženje / Sale of goods through retail - debit	Kreiraj prodajni nalog- /Create sales order	Kreiraj prodajni nalog- /Create sales order	75	7562	\N
13355	ZMP - A1	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	PODD	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje - zaduženje / Sale of goods through retail - debit	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	76	7563	\N
13356	ZMP - A1	VF01	Kreiraj zaduženje maloprodaje /  Create retail charge	Kreiraj zaduženje maloprodaje /  Create retail charge	PODD	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje - zaduženje / Sale of goods through retail - debit	Kreiraj zaduženje maloprodaje /  Create retail charge	Kreiraj zaduženje maloprodaje /  Create retail charge	77	7564	\N
13357	ZN02 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	78	7565	\N
13358	ZN02 - AA	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	79	7566	\N
13359	ZN02 - AA	VT01N	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	80	7567	\N
13360	ZN02 - AA	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	81	7568	\N
13361	ZN01 - A1	VA01	Kriraj prodajni nalog/Create Sales Order	Kriraj prodajni nalog/Create Sales Order	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - sa dokazom isporuke/Sale of goods from stock on the dome	Kriraj prodajni nalog/Create Sales Order	Kriraj prodajni nalog/Create Sales Order	82	7569	\N
13362	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - sa dokazom isporuke/Sale of goods from stock on the dome	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	83	7570	\N
13363	ZN01 - A1	VLPOD	Kreiraj dokaz isporuke/Create evidence of delivery	Kreiraj dokaz isporuke/Create evidence of delivery	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - sa dokazom isporuke/Sale of goods from stock on the dome	Kreiraj dokaz isporuke/Create evidence of delivery	Kreiraj dokaz isporuke/Create evidence of delivery	84	7571	\N
13364	ZN01 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - sa dokazom isporuke/Sale of goods from stock on the dome	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	85	7572	\N
13365	ZN03 - AA	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	PODD	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	86	7573	\N
13366	ZN03 - AA	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	PODD	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	87	7574	\N
13367	ZN03 - A1	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	PODD	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	88	7575	\N
14712	TEST	ZOBJ	TEST	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1433	8920	\N
13368	ZN03 - A1	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	PODD	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	89	7576	\N
13369	ZRR - A1	VA01	Kreiraj nalog isporuka bez fakture/ Create a delivery order without an invoice	Kreiraj nalog isporuka bez fakture/ Create a delivery order without an invoice	PODD	Sales Distribution/SD	\N	Robne rezerve / Commodity reserves	Kreiraj nalog isporuka bez fakture/ Create a delivery order without an invoice	Kreiraj nalog isporuka bez fakture/ Create a delivery order without an invoice	90	7577	\N
13370	ZRR - A1	VL01N	Kreiraj isporuku/Create delivery	Kreiraj isporuku/Create delivery	PODD	Sales Distribution/SD	\N	Robne rezerve / Commodity reserves	Kreiraj isporuku/Create delivery	Kreiraj isporuku/Create delivery	91	7578	\N
13371	TEST	ZOKR	TM obavijest ZOKR/ TM notification  ZOKR	Kreiraj TM obavijest/Create TM notification	PODD	Sales Distribution/SD	\N	TM obavijest ZOKR/ TM notification  ZOKR	Kreiraj TM obavijest/Create TM notification	TM obavijest ZOKR/ TM notification  ZOKR	92	7579	\N
13372	ZORT - AA	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	PODD	Sales Distribution/SD	\N	Tranzitna prodaja-  izvoz / Transit sales - export	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	93	7580	\N
13373	ZORT - AA	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	PODD	Sales Distribution/SD	\N	Tranzitna prodaja-  izvoz / Transit sales - export	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	94	7581	\N
13374	TEST	VB21	Kreiraj prodajni ugovor/Create a sales contract	Kreiraj prodajni ugovor/Create a sales contract	PODD	Sales Distribution/SD	\N	Upravljanje prodajnim ugovorima (javna nabava) / Management of sales contracts (public procurement)	Kreiraj prodajni ugovor/Create a sales contract	Kreiraj prodajni ugovor/Create a sales contract	95	7582	\N
13375	TEST	VB22	Promjeni prodajni ugovor/change the  sales contract	Promjeni prodajni ugovor/change the  sales contract	PODD	Sales Distribution/SD	\N	Upravljanje prodajnim ugovorima (javna nabava) / Management of sales contracts (public procurement)	Promjeni prodajni ugovor/change the  sales contract	Promjeni prodajni ugovor/change the  sales contract	96	7583	\N
13376	TEST	VB23	Prikaži prodajni ugovor/Show  sales contract	Prikaži prodajni ugovor/Show  sales contract	PODD	Sales Distribution/SD	\N	Upravljanje prodajnim ugovorima (javna nabava) / Management of sales contracts (public procurement)	Prikaži prodajni ugovor/Show  sales contract	Prikaži prodajni ugovor/Show  sales contract	97	7584	\N
13377	ZMPU - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	PODD	Sales Distribution/SD	\N	Zaduženje maloprodaje – ugostiteljstvo / Retail debt - hospitality	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	98	7585	\N
13378	ZMPU - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	PODD	Sales Distribution/SD	\N	Zaduženje maloprodaje – ugostiteljstvo / Retail debt - hospitality	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	99	7586	\N
13379	ZMPU - A1	VF01	Kreiraj zaduženje maloprodaje/Create retail charge	Kreiraj zaduženje maloprodaje/Create retail charge	PODD	Sales Distribution/SD	\N	Zaduženje maloprodaje – ugostiteljstvo / Retail debt - hospitality	Kreiraj zaduženje maloprodaje/Create retail charge	Kreiraj zaduženje maloprodaje/Create retail charge	100	7587	\N
13380	ZTRM - A1	ZODO	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	BEPO	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	101	7588	\N
13381	ZNR - AA	VF02	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	PODD	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	102	7589	\N
13382	ZN04 - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	BEPO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	103	7590	\N
13383	ZN04 - A1, proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	BEPO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	104	7591	\N
13384	ZN06 - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	BEPO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	105	7592	\N
13385	ZN06 - A1, proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	BEPO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	106	7593	\N
13386	ZN05 - A1,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	BEPO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	107	7594	\N
13387	ZN05 - A1,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	BEPO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	108	7595	\N
13388	ZN07 - A1,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	BEPO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	109	7596	\N
14599	ZN01	BUSINESS CONECT	slanje fakture	slanje fakture na knjiženje - IV	ZITO	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	slanje fakture na knjiženje - IV	slanje fakture	1320	8807	\N
14824	test	IW31	csjadbc	jcndslknbclk	BEPO	Plant Mainet	\N	E2E	\N	\N	\N	9032	\N
13389	ZN07 - A1,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	BEPO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	110	7597	\N
13390	ZN08 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	BEPO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	111	7598	\N
13391	ZN08 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	BEPO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	112	7599	\N
13392	ZN08 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	BEPO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	113	7600	\N
13393	ZREB - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	BEPO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	114	7601	\N
13394	ZREB - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	BEPO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	115	7602	\N
13395	ZREB - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	BEPO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	116	7603	\N
13396	ZN09 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	BEPO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	117	7604	\N
13397	ZN09 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	BEPO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	118	7605	\N
13398	ZN01 - A1	ZPRNAR	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	119	7606	\N
13399	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	120	7607	\N
13400	ZN01 - A1	VT01N	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	121	7608	\N
13401	ZN01 - A1	VI01	Kreiraj obračun troškova/Create cost report	Kreiraj obračun troškova/Create cost report	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj obračun troškova/Create cost report	Kreiraj obračun troškova/Create cost report	122	7609	\N
13402	ZN01 - A1	VF01	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	123	7610	\N
13403	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	124	7611	\N
13404	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	125	7612	\N
13405	ZN01 - A1	VT01N	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	126	7613	\N
13446	ZCEO - AA, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	LACZ	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	167	7654	\N
13406	ZN01 - A1	VI01	Kreiraj obračun troškova/Create cost report	Kreiraj obračun troškova/Create cost report	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj obračun troškova/Create cost report	Kreiraj obračun troškova/Create cost report	127	7614	\N
13407	ZN01 - A1	VF01	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	128	7615	\N
13408	ZN03 - A1	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	BEPO	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	129	7616	\N
13409	ZN03 - A1	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	BEPO	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	130	7617	\N
13410	TEST	MCSI	Standardne analize prodaje/Standard sales analyses	Pozovi standardnu analizu prodaje/Call Standard Analyses of Sales	BEPO	Sales Distribution/SD	\N	Standardne analize prodaje / Standard sales analyses	Pozovi standardnu analizu prodaje/Call Standard Analyses of Sales	Standardne analize prodaje/Standard sales analyses	131	7618	\N
13411	TEST	VK11	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Kreiranje prodajnih cijena i uvjeta/Creating of sales prices and conditions	BEPO	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Kreiranje prodajnih cijena i uvjeta/Creating of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	132	7619	\N
13412	TEST	VK12	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Promjena prodajnih cijena i uvjeta/ Change of sales prices and conditions	BEPO	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Promjena prodajnih cijena i uvjeta/ Change of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	133	7620	\N
13413	TEST	VK13	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Pregled prodajnih cijena i uvjeta/View of sales prices and conditions	BEPO	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Pregled prodajnih cijena i uvjeta/View of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	134	7621	\N
13414	ZN02 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	ZITO	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	135	7622	\N
13415	ZN02 - AA	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	ZITO	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	136	7623	\N
13416	ZN11 - AA	VA01	Kreiraj prodajni nalog punjenje konsignacije/Create sales order filling consignment	Kreiraj prodajni nalog punjenje konsignacije/Create sales order filling consignment	ZITO	Sales Distribution/SD	\N	Konsignacija kupca - punjenje / Buyer's consignment - charge	Kreiraj prodajni nalog punjenje konsignacije/Create sales order filling consignment	Kreiraj prodajni nalog punjenje konsignacije/Create sales order filling consignment	137	7624	\N
13417	ZN11 - AA	VL01N	Kreiraj izlaznu isporuku punjenja konsignacije/Create an outbound consignment fill delivery	Kreiraj izlaznu isporuku punjenja konsignacije/Create an outbound consignment fill delivery	ZITO	Sales Distribution/SD	\N	Konsignacija kupca - punjenje / Buyer's consignment - charge	Kreiraj izlaznu isporuku punjenja konsignacije/Create an outbound consignment fill delivery	Kreiraj izlaznu isporuku punjenja konsignacije/Create an outbound consignment fill delivery	138	7625	\N
13418	ZTRM - A1	ZODO	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	ZITO	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	139	7626	\N
13419	ZN08 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	ZITO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	140	7627	\N
13420	ZN08 - AA	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	ZITO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	141	7628	\N
13421	ZN08 - AA	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	ZITO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	142	7629	\N
13422	ZOKR	ZOKR	Kreiraj TM okružnicu/Create TM circulars	Kreiraj TM okružnicu/Create TM circulars	ZITO	Sales Distribution/SD	\N	TM okružnice ZOKR/ TM circulars  ZOKR	Kreiraj TM okružnicu/Create TM circulars	Kreiraj TM okružnicu/Create TM circulars	143	7630	\N
13423	TEST	ZOKR	TM obavijest ZOKR/ TM notification  ZOKR	TM obavijest ZOKR/ TM notification  ZOKR	ZITO	Sales Distribution/SD	\N	TM obavijest ZOKR/ TM notification  ZOKR	TM obavijest ZOKR/ TM notification  ZOKR	TM obavijest ZOKR/ TM notification  ZOKR	144	7631	\N
13424	TEST	VK11	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Kreiranje prodajnih cijena i uvjeta/Creating of sales prices and conditions	ZITO	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Kreiranje prodajnih cijena i uvjeta/Creating of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	145	7632	\N
13549	ZN02 - AA	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	MIRN	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	270	7757	\N
13425	TEST	VK12	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Promjena prodajnih cijena i uvjeta/ Change of sales prices and conditions	ZITO	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Promjena prodajnih cijena i uvjeta/ Change of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	146	7633	\N
13426	TEST	VK13	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Pregled prodajnih cijena i uvjeta/View of sales prices and conditions	ZITO	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Pregled prodajnih cijena i uvjeta/View of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	147	7634	\N
13427	ZISK - knjiženje izlaznih isporuka	ZISK	Masovno kreiranje isporuke / Create mass  delivery	Masovno kreiranje isporuke / Create mass  delivery	ZITO	Sales Distribution/SD	\N	Nadzornik isporuke u pekarama – ZISK/Delivery supervisor in bakeries - ZISK	Masovno kreiranje isporuke / Create mass  delivery	Masovno kreiranje isporuke / Create mass  delivery	148	7635	\N
13428	TEST	VD51	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Kreiranje info slogova kupac-materijal/Creating of customer/material info records	ZITO	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Kreiranje info slogova kupac-materijal/Creating of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	149	7636	\N
13429	TEST	VD52	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Promjena info slogova kupac- materijal/ Change of customer/material info records	ZITO	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Promjena info slogova kupac- materijal/ Change of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	150	7637	\N
13430	TEST	VD53	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Pregled info slogova kupac-materijal/ View of customer/material info records	ZITO	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Pregled info slogova kupac-materijal/ View of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	151	7638	\N
13431	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	LACZ	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	152	7639	\N
13432	ZN01 - A1	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	LACZ	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	153	7640	\N
13433	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	LACZ	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	154	7641	\N
13434	ZN01 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	LACZ	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	155	7642	\N
13435	ZN02 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	LACZ	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	156	7643	\N
13436	ZN02 - AA	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	LACZ	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	157	7644	\N
13437	ZN02 - AA	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	LACZ	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	158	7645	\N
13438	ZN02 - AA	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	LACZ	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	159	7646	\N
13439	ZTRM - A1	ZODO	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	LACZ	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	160	7647	\N
13440	ZN07 - A1,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	LACZ	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	161	7648	\N
13441	ZN07 - A1,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	LACZ	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	162	7649	\N
13442	ZN07 - AA,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	LACZ	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	163	7650	\N
13443	ZN07 - AA,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	LACZ	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	164	7651	\N
13444	ZCOD - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	LACZ	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	165	7652	\N
13445	ZCOD - A1, proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	LACZ	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	166	7653	\N
14816	TEST	WB2R_SC	TEST	TEST	BEPO	Sales Distribution/SD	\N	Naknadni rabati	TEST	TEST	1537	9024	\N
13447	ZCEO - AA, proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	LACZ	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	168	7655	\N
13448	ZN09 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	LACZ	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	169	7656	\N
13449	ZN09 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	LACZ	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	170	7657	\N
13450	ZN09 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	LACZ	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	171	7658	\N
13451	ZN09 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	LACZ	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	172	7659	\N
13452	ZN09 - AA	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	LACZ	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	173	7660	\N
13453	ZN09 - AA	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	LACZ	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	174	7661	\N
13454	ZN03 - AA	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	LACZ	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	175	7662	\N
13455	ZN03 - AA	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	LACZ	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	176	7663	\N
13456	ZN03 - A1	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	LACZ	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	177	7664	\N
13457	ZN03 - A1	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	LACZ	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	178	7665	\N
13458	TEST	VD51	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Kreiranje info slogova kupac-materijal/Creating of customer/material info records	LACZ	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Kreiranje info slogova kupac-materijal/Creating of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	179	7666	\N
13459	TEST	VD52	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Promjena info slogova kupac- materijal/ Change of customer/material info records	LACZ	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Promjena info slogova kupac- materijal/ Change of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	180	7667	\N
13460	TEST	VD53	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Pregled info slogova kupac-materijal/ View of customer/material info records	LACZ	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Pregled info slogova kupac-materijal/ View of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	181	7668	\N
13461	TEST	VK11	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Kreiranje prodajnih cijena i uvjeta/Creating of sales prices and conditions	LACZ	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Kreiranje prodajnih cijena i uvjeta/Creating of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	182	7669	\N
13462	TEST	VK12	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Promjena prodajnih cijena i uvjeta/ Change of sales prices and conditions	LACZ	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Promjena prodajnih cijena i uvjeta/ Change of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	183	7670	\N
13463	TEST	VK13	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Pregled prodajnih cijena i uvjeta/View of sales prices and conditions	LACZ	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Pregled prodajnih cijena i uvjeta/View of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	184	7671	\N
13464	ZPO3	ZPNK	Ponuda kupcu / Offer to the customer	Kreiraj prodajni nalog/Create sales order	POLJ	Sales Distribution/SD	\N	Ponuda kupcu / Offer to the customer	Kreiraj prodajni nalog/Create sales order	Ponuda kupcu / Offer to the customer	185	7672	\N
13465	ZOKR	ZOKR	Kreiraj TM okružnicu/Create TM circulars	Kreiraj TM okružnicu/Create TM circulars	POLJ	Sales Distribution/SD	\N	TM okružnice ZOKR/ TM circulars  ZOKR	Kreiraj TM okružnicu/Create TM circulars	Kreiraj TM okružnicu/Create TM circulars	186	7673	\N
14817	TEST	WCOCOALL	TEST	TEST	BEPO	Sales Distribution/SD	\N	Naknadni rabati	TEST	TEST	1538	9025	\N
13467	TEST	VD51	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Kreiranje info slogova kupac-materijal/Creating of customer/material info records	POLJ	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Kreiranje info slogova kupac-materijal/Creating of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	188	7675	\N
13468	TEST	VD52	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Promjena info slogova kupac- materijal/ Change of customer/material info records	POLJ	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Promjena info slogova kupac- materijal/ Change of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	189	7676	\N
13469	TEST	VD53	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Pregled info slogova kupac-materijal/ View of customer/material info records	POLJ	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Pregled info slogova kupac-materijal/ View of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	190	7677	\N
13470	TEST	VB01	Kreiraj asortiman/Create an assortment	Kreiraj asortiman/Create an assortment	POLJ	Sales Distribution/SD	\N	Ulistavanje/isključivanje/ Browsing/switching off the assortment	Kreiraj asortiman/Create an assortment	Kreiraj asortiman/Create an assortment	191	7678	\N
13471	TEST	VK11	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Kreiranje prodajnih cijena i uvjeta/Creating of sales prices and conditions	POLJ	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Kreiranje prodajnih cijena i uvjeta/Creating of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	192	7679	\N
13472	TEST	VK12	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Promjena prodajnih cijena i uvjeta/ Change of sales prices and conditions	POLJ	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Promjena prodajnih cijena i uvjeta/ Change of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	193	7680	\N
13473	TEST	VK13	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Pregled prodajnih cijena i uvjeta/View of sales prices and conditions	POLJ	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Pregled prodajnih cijena i uvjeta/View of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	194	7681	\N
13474	ZISK - knjiženje izlaznih isporuka	ZISK	Masovno kreiranje isporuke / Create mass  delivery	Masovno kreiranje isporuke / Create mass  delivery	POLJ	Sales Distribution/SD	\N	Nadzornik isporuke u pekarama – ZISK/Delivery supervisor in bakeries - ZISK	Masovno kreiranje isporuke / Create mass  delivery	Masovno kreiranje isporuke / Create mass  delivery	195	7682	\N
13475	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POMK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	196	7683	\N
13476	ZN01 - A1	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	POMK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	197	7684	\N
13477	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POMK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	198	7685	\N
13478	ZN01 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POMK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	199	7686	\N
13479	ZN02 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POMK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	200	7687	\N
13480	ZN02 - AA	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	POMK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	201	7688	\N
13481	ZN02 - AA	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POMK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	202	7689	\N
13482	ZN02 - AA	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POMK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	203	7690	\N
13483	ZN10 - A1	VA01	Kreiraj prodajni nalog odjava konsignacije/Create a sales order check out the consignment	Kreiraj prodajni nalog odjava konsignacije/Create a sales order check out the consignment	POMK	Sales Distribution/SD	\N	Konsignacija kupca - odjava / Buyer's consignment check out	Kreiraj prodajni nalog odjava konsignacije/Create a sales order check out the consignment	Kreiraj prodajni nalog odjava konsignacije/Create a sales order check out the consignment	204	7691	\N
13484	ZN10 - A1	VL01N	Kreiraj izlaznu isporuku odjave konsignacije/Create a consignment check out delivery	Kreiraj izlaznu isporuku odjave konsignacije/Create a consignment check out delivery	POMK	Sales Distribution/SD	\N	Konsignacija kupca - odjava / Buyer's consignment check out	Kreiraj izlaznu isporuku odjave konsignacije/Create a consignment check out delivery	Kreiraj izlaznu isporuku odjave konsignacije/Create a consignment check out delivery	205	7692	\N
13485	ZN10 - A1	VF01	Kreiraj fakturu odjave konsignacije/Create a consignment check-out invoice	Kreiraj fakturu odjave konsignacije/Create a consignment check-out invoice	POMK	Sales Distribution/SD	\N	Konsignacija kupca - odjava / Buyer's consignment check out	Kreiraj fakturu odjave konsignacije/Create a consignment check-out invoice	Kreiraj fakturu odjave konsignacije/Create a consignment check-out invoice	206	7693	\N
13486	ZN12 - A1	VA01	Kreiraj nalog povrata na konsignaciju/Create a consignment return order	Kreiraj nalog povrata na konsignaciju/Create a consignment return order	POMK	Sales Distribution/SD	\N	Konsignacija kupca - povrat / Buyer's consignment return	Kreiraj nalog povrata na konsignaciju/Create a consignment return order	Kreiraj nalog povrata na konsignaciju/Create a consignment return order	207	7694	\N
13487	ZN12 - A1	VL01N	Kreiraj isporuku povrata na konsignaciju/ Create a consignment return delivery	Kreiraj isporuku povrata na konsignaciju/ Create a consignment return delivery	POMK	Sales Distribution/SD	\N	Konsignacija kupca - povrat / Buyer's consignment return	Kreiraj isporuku povrata na konsignaciju/ Create a consignment return delivery	Kreiraj isporuku povrata na konsignaciju/ Create a consignment return delivery	208	7695	\N
13488	ZN11 - A1	VA01	Kreiraj prodajni nalog punjenje konsignacije/Create sales order filling consignment	Kreiraj prodajni nalog punjenje konsignacije/Create sales order filling consignment	POMK	Sales Distribution/SD	\N	Konsignacija kupca - punjenje / Buyer's consignment - charge	Kreiraj prodajni nalog punjenje konsignacije/Create sales order filling consignment	Kreiraj prodajni nalog punjenje konsignacije/Create sales order filling consignment	209	7696	\N
13489	ZN11 - A1	VL01N	Kreiraj izlaznu isporuku punjenja konsignacije/Create an outbound consignment fill delivery	Kreiraj izlaznu isporuku punjenja konsignacije/Create an outbound consignment fill delivery	POMK	Sales Distribution/SD	\N	Konsignacija kupca - punjenje / Buyer's consignment - charge	Kreiraj izlaznu isporuku punjenja konsignacije/Create an outbound consignment fill delivery	Kreiraj izlaznu isporuku punjenja konsignacije/Create an outbound consignment fill delivery	210	7697	\N
13490	ZTRM - A1	ZODO	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	POMK	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	211	7698	\N
13491	ZTR1 - A1	ZODO	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	POMK	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	212	7699	\N
13492	ZNR	ZODO	Pregled sporazuma o rabatu/Overview of rebate agreements	Pregled sporazuma o rabatu/Overview of rebate agreements	POMK	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Pregled sporazuma o rabatu/Overview of rebate agreements	Pregled sporazuma o rabatu/Overview of rebate agreements	213	7700	\N
13493	ZNR	ZODO	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	POMK	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	214	7701	\N
13494	ZNR	VF01	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	POMK	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	215	7702	\N
13495	ZNR	VF02	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	POMK	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	216	7703	\N
13496	ZNR - AA	VA01	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	POMK	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	217	7704	\N
13497	ZNR - AA	VF01	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	POMK	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	218	7705	\N
13498	ZNR - AA	VF02	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	POMK	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	219	7706	\N
13499	ZN05 - A1,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	220	7707	\N
13500	ZN05 - A1,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	221	7708	\N
13501	ZN05 - AA,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	222	7709	\N
13502	ZN05 - AA,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	223	7710	\N
13503	ZN07 - A1,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	224	7711	\N
13504	ZN07 - A1,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	225	7712	\N
14600	ZN01	WE02	prikaz IDOC-a	prikaz IDOC-a - IF	ZITO	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	prikaz IDOC-a - IF	prikaz IDOC-a	1321	8808	\N
13505	ZN07 - AA,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	226	7713	\N
13506	ZN07 - AA,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	227	7714	\N
13507	ZN1 - A1	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	228	7715	\N
13508	ZN1 - A1	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	229	7716	\N
13509	Z850	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	230	7717	\N
13510	Z850	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	231	7718	\N
13511	ZN08 - A1	SFA	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POMK	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	232	7719	\N
13512	ZN08 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	POMK	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	233	7720	\N
13513	ZN08 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	POMK	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	234	7721	\N
13514	ZN08 - A1	E-PISARNICA	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	POMK	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	235	7722	\N
13515	ZN08 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POMK	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	236	7723	\N
13516	ZN08 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	POMK	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	237	7724	\N
13517	ZN08 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	POMK	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	238	7725	\N
13518	ZN13 - A1	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POMK	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	239	7726	\N
13519	ZN13 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POMK	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	240	7727	\N
13520	ZN13 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POMK	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	241	7728	\N
13521	ZN02 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	242	7729	\N
13522	ZN02 - AA	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	243	7730	\N
13523	ZN02 - AA	VT01N	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	244	7731	\N
13524	ZN02 - AA	VI01	Kreiraj obračun troškova – Create an cost report	Kreiraj obračun troškova – Create an cost report	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj obračun troškova – Create an cost report	Kreiraj obračun troškova – Create an cost report	245	7732	\N
13525	ZN02 - AA	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	246	7733	\N
13526	Z831	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	247	7734	\N
13527	Z831	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	248	7735	\N
13528	Z831	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	249	7736	\N
13529	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	250	7737	\N
13530	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	251	7738	\N
13531	ZN01 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	252	7739	\N
13532	ZN03 - AA	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	POMK	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	253	7740	\N
13533	ZN03 - AA	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	POMK	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	254	7741	\N
13534	ZN03 - A1	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	POMK	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	255	7742	\N
13535	ZN03 - A1	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	POMK	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	256	7743	\N
13536	TEST	MCSI	Standardne analize prodaje / Standard sales analyses	Pozovi standardnu analizu prodaje/Call Standard Analyses of Sales	POMK	Sales Distribution/SD	\N	Standardne analize prodaje / Standard sales analyses	Pozovi standardnu analizu prodaje/Call Standard Analyses of Sales	Standardne analize prodaje / Standard sales analyses	257	7744	\N
13537	TEST	VD51	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Kreiranje info slogova kupac-materijal/Creating of customer/material info records	POMK	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Kreiranje info slogova kupac-materijal/Creating of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	258	7745	\N
13538	TEST	VD52	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Promjena info slogova kupac- materijal/ Change of customer/material info records	POMK	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Promjena info slogova kupac- materijal/ Change of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	259	7746	\N
13539	TEST	VD53	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Pregled info slogova kupac-materijal/ View of customer/material info records	POMK	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Pregled info slogova kupac-materijal/ View of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	260	7747	\N
13540	TEST	VK11	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Kreiranje prodajnih cijena i uvjeta/Creating of sales prices and conditions	POMK	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Kreiranje prodajnih cijena i uvjeta/Creating of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	261	7748	\N
13541	TEST	VK12	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Promjena prodajnih cijena i uvjeta/ Change of sales prices and conditions	POMK	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Promjena prodajnih cijena i uvjeta/ Change of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	262	7749	\N
13542	TEST	VK13	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Pregled prodajnih cijena i uvjeta/View of sales prices and conditions	POMK	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Pregled prodajnih cijena i uvjeta/View of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	263	7750	\N
13543	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	264	7751	\N
13544	ZN01 - A1	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	MIRN	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	265	7752	\N
13545	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	MIRN	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	266	7753	\N
13546	ZN01 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	MIRN	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	267	7754	\N
13547	ZN02 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	268	7755	\N
13548	ZN02 - AA	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	MIRN	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	269	7756	\N
13550	ZN02 - AA	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	MIRN	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	271	7758	\N
13551	ZN05 - A1,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	MIRN	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	272	7759	\N
13552	ZN05 - A1,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	MIRN	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	273	7760	\N
13553	ZN05 - AA,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	MIRN	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	274	7761	\N
13554	ZN05 - AA,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	MIRN	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	275	7762	\N
13555	ZN07 - A1,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	MIRN	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	276	7763	\N
13556	ZN07 - A1,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	MIRN	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	277	7764	\N
13557	ZN07 - AA,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	MIRN	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	278	7765	\N
13558	ZN07 - AA,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	MIRN	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	279	7766	\N
13559	ZN08 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	280	7767	\N
13560	ZN08 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	281	7768	\N
13561	ZN08 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	282	7769	\N
13562	ZN08 - A1	E-PISARNICA	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	283	7770	\N
13563	ZN09 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	284	7771	\N
13564	ZN09 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	285	7772	\N
13565	ZN09 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	286	7773	\N
13566	ZN09 - A1	E-PISARNICA	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	287	7774	\N
13567	ZN08 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	288	7775	\N
13568	ZN08 - AA	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	289	7776	\N
13569	ZN08 - AA	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	290	7777	\N
13570	ZN08 - AA	E-PISARNICA	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	291	7778	\N
13571	ZN09 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	292	7779	\N
13572	ZN09 - AA	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	293	7780	\N
14818	TEST	WCOLI	TEST	TEST	BEPO	Sales Distribution/SD	\N	Naknadni rabati	TEST	TEST	1539	9026	\N
13573	ZN09 - AA	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	294	7781	\N
13574	ZREM - A1	VA01	Kreiraj nalog povrata/Create  a return order	Kreiraj nalog povrata/Create  a return order	MIRN	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje -  povrat / Sale of goods through retail - return	Kreiraj nalog povrata/Create  a return order	Kreiraj nalog povrata/Create  a return order	295	7782	\N
13575	ZREM - A1	VL01N	Kreiraj isporuku povrata/Create  a delivery of return	Kreiraj isporuku povrata/Create  a delivery of return	MIRN	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje -  povrat / Sale of goods through retail - return	Kreiraj isporuku povrata/Create  a delivery of return	Kreiraj isporuku povrata/Create  a delivery of return	296	7783	\N
13576	ZREM - A1	VF01	Kreiraj  povrat zaduženja maloprodaje/ Create chergeback	Kreiraj  povrat zaduženja maloprodaje/ Create chergeback	MIRN	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje -  povrat / Sale of goods through retail - return	Kreiraj  povrat zaduženja maloprodaje/ Create chergeback	Kreiraj  povrat zaduženja maloprodaje/ Create chergeback	297	7784	\N
13577	ZMP - A1	VA01	Kreiraj prodajni nalog- /Create sales order	Kreiraj prodajni nalog- /Create sales order	MIRN	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje - zaduženje / Sale of goods through retail - debit	Kreiraj prodajni nalog- /Create sales order	Kreiraj prodajni nalog- /Create sales order	298	7785	\N
13578	ZMP - A1	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	MIRN	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje - zaduženje / Sale of goods through retail - debit	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	299	7786	\N
13579	ZMP - A1	VF01	Kreiraj zaduženje maloprodaje /  Create retail charge	Kreiraj zaduženje maloprodaje /  Create retail charge	MIRN	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje - zaduženje / Sale of goods through retail - debit	Kreiraj zaduženje maloprodaje /  Create retail charge	Kreiraj zaduženje maloprodaje /  Create retail charge	300	7787	\N
13580	ZN02 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	301	7788	\N
13581	ZN02 - AA	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	302	7789	\N
13582	ZN02 - AA	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	303	7790	\N
13583	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	304	7791	\N
13584	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	305	7792	\N
13585	ZN01 - A1	VF01	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	306	7793	\N
13586	ZN03 - AA	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	MIRN	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	307	7794	\N
13587	ZN03 - AA	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	MIRN	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	308	7795	\N
13588	ZN03 - A1	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	MIRN	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	309	7796	\N
13589	ZN03 - A1	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	MIRN	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	310	7797	\N
13590	ZRR - A1	VA01	Kreiraj nalog isporuka bez fakture/ Create a delivery order without an invoice	Kreiraj nalog isporuka bez fakture/ Create a delivery order without an invoice	MIRN	Sales Distribution/SD	\N	Robne rezerve / Commodity reserves	Kreiraj nalog isporuka bez fakture/ Create a delivery order without an invoice	Kreiraj nalog isporuka bez fakture/ Create a delivery order without an invoice	311	7798	\N
13591	ZRR - A1	VL01N	Kreiraj isporuku/Create delivery	Kreiraj isporuku/Create delivery	MIRN	Sales Distribution/SD	\N	Robne rezerve / Commodity reserves	Kreiraj isporuku/Create delivery	Kreiraj isporuku/Create delivery	312	7799	\N
13592	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	PLKO	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	313	7800	\N
13593	ZN01 - A1	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	PLKO	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	314	7801	\N
13594	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	PLKO	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	315	7802	\N
13595	ZN01 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	PLKO	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	316	7803	\N
13596	ZN02 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	PLKO	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	317	7804	\N
13597	ZN02 - AA	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	PLKO	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	318	7805	\N
13598	ZN02 - AA	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	PLKO	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	319	7806	\N
13599	ZN02 - AA	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	PLKO	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	320	7807	\N
13600	ZWCR - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	PLKO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	321	7808	\N
13601	ZWCR - A1, proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	PLKO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	322	7809	\N
13602	ZWDR - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	PLKO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	323	7810	\N
13603	ZWDR - A1, proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	PLKO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	324	7811	\N
13604	ZWCR  - AA, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	PLKO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	325	7812	\N
13605	ZWCR  - AA, proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	PLKO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	326	7813	\N
13606	ZWDR - AA, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	PLKO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	327	7814	\N
13607	ZWDR - AA, proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	PLKO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	328	7815	\N
13608	ZN09 - AA	E-PISARNICA	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	329	7816	\N
13609	ZN08 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	PLKO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	330	7817	\N
13610	ZN08 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	PLKO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	331	7818	\N
13611	ZN08 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	PLKO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	332	7819	\N
13612	ZN02 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	PLKO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	333	7820	\N
13613	ZN02 - AA	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	PLKO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	334	7821	\N
13614	ZN02 - AA	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	PLKO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	335	7822	\N
13615	ZN03 - AA	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	PLKO	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	336	7823	\N
13616	ZN03 - AA	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	PLKO	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	337	7824	\N
13617	ZN03 - A1	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	PLKO	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	338	7825	\N
13618	ZN03 - A1	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	PLKO	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	339	7826	\N
13619	TEST	MCSI	Standardne analize prodaje / Standard sales analyses	Pozovi standardnu analizu prodaje/Call Standard Analyses of Sales	HUMA	Sales Distribution/SD	\N	Standardne analize prodaje / Standard sales analyses	Pozovi standardnu analizu prodaje/Call Standard Analyses of Sales	Standardne analize prodaje / Standard sales analyses	340	7827	\N
13620	TEST	VD51	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Kreiranje info slogova kupac-materijal/Creating of customer/material info records	PLKO	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Kreiranje info slogova kupac-materijal/Creating of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	341	7828	\N
13621	TEST	VD52	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Promjena info slogova kupac- materijal/ Change of customer/material info records	PLKO	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Promjena info slogova kupac- materijal/ Change of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	342	7829	\N
13622	TEST	VD53	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Pregled info slogova kupac-materijal/ View of customer/material info records	PLKO	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Pregled info slogova kupac-materijal/ View of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	343	7830	\N
13623	TEST	VK12	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Promjena prodajnih cijena i uvjeta/ Change of sales prices and conditions	PLKO	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Promjena prodajnih cijena i uvjeta/ Change of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	344	7831	\N
13624	TEST	VK13	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Pregled prodajnih cijena i uvjeta/View of sales prices and conditions	PLKO	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Pregled prodajnih cijena i uvjeta/View of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	345	7832	\N
13625	ZNR	ZODO	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	POYU	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	346	7833	\N
13626	ZNR	VF01	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	POYU	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	347	7834	\N
13627	ZNR	VF02	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	POYU	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	348	7835	\N
13628	ZN06 - A1,  usluge	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POYU	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	349	7836	\N
13629	ZN06 - A1,  usluge	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POYU	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	350	7837	\N
13630	ZN06 - A1,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POYU	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	351	7838	\N
13631	ZN06 - A1,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POYU	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	352	7839	\N
13632	Z270 - A1	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POYU	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	353	7840	\N
13633	Z270 - A1	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POYU	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	354	7841	\N
13634	ZN08 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POYU	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	355	7842	\N
13635	ZN08 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	POYU	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	356	7843	\N
13636	ZN08 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	POYU	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	357	7844	\N
13637	ZN09 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POYU	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	358	7845	\N
13638	ZN09 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	POYU	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	359	7846	\N
13639	ZN09 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	POYU	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	360	7847	\N
13640	ZN13 - A1	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POYU	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	361	7848	\N
13641	ZN13 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POYU	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	362	7849	\N
13642	ZN13 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POYU	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	363	7850	\N
13643	ZN02 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POYU	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	364	7851	\N
13644	ZN02 - AA	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	POYU	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	365	7852	\N
13645	ZN02 - AA	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POYU	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	366	7853	\N
13646	ZN03 - AA	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	POYU	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	367	7854	\N
13647	ZN03 - AA	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	POYU	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	368	7855	\N
13648	ZN03 - A1	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	POYU	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	369	7856	\N
13649	ZN03 - A1	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	POYU	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	370	7857	\N
13650	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POCG	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	371	7858	\N
13651	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POCG	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	372	7859	\N
13652	ZN02 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POCG	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	373	7860	\N
13653	ZN02 - AA	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POCG	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	374	7861	\N
13654	ZTRM - A1	ZODO	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	POCG	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	375	7862	\N
13655	ZNR	ZODO	Pregled sporazuma o rabatu/Overview of rebate agreements	Pregled sporazuma o rabatu/Overview of rebate agreements	POCG	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Pregled sporazuma o rabatu/Overview of rebate agreements	Pregled sporazuma o rabatu/Overview of rebate agreements	376	7863	\N
13656	ZNR	ZODO	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	POCG	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	377	7864	\N
13657	ZNR	VF01	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	POCG	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	378	7865	\N
13658	ZNR	VF02	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	POCG	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	379	7866	\N
13659	ZNR - AA	VA01	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	POCG	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	380	7867	\N
13660	ZNR - AA	VF01	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	POCG	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	381	7868	\N
13661	ZNR - AA	VF02	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	POCG	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	Promjeni odobrenje za naknadni rabat/Change an authorization for additional rebate	382	7869	\N
13662	ZN04 - AA, usluge	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POCG	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	383	7870	\N
13663	ZN04 - AA, usluge	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POCG	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	384	7871	\N
13664	Z311 - A1	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POCG	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	385	7872	\N
13665	Z311 - A1	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POCG	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	386	7873	\N
13666	Z320 - A1	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POCG	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	387	7874	\N
13667	Z320 - A1	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POCG	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	388	7875	\N
13668	Z320 - AA	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POCG	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	389	7876	\N
13669	Z320 - AA	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POCG	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	390	7877	\N
13670	ZN08 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POCG	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	391	7878	\N
13671	ZN08 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	POCG	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	392	7879	\N
13672	ZN14 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POCG	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	393	7880	\N
13673	ZN14 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	POCG	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	394	7881	\N
13674	ZN14 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	POCG	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	395	7882	\N
13675	ZN09 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POCG	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	396	7883	\N
13676	ZN09 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	POCG	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	397	7884	\N
13677	ZN13 - A1	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POCG	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	398	7885	\N
13678	ZN13 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POCG	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	399	7886	\N
13679	ZN02 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POBH	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	400	7887	\N
13680	ZN02 - AA	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	POBH	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	401	7888	\N
13681	ZN02 - AA	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POBH	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	402	7889	\N
13682	ZN02 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POCG	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	403	7890	\N
13683	ZN02 - AA	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	POCG	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	404	7891	\N
13684	ZN02 - AA	VT01N	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	POCG	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	405	7892	\N
13685	ZN02 - AA	VI01	Kreiraj obračun troškova – Create an cost report	Kreiraj obračun troškova – Create an cost report	POCG	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj obračun troškova – Create an cost report	Kreiraj obračun troškova – Create an cost report	406	7893	\N
13686	ZN02 - AA	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POCG	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	407	7894	\N
13687	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POCG	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	408	7895	\N
13688	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POCG	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	409	7896	\N
13689	ZN01 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POCG	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	410	7897	\N
13690	ZN03 - A1	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	POCG	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	411	7898	\N
13691	ZN03 - A1	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	POCG	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	412	7899	\N
13692	TEST	VD51	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Kreiranje info slogova kupac-materijal/Creating of customer/material info records	POCG	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Kreiranje info slogova kupac-materijal/Creating of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	413	7900	\N
13693	TEST	VD52	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Promjena info slogova kupac- materijal/ Change of customer/material info records	POCG	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Promjena info slogova kupac- materijal/ Change of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	414	7901	\N
13694	TEST	VD53	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Pregled info slogova kupac-materijal/ View of customer/material info records	POCG	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Pregled info slogova kupac-materijal/ View of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	415	7902	\N
13695	TEST	VK11	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Kreiranje prodajnih cijena i uvjeta/Creating of sales prices and conditions	POCG	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Kreiranje prodajnih cijena i uvjeta/Creating of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	416	7903	\N
13696	TEST	VK12	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Promjena prodajnih cijena i uvjeta/ Change of sales prices and conditions	POCG	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Promjena prodajnih cijena i uvjeta/ Change of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	417	7904	\N
13697	TEST	VK13	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Pregled prodajnih cijena i uvjeta/View of sales prices and conditions	POCG	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Pregled prodajnih cijena i uvjeta/View of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	418	7905	\N
13698	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	HUMA	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	419	7906	\N
13699	ZN01 - A1	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	HUMA	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	420	7907	\N
13700	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	HUMA	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	421	7908	\N
13701	ZN01 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	HUMA	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	422	7909	\N
13702	ZN02 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	HUMA	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	423	7910	\N
14713	TEST	ZODO	transakcija ZODO	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	transakcija ZODO	1434	8921	\N
13704	ZN02 - AA	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	HUMA	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	425	7912	\N
13705	ZN02 - AA	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	HUMA	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	426	7913	\N
13706	ZTRM - A1	ZODO	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	HUMA	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	427	7914	\N
13707	ZHCR - A1,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	HUMA	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	428	7915	\N
13708	ZHCR - A1,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	HUMA	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	429	7916	\N
13709	ZHDR - A1,  proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	HUMA	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	430	7917	\N
13710	ZHDR - A1,  proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	HUMA	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	431	7918	\N
13711	ZN02 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	HUMA	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	432	7919	\N
13712	ZN02 - AA	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	HUMA	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	433	7920	\N
13713	ZN02 - AA	VT01N	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	HUMA	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	434	7921	\N
13714	ZN02 - AA	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	HUMA	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	435	7922	\N
13715	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	HUMA	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	436	7923	\N
13716	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	HUMA	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	437	7924	\N
13717	ZN01 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	HUMA	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	438	7925	\N
13718	ZN03 - AA	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	HUMA	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	439	7926	\N
13719	ZN03 - AA	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	HUMA	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	440	7927	\N
13720	ZN03 - A1	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	HUMA	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	441	7928	\N
13721	ZN03 - A1	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	HUMA	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	442	7929	\N
13722	TEST	VD51	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Kreiranje info slogova kupac-materijal/Creating of customer/material info records	HUMA	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Kreiranje info slogova kupac-materijal/Creating of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	443	7930	\N
13723	TEST	VD52	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Promjena info slogova kupac- materijal/ Change of customer/material info records	HUMA	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Promjena info slogova kupac- materijal/ Change of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	444	7931	\N
13747	ZN03 - A1	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	POBH	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	468	7955	\N
13724	TEST	VD53	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Pregled info slogova kupac-materijal/ View of customer/material info records	HUMA	Sales Distribution/SD	\N	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	Pregled info slogova kupac-materijal/ View of customer/material info records	Upravljanje matičnim podacima info slogova kupac/materijal / Master data management of customer/mate	445	7932	\N
13725	TEST	VK11	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Kreiranje prodajnih cijena i uvjeta/Creating of sales prices and conditions	HUMA	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Kreiranje prodajnih cijena i uvjeta/Creating of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	446	7933	\N
13726	TEST	VK12	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Promjena prodajnih cijena i uvjeta/ Change of sales prices and conditions	HUMA	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Promjena prodajnih cijena i uvjeta/ Change of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	447	7934	\N
13727	TEST	VK13	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Pregled prodajnih cijena i uvjeta/View of sales prices and conditions	HUMA	Sales Distribution/SD	\N	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	Pregled prodajnih cijena i uvjeta/View of sales prices and conditions	Upravljanje matičnim podacima prodajnih cijena i uvjeta / Management of master data of sales prices	448	7935	\N
13728	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POBH	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	449	7936	\N
13729	ZN01 - A1	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	POBH	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	450	7937	\N
13730	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POBH	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	451	7938	\N
13731	ZN01 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POBH	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	452	7939	\N
13732	ZN02 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POBH	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	453	7940	\N
13733	ZN02 - AA	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	POBH	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	454	7941	\N
13734	ZN02 - AA	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POBH	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	455	7942	\N
13735	ZN02 - AA	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POBH	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	456	7943	\N
13736	ZN08 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POBH	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	457	7944	\N
13737	ZN08 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	POBH	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	458	7945	\N
13738	ZN08 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	POBH	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	459	7946	\N
13739	ZN14 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POBH	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	460	7947	\N
13740	ZN14 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	POBH	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	461	7948	\N
13741	ZN14 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	POBH	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	462	7949	\N
13742	ZN13 - A1	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POBH	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	463	7950	\N
13743	ZN13 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POBH	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	464	7951	\N
13744	ZN13 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POBH	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	465	7952	\N
13745	ZN03 - AA	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	POBH	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	466	7953	\N
13746	ZN03 - AA	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	POBH	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	467	7954	\N
13748	ZN03 - A1	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	POBH	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	469	7956	\N
13749	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	KONR	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	470	7957	\N
13750	ZN01 - A1	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	KONR	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	471	7958	\N
13751	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	KONR	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	472	7959	\N
13752	ZN01 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	KONR	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	473	7960	\N
13753	ZN02 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	KONR	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	474	7961	\N
13754	ZN02 - AA	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	KONR	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	475	7962	\N
13755	ZN02 - AA	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	KONR	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	476	7963	\N
13756	ZN02 - AA	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	KONR	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	477	7964	\N
13757	ZTRM - A1	ZODO	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	KONR	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	478	7965	\N
13758	ZTR1 - A1	ZODO	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	KONR	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	479	7966	\N
13759	ZN04 - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	KONR	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	480	7967	\N
13760	ZN04 - A1, proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	KONR	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	481	7968	\N
13761	ZN04 - A1, usluge	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	KONR	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	482	7969	\N
13762	ZN04 - A1, usluge	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	KONR	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	483	7970	\N
13763	ZN04 - AA, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	KONR	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	484	7971	\N
13764	ZN04 - AA, proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	KONR	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	485	7972	\N
13765	ZN04 - AA, usluge	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	KONR	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	486	7973	\N
13766	ZN04 - AA, usluge	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	KONR	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	487	7974	\N
13767	ZN08 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	KONR	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	488	7975	\N
13768	ZN08 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	KONR	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	489	7976	\N
13769	ZN08 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	KONR	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	490	7977	\N
13770	ZN03 - AA	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	KONR	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	491	7978	\N
14714	TEST	ZOKR	Transakcija ZOKR - Kreiranje okrožnic	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	Transakcija ZOKR - Kreiranje okrožnic	1435	8922	\N
13771	ZN03 - AA	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	KONR	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	492	7979	\N
13772	ZN03 - A1	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	KONR	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	493	7980	\N
13773	ZN03 - A1	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	KONR	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	494	7981	\N
13774	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POSK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	495	7982	\N
13775	ZN01 - A1	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	POSK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	496	7983	\N
13776	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POSK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	497	7984	\N
13777	ZN01 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POSK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	498	7985	\N
13778	ZN06 - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POSK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	499	7986	\N
13779	ZN06 - A1, proizvodi	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POSK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	500	7987	\N
13780	ZN08 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POSK	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	501	7988	\N
13781	ZN08 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	POSK	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	502	7989	\N
13782	ZN08 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	POSK	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	503	7990	\N
13783	ZN09 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	HUMA	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	504	7991	\N
13784	ZN09 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	HUMA	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	505	7992	\N
13785	ZN09 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	HUMA	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	506	7993	\N
13786	ZN09 - AA	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	HUMA	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	507	7994	\N
13787	ZN09 - AA	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	HUMA	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	508	7995	\N
13788	ZN09 - AA	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	HUMA	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	509	7996	\N
13789	ZTRR - A1	ZODO	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	PODD	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	510	7997	\N
13790	ZTRR - A1	ZSTORNO	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	PODD	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	511	7998	\N
13791	ZTRR - A1	ZODO	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	PODD	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	512	7999	\N
13792	ZTRR - A1	ZODO	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	BEPO	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	513	8000	\N
13793	ZTRR - A1	ZSTORNO	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	BEPO	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	514	8001	\N
13794	ZTRR - A1	ZODO	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	LACZ	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	515	8002	\N
13795	ZTRR - A1	ZSTORNO	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	LACZ	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	516	8003	\N
13796	ZTRR - A1	ZODO	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	LACZ	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	517	8004	\N
13797	ZTRR - A1	ZODO	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	PLKO	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	518	8005	\N
13798	ZTRR - A1	ZSTORNO	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	PLKO	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	519	8006	\N
13799	ZTRR - A1	ZODO	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	PLKO	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	520	8007	\N
13800	ZTRR - A1	ZSTORNO	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	POYU	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	521	8008	\N
13801	ZTRR - A1	ZODO	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	POYU	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	522	8009	\N
13802	ZTRR - A1	ZODO	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	POCG	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	523	8010	\N
13803	ZTRR - A1	ZSTORNO	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	POCG	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	524	8011	\N
13804	ZTRR - A1	ZODO	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	POCG	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	525	8012	\N
13805	ZTRR - A1	ZODO	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	HUMA	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	526	8013	\N
13806	ZTRR - A1	ZSTORNO	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	HUMA	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	527	8014	\N
13807	ZTRR - A1	ZODO	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	KONR	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	528	8015	\N
13808	ZTRR - A1	ZSTORNO	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	KONR	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	529	8016	\N
13809	ZTRR - A1	ZODO	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	KONR	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	530	8017	\N
13810	ZTRR - A1	ZODO	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	POSK	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	531	8018	\N
14601	ZN01	FB03	Interna obav.odobr.	Interna obav.odobr. - IF	ZITO	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	Interna obav.odobr. - IF	Interna obav.odobr.	1322	8809	\N
13811	ZTRR - A1	ZSTORNO	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	POSK	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	532	8019	\N
13812	ZTRR - A1	ZODO	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	POSK	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	533	8020	\N
13813	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	534	8021	\N
13814	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	535	8022	\N
13815	ZN01 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	536	8023	\N
13816	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	537	8024	\N
13817	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	538	8025	\N
13818	ZN01 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	539	8026	\N
13819	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	PLKO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	540	8027	\N
13820	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	PLKO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	541	8028	\N
13821	ZN01 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	PLKO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	542	8029	\N
13822	ZRN1	VA01	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	POMK	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	543	8030	\N
13823	ZRN1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POMK	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	544	8031	\N
13824	ZN01 - A1 -STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	545	8032	\N
13825	ZN02 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	546	8033	\N
13826	ZNBM - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Nalog bez otpreme / Order without shipping	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	547	8034	\N
13827	ZNBO - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Nalog bez otpreme / Order without shipping	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	548	8035	\N
13828	ZNOI - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Nalog bez otpreme / Order without shipping	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	549	8036	\N
13829	ZPVP - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Obračun sponzorstva - roba / Calculation of sponsorship - goods	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	550	8037	\N
13830	ZUS - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Obračun sponzorstva - usluga / Calculation of sponsorship - service	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	551	8038	\N
13831	ZTRM - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	552	8039	\N
13832	ZTRM - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	553	8040	\N
13833	ZNR -A1- STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	554	8041	\N
14218	ZN01 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	HUMA	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	939	8426	\N
13834	ZNR - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	555	8042	\N
13835	ZN04 - A1, proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	556	8043	\N
13836	ZN04 - A1, usluge - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	557	8044	\N
13837	ZN05 - A1,  proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	558	8045	\N
13838	ZN06 - A1,  usluge - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	559	8046	\N
13839	ZN06 - A1,  proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	560	8047	\N
13840	ZN07 - A1,  proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	561	8048	\N
13841	ZN04 - AA, usluge - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	562	8049	\N
13842	ZN04 - AA,  proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	563	8050	\N
13843	ZN05 - AA,  proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	564	8051	\N
13844	ZN06 - AA,  usluge - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	565	8052	\N
13845	ZN06 - AA,  proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	566	8053	\N
13846	ZN07 - AA,  proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	567	8054	\N
13847	ZN1 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	568	8055	\N
13848	ZN08 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	569	8056	\N
13849	ZN09 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	570	8057	\N
13850	ZN08 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	571	8058	\N
13851	ZN09 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	572	8059	\N
13852	ZCRM - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje -  financijsko odobrenje / Sale of goods through retail – financial a	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	573	8060	\N
13853	ZPNM - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje -  povrat / Sale of goods through retail - return	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	574	8061	\N
13854	ZREM - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje -  povrat / Sale of goods through retail - return	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	575	8062	\N
13855	ZMP - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje - zaduženje / Sale of goods through retail - debit	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	576	8063	\N
13856	ZN02 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	577	8064	\N
13857	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu sa dokazom isporuke, pošiljkom i obračunom troškova/Sale o	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	578	8065	\N
13858	ZN01 - A1	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu sa dokazom isporuke, pošiljkom i obračunom troškova/Sale o	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	579	8066	\N
13859	ZN01 - A1	VT01N	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu sa dokazom isporuke, pošiljkom i obračunom troškova/Sale o	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	580	8067	\N
13860	ZN01 - A1	VLPOD	Kreiraj dokaz isporuke/Create evidence of delivery	Kreiraj dokaz isporuke/Create evidence of delivery	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu sa dokazom isporuke, pošiljkom i obračunom troškova/Sale o	Kreiraj dokaz isporuke/Create evidence of delivery	Kreiraj dokaz isporuke/Create evidence of delivery	581	8068	\N
13861	ZN01 - A1	VI01	Kreiraj obračun troškova/Create an cost report	Kreiraj obračun troškova/Create an cost report	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu sa dokazom isporuke, pošiljkom i obračunom troškova/Sale o	Kreiraj obračun troškova/Create an cost report	Kreiraj obračun troškova/Create an cost report	582	8069	\N
13862	ZN01 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu sa dokazom isporuke, pošiljkom i obračunom troškova/Sale o	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	583	8070	\N
13863	ZN01 - A1-STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu sa dokazom isporuke, pošiljkom i obračunom troškova/Sale o	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	584	8071	\N
13864	ZN03 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	585	8072	\N
13865	ZN03 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	586	8073	\N
13866	ZORT - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Tranzitna prodaja-  izvoz / Transit sales - export	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	587	8074	\N
13867	ZTRM - A1 - STORNO	ZODO	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	BEPO	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	588	8075	\N
13868	ZTRM - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	BEPO	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	589	8076	\N
13869	ZMPU - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PODD	Sales Distribution/SD	\N	Zaduženje maloprodaje – ugostiteljstvo / Retail debt - hospitality	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	590	8077	\N
13870	ZN04 - A1, proizvodi - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	BEPO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	591	8078	\N
13871	ZN04 - A1, proizvodi - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	BEPO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	592	8079	\N
13872	ZN04 - A1, proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	BEPO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	593	8080	\N
13873	ZN06 - A1, proizvodi - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	BEPO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	594	8081	\N
13874	ZN06 - A1, proizvodi - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	BEPO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	595	8082	\N
13875	ZN06 - A1, proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	BEPO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	596	8083	\N
13876	ZN05 - A1,  proizvodi - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	BEPO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	597	8084	\N
13877	ZN05 - A1,  proizvodi - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	BEPO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	598	8085	\N
13878	ZN05 - A1,  proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	BEPO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	599	8086	\N
13879	ZN07 - A1,  proizvodi - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	BEPO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	600	8087	\N
14766	TEST	WCOCOALL	Pogodbe o pogojih	TEST	ZITO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Pogodbe o pogojih	1487	8974	\N
13880	ZN07 - A1,  proizvodi - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	BEPO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	601	8088	\N
13881	ZN07 - A1,  proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	BEPO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	602	8089	\N
13882	ZN08 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	BEPO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	603	8090	\N
13883	ZN08 - A1 - STORNO	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	BEPO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	604	8091	\N
13884	ZN08 - A1 - STORNO	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	BEPO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	605	8092	\N
13885	ZN08 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	BEPO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	606	8093	\N
13886	ZREB - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	BEPO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	607	8094	\N
13887	ZREB - A1 - STORNO	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	BEPO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	608	8095	\N
13888	ZREB - A1 - STORNO	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	BEPO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	609	8096	\N
13889	ZREB - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	BEPO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	610	8097	\N
13890	ZN09 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	BEPO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	611	8098	\N
13891	ZN09 - A1 - STORNO	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	BEPO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	612	8099	\N
13892	ZN09 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	BEPO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	613	8100	\N
13893	ZN01 - A1 - STORNO	ZPRNAR	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	614	8101	\N
13894	ZN01 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	615	8102	\N
13895	ZN01 - A1 - STORNO	VT01N	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	616	8103	\N
13896	ZN01 - A1 - STORNO	VI01	Kreiraj obračun troškova/Create cost report	Kreiraj obračun troškova/Create cost report	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj obračun troškova/Create cost report	Kreiraj obračun troškova/Create cost report	617	8104	\N
13897	ZN01 - A1 - STORNO	VF01	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	618	8105	\N
13898	ZN01 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	619	8106	\N
13899	ZN01 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	620	8107	\N
13900	ZN01 - A1 - STORNO	VT01N	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	621	8108	\N
13901	ZN01 - A1 - STORNO	VI01	Kreiraj obračun troškova/Create cost report	Kreiraj obračun troškova/Create cost report	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj obračun troškova/Create cost report	Kreiraj obračun troškova/Create cost report	622	8109	\N
14219	ZN01 - A1 - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	HUMA	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	940	8427	\N
13902	ZN01 - A1 - STORNO	VF01	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	623	8110	\N
13903	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	624	8111	\N
13904	ZN03 - A1 - STORNO	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	BEPO	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	625	8112	\N
13905	ZN03 - A1 - STORNO	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	BEPO	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	626	8113	\N
13906	ZN10 - AA - STORNO	VA01	Kreiraj prodajni nalog odjava konsignacije/Create a sales order check out the consignment	Kreiraj prodajni nalog odjava konsignacije/Create a sales order check out the consignment	ZITO	Sales Distribution/SD	\N	Konsignacija kupca - odjava / Buyer's consignment check out	Kreiraj prodajni nalog odjava konsignacije/Create a sales order check out the consignment	Kreiraj prodajni nalog odjava konsignacije/Create a sales order check out the consignment	627	8114	\N
13907	ZN10 - AA - STORNO	VL01N	Kreiraj izlaznu isporuku odjave konsignacije/Create a consignment check out delivery	Kreiraj izlaznu isporuku odjave konsignacije/Create a consignment check out delivery	ZITO	Sales Distribution/SD	\N	Konsignacija kupca - odjava / Buyer's consignment check out	Kreiraj izlaznu isporuku odjave konsignacije/Create a consignment check out delivery	Kreiraj izlaznu isporuku odjave konsignacije/Create a consignment check out delivery	628	8115	\N
13908	ZN10 - AA - STORNO	VF01	Kreiraj fakturu odjave konsignacije/Create a consignment check-out invoice	Kreiraj fakturu odjave konsignacije/Create a consignment check-out invoice	ZITO	Sales Distribution/SD	\N	Konsignacija kupca - odjava / Buyer's consignment check out	Kreiraj fakturu odjave konsignacije/Create a consignment check-out invoice	Kreiraj fakturu odjave konsignacije/Create a consignment check-out invoice	629	8116	\N
13909	ZN10 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Konsignacija kupca - odjava / Buyer's consignment check out	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	630	8117	\N
13910	ZNR - STORNO	VA01	Kreiranje prodajnog naloga	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	ZITO	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiranje prodajnog naloga	631	8118	\N
13911	ZNR - STORNO	VF01	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	OK	ZITO	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	OK	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	632	8119	\N
13912	ZNR - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	633	8120	\N
13913	ZN05 - AA,  proizvodi - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	ZITO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	634	8121	\N
13914	ZN05 - AA,  proizvodi - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	ZITO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	635	8122	\N
13915	ZN05 - AA,  proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	636	8123	\N
13916	ZPDE - AA, proizvodi - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	ZITO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	637	8124	\N
13917	ZPDE - AA, proizvodi - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	ZITO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	638	8125	\N
13918	ZPDE - AA, proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	639	8126	\N
13919	ZN08 - AA - STORNO	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	ZITO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	640	8127	\N
13920	ZN08 - AA - STORNO	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	ZITO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	641	8128	\N
13921	ZN08 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	642	8129	\N
13922	ZN14 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	ZITO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	643	8130	\N
14769	TEST	WB2R_BUSVOL	Promet za pogodbe	TEST	ZITO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Promet za pogodbe	1490	8977	\N
13923	ZN14 - A1 - STORNO	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	ZITO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	644	8131	\N
13924	ZN14 - A1 - STORNO	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	ZITO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	645	8132	\N
13925	ZN14 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	646	8133	\N
13926	ZN13 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	ZITO	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	647	8134	\N
13927	ZN13 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	ZITO	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	648	8135	\N
13928	ZN13 - A1 - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	ZITO	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	649	8136	\N
13929	ZN13 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	650	8137	\N
13930	ZN02 - AA - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	ZITO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	651	8138	\N
13931	ZN02 - AA - STORNO	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	ZITO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	652	8139	\N
13932	ZN02 - AA - STORNO	VT01N	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	ZITO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	653	8140	\N
13933	ZN02 - AA - STORNO	VI01	Kreiraj obračun troškova/Create shipment costs	Kreiraj obračun troškova/Create shipment costs	ZITO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj obračun troškova/Create shipment costs	Kreiraj obračun troškova/Create shipment costs	654	8141	\N
13934	ZN02 - AA - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	ZITO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	655	8142	\N
13935	ZN02 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	656	8143	\N
13936	ZN01 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	ZITO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	657	8144	\N
13937	ZN01 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	ZITO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	658	8145	\N
13938	ZN01 - A1 - STORNO	VF01	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	ZITO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	659	8146	\N
13939	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	660	8147	\N
13940	ZN01 - A1 - STORNO	VA01	Kriraj prodajni nalog/Create Sales Order	Kriraj prodajni nalog/Create Sales Order	ZITO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - sa dokazom isporuke/Sale of goods from stock on the dome	Kriraj prodajni nalog/Create Sales Order	Kriraj prodajni nalog/Create Sales Order	661	8148	\N
13941	ZN01 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	ZITO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - sa dokazom isporuke/Sale of goods from stock on the dome	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	662	8149	\N
13942	ZN01 - A1 - STORNO	VLPOD	Kreiraj dokaz isporuke/Create evidence of delivery	Kreiraj dokaz isporuke/Create evidence of delivery	ZITO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - sa dokazom isporuke/Sale of goods from stock on the dome	Kreiraj dokaz isporuke/Create evidence of delivery	Kreiraj dokaz isporuke/Create evidence of delivery	663	8150	\N
13943	ZN01 - A1 - STORNO	VF01	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	ZITO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - sa dokazom isporuke/Sale of goods from stock on the dome	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	664	8151	\N
13944	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - sa dokazom isporuke/Sale of goods from stock on the dome	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	665	8152	\N
13945	ZN03 - AA - STORNO	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	ZITO	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	666	8153	\N
13946	ZN03 - AA - STORNO	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	ZITO	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	667	8154	\N
13947	ZN03 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	668	8155	\N
13948	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	LACZ	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke sa pošiljkom i obračunom troškova	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	669	8156	\N
13949	ZN01 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POLJ	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	670	8157	\N
13950	ZN01 - A1 - STORNO	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	POLJ	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	671	8158	\N
13951	ZN01 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POLJ	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	672	8159	\N
13952	ZN01 - A1 - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	673	8160	\N
13953	ZPO3 - STORNO	ZPNK	Ponuda kupcu / Offer to the customer	Kreiraj prodajni nalog/Create sales order	POLJ	Sales Distribution/SD	\N	Ponuda kupcu / Offer to the customer	Kreiraj prodajni nalog/Create sales order	Ponuda kupcu / Offer to the customer	674	8161	\N
13954	ZPO4 - STORNO	ZPNK	Ponuda kupcu / Offer to the customer	Kreiraj prodajni nalog/Create sales order	ZITO	Sales Distribution/SD	\N	Ponuda kupcu / Offer to the customer	Kreiraj prodajni nalog/Create sales order	Ponuda kupcu / Offer to the customer	675	8162	\N
13955	ZTRM - A1 - STORNO	ZODO	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	POLJ	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	676	8163	\N
13956	ZTRM - A1 - STORNO	ZSTORNO	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	677	8164	\N
13957	ZNR - STORNO	ZODO	Pregled sporazuma o rabatu/Overview of rebate agreements	Pregled sporazuma o rabatu/Overview of rebate agreements	POLJ	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Pregled sporazuma o rabatu/Overview of rebate agreements	Pregled sporazuma o rabatu/Overview of rebate agreements	678	8165	\N
13958	ZNR - STORNO	ZODO	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	POLJ	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	679	8166	\N
13959	ZNR - STORNO	VF01	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	POLJ	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	680	8167	\N
13960	ZNR - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	681	8168	\N
13961	ZN04 - A1, usluge - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POLJ	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	682	8169	\N
13962	ZN04 - A1, usluge - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POLJ	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	683	8170	\N
13963	ZN04 - A1, usluge - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	684	8171	\N
13964	ZN06 - A1,  usluge - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POLJ	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	685	8172	\N
13965	ZN06 - A1,  usluge - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POLJ	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	686	8173	\N
13966	ZN06 - A1,  usluge - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	687	8174	\N
13967	ZN14 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POLJ	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	688	8175	\N
14032	ZN07 - AA,  proizvodi - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	753	8240	\N
13968	ZN14 - A1 - STORNO	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	POLJ	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	689	8176	\N
13969	ZN14 - A1 - STORNO	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	POLJ	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	690	8177	\N
13970	ZN14 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	691	8178	\N
13971	ZN13 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POLJ	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	692	8179	\N
13972	ZN13 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POLJ	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	693	8180	\N
13973	ZN13 - A1 - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	694	8181	\N
13974	ZN13 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	695	8182	\N
13975	ZN01 - A1 - STORNO	VF01	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	POLJ	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	696	8183	\N
13976	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	697	8184	\N
13977	ZN01 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POLJ	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	698	8185	\N
13978	ZN01 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POLJ	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	699	8186	\N
13979	ZN01 - A1 - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	700	8187	\N
13980	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	701	8188	\N
13981	ZN01 - A1 - STORNO	VA01	Kriraj prodajni nalog/Create Sales Order	Kriraj prodajni nalog/Create Sales Order	POLJ	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - sa dokazom isporuke/Sale of goods from stock on the dome	Kriraj prodajni nalog/Create Sales Order	Kriraj prodajni nalog/Create Sales Order	702	8189	\N
13982	ZN01 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POLJ	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - sa dokazom isporuke/Sale of goods from stock on the dome	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	703	8190	\N
13983	ZN01 - A1 - STORNO	VLPOD	Kreiraj dokaz isporuke/Create evidence of delivery	Kreiraj dokaz isporuke/Create evidence of delivery	POLJ	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - sa dokazom isporuke/Sale of goods from stock on the dome	Kreiraj dokaz isporuke/Create evidence of delivery	Kreiraj dokaz isporuke/Create evidence of delivery	704	8191	\N
13984	ZN01 - A1 - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - sa dokazom isporuke/Sale of goods from stock on the dome	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	705	8192	\N
13985	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - sa dokazom isporuke/Sale of goods from stock on the dome	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	706	8193	\N
13986	ZN03 - AA - STORNO	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	POLJ	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	707	8194	\N
13987	ZN03 - AA - STORNO	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	POLJ	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	708	8195	\N
13988	ZN03 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	709	8196	\N
13989	ZN03 - A1 - STORNO	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	POLJ	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	710	8197	\N
14079	ZN02 - AA - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	MIRN	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	800	8287	\N
13990	ZN03 - A1 - STORNO	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	POLJ	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	711	8198	\N
13991	ZN03 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	712	8199	\N
13992	ZN01 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POMK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	713	8200	\N
13993	ZN01 - A1 - STORNO	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	POMK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	714	8201	\N
13994	ZN01 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POMK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	715	8202	\N
13995	ZN01 - A1 - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POMK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	716	8203	\N
13996	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	717	8204	\N
13997	ZN02 - AA - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POMK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	718	8205	\N
13998	ZN02 - AA - STORNO	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	POMK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	719	8206	\N
13999	ZN02 - AA - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POMK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	720	8207	\N
14000	ZN02 - AA - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POMK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	721	8208	\N
14001	ZN02 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	722	8209	\N
14002	ZN10 - A1 - STORNO	VA01	Kreiraj prodajni nalog odjava konsignacije/Create a sales order check out the consignment	Kreiraj prodajni nalog odjava konsignacije/Create a sales order check out the consignment	POMK	Sales Distribution/SD	\N	Konsignacija kupca - odjava / Buyer's consignment check out	Kreiraj prodajni nalog odjava konsignacije/Create a sales order check out the consignment	Kreiraj prodajni nalog odjava konsignacije/Create a sales order check out the consignment	723	8210	\N
14003	ZN10 - A1 - STORNO	VL01N	Kreiraj izlaznu isporuku odjave konsignacije/Create a consignment check out delivery	Kreiraj izlaznu isporuku odjave konsignacije/Create a consignment check out delivery	POMK	Sales Distribution/SD	\N	Konsignacija kupca - odjava / Buyer's consignment check out	Kreiraj izlaznu isporuku odjave konsignacije/Create a consignment check out delivery	Kreiraj izlaznu isporuku odjave konsignacije/Create a consignment check out delivery	724	8211	\N
14004	ZN10 - A1 - STORNO	VF01	Kreiraj fakturu odjave konsignacije/Create a consignment check-out invoice	Kreiraj fakturu odjave konsignacije/Create a consignment check-out invoice	POMK	Sales Distribution/SD	\N	Konsignacija kupca - odjava / Buyer's consignment check out	Kreiraj fakturu odjave konsignacije/Create a consignment check-out invoice	Kreiraj fakturu odjave konsignacije/Create a consignment check-out invoice	725	8212	\N
14005	ZN10 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Konsignacija kupca - odjava / Buyer's consignment check out	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	726	8213	\N
14006	ZN12 - A1 - STORNO	VA01	Kreiraj nalog povrata na konsignaciju/Create a consignment return order	Kreiraj nalog povrata na konsignaciju/Create a consignment return order	POMK	Sales Distribution/SD	\N	Konsignacija kupca - povrat / Buyer's consignment return	Kreiraj nalog povrata na konsignaciju/Create a consignment return order	Kreiraj nalog povrata na konsignaciju/Create a consignment return order	727	8214	\N
14007	ZN12 - A1 - STORNO	VL01N	Kreiraj isporuku povrata na konsignaciju/ Create a consignment return delivery	Kreiraj isporuku povrata na konsignaciju/ Create a consignment return delivery	POMK	Sales Distribution/SD	\N	Konsignacija kupca - povrat / Buyer's consignment return	Kreiraj isporuku povrata na konsignaciju/ Create a consignment return delivery	Kreiraj isporuku povrata na konsignaciju/ Create a consignment return delivery	728	8215	\N
14008	ZN12 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Konsignacija kupca - povrat / Buyer's consignment return	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	729	8216	\N
14009	ZN11 - A1 - STORNO	VA01	Kreiraj prodajni nalog punjenje konsignacije/Create sales order filling consignment	Kreiraj prodajni nalog punjenje konsignacije/Create sales order filling consignment	POMK	Sales Distribution/SD	\N	Konsignacija kupca - punjenje / Buyer's consignment - charge	Kreiraj prodajni nalog punjenje konsignacije/Create sales order filling consignment	Kreiraj prodajni nalog punjenje konsignacije/Create sales order filling consignment	730	8217	\N
14010	ZN11 - A1 - STORNO	VL01N	Kreiraj izlaznu isporuku punjenja konsignacije/Create an outbound consignment fill delivery	Kreiraj izlaznu isporuku punjenja konsignacije/Create an outbound consignment fill delivery	POMK	Sales Distribution/SD	\N	Konsignacija kupca - punjenje / Buyer's consignment - charge	Kreiraj izlaznu isporuku punjenja konsignacije/Create an outbound consignment fill delivery	Kreiraj izlaznu isporuku punjenja konsignacije/Create an outbound consignment fill delivery	731	8218	\N
14011	ZN11 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Konsignacija kupca - punjenje / Buyer's consignment - charge	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	732	8219	\N
14012	ZTRM - A1 - STORNO	ZODO	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	POMK	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	733	8220	\N
14013	ZTRM - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	734	8221	\N
14014	ZTR1 - A1 - STORNO	ZODO	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	POMK	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	735	8222	\N
14015	ZTR1 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	736	8223	\N
14016	ZNR - STORNO	ZODO	Pregled sporazuma o rabatu/Overview of rebate agreements	Pregled sporazuma o rabatu/Overview of rebate agreements	POMK	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Pregled sporazuma o rabatu/Overview of rebate agreements	Pregled sporazuma o rabatu/Overview of rebate agreements	737	8224	\N
14017	ZNR - STORNO	ZODO	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	POMK	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	738	8225	\N
14018	ZNR - STORNO	VF01	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	POMK	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	739	8226	\N
14019	ZNR - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	740	8227	\N
14020	ZNR - AA - STORNO	VA01	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	POMK	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	741	8228	\N
14021	ZNR - AA - STORNO	VF01	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	POMK	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	742	8229	\N
14022	ZNR - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	743	8230	\N
14023	ZN05 - A1,  proizvodi - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	744	8231	\N
14024	ZN05 - A1,  proizvodi - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	745	8232	\N
14025	ZN05 - A1,  proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	746	8233	\N
14026	ZN05 - AA,  proizvodi - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	747	8234	\N
14027	ZN05 - AA,  proizvodi - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	748	8235	\N
14028	ZN05 - AA,  proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	749	8236	\N
14029	ZN07 - A1,  proizvodi - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	750	8237	\N
14030	ZN07 - A1,  proizvodi - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	751	8238	\N
14031	ZN07 - A1,  proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	752	8239	\N
14080	ZN02 - AA - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	MIRN	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	801	8288	\N
14033	ZN07 - AA,  proizvodi - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	754	8241	\N
14034	ZN07 - AA,  proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	755	8242	\N
14035	ZN1 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	756	8243	\N
14036	ZN1 - A1 - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	757	8244	\N
14037	ZN1 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	758	8245	\N
14038	Z850 - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	759	8246	\N
14039	Z850 - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	760	8247	\N
14040	Z850 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	761	8248	\N
14041	ZN08 - A1 - STORNO	SFA	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POMK	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	762	8249	\N
14042	ZN08 - A1 - STORNO	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	POMK	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	763	8250	\N
14043	ZN08 - A1 - STORNO	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	POMK	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	764	8251	\N
14044	ZN08 - A1 - STORNO	E-PISARNICA	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	POMK	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	765	8252	\N
14045	ZN08 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POMK	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	766	8253	\N
14046	ZN08 - A1 - STORNO	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	POMK	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	767	8254	\N
14047	ZN08 - A1 - STORNO	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	POMK	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	768	8255	\N
14048	ZN08 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	769	8256	\N
14049	ZN13 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POMK	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	770	8257	\N
14050	ZN13 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POMK	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	771	8258	\N
14051	ZN13 - A1 - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POMK	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	772	8259	\N
14052	ZN13 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	773	8260	\N
14053	ZN02 - AA - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	774	8261	\N
14054	ZN02 - AA - STORNO	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	775	8262	\N
14055	ZN02 - AA - STORNO	VT01N	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	776	8263	\N
14081	ZN02 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	802	8289	\N
14056	ZN02 - AA - STORNO	VI01	Kreiraj obračun troškova – Create an cost report	Kreiraj obračun troškova – Create an cost report	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj obračun troškova – Create an cost report	Kreiraj obračun troškova – Create an cost report	777	8264	\N
14057	ZN02 - AA - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	778	8265	\N
14058	ZN02 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	779	8266	\N
14059	Z831 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	780	8267	\N
14060	Z831 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	781	8268	\N
14061	Z831 - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	782	8269	\N
14062	Z831 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	783	8270	\N
14063	ZN01 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	784	8271	\N
14064	ZN01 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	785	8272	\N
14065	ZN01 - A1 - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	786	8273	\N
14066	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	787	8274	\N
14067	ZN03 - AA - STORNO	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	POMK	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	788	8275	\N
14068	ZN03 - AA - STORNO	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	POMK	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	789	8276	\N
14069	ZN03 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	790	8277	\N
14070	ZN03 - A1 - STORNO	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	POMK	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	791	8278	\N
14071	ZN03 - A1 - STORNO	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	POMK	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	792	8279	\N
14072	ZN01 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	793	8280	\N
14073	ZN01 - A1 - STORNO	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	MIRN	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	794	8281	\N
14074	ZN01 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	MIRN	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	795	8282	\N
14075	ZN01 - A1 - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	MIRN	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	796	8283	\N
14076	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	797	8284	\N
14077	ZN02 - AA - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	798	8285	\N
14078	ZN02 - AA - STORNO	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	MIRN	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	799	8286	\N
14770	TEST	WCOLI	Poregled pogoja	TEST	ZITO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Poregled pogoja	1491	8978	\N
14082	ZN05 - A1,  proizvodi - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	MIRN	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	803	8290	\N
14083	ZN05 - A1,  proizvodi - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	MIRN	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	804	8291	\N
14084	ZN05 - A1,  proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	805	8292	\N
14085	ZN05 - AA,  proizvodi - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	MIRN	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	806	8293	\N
14086	ZN05 - AA,  proizvodi - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	MIRN	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	807	8294	\N
14087	ZN05 - AA,  proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	808	8295	\N
14088	ZN07 - A1,  proizvodi - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	MIRN	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	809	8296	\N
14089	ZN07 - A1,  proizvodi - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	MIRN	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	810	8297	\N
14090	ZN07 - A1,  proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	811	8298	\N
14091	ZN07 - AA,  proizvodi - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	MIRN	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	812	8299	\N
14092	ZN07 - AA,  proizvodi - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	MIRN	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	813	8300	\N
14093	ZN07 - AA,  proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	814	8301	\N
14094	ZN08 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	815	8302	\N
14095	ZN08 - A1 - STORNO	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	816	8303	\N
14096	ZN08 - A1 - STORNO	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	817	8304	\N
14097	ZN08 - A1 - STORNO	E-PISARNICA	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	818	8305	\N
14098	ZN08 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	819	8306	\N
14099	ZN09 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	820	8307	\N
14100	ZN09 - A1 - STORNO	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	821	8308	\N
14101	ZN09 - A1 - STORNO	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	822	8309	\N
14102	ZN09 - A1 - STORNO	E-PISARNICA	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	823	8310	\N
14103	ZN09 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	824	8311	\N
14104	ZN08 - AA - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	825	8312	\N
14105	ZN08 - AA - STORNO	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	826	8313	\N
14106	ZN08 - AA - STORNO	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	827	8314	\N
14107	ZN08 - AA - STORNO	E-PISARNICA	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	828	8315	\N
14108	ZN08 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	829	8316	\N
14109	ZN09 - AA - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	830	8317	\N
14110	ZN09 - AA - STORNO	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	831	8318	\N
14111	ZN09 - AA - STORNO	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	832	8319	\N
14112	ZN09 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	833	8320	\N
14113	ZREM - A1 - STORNO	VA01	Kreiraj nalog povrata/Create  a return order	Kreiraj nalog povrata/Create  a return order	MIRN	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje -  povrat / Sale of goods through retail - return	Kreiraj nalog povrata/Create  a return order	Kreiraj nalog povrata/Create  a return order	834	8321	\N
14114	ZREM - A1 - STORNO	VL01N	Kreiraj isporuku povrata/Create  a delivery of return	Kreiraj isporuku povrata/Create  a delivery of return	MIRN	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje -  povrat / Sale of goods through retail - return	Kreiraj isporuku povrata/Create  a delivery of return	Kreiraj isporuku povrata/Create  a delivery of return	835	8322	\N
14115	ZREM - A1 - STORNO	VF01	Kreiraj  povrat zaduženja maloprodaje/ Create chergeback	Kreiraj  povrat zaduženja maloprodaje/ Create chergeback	MIRN	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje -  povrat / Sale of goods through retail - return	Kreiraj  povrat zaduženja maloprodaje/ Create chergeback	Kreiraj  povrat zaduženja maloprodaje/ Create chergeback	836	8323	\N
14116	ZREM - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje -  povrat / Sale of goods through retail - return	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	837	8324	\N
14117	ZMP - A1 - STORNO	VA01	Kreiraj prodajni nalog- /Create sales order	Kreiraj prodajni nalog- /Create sales order	MIRN	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje - zaduženje / Sale of goods through retail - debit	Kreiraj prodajni nalog- /Create sales order	Kreiraj prodajni nalog- /Create sales order	838	8325	\N
14118	ZMP - A1 - STORNO	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	MIRN	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje - zaduženje / Sale of goods through retail - debit	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	839	8326	\N
14119	ZMP - A1 - STORNO	VF01	Kreiraj zaduženje maloprodaje /  Create retail charge	Kreiraj zaduženje maloprodaje /  Create retail charge	MIRN	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje - zaduženje / Sale of goods through retail - debit	Kreiraj zaduženje maloprodaje /  Create retail charge	Kreiraj zaduženje maloprodaje /  Create retail charge	840	8327	\N
14120	ZMP - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Prodaja robe preko maloprodaje - zaduženje / Sale of goods through retail - debit	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	841	8328	\N
14121	ZN02 - AA - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	842	8329	\N
14122	ZN02 - AA - STORNO	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	843	8330	\N
14123	ZN02 - AA - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	844	8331	\N
14124	ZN02 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	845	8332	\N
14125	ZN01 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	846	8333	\N
14126	ZN01 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	847	8334	\N
14767	TEST	WZR4	Storno dokumetnov obračuna	TEST	ZITO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Storno dokumetnov obračuna	1488	8975	\N
14127	ZN01 - A1 - STORNO	VF01	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	848	8335	\N
14128	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu - bez dokaza isporuke sa pošiljkom i obračunom troškova /	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	849	8336	\N
14129	ZN03 - AA - STORNO	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	MIRN	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	850	8337	\N
14130	ZN03 - AA - STORNO	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	MIRN	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	851	8338	\N
14131	ZN03 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	852	8339	\N
14132	ZN03 - A1 - STORNO	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	MIRN	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	853	8340	\N
14133	ZN03 - A1 - STORNO	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	MIRN	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	854	8341	\N
14134	ZN03 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	855	8342	\N
14135	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PLKO	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	856	8343	\N
14136	ZN02 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PLKO	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	857	8344	\N
14137	ZWCR - A1, proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PLKO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	858	8345	\N
14138	ZWDR - A1, proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PLKO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	859	8346	\N
14139	ZWCR  - AA, proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PLKO	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	860	8347	\N
14140	ZN09 - AA - STORNO	E-PISARNICA	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	861	8348	\N
14141	ZN02 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PLKO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	862	8349	\N
14142	ZN03 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PLKO	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	863	8350	\N
14143	ZNR - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POYU	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	864	8351	\N
14144	ZN06 - A1,  usluge - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POYU	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	865	8352	\N
14145	ZN06 - A1,  usluge - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POYU	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	866	8353	\N
14146	ZN06 - A1,  usluge - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POYU	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	867	8354	\N
14147	ZN03 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PLKO	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	868	8355	\N
14148	Z270 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POYU	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	869	8356	\N
14149	ZN08 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POYU	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	870	8357	\N
14150	ZN09 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POYU	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	871	8358	\N
14151	ZN13 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POYU	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	872	8359	\N
14152	ZN02 - AA - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POYU	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	873	8360	\N
14153	ZN02 - AA - STORNO	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	POYU	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	874	8361	\N
14154	ZN02 - AA - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POYU	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	875	8362	\N
14155	ZN02 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POYU	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	876	8363	\N
14156	ZN03 - AA - STORNO	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	POYU	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	877	8364	\N
14157	ZN03 - AA - STORNO	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	POYU	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	878	8365	\N
14158	ZN03 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POYU	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	879	8366	\N
14159	ZN03 - A1 - STORNO	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	POYU	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	880	8367	\N
14160	ZN03 - A1 - STORNO	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	POYU	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	881	8368	\N
14161	ZN01 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POCG	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	882	8369	\N
14162	ZN01 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POCG	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	883	8370	\N
14163	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POCG	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	884	8371	\N
14164	ZN02 - AA - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POCG	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	885	8372	\N
14165	ZN02 - AA - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POCG	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	886	8373	\N
14166	ZN02 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POCG	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	887	8374	\N
14167	ZTRM - A1 - STORNO	ZODO	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	POCG	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	888	8375	\N
14168	ZTRM - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POCG	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	889	8376	\N
14169	ZNR - STORNO	ZODO	Pregled sporazuma o rabatu/Overview of rebate agreements	Pregled sporazuma o rabatu/Overview of rebate agreements	POCG	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Pregled sporazuma o rabatu/Overview of rebate agreements	Pregled sporazuma o rabatu/Overview of rebate agreements	890	8377	\N
14170	ZNR - STORNO	ZODO	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	POCG	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	891	8378	\N
14171	ZNR - STORNO	VF01	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	POCG	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	892	8379	\N
14172	ZNR - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POCG	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	893	8380	\N
14173	ZNR - AA - STORNO	VA01	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	POCG	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	Kreiraj nalog za naknadni rabat/Create an order for additional rebate	894	8381	\N
14174	ZNR - AA - STORNO	VF01	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	POCG	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	Kreiraj odobrenje za naknadni rabat/Create an authorization for additional rebate	895	8382	\N
14175	ZNR - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POCG	Sales Distribution/SD	\N	Proces obračuna cassa sconto / The cassa sconto calculation process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	896	8383	\N
14176	ZN04 - AA, usluge - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POCG	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	897	8384	\N
14177	ZN04 - AA, usluge - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POCG	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	898	8385	\N
14178	ZN04 - AA, usluge - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POCG	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	899	8386	\N
14179	Z311 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POCG	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	900	8387	\N
14180	Z311 - A1 - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POCG	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	901	8388	\N
14181	Z311 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POCG	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	902	8389	\N
14182	Z320 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POCG	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	903	8390	\N
14183	Z320 - A1 - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POCG	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	904	8391	\N
14184	Z320 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POCG	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	905	8392	\N
14185	Z320 - AA - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POCG	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	906	8393	\N
14186	Z320 - AA - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POCG	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	907	8394	\N
14187	Z320 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POCG	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	908	8395	\N
14188	ZN08 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POCG	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	909	8396	\N
14189	ZN08 - A1 - STORNO	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	POCG	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	910	8397	\N
14190	ZN08 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POCG	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	911	8398	\N
14191	ZN14 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POCG	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	912	8399	\N
14192	ZN14 - A1 - STORNO	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	POCG	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	913	8400	\N
14193	ZN14 - A1 - STORNO	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	POCG	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	914	8401	\N
14217	ZN01 - A1 - STORNO	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	HUMA	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	938	8425	\N
14194	ZN14 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POCG	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	915	8402	\N
14195	ZN09 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POCG	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	916	8403	\N
14196	ZN09 - A1 - STORNO	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	POCG	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	917	8404	\N
14197	ZN09 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POCG	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	918	8405	\N
14198	ZN13 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POCG	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	919	8406	\N
14199	ZN13 - A1 - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POCG	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	920	8407	\N
14200	ZN02 - AA -  STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POBH	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	921	8408	\N
14201	ZN02 - AA -  STORNO	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	POBH	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	922	8409	\N
14202	ZN02 - AA -  STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POBH	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	923	8410	\N
14203	ZN13 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POCG	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	924	8411	\N
14204	ZN02 - AA - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POCG	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	925	8412	\N
14205	ZN02 - AA - STORNO	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	POCG	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	926	8413	\N
14206	ZN02 - AA - STORNO	VT01N	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	POCG	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	927	8414	\N
14207	ZN02 - AA - STORNO	VI01	Kreiraj obračun troškova – Create an cost report	Kreiraj obračun troškova – Create an cost report	POCG	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj obračun troškova – Create an cost report	Kreiraj obračun troškova – Create an cost report	928	8415	\N
14208	ZN02 - AA - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POCG	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	929	8416	\N
14209	ZN02 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POCG	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	930	8417	\N
14210	ZN01 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POCG	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	931	8418	\N
14211	ZN01 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POCG	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	932	8419	\N
14212	ZN01 - A1 - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POCG	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	933	8420	\N
14213	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POCG	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	934	8421	\N
14214	ZN03 - A1 - STORNO	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	POCG	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	935	8422	\N
14215	ZN03 - A1 - STORNO	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	POCG	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	936	8423	\N
14216	ZN01 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	HUMA	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	937	8424	\N
14220	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	HUMA	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	941	8428	\N
14221	ZN02 - AA - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	HUMA	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	942	8429	\N
14222	ZN02 - AA - STORNO	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	HUMA	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	943	8430	\N
14223	ZN02 - AA - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	HUMA	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	944	8431	\N
14224	ZN02 - AA - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	HUMA	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	945	8432	\N
14225	ZN02 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	HUMA	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	946	8433	\N
14226	ZTRM - A1 - STORNO	ZODO	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	HUMA	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	947	8434	\N
14227	ZTRM - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	HUMA	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	948	8435	\N
14228	ZHCR - A1,  proizvodi - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	HUMA	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	949	8436	\N
14229	ZHCR - A1,  proizvodi - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	HUMA	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	950	8437	\N
14230	ZHCR - A1,  proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	HUMA	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	951	8438	\N
14231	ZHDR - A1,  proizvodi - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	HUMA	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	952	8439	\N
14232	ZHDR - A1,  proizvodi - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	HUMA	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	953	8440	\N
14233	ZHDR - A1,  proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	HUMA	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	954	8441	\N
14234	ZN02 - AA - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	HUMA	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	955	8442	\N
14235	ZN02 - AA - STORNO	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	HUMA	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	956	8443	\N
14236	ZN02 - AA - STORNO	VT01N	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	HUMA	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	957	8444	\N
14237	ZN02 - AA - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	HUMA	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	958	8445	\N
14238	ZN02 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	HUMA	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	959	8446	\N
14239	ZN01 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	HUMA	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	960	8447	\N
14240	ZN01 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	HUMA	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	961	8448	\N
14241	ZN01 - A1 - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	HUMA	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	962	8449	\N
14242	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	HUMA	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	963	8450	\N
14602	ZN01	BD87	obrada dokumenta s greškom	obrada dokumenta s greškom - IF	ZITO	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	obrada dokumenta s greškom - IF	obrada dokumenta s greškom	1323	8810	\N
14243	ZN03 - AA - STORNO	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	HUMA	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	964	8451	\N
14244	ZN03 - AA - STORNO	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	HUMA	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	965	8452	\N
14245	ZN03 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	HUMA	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	966	8453	\N
14246	ZN03 - A1 - STORNO	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	HUMA	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	967	8454	\N
14247	ZN03 - A1 - STORNO	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	HUMA	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	968	8455	\N
14248	ZN02 - AA -  STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POBH	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	969	8456	\N
14249	ZN01 - A1 -  STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POBH	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	970	8457	\N
14250	ZN01 - A1 -  STORNO	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	POBH	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	971	8458	\N
14251	ZN01 - A1 -  STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POBH	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	972	8459	\N
14252	ZN01 - A1 -  STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POBH	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	973	8460	\N
14253	ZN01 - A1 -  STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POBH	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	974	8461	\N
14254	ZN02 - AA -  STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POBH	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	975	8462	\N
14255	ZN02 - AA -  STORNO	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	POBH	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	976	8463	\N
14256	ZN02 - AA -  STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POBH	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	977	8464	\N
14257	ZN02 - AA -  STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POBH	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	978	8465	\N
14258	ZN02 - AA -  STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POBH	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	979	8466	\N
14259	ZN08 - A1 -  STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POBH	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	980	8467	\N
14260	ZN08 - A1 -  STORNO	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	POBH	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	981	8468	\N
14261	ZN08 - A1 -  STORNO	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	POBH	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	982	8469	\N
14262	ZN08 - A1 -  STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POBH	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	983	8470	\N
14263	ZN14 - A1 -  STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POBH	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	984	8471	\N
14264	ZN14 - A1 -  STORNO	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	POBH	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	985	8472	\N
14265	ZN14 - A1 -  STORNO	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	POBH	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	986	8473	\N
14266	ZN14 - A1 -  STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POBH	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	987	8474	\N
14267	ZN13 - A1 -  STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POBH	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	988	8475	\N
14268	ZN13 - A1 -  STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POBH	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	989	8476	\N
14269	ZN13 - A1 -  STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POBH	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	990	8477	\N
14270	ZN13 - A1 -  STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POBH	Sales Distribution/SD	\N	Vlastita potrošnja / Own consumption	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	991	8478	\N
14271	ZN03 - AA -  STORNO	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	POBH	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	992	8479	\N
14272	ZN03 - AA -  STORNO	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	POBH	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	993	8480	\N
14273	ZN03 - AA -  STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POBH	Sales Distribution/SD	\N	Prodaja usluga na inozemno tržište / Sale of services to export market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	994	8481	\N
14274	ZN03 - A1 -  STORNO	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	POBH	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	995	8482	\N
14275	ZN03 - A1 -  STORNO	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	POBH	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	996	8483	\N
14276	ZN01 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	KONR	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	997	8484	\N
14277	ZN01 - A1 - STORNO	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	KONR	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	998	8485	\N
14278	ZN01 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	KONR	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	999	8486	\N
14279	ZN01 - A1 - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	KONR	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1000	8487	\N
14280	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	KONR	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1001	8488	\N
14281	ZN02 - AA - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	KONR	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1002	8489	\N
14282	ZN02 - AA - STORNO	VF01	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	KONR	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj proformu/Create proforma	Kreiraj proformu/Create proforma	1003	8490	\N
14283	ZN02 - AA - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	KONR	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	1004	8491	\N
14284	ZN02 - AA - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	KONR	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1005	8492	\N
14285	ZN02 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	KONR	Sales Distribution/SD	\N	Avansna prodaja / Advance sales	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1006	8493	\N
14286	ZTRM - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	KONR	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1007	8494	\N
14287	ZN04 - A1, proizvodi - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	KONR	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1008	8495	\N
14288	ZN04 - A1, proizvodi - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	KONR	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	1009	8496	\N
14289	ZN04 - A1, proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	KONR	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1010	8497	\N
14290	ZN04 - A1, usluge - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	KONR	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1011	8498	\N
14313	ZSKM - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POSK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1034	8521	\N
14291	ZN04 - A1, usluge - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	KONR	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	1012	8499	\N
14292	ZN04 - A1, usluge - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	KONR	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1013	8500	\N
14293	ZN04 - AA, proizvodi - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	KONR	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1014	8501	\N
14294	ZN04 - AA, proizvodi - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	KONR	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	1015	8502	\N
14295	ZN04 - AA, proizvodi - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	KONR	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1016	8503	\N
14296	ZN04 - AA, usluge - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	KONR	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1017	8504	\N
14297	ZN04 - AA, usluge - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	KONR	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	1018	8505	\N
14298	ZN04 - AA, usluge - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	KONR	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1019	8506	\N
14299	ZN08 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	KONR	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1020	8507	\N
14300	ZN08 - A1 - STORNO	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	KONR	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	1021	8508	\N
14301	ZN08 - A1 - STORNO	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	KONR	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	1022	8509	\N
14302	ZN08 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	KONR	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1023	8510	\N
14303	ZN02 - AA - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	KONR	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1024	8511	\N
14304	ZN02 - AA - STORNO	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	KONR	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	1025	8512	\N
14305	ZN02 - AA - STORNO	VT01N	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	KONR	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	1026	8513	\N
14306	ZN02 - AA - STORNO	VI01	Kreiraj obračun troškova – Create an cost report	Kreiraj obračun troškova – Create an cost report	KONR	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj obračun troškova – Create an cost report	Kreiraj obračun troškova – Create an cost report	1027	8514	\N
14307	ZN02 - AA - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	KONR	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1028	8515	\N
14308	ZN02 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	KONR	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1029	8516	\N
14309	ZN03 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1030	8517	\N
14310	ZTRM - A1 - STORNO	ZODO	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	POSK	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	Knjiženje naloga – odobrenja  TM faktura/Booking of orders – approval of TM invoices	1031	8518	\N
14311	ZTRM - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POSK	Sales Distribution/SD	\N	Proces knjiženja TM faktura/The process of posting TM invoices	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1032	8519	\N
14312	ZRR2 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POSK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1033	8520	\N
14663	ZN08	VA02	Promjena naloga	Promjeni naloga ako je potrebno	POLJ	Sales Distribution/SD	\N	Intercompany 2 - Nalog povr.neog.zal.	Promjeni naloga ako je potrebno	Promjena naloga	1384	8871	\N
14314	ZSKM - A1 - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	POSK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	1035	8522	\N
14315	ZSKM - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POSK	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1036	8523	\N
14316	ZN06 - A1,  usluge - STORNO	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	INTS	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1037	8524	\N
14317	ZN06 - A1,  usluge - STORNO	VF01	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	INTS	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Kreiraj odobrenje-terećenje/Create approval-debit	Kreiraj odobrenje-terećenje/Create approval-debit	1038	8525	\N
14318	ZN06 - A1,  usluge - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	INTS	Sales Distribution/SD	\N	Proces odobrenja i terećenja / Debit and approval process	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1039	8526	\N
14319	ZN03 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POYU	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1040	8527	\N
14320	ZN03 - A1 - STORNO	VA01	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	ZIMP	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj prodajni nalog za usluge/Create a sales order for services	Kreiraj prodajni nalog za usluge/Create a sales order for services	1041	8528	\N
14321	ZN03 - A1 - STORNO	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	ZIMP	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu za usluge/Create invoice for services	1042	8529	\N
14322	ZN03 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	HUMA	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1043	8530	\N
14323	ZN09 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	HUMA	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1044	8531	\N
14324	ZN09 - A1 - STORNO	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	HUMA	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	1045	8532	\N
14325	ZN09 - A1 - STORNO	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	HUMA	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	1046	8533	\N
14326	ZN09 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	HUMA	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1047	8534	\N
14327	ZN09 - AA - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	HUMA	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1048	8535	\N
14328	ZN09 - AA - STORNO	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	HUMA	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	1049	8536	\N
14329	ZN09 - AA - STORNO	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	HUMA	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	1050	8537	\N
14330	ZN03 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	BEPO	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1051	8538	\N
14331	ZTRR - A1 - STORNO	ZODO	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	ZITO	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	1052	8539	\N
14332	ZTRR - A1 - STORNO	ZSTORNO	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	ZITO	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	1053	8540	\N
14333	ZTRR - A1 - STORNO	ZODO	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	ZITO	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	1054	8541	\N
14334	ZN09 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	LACZ	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1055	8542	\N
14376	ZTRR - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POCG	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1097	8584	\N
14335	ZTRR - A1 - STORNO	ZODO	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	LACZ	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	1056	8543	\N
14336	ZTRR - A1 - STORNO	ZSTORNO	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	LACZ	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	1057	8544	\N
14337	ZTRR - A1 - STORNO	ZODO	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	LACZ	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	1058	8545	\N
14338	ZTRR - A1 - STORNO	ZODO	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	POLJ	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	1059	8546	\N
14339	ZTRR - A1 - STORNO	ZSTORNO	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	POLJ	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	1060	8547	\N
14340	ZTRR - A1 - STORNO	ZODO	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	POLJ	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	1061	8548	\N
14341	ZN08 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PLKO	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1062	8549	\N
14342	ZTRR - A1 - STORNO	ZODO	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	PLKO	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	1063	8550	\N
14343	ZTRR - A1 - STORNO	ZSTORNO	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	PLKO	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	1064	8551	\N
14344	ZTRR - A1 - STORNO	ZODO	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	PLKO	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	1065	8552	\N
14345	ZN03 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZIMP	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1066	8553	\N
14346	ZTRR - A1 - STORNO	ZODO	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	POYU	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	1067	8554	\N
14347	ZTRR - A1 - STORNO	ZSTORNO	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	POYU	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	1068	8555	\N
14348	ZN03 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POCG	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1069	8556	\N
14349	ZTRR - A1 - STORNO	ZODO	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	POCG	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	1070	8557	\N
14350	ZTRR - A1 - STORNO	ZSTORNO	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	POCG	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	1071	8558	\N
14351	ZTRR - A1 - STORNO	ZODO	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	POCG	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	Knjiženje novih rezervacija (kumulativ)/Booking of new reservations (cumulative)	1072	8559	\N
14352	ZN09 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	HUMA	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1073	8560	\N
14375	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1096	8583	\N
14353	ZTRR - A1 - STORNO	ZODO	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	HUMA	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	1074	8561	\N
14354	ZTRR - A1 - STORNO	ZSTORNO	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	HUMA	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	1075	8562	\N
14355	ZN03 - A1 -  STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POBH	Sales Distribution/SD	\N	Prodaja usluga na domaćem tržištu / Sale of services on the domestic market	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1076	8563	\N
14356	ZTRR - A1 - STORNO	ZSTORNO	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	KONR	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storno rezervacija/Cancellation of reservation	Storno rezervacija/Cancellation of reservation	1077	8564	\N
14357	ZN01 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1078	8565	\N
14358	ZN01 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	1079	8566	\N
14359	ZN01 - A1 - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1080	8567	\N
14360	ZN09 - AA - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca / The process of returning goods from the customer	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1081	8568	\N
14361	ZN01 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1082	8569	\N
14362	ZN01 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	1083	8570	\N
14363	ZN01 - A1 - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	MIRN	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1084	8571	\N
14364	ZN01 - A1 - STORNO	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	KONR	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1085	8572	\N
14365	ZN01 - A1 - STORNO	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	KONR	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	1086	8573	\N
14366	ZN01 - A1 - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	KONR	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1087	8574	\N
14367	ZTRR - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POSK	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1088	8575	\N
14368	ZRN1 - STORNO	VA01	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	POMK	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	Knjiženje naloga-odobrenja rezervacija (kumulativ)/Posting of reservation approval orders (cumulativ	1089	8576	\N
14369	ZRN1 - STORNO	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POMK	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1090	8577	\N
14370	ZRN1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POMK	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1091	8578	\N
14371	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	PLKO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1092	8579	\N
14372	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	BEPO	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1093	8580	\N
14373	ZN01 - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	KONR	Sales Distribution/SD	\N	Prodaja robe sa zalihe na domaćem tržištu bez dokaza isporuke/Sale of goods from stock on the domest	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1094	8581	\N
14374	ZTRR - A1 - STORNO	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	LACZ	Sales Distribution/SD	\N	Proces naknadnih TM rabata rezervacije	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1095	8582	\N
14705	TEST	ZDELPICK	TEST	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1426	8913	\N
14377	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01: e -račun	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1098	8585	\N
14378	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	MIRN	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01: e -račun	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	1099	8586	\N
14379	ZN01 - A1	VF01	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	MIRN	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01: e -račun	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	1100	8587	\N
14380	ZN01 - A1	EDOC_COCKPIT	Slanje e- fakture	Pošalji e- fakturu	MIRN	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01: e -račun	Pošalji e- fakturu	Slanje e- fakture	1101	8588	\N
14381	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1102	8589	\N
14382	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	MIRN	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	1103	8590	\N
14383	ZN01 - A1	VF01	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	MIRN	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Kreiraj fakturu/Create invoice	Kreiraj fakturu/Create invoice	1104	8591	\N
14384	ZN01 - A1	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1105	8592	\N
14385	ZN01 - A1	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	MIRN	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1106	8593	\N
14386	ZN03 - A1	VA01	Nalog za usluge / Service order	Kreiraj nalog za usluge/Create service order	MIRN	Sales Distribution/SD	\N	Faktura usluge ZF03: e -račun	Kreiraj nalog za usluge/Create service order	Nalog za usluge / Service order	1107	8594	\N
14387	ZN03 - A1	VF03	Faktura usluge/Service invoice	Kreiraj fakturu/Create an invoice	MIRN	Sales Distribution/SD	\N	Faktura usluge ZF03: e -račun	Kreiraj fakturu/Create an invoice	Faktura usluge/Service invoice	1108	8595	\N
14388	ZN03 - A1	EDOC_COCKPIT	Slanje e- fakture	Pošalji e- fakturu	MIRN	Sales Distribution/SD	\N	Faktura usluge ZF03: e -račun	Pošalji e- fakturu	Slanje e- fakture	1109	8596	\N
14389	ZN03 - A1	VA01	Nalog za usluge / Service order	Kreiraj nalog za usluge/Create service order	MIRN	Sales Distribution/SD	\N	Faktura usluge ZF03 - storno: e -račun	Kreiraj nalog za usluge/Create service order	Nalog za usluge / Service order	1110	8597	\N
14390	ZN03 - A1	VF03	Faktura usluge/Service invoice	Kreiraj fakturu/Create an invoice	MIRN	Sales Distribution/SD	\N	Faktura usluge ZF03 - storno: e -račun	Kreiraj fakturu/Create an invoice	Faktura usluge/Service invoice	1111	8598	\N
14391	ZN03 - A1	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Faktura usluge ZF03 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1112	8599	\N
14392	ZN03 - A1	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	MIRN	Sales Distribution/SD	\N	Faktura usluge ZF03 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1113	8600	\N
14393	ZN05 - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	MIRN	Sales Distribution/SD	\N	Financijsko odobrenje ZF04: e-račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1114	8601	\N
14394	ZN05 - A1, proizvodi	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	MIRN	Sales Distribution/SD	\N	Financijsko odobrenje ZF04: e-račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1115	8602	\N
14395	ZN05 - A1, proizvodi	EDOC_COCKPIT	Slanje e- fakture	Pošalji e- fakturu	MIRN	Sales Distribution/SD	\N	Financijsko odobrenje ZF04: e-račun	Pošalji e- fakturu	Slanje e- fakture	1116	8603	\N
14396	ZN05 - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	MIRN	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1117	8604	\N
14397	ZN05 - A1, proizvodi	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	MIRN	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1118	8605	\N
14398	ZN05 - A1, proizvodi	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1119	8606	\N
14399	ZN05 - A1, proizvodi	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	MIRN	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1120	8607	\N
14400	ZN07 - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	MIRN	Sales Distribution/SD	\N	Financijsko terećenje ZF05: e-račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1121	8608	\N
14401	ZN07 - A1, proizvodi	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	MIRN	Sales Distribution/SD	\N	Financijsko terećenje ZF05: e-račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1122	8609	\N
14402	ZN07 - A1, proizvodi	EDOC_COCKPIT	Slanje e- fakture	Pošalji e- fakturu	MIRN	Sales Distribution/SD	\N	Financijsko terećenje ZF05: e-račun	Pošalji e- fakturu	Slanje e- fakture	1123	8610	\N
14403	ZN07 - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	MIRN	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1124	8611	\N
14404	ZN07 - A1, proizvodi	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	MIRN	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1125	8612	\N
14405	ZN07 - A1, proizvodi	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1126	8613	\N
14406	ZN07 - A1, proizvodi	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	MIRN	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1127	8614	\N
14407	ZN08 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08: e-račun	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1128	8615	\N
14408	ZN08 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08: e-račun	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	1129	8616	\N
14409	ZN08 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08: e-račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1130	8617	\N
14410	ZN08 - A1	EDOC_COCKPIT	Slanje e- fakture	Pošalji e- fakturu	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08: e-račun	Pošalji e- fakturu	Slanje e- fakture	1131	8618	\N
14411	ZN08 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08 - strorno: e-račun	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1132	8619	\N
14412	ZN08 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08 - strorno: e-račun	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	1133	8620	\N
14413	ZN08 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08 - strorno: e-račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1134	8621	\N
14414	ZN08 - A1	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08 - strorno: e-račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1135	8622	\N
14415	ZN08 - A1	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08 - strorno: e-račun	Pošalji storno e- fakture	Slanje storno e- fakture	1136	8623	\N
14416	ZN09 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF09: e-račun	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1137	8624	\N
14417	ZN09 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF09: e-račun	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	1138	8625	\N
14418	ZN09 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj fakturu/Create an invoice	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF09: e-račun	Kreiraj fakturu/Create an invoice	Kreiraj odobrenje/Create approval	1139	8626	\N
14419	ZN09 - A1	EDOC_COCKPIT	Slanje e- fakture	Pošalji e- fakturu	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF09: e-račun	Pošalji e- fakturu	Slanje e- fakture	1140	8627	\N
14420	ZN09 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF09 - strorno: e-račun	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	1141	8628	\N
14421	ZN09 - A1	VF01	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF09 - strorno: e-račun	Kreiraj odobrenje/Create approval	Kreiraj odobrenje/Create approval	1142	8629	\N
14422	ZN09 - A1	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF09 - strorno: e-račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1143	8630	\N
14423	ZN09 - A1	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	MIRN	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF09 - strorno: e-račun	Pošalji storno e- fakture	Slanje storno e- fakture	1144	8631	\N
14424	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POLJ	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1145	8632	\N
14425	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	POLJ	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	1146	8633	\N
14426	ZN01 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1147	8634	\N
14427	ZN01 - A1	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1148	8635	\N
14428	ZN01 - A1	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	POLJ	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1149	8636	\N
14429	ZNBS - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POLJ	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01: e -račun	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1150	8637	\N
14430	ZNBS - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1151	8638	\N
14431	ZNBS - A1	EDOC_COCKPIT	Slanje e- fakture	Pošalji e- fakturu	POLJ	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01: e -račun	Pošalji e- fakturu	Slanje e- fakture	1152	8639	\N
14432	ZNBS - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POLJ	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1153	8640	\N
14706	TEST	ZEDEL	RIP	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	RIP	1427	8914	\N
14433	ZNBS - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1154	8641	\N
14434	ZNBS - A1	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1155	8642	\N
14435	ZNBS - A1	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	POLJ	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1156	8643	\N
14436	ZN03 - A1	VA01	Nalog za usluge / Service order	Kreiraj nalog za usluge/Create service order	POLJ	Sales Distribution/SD	\N	Faktura usluge ZF03 - storno: e -račun	Kreiraj nalog za usluge/Create service order	Nalog za usluge / Service order	1157	8644	\N
14437	ZN03 - A1	VF03	Faktura usluge/Service invoice	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Faktura usluge ZF03 - storno: e -račun	Kreiraj fakturu/Create an invoice	Faktura usluge/Service invoice	1158	8645	\N
14438	ZN03 - A1	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Faktura usluge ZF03 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1159	8646	\N
14439	ZN03 - A1	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	POLJ	Sales Distribution/SD	\N	Faktura usluge ZF03 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1160	8647	\N
14440	ZN04 - A1, usluge	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POLJ	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1161	8648	\N
14441	ZN04 - A1, usluge	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1162	8649	\N
14442	ZN04 - A1, usluge	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1163	8650	\N
14443	ZN04 - A1, usluge	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	POLJ	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1164	8651	\N
14444	ZN04 - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POLJ	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1165	8652	\N
14445	ZN04 - A1, proizvodi	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1166	8653	\N
14446	ZN04 - A1, proizvodi	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1167	8654	\N
14447	ZN04 - A1, proizvodi	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	POLJ	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1168	8655	\N
14448	ZN05 - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POLJ	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1169	8656	\N
14449	ZN05 - A1, proizvodi	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1170	8657	\N
14450	ZN05 - A1, proizvodi	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1171	8658	\N
14451	ZN05 - A1, proizvodi	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	POLJ	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1172	8659	\N
14452	ZN06 - A1, usluge	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POLJ	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1173	8660	\N
14453	ZN06 - A1, usluge	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1174	8661	\N
14454	ZN06 - A1, usluge	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1175	8662	\N
14455	ZN06 - A1, usluge	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	POLJ	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1176	8663	\N
14456	ZN06 - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POLJ	Sales Distribution/SD	\N	Financijsko terećenje ZF05: e-račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1177	8664	\N
14457	ZN06 - A1, proizvodi	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Financijsko terećenje ZF05: e-račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1178	8665	\N
14458	ZN06 - A1, proizvodi	EDOC_COCKPIT	Slanje e- fakture	Pošalji e- fakturu	POLJ	Sales Distribution/SD	\N	Financijsko terećenje ZF05: e-račun	Pošalji e- fakturu	Slanje e- fakture	1179	8666	\N
14459	ZN06 - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POLJ	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1180	8667	\N
14488	ZN04 - A1, usluge	EDOC_COCKPIT	Slanje e- fakture	Pošalji e- fakturu	INTS	Sales Distribution/SD	\N	Financijsko odobrenje ZF04: e-račun	Pošalji e- fakturu	Slanje e- fakture	1209	8696	\N
14460	ZN06 - A1, proizvodi	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1181	8668	\N
14461	ZN06 - A1, proizvodi	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1182	8669	\N
14462	ZN06 - A1, proizvodi	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	POLJ	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1183	8670	\N
14463	ZN07 - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POLJ	Sales Distribution/SD	\N	Financijsko terećenje ZF05: e-račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1184	8671	\N
14464	ZN07 - A1, proizvodi	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Financijsko terećenje ZF05: e-račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1185	8672	\N
14465	ZN07 - A1, proizvodi	EDOC_COCKPIT	Slanje e- fakture	Pošalji e- fakturu	POLJ	Sales Distribution/SD	\N	Financijsko terećenje ZF05: e-račun	Pošalji e- fakturu	Slanje e- fakture	1186	8673	\N
14466	ZN07 - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	POLJ	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1187	8674	\N
14467	ZN07 - A1, proizvodi	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1188	8675	\N
14468	ZN07 - A1, proizvodi	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1189	8676	\N
14469	ZN07 - A1, proizvodi	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	POLJ	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1190	8677	\N
14470	ZN08 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POLJ	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08: e-račun	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1191	8678	\N
14471	ZN08 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	POLJ	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08: e-račun	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	1192	8679	\N
14472	ZN08 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08: e-račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1193	8680	\N
14473	ZN08 - A1	EDOC_COCKPIT	Slanje e- fakture	Pošalji e- fakturu	POLJ	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08: e-račun	Pošalji e- fakturu	Slanje e- fakture	1194	8681	\N
14474	ZN08 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	POLJ	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08 - strorno: e-račun	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1195	8682	\N
14475	ZN08 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	POLJ	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08 - strorno: e-račun	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	1196	8683	\N
14476	ZN08 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08 - strorno: e-račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1197	8684	\N
14477	ZN08 - A1	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	POLJ	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08 - strorno: e-račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1198	8685	\N
14478	ZN08 - A1	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	POLJ	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08 - strorno: e-račun	Pošalji storno e- fakture	Slanje storno e- fakture	1199	8686	\N
14479	ZN03 - A1	VA01	Nalog za usluge / Service order	Kreiraj nalog za usluge/Create service order	INTS	Sales Distribution/SD	\N	Faktura usluge ZF03: e -račun	Kreiraj nalog za usluge/Create service order	Nalog za usluge / Service order	1200	8687	\N
14480	ZN03 - A1	VF01	Faktura usluge/Service invoice	Kreiraj fakturu/Create an invoice	INTS	Sales Distribution/SD	\N	Faktura usluge ZF03: e -račun	Kreiraj fakturu/Create an invoice	Faktura usluge/Service invoice	1201	8688	\N
14481	ZN03 - A1	EDOC_COCKPIT	Slanje e- fakture	Pošalji e- fakturu	INTS	Sales Distribution/SD	\N	Faktura usluge ZF03: e -račun	Pošalji e- fakturu	Slanje e- fakture	1202	8689	\N
14482	ZN03 - A1	VA01	Nalog za usluge / Service order	Kreiraj nalog za usluge/Create service order	INTS	Sales Distribution/SD	\N	Faktura usluge ZF03 - storno: e -račun	Kreiraj nalog za usluge/Create service order	Nalog za usluge / Service order	1203	8690	\N
14483	ZN03 - A1	VF01	Faktura usluge/Service invoice	Kreiraj fakturu/Create an invoice	INTS	Sales Distribution/SD	\N	Faktura usluge ZF03 - storno: e -račun	Kreiraj fakturu/Create an invoice	Faktura usluge/Service invoice	1204	8691	\N
14484	ZN03 - A1	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	INTS	Sales Distribution/SD	\N	Faktura usluge ZF03 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1205	8692	\N
14485	ZN03 - A1	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	INTS	Sales Distribution/SD	\N	Faktura usluge ZF03 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1206	8693	\N
14486	ZN04 - A1, usluge	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	INTS	Sales Distribution/SD	\N	Financijsko odobrenje ZF04: e-račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1207	8694	\N
14487	ZN04 - A1, usluge	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	INTS	Sales Distribution/SD	\N	Financijsko odobrenje ZF04: e-račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1208	8695	\N
14489	ZN04 - A1, usluge	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	INTS	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1210	8697	\N
14490	ZN04 - A1, usluge	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	INTS	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1211	8698	\N
14491	ZN04 - A1, usluge	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	INTS	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1212	8699	\N
14492	ZN04 - A1, usluge	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	INTS	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1213	8700	\N
14493	ZN03 - A1	VA01	Nalog za usluge / Service order	Kreiraj nalog za usluge/Create service order	ZIMP	Sales Distribution/SD	\N	Faktura usluge ZF03: e -račun	Kreiraj nalog za usluge/Create service order	Nalog za usluge / Service order	1214	8701	\N
14494	ZN03 - A1	VF03	Faktura usluge/Service invoice	Kreiraj fakturu/Create an invoice	ZIMP	Sales Distribution/SD	\N	Faktura usluge ZF03: e -račun	Kreiraj fakturu/Create an invoice	Faktura usluge/Service invoice	1215	8702	\N
14495	ZN03 - A1	EDOC_COCKPIT	Slanje e- fakture	Pošalji e- fakturu	ZIMP	Sales Distribution/SD	\N	Faktura usluge ZF03: e -račun	Pošalji e- fakturu	Slanje e- fakture	1216	8703	\N
14496	ZN03 - A1	VA01	Nalog za usluge / Service order	Kreiraj nalog za usluge/Create service order	ZIMP	Sales Distribution/SD	\N	Faktura usluge ZF03 - storno: e -račun	Kreiraj nalog za usluge/Create service order	Nalog za usluge / Service order	1217	8704	\N
14497	ZN03 - A1	VF03	Faktura usluge/Service invoice	Kreiraj fakturu/Create an invoice	ZIMP	Sales Distribution/SD	\N	Faktura usluge ZF03 - storno: e -račun	Kreiraj fakturu/Create an invoice	Faktura usluge/Service invoice	1218	8705	\N
14498	ZN03 - A1	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZIMP	Sales Distribution/SD	\N	Faktura usluge ZF03 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1219	8706	\N
14499	ZN03 - A1	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	ZIMP	Sales Distribution/SD	\N	Faktura usluge ZF03 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1220	8707	\N
14500	ZN05 - A1, usluge	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	ZIMP	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1221	8708	\N
14501	ZN05 - A1, usluge	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	ZIMP	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1222	8709	\N
14502	ZN05 - A1, usluge	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZIMP	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1223	8710	\N
14503	ZN05 - A1, usluge	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	ZIMP	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1224	8711	\N
14504	ZN01 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	ZITO	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1225	8712	\N
14505	ZN01 - A1	VL01N	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	ZITO	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Kreiraj isporuku/Create a delivery	Kreiraj isporuku/Create a delivery	1226	8713	\N
14506	ZN01 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	ZITO	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1227	8714	\N
14507	ZN01 - A1	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1228	8715	\N
14508	ZN01 - A1	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	ZITO	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1229	8716	\N
14509	ZNBS - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	ZITO	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1230	8717	\N
14510	ZNBS - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	ZITO	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1231	8718	\N
14511	ZNBS - A1	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1232	8719	\N
14512	ZNBS - A1	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	ZITO	Sales Distribution/SD	\N	Faktura domaća prodaja ZF01 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1233	8720	\N
14513	ZN03 - A1	VF03	Faktura usluge/Service invoice	Kreiraj fakturu/Create an invoice	ZITO	Sales Distribution/SD	\N	Faktura usluge ZF03: e -račun	Kreiraj fakturu/Create an invoice	Faktura usluge/Service invoice	1234	8721	\N
14514	ZN03 - A1	EDOC_COCKPIT	Slanje e- fakture	Pošalji e- fakturu	ZITO	Sales Distribution/SD	\N	Faktura usluge ZF03: e -račun	Pošalji e- fakturu	Slanje e- fakture	1235	8722	\N
14515	ZN03 - A1	VA01	Nalog za usluge / Service order	Kreiraj nalog za usluge/Create service order	ZITO	Sales Distribution/SD	\N	Faktura usluge ZF03 - storno: e -račun	Kreiraj nalog za usluge/Create service order	Nalog za usluge / Service order	1236	8723	\N
14516	ZN03 - A1	VF01	Kreiraj fakturu za usluge/Create invoice for services	Kreiraj fakturu/Create an invoice	ZITO	Sales Distribution/SD	\N	Faktura usluge ZF03 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu za usluge/Create invoice for services	1237	8724	\N
14768	TEST	WB2R_SC	Obračun pogodbe stranke	TEST	ZITO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Obračun pogodbe stranke	1489	8976	\N
14517	ZN03 - A1	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Faktura usluge ZF03 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1238	8725	\N
14518	ZN03 - A1	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	ZITO	Sales Distribution/SD	\N	Faktura usluge ZF03 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1239	8726	\N
14519	ZN04 - A1, usluge	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	ZITO	Sales Distribution/SD	\N	Financijsko odobrenje ZF04: e-račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1240	8727	\N
14520	ZN04 - A1, usluge	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	ZITO	Sales Distribution/SD	\N	Financijsko odobrenje ZF04: e-račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1241	8728	\N
14521	ZN04 - A1, usluge	EDOC_COCKPIT	Slanje e- fakture	Pošalji e- fakturu	ZITO	Sales Distribution/SD	\N	Financijsko odobrenje ZF04: e-račun	Pošalji e- fakturu	Slanje e- fakture	1242	8729	\N
14522	ZN04 - A1, usluge	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	ZITO	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1243	8730	\N
14523	ZN04 - A1, usluge	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	ZITO	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1244	8731	\N
14524	ZN04 - A1, usluge	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1245	8732	\N
14525	ZN04 - A1, usluge	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	ZITO	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1246	8733	\N
14526	ZN04 - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	ZITO	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1247	8734	\N
14527	ZN04 - A1, proizvodi	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	ZITO	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1248	8735	\N
14528	ZN04 - A1, proizvodi	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1249	8736	\N
14529	ZN04 - A1, proizvodi	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	ZITO	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1250	8737	\N
14530	ZN05 - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	ZITO	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1251	8738	\N
14531	ZN05 - A1, proizvodi	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	ZITO	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1252	8739	\N
14532	ZN05 - A1, proizvodi	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1253	8740	\N
14533	ZN05 - A1, proizvodi	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	ZITO	Sales Distribution/SD	\N	Financijsko odobrenje ZF04 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1254	8741	\N
14534	ZN06 - A1, usluge	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	ZITO	Sales Distribution/SD	\N	Financijsko terećenje ZF05: e-račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1255	8742	\N
14535	ZN06 - A1, usluge	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	ZITO	Sales Distribution/SD	\N	Financijsko terećenje ZF05: e-račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1256	8743	\N
14536	ZN06 - A1, usluge	EDOC_COCKPIT	Slanje e- fakture	Pošalji e- fakturu	ZITO	Sales Distribution/SD	\N	Financijsko terećenje ZF05: e-račun	Pošalji e- fakturu	Slanje e- fakture	1257	8744	\N
14537	ZN06 - A1, usluge	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	ZITO	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1258	8745	\N
14538	ZN06 - A1, usluge	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	ZITO	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1259	8746	\N
14539	ZN06 - A1, usluge	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1260	8747	\N
14540	ZN06 - A1, usluge	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	ZITO	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1261	8748	\N
14541	ZN06 - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	ZITO	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1262	8749	\N
14542	ZN06 - A1, proizvodi	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	ZITO	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1263	8750	\N
14543	ZN06 - A1, proizvodi	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1264	8751	\N
14707	TEST	ZEDOC_RESET	Odpre IDOC da se prekliče/ponovno pošlje	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	Odpre IDOC da se prekliče/ponovno pošlje	1428	8915	\N
14544	ZN06 - A1, proizvodi	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	ZITO	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1265	8752	\N
14545	ZN07 - A1, proizvodi	VA01	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	ZITO	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Kreiraj prodajni nalog/Create a sales order	Kreiraj prodajni nalog/Create a sales order	1266	8753	\N
14546	ZN07 - A1, proizvodi	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	ZITO	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1267	8754	\N
14547	ZN07 - A1, proizvodi	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1268	8755	\N
14548	ZN07 - A1, proizvodi	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	ZITO	Sales Distribution/SD	\N	Financijsko terećenje ZF05 - storno: e -račun	Pošalji storno e- fakture	Slanje storno e- fakture	1269	8756	\N
14549	ZN08 - A1	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	ZITO	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08 - strorno: e-račun	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1270	8757	\N
14550	ZN08 - A1	VL01N	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	ZITO	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08 - strorno: e-račun	Kreiraj isporuku povrata/Create a delivery of return	Kreiraj isporuku povrata/Create a delivery of return	1271	8758	\N
14551	ZN08 - A1	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	ZITO	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08 - strorno: e-račun	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1272	8759	\N
14552	ZN08 - A1	VF11	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	ZITO	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08 - strorno: e-račun	Storniraj fakturu /Cancel the invoice	Storniraj fakturu /Cancel the invoice	1273	8760	\N
14553	ZN08 - A1	EDOC_COCKPIT	Slanje storno e- fakture	Pošalji storno e- fakture	ZITO	Sales Distribution/SD	\N	Proces povrata robe od kupca  ZF08 - strorno: e-račun	Pošalji storno e- fakture	Slanje storno e- fakture	1274	8761	\N
14554	ZN02 - AA - Glutamat	VA01	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj prodajni nalog/Create sales order	Kreiraj prodajni nalog/Create sales order	1275	8762	\N
14555	ZN02 - AA - Glutamat	VL01N	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj isporuku /Create a  delivery	Kreiraj isporuku /Create a  delivery	1276	8763	\N
14556	ZN02 - AA - Glutamat	VT01N	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj pošiljku/Create shipment	Kreiraj pošiljku/Create shipment	1277	8764	\N
14557	ZN02 - AA - Glutamat	VT02N	Kreiraj pošiljku/Create shipment	Promjeni pošiljku/Change shipment	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Promjeni pošiljku/Change shipment	Kreiraj pošiljku/Create shipment	1278	8765	\N
14558	ZN02 - AA - Glutamat	VT03N	Kreiraj pošiljku/Create shipment	Prikaži pošiljku/Display Shipment	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Prikaži pošiljku/Display Shipment	Kreiraj pošiljku/Create shipment	1279	8766	\N
14559	ZN02 - AA - Glutamat	VF01	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	PODD	Sales Distribution/SD	\N	Prodaja robe sa zalihe na inozemno tržište / Sale of goods from stock on the foregin market	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/Create an invoice	1280	8767	\N
14560	ZN01	VA01	Nalog za domaću prodaju	Kreiraj prodajni nalog/Create a sales order	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe	Kreiraj prodajni nalog/Create a sales order	Nalog za domaću prodaju	1281	8768	\N
14561	ZN01	VA02	Promjena naloga	Promjeni naloga ako je potrebno	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe	Promjeni naloga ako je potrebno	Promjena naloga	1282	8769	\N
14562	ZN01	VL01N	Isporuka robe	Kreiraj isporuku/Create a delivery	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe	Kreiraj isporuku/Create a delivery	Isporuka robe	1283	8770	\N
14563	ZN01	VL02N	Promjeni isporuku/Chanege delivery document	Promjeni isporuku/Chanege delivery document	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe	Promjeni isporuku/Chanege delivery document	Promjeni isporuku/Chanege delivery document	1284	8771	\N
14564	ZN01	VL06O	Knjiženje dobavnice	Knjiženje dobavnice	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe	Knjiženje dobavnice	Knjiženje dobavnice	1285	8772	\N
14565	ZN01	VLPODL	Potvrda dobavnice	Potvrda dobavnice  (logistika ili kupac)	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe	Potvrda dobavnice  (logistika ili kupac)	Potvrda dobavnice	1286	8773	\N
14566	ZN01	VF04 - ZF01	Kreiranje fakture /Izdavanje više računa odjednom	Kreiraj fakturu /Izdavanje više računa odjednom	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe	Kreiraj fakturu /Izdavanje više računa odjednom	Kreiranje fakture /Izdavanje više računa odjednom	1287	8774	\N
14567	ZN01	VFX3  -  ZF01	Provjera jesu li svi dokumenti proknjiženi	Provjeri jesu li svi dokumenti proknjiženi	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe	Provjeri jesu li svi dokumenti proknjiženi	Provjera jesu li svi dokumenti proknjiženi	1288	8775	\N
14568	ZN01	EDOC_COCKPIT   - ZF01	Izradimo XML-a	Izradimo XML za fakturu koja će ići na Business Connect	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe	Izradimo XML za fakturu koja će ići na Business Connect	Izradimo XML-a	1289	8776	\N
14569	ZN01	BUSINESS CONECT  -  ZF01	Slanje fakture	Slanje računa kupcu	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe	Slanje računa kupcu	Slanje fakture	1290	8777	\N
14570	ZN01	VF01	Faktur.između poduz.	Kreiraj fakturu između poduzeća - IV	ZITO	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe	Kreiraj fakturu između poduzeća - IV	Faktur.između poduz.	1291	8778	\N
14708	TEST	ZFAKT	transakcija ZFAKT - bruto in neto vrednost na računu	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	transakcija ZFAKT - bruto in neto vrednost na računu	1429	8916	\N
14571	ZN01	VFX3	Provjera jesu li svi dokumenti proknjiženi	Provjeri jesu li svi dokumenti proknjiženi - IV	ZITO	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe	Provjeri jesu li svi dokumenti proknjiženi - IV	Provjera jesu li svi dokumenti proknjiženi	1292	8779	\N
14572	ZN01	EDOC_COCKPIT	Izradimo XML-a	Izradimo XML za fakturu koja će ići na Business Connect - IV	ZITO	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe	Izradimo XML za fakturu koja će ići na Business Connect - IV	Izradimo XML-a	1293	8780	\N
14573	ZN01	BUSINESS CONECT	slanje fakture	šaljemo račun na knjiženje za  Podravka Slovenija - IV	ZITO	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe	šaljemo račun na knjiženje za  Podravka Slovenija - IV	slanje fakture	1294	8781	\N
14574	ZN01	WE02	prikaz IDOC-a	prikaz IDOC-a - IF	ZITO	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe	prikaz IDOC-a - IF	prikaz IDOC-a	1295	8782	\N
14575	ZN01	FB03	Interna obav.odobr.	Interna obav.odobr. - IF	ZITO	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe	Interna obav.odobr. - IF	Interna obav.odobr.	1296	8783	\N
14576	ZN01	BD87	obrada dokumenta s greškom	obrada dokumenta s greškom - IF	ZITO	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe	obrada dokumenta s greškom - IF	obrada dokumenta s greškom	1297	8784	\N
14577	ZN01	EDOC_COCKPIT	otvorite poslani račun - promijena statusa u "Otkazano"	otvorite poslani račun - promijenite status u "Otkazano" - IV	ZITO	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	otvorite poslani račun - promijenite status u "Otkazano" - IV	otvorite poslani račun - promijena statusa u "Otkazano"	1298	8785	\N
14578	ZN01	ZEDOC_RESET	otvorite poslani račun - promijena statusa u "Otkazano"	otvorite poslani račun - promijenite status u "Otkazano" - IV	ZITO	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	otvorite poslani račun - promijenite status u "Otkazano" - IV	otvorite poslani račun - promijena statusa u "Otkazano"	1299	8786	\N
14579	ZN01	VF11	Storno fakture	Storniraj fakturu /Cancel the invoice - IVS	ZITO	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	Storniraj fakturu /Cancel the invoice - IVS	Storno fakture	1300	8787	\N
14580	ZN01	VFX3	Provjera jesu li svi dokumenti proknjiženi	Provjeri jesu li svi dokumenti proknjiženi - IVS	ZITO	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	Provjeri jesu li svi dokumenti proknjiženi - IVS	Provjera jesu li svi dokumenti proknjiženi	1301	8788	\N
14581	ZN01	EDOC_COCKPIT	Izradimo XML-a	Izradimo XML za fakturu koja će ići na Business Connect - IVS	ZITO	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	Izradimo XML za fakturu koja će ići na Business Connect - IVS	Izradimo XML-a	1302	8789	\N
14582	ZN01	BUSINESS CONECT	fakturu šaljemo na knjiženje	fakturu šaljemo na knjiženje - IVS	ZITO	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	fakturu šaljemo na knjiženje - IVS	fakturu šaljemo na knjiženje	1303	8790	\N
14583	ZN01	EDOC_COCKPIT - ZF01	otvorite poslani račun - promijena statusa u "Otkazano"	otvorite poslani račun - promijenite status u "Otkazano"	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	otvorite poslani račun - promijenite status u "Otkazano"	otvorite poslani račun - promijena statusa u "Otkazano"	1304	8791	\N
14584	ZN01	ZEDOC_RESET  - ZF01	otvorite poslani račun - promijena statusa u "Otkazano"	otvorite poslani račun - promijenite status u "Otkazano"	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	otvorite poslani račun - promijenite status u "Otkazano"	otvorite poslani račun - promijena statusa u "Otkazano"	1305	8792	\N
14585	ZN01	VF11  - ZS01	Storno računa do kupca	Storno računa do kupca	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	Storno računa do kupca	Storno računa do kupca	1306	8793	\N
14586	ZN01	VFX3 - ZS01	Provjera jesu li svi dokumenti proknjiženi	Provjeri jesu li svi dokumenti proknjiženi	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	Provjeri jesu li svi dokumenti proknjiženi	Provjera jesu li svi dokumenti proknjiženi	1307	8794	\N
14587	ZN01	EDOC_COCKPIT  - ZS01	Poslati dokument o otkazivanju na Business Connect	Poslati dokument o otkazivanju na Business Connect	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	Poslati dokument o otkazivanju na Business Connect	Poslati dokument o otkazivanju na Business Connect	1308	8795	\N
14588	ZN01	VL09	Razknjiži dobavnico	Razknjiži dobavnico	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	Razknjiži dobavnico	Razknjiži dobavnico	1309	8796	\N
14589	ZN01	VL02N	Promjeni isporuku/Chanege delivery document	Promjeni isporuku/Chanege delivery document	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	Promjeni isporuku/Chanege delivery document	Promjeni isporuku/Chanege delivery document	1310	8797	\N
14590	ZN01	VL06O	Knjiženje dobavnice	Knjiženje dobavnice	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	Knjiženje dobavnice	Knjiženje dobavnice	1311	8798	\N
14591	ZN01	VLPODL	Potvrda dobavnice	Potvrda dobavnice  (logistika ili kupac)	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	Potvrda dobavnice  (logistika ili kupac)	Potvrda dobavnice	1312	8799	\N
14592	ZN01	VF01	Kreiraj fakturu	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	Kreiraj fakturu/Create an invoice	Kreiraj fakturu	1313	8800	\N
14593	ZN01	VFX3	Provjera jesu li svi dokumenti proknjiženi	Provjeri jesu li svi dokumenti proknjiženi	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	Provjeri jesu li svi dokumenti proknjiženi	Provjera jesu li svi dokumenti proknjiženi	1314	8801	\N
14594	ZN01	EDOC_COCKPIT   ZF01	Izradimo XML-a	Izradimo XML za fakturu koja će ići na Business Connect	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	Izradimo XML za fakturu koja će ići na Business Connect	Izradimo XML-a	1315	8802	\N
14595	ZN01	BUSINESS CONECT   ZF01	Slanje fakture	Slanje računa kupcu	POLJ	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	Slanje računa kupcu	Slanje fakture	1316	8803	\N
14596	ZN01	VF01	Faktur.između poduz.	Kreiraj fakturu između poduzeća - IV	ZITO	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	Kreiraj fakturu između poduzeća - IV	Faktur.između poduz.	1317	8804	\N
14597	ZN01	VFX3	Provjera jesu li svi dokumenti proknjiženi	Provjeri jesu li svi dokumenti proknjiženi - IV	ZITO	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	Provjeri jesu li svi dokumenti proknjiženi - IV	Provjera jesu li svi dokumenti proknjiženi	1318	8805	\N
14598	ZN01	EDOC_COCKPIT	Izradimo XML-a	Izradimo XML za fakturu koja će ići na Business Connect - IV	ZITO	Sales Distribution/SD	\N	Intercompany 1 - prodaja robe: storno	Izradimo XML za fakturu koja će ići na Business Connect - IV	Izradimo XML-a	1319	8806	\N
14709	TEST	ZINFUPD	TEST	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1430	8917	\N
14603	ZN08	VA01	Nalog povr.neog.zal.	Kreiraj prodajni nalog/Create a sales order	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.	Kreiraj prodajni nalog/Create a sales order	Nalog povr.neog.zal.	1324	8811	\N
14604	ZN08	VA02	Promjena naloga povr.neog.zal.	Promjeni naloga ako je potrebno	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.	Promjeni naloga ako je potrebno	Promjena naloga povr.neog.zal.	1325	8812	\N
14605	ZN08	VL01N	Isporuka povrata robe	Kreiraj isporuku/Create a delivery	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.	Kreiraj isporuku/Create a delivery	Isporuka povrata robe	1326	8813	\N
14606	ZN08	VL02N	Promjeni isporuku/Chanege delivery document	Promjeni isporuku/Chanege delivery document	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.	Promjeni isporuku/Chanege delivery document	Promjeni isporuku/Chanege delivery document	1327	8814	\N
14607	ZN08	VL06O	Knjiženje dobavnice	Knjiženje dobavnice	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.	Knjiženje dobavnice	Knjiženje dobavnice	1328	8815	\N
14608	ZN08	VF01	Kreiraj fakturu / odobrenje	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.	Kreiraj fakturu/Create an invoice	Kreiraj fakturu / odobrenje	1329	8816	\N
14609	ZN08	VFX3	Provjera jesu li svi dokumenti proknjiženi	Provjeri jesu li svi dokumenti proknjiženi	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.	Provjeri jesu li svi dokumenti proknjiženi	Provjera jesu li svi dokumenti proknjiženi	1330	8817	\N
14610	ZN08	EDOC_COCKPIT	Izradimo XML-a	Izradimo XML za fakturu koja će ići na Business Connect	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.	Izradimo XML za fakturu koja će ići na Business Connect	Izradimo XML-a	1331	8818	\N
14611	ZN08	BUSINESS CONECT	Slanje fakture	Slanje računa kupcu	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.	Slanje računa kupcu	Slanje fakture	1332	8819	\N
14612	ZN08	VF01	Faktur.između poduz.	Kreiraj fakturu između poduzeća - IG	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.	Kreiraj fakturu između poduzeća - IG	Faktur.između poduz.	1333	8820	\N
14613	ZN08	VFX3	Provjera jesu li svi dokumenti proknjiženi	Provjeri jesu li svi dokumenti proknjiženi - IG	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.	Provjeri jesu li svi dokumenti proknjiženi - IG	Provjera jesu li svi dokumenti proknjiženi	1334	8821	\N
14614	ZN08	EDOC_COCKPIT	Izradimo XML-a	Izradimo XML za fakturu koja će ići na Business Connect - IG	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.	Izradimo XML za fakturu koja će ići na Business Connect - IG	Izradimo XML-a	1335	8822	\N
14615	ZN08	BUSINESS CONECT	Slanje fakture na kniženje	Slanje fakture na kniženje - IG	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.	Slanje fakture na kniženje - IG	Slanje fakture na kniženje	1336	8823	\N
14616	ZN08	WE02	prikaz IDOC-a	prikaz IDOC-a - IO	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.	prikaz IDOC-a - IO	prikaz IDOC-a	1337	8824	\N
14617	ZN08	FB03	Interna obav.odobr.	Interna obav.odobr. - IO	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.	Interna obav.odobr. - IO	Interna obav.odobr.	1338	8825	\N
14618	ZN08	BD87	obrada dokumenta s greškom	obrada dokumenta s greškom - IO	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.	obrada dokumenta s greškom - IO	obrada dokumenta s greškom	1339	8826	\N
14619	ZN08	EDOC_COCKPIT	otvorite poslani račun - promijena statusa u "Otkazano"	otvorite poslani račun - promijenite status u "Otkazano" - IG	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	otvorite poslani račun - promijenite status u "Otkazano" - IG	otvorite poslani račun - promijena statusa u "Otkazano"	1340	8827	\N
14620	ZN08	ZEDOC_RESET	otvorite poslani račun - promijena statusa u "Otkazano"	otvorite poslani račun - promijenite status u "Otkazano" - IG	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	otvorite poslani račun - promijenite status u "Otkazano" - IG	otvorite poslani račun - promijena statusa u "Otkazano"	1341	8828	\N
14621	ZN08	VF11	Storno fakture	Storniraj fakturu /Cancel the invoice - IGS	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Storniraj fakturu /Cancel the invoice - IGS	Storno fakture	1342	8829	\N
14622	ZN08	VFX3	Provjera jesu li svi dokumenti proknjiženi	Provjeri jesu li svi dokumenti proknjiženi - IGS	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Provjeri jesu li svi dokumenti proknjiženi - IGS	Provjera jesu li svi dokumenti proknjiženi	1343	8830	\N
14623	ZN08	EDOC_COCKPIT	Izradimo XML-a	Izradimo XML za fakturu koja će ići na Business Connect - IGS	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Izradimo XML za fakturu koja će ići na Business Connect - IGS	Izradimo XML-a	1344	8831	\N
14624	ZN08	BUSINESS CONECT	otvorite poslani račun - promijena statusa u "Otkazano"	Slanje fakture na kniženje - IGS	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Slanje fakture na kniženje - IGS	otvorite poslani račun - promijena statusa u "Otkazano"	1345	8832	\N
14625	ZN08	BD87	Obrada dokukenata s greškom	Obrada dokukenata s greškom - IO	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Obrada dokukenata s greškom - IO	Obrada dokukenata s greškom	1346	8833	\N
14626	ZN08	WE02	prikaz IDOC-a	prikaz IDOC-a - IO	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	prikaz IDOC-a - IO	prikaz IDOC-a	1347	8834	\N
14627	ZN08	FB03	Interna obav.odobr.	Interna obav.odobr. - IO	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Interna obav.odobr. - IO	Interna obav.odobr.	1348	8835	\N
14628	ZN08	EDOC_COCKPIT	Promejna statusa	Otvori poslanu fakturu i promjeni status u Otkazano	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Otvori poslanu fakturu i promjeni status u Otkazano	Promejna statusa	1349	8836	\N
14629	ZN08	ZEDOC_RESET	Promejna statusa	Otvori poslanu fakturu i promjeni status u Otkazano	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Otvori poslanu fakturu i promjeni status u Otkazano	Promejna statusa	1350	8837	\N
14630	ZN08	VF11	Storno fakture	Storno fakture	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Storno fakture	Storno fakture	1351	8838	\N
14631	ZN08	VFX3	Provjera jesu li svi dokumenti proknjiženi	Provjeri jesu li svi dokumenti proknjiženi	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Provjeri jesu li svi dokumenti proknjiženi	Provjera jesu li svi dokumenti proknjiženi	1352	8839	\N
14710	TEST	ZMODIS	Transakcija ukinjena, vendar se še potrebuje zgodovina	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	Transakcija ukinjena, vendar se še potrebuje zgodovina	1431	8918	\N
14632	ZN08	EDOC_COCKPIT	Slanje storno dokuementa u Business Conect	Slanje storno dokuementa u Business Conect	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Slanje storno dokuementa u Business Conect	Slanje storno dokuementa u Business Conect	1353	8840	\N
14633	ZN08	VL09	Stornaj otpremnicu povrata	Stornaj otpremnicu povrata	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Stornaj otpremnicu povrata	Stornaj otpremnicu povrata	1354	8841	\N
14634	ZN08	VL02N	Promjeni isporuku/Chanege delivery document	Promjeni isporuku/Chanege delivery document	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Promjeni isporuku/Chanege delivery document	Promjeni isporuku/Chanege delivery document	1355	8842	\N
14635	ZN08	VL06O	Knjiženje dobavnice	Knjiženje dobavnice	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Knjiženje dobavnice	Knjiženje dobavnice	1356	8843	\N
14636	ZN08	VF01	Kreiraj fakturu/odobrenje	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Kreiraj fakturu/Create an invoice	Kreiraj fakturu/odobrenje	1357	8844	\N
14637	ZN08	VFX3	Provjera jesu li svi dokumenti proknjiženi	Provjera jesu li svi dokumenti proknjiženi	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Provjera jesu li svi dokumenti proknjiženi	Provjera jesu li svi dokumenti proknjiženi	1358	8845	\N
14638	ZN08	EDOC_COCKPIT	Izrada XML-a	Izradimo XML za fakturu koja će ići na Business Connect	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Izradimo XML za fakturu koja će ići na Business Connect	Izrada XML-a	1359	8846	\N
14639	ZN08	BUSINESS CONECT	Slanje fakture	Slanje računa kupcu	POLJ	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Slanje računa kupcu	Slanje fakture	1360	8847	\N
14640	ZN08	VF01	Faktur.između poduz.	Kreiraj fakturu između poduzeća - IG	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Kreiraj fakturu između poduzeća - IG	Faktur.između poduz.	1361	8848	\N
14641	ZN08	VFX3	Provjera jesu li svi dokumenti proknjiženi	Provjeri jesu li svi dokumenti proknjiženi - IG	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Provjeri jesu li svi dokumenti proknjiženi - IG	Provjera jesu li svi dokumenti proknjiženi	1362	8849	\N
14642	ZN08	EDOC_COCKPIT	Izradimo XML-a	Izradimo XML za fakturu koja će ići na Business Connect - IG	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Izradimo XML za fakturu koja će ići na Business Connect - IG	Izradimo XML-a	1363	8850	\N
14643	ZN08	BUSINESS CONECT	slanje fakture	slanje fakture na knjiženje - IG	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	slanje fakture na knjiženje - IG	slanje fakture	1364	8851	\N
14644	ZN08	WE02	prikaz IDOC-a	prikaz IDOC-a - IO	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	prikaz IDOC-a - IO	prikaz IDOC-a	1365	8852	\N
14645	ZN08	FB03	Interna obav.odobr.	Interna obav.odobr. - IO	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	Interna obav.odobr. - IO	Interna obav.odobr.	1366	8853	\N
14646	ZN08	BD87	obrada dokumenta s greškom	obrada dokumenta s greškom - IO	ZITO	Sales Distribution/SD	\N	Intercompany 1 - Nalog povr.neog.zal.  - storno	obrada dokumenta s greškom - IO	obrada dokumenta s greškom	1367	8854	\N
14647	ZN01	VA01	Nalog za domaću prodaju	Kreiraj prodajni nalog/Create a sales order	POLJ	Sales Distribution/SD	\N	Intercompany 2 - prodaja robe	Kreiraj prodajni nalog/Create a sales order	Nalog za domaću prodaju	1368	8855	\N
14648	ZN01	VA02	Promjena naloga	Promjeni naloga ako je potrebno	POLJ	Sales Distribution/SD	\N	Intercompany 2 - prodaja robe	Promjeni naloga ako je potrebno	Promjena naloga	1369	8856	\N
14649	ZN01	VL01N	Isporuka robe	Kreiraj isporuku/Create a delivery	PODD	Sales Distribution/SD	\N	Intercompany 2 - prodaja robe	Kreiraj isporuku/Create a delivery	Isporuka robe	1370	8857	\N
14650	ZN01	VL02N	Promjeni isporuku/Chanege delivery document	Promjeni isporuku/Chanege delivery document	PODD	Sales Distribution/SD	\N	Intercompany 2 - prodaja robe	Promjeni isporuku/Chanege delivery document	Promjeni isporuku/Chanege delivery document	1371	8858	\N
14651	ZN01	VL06O	Knjiženje dobavnice	Knjiženje dobavnice	PODD	Sales Distribution/SD	\N	Intercompany 2 - prodaja robe	Knjiženje dobavnice	Knjiženje dobavnice	1372	8859	\N
14652	ZN01	VLPODL	Potvrda dobavnice	Potvrda dobavnice  (logistika ili kupac)	PODD	Sales Distribution/SD	\N	Intercompany 2 - prodaja robe	Potvrda dobavnice  (logistika ili kupac)	Potvrda dobavnice	1373	8860	\N
14653	ZN01	VF01	Kreiranje fakture	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Intercompany 2 - prodaja robe	Kreiraj fakturu/Create an invoice	Kreiranje fakture	1374	8861	\N
14654	ZN01	VFX3	Provjera jesu li svi dokumenti proknjiženi	Provjeri jesu li svi dokumenti proknjiženi	POLJ	Sales Distribution/SD	\N	Intercompany 2 - prodaja robe	Provjeri jesu li svi dokumenti proknjiženi	Provjera jesu li svi dokumenti proknjiženi	1375	8862	\N
14655	ZN01	EDOC_COCKPIT	Izradimo XML-a	Izradimo XML za fakturu koja će ići na Business Connect	POLJ	Sales Distribution/SD	\N	Intercompany 2 - prodaja robe	Izradimo XML za fakturu koja će ići na Business Connect	Izradimo XML-a	1376	8863	\N
14656	ZN01	BUSINESS CONECT	Slanje fakture	Slanje računa kupcu	POLJ	Sales Distribution/SD	\N	Intercompany 2 - prodaja robe	Slanje računa kupcu	Slanje fakture	1377	8864	\N
14657	ZN01	VF01	Faktur.između poduz.	Kreiraj fakturu između poduzeća - IV	PODD	Sales Distribution/SD	\N	Intercompany 2 - prodaja robe	Kreiraj fakturu između poduzeća - IV	Faktur.između poduz.	1378	8865	\N
14658	ZN01	VFX3	Provjera jesu li svi dokumenti proknjiženi	Provjeri jesu li svi dokumenti proknjiženi - IV	PODD	Sales Distribution/SD	\N	Intercompany 2 - prodaja robe	Provjeri jesu li svi dokumenti proknjiženi - IV	Provjera jesu li svi dokumenti proknjiženi	1379	8866	\N
14659	ZN01	WE02	prikaz IDOC-a	prikaz IDOC-a - IV	POLJ	Sales Distribution/SD	\N	Intercompany 2 - prodaja robe	prikaz IDOC-a - IV	prikaz IDOC-a	1380	8867	\N
14660	ZN01	FB03	Ulazni račun	Interna obav.odobr. - IF	POLJ	Sales Distribution/SD	\N	Intercompany 2 - prodaja robe	Interna obav.odobr. - IF	Ulazni račun	1381	8868	\N
14661	ZN01	BD87	obrada dokumenta s greškom	obrada dokumenta s greškom - IF	PODD	Sales Distribution/SD	\N	Intercompany 2 - prodaja robe	obrada dokumenta s greškom - IF	obrada dokumenta s greškom	1382	8869	\N
14662	ZN08	VA01	Nalog za povrat robe	Kreiraj prodajni nalog/Create a sales order	POLJ	Sales Distribution/SD	\N	Intercompany 2 - Nalog povr.neog.zal.	Kreiraj prodajni nalog/Create a sales order	Nalog za povrat robe	1383	8870	\N
14711	TEST	ZNEISP	TEST	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1432	8919	\N
14664	ZN08	VL01N	Isporuka povrsts robe	Kreiraj isporuku/Create a delivery	PODD	Sales Distribution/SD	\N	Intercompany 2 - Nalog povr.neog.zal.	Kreiraj isporuku/Create a delivery	Isporuka povrsts robe	1385	8872	\N
14665	ZN08	VL02N	Promjeni isporuku/Chanege delivery document	Promjeni isporuku/Chanege delivery document	PODD	Sales Distribution/SD	\N	Intercompany 2 - Nalog povr.neog.zal.	Promjeni isporuku/Chanege delivery document	Promjeni isporuku/Chanege delivery document	1386	8873	\N
14666	ZN08	VL06O	Knjiženje isporuke povrata	Knjiženje isporuke povrata	PODD	Sales Distribution/SD	\N	Intercompany 2 - Nalog povr.neog.zal.	Knjiženje isporuke povrata	Knjiženje isporuke povrata	1387	8874	\N
14667	ZN08	VF01	Odobr.pov.neog.zal.	Kreiraj fakturu/Create an invoice	POLJ	Sales Distribution/SD	\N	Intercompany 2 - Nalog povr.neog.zal.	Kreiraj fakturu/Create an invoice	Odobr.pov.neog.zal.	1388	8875	\N
14668	ZN08	VFX3	Provjera jesu li svi dokumenti proknjiženi	Provjeri jesu li svi dokumenti proknjiženi	POLJ	Sales Distribution/SD	\N	Intercompany 2 - Nalog povr.neog.zal.	Provjeri jesu li svi dokumenti proknjiženi	Provjera jesu li svi dokumenti proknjiženi	1389	8876	\N
14669	ZN08	EDOC_COCKPIT	Izradimo XML-a	Izradimo XML za fakturu koja će ići na Business Connect	POLJ	Sales Distribution/SD	\N	Intercompany 2 - Nalog povr.neog.zal.	Izradimo XML za fakturu koja će ići na Business Connect	Izradimo XML-a	1390	8877	\N
14670	ZN08	BUSINESS CONECT	Slanje fakture	Slanje računa kupcu	POLJ	Sales Distribution/SD	\N	Intercompany 2 - Nalog povr.neog.zal.	Slanje računa kupcu	Slanje fakture	1391	8878	\N
14671	ZN08	VF01	Faktur.između poduz.	Kreiraj fakturu između poduzeća - IG	PODD	Sales Distribution/SD	\N	Intercompany 2 - Nalog povr.neog.zal.	Kreiraj fakturu između poduzeća - IG	Faktur.između poduz.	1392	8879	\N
14672	ZN08	VFX3	Provjera jesu li svi dokumenti proknjiženi	Provjeri jesu li svi dokumenti proknjiženi - IG	PODD	Sales Distribution/SD	\N	Intercompany 2 - Nalog povr.neog.zal.	Provjeri jesu li svi dokumenti proknjiženi - IG	Provjera jesu li svi dokumenti proknjiženi	1393	8880	\N
14673	ZN08	WE02	prikaz IDOC-a	prikaz IDOC-a - IO	POLJ	Sales Distribution/SD	\N	Intercompany 2 - Nalog povr.neog.zal.	prikaz IDOC-a - IO	prikaz IDOC-a	1394	8881	\N
14674	ZN08	FB03	Interna obav.odobr.	Interna obav.odobr. - IO	POLJ	Sales Distribution/SD	\N	Intercompany 2 - Nalog povr.neog.zal.	Interna obav.odobr. - IO	Interna obav.odobr.	1395	8882	\N
14675	ZN08	BD87	obrada dokumenta s greškom	obrada dokumenta s greškom - IO	PODD	Sales Distribution/SD	\N	Intercompany 2 - Nalog povr.neog.zal.	obrada dokumenta s greškom - IO	obrada dokumenta s greškom	1396	8883	\N
14676	TEST	ZNEISP	Naručeno isporučeno fakturirano	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Naručeno isporučeno fakturirano	1397	8884	\N
14677	TEST	ZPDF	Creating PDF file	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Creating PDF file	1398	8885	\N
14678	TEST	ZVF04	Lista dospjeća za fakturiranje	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Lista dospjeća za fakturiranje	1399	8886	\N
14679	TEST	ZAHN	Nalog po upitu	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Nalog po upitu	1400	8887	\N
14680	TEST	ZBA0	Izlaz iz prodajnih naloga	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Izlaz iz prodajnih naloga	1401	8888	\N
14681	TEST	ZDELPICK	Kopiranje podataka za izuzimanje	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Kopiranje podataka za izuzimanje	1402	8889	\N
14682	TEST	ZDESORTP	Potencijalna desortiranost na dan	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Potencijalna desortiranost na dan	1403	8890	\N
14683	TEST	ZDMS	DMS: izvoz slika	TEST	PODD	Sales Distribution/SD	\N	z-transakcije	TEST	DMS: izvoz slika	1404	8891	\N
14684	TEST	ZOKRR	Sustav okružnica	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Sustav okružnica	1405	8892	\N
14685	TEST	ZPAR2	Partnerske funkcije kupca	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Partnerske funkcije kupca	1406	8893	\N
14686	TEST	ZPICK	Lista izuzimanja	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Lista izuzimanja	1407	8894	\N
14687	TEST	ZPUTMI	Transakcija za unos u tab. ZPUTMI	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Transakcija za unos u tab. ZPUTMI	1408	8895	\N
14688	TEST	ZRAZLOG	Zatvaranje SD naloga s razlogom od.	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Zatvaranje SD naloga s razlogom od.	1409	8896	\N
14689	TEST	ZTEZ	Podaci o eventualnoj isporuci	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Podaci o eventualnoj isporuci	1410	8897	\N
14690	TEST	ZUVN	Uvjeti iz prodajnog naloga	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Uvjeti iz prodajnog naloga	1411	8898	\N
14691	TEST	ZVOZACI	Dodatni podaci o vozačima	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Dodatni podaci o vozačima	1412	8899	\N
14692	TEST	ZSTORNO	Masovno otkazivanje fakt.dokumenata	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Masovno otkazivanje fakt.dokumenata	1413	8900	\N
14693	TEST	ZSD	Z transakcije	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Z transakcije	1414	8901	\N
14694	TEST	ZTIME1	Vremena kreiranja prodajnih dokumenata	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Vremena kreiranja prodajnih dokumenata	1415	8902	\N
14695	TEST	ZUGOVOR	Lista ugovora kupaca	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Lista ugovora kupaca	1416	8903	\N
14696	TEST	ZKPD	Unos, održavanje i prikaz KPD-a	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Unos, održavanje i prikaz KPD-a	1417	8904	\N
14697	TEST	ZODO	Pregled sporazuma o rabatu	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Pregled sporazuma o rabatu	1418	8905	\N
14698	TEST	ZGDK	Promjena grupe dodjele konta	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Promjena grupe dodjele konta	1419	8906	\N
14699	TEST	ZTRD	Sustav okružnica	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	Sustav okružnica	1420	8907	\N
14700	TEST	ZCOCKPIT_F20	COCKPIT F20	TEST	PODD	Sales Distribution/SD	\N	Z-transakcije	TEST	COCKPIT F20	1421	8908	\N
14701	TEST	ZEDOC_RESET	Odpre IDOC da se prekliče/ponovno pošlje	TEST	INTS	Sales Distribution/SD	\N	Z-transakcije	TEST	Odpre IDOC da se prekliče/ponovno pošlje	1422	8909	\N
14702	TEST	ZUVF	TEST	TEST	INTS	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1423	8910	\N
14703	TEST	ZB2B_ZZORD	TEST	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1424	8911	\N
14704	TEST	ZCJENIK	Transakcija ZCJENIK - pregled vseh vrst pogojev (ZPRS, ZCDS, ZSOS, ZSUP, ZTRM,..)	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	Transakcija ZCJENIK - pregled vseh vrst pogojev (ZPRS, ZCDS, ZSOS, ZSUP, ZTRM,..)	1425	8912	\N
14715	TEST	ZPDF	Tiskanje iz DUM - tiskanje PDF, shranjevanje PDF	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	Tiskanje iz DUM - tiskanje PDF, shranjevanje PDF	1436	8923	\N
14716	TEST	ZPNK	TEST	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1437	8924	\N
14717	TEST	ZPOD	TEST	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1438	8925	\N
14718	TEST	ZRECIDOC	TEST	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1439	8926	\N
14719	TEST	ZSD	TEST	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1440	8927	\N
14720	TEST	ZSTORNO	Skupinski storno dokumentov	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	Skupinski storno dokumentov	1441	8928	\N
14721	TEST	ZUVF	TEST	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1442	8929	\N
14722	TEST	ZUVN	Transakcija ZUVN - pregled po nalogih	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	Transakcija ZUVN - pregled po nalogih	1443	8930	\N
14723	TEST	ZVF04	Iskanje sprmemeb (če je vse fakturirano)	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	Iskanje sprmemeb (če je vse fakturirano)	1444	8931	\N
14724	TEST	ZVF31	Sporočila iz faktur	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	Sporočila iz faktur	1445	8932	\N
14725	TEST	ZORDERS	TEST	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1446	8933	\N
14726	TEST	ZRECADV	TEST	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1447	8934	\N
14727	TEST	ZREZKUP	TEST	TEST	POLJ	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1448	8935	\N
14728	TEST	ZPDF	Tiskanje iz DUM - tiskanje PDF, shranjevanje PDF	TEST	ZIMP	Sales Distribution/SD	\N	Z-transakcije	TEST	Tiskanje iz DUM - tiskanje PDF, shranjevanje PDF	1449	8936	\N
14729	TEST	ZUVF	TEST	TEST	ZIMP	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1450	8937	\N
14730	TEST	ZEDOC_RESET	Odpre IDOC da se prekliče/ponovno pošlje	TEST	ZIMP	Sales Distribution/SD	\N	Z-transakcije	TEST	Odpre IDOC da se prekliče/ponovno pošlje	1451	8938	\N
14731	TEST	ZB2B_ZZORD	TEST	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1452	8939	\N
14732	TEST	ZCJENIK	Transakcija ZCJENIK - pregled vseh vrst pogojev (ZPRS, ZCDS, ZSOS, ZSUP, ZTRM,..)	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	Transakcija ZCJENIK - pregled vseh vrst pogojev (ZPRS, ZCDS, ZSOS, ZSUP, ZTRM,..)	1453	8940	\N
14733	TEST	ZDELPICK	TEST	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1454	8941	\N
14734	TEST	ZEDEL	RIP	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	RIP	1455	8942	\N
14735	TEST	ZEDOC_RESET	Odpre IDOC da se prekliče/ponovno pošlje	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	Odpre IDOC da se prekliče/ponovno pošlje	1456	8943	\N
14736	TEST	ZINFUPD	TEST	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1457	8944	\N
14737	TEST	ZISK	TEST	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1458	8945	\N
14738	TEST	ZNEISP	TEST	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1459	8946	\N
14739	TEST	ZOBJ	TEST	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1460	8947	\N
14740	TEST	ZODO	transakcija ZODO	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	transakcija ZODO	1461	8948	\N
14741	TEST	ZPDF	Tiskanje iz DUM - tiskanje PDF, shranjevanje PDF	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	Tiskanje iz DUM - tiskanje PDF, shranjevanje PDF	1462	8949	\N
14742	TEST	ZPNK	TEST	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1463	8950	\N
14743	TEST	ZPOD	TEST	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1464	8951	\N
14744	TEST	ZRECIDOC	TEST	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1465	8952	\N
14745	TEST	ZSD	TEST	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1466	8953	\N
14746	TEST	ZSTORNO	Skupinski storno dokumentov	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	Skupinski storno dokumentov	1467	8954	\N
14747	TEST	ZTEZ	Pretvornik materiala/preračunavanje količin	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	Pretvornik materiala/preračunavanje količin	1468	8955	\N
14748	TEST	ZUVF	TEST	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1469	8956	\N
14749	TEST	ZUVN	Transakcija ZUVN - pregled po nalogih	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	Transakcija ZUVN - pregled po nalogih	1470	8957	\N
14750	TEST	ZVF04	Iskanje sprmemeb (če je vse fakturirano)	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	Iskanje sprmemeb (če je vse fakturirano)	1471	8958	\N
14751	TEST	ZVF31	Sporočila iz faktur	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	Sporočila iz faktur	1472	8959	\N
14752	TEST	ZISPROM	TEST	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1473	8960	\N
14753	TEST	ZORDERS	TEST	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1474	8961	\N
14754	TEST	ZRECADV	TEST	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1475	8962	\N
14755	TEST	ZREZKUP	TEST	TEST	ZITO	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1476	8963	\N
14756	TEST	WCOCO	Obdelava pogodbe o pogojih	TEST	POLJ	Sales Distribution/SD	\N	Naknadni rabati	TEST	Obdelava pogodbe o pogojih	1477	8964	\N
14757	TEST	WB2R_AB_DOCS	Dok. upravljanja obračunov za pogodbe	TEST	POLJ	Sales Distribution/SD	\N	Naknadni rabati	TEST	Dok. upravljanja obračunov za pogodbe	1478	8965	\N
14758	TEST	WCOCOALL	Pogodbe o pogojih	TEST	POLJ	Sales Distribution/SD	\N	Naknadni rabati	TEST	Pogodbe o pogojih	1479	8966	\N
14759	TEST	WZR4	Storno dokumetnov obračuna	TEST	POLJ	Sales Distribution/SD	\N	Naknadni rabati	TEST	Storno dokumetnov obračuna	1480	8967	\N
14760	TEST	WB2R_SC	Obračun pogodbe stranke	TEST	POLJ	Sales Distribution/SD	\N	Naknadni rabati	TEST	Obračun pogodbe stranke	1481	8968	\N
14761	TEST	WB2R_BUSVOL	Promet za pogodbe	TEST	POLJ	Sales Distribution/SD	\N	Naknadni rabati	TEST	Promet za pogodbe	1482	8969	\N
14762	TEST	WCOLI	Poregled pogoja	TEST	POLJ	Sales Distribution/SD	\N	Naknadni rabati	TEST	Poregled pogoja	1483	8970	\N
14763	TEST	WB2R_CANCEL_DOCS	Preklic dokumentov za pogodbe	TEST	POLJ	Sales Distribution/SD	\N	Naknadni rabati	TEST	Preklic dokumentov za pogodbe	1484	8971	\N
14764	TEST	WCOCO	Obdelava pogodbe o pogojih	TEST	ZITO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Obdelava pogodbe o pogojih	1485	8972	\N
14765	TEST	WB2R_AB_DOCS	Dok. upravljanja obračunov za pogodbe	TEST	ZITO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Dok. upravljanja obračunov za pogodbe	1486	8973	\N
14771	TEST	WB2R_CANCEL_DOCS	Preklic dokumentov za pogodbe	TEST	ZITO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Preklic dokumentov za pogodbe	1492	8979	\N
14772	TEST	WCOCO	Obdelava pogodbe o pogojih	TEST	PODD	Sales Distribution/SD	\N	Naknadni rabati	TEST	Obdelava pogodbe o pogojih	1493	8980	\N
14773	TEST	WB2R_BUSVOL	Promet za pogodbe	TEST	PODD	Sales Distribution/SD	\N	Naknadni rabati	TEST	Promet za pogodbe	1494	8981	\N
14774	TEST	WB2R_SC	Obračun pogodbe stranke	TEST	PODD	Sales Distribution/SD	\N	Naknadni rabati	TEST	Obračun pogodbe stranke	1495	8982	\N
14775	TEST	WCOCOALL	Pogodbe o pogojih	TEST	PODD	Sales Distribution/SD	\N	Naknadni rabati	TEST	Pogodbe o pogojih	1496	8983	\N
14776	TEST	WCOLI	Poregled pogoja	TEST	PODD	Sales Distribution/SD	\N	Naknadni rabati	TEST	Poregled pogoja	1497	8984	\N
14777	TEST	WB2R_AB_DOCS	Dok. upravljanja obračunov za pogodbe	TEST	PODD	Sales Distribution/SD	\N	naknadni rabati	TEST	Dok. upravljanja obračunov za pogodbe	1498	8985	\N
14778	TEST	WZR2	Sprememba dokumenta obračuna	TEST	PODD	Sales Distribution/SD	\N	Naknadni rabati	TEST	Sprememba dokumenta obračuna	1499	8986	\N
14779	TEST	WB2R_CANCEL_DOCS	Preklic dokumentov za pogodbe	TEST	PODD	Sales Distribution/SD	\N	Naknadni rabati	TEST	Preklic dokumentov za pogodbe	1500	8987	\N
14780	TEST	WRZ3	Prikaz dokumenta obračuna	TEST	PODD	Sales Distribution/SD	\N	Naknadni rabati	TEST	Prikaz dokumenta obračuna	1501	8988	\N
14781	TEST	WRZ4	Storno dokumetnov obračuna	TEST	PODD	Sales Distribution/SD	\N	Naknadni rabati	TEST	Storno dokumetnov obračuna	1502	8989	\N
14782	TEST	WB2R_SC_CORR	Popravek poravnave za pogodbe o pogojih stranke	TEST	PODD	Sales Distribution/SD	\N	Naknadni rabati	TEST	Popravek poravnave za pogodbe o pogojih stranke	1503	8990	\N
14783	TEST	WB2R_BVDETAIL	Posam. dokaz. obrač. pogodbe o pogojih	TEST	PODD	Sales Distribution/SD	\N	Naknadni rabati	TEST	Posam. dokaz. obrač. pogodbe o pogojih	1504	8991	\N
14784	TEST	WB2R_BVDETAIL_IDA	Zneski obračuna obrač. pog. o pogojih	TEST	PODD	Sales Distribution/SD	\N	Naknadni rabati	TEST	Zneski obračuna obrač. pog. o pogojih	1505	8992	\N
14785	TEST	WB2R_SETTL_CAL	Koledar obračuna za pogodbe o pogojih	TEST	PODD	Sales Distribution/SD	\N	Naknadni rabati	TEST	Koledar obračuna za pogodbe o pogojih	1506	8993	\N
14786	TEST	WB2R_SETTL_VAL_IDA	Zneski obračuna v obračunu pogodbe o pogojih	TEST	PODD	Sales Distribution/SD	\N	Naknadni rabati	TEST	Zneski obračuna v obračunu pogodbe o pogojih	1507	8994	\N
14787	TEST	ZPDF	Pretvorba v PDF	TEST	ZITO	Sales Distribution/SD	\N	TEST	TEST	Pretvorba v PDF	1508	8995	\N
14788	ZN01	VL06O	Knjiženje dobavnice	TEST	PLKO	Sales Distribution/SD	\N	Intercompany 2 - prodaja robe	TEST	Knjiženje dobavnice	1509	8996	\N
14789	ZN01	VFX3	Provjera jesu li svi dokumenti proknjiženi	TEST	PLKO	Sales Distribution/SD	\N	Intercompany 2 - prodaja robe	TEST	Provjera jesu li svi dokumenti proknjiženi	1510	8997	\N
14790	ZN01	BD87	obrada dokumenta s greškom	TEST	PLKO	Sales Distribution/SD	\N	Intercompany 2 - prodaja robe	TEST	obrada dokumenta s greškom	1511	8998	\N
14791	TEST	ZPDF	Creating PDF file	TEST	PLKO	Sales Distribution/SD	\N	Z-transakcije	TEST	Creating PDF file	1512	8999	\N
14792	TEST	ZSD	Z transakcije	TEST	PLKO	Sales Distribution/SD	\N	Z-transakcije	TEST	Z transakcije	1513	9000	\N
14793	TEST	WCOCO	Obdelava pogodbe o pogojih	TEST	PLKO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Obdelava pogodbe o pogojih	1514	9001	\N
14794	TEST	WB2R_BUSVOL	Promet za pogodbe	TEST	PLKO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Promet za pogodbe	1515	9002	\N
14795	TEST	WB2R_SC	Obračun pogodbe stranke	TEST	PLKO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Obračun pogodbe stranke	1516	9003	\N
14796	TEST	WCOCOALL	Pogodbe o pogojih	TEST	PLKO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Pogodbe o pogojih	1517	9004	\N
14797	TEST	WCOLI	Poregled pogoja	TEST	PLKO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Poregled pogoja	1518	9005	\N
14798	TEST	WB2R_AB_DOCS	Dok. upravljanja obračunov za pogodbe	TEST	PLKO	Sales Distribution/SD	\N	naknadni rabati	TEST	Dok. upravljanja obračunov za pogodbe	1519	9006	\N
14799	TEST	WZR2	Sprememba dokumenta obračuna	TEST	PLKO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Sprememba dokumenta obračuna	1520	9007	\N
14800	TEST	WB2R_CANCEL_DOCS	Preklic dokumentov za pogodbe	TEST	PLKO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Preklic dokumentov za pogodbe	1521	9008	\N
14801	TEST	WZR3	Prikaz dokumenta obračuna	TEST	PLKO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Prikaz dokumenta obračuna	1522	9009	\N
14802	TEST	WZR4	Storno dokumetnov obračuna	TEST	PLKO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Storno dokumetnov obračuna	1523	9010	\N
14803	TEST	WB2R_SC_CORR	Popravek poravnave za pogodbe o pogojih stranke	TEST	PLKO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Popravek poravnave za pogodbe o pogojih stranke	1524	9011	\N
14804	TEST	WB2R_BVDETAIL	Posam. dokaz. obrač. pogodbe o pogojih	TEST	PLKO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Posam. dokaz. obrač. pogodbe o pogojih	1525	9012	\N
14805	TEST	WB2R_BVDETAIL_IDA	Zneski obračuna obrač. pog. o pogojih	TEST	PLKO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Zneski obračuna obrač. pog. o pogojih	1526	9013	\N
14806	TEST	WB2R_SETTL_CAL	Koledar obračuna za pogodbe o pogojih	TEST	PLKO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Koledar obračuna za pogodbe o pogojih	1527	9014	\N
14807	TEST	WB2R_SETTL_VAL_IDA	Zneski obračuna v obračunu pogodbe o pogojih	TEST	PLKO	Sales Distribution/SD	\N	Naknadni rabati	TEST	Zneski obračuna v obračunu pogodbe o pogojih	1528	9015	\N
14808	TEST	WCOCO	off-invoice rebate contract	off-invoice rebate contract	POSK	Sales Distribution/SD	\N	TEST	off-invoice rebate contract	off-invoice rebate contract	1529	9016	\N
14809	TEST	WB2R_SC	off-invoice rebate accruals	off-invoice rebate accruals	POSK	Sales Distribution/SD	\N	TEST	off-invoice rebate accruals	off-invoice rebate accruals	1530	9017	\N
14810	TEST	WB2R_SC	off-invoice rebate credit note	off-invoice rebate credit note	POSK	Sales Distribution/SD	\N	TEST	off-invoice rebate credit note	off-invoice rebate credit note	1531	9018	\N
14811	TEST	ZKPD	TEST	TEST	BEPO	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1532	9019	\N
14812	TEST	ZGDK	TEST	TEST	BEPO	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1533	9020	\N
14813	TEST	ZCOCKPIT_F20	TEST	TEST	BEPO	Sales Distribution/SD	\N	Z-transakcije	TEST	TEST	1534	9021	\N
14814	TEST	WCOCO	TEST	TEST	BEPO	Sales Distribution/SD	\N	Naknadni rabati	TEST	TEST	1535	9022	\N
14815	TEST	WB2R_BUSVOL	TEST	TEST	BEPO	Sales Distribution/SD	\N	Naknadni rabati	TEST	TEST	1536	9023	\N
14819	TEST	WB2R_AB_DOCS	TEST	TEST	BEPO	Sales Distribution/SD	\N	naknadni rabati	TEST	TEST	1540	9027	\N
14820	TEST	WZR2	TEST	TEST	BEPO	Sales Distribution/SD	\N	Naknadni rabati	TEST	TEST	1541	9028	\N
14821	TEST	WB2R_CANCEL_DOCS	TEST	TEST	BEPO	Sales Distribution/SD	\N	Naknadni rabati	TEST	TEST	1542	9029	\N
14822	TEST	WRZ3	TEST	TEST	BEPO	Sales Distribution/SD	\N	Naknadni rabati	TEST	TEST	1543	9030	\N
14823	TEST	WRZ4	TEST	TEST	BEPO	Sales Distribution/SD	\N	Naknadni rabati	TEST	TEST	1544	9031	\N
\.


--
-- Data for Name: test_templates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_templates (id, module, country_code, test_type, e2e_process, scenario_id, transaction_code, process_step, test_step_name) FROM stdin;
1	Sales Distribution/SD	\N	E2E	Order to Cash	E2E	VA01	Create Sales Order	Create order
2	Sales Distribution/SD	\N	E2E	Order to Cash	E2E	VL01N	Create Delivery	Delivery creation
3	Sales Distribution/SD	\N	E2E	Order to Cash	E2E	VF01	Billing	Invoice creation
4	Sales Distribution/SD	\N	Functional	Sales	Functional	VA01	Create Order	Positive test
5	Sales Distribution/SD	\N	Functional	Sales	Functional	VA02	Change Order	Edit order
6	Sales Distribution/SD	\N	Negative	Sales	Negative	VA01	Invalid Customer	Error scenario
7	Sales Distribution/SD	\N	Standalone	Display	Standalone	VA03	Display Order	View order
\.


--
-- Name: ai_command_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ai_command_history_id_seq', 65, true);


--
-- Name: flow_master_flow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.flow_master_flow_id_seq', 115, true);


--
-- Name: flow_steps_step_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.flow_steps_step_id_seq', 87, true);


--
-- Name: repository_assets_asset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.repository_assets_asset_id_seq', 42, true);


--
-- Name: sap_process_library_process_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sap_process_library_process_id_seq', 342, true);


--
-- Name: sap_process_steps_process_step_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sap_process_steps_process_step_id_seq', 1093, true);


--
-- Name: script_master_script_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.script_master_script_id_seq', 4, true);


--
-- Name: script_steps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.script_steps_id_seq', 19, true);


--
-- Name: test_cases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_cases_id_seq', 29, true);


--
-- Name: test_coverage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_coverage_id_seq', 9, true);


--
-- Name: test_coverage_modules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_coverage_modules_id_seq', 36, true);


--
-- Name: test_coverage_structure_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_coverage_structure_id_seq', 1651, true);


--
-- Name: test_coverage_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_coverage_types_id_seq', 30, true);


--
-- Name: test_execution_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_execution_history_id_seq', 86, true);


--
-- Name: test_steps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_steps_id_seq', 14824, true);


--
-- Name: test_steps_step_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_steps_step_id_seq', 9032, true);


--
-- Name: test_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_templates_id_seq', 7, true);


--
-- Name: ai_command_history ai_command_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_command_history
    ADD CONSTRAINT ai_command_history_pkey PRIMARY KEY (id);


--
-- Name: flow_master flow_master_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flow_master
    ADD CONSTRAINT flow_master_pkey PRIMARY KEY (flow_id);


--
-- Name: flow_steps flow_steps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flow_steps
    ADD CONSTRAINT flow_steps_pkey PRIMARY KEY (step_id);


--
-- Name: repository_assets repository_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.repository_assets
    ADD CONSTRAINT repository_assets_pkey PRIMARY KEY (asset_id);


--
-- Name: sap_process_library sap_process_library_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sap_process_library
    ADD CONSTRAINT sap_process_library_pkey PRIMARY KEY (process_id);


--
-- Name: sap_process_steps sap_process_steps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sap_process_steps
    ADD CONSTRAINT sap_process_steps_pkey PRIMARY KEY (process_step_id);


--
-- Name: script_master script_master_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.script_master
    ADD CONSTRAINT script_master_pkey PRIMARY KEY (script_id);


--
-- Name: script_steps script_steps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.script_steps
    ADD CONSTRAINT script_steps_pkey PRIMARY KEY (id);


--
-- Name: test_cases test_cases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_cases
    ADD CONSTRAINT test_cases_pkey PRIMARY KEY (id);


--
-- Name: test_coverage_modules test_coverage_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_coverage_modules
    ADD CONSTRAINT test_coverage_modules_pkey PRIMARY KEY (id);


--
-- Name: test_coverage test_coverage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_coverage
    ADD CONSTRAINT test_coverage_pkey PRIMARY KEY (id);


--
-- Name: test_coverage_structure test_coverage_structure_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_coverage_structure
    ADD CONSTRAINT test_coverage_structure_pkey PRIMARY KEY (id);


--
-- Name: test_coverage_types test_coverage_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_coverage_types
    ADD CONSTRAINT test_coverage_types_pkey PRIMARY KEY (id);


--
-- Name: test_execution_history test_execution_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_execution_history
    ADD CONSTRAINT test_execution_history_pkey PRIMARY KEY (id);


--
-- Name: test_templates test_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_templates
    ADD CONSTRAINT test_templates_pkey PRIMARY KEY (id);


--
-- Name: flow_steps fk_flow_steps; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flow_steps
    ADD CONSTRAINT fk_flow_steps FOREIGN KEY (flow_id) REFERENCES public.flow_master(flow_id) ON DELETE CASCADE;


--
-- Name: sap_process_steps fk_process_steps; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sap_process_steps
    ADD CONSTRAINT fk_process_steps FOREIGN KEY (process_id) REFERENCES public.sap_process_library(process_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict zLrWw6xeGASwv9J5ueyG1cGV3RZtLDlVvHgxwZQQV7edZyPzFSEzdPFe0BnygAQ

