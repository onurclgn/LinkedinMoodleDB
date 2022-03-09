-- Table: public.enroll_event

-- DROP TABLE IF EXISTS public.enroll_event;

CREATE TABLE IF NOT EXISTS public.enroll_event
(
    user_id character(20) COLLATE pg_catalog."default" NOT NULL,
    event_id character(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "ENROLL_EVENT_pkey" PRIMARY KEY (user_id, event_id),
    CONSTRAINT "Event_id" FOREIGN KEY (event_id)
        REFERENCES public.events (event_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "User_id" FOREIGN KEY (user_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.enroll_event
    OWNER to postgres;
-- Index: fki_Event_id

-- DROP INDEX IF EXISTS public."fki_Event_id";

CREATE INDEX IF NOT EXISTS "fki_Event_id"
    ON public.enroll_event USING btree
    (event_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- Trigger: join_event

-- DROP TRIGGER IF EXISTS join_event ON public.enroll_event;

CREATE TRIGGER join_event
    BEFORE INSERT
    ON public.enroll_event
    FOR EACH ROW
    EXECUTE FUNCTION public.check_participant();