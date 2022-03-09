-- Table: public.has_educate

-- DROP TABLE IF EXISTS public.has_educate;

CREATE TABLE IF NOT EXISTS public.has_educate
(
    user_id character(20) COLLATE pg_catalog."default" NOT NULL,
    education_id character(20) COLLATE pg_catalog."default" NOT NULL,
    start_date date NOT NULL,
    end_date date,
    CONSTRAINT "HAS_UPDATE_pkey" PRIMARY KEY (user_id, education_id),
    CONSTRAINT "Education_id" FOREIGN KEY (education_id)
        REFERENCES public.education (education_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "User_id" FOREIGN KEY (user_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.has_educate
    OWNER to postgres;
-- Index: fki_Education_id

-- DROP INDEX IF EXISTS public."fki_Education_id";

CREATE INDEX IF NOT EXISTS "fki_Education_id"
    ON public.has_educate USING btree
    (education_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_u

-- DROP INDEX IF EXISTS public.fki_u;

CREATE INDEX IF NOT EXISTS fki_u
    ON public.has_educate USING btree
    (user_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;