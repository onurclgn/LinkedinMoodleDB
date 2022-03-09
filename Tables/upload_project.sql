-- Table: public.upload_project

-- DROP TABLE IF EXISTS public.upload_project;

CREATE TABLE IF NOT EXISTS public.upload_project
(
    project_id character(20) COLLATE pg_catalog."default" NOT NULL,
    ins_id character(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "UPLOAD_PROJECT_pkey" PRIMARY KEY (project_id, ins_id),
    CONSTRAINT "Ins_id" FOREIGN KEY (ins_id)
        REFERENCES public.instructor (instructor_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Project_id" FOREIGN KEY (project_id)
        REFERENCES public.project (project_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.upload_project
    OWNER to postgres;
-- Index: fki_Ins_id

-- DROP INDEX IF EXISTS public."fki_Ins_id";

CREATE INDEX IF NOT EXISTS "fki_Ins_id"
    ON public.upload_project USING btree
    (ins_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- Trigger: upload_project_trigger

-- DROP TRIGGER IF EXISTS upload_project_trigger ON public.upload_project;

CREATE TRIGGER upload_project_trigger
    BEFORE INSERT
    ON public.upload_project
    FOR EACH ROW
    EXECUTE FUNCTION public.same_course_project_ins();