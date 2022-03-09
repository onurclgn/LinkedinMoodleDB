-- Table: public.university

-- DROP TABLE IF EXISTS public.university;

CREATE TABLE IF NOT EXISTS public.university
(
    names character(64) COLLATE pg_catalog."default" NOT NULL,
    adress character(128) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "UNIVERSITY_pkey" PRIMARY KEY (names)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.university
    OWNER to postgres;