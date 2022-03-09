-- Table: public.instructor

-- DROP TABLE IF EXISTS public.instructor;

CREATE TABLE IF NOT EXISTS public.instructor
(
    instructor_id character(20) COLLATE pg_catalog."default" NOT NULL DEFAULT 1,
    dep_id character(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "INSTRUCTOR_pkey" PRIMARY KEY (instructor_id),
    CONSTRAINT ins_id FOREIGN KEY (instructor_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.instructor
    OWNER to postgres;
-- Index: fki_ins_id

-- DROP INDEX IF EXISTS public.fki_ins_id;

CREATE INDEX IF NOT EXISTS fki_ins_id
    ON public.instructor USING btree
    (instructor_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;