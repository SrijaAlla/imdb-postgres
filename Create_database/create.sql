-- Database: IMDB_MOVIES_2.0

-- DROP DATABASE IF EXISTS "IMDB_MOVIES_2.0";

-- CREATE DATABASE "IMDB_MOVIES_2.0"
--     WITH
--     OWNER = postgres
--     ENCODING = 'UTF8'
--     LC_COLLATE = 'English_India.1252'
--     LC_CTYPE = 'English_India.1252'
--     LOCALE_PROVIDER = 'libc'
--     TABLESPACE = pg_default
--     CONNECTION LIMIT = -1
--     IS_TEMPLATE = False;

-- DROP existing tables if they exist to prevent errors on creation
DROP TABLE IF EXISTS public.principals_imdb, public.writers_imdb, public.ratings_imdb, public.knownfortitles_imdb, public.genres_imdb, public.episode_imdb, public.directors_imdb, public.akas_imdb, public.primaryprofession_imdb, public.names_imdb, public.basics_imdb CASCADE;

-- Table creation for 'basics_imdb'
CREATE TABLE IF NOT EXISTS public.basics_imdb
(
    tconst character varying(25) COLLATE pg_catalog."default" NOT NULL,
    titletype character varying(100) COLLATE pg_catalog."default",
    primarytitle character varying(600) COLLATE pg_catalog."default",
    originaltitle character varying(600) COLLATE pg_catalog."default",
    isadult character varying(20) COLLATE pg_catalog."default",
    startyear integer,
    endyear integer,
    runtimeminutes integer,
    CONSTRAINT basics_imdb_pkey PRIMARY KEY (tconst)
);
ALTER TABLE public.basics_imdb OWNER to postgres;

-- Table creation for 'names_imdb'
CREATE TABLE IF NOT EXISTS public.names_imdb
(
    nconst character varying(20) COLLATE pg_catalog."default" NOT NULL,
    primaryname character varying(500) COLLATE pg_catalog."default",
    birthyear integer,
    deathyear integer,
    CONSTRAINT names_imdb_pkey PRIMARY KEY (nconst)
);
ALTER TABLE public.names_imdb OWNER to postgres;

-- Table creation for 'akas_imdb'
CREATE TABLE IF NOT EXISTS public.akas_imdb
(
    titleid character varying(100) COLLATE pg_catalog."default" NOT NULL,
    ordering integer NOT NULL,
    title character varying COLLATE pg_catalog."default",
    region character varying(100) COLLATE pg_catalog."default",
    language character varying(60) COLLATE pg_catalog."default",
    type character varying COLLATE pg_catalog."default",
    attribute character varying COLLATE pg_catalog."default",
    isoriginaltitle integer,
    CONSTRAINT akas_imdb_pkey PRIMARY KEY (titleid, ordering),
    CONSTRAINT akas_titleid_fkey FOREIGN KEY (titleid)
        REFERENCES public.basics_imdb (tconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
ALTER TABLE public.akas_imdb OWNER to postgres;
CREATE INDEX IF NOT EXISTS "index_akas_imdb_titleId" ON public.akas_imdb USING btree (titleid COLLATE pg_catalog."default" ASC NULLS LAST);

-- Table creation for 'directors_imdb'
CREATE TABLE IF NOT EXISTS public.directors_imdb
(
    tconst character varying COLLATE pg_catalog."default" NOT NULL,
    nconst character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT directors_pkey PRIMARY KEY (tconst, nconst),
    CONSTRAINT directors_nconst_fkey FOREIGN KEY (nconst)
        REFERENCES public.names_imdb (nconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT directors_tconst_fkey FOREIGN KEY (tconst)
        REFERENCES public.basics_imdb (tconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
ALTER TABLE public.directors_imdb OWNER to postgres;

-- Table creation for 'episode_imdb'
CREATE TABLE IF NOT EXISTS public.episode_imdb
(
    tconst character varying(25) COLLATE pg_catalog."default" NOT NULL,
    parenttconst character varying(25) COLLATE pg_catalog."default",
    seasonnumber integer,
    episodenumber integer,
    CONSTRAINT episode_imdb_pkey PRIMARY KEY (tconst),
    CONSTRAINT episode_parenttconst_fkey FOREIGN KEY (parenttconst)
        REFERENCES public.basics_imdb (tconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT episode_tconst_fkey FOREIGN KEY (tconst)
        REFERENCES public.basics_imdb (tconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
ALTER TABLE public.episode_imdb OWNER to postgres;
CREATE INDEX IF NOT EXISTS "index_episode_imdb_parentTconst" ON public.episode_imdb USING btree (parenttconst COLLATE pg_catalog."default" ASC NULLS LAST);
CREATE INDEX IF NOT EXISTS index_episode_imdb_tconst ON public.episode_imdb USING btree (tconst COLLATE pg_catalog."default" ASC NULLS LAST);

-- Continue creating other tables and their constraints in a similar fashion

-- Table creation for 'genres_imdb'
CREATE TABLE IF NOT EXISTS public.genres_imdb
(
    tconst character varying COLLATE pg_catalog."default" NOT NULL,
    genre character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT genres_imdb_pkey PRIMARY KEY (tconst, genre),
    CONSTRAINT genres_imdb_tconst_fkey FOREIGN KEY (tconst)
        REFERENCES public.basics_imdb (tconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);
ALTER TABLE public.genres_imdb OWNER to postgres;
CREATE INDEX IF NOT EXISTS fki_genres_imdb_tconst_fkey ON public.genres_imdb USING btree (tconst COLLATE pg_catalog."default" ASC NULLS LAST);

-- Table creation for 'knownfortitles_imdb'
CREATE TABLE IF NOT EXISTS public.knownfortitles_imdb
(
    nconst character varying COLLATE pg_catalog."default" NOT NULL,
    knownfortitle character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT knownfortitles_imdb_pkey PRIMARY KEY (nconst, knownfortitle),
    CONSTRAINT knownfortitles_imdb_nconst_fkey FOREIGN KEY (nconst)
        REFERENCES public.names_imdb (nconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
ALTER TABLE public.knownfortitles_imdb OWNER to postgres;

-- Table creation for 'primaryprofession_imdb'
CREATE TABLE IF NOT EXISTS public.primaryprofession_imdb
(
    nconst character varying COLLATE pg_catalog."default" NOT NULL,
    primaryprofession character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT primaryprofession_imdb_pkey PRIMARY KEY (nconst, primaryprofession),
    CONSTRAINT primaryprofession_imdb_nconst_fkey FOREIGN KEY (nconst)
        REFERENCES public.names_imdb (nconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
ALTER TABLE public.primaryprofession_imdb OWNER to postgres;

-- Table creation for 'principals_imdb'
CREATE TABLE IF NOT EXISTS public.principals_imdb
(
    tconst character varying(60) COLLATE pg_catalog."default" NOT NULL,
    ordering integer NOT NULL,
    nconst character varying(60) COLLATE pg_catalog."default",
    category character varying COLLATE pg_catalog."default",
    job character varying COLLATE pg_catalog."default",
    characters character varying COLLATE pg_catalog."default",
    CONSTRAINT principals_imdb_pkey PRIMARY KEY (tconst, ordering),
    CONSTRAINT principals_nconst_fkey FOREIGN KEY (nconst)
        REFERENCES public.names_imdb (nconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT principals_tconst_fkey FOREIGN KEY (tconst)
        REFERENCES public.basics_imdb (tconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
ALTER TABLE public.principals_imdb OWNER to postgres;
CREATE INDEX IF NOT EXISTS index_principals_imdb_nconst ON public.principals_imdb USING btree (nconst COLLATE pg_catalog."default" ASC NULLS LAST);
CREATE INDEX IF NOT EXISTS index_principals_imdb_tconst ON public.principals_imdb USING btree (tconst COLLATE pg_catalog."default" ASC NULLS LAST);

-- Table creation for 'ratings_imdb'
CREATE TABLE IF NOT EXISTS public.ratings_imdb
(
    tconst character varying(30) COLLATE pg_catalog."default" NOT NULL,
    averagerating double precision,
    numvotes integer,
    CONSTRAINT ratings_imdb_pkey PRIMARY KEY (tconst),
    CONSTRAINT ratings_tconst_fkey FOREIGN KEY (tconst)
        REFERENCES public.basics_imdb (tconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
ALTER TABLE public.ratings_imdb OWNER to postgres;
CREATE INDEX IF NOT EXISTS index_ratings_imdb_tconst ON public.ratings_imdb USING btree (tconst COLLATE pg_catalog."default" ASC NULLS LAST);

-- Table creation for 'writers_imdb'
CREATE TABLE IF NOT EXISTS public.writers_imdb
(
    tconst character varying COLLATE pg_catalog."default" NOT NULL,
    nconst character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT writers_pkey PRIMARY KEY (tconst, nconst),
    CONSTRAINT writers_nconst_fkey FOREIGN KEY (nconst)
        REFERENCES public.names_imdb (nconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT writers_tconst_fkey FOREIGN KEY (tconst)
        REFERENCES public.basics_imdb (tconst) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
ALTER TABLE public.writers_imdb OWNER to postgres;


	
