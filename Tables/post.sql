-- Table: public.post

-- DROP TABLE IF EXISTS public.post;

CREATE TABLE IF NOT EXISTS public.post
(
    post_id character(20) COLLATE pg_catalog."default" NOT NULL,
    content character(128) COLLATE pg_catalog."default" NOT NULL,
    post_time date,
    shared_id character(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "POST_pkey" PRIMARY KEY (post_id),
    CONSTRAINT "Shared_id" FOREIGN KEY (shared_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT post_post_time_check CHECK (post_time < CURRENT_DATE) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.post
    OWNER to postgres;
-- Index: fki_Shared_id

-- DROP INDEX IF EXISTS public."fki_Shared_id";

CREATE INDEX IF NOT EXISTS "fki_Shared_id"
    ON public.post USING btree
    (shared_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;