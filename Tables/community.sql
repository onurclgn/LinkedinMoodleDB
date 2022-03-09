-- Table: public.community

-- DROP TABLE IF EXISTS public.community;

CREATE TABLE IF NOT EXISTS public.community
(
    community_id character(20) COLLATE pg_catalog."default" NOT NULL,
    community_name character(64) COLLATE pg_catalog."default" NOT NULL,
    creator_id character(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "GROUP_pkey" PRIMARY KEY (community_id),
    CONSTRAINT "Creator_id" FOREIGN KEY (creator_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.community
    OWNER to postgres;
-- Index: fki_Creator_id

-- DROP INDEX IF EXISTS public."fki_Creator_id";

CREATE INDEX IF NOT EXISTS "fki_Creator_id"
    ON public.community USING btree
    (creator_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;