-- Table: public.give_course

-- DROP TABLE IF EXISTS public.give_course;

CREATE TABLE IF NOT EXISTS public.give_course
(
    ins_id character(20) COLLATE pg_catalog."default" NOT NULL,
    course_code character(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "GIVE_COURSE_pkey" PRIMARY KEY (ins_id, course_code),
    CONSTRAINT "Course_code" FOREIGN KEY (course_code)
        REFERENCES public.course (course_code) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Ins_id" FOREIGN KEY (ins_id)
        REFERENCES public.instructor (instructor_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.give_course
    OWNER to postgres;

-- Trigger: max_give_course

-- DROP TRIGGER IF EXISTS max_give_course ON public.give_course;

CREATE TRIGGER max_give_course
    BEFORE INSERT
    ON public.give_course
    FOR EACH ROW
    EXECUTE FUNCTION public.check_numberof_course();

-- Trigger: same_id_control_ins

-- DROP TRIGGER IF EXISTS same_id_control_ins ON public.give_course;

CREATE TRIGGER same_id_control_ins
    BEFORE INSERT
    ON public.give_course
    FOR EACH ROW
    EXECUTE FUNCTION public.same_id_dept_and_insdept();