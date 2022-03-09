-- Table: public.project

-- DROP TABLE IF EXISTS public.project;

CREATE TABLE IF NOT EXISTS public.project
(
    project_id character(40) COLLATE pg_catalog."default" NOT NULL,
    deadline date,
    names character(64) COLLATE pg_catalog."default",
    course_code character(40) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "PROJECT_pkey" PRIMARY KEY (project_id),
    CONSTRAINT "Course_code" FOREIGN KEY (course_code)
        REFERENCES public.course (course_code) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.project
    OWNER to postgres;
-- Index: fki_Course_code

-- DROP INDEX IF EXISTS public."fki_Course_code";

CREATE INDEX IF NOT EXISTS "fki_Course_code"
    ON public.project USING btree
    (course_code COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;