--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: dog; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.dog (
    id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    dob date NOT NULL,
    owner text,
    gender character(1) DEFAULT 'f'::bpchar NOT NULL,
    image text NOT NULL
);


ALTER TABLE public.dog OWNER TO myuser;

--
-- Name: dog_id_seq; Type: SEQUENCE; Schema: public; Owner: myuser
--

CREATE SEQUENCE public.dog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dog_id_seq OWNER TO myuser;

--
-- Name: dog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myuser
--

ALTER SEQUENCE public.dog_id_seq OWNED BY public.dog.id;


--
-- Name: dog id; Type: DEFAULT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.dog ALTER COLUMN id SET DEFAULT nextval('public.dog_id_seq'::regclass);


--
-- Data for Name: dog; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.dog (id, name, description, dob, owner, gender, image) FROM stdin;
97	Rocky	A brown Chihuahua known for being protective.	2019-01-28	\N	m	https://raw.githubusercontent.com/joshlong-attic/dog-images/main/chihuahua-1.png
87	Bailey	A tan Dachshund known for being playful.	2022-03-22	\N	m	https://raw.githubusercontent.com/joshlong-attic/dog-images/main/dachshund-1.png
89	Charlie	A black Bulldog known for being curious.	2021-08-26	\N	m	https://raw.githubusercontent.com/joshlong-attic/dog-images/main/bulldog-1.png
67	Cooper	A tan Boxer known for being affectionate.	2011-12-22	\N	f	https://raw.githubusercontent.com/joshlong-attic/dog-images/main/boxer-1.png
73	Max	A brindle Dachshund known for being energetic.	2021-12-07	\N	m	https://raw.githubusercontent.com/joshlong-attic/dog-images/main/dachshund-1.png
3	Buddy	A Poodle known for being calm.	2013-10-30	\N	m	https://raw.githubusercontent.com/joshlong-attic/dog-images/main/poodle-1.png
93	Duke	A white German Shepherd known for being friendly.	2017-03-19	\N	m	https://raw.githubusercontent.com/joshlong-attic/dog-images/main/german-shepard-2.png
63	Jasper	A grey Shih Tzu known for being protective.	2016-01-05	\N	m	https://raw.githubusercontent.com/joshlong-attic/dog-images/main/shih-tzu-2.png
69	Toby	A grey Doberman known for being playful.	2008-12-31	\N	m	https://raw.githubusercontent.com/joshlong-attic/dog-images/main/doberman-1.png
101	Nala	A spotted German Shepherd known for being loyal.	2020-07-30	\N	f	https://raw.githubusercontent.com/joshlong-attic/dog-images/main/german-shepard-1.png
61	Penny	A white Great Dane known for being protective.	2014-05-07	\N	f	https://raw.githubusercontent.com/joshlong-attic/dog-images/main/great-dane-1.png
1	Bella	A golden Poodle known for being calm.	2020-01-07	\N	f	https://raw.githubusercontent.com/joshlong-attic/dog-images/main/poodle-2.png
91	Willow	A brindle Great Dane known for being calm.	2011-11-15	\N	f	https://raw.githubusercontent.com/joshlong-attic/dog-images/main/great-dane-2.png
5	Daisy	A spotted Poodle known for being affectionate.	2021-07-31	\N	f	https://raw.githubusercontent.com/joshlong-attic/dog-images/main/poodle-1.png
95	Mia	A grey Great Dane known for being loyal.	2020-11-03	\N	f	https://raw.githubusercontent.com/joshlong-attic/dog-images/main/great-dane-2.png
71	Molly	A golden Chihuahua known for being curious.	2014-03-22	\N	f	https://raw.githubusercontent.com/joshlong-attic/dog-images/main/chihuahua-2.png
65	Ruby	A white Great Dane known for being protective.	2021-11-07	\N	f	https://raw.githubusercontent.com/joshlong-attic/dog-images/main/great-dane-3.png
45	Prancer	A demonic, neurotic, man hating, animal hating, children hating dogs that look like gremlins.	2008-12-19	\N	m	https://raw.githubusercontent.com/joshlong-attic/dog-images/main/prancer.jpg
\.


--
-- Name: dog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: myuser
--

SELECT pg_catalog.setval('public.dog_id_seq', 101, true);


--
-- Name: dog dog_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.dog
    ADD CONSTRAINT dog_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

