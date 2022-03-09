-- Table: public.education

-- DROP TABLE IF EXISTS public.education;

CREATE TABLE IF NOT EXISTS public.education
(
    education_id character(20) COLLATE pg_catalog."default" NOT NULL,
    school_name character(64) COLLATE pg_catalog."default",
    department_name character(64) COLLATE pg_catalog."default",
    CONSTRAINT "EDUCATION_pkey" PRIMARY KEY (education_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.education
    OWNER to postgres;