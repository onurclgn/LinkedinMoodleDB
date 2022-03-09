-- Table: public.takeproject

-- DROP TABLE IF EXISTS public.takeproject;

CREATE TABLE IF NOT EXISTS public.takeproject
(
    project_id character(20) COLLATE pg_catalog."default" NOT NULL,
    student_id character(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "TAKEPROJECT_pkey" PRIMARY KEY (project_id, student_id),
    CONSTRAINT "Project_id" FOREIGN KEY (project_id)
        REFERENCES public.project (project_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Student_id" FOREIGN KEY (student_id)
        REFERENCES public.student (student_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.takeproject
    OWNER to postgres;
-- Index: fki_Project_id

-- DROP INDEX IF EXISTS public."fki_Project_id";

CREATE INDEX IF NOT EXISTS "fki_Project_id"
    ON public.takeproject USING btree
    (project_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- Trigger: take_project_trigger

-- DROP TRIGGER IF EXISTS take_project_trigger ON public.takeproject;

CREATE TRIGGER take_project_trigger
    BEFORE INSERT
    ON public.takeproject
    FOR EACH ROW
    EXECUTE FUNCTION public.same_course_project_stu();