-- Table: public.message

-- DROP TABLE IF EXISTS public.message;

CREATE TABLE IF NOT EXISTS public.message
(
    sender character(20) COLLATE pg_catalog."default" NOT NULL,
    receiver character(20) COLLATE pg_catalog."default" NOT NULL,
    text character(128) COLLATE pg_catalog."default" NOT NULL,
    message_time date NOT NULL,
    CONSTRAINT "MESSAGE_pkey" PRIMARY KEY (sender, receiver),
    CONSTRAINT "Receiver" FOREIGN KEY (receiver)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Sender" FOREIGN KEY (sender)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.message
    OWNER to postgres;
-- Index: fki_Receiver

-- DROP INDEX IF EXISTS public."fki_Receiver";

CREATE INDEX IF NOT EXISTS "fki_Receiver"
    ON public.message USING btree
    (receiver COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_Sender

-- DROP INDEX IF EXISTS public."fki_Sender";

CREATE INDEX IF NOT EXISTS "fki_Sender"
    ON public.message USING btree
    (sender COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- Trigger: message_control

-- DROP TRIGGER IF EXISTS message_control ON public.message;

CREATE TRIGGER message_control
    BEFORE INSERT
    ON public.message
    FOR EACH ROW
    EXECUTE FUNCTION public.message_to_connect();