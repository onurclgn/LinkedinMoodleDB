-- Table: public.department

-- DROP TABLE IF EXISTS public.department;

CREATE TABLE IF NOT EXISTS public.department
(
    dep_id character(20) COLLATE pg_catalog."default" NOT NULL,
    dname character(64) COLLATE pg_catalog."default" NOT NULL,
    uni_name character(64) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "DEPARTMENT_pkey" PRIMARY KEY (dep_id),
    CONSTRAINT uni_name FOREIGN KEY (uni_name)
        REFERENCES public.university (names) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.department
    OWNER to postgres;
-- Index: fki_uni_name

-- DROP INDEX IF EXISTS public.fki_uni_name;

CREATE INDEX IF NOT EXISTS fki_uni_name
    ON public.department USING btree
    (uni_name COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;