-- Table: public.company

-- DROP TABLE IF EXISTS public.company;

CREATE TABLE IF NOT EXISTS public.company
(
    company_id character(20) COLLATE pg_catalog."default" NOT NULL,
    company_name character(64) COLLATE pg_catalog."default" NOT NULL,
    country character(64) COLLATE pg_catalog."default",
    city character(64) COLLATE pg_catalog."default",
    CONSTRAINT "COMPANY_pkey" PRIMARY KEY (company_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.company
    OWNER to postgres;