-- Table: public.events

-- DROP TABLE IF EXISTS public.events;

CREATE TABLE IF NOT EXISTS public.events
(
    event_id character(20) COLLATE pg_catalog."default" NOT NULL,
    event_name character(64) COLLATE pg_catalog."default" NOT NULL,
    event_time date,
    creator_id character(20) COLLATE pg_catalog."default" NOT NULL,
    maximum_participant integer NOT NULL,
    CONSTRAINT "EVENT_pkey" PRIMARY KEY (event_id),
    CONSTRAINT "Creator_id" FOREIGN KEY (creator_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    CONSTRAINT events_event_time_check CHECK (event_time > CURRENT_DATE) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.events
    OWNER to postgres;

-- Trigger: creato_join

-- DROP TRIGGER IF EXISTS creato_join ON public.events;

CREATE TRIGGER creato_join
    AFTER INSERT
    ON public.events
    FOR EACH ROW
    EXECUTE FUNCTION public.creator_join_event();