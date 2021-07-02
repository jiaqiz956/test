--
-- PostgreSQL database dump
--

-- Dumped from database version 10.3
-- Dumped by pg_dump version 10.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.tweets DROP CONSTRAINT tweets_pkey;
ALTER TABLE ONLY public.accounts DROP CONSTRAINT accounts_pkey;
DROP TABLE public.tweets;
DROP TABLE public.keywords;
DROP TABLE public.followers;
DROP TABLE public.accounts;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    account_screen_name character varying,
    name character varying,
    account_id bigint NOT NULL,
    collect_followers boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    location character varying,
    description character varying,
    suspended boolean DEFAULT false,
    last_follower_collection_timestamp timestamp without time zone,
    tweet_count integer,
    en_tweet_count integer,
    ja_tweet_count integer,
    other_tweet_count integer,
    error boolean,
    collect_tweets boolean,
    last_tweet_collection_timestamp timestamp without time zone
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- Name: COLUMN accounts.tweet_count; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.accounts.tweet_count IS 'this column holds the number of tweets sent by this user that we have in the tweets table. Run PopulateAccountsTable.py to fill / refresh this column. We use this info to prioritize which users'' follower info to collect.';


--
-- Name: followers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.followers (
    "timestamp" timestamp without time zone DEFAULT now(),
    follower_id bigint NOT NULL,
    followee_id bigint NOT NULL,
    degree integer,
    last_present_timestamp timestamp without time zone,
    first_not_present_timestamp timestamp without time zone,
    last_not_present_timestamp timestamp without time zone
);


ALTER TABLE public.followers OWNER TO postgres;

--
-- Name: keywords; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keywords (
    keyword character varying,
    language character varying,
    date_started date,
    collect boolean DEFAULT true,
    abbrev_keyword character varying
);


ALTER TABLE public.keywords OWNER TO postgres;

--
-- Name: COLUMN keywords.abbrev_keyword; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.keywords.abbrev_keyword IS 'Short form of keyword for use in descriptive statistics etc.';


--
-- Name: tweets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tweets (
    id bigint NOT NULL,
    text character varying,
    in_reply_to_status_id bigint,
    favorite_count integer,
    retweeted boolean,
    retweet_count integer,
    favorited boolean,
    user_id bigint,
    user_screen_name character varying,
    user_name character varying,
    possibly_sensitive boolean,
    lang character varying,
    created_at timestamp without time zone,
    source character varying,
    retweeted_status_id bigint,
    coordinates_coordinates point,
    media character varying[],
    place_bounding_box_coordinates point[],
    symbols character varying[],
    quoted_status_id character varying,
    keywords character varying[]
);


ALTER TABLE public.tweets OWNER TO postgres;

--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (account_screen_name, name, account_id, collect_followers, created_at, location, description, suspended, last_follower_collection_timestamp, tweet_count, en_tweet_count, ja_tweet_count, other_tweet_count, error, collect_tweets, last_tweet_collection_timestamp) FROM stdin;
\.


--
-- Data for Name: followers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.followers ("timestamp", follower_id, followee_id, degree, last_present_timestamp, first_not_present_timestamp, last_not_present_timestamp) FROM stdin;
\.


--
-- Data for Name: keywords; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keywords (keyword, language, date_started, collect, abbrev_keyword) FROM stdin;
\.


--
-- Data for Name: tweets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tweets (id, text, in_reply_to_status_id, favorite_count, retweeted, retweet_count, favorited, user_id, user_screen_name, user_name, possibly_sensitive, lang, created_at, source, retweeted_status_id, coordinates_coordinates, media, place_bounding_box_coordinates, symbols, quoted_status_id, keywords) FROM stdin;
\.


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (account_id);


--
-- Name: tweets tweets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tweets
    ADD CONSTRAINT tweets_pkey PRIMARY KEY (id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

