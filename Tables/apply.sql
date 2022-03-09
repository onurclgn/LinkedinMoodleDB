-- Table: public.apply

-- DROP TABLE IF EXISTS public.apply;

CREATE TABLE IF NOT EXISTS public.apply
(
    emp_id character(20) COLLATE pg_catalog."default" NOT NULL,
    company_id character(20) COLLATE pg_catalog."default" NOT NULL,
    job_name character(20) COLLATE pg_catalog."default" NOT NULL,
    appdate character(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT apply_pkey PRIMARY KEY (emp_id, company_id, job_name),
    CONSTRAINT company FOREIGN KEY (company_id, job_name)
        REFERENCES public.job (company_id, job_name) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT emp_id FOREIGN KEY (emp_id)
        REFERENCES public.employee (emp_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.apply
    OWNER to postgres;
-- Index: fki_company

-- DROP INDEX IF EXISTS public.fki_company;

CREATE INDEX IF NOT EXISTS fki_company
    ON public.apply USING btree
    (company_id COLLATE pg_catalog."default" ASC NULLS LAST, job_name COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- Trigger: max_apply_job

-- DROP TRIGGER IF EXISTS max_apply_job ON public.apply;

CREATE TRIGGER max_apply_job
    BEFORE INSERT
    ON public.apply
    FOR EACH ROW
    EXECUTE FUNCTION public.check_numberof_apply();