-- Table: public.enroll_course

-- DROP TABLE IF EXISTS public.enroll_course;

CREATE TABLE IF NOT EXISTS public.enroll_course
(
    course_code character(20) COLLATE pg_catalog."default" NOT NULL,
    student_id character(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "ENROLL_COURSE_pkey" PRIMARY KEY (course_code, student_id),
    CONSTRAINT "Course_code" FOREIGN KEY (course_code)
        REFERENCES public.course (course_code) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Student_id" FOREIGN KEY (student_id)
        REFERENCES public.student (student_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.enroll_course
    OWNER to postgres;
-- Index: fki_Student_id

-- DROP INDEX IF EXISTS public."fki_Student_id";

CREATE INDEX IF NOT EXISTS "fki_Student_id"
    ON public.enroll_course USING btree
    (student_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- Trigger: same_id_control

-- DROP TRIGGER IF EXISTS same_id_control ON public.enroll_course;

CREATE TRIGGER same_id_control
    BEFORE INSERT
    ON public.enroll_course
    FOR EACH ROW
    EXECUTE FUNCTION public.same_id_dept_and_studept();

-- Trigger: student_max_credit

-- DROP TRIGGER IF EXISTS student_max_credit ON public.enroll_course;

CREATE TRIGGER student_max_credit
    BEFORE INSERT OR UPDATE 
    ON public.enroll_course
    FOR EACH ROW
    EXECUTE FUNCTION public.credit_check();