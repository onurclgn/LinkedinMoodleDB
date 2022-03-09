-- Table: public.connects

-- DROP TABLE IF EXISTS public.connects;

CREATE TABLE IF NOT EXISTS public.connects
(
    connector_id character(20) COLLATE pg_catalog."default" NOT NULL,
    connect_by_id character(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "CONNECT_pkey" PRIMARY KEY (connector_id, connect_by_id),
    CONSTRAINT "Connect_by" FOREIGN KEY (connect_by_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Connector" FOREIGN KEY (connector_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT connects_check CHECK (connector_id <> connect_by_id) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.connects
    OWNER to postgres;
-- Index: fki_Connect_by

-- DROP INDEX IF EXISTS public."fki_Connect_by";

CREATE INDEX IF NOT EXISTS "fki_Connect_by"
    ON public.connects USING btree
    (connect_by_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_Connector

-- DROP INDEX IF EXISTS public."fki_Connector";

CREATE INDEX IF NOT EXISTS "fki_Connector"
    ON public.connects USING btree
    (connector_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- Trigger: connect_to

-- DROP TRIGGER IF EXISTS connect_to ON public.connects;

CREATE TRIGGER connect_to
    AFTER INSERT
    ON public.connects
    FOR EACH ROW
    EXECUTE FUNCTION public.connect_each_other();

-- Trigger: unconnect_to

-- DROP TRIGGER IF EXISTS unconnect_to ON public.connects;

CREATE TRIGGER unconnect_to
    AFTER DELETE
    ON public.connects
    FOR EACH ROW
    EXECUTE FUNCTION public.unconnect_each_other();