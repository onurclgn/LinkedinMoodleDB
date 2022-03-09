-- Table: public.follow

-- DROP TABLE IF EXISTS public.follow;

CREATE TABLE IF NOT EXISTS public.follow
(
    follower character(20) COLLATE pg_catalog."default" NOT NULL,
    follower_by character(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT follow_pkey PRIMARY KEY (follower, follower_by),
    CONSTRAINT "Follower" FOREIGN KEY (follower)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Follower_by" FOREIGN KEY (follower_by)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT follow_check CHECK (follower <> follower_by) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.follow
    OWNER to postgres;
-- Index: fki_Follower

-- DROP INDEX IF EXISTS public."fki_Follower";

CREATE INDEX IF NOT EXISTS "fki_Follower"
    ON public.follow USING btree
    (follower COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_Follower_by

-- DROP INDEX IF EXISTS public."fki_Follower_by";

CREATE INDEX IF NOT EXISTS "fki_Follower_by"
    ON public.follow USING btree
    (follower_by COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;