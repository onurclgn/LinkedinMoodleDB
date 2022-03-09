-- Table: public.employee

-- DROP TABLE IF EXISTS public.employee;

CREATE TABLE IF NOT EXISTS public.employee
(
    emp_id character(20) COLLATE pg_catalog."default" NOT NULL,
    start_date date,
    role character(20) COLLATE pg_catalog."default",
    company_id character(20) COLLATE pg_catalog."default",
    CONSTRAINT "EMPLOYEE_pkey" PRIMARY KEY (emp_id),
    CONSTRAINT "Company_id" FOREIGN KEY (company_id)
        REFERENCES public.company (company_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT emp_id FOREIGN KEY (emp_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.employee
    OWNER to postgres;
-- Index: fki_emp_id

-- DROP INDEX IF EXISTS public.fki_emp_id;

CREATE INDEX IF NOT EXISTS fki_emp_id
    ON public.employee USING btree
    (emp_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_employe_id

-- DROP INDEX IF EXISTS public.fki_employe_id;

CREATE INDEX IF NOT EXISTS fki_employe_id
    ON public.employee USING btree
    (emp_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;