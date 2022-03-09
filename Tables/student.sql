-- Table: public.student

-- DROP TABLE IF EXISTS public.student;

CREATE TABLE IF NOT EXISTS public.student
(
    student_id character(20) COLLATE pg_catalog."default" NOT NULL,
    student_number character(64) COLLATE pg_catalog."default" NOT NULL,
    advisor_id character(20) COLLATE pg_catalog."default" NOT NULL,
    dep_id character(20) COLLATE pg_catalog."default" NOT NULL,
    taken_credit integer NOT NULL DEFAULT 0,
    CONSTRAINT "STUDENT_pkey" PRIMARY KEY (student_id),
    CONSTRAINT "Advisor_id" FOREIGN KEY (advisor_id)
        REFERENCES public.instructor (instructor_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET DEFAULT,
    CONSTRAINT "Dep_id" FOREIGN KEY (dep_id)
        REFERENCES public.department (dep_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT user_id FOREIGN KEY (student_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT student_student_number_check CHECK (char_length(student_number) > 10) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.student
    OWNER to postgres;
-- Index: fki_Advisor_id

-- DROP INDEX IF EXISTS public."fki_Advisor_id";

CREATE INDEX IF NOT EXISTS "fki_Advisor_id"
    ON public.student USING btree
    (advisor_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_Dep_id

-- DROP INDEX IF EXISTS public."fki_Dep_id";

CREATE INDEX IF NOT EXISTS "fki_Dep_id"
    ON public.student USING btree
    (dep_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_user_id

-- DROP INDEX IF EXISTS public.fki_user_id;

CREATE INDEX IF NOT EXISTS fki_user_id
    ON public.student USING btree
    (student_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- Trigger: student_number_check

-- DROP TRIGGER IF EXISTS student_number_check ON public.student;

CREATE TRIGGER student_number_check
    BEFORE UPDATE 
    ON public.student
    FOR EACH ROW
    EXECUTE FUNCTION public.no_update_number();