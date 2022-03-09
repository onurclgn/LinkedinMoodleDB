-- Table: public.course

-- DROP TABLE IF EXISTS public.course;

CREATE TABLE IF NOT EXISTS public.course
(
    course_code character(40) COLLATE pg_catalog."default" NOT NULL,
    names character(64) COLLATE pg_catalog."default" NOT NULL,
    credit integer,
    department_id character(40) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "COURSE_pkey" PRIMARY KEY (course_code),
    CONSTRAINT "Department_id" FOREIGN KEY (department_id)
        REFERENCES public.department (dep_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.course
    OWNER to postgres;
-- Index: fki_Department_id

-- DROP INDEX IF EXISTS public."fki_Department_id";

CREATE INDEX IF NOT EXISTS "fki_Department_id"
    ON public.course USING btree
    (department_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;