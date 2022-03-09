-- Table: public.job

-- DROP TABLE IF EXISTS public.job;

CREATE TABLE IF NOT EXISTS public.job
(
    company_id character(20) COLLATE pg_catalog."default" NOT NULL,
    job_name character(40) COLLATE pg_catalog."default" NOT NULL,
    job_type character(40) COLLATE pg_catalog."default",
    CONSTRAINT "JOB_pkey" PRIMARY KEY (company_id, job_name),
    CONSTRAINT "Company_id" FOREIGN KEY (company_id)
        REFERENCES public.company (company_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT job_job_type_check CHECK (job_type = 'full-time'::bpchar OR job_type = 'part-time'::bpchar OR job_type = 'intern'::bpchar) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.job
    OWNER to postgres;
-- Index: fki_O

-- DROP INDEX IF EXISTS public."fki_O";

CREATE INDEX IF NOT EXISTS "fki_O"
    ON public.job USING btree
    (company_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;